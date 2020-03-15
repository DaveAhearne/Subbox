import React from "react"
import PostView from "../../components/PostView";
import SubmitPost from "../../components/SubmitPost";

import Config from "../../config/environment"
import PostService from "../../services/postService"

import "./board.css"

class Board extends React.Component {

    constructor(){
        super()
        this._postService = new PostService(Config.base_url)
    }

    state = {
        submissions: []
    }

    async _handleSubmission(content){
        await this._postService.SavePost(content)
        this.setState((prev, _) => { return { submissions: prev.submissions.concat(content)} })
    }

    render() {
        return <div className="boardContainer">
            <PostView submissions={this.state.submissions}/>
            <SubmitPost handleSubmission={(content) => this._handleSubmission(content)}/>
        </div>
    }
}

export default Board