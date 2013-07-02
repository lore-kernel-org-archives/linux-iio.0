Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:40708 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752267Ab3GBMyw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 08:54:52 -0400
Message-ID: <51D2CE6A.7040103@metafoo.de>
Date: Tue, 02 Jul 2013 14:58:18 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hector Palacios <hector.palacios@digi.com>
CC: linux-iio@vger.kernel.org, Marek Vasut <marex@denx.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: Accessing specific hardware features of mxs-lradc
References: <51D2B057.9090005@digi.com>
In-Reply-To: <51D2B057.9090005@digi.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/02/2013 12:49 PM, Hector Palacios wrote:
> Greetings,
> 
> The mxs-lradc has some hardware specific features like the DIVIDE_BY_TWO (an
> analog divide by two circuit that can be activated per channel).
> This is not currently implemented in the driver and I was wondering what would
> be the way to expose and control such setting. A specific sysfs entry? Somehow
> through the device tree?
> 
> Is there any example of how to control a hw-specific feature in other similar
> iio drivers?
> 

This sounds as if the channel scale is programmable. There are quite a few
drivers for devices which have similar features, just make the scale property
writable and provide a scale_available.

- Lars
