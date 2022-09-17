import {createContext,useReducer} from 'react'
import movieReducer from './movieReducer'

const initialState = {
    watched:localStorage.getItem("watched") ?
            localStorage.getItem("watched"): []
}

export const movieContext = createContext(initialState)
export const movieProvider = ({children}) =>{
    const watched = useReducer(initialState,movieReducer)

    return(
        <movieContext.Provider value ={{watched:state.watched}}>
            {children}
        </movieContext.Provider>
    )
}

const [cred,setCred] = useState({
    username:"",
})
// ekastimo@gmail.com
//C:\Users\TAATA EARL\AppData\Local\Programs\Microsoft VS Code\bin
{/* <input type="text" onChange = {(e)=>setCred({...cred,username:e.target.value})} value={cred.username}/> */}
//my teacher,my obsession


const joi = require("joi")

const schema = joi.object({
    username:joi.string().min(3).required(),
})

const {error} = schema.validate(req.body)

if(error) res.status(400).send(error.details[0].message)

// sign up
const joi = require("joi")
const bcrypt = require("bcrypt")
const jwt = require("jwt")
const user = require("./models/user")

exports.signUp = async(req,res) =>{
    const schema = joi.object({
        username:joi.string().min(3).max(10).required(),
        email:joi.string().email().min(10).required(),
        password:joi.string().min(8).max(25).required(),
    })

    const {error} = schema.validate(req.body)
    if(error) return res.status(400).send(error.details[0].message)

    try{
        const emailExists = user.findOne({email:req.body.email})
        if(!emailExists) return res.status(400).send('Email already exists.')

        const salt = await bcrypt.genSalt(10)
        const saltedPassword = await bcrypt.hash(req.body.password,salt)

        const new_user = await new user({
            username:req.body.username,
            email:req.body.email,
            password:saltedPassword
        })

        await new_user.save()
        const token = await jwt.sign({
            id:new_user.id,
            username:new_user.username,
            email:new_user.email
        },process.env.SECRET_KEY)

        res.status(200).json(token)

    }
    catch(error){
        return res.status(500).send(error.message)
    }
}

exports.signIn = async(req,res) =>{
    try{
        const schema = joi.object({
            username:joi.string().required().min(3).max(100),
            email:joi.string().email().required().min(3).max(100),
            password:joi.string().required().min(3).max(100), 
        })

        const {error} = await schema.validate(req.body)

        if(error) res.status(400).send(error.details[0].message)

        const user = await user.findOne({email:req.body.email})

        if(!user) res.status(400).send("Invalid email and password combination.")

        const passwordCheck = await bcrypt.compare(user.password,req.body.password)

        if(!passwordCheck) res.status(400).send("Invalid email and password combination.")

        const token = jwt.sign({
            id: user.id,
            username: user.username,
            email: user.email,
        },process.env.SECRET_KEY)

        res.status(200).send(token)
    }
    catch(error){
        return res.status(500).send(error.message)
    }
}

const {PrismaClient} = require("@prisma/client")
const prisma = new PrismaClient();

exports.getAuthors = async(req,res) =>{
    try{
        const authors = await prisma.author.findMany({
            include:{quotes:true}
        })
        return res.status(200).json(authors)
    }
    catch(error){
        res.status(500).send(error.message || "There was a server error.")
    }
}

exports.createAuthor = async(req,res) =>{
    try{
        const {name} = req.body
        const filter = await prisma.author.findUnique({
            where:{name:req.body.name}
        })
        if(filter) return res.status(400).send("Author already exists.")
        const author = await prisma.create({
            data:{name}
        })
        return res.status(200).json({message:"author has been added.",author})
    }
    catch(error){
        res.status(500).send(error.message || "There was a server error.")
    }
}

exports.getAuthor = async(req,res) =>{
    try{
        const id = req.params.id
        const author = await prisma.author.findUnique({
            where:{
                id:Number(id)
            }
        })
        if(!author) return res.status(400).send("Author was not found")
        res.status(200).json(author)
    }
    catch(error){
        res.status(500).send(error.message || "There was a server error.")
    }
}

exports.updateAuthor = async(req,res) =>{
    try{
        const id = req.params.id
        const author = await prisma.author.findUnique({
            data:req.body,
            where:{
                id:Number(id)
            }
        })
        if(!author) return res.status(400).send("Author was not found")
        res.status(200).json(author)
    }
    catch(error){
        res.status(500).send(error.message || "There was a server error.")
    }
}

exports.deleteAuthor = async(req,res) =>{
    try{
        const id = req.params.id
        const author = await prisma.author.delete({
            where:{
                id:Number(id)
            }
        })
        if(!author) return res.status(400).send("Author was not found")
        res.status(200).json(author)
    }
    catch(error){
        res.status(500).send(error.message || "There was a server error.")
    }
    
}

const jwt = require("jsonwebtoken")
const bcrypt = require("bcrypt")
const joi = require("joi")

exports.signUp = async(req,res) =>{
    try{
        const schema = joi.object({
            username:joi.string().required().min(3).max(8),
            email:joi.email().required().min(8).max(30),
            password:joi.string().required().min(8).max(28),
        })

        const {error} = schema.validate(req.body)
        if(error) return res.status(400).send(error.details[0].message)

        const emailExists = await prisma.user.findUnique({
            where:{email:req.body.email}
        }) 
        if(emailExists) return res.status(400).send("user already exists.")

        const salt = await bcrypt.genSalt(10)
        const hashed = await bcrypt.hash(req.body.password,salt)

        const user = await prisma.user.create({
           data:{
                username:req.body.username, 
                email:req.body.email, 
                password:hashed,
           } 
        })
        const token = jwt.sign(user,process.env.SECRET_KEY)

        res.status(200).json(token)
    }
    catch(error){
        res.status(500).send(error.message || "There was a server error.")
    }
}

exports.signIn = async(req,res) =>{
    try{
        const schema = joi.object({
            email:joi.email().required().min(8).max(30),
            password:joi.string().required().min(8).max(28),
        })

        const {error} = schema.validate(req.body)
        if(error) return res.status(400).send(error.details[0].message)

        const user = await prisma.user.findUnique({
            where:{email:req.body.email}
        }) 
        if(!user) return res.status(400).send("wrong email password combination.")

        const passwordCheck = await bcrypt.compare(req.body.password,user.password)

        if(!passwordCheck) return res.status(400).send("wrong email password combination.")

        const token = jwt.sign({
            id:user.id,
            username:user.username,
            email:user.email,
        },process.env.SECRET_KEY)

        res.status(200).json(token)
    }
    catch(error){
        res.status(500).send(error.message || "There was a server error.")
    }
}

const mongoose = require("mongoose")

const connectDB = async() =>{
    try{
        const con = await mongoose.connect(process.env.MONGO_URI,{
            useUnifiedTopology:true,
            useCreateIndex:true,
            useNewUrlParser:true,
            useFindAndModify:false
        })
        console.log(`Database connected.`)
    }
    catch(error){
        console.log(error.message || `There was a server error.`)
        process.exit(1)
    }
}

module.exports = connectDB