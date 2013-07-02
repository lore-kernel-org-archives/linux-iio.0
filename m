Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:49728 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab3GBMXn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 08:23:43 -0400
From: Marek Vasut <marex@denx.de>
To: Hector Palacios <hector.palacios@digi.com>
Subject: Re: Accessing specific hardware features of mxs-lradc
Date: Tue, 2 Jul 2013 14:06:19 +0200
Cc: linux-iio@vger.kernel.org,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
References: <51D2B057.9090005@digi.com>
In-Reply-To: <51D2B057.9090005@digi.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307021406.19310.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Hector,

> Greetings,
> 
> The mxs-lradc has some hardware specific features like the DIVIDE_BY_TWO
> (an analog divide by two circuit that can be activated per channel).
> This is not currently implemented in the driver and I was wondering what
> would be the way to expose and control such setting. A specific sysfs
> entry? Somehow through the device tree?

The proper way would be to see of IIO doesn't already have some ways to control 
those (it likely does) and then these would automatically be accessible via 
sysfs.

> Is there any example of how to control a hw-specific feature in other
> similar iio drivers?

None that I'm aware of, but I didn't look. I suspect this would be somewhere 
around the channel defitionion, since the /2 function of the LRADC is a per-
channel feature on the LRADC.

Best regards,
Marek Vasut
