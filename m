Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:40973 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab1HWLNP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Aug 2011 07:13:15 -0400
Message-ID: <4E538D35.7090508@cam.ac.uk>
Date: Tue, 23 Aug 2011 12:21:25 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: malas <malas@tcoe.iitm.ac.in>
CC: linux-iio@vger.kernel.org
Subject: Re: ad7793 iio-ring test read issue - Reg
References: <20110823080829.M36921@tcoe.iitm.ac.in>
In-Reply-To: <20110823080829.M36921@tcoe.iitm.ac.in>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/23/11 09:18, malas wrote:
> 
> Dear Michael Hennerich,
> 
> 
> I shall post iio quesris in this mail list as per your suggestions.
> 
> AD7793 driver is built into kernel. The chip gets configured and am able to read data on
> continuous mode via spi interface using ad7793 driver at kernel level.
> 
> While testing userspace test iio-ring to read data from ring buffer, generic_buffer code
> was executed, it  proceeds till opening /sys/bus/iio/devices/device0:buffer0 and
> Read call fails.
Question 1: What's the kernel and where did you get it from? (Interfaces are moving
fast so it's plausible you've fallen in a hole where userspace wasn't matching kernelspace).
> 
> In fs I can list the iio device ad7793 with following properties get/set.
> 
> root:/> ls /sys/bus/iio/devices/device0\:buffer0/
> bytes_per_datum  enable           power            subsystem
> dev              length           scan_elements    uevent
> root:/>
> 
> I find access0 and event0 missing in this list. Is that the reason for read() fails.
Yes.  Question is why and without kernel version I don't know where to look I'm afraid.

> 
> Please help.
> 
> Thanks
> Mala
> --
> Open WebMail Project (http://openwebmail.org)
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

