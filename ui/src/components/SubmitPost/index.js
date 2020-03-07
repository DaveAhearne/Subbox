import React from "react"
import Rating from "../../enums/rating"
import "./SubmitPost.css"

import "./ipsum"

class SubmitPost extends React.Component{

    constructor(){
        super();

        // var ipsum = new window.LoremIpsum();
        // setInterval(() => {
        //     let content = ipsum.sentence(2, 50);
        //     this.setState({content: content})
        //     this.props.handleSubmission(this.state.content, this.state.rating)
        // }, 3000);
    }

    state = {
        content: "",
        rating: 0
    }

    _handleInput(event){
        this.setState({content: event.target.value})
    }

    _handleSubmit(event){
        if(event.charCode === 13){
            this.props.handleSubmission(this.state.content, this.state.rating)
            this.setState({content: ""})
        }
    }

    render(){
        return (
            <div className="SubmitPost">
                <input className="SubmitInput"
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