Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52549 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbcBLRXu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2016 12:23:50 -0500
In-Reply-To: <56BDAE57.4010900@parrot.com>
References: <56BDAE57.4010900@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: read_raw when buffered sampling enabled
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Fri, 12 Feb 2016 17:23:17 +0000
To: Gregor Boirie <gregor.boirie@parrot.com>,
	linux-iio@vger.kernel.org,
	Gregor Boirie <gregor.boirie@parrot.com>,
	linux-iio@vger.kernel.org
Message-ID: <3E5381FC-27B7-4B01-AAE7-B6941D99BAC3@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 12 February 2016 10:05:11 GMT+00:00, Gregor Boirie <gregor.boirie@parrot.com> wrote:
>Greetings,
>
>I see in several iio drivers supporting triggered buffer mode that
>read_raw
>returns -EBUSY when buffered sampling is enabled. This additional logic
>is implemented in read_raw using iio_buffer_enabled().
>Since some drivers don't implement this I'm wondering wether this logic
>is
>an IIO design requirement or if this is device / driver specific.

Driver specific. Usually depends on whether such a read will
 materially effect capture to a buffer.  So usually prevent
 reads if for example a new data interrupt would be skipped
 or a sequence of data disrupted.

Some devices will read a last captured value out without
 effecting the flow so don't need to prevent such reads.

Others do every read on demand, so other than possible bus congestion, there is no
 reason to prevent such reads (and congestion is largely beyond our control,
 is we don't lock the bus up,  anyway so who cares!)

I have thought about adding some caching in the core to allow in kernel
 polled and push clients to run at the same time but that would require explicit
 notice that a polled client might want the data and some fun with an additional
 cache buffer attached.


Jonathan
>
>Regards,
>Grégor.
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
