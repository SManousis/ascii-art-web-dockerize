# Ascii Art Web Project

This is the Ascii Art Web project written in go. It's a web server for outputting the text in a graphic representation of ASCII.
Additionally, we have formatted the page to be visually pleasing, and added options for colour, alignment and banners.

This program has been implemented with a docker function, which allows it to run in an isolated container in different operating systems.

# Objectives

Ascii art web consists of creating and running a server, in which it will be possible to use a web GUI (graphical user interface) version of a program that outputs text in a graphical representation of ASCII in several different options.

# Authors

Stamatis Manousis
Augoustinos Andris

# Usage

To run the program from the terminal:

    go run .

    You will receive a confirmation of the address and port where the program is initialized.

If you want to run the docker function:

    bash run.sh

    To close the docker function once you're done (so it doesn't consume resources):

    bash close.sh

# Implementation details

1. HTTP Server Setup

    Routing:
        The HTTP server was set up using Go's net/http package.
        Endpoints of implementation:
            GET /: Serves the main page with the form.
            POST /ascii-art: Handles form submissions and processes the input.

    Handler Functions:
        Handler functions.
            renderTemplate:
                Renders the index.html template.
            homeHandler:
                Parses form data.
                Validates user input.
                Calls functions to generate ASCII art.
                Renders the result template with the generated art.

2. Template Rendering

    Templates Used:
        The HTML templates used are index.html that is the main template to enter the text and the result.html that returns the Ascii Art result.
    Data Passing:
        Data is passed to templates using Go's html/template package.
        The PageData struct carries data (input text, banner selection, ASCII art result, error messages).

3. Input Processing

    Form Data Parsing:
        Data is parsed from the POST request using r.ParseForm() and retrieve values with r.FormValue().

    Input Validation:
        Checks performed to validate the user's input.
            Ensuring text input is not empty.
            Validating that the banner selection is one of the allowed options.
            Handling invalid or unsupported characters.

4. ASCII Art Generation Algorithm

    Reading Banner Files:
        Banner files (standard.txt, shadow.txt, thinkertoy.txt) are read from the filesystem and handled using filepath.Join().
    
    Processing the Banner Data:
        Banner file is split into lines for processing.
        Then they are normalized to handle different line endings.

    Converting Text to ASCII Art:
        ConvertToAsciiArt function.
            Character Mapping:
                To calculate the index in the banner file for each character.
                    We are subtracting 32 from the ASCII code to align with the banner file's character order.
                    Multiplying by the number of lines per character (usually 9).
            Building the ASCII Art:
                Then we iterate over each line of the characters to build the final ASCII art string.
                The strings.Builder is used for efficient string concatenation.
            Handling Newlines:
                Multi-line input is handled by splitting on \n and maintaining proper formatting.

5. Error Handling

    User-Friendly Errors:
        Eroors that are handled and displayed to the user.
            Invalid input.
            Missing or incorrect banner selection.
            Unsupported characters.

    HTTP Status Codes:
        Appropriate HTTP status codes are set based on different error conditions.
            200 OK for successful requests.
            400 Bad Request for invalid input.
            404 Not Found for incorrect address.
            500 Internal Server Error for unexpected issues.
6. Concurrency and Performance

    Handling Concurrent Requests:
            Go's net/http package handles concurrency internally using goroutines.