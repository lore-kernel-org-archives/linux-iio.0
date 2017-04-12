Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41182 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbdDLOg6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Apr 2017 10:36:58 -0400
Date: Wed, 12 Apr 2017 15:36:44 +0100
In-Reply-To: <CAN_72e0zOws-Qusya-yhifbaQ6qDGc5wcOWX+RgT4d0fPpx7-w@mail.gmail.com>
References: <CAN_72e1apsS2nKh7SYiETz+=bJW7mEBS6GV8DmzZEPzroaeACg@mail.gmail.com> <23293209-00F9-4D1E-8822-00B3B267EF79@sense.com> <CAN_72e0u+fgOB9TmvP55pDLOC1Z9vGYnNj5Zpogc1b-K7xW7WA@mail.gmail.com> <AD6B3C1C-0A2A-4941-86E6-D2AFB6446E18@sense.com> <CAN_72e3-Zzr7b9sLfKk1EGeAYwb03=UrJsGpLOGbR4C-QjOtLw@mail.gmail.com> <4311cd69-c853-8fee-c0d2-0476b24580e4@kernel.org> <CAN_72e1voayyNrg2+6V7hhGG4uJi0FSotwrT9FeQ4QgTPoawUw@mail.gmail.com> <CAN_72e0zOws-Qusya-yhifbaQ6qDGc5wcOWX+RgT4d0fPpx7-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: Raw data block input: is IIO a good choice?
To: Pavel Roskin <plroskin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
CC: Jonah Petri <jonah@sense.com>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <6C2F73E4-E1A9-4F25-9953-D6D8441799DA@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 12 April 2017 01:05:17 BST, Pavel Roskin <plroskin@gmail.com> wrote:
>Hi Jonathan,
>
>I tried to describe all channels, and it turns out many of them cannot
>be adequately described by the types in iio_chan_type. How do I
>describe the message sequence number? 
That wouldn't normally be of interest to userspace as driver would guarantee order.

How about the control register
>value at the time when the data was captured? That data needs to be
>passed to the userspace.

Is it changing on its own? If not normally that is represented via out of band reads of sysfs.

>
>I checked sca3000 driver. I see that it uses
>sca3000_read_first_n_hw_rb() to read the data from the buffer. Can
>that data be accessed by the userspace as is, without any processing?

It is supplied raw to userspace. You can do what you like.

J
>
>Pavel

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
