Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:40436 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab2IYOFP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Sep 2012 10:05:15 -0400
Received: by oagh16 with SMTP id h16so238209oag.19
        for <linux-iio@vger.kernel.org>; Tue, 25 Sep 2012 07:05:14 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 25 Sep 2012 16:05:14 +0200
Message-ID: <CAEE_umr40Knv-LAYSCYENYXhc4eoaFEirwBzimk5dzgjMzhUkg@mail.gmail.com>
Subject: iio_buffer length
From: Denis Ciocca <denis.ciocca@gmail.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi guys,

I finally managed to resolve the issues about iio_trigger and iio_buffer.
Now I ask please you if you can clarify to me about use of
iio_generic_buffer and how I can use the /dev/iio:deviceX char-event
to catch data from buffer.
I compiled the generic-buffer program and I don't understand how datas
come out. My driver has 4 channels:
- 3 for accelerometer raw data (x,y,z)
- 1 for timestamp

The application set up the length of buffer to 32, but when I run the
application I don't see 32 samples but only 16. What means 32?
It is possible the use of buffer to catch every sample? (buffer length = 1)?
When I set buffer length to 1 the application doesn't work!

Thanks,
Denis
