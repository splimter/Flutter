class Person {
	Person(this.gqlid, this.id, this.name, this.lastName, this.age);

	final String gqlid;
	final String id;
	final String name;
	final String lastName;
	final String age;

	getGQLId() => this.gqlid;

	getId() => this.id;

	getName() => this.name;

	getLastName() => this.lastName;

	getAge() => this.age;
}