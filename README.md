# MIA - Medical Imaging Acquisition Application

MIA is a serverless web application which allows physicians to register patients and send them a secure URL via SMS to upload photo and videos for the physician to review. The patient receives the secure URL and needs to authenticate themselves by confirming their date of birth. Once authenticated thee patient is able to select images and/or video they wish the physician to review. The media is uploaded directly into a private S3 bucket using a short lived signed URL.

Once the physician has reviewed the uploaded media, they can choose to publish it to a Health Information Exchange using a standards based ITI-41 : Provide and Register Set-b message.

## Architecture

The Terraform scripts deploy and provision the following architecture:


![Architecture](/img/architecture.png?raw=true)

