Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.208]:54294 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbcCPUCM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Mar 2016 16:02:12 -0400
Date: Wed, 16 Mar 2016 21:02:51 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, jic23@kernel.org,
	knaack.h@gmx.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: add driver for Microchip MCP414X/416X/424X/426X
Message-ID: <20160316200251.GB6212@x220>
References: <20160316113738.GB2445@x220>
 <alpine.DEB.2.02.1603161238590.30358@pmeerw.net>
 <20160316162544.GA6212@x220>
 <56E9A4FB.5060507@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56E9A4FB.5060507@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mar 16, 2016 19:24, Lars-Peter Clausen wrote:
> On 03/16/2016 05:25 PM, Slawomir Stepien wrote:
> > On Mar 16, 2016 13:30, Peter Meerwald-Stadler wrote:
> [...]
> >> plenty of the private API, some of which seems to be debug only?
> >> what is really needed to interact with a poti?
> > 
> > I wanted to export both the non volatile and volatile memory addresses for wiper
> > position access. That is bare minimum for the poti to operate.
> > 
> > But I also wanted to export additional features of this chip. That is way there
> > is increase and decrease API, and STATUS and TCON register access.
> > 
> 
> The important part about a framework and the associated device drivers
> is to expose the features of a device using a standardized interface so
> you can write generic applications/libraries and share infrastructure.
> If an application requires device specific knowledge to access the
> features of a device you may as well write a userspace driver using i2cdev.
> 
> So when you are introducing new ABI it should at least follow the
> standard naming scheme. And also try to think whether this is a feature
> that is present in other similar devices and come up with a device
> independent way to expose this functionality.
> 
> Let's start with the simple stuff, I don't really see the advantage of
> having separate inc/dec controls. This can be handled through the
> standard raw attribute. If the newly written value is one off from the
> previous one use inc/dec otherwise write it directly. And even then it
> might make sense to just ignore that and always write the raw value.

I've got your point. The version 2 will use only the IIO facilities. Then I will
try to build more based on that.

> > The memory_map API is a way to access all the not used by chip memory addresses.
> > This API I think could be deleted. But I still think that some people might find
> > it useful.
> 
> This sounds more like it should maybe be exposed as a standard EEPROM
> device.

Not quite familiar with this, but will look into that.

Once more thank you for comments.

-- 
Slawomir Stepien
