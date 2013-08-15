Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:34551 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439Ab3HOJJM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 15 Aug 2013 05:09:12 -0400
Date: Thu, 15 Aug 2013 11:09:11 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/1] Add Microchip MCP3422/3/4 High resolution ADC
In-Reply-To: <1376500125-16014-1-git-send-email-angelo.compagnucci@gmail.com>
Message-ID: <alpine.DEB.2.01.1308151104040.29956@pmeerw.net>
References: <1376500125-16014-1-git-send-email-angelo.compagnucci@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

> This revision solves various problems of the previous one.
> Most important is locking of the chip configuration during updates
> and the use of devm_* API.
> For each channel there are now two sysfs attributes, so you can read
> the raw value or the scaled one.
> 
> To Peter: Chip versions differs in address assignment (MCP3422 has a fixed address)
> and channel number (MCP3423 has 2 channels, MCP3424 has 4) but the chip manages
> internally the lack of channels (it remaps non exixtent channels to the existent ones)
> so I opted to keep the driver clean and implemented all the four channels.

looks a whole lot better!

regarding chip ids and channels: many ADC drivers create the number of 
channels dynamically, I'd rather implement this

having different chips in mcp3422_id but not using it is confusing to me

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
