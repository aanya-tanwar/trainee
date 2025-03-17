# Trainee Backend

This is the **Backend** of the **Trainee Project**. It is built using **Node.js** and **Express.js** to set up a simple server that responds to requests. It includes necessary files such as `app.js`, `node_modules`, `package.json`, `package-lock.json`, and a `public` folder for static assets.

---

## Steps to Set Up the Backend

### 1. Create the Project Folder

1. **Create a new folder** for the backend project. Name it `trainee_backend`.

    - On **Windows**, right-click and select **New Folder**.
    - On **macOS/Linux**, open a terminal and run:
      ```bash
      mkdir trainee_backend
      cd trainee_backend
      ```

### 2. Initialize the Node.js Project

1. Inside the `trainee_backend` folder, run the following command to initialize the Node.js project:
    ```bash
    npm init -y
    ```

2. This will create a **`package.json`** file in your `trainee_backend` folder with default values.

### 3. Install Express.js

1. To create a basic server, install **Express.js**, a web framework for Node.js.

    - Run the following command to install Express:
      ```bash
      npm install express
      ```

2. This will install **Express** and add it as a dependency in the `package.json` file.

### 4. Create the `app.js` File

1. Inside the `trainee_backend` folder, create a new file named **`app.js`**. This will be the main entry point of the application.
   
2. Inside `app.js`, set up a basic Express server to listen for requests and handle routes. For example, a route that responds with a "Welcome" message.

### 5. Create the `public` Folder

1. Inside the `trainee_backend` folder, create a **`public`** folder to serve static files (such as images, styles, etc.) in the future.
   
    - You can add files like `index.html`, CSS files, or JavaScript files into this folder for serving static content.

    - Example structure:
      ```bash
      mkdir public
      ```

### 6. Create the `.gitignore` File

1. Inside the `trainee_backend` folder, create a `.gitignore` file to ignore unnecessary files like `node_modules`, which don't need to be tracked by Git.
   
2. In the `.gitignore` file, add:
    ```
    node_modules/
    ```

## How to Run

1. Navigate to the `trainee_backend` directory.
2. Install dependencies by running:

    ```bash
    cd trainee_backend
    npm install
    ```

3. Start the server:

    ```bash
    node app.js
    ```

4. Open a web browser and visit `http://localhost:3000`.

    You will see the **"Welcome to Trainee Backend!"** message.

## How to Test

To test the backend:
1. Ensure that the server is running (use the command `node app.js`).
2. Open your browser and go to `http://localhost:3000`.
3. You should see a message displayed: **"Welcome to Trainee Backend!"**

## Technologies Used

- **Node.js**: Runtime for running the backend server.
- **Express**: Web framework for building the backend server.

