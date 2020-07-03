const AWS = require('aws-sdk')

const documentClient = new AWS.DynamoDB.DocumentClient();

const Dynamo = {
    async get(ID, TableName){

        const params = {
            TableName,
            Key: {
                ID
            }
        };

        const data = await documentClient
             .get(params)
             .promise()

        console.log(data)

        if(!data || !data.Item){
            throw Error(`There is error in fetching the data for ${ID} from the ${TableName}`)
        }

        console.log(data.Item)

        return data.Item
    },

    async post(data, TableName){
        if(!data.ID)
          throw Error('no id in data')

        const params = {
            TableName,
            Item: data
        };

        const res = await documentClient
             .put(params)
             .promise()


        if(!res)
          throw Error(`error while inserting data for ${data.ID} in table ${TableName}`)  

        return data  

    },

    async deletee(ID, TableName){

        const params = {
            TableName,
            Key: {
                ID
            }
        }

        const res = await documentClient
             .delete(params)
             .promise()

        if(!res)
            throw Error(`error while deleting data for ${ID} in table ${TableName}`)  
             
        return {"result" :"Data Deleted Succesfully"}
    },

    async updatee(data, TableName){
        let ID = data.ID;
        const params = {
            TableName,
            Key: {
                ID
            },
            UpdateExpression: "SET Company = :newComp",
            ExpressionAttributeValues: { 
                ":newComp": data.Company
            }
        }

        const res = await documentClient.update(params).promise()

        if(!res)
            throw Error(`error while updating data for ${ID} in table ${TableName}`)


        return data
    }
};

module.exports = Dynamo
