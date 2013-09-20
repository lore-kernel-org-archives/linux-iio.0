Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:50823 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754265Ab3ITUMK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 20 Sep 2013 16:12:10 -0400
Date: Fri, 20 Sep 2013 22:12:06 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 07/15] staging:iio:hmc5843: Use CALIBSCALE instead of
 magn_range
In-Reply-To: <523CA8B1.7030003@kernel.org>
Message-ID: <alpine.DEB.2.01.1309202147420.5504@pmeerw.net>
References: <1379619360-8150-1-git-send-email-pmeerw@pmeerw.net> <1379619360-8150-8-git-send-email-pmeerw@pmeerw.net> <523CA8B1.7030003@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

> I'm afraid I don't follow why you don't just make scale writeable
> rather than introducing a second element to control the same thing.
> Calibscale is intended for the case where the hardware can change
> the scale without it being apparent from the raw readings. Sometimes
> it also gets used to handling amplifiers in cases where the conversion
> function is 'interesting' and we have no choice but to do it in kernel
> in order to have data provided to userspace in a comprehensible form
> but that doesn't apply here.

I guess this is reminiscent of the staging code which had magn_range and 
scale; magn_range being the nice, human-readable measurement range (such 
as +- 1.9 Gauss)

setting the expected measurement range sounds like calibration to me...

I think this is one of the biggest issues of iio: that there is no 
guideline when to use what

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
