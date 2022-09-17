import React,{useState} from 'react'
import {Link} from 'react-router-dom'
import {Avatar} from 'antd'

//useState allows you to create and set a variable.
const navLinks = [
    {
        title:"Home",
        path:"/"
    },
    {
        title:"Blog",
        path:"/blog"
    },
    {
        title:"Contact",
        path:"/contact"
    },
    {
        title:"Login",
        path:"/login"
    }
]

const Navigation = ({user}) => {
    const [menuActive,setMenuActive] = useState(false)
    return (
        <nav className="site-navigation">
            <span className="menu-title"><Link to="/">mini react blog ...</Link></span>
            <div className={`menu-content-container ${menuActive && 'active'}`}>
                <ul>
                    {navLinks.map((link,index)=>{
                        return(
                            <li key={index}>
                                <Link to={link.path}>{link.title}</Link>
                            </li>
                        )
                    })}
                </ul>
                <span className="menu-avatar-container">
                    <Avatar src='https://joeschmoe.io/api/v1/random' size={38}/>
                    <span className='menu-avatar-name'>{`${user.firstName} ${user.lastName}`}</span>
                </span>
            </div>
            <i className="ionicons icon ion-ios-menu" onClick={ () => setMenuActive(!menuActive)}/>
        </nav>
    )
}

export default Navigation
