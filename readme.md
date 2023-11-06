# Homework Template

This template repository has the structure I expect to see in all homework assignments.  It is a good idea to fork this repository and use it as a template for your homework assignments.  This will ensure that you have the correct structure and that you have all the files you need to submit your homework.

- root:
  - **instructions_hwx.qmd** and **instructions_hwx.pdf** : The instructions for the homework assignment
  - **data\\** : A folder containing the data used for assignemnt. Required only if data is not available using `frause`, or access with other repository.
  - **do_files\\** : A folder containing the source code for the assignment. 
    This folder should contain a file called `homework.do` that can be run to execute the assignment. It should also contain a file called `homework.log` that contains the output from running `homework.do`.
    Both files will be mostly used for exploration and preparation of the data, and will not be graded.
  - **homework_x.qmd** : A file containing the answers to the questions in the assignment. 
    This file should be a quarto markdown file that can be compiled to a pdf file using `quarto`. 
    This file should also be self contained, meaning that it should not require any files from the `do_files` folder to compile, and yet produce homework output.
    This file will be graded.
  - **resources\\**: Figures and tables can be added here, and then referenced in the `homework_x.qmd` file. 
    This should be produced by the `homework_x.qmd` file, and the `homework.do` file.
  
This repository also contains an example homework assignment, in folder **example**. One of them relies on `nbstata`, and the other uses the `do-file` output to produce the homework.

You can compile the homework_x.qmd into a html or pdf file, but its not required.
