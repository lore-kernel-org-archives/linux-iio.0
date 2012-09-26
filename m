Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55831 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964Ab2IZBjb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Sep 2012 21:39:31 -0400
Received: by vbbff1 with SMTP id ff1so78118vbb.19
        for <linux-iio@vger.kernel.org>; Tue, 25 Sep 2012 18:39:30 -0700 (PDT)
From: Ge Gao <ggao@invensense.com>
References: <C0999E24-1BF1-4B7D-835B-8E3AC76C61F8@gmail.com>
In-Reply-To: <C0999E24-1BF1-4B7D-835B-8E3AC76C61F8@gmail.com>
MIME-Version: 1.0
Date: Tue, 25 Sep 2012 18:32:51 -0700
Message-ID: <5348d4d4e8f4766e2ed416b6b8318ee5@mail.gmail.com>
Subject: RE: iio_buffer length
To: Denis Ciocca <denis.ciocca@gmail.com>, jic23@jic23.retrosnub.co.uk
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

To use KFIFO, you need Jonanthan's KFIFO poll patch,  you probably also
need a patch from me that fixed the industrial-buffer.c. But that buffer
is not well tested and is only used by me. The original KFIFO does not
have poll functionality and has some other minor bug.

Ge


-----Original Message-----
From: linux-iio-owner@vger.kernel.org
[mailto:linux-iio-owner@vger.kernel.org] On Behalf Of Denis Ciocca
Sent: Tuesday, September 25, 2012 2:35 PM
To: jic23@jic23.retrosnub.co.uk
Cc: linux-iio@vger.kernel.org
Subject: iio_buffer length

Hi Jon,

> Firstly please confirm you are using a kfifo buffer?

No, I use sw-ring.


> Swring is deprecated but will do precisely what you are seeing I think.
It uses a half full watershead to decide to signal userspace.  If you wait
till the buffer is full, unless your sampling is very slow you will have
data coming in before userspace has read the whole buffer out. Hence you
will loose data.

You are right. I saw exatly what you said.


> Kfifo has a more conventional poll and will fire off userspace
> whenever
any data is in the buffer. Hence kfifo will work for your usecase.  I
would like to have a fill level capable buffer again in the future as they
are very useful in high speed uses where latency doesn't matter.

Ok, I will change my sw-ring buffer to kfifo!

Thanks,
Denis
--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
the body of a message to majordomo@vger.kernel.org More majordomo info at
http://vger.kernel.org/majordomo-info.html
