Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35844 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbdDHAUj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Apr 2017 20:20:39 -0400
Received: by mail-qk0-f175.google.com with SMTP id p22so75362553qka.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Apr 2017 17:20:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Raw data block input: is IIO a good choice?
From: Jonah Petri <jonah@sense.com>
In-Reply-To: <CAN_72e1apsS2nKh7SYiETz+=bJW7mEBS6GV8DmzZEPzroaeACg@mail.gmail.com>
Date: Fri, 7 Apr 2017 20:20:36 -0400
Cc: linux-iio@vger.kernel.org
Message-Id: <23293209-00F9-4D1E-8822-00B3B267EF79@sense.com>
References: <CAN_72e1apsS2nKh7SYiETz+=bJW7mEBS6GV8DmzZEPzroaeACg@mail.gmail.com>
To: Pavel Roskin <plroskin@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Pavel,

I=E2=80=99m fairly new to IIO, but I am working on a somewhat similar =
project.  One important question is how you are intending to transport =
your data from the FPGA to your CPU?  Do you have a DMA engine of some =
kind, with a linux driver?  Or perhaps a wire protocol, such as SPI or =
I2C?  What=E2=80=99s your realtime requirements?  That is, if your data =
rate is 12.5k/sec, so how much buffer space do you have on the hardware? =
 Typically you would aim to drain the hardware when it is 50% full, so =
that would give you an idea of how frequently you=E2=80=99d need to =
service your hardware buffer.

Stock Linux isn=E2=80=99t going to be your friend if your realtime =
requirements are tight.  Don=E2=80=99t rely on interrupt latencies less =
than 10s of milliseconds, or even more on busy systems.

Jonah


> On Apr 7, 2017, at 5:48 PM, Pavel Roskin <plroskin@gmail.com> wrote:
>=20
> Hello,
>=20
> I'm writing a driver for an FPGA device that collects information from
> several sensors. The data is collected every 20 milliseconds (i.e. 50
> times a second). The data is a 256 byte block that is put to a ring
> buffer in the hardware. The software should read the data quickly to
> avoid it being overwritten in the ring buffer. It is very important
> not to lose any data; previous values are just as important as the
> current ones. No parsing needs to be done in the kernel; the userspace
> will take care of it.
>=20
> Is IIO a good choice for such device? I see that the existing IIO
> drivers are careful to describe all data they collect. I'm not going
> to do that in the kernel (OK, maybe later to allow other utilities to
> get the parsed data, but it can be done in userspace too).
>=20
> I would really appreciate is somebody could point me to a driver that
> implements similar functionality.
>=20
> --=20
> Regards,
> Pavel Roskin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

