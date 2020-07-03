const Responses = require('../../common/API_Responses')
const Dynamo = require('../../common/Dynamo')

const tableName = process.env.tableName

exports.handler_api = async event => {
     
    console.log('event',event);
    
    if(!event.pathParameters || !event.pathParameters.ID)
        return Responses._400({message: 'Missing the ID from the path'})
    
    let ID = Number(event.pathParameters.ID);         
    

    const user = await Dynamo.deletee(ID, tableName).catch(err => {
        console.log("Error in Dynamo Delete",err)
        return null
    })

    if(!user){
       return Responses._400({message: 'Failed to get user by ID '+'user: '+user})
    }
    
    return Responses._200({user})
 
}