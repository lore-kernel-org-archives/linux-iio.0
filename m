Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34117 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbdDHDKT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Apr 2017 23:10:19 -0400
Received: by mail-qk0-f179.google.com with SMTP id p68so51559297qke.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Apr 2017 20:10:18 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Raw data block input: is IIO a good choice?
From: Jonah Petri <jonah@sense.com>
In-Reply-To: <CAN_72e0u+fgOB9TmvP55pDLOC1Z9vGYnNj5Zpogc1b-K7xW7WA@mail.gmail.com>
Date: Fri, 7 Apr 2017 23:10:16 -0400
Cc: linux-iio@vger.kernel.org
Message-Id: <AD6B3C1C-0A2A-4941-86E6-D2AFB6446E18@sense.com>
References: <CAN_72e1apsS2nKh7SYiETz+=bJW7mEBS6GV8DmzZEPzroaeACg@mail.gmail.com> <23293209-00F9-4D1E-8822-00B3B267EF79@sense.com> <CAN_72e0u+fgOB9TmvP55pDLOC1Z9vGYnNj5Zpogc1b-K7xW7WA@mail.gmail.com>
To: Pavel Roskin <plroskin@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Pavel,

To me, IIO seems really great if you want to have generic, structured =
access to your sensor's data from userspace, with a single driver =
supporting a wide variety of use cases.  Your system sounds very =
bespoke, and I=E2=80=99m guessing that you probably have a single, =
tightly-coupled client for your data.

In my opinion, IIO might be a bit much for your situation.  If I were =
you, I would just implement a /dev/ node which returns the queued data =
from the FPGA on read.  Should be a simple fops table and not much else, =
I=E2=80=99d think.  Just my 2=C2=A2!

Best,
Jonah

> On Apr 7, 2017, at 9:47 PM, Pavel Roskin <plroskin@gmail.com> wrote:
>=20
> Hi Jonah,
>=20
> Thank you for reply! There is no DMA. The ring buffer is implemented
> in FPGA. It is mapped to the CPU memory. It has space for 64 messages.
> That is, if the userspace doesn't read data for 64/50 =3D 1.28 =
seconds,
> there will be lost data. It is possible to set up an interrupt as a
> certain watermark, e.g. when half of the buffers are utilized. But I
> expect that the userspace utility will be polling the driver for new
> messages and will read them before the interrupt is triggered.
>=20
> I'm not sure if a buffer in the kernel space would be needed. It would
> be nice to save the data in case if the userspace software is slow.
> But I don't see that as a hard requirement. If the userspace utility
> sleeps for over a second, I would be in trouble, with or without
> kernel buffering.
>=20
> I don't want to do any processing in the kernel space. So the driver
> would have one "channel" spitting out 256 byte long opaque packets.
>=20
> I'm sure there are tons of ways to get that data to the userspace, I
> just want to select a subsystem that would cause less frustration and
> "impedance mismatch".
>=20
> --=20
> Regards,
> Pavel Roskin

