import React from 'react'
import {MansonryPost} from './'

export default function PostMansonry({posts,columns,tagsOnTop}){
    return(
        <section className="masonry" style={{gridTemplateColumns:`repeat(${columns},minmax(275px,1fr))`}}>
            { posts.map((post,index) =>
                <MansonryPost {...{post,index,tagsOnTop,key:index}}/>
            )}
        </section>
    )
}