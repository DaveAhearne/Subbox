const AWS = require("aws-sdk")
AWS.config.update({ region: process.env.region });

class PostRepository {
    constructor(tableName) {
        this._database = new AWS.DynamoDB.DocumentClient();
        this._tableName = tableName
    }

    async Save(post) {
        var params = {
            TableName: this._tableName,
            Item: post
        }

        return new Promise((resolve, reject) => {
            this._database.put(params, function (err, data) {
                if(err){
                    reject(`Unable to add item. Error JSON: ${JSON.stringify(err, null, 2)}`)
                }

                resolve(data)
            })
        })
    }
}

module.exports = PostRepository