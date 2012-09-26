Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:57399 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071Ab2IZH1R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 26 Sep 2012 03:27:17 -0400
Message-ID: <5062AE55.4060205@jic23.retrosnub.co.uk>
Date: Wed, 26 Sep 2012 08:27:17 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Ge Gao <ggao@invensense.com>
CC: Denis Ciocca <denis.ciocca@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: iio_buffer length
References: <C0999E24-1BF1-4B7D-835B-8E3AC76C61F8@gmail.com> <5348d4d4e8f4766e2ed416b6b8318ee5@mail.gmail.com>
In-Reply-To: <5348d4d4e8f4766e2ed416b6b8318ee5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/09/12 02:32, Ge Gao wrote:
> To use KFIFO, you need Jonanthan's KFIFO poll patch,
That's in staging-next now and will merge into mainline in the
next merge window (about 1 to 2 weeks time).
> you probably also
> need a patch from me that fixed the industrial-buffer.c. But that buffer
> is not well tested and is only used by me.
There are a lot of drivers using kfifo. It's hidden in many of them as 
they use it via the industrialio-triggered-buffer helper functions that
deal with the most common use cases.

With that I count 9 in drivers/iio and 6 in drivers/staging/iio vs 10
in total for sw_ring most of which will go away once someone has a spare
couple of hours.

Basically any driver that has come along since we moved to kfifo is the
preferred choice and any that anyone has touched since then.

> The original KFIFO does not
> have poll functionality and has some other minor bug.
If I've missed any patches from you on this (or just forgotten them ;)
please do keep pestering me.
>
> Ge
>
>
> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org
> [mailto:linux-iio-owner@vger.kernel.org] On Behalf Of Denis Ciocca
> Sent: Tuesday, September 25, 2012 2:35 PM
> To: jic23@jic23.retrosnub.co.uk
> Cc: linux-iio@vger.kernel.org
> Subject: iio_buffer length
>
> Hi Jon,
>
>> Firstly please confirm you are using a kfifo buffer?
>
> No, I use sw-ring.
>
>
>> Swring is deprecated but will do precisely what you are seeing I think.
> It uses a half full watershead to decide to signal userspace.  If you wait
> till the buffer is full, unless your sampling is very slow you will have
> data coming in before userspace has read the whole buffer out. Hence you
> will loose data.
>
> You are right. I saw exatly what you said.
>
>
>> Kfifo has a more conventional poll and will fire off userspace
>> whenever
> any data is in the buffer. Hence kfifo will work for your usecase.  I
> would like to have a fill level capable buffer again in the future as they
> are very useful in high speed uses where latency doesn't matter.
>
> Ok, I will change my sw-ring buffer to kfifo!
>
> Thanks,
> Denis
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

