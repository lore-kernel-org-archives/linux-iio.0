Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:42100 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab3HUABC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Aug 2013 20:01:02 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so1006138pbc.30
        for <linux-iio@vger.kernel.org>; Tue, 20 Aug 2013 17:01:01 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: DTS Support for AD7192
From: Oliver King-Smith <oliverks@elementalsemi.com>
In-Reply-To: <6067964B99C6A049AA5840B6F7BB2D0A0299F4@NWD2MBX6.ad.analog.com>
Date: Tue, 20 Aug 2013 17:00:55 -0700
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-Id: <AB3418D4-59F5-4929-BF67-32EBB47276B3@elementalsemi.com>
References: <95643F3C-C453-45AE-87B6-0D7D0096EA89@elementalsemi.com>,<520F4828.90300@metafoo.de> <6067964B99C6A049AA5840B6F7BB2D0A0299F4@NWD2MBX6.ad.analog.com>
To: "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dragos,

I am resending this, as I accidentally sent the previous version in non plain text.

Thank you for the follow up, I have made some progress on this.  I am using the Beaglebone Black to interface to the ad7192.  The main problem now can be shown in the log below:

[  311.593777] ad7192: module is from the staging directory, the quality is unknown, you have been warned.
[  311.595641] edma-dma-engine edma-dma-engine.0: allocated channel for 0:43
[  311.597279] edma-dma-engine edma-dma-engine.0: allocated channel for 0:42
[  311.597617] ad7192 spi1.0: no platform data?
[  311.609899] bone-capemgr bone_capemgr.8: slot #7: Applied #2 overlays.

The platform data in this case is the struct ad7192_platform_data

There is no support that I can see to populate this data from device tree.  I assume this is part of your fix.

Another issue I saw when hooking the ad7192 to an old beagle bone (running a much older version of the kernel and iio infrastructure) was the iio driver for the ad7192 was hanging working with the AM335X processors.  In this case I tracked the problem to level sensitive interrupts rather than edge sensitive.  There were some race conditions that cause the driver to miss an interrupt and hang as a result.  I never got it entirely working as I got distracted and the Beaglebone Black came out by the time I picked it up again.  Do you want me to post those changes back?  A lot has changed since then, but it could still be a problem in the current drivers.

 Oliver King-Smith PhD
CEO
831-227-8675
oliverks@elementalsemi.com
