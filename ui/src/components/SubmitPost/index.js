import React from "react"
import "./SubmitPost.css"

class SubmitPost extends React.Component{
    state = {
        content: ""
    }

    _handleInput(event){
        this.setState({content: event.target.value})
    }

    _handleSubmit(event){
        if(event.charCode === 13){
            this.props.handleSubmission(this.state.content)
            this.setState({content: ""})
        }
    }

    render(){
        return (
            <div className="SubmitPost">
                <input 
                    onChange={(e => this._handleInput(e))} 
                    onKeyPress={(e) => this._handleSubmit(e)}
                    value={this.state.content}
                    type="text">
                </input>
            </div>
        )
    }
}

SubmitPost.defaultProps = {
    handleSubmission: (content) => {}
}

export default SubmitPost