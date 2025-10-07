let data = [];

// CREATE
data.push(100);
console.log("Inserted 100");
data.push(200);
console.log("Inserted 200");
data.push(300);
console.log("Inserted 300");

// READ
console.log("Array:", data);

// UPDATE
let indexToUpdate = data.indexOf(200);
if (indexToUpdate !== -1) {
    data[indexToUpdate] = 250;
    console.log("Updated 200 to 250");
}

// READ
console.log("Array:", data);

// DELETE
let indexToDelete = data.indexOf(100);
if (indexToDelete !== -1) {
    data.splice(indexToDelete, 1);
    console.log("Deleted 100");
}

// READ
console.log("Array:", data);
