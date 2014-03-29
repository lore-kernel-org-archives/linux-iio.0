Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47678 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbaC2LEq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Mar 2014 07:04:46 -0400
Message-ID: <5336A913.1040908@kernel.org>
Date: Sat, 29 Mar 2014 11:05:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ge Gao <GGao@invensense.com>, Lars-Peter Clausen <lars@metafoo.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: unreliable time function inside IRQ?
References: <E7747D604FBC9F43A71AA431AFF447622577643E@IUSEXCH01.invcorp.invensense.com>
In-Reply-To: <E7747D604FBC9F43A71AA431AFF447622577643E@IUSEXCH01.invcorp.invensense.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/03/14 21:56, Ge Gao wrote:
> Dear all, Had to bring this question again to see whether anyone see
> the same problem. IIO fetches the timestamp inside IRQ using
> iio_get_time_ns(), which in turn call ktime_get_real_ts(&ts).
> However, I notice that the clock taken during interrupt is not always
> reliable. Sometimes the clock does not update. It is updated after
> one or more interrupts. It is very easy to reproduce. First find a
> hardware generating fixed interval of interrupts and using IIO driver
> to run it. Print out the timestamp. You could find that the timestamp
> distance is not always correct. For example, if you run a 5 Hz
> interrupt, most of time you will interrupt timestamp interval is
> around 200ms. However, sometimes, you could see interval sequence
> like ...200, 192, 208, 200, 200, 182, 218, 200....... I searched
> online and only found one result, which is exactly the same as I
> observed. Below is the link:
> http://stackoverflow.com/questions/17080516/unable-unreliable-to-use-clock-gettime-in-hard-irq-context
>
>
But no one answer the question.
> 	Is there anyone see the same problem? Thanks.
Hi Ge,

I'm afraid I don't know the cause of this.
It's also entirely possible that other interrupts are occurring that
are delaying the processing of some of your interrupts.
The slightly interesting bit is that you seem to be getting interrupts
apparently early sometimes.  I would have expected a longer delay then
a shorter one if it was something else interfering.

It might be related to the implementation of the high resolution
timers on your platform.  Perhaps they are being updated by a high
precision, low frequency source.  Mind you, in that case I think
you'd expect to see only one value being out rather than the single
early value you appear to be seeing here.  For some reason it seems
that occasionally you are handling interrupts earlier than the
majority of the time... Odd!


What is the platform you are seeing this on?

Jonathan
>
> Best Regards,
>
> Ge GAO
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

