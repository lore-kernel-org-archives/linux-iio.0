Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-004.synserver.de ([212.40.185.4]:1452 "EHLO
	smtp-out-003.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934953AbcCPSjH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Mar 2016 14:39:07 -0400
Subject: Re: [PATCH] iio: add driver for Microchip MCP414X/416X/424X/426X
To: Slawomir Stepien <sst@poczta.fm>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20160316113738.GB2445@x220>
 <alpine.DEB.2.02.1603161238590.30358@pmeerw.net> <20160316162544.GA6212@x220>
Cc: jic23@kernel.org, knaack.h@gmx.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56E9A4FB.5060507@metafoo.de>
Date: Wed, 16 Mar 2016 19:24:59 +0100
MIME-Version: 1.0
In-Reply-To: <20160316162544.GA6212@x220>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/16/2016 05:25 PM, Slawomir Stepien wrote:
> On Mar 16, 2016 13:30, Peter Meerwald-Stadler wrote:
[...]
>> plenty of the private API, some of which seems to be debug only?
>> what is really needed to interact with a poti?
> 
> I wanted to export both the non volatile and volatile memory addresses for wiper
> position access. That is bare minimum for the poti to operate.
> 
> But I also wanted to export additional features of this chip. That is way there
> is increase and decrease API, and STATUS and TCON register access.
> 

The important part about a framework and the associated device drivers
is to expose the features of a device using a standardized interface so
you can write generic applications/libraries and share infrastructure.
If an application requires device specific knowledge to access the
features of a device you may as well write a userspace driver using i2cdev.

So when you are introducing new ABI it should at least follow the
standard naming scheme. And also try to think whether this is a feature
that is present in other similar devices and come up with a device
independent way to expose this functionality.

Let's start with the simple stuff, I don't really see the advantage of
having separate inc/dec controls. This can be handled through the
standard raw attribute. If the newly written value is one off from the
previous one use inc/dec otherwise write it directly. And even then it
might make sense to just ignore that and always write the raw value.

> The memory_map API is a way to access all the not used by chip memory addresses.
> This API I think could be deleted. But I still think that some people might find
> it useful.

This sounds more like it should maybe be exposed as a standard EEPROM
device.

