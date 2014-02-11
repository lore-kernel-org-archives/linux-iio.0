Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:1557 "EHLO
	ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750758AbaBKHeA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Feb 2014 02:34:00 -0500
Message-ID: <52F9D18A.4020002@flatmax.org>
Date: Tue, 11 Feb 2014 18:30:18 +1100
From: Matt Flax <flatmax@flatmax.org>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: Re: iio for the end user
References: <52F408F8.7080307@flatmax.org>
In-Reply-To: <52F408F8.7080307@flatmax.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi again,

I would like to ask a second time.

Are there any end user systems which support IIO ?

If not then are there any efforts for a networking protocol/library/API 
for IIO streaming ? Particularly interested in multi device input 
streaming at this point in time.

I have been working further on the jack IIO driver, however it seems 
that the concept of getting such high sample rates running on embedded 
cores may prove to challenging for audio subsystems. Whilst reading in 
the jack 'driver' space is ok, connecting clients to the 'driver' is 
difficult when trying to keep up with the higher then traditional audio 
sample rates.

thanks
Matt

On 07/02/14 09:13, Matt Flax wrote:
> Hi there,
>
> I have been working towards getting something together which allows 
> the end user to use IIO with 'standard applications' and also support 
> network connectivity. I have a set of ADCs running using IIO at the 
> moment, so I am focussing on input. I am aware that this paradigm may 
> fall over for very  high sample rates, but for lower sample rates, of 
> the order of 1 MHz, it should work.
>
> I am writing to this list to find out if there are other networkable 
> approaches in linking iio into other existing protocols/software which 
> would suit the end user ? I am new to this list and didn't find much 
> in the archives, however perhaps I missed something ?
>
> My first attempt for user space IIO is to use Jack and integrate iio 
> into Jack as a driver. I have successfully created this iio driver for 
> jack [1] and I can get the driver to run with very low latencies.
> The best spec. without overruns is :  4 channels at 1MHz with mmap 
> block sizes of 256 samples using 3 periods ... thats roughly 0.75 ms 
> maximum latency at the jack driver level.
> The current stage of development is  to connect a jack client to this 
> new iio driver and I am in the stage of debugging that work.
>
> thanks
> Matt
> [1] https://github.com/flatmax/jack1
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

