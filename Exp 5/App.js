import React, { useState } from "react";

const App = () => {
  const [task, setTask] = useState("");
  const [todos, setTodos] = useState([]);

  // Add a new task
  const addTask = () => {
    if (task.trim() === "") return;
    setTodos([...todos, { text: task, completed: false }]);
    setTask("");
  };

  // Delete a task
  const deleteTask = (index) => {
    setTodos(todos.filter((_, i) => i !== index));
  };

  // Toggle task completed
  const toggleComplete = (index) => {
    const newTodos = [...todos];
    newTodos[index].completed = !newTodos[index].completed;
    setTodos(newTodos);
  };

  // Inline styles
  const styles = {
    app: { textAlign: "center", marginTop: "50px", fontFamily: "Arial, sans-serif" },
    inputContainer: { marginBottom: "20px" },
    input: { padding: "8px", fontSize: "16px", width: "250px", marginRight: "10px" },
    button: { padding: "8px 12px", fontSize: "16px", cursor: "pointer" },
    list: { listStyle: "none", padding: 0 },
    listItem: {
      padding: "8px",
      fontSize: "18px",
      display: "flex",
      justifyContent: "space-between",
      width: "300px",
      margin: "0 auto 10px",
      borderBottom: "1px solid #ccc",
      cursor: "pointer"
    },
    completed: { textDecoration: "line-through", color: "gray" },
    deleteButton: { backgroundColor: "red", color: "white", border: "none", padding: "4px 8px", cursor: "pointer" }
  };

  return (
    <div style={styles.app}>
      <h1>To-Do List</h1>
      <div style={styles.inputContainer}>
        <input
          style={styles.input}
          type="text"
          value={task}
          onChange={(e) => setTask(e.target.value)}
          placeholder="Enter a task"
        />
        <button style={styles.button} onClick={addTask}>Add</button>
      </div>
      <ul style={styles.list}>
        {todos.map((todo, index) => (
          <li
            key={index}
            style={{ ...styles.listItem, ...(todo.completed ? styles.completed : {}) }}
          >
            <span onClick={() => toggleComplete(index)}>{todo.text}</span>
            <button
              style={styles.deleteButton}
              onClick={() => deleteTask(index)}
            >
              Delete
            </button>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default App;
