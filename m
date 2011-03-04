Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45959 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031Ab1CDKcv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Mar 2011 05:32:51 -0500
Received: by pvg12 with SMTP id 12so311726pvg.19
        for <linux-iio@vger.kernel.org>; Fri, 04 Mar 2011 02:32:50 -0800 (PST)
Message-ID: <4D70BFCD.40605@gmail.com>
Date: Fri, 04 Mar 2011 18:32:45 +0800
From: Marten Svanfeldt <marten.svanfeldt@gmail.com>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: High frequency software trigger
References: <4D709432.90003@gmail.com> <544AC56F16B56944AEC3BD4E3D59177133FA70B26C@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177133FA70B26C@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2011-03-04 17:19, Hennerich, Michael wrote:
>
> I recently submitted a trigger source driver that utilizes Blackfin hardware timer.
>
> http://wiki.analog.com/software/linux/docs/iio/iio-trig-bfin-timer

Thank you, this had passed me by. Looking at the source, it seems that a 
hrtimer based trigger would be something similar, except not tied to any 
specific platform.

>
> Not sure what your platform is, but there might be similar peripherals,
> that can generate sub second cyclic interrupts.
The platform in question is an TI OMAP3 (3530) based system, but my goal 
would be to utilize hrtimers as they are not tied to a specific 
platform. They are supposed to work on our target platform, but I 
haven't had time to test them extensively yet.

> I successfully used it on a fast Blackfin processor at frequencies of 10kHz and above,
> with this simple demo application.
>
> http://wiki.analog.com/software/linux/docs/iio/iio_netscope
10kHz sounds reassuring, in my case it is about 250Hz max, but some 13 
or so channels. Did you get any idea where the limitations lies in terms 
of system load etc? Of course this depends on the exact setup, just 
trying to find all possible sides of moving our code over to be IIO-based.

Regards
Marten Svanfeldt
