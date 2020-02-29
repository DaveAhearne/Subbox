import React from "react"
import PostView from "../../components/PostView";
import SubmitPost from "../../components/SubmitPost";

import "./board.css"

function Board() {
    return <div className="boardContainer">
        <PostView />
        <SubmitPost />
    </div>
}

export default Board