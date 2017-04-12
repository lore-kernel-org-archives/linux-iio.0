Return-Path: <SRS0=XPh7=3U=gmail.com=plroskin@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAN_72e1voayyNrg2+6V7hhGG4uJi0FSotwrT9FeQ4QgTPoawUw@mail.gmail.com>
References: <CAN_72e1apsS2nKh7SYiETz+=bJW7mEBS6GV8DmzZEPzroaeACg@mail.gmail.com>
 <23293209-00F9-4D1E-8822-00B3B267EF79@sense.com> <CAN_72e0u+fgOB9TmvP55pDLOC1Z9vGYnNj5Zpogc1b-K7xW7WA@mail.gmail.com>
 <AD6B3C1C-0A2A-4941-86E6-D2AFB6446E18@sense.com> <CAN_72e3-Zzr7b9sLfKk1EGeAYwb03=UrJsGpLOGbR4C-QjOtLw@mail.gmail.com>
 <4311cd69-c853-8fee-c0d2-0476b24580e4@kernel.org> <CAN_72e1voayyNrg2+6V7hhGG4uJi0FSotwrT9FeQ4QgTPoawUw@mail.gmail.com>
From: Pavel Roskin <plroskin@gmail.com>
Date: Tue, 11 Apr 2017 17:05:17 -0700
Message-ID: <CAN_72e0zOws-Qusya-yhifbaQ6qDGc5wcOWX+RgT4d0fPpx7-w@mail.gmail.com>
Subject: Re: Raw data block input: is IIO a good choice?
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonah Petri <jonah@sense.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

I tried to describe all channels, and it turns out many of them cannot
be adequately described by the types in iio_chan_type. How do I
describe the message sequence number? How about the control register
value at the time when the data was captured? That data needs to be
passed to the userspace.

I checked sca3000 driver. I see that it uses
sca3000_read_first_n_hw_rb() to read the data from the buffer. Can
that data be accessed by the userspace as is, without any processing?

Pavel
