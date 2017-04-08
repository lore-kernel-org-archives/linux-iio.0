Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33705 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbdDHBrH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Apr 2017 21:47:07 -0400
Received: by mail-qk0-f177.google.com with SMTP id h67so76421510qke.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Apr 2017 18:47:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <23293209-00F9-4D1E-8822-00B3B267EF79@sense.com>
References: <CAN_72e1apsS2nKh7SYiETz+=bJW7mEBS6GV8DmzZEPzroaeACg@mail.gmail.com>
 <23293209-00F9-4D1E-8822-00B3B267EF79@sense.com>
From: Pavel Roskin <plroskin@gmail.com>
Date: Fri, 7 Apr 2017 18:47:05 -0700
Message-ID: <CAN_72e0u+fgOB9TmvP55pDLOC1Z9vGYnNj5Zpogc1b-K7xW7WA@mail.gmail.com>
Subject: Re: Raw data block input: is IIO a good choice?
To: Jonah Petri <jonah@sense.com>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonah,

Thank you for reply! There is no DMA. The ring buffer is implemented
in FPGA. It is mapped to the CPU memory. It has space for 64 messages.
That is, if the userspace doesn't read data for 64/50 = 1.28 seconds,
there will be lost data. It is possible to set up an interrupt as a
certain watermark, e.g. when half of the buffers are utilized. But I
expect that the userspace utility will be polling the driver for new
messages and will read them before the interrupt is triggered.

I'm not sure if a buffer in the kernel space would be needed. It would
be nice to save the data in case if the userspace software is slow.
But I don't see that as a hard requirement. If the userspace utility
sleeps for over a second, I would be in trouble, with or without
kernel buffering.

I don't want to do any processing in the kernel space. So the driver
would have one "channel" spitting out 256 byte long opaque packets.

I'm sure there are tons of ways to get that data to the userspace, I
just want to select a subsystem that would cause less frustration and
"impedance mismatch".

-- 
Regards,
Pavel Roskin
