Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54169 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290AbbIVBFQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2015 21:05:16 -0400
Subject: Re: ADS1018 ADC driver
To: Michael Welling <mwelling@ieee.org>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
References: <20150921220648.GA12569@deathstar>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5600A924.1090303@roeck-us.net>
Date: Mon, 21 Sep 2015 18:04:36 -0700
MIME-Version: 1.0
In-Reply-To: <20150921220648.GA12569@deathstar>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Michael,

On 09/21/2015 03:06 PM, Michael Welling wrote:
> I am in the process of starting a new device driver for the ADS1018 ADC.
> Before starting I did some research as whether similar drivers exist in the kernel.
>
> It appears that ADC drivers are in both hwmon and iio/adc. The closest drivers to
> the device mentioned are in hwmon.
>
> Where is the best place for this new ADC driver?

Your call. You could add support for the chip to hwmon/ads1015.c, or you could write
a new driver in iio/adc. If you do the latter, maybe you can also include support
for ads1015 and ads1115, so we can ultimately remove the ads1015 driver from hwmon.

> Shouldn't ADCs all be in the same subsystem?
> Has there been any effort to unify or distiguish where drivers should go?
>
In general, ADCs primarily used for the purpose of ADC measurements would go
into iio, and ADCs used primarily for hardware monitoring would go into hwmon.

There are no strict rules, though, and this is not always black-and-white.
I am sure there are some drivers in hwmon which would be better suited for iio.
Primarily that would be the case because the iio subsystem is relatively new,
and such drivers did not have a home other than hwmon until a couple of years ago.
If you find any drivers in hwmon which you think should be moved, please feel free
to do the conversion.

Guenter

