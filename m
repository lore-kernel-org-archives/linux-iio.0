Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59448 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992459AbbHHQma (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 12:42:30 -0400
Subject: Re: [PATCH v5 0/8] iio: mma8452: improve driver and support more
 chips
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org
References: <1438006095-26920-1-git-send-email-martink@posteo.de>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C63172.3090503@kernel.org>
Date: Sat, 8 Aug 2015 17:42:26 +0100
MIME-Version: 1.0
In-Reply-To: <1438006095-26920-1-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Martin,

Sorry to say this has crossed with a cleanup set from Hartmut.
I'm afraid I applied his first.  This will all need rebasing.

There weren't any fundamental changes in Hartmut's series, but
I'd feel nervous to try and apply yours on top without hardware to
sanity check I hadn't messed it up.

Jonathan

On 27/07/15 15:08, Martin Kepplinger wrote:
> Before I go away for holidays, this is version 5 of the mma8452 driver
> improvements. This version removes the unnessasary DRIVER_NAME define and
> improves the DT property "use_int2" to be extendible for any future additions
> to the driver.
> 
> This is based on today's -next.
> 
> 
> These changes add support for motion interrupts and 3 more accelerometer
> chips, two of which use them because they don't support the until now
> included transient interrupt sources:
> 
> MMA8453Q, MMA8652FC and MMA8653FC; datasheets are in the commit messages.
> The driver and module name remains the same, seperating it from the device
> names it now supports.
> 
> On top of this, there are minor documentation additions, and more notably,
> it allows to use the driver, no matter how the interrupt pins are wired
> on your board.
> 
> Please review and test if you can. For MMA8452Q, nothing should have
> changed.
> 
> revision history
> ----------------
> v5   DRIVER_NAME define removed; more flexible DT property
> v4   cleanup; one bugfix patch removed from series; DT people added
> v3   adds one patch to allow all possible pin wirings; adds more email
> recipients
> v2   splits the work into a series of smaller pieces
> v1   initial post
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

