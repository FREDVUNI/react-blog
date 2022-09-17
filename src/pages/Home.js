import React from 'react'
import {PostMansonry,MansonryPost} from '../components/common'
import trending from '../assets/mocks/trending'
import featured from '../assets/mocks/featured'

const trendingConfig ={
    1:{
        gridArea:'1 / 2 / 3 / 3'
    }
}

const mergeStyles = function(posts,config){
    posts.forEach((post,index)=>{
        post.style = config[index]
    })
}

const featuredConfig = {
    0:{
        gridArea: '1 / 1 / 2 / 3',
        height:'300px',
    },
    1:{
        height:'300px'
    },
    3:{
        height:'630px',
        marginLeft:'30px',
        width: '630px'
    }
}

mergeStyles(trending,trendingConfig)
mergeStyles(featured,featuredConfig)

const lastFeatured = featured.pop()

const Home = () =>{
    return(
        <section className="container home">
            <div className="row">
                <h1>Featured Posts</h1>
                <section className="featured-posts-container">
                    <PostMansonry posts={featured} columns={2} tagsOnTop={true}/>
                    <MansonryPost post={lastFeatured} tagsOnTop={true}/>
                </section>
                <h1>Trending Posts</h1>
                <PostMansonry posts={trending} columns={3} tagsOnTop={true}/>
            </div>
        </section>
    )
}

export default Home