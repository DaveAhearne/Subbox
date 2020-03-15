class PostService {
    constructor(baseUrl){
        this._baseUrl = baseUrl
    }

    async SavePost(postData){
        const url = `${this._baseUrl}/api/submission`
        return await fetch(url, {
            method: "POST",
            mode: 'no-cors', // Should enable this, but it'l only work when we have a stable url
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(postData)
        })
    }
}

module.exports = PostService