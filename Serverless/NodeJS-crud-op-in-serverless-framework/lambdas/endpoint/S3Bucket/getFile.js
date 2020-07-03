const Responses = require('../../common/API_Responses')
const S3 = require('../../common/S3')

const bucketName = process.env.bucketName

exports.handler_api = async event => {
     
    console.log('event',event);
    
    if(!event.pathParameters || !event.pathParameters.fileName)
        return Responses._400({message: 'Missing the file from the path'})
    
    let fileName = event.pathParameters.fileName;    

    const data = await S3.get(fileName, bucketName).catch(err => {
        console.log("Error in S3 write.",err)
        return null
    })

    if(!data){
       return Responses._400({message: 'Failed to get file name from Bucket '+ data+' ' + bucketName+' ' +fileName})
    }
    
    return Responses._200({data})
 
}