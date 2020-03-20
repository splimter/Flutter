class QueryMutation {

	String addPerson(String id, String name, String lastName, String age) {
		return """
      mutation{
          createPerson(data: {id: "$id", name: "$name", lastName: "$lastName", age: "$age"}){
            id
            name
            lastName
            age
          }
      }
    """;
	}

	String getAll(){
		return """
      query {
        allPersons{
          data {
          _id
          id
          name
          lastName
          age
          }
        }
      }
    """;
	}

  String deletePerson(id) {
    return """
      mutation{
        deletePerson(id: "$id"){
          id
        }
      } 
    """;
  }

  String editPerson(String gqlId, String id, String name, String lastName, int age) {
    return """
      mutation{
          updatePerson(
          id: "$gqlId"
          data: {id: "$id", name: "$name", lastName: "$lastName", age: "$age"}
          ){
            name
            lastName
          }
      }    
     """;
  }
}
