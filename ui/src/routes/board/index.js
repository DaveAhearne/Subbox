import React from "react"
import PostView from "../../components/PostView";
import SubmitPost from "../../components/SubmitPost";

import "./board.css"

class Board extends React.Component {

    state = {
        submissions: []
    }

    _handleSubmission(content){
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