const Responses = require('../../common/API_Responses')
const S3 = require('../../common/S3')

const bucketName = process.env.bucketName

exports.handler_api = async event => {
     
    console.log('event',event);
    
    if(!event.pathParameters || !event.pathParameters.fileName)
        return Responses._400({message: 'Missing the file from the path'})
    
    let fileName = event.pathParameters.fileName;    
    const data = JSON.parse(event.body)
          
    

    const newData = await S3.write(data, fileName, bucketName).catch(err => {
        console.log("Error in S3 write.",err)
        return null
    })

    if(!newData){
       return Responses._400({message: 'Failed to get file name '})
    }
    
    return Responses._200({newData})
 
}