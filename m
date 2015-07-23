Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:39033 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753149AbbGWPx0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 Jul 2015 11:53:26 -0400
Received: from mrelay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 328AB47F006
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2015 17:24:25 +0200 (CEST)
Message-ID: <1437664945.2863.14.camel@hadess.net>
Subject: Re: bmc150_accel i2c-BMA250E:00: Invalid chip f8
From: Bastien Nocera <hadess@hadess.net>
To: jic23@jic23.retrosnub.co.uk
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Thu, 23 Jul 2015 17:22:25 +0200
In-Reply-To: <20150723135953.77FEB431C5@saturn.retrosnub.co.uk>
References: <1437590935.30706.106.camel@hadess.net>
	 <20150723135953.77FEB431C5@saturn.retrosnub.co.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 2015-07-23 at 14:59 +0100, jic23@jic23.retrosnub.co.uk wrote:
> 
<snip>
> Odd. The bma250e is documented as having an id of 0xf9 not 0xf8.
> http://ae-bst.resource.bosch.com/media/products/dokumente/bma250e/BST
> -BMA250 
> E-DS004-05_published.pdf 
> 
> So all I can think of is that the chip is a bma222e (or something 
> else
> with the 0xf8 chip id) or there are some bma250e's out there with
> the wrong ID... 
> 
> Someone changed a part on the device and thought no one would notice
> and hence didn't update the bios? (even if it has a totally different
> range) 
> 
> I guess if you frig the driver to load anyway we can see what value
> it is giving for g and that should give us more of a clue. 

I've sent 1 preparation patch, and one fixup patch to ignore the
ACPI/I2C ID when selecting the chip type.

Cheers

