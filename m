Return-Path: <bengardiner@nanometrics.ca>
MIME-Version: 1.0
In-Reply-To: <1290097328-6236-1-git-send-email-michael.hennerich@analog.com>
References: <1290097328-6236-1-git-send-email-michael.hennerich@analog.com>
Date: Fri, 19 Nov 2010 10:25:27 -0500
Message-ID: <AANLkTi=sefrxCJM1n0E_9E4HYzMfuA_F-66evZr794X6@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: adc: Enable driver support for ad7887 AD converter
From: Ben Gardiner <bengardiner@nanometrics.ca>
To: michael.hennerich@analog.com
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Michael,

I'm new to IIO and was reading this post as part of my familiarization
with the framework. I can't really comment on the meat of this work
but I did notice a couple references to 'i2c' in the comments. I hope
you don't mind: I can only contribute this minor nitpick.

On Thu, Nov 18, 2010 at 11:22 AM,  <michael.hennerich@analog.com> wrote:
> [...]
> +static int __devinit ad7887_probe(struct spi_device *spi)
> [...]
> + =A0 =A0 =A0 /* Estabilish that the iio_dev is a child of the i2c device=
 */
> [...]
> +/**
> + * ad7887_poll_func_th() th of trigger launched polling to ring buffer
> + *
> + * As sampling only occurs on i2c comms occuring, leave timestamping unt=
il
> + * then. =A0Some triggers will generate their own time stamp. =A0Current=
ly
> + * there is no way of notifying them when no one cares.
> + **/
> [...]

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
