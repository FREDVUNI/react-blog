import React from 'react'
import {categoryColors} from './styles'

export default function MansonryPost ({post,tagsOnTop}){
    const windowWidth = window.innerWidth;
    const imageBackground = {
        backgroundImage: `url("${require(`../../assets/images/${post.image}`)}")`,
    };

    const style = windowWidth > 900 ? { ...imageBackground, ...post.style } : imageBackground;

    return(
        <a className="masonry-post overlay" style={style} href={post.link}>
            <div className="image-text" >
                <div className="tags-container">
                    {post.categories.map((tag,index) =>
                        <span key={index} className="tag" style={{backgroundColor:categoryColors[tag]}}>
                            {tag.toUpperCase()}
                        </span>
                    )}
                </div>
                <h2 className="image-title">{post.title}</h2>
                <span className="image-date">{post.date}</span>
            </div>
        </a>
    )
}