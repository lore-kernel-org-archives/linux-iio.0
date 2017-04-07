Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34441 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbdDGVsM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Apr 2017 17:48:12 -0400
Received: by mail-qk0-f179.google.com with SMTP id p68so48462465qke.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Apr 2017 14:48:12 -0700 (PDT)
MIME-Version: 1.0
From: Pavel Roskin <plroskin@gmail.com>
Date: Fri, 7 Apr 2017 14:48:11 -0700
Message-ID: <CAN_72e1apsS2nKh7SYiETz+=bJW7mEBS6GV8DmzZEPzroaeACg@mail.gmail.com>
Subject: Raw data block input: is IIO a good choice?
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

I'm writing a driver for an FPGA device that collects information from
several sensors. The data is collected every 20 milliseconds (i.e. 50
times a second). The data is a 256 byte block that is put to a ring
buffer in the hardware. The software should read the data quickly to
avoid it being overwritten in the ring buffer. It is very important
not to lose any data; previous values are just as important as the
current ones. No parsing needs to be done in the kernel; the userspace
will take care of it.

Is IIO a good choice for such device? I see that the existing IIO
drivers are careful to describe all data they collect. I'm not going
to do that in the kernel (OK, maybe later to allow other utilities to
get the parsed data, but it can be done in userspace too).

I would really appreciate is somebody could point me to a driver that
implements similar functionality.

-- 
Regards,
Pavel Roskin
