import React from 'react';
import PostContent from "../PostContent"
import './PostView.css';

function PostView(props) {
  const {submissions} = props

  return (
    <div className="PostView">
      {
        submissions.map(c => {
          return <PostContent content={c}/>
        })
      }
    </div>
  );
}

export default PostView;