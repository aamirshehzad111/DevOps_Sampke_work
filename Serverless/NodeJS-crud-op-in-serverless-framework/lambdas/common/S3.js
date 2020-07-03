const AWS = require('aws-sdk')

let s3Client = new AWS.S3();

const S3 = {
    
    async get(fileName, bucketName){

        const params = {
            Bucket: bucketName,
            Key: fileName
        }

        let data = await s3Client.getObject(params).promise();

        if(!data)
            throw Error(`error while getting ${fileName} in bucket ${bucketName}`)

        if(fileName.slice(fileName.length-4, fileName.length) == "json")
            data = data.Body.toString()
          
        return data  
    },

    async write(data, fileName, bucketName){

        const params = {
            Body: JSON.stringify(data), 
            Bucket: bucketName, 
            Key: fileName
        };
    
        const newData = await s3Client.putObject(params).promise()

        if(!newData)
            throw Error(`error while putting ${fileName} in bucket ${bucketName}`)

        return newData
    
    }

    
};


module.exports = S3