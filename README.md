# MIA - Medical Imaging Acquisition Application

MIA is a serverless web application that allows NHS physicians to register patients and send them a secure URL via SMS to upload photos and videos for clinical review. The patient receives the secure URL and needs to authenticate themselves by confirming their date of birth. Once authenticated, the patient can select images and videos they wish the physician to review. The patient can also enter a description of the behaviour or condition they want to be reviewed. Then, the media is uploaded directly into a private S3 bucket using a short-lived signed URL, and the physician is notified to check the submitted media.

Once the physician has reviewed the uploaded media, they can publish it to a Health Information Exchange using an ITI-41  Provide and Register Set-b message.

## Architecture

The Terraform scripts deploy and provision the following architecture:

![Architecture](/img/architecture.png?raw=true)

