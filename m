Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:51729 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932461AbcDLMGk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 12 Apr 2016 08:06:40 -0400
Date: Tue, 12 Apr 2016 14:06:38 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: IIO driver for si114x
In-Reply-To: <570CDFD0.7060702@intel.com>
Message-ID: <alpine.DEB.2.02.1604121404050.4383@pmeerw.net>
References: <570CDFD0.7060702@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

> I want to add support for a si1145 light sensor. Some brief googling finds a
> bunch of old (2012) patches for an si114x driver in drivers/iio/light. Here's
> the link to the old thread:
> 
> http://comments.gmane.org/gmane.linux.kernel.iio/5478

I have updated sources, not yet posted
Matt Ranostay also indicated that he'd be willing to work on the device

> I'm willing to do the work to get support for this in upstream. I guess the
> best way to do that would be to apply the most recent source I can find to my
> local tree, test it on my device and repost on the list for review, right? I
> can't find anything newer than 2012 though.

the si114x is a rather complicated device with many controls, for example 
the output current of the LEDs

I think this issue also surfaced for another proximity driver recently...

regards, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
