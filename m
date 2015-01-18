Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Kristina =?utf-8?q?Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
Subject: Re: [PATCH 1/4] iio: mxs-lradc: separate touchscreen and buffer virtual channels
Date: Sun, 18 Jan 2015 01:19:04 +0100
Cc: Jonathan Cameron <jic23@kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>,
 "Lars-Peter Clausen" <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Juergen Beisert <jbe@pengutronix.de>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com> <1421454131-3501-2-git-send-email-kristina.martsenko@gmail.com>
In-Reply-To: <1421454131-3501-2-git-send-email-kristina.martsenko@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201501180119.04510.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Saturday, January 17, 2015 at 01:22:08 AM, Kristina Mart=C5=A1enko wrote:

Hi!

Good stuff, thank you! Just minor nitpicks below.

[...]

> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index e0e91836eec1..fc65cd311be9
> 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -214,11 +214,14 @@ struct mxs_lradc {
>  	unsigned long		is_divided;
>=20
>  	/*
> -	 * Touchscreen LRADC channels receives a private slot in the CTRL4
> -	 * register, the slot #7. Therefore only 7 slots instead of 8 in the
> -	 * CTRL4 register can be mapped to LRADC channels when using the
> -	 * touchscreen.
> -	 *
> +	 * When the touchscreen is enabled, we give it two private virtual
> +	 * channels: #6 and #7. This means that only 6 virtual channels (instead
> +	 * of 8) will be available for buffered capture.
> +	 */
> +#define TS_VCH1		7
> +#define TS_VCH2		6

Please use a bit more explicit name for the macro, it's really not clear wh=
at
the macro represents from it's name. Something like TOUCHSCREEN_VCHANNEL1 m=
ight
work better for example. What do you think ?

> +
> +	/*
>  	 * Furthermore, certain LRADC channels are shared between touchscreen
>  	 * and/or touch-buttons and generic LRADC block. Therefore when using
>  	 * either of these, these channels are not available for the regular
[...]

I also have a general question/idea here, it's explicitly not something I'd=
 like
to force upon you to implement. I see we have some kind of a hardware, whic=
h can
sample up-to N inputs in parallel . Each input is muxed between M possible=
=20
sources . Is such a thing common in the ADC/DAC world ? Would it be worth to
implement generic helper to handle this kind of a N:M mapping ? What do you=
 all
think please ?

Best regards,
Marek Vasut
