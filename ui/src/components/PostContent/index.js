import React from "react"
import "./PostContent.css"

function PostContent(props){
    const { content } = props

    return <div className="Post">
        {content}
    </div>
}

export default PostContent
