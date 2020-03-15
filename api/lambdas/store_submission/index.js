const { v4 } = require("uuid")
const PostRepository = require("./postRepository")

exports.handler = async function (event) {
    console.log(`Starting submission storage`)

    const postRepository = new PostRepository(process.env.table_name);

    let post = {
        PostId : v4(),
        Category: "Suggestion",
        Content : event.body
    }

    console.log(`Attempting storage of object: ${JSON.stringify(post)}`)

    try {
        await postRepository.Save(post)

        console.log(`Completed storage of object: ${post.PostId}`)

        return {
            statusCode: 201
        }
    } catch (error) {
        return {
            statusCode: 500,
            body: `Failed to save post: ${JSON.stringify(error)}`
        }
    }
}