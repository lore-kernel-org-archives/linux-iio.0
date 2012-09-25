Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56157 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757730Ab2IYQcj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Sep 2012 12:32:39 -0400
References: <CAEE_umr40Knv-LAYSCYENYXhc4eoaFEirwBzimk5dzgjMzhUkg@mail.gmail.com>
In-Reply-To: <CAEE_umr40Knv-LAYSCYENYXhc4eoaFEirwBzimk5dzgjMzhUkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: iio_buffer length
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 25 Sep 2012 17:20:56 +0100
To: Denis Ciocca <denis.ciocca@gmail.com>, linux-iio@vger.kernel.org
Message-ID: <be76e072-47c2-4abc-bea1-69081e98abad@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Denis Ciocca <denis.ciocca@gmail.com> wrote:

>Hi guys,
>
>I finally managed to resolve the issues about iio_trigger and
>iio_buffer.
>Now I ask please you if you can clarify to me about use of
>iio_generic_buffer and how I can use the /dev/iio:deviceX char-event
>to catch data from buffer.
>I compiled the generic-buffer program and I don't understand how datas
>come out. My driver has 4 channels:
>- 3 for accelerometer raw data (x,y,z)
>- 1 for timestamp
>
>The application set up the length of buffer to 32, but when I run the
>application I don't see 32 samples but only 16. What means 32?
>It is possible the use of buffer to catch every sample? (buffer length
>= 1)?
>When I set buffer length to 1 the application doesn't work!

Firstly please confirm you are using a kfifo buffer? Swring is deprecated but will do precisely what you are seeing I think. It uses a half full watershead to decide to signal userspace.  If you wait till the buffer is full, unless your sampling is very slow you will have data coming in before userspace has read the whole buffer out. Hence you will loose data.  Kfifo has a more conventional poll and will fire off userspace whenever any data is in the buffer. Hence kfifo will work for your usecase.  I would like to have a fill level capable buffer again in the future as they are very useful in high speed uses where latency doesn't matter. 

If you are using kfifo then something odd is going on!  Its trivial to switch a driver between them.
>
>Thanks,
>Denis
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
