Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36453 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757437AbbIVB1Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2015 21:27:16 -0400
Received: by ioii196 with SMTP id i196so2099820ioi.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2015 18:27:15 -0700 (PDT)
Date: Mon, 21 Sep 2015 20:27:07 -0500
From: Michael Welling <mwelling@ieee.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: ADS1018 ADC driver
Message-ID: <20150922012707.GA20799@deathstar>
References: <20150921220648.GA12569@deathstar>
 <5600A924.1090303@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5600A924.1090303@roeck-us.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Sep 21, 2015 at 06:04:36PM -0700, Guenter Roeck wrote:
> Hi Michael,
> 
> On 09/21/2015 03:06 PM, Michael Welling wrote:
> >I am in the process of starting a new device driver for the ADS1018 ADC.
> >Before starting I did some research as whether similar drivers exist in the kernel.
> >
> >It appears that ADC drivers are in both hwmon and iio/adc. The closest drivers to
> >the device mentioned are in hwmon.
> >
> >Where is the best place for this new ADC driver?
> 
> Your call. You could add support for the chip to hwmon/ads1015.c, or you could write
> a new driver in iio/adc. If you do the latter, maybe you can also include support
> for ads1015 and ads1115, so we can ultimately remove the ads1015 driver from hwmon.

Guenter,

Though the iio route may be more work I have a feeling the
driver will be better off there. The use of regmap support
should allow for both the SPI and I2C version to coexist.

I will try my best to implement the driver in a way that
can cover these other I2C devices mentioned.

> 
> >Shouldn't ADCs all be in the same subsystem?
> >Has there been any effort to unify or distiguish where drivers should go?
> >
> In general, ADCs primarily used for the purpose of ADC measurements would go
> into iio, and ADCs used primarily for hardware monitoring would go into hwmon.
> 
> There are no strict rules, though, and this is not always black-and-white.
> I am sure there are some drivers in hwmon which would be better suited for iio.
> Primarily that would be the case because the iio subsystem is relatively new,
> and such drivers did not have a home other than hwmon until a couple of years ago.
> If you find any drivers in hwmon which you think should be moved, please feel free
> to do the conversion.

Has anyone considered an alternative implementation for generic ADCs?

I was thinking about an implementation similar to gpiolib whereas ADCs can be
resources for other drivers.

For instance, ADC lines could be registered to a joystick driver and used to provide
analog stick or pressure sensitive button. Another example could be registering analog
lines for an analog accelerometer driver.

Is this a bad idea?

-Michael

> 
> Guenter
> 
