Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41573 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab2FRHiO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2012 03:38:14 -0400
Message-ID: <4FDEDADC.4030704@kernel.org>
Date: Mon, 18 Jun 2012 08:38:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, omaplinuxkernel@gmail.com,
	lars@metafoo.de
Subject: Re: [PATCH v3] iio: add vcnl4000 combined ALS and proximity sensor
References: <1339532615-4511-1-git-send-email-pmeerw@pmeerw.net> <4FDB323F.4090306@kernel.org> <alpine.DEB.2.01.1206171500540.8174@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1206171500540.8174@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/17/2012 2:18 PM, Peter Meerwald wrote:
> Hello,
>
>> Couple of nitpicks inline.  My biggest question about
>> this driver is why are you submitting it to staging?
>> Can't see any reason it can't go directly into drivers/iio/light.
> thank you for reviewing; reason for staging is that I consider the driver
> incomplete because IR current control and proximity thresholding/event
> handling is missing -- I plan to add these as soon as I have figured out
> how to do that properly in IIO; I moved the driver out of staging
> nevertheless
cool.  I'm keen to move everything we possibly can out of staging
(when ready!) to make for a vaguely sensible bit of code management in
the long run.
>
>>> +config SENSORS_VCNL4000
>>> +	tristate "VCNL4000 combined ALS and proximity sensor"
>> How did we end up with that SENSORS prefix.  I think it might be a legacy of
>> a few drivers that were intially submitted to hwmon and moved here.
>> Probably best to drop it.
> drivers/iio/light/Kconfig has CONFIG_SENSORS_LM3533
> drivers/staging/iio/light/Kconfig has 3x CONFIG_SENSORS, 2x CONFIG_
> drivers/staging/iio/magnetometer has CONFIG_SENSORS_
>
> hwmon/ and misc/ uses CONFIG_SENSORS; I wonder how many sensor drivers do
> not fly SENSORS_?
The misc ones are mostly drivers that were initially submitted to hwmon (or
I guess have copied the sensors bit off drivers that were.)  Same is true of
the ones in IIO.
>
> patch to remove SENSORS_ for IIO is following
Be careful with this one, whilst it would be nice, it may break lots of 
peoples config
files.  Probably best to leave be for existing drivers.
>
>>> +		.type = IIO_INTENSITY,
>>> +		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
>>> +			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>> IIO_INTENSITY was originally introduced because we had a set of light sensors
>> where their was no simple relationship between them and anything in SI units.
>> If we can convert to illuminance as here via a simple scaling and offset
>> then I'd be tempted to make this IIO_LIGHT (and hence illuminance_raw)
>> with illuminance_scale and illuminance_offset
> I have switched it to IIO_LIGHT, I was taking the conservative route with
> IIO_INTENSITY; I have to trust the data sheet...
Don't we all from time to time. Sometimes they are even right!
>
> regards, p.
>

