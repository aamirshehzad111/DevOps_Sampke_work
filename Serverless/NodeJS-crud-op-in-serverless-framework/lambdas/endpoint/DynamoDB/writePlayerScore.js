const Responses = require('../../common/API_Responses')
const Dynamo = require('../../common/Dynamo')

const tableName = process.env.tableName

exports.handler_api = async event => {
     
    console.log('event',event);
    
    if(!event.pathParameters || !event.pathParameters.ID)
        return Responses._400({message: 'Missing the ID from the path'})
    
    let ID = event.pathParameters.ID;    
    const user = JSON.parse(event.body)
    user.ID =  Number(ID)      
    

    const newUser = await Dynamo.post(user, tableName).catch(err => {
        console.log("Error in Dynamo Post",err)
        return null
    })

    if(!newUser){
       return Responses._400({message: 'Failed to get user by ID '+'user: '+newUser})
    }
    
    return Responses._200({newUser})
 
}