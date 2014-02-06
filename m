Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:58286 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751426AbaBFWNQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2014 17:13:16 -0500
Message-ID: <52F408F8.7080307@flatmax.org>
Date: Fri, 07 Feb 2014 09:13:12 +1100
From: Matt Flax <flatmax@flatmax.org>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: iio for the end user
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi there,

I have been working towards getting something together which allows the 
end user to use IIO with 'standard applications' and also support 
network connectivity. I have a set of ADCs running using IIO at the 
moment, so I am focussing on input. I am aware that this paradigm may 
fall over for very  high sample rates, but for lower sample rates, of 
the order of 1 MHz, it should work.

I am writing to this list to find out if there are other networkable 
approaches in linking iio into other existing protocols/software which 
would suit the end user ? I am new to this list and didn't find much in 
the archives, however perhaps I missed something ?

My first attempt for user space IIO is to use Jack and integrate iio 
into Jack as a driver. I have successfully created this iio driver for 
jack [1] and I can get the driver to run with very low latencies.
The best spec. without overruns is :  4 channels at 1MHz with mmap block 
sizes of 256 samples using 3 periods ... thats roughly 0.75 ms maximum 
latency at the jack driver level.
The current stage of development is  to connect a jack client to this 
new iio driver and I am in the stage of debugging that work.

thanks
Matt
[1] https://github.com/flatmax/jack1
