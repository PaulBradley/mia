# MIA - Medical Imaging Acquisition Application

MIA is a serverless web application that allows NHS physicians to register patients and send them a secure URL via SMS so that the patient can upload photos and videos securely clinical review. The patient receives the secure URL and needs to authenticate themselves by confirming their date of birth. Once authenticated, the patient can select which images and videos they wish the physician to review. The patient can also enter a description of the behaviour or condition they want to be reviewed. The media is uploaded directly into a private S3 bucket using a short-lived signed URL, and the physician is notified to check the submitted media.

Once the physician has reviewed the uploaded media, they can publish it to a Health Information Exchange using an ITI-41  Provide and Register Set-b message.

## Architecture

The Terraform scripts deploy and provision the following architecture:

![Architecture](/img/mia-cloud-architecture-diagram.svg?raw=true)

## Video Demonstration

To understand this applications clinical workflow, please watch the five-minute video below.

[![MIA - Medical Imaging Acquisition Application](https://img.youtube.com/vi/U5IAxRy8dSw/0.jpg)](https://www.youtube.com/watch?v=U5IAxRy8dSw)


## Technical Write Up

A comprehensive technical write up can [be found here](https://paulbradley.dev/mia/)
