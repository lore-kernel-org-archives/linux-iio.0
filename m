Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33241 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933423AbcLTKSl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2016 05:18:41 -0500
Received: by mail-yw0-f196.google.com with SMTP id s68so10362402ywg.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2016 02:18:41 -0800 (PST)
MIME-Version: 1.0
From: Matthias Klumpp <matthias@tenstral.net>
Date: Tue, 20 Dec 2016 11:18:40 +0100
Message-ID: <CAKNHny-B-tyZ3GszV-DLxRKzhhCuqELUc6MsiPs=76GYghO58g@mail.gmail.com>
Subject: Problems with using IIO buffers
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello!
I am having troubles getting buffers to work with IIO. Querying raw
data from devices works well via sysfs, but buffered input from ADCs
does not work.

I am writing a driver for the MAX1133 ADC chip, and the poll function
to gather data is never called, while it is correctly registered using
the iio_triggered_buffer_setup() function.
Querying the device with iio_readdev fails with a timeout.

Furthermore when using the iio_dummy driver with iio_readdev from the
libiio utils, I get the exact same result: "Unable to refill buffer:
Connection timed out".

Do you maybe have any pointers for me on what to try next to make this
work? So far, all my attempts at adressing this issue yielded no
results. The Linux kernel is rather standard, but compiled with the
RT_PREEMPT patches (but I also verified that this issue exists with a
non-RT kernel as well).

Linux is at 4.8.14 on armhf, and this issue also exists with Linux 4.4.

Since I never touched IIO before, I would be very happy about getting
some pointers on how to debug this.

Kind regards,
    Matthias Klumpp

-- 
Debian Developer | Freedesktop-Developer
I welcome VSRE emails. See http://vsre.info/
