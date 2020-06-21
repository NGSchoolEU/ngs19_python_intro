# Introduction to Python

The repository with materials for the Introduction to Python course for NGSchool2019 and RNA Club meeting on May the 6th and later at the #NGSchool2019: Machine Learning for Biomedicine. It has been used few times since then and has been continuously improved. 

The whole tutorial was design to be able to be run interactively in a classroom, or on its own. So if you missed the online session - try running it on your own. Soon, there will also be a video of a live session which hopefully help you out.

## Aim

The aim of the workshops is to walk you through basics, show what the advantages of Python and what can be done with it. It also lists places where to look for materials to learn more.

## About the tutor

My name is [Kasia](https://kasia.codes/) and I'm a DPhil student in Genomic Medicine and Statistics at the Wellcome Centre for Human Genetics, University of Oxford. I'm also the President of [NGSchool Society](https://ngschool.eu/) where with an amazing group of [people](https://ngschool.eu/people/) we try to build international community for computational biologists with training, platforms to network and exchange knowledge. Be sure to check out more on our social media ([twitter](https://twitter.com/NGSchoolEU) and [fb](https://www.facebook.com/NGSchool.eu/)) and [join us on discord](https://discord.gg/MhNeqwR).

## Running on Google Colab

You can run the whole notebook on [Google Colab](https://colab.research.google.com/). You can follow [this link](https://colab.research.google.com/github/NGSchoolEU/ngs19_python_intro/blob/master/Intro%20to%20Python.ipynb) directly or open a notebook from this repository. The beauty of this solution is that everything works and all you need is access to the internet to work on the exercises. However, the downside of this solution is that you have to have a google account. In case you are not comfortable with this, or you want to run the notebook offline see the instructions in the next section.

## Running on your machine

You can run the notebook on your machine. All you need is to make sure the following requirements are satisfied.

### Requirements

* Python3 (>= 3.5)
* numpy
* pandas
* scipy
* matplotlib
* Jupyter lab

I prepared a script that can test whether the requirements are satisfied, and gives advice how to proceed in case some are missing. However, it only works on `bash`. 

```bash
bash setup_check.sh
```

In case you need more advice don't hesitate to contact me. Hope you enjoy! 
Kasia
