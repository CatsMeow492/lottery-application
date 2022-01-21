const John = {
    first : "John",
    last : "Johnson",
    type : "human",
    greet : function {
        console.log('Hi my name is ' + this.first + this.last);
    }
}

function human(first, last, age, weight) {
    this.first = first,
    this.last = last,
    this.age = age,
    this.weight = weight
}

const John = new human("John", "Johnson", 99, 165);