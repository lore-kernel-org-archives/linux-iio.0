Return-Path: <pmeerw@pmeerw.net>
Date: Sun, 17 Jun 2012 15:18:30 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, omaplinuxkernel@gmail.com, lars@metafoo.de
Subject: Re: [PATCH v3] iio: add vcnl4000 combined ALS and proximity sensor
In-Reply-To: <4FDB323F.4090306@kernel.org>
Message-ID: <alpine.DEB.2.01.1206171500540.8174@pmeerw.net>
References: <1339532615-4511-1-git-send-email-pmeerw@pmeerw.net> <4FDB323F.4090306@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

> Couple of nitpicks inline.  My biggest question about
> this driver is why are you submitting it to staging?
> Can't see any reason it can't go directly into drivers/iio/light.

thank you for reviewing; reason for staging is that I consider the driver 
incomplete because IR current control and proximity thresholding/event 
handling is missing -- I plan to add these as soon as I have figured out 
how to do that properly in IIO; I moved the driver out of staging 
nevertheless

> > +config SENSORS_VCNL4000
> > +	tristate "VCNL4000 combined ALS and proximity sensor"
> How did we end up with that SENSORS prefix.  I think it might be a legacy of
> a few drivers that were intially submitted to hwmon and moved here.
> Probably best to drop it.

drivers/iio/light/Kconfig has CONFIG_SENSORS_LM3533
drivers/staging/iio/light/Kconfig has 3x CONFIG_SENSORS, 2x CONFIG_
drivers/staging/iio/magnetometer has CONFIG_SENSORS_

hwmon/ and misc/ uses CONFIG_SENSORS; I wonder how many sensor drivers do 
not fly SENSORS_?

patch to remove SENSORS_ for IIO is following

> > +		.type = IIO_INTENSITY,
> > +		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
> > +			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
> IIO_INTENSITY was originally introduced because we had a set of light sensors
> where their was no simple relationship between them and anything in SI units.
> If we can convert to illuminance as here via a simple scaling and offset
> then I'd be tempted to make this IIO_LIGHT (and hence illuminance_raw)
> with illuminance_scale and illuminance_offset

I have switched it to IIO_LIGHT, I was taking the conservative route with 
IIO_INTENSITY; I have to trust the data sheet...

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
