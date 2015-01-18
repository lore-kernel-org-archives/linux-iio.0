Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Kristina =?utf-8?q?Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
Subject: Re: [PATCH 2/4] iio: mxs-lradc: make ADC reads not disable touchscreen interrupts
Date: Sun, 18 Jan 2015 01:21:19 +0100
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
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com> <1421454131-3501-3-git-send-email-kristina.martsenko@gmail.com>
In-Reply-To: <1421454131-3501-3-git-send-email-kristina.martsenko@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201501180121.19946.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Saturday, January 17, 2015 at 01:22:09 AM, Kristina Mart=C5=A1enko wrote:
> Reading a channel through sysfs, or starting a buffered capture, will
> currently turn off the touchscreen. This is because the read_raw() and
> buffer preenable()/postdisable() callbacks disable interrupts for all
> LRADC channels, including those the touchscreen uses.
>=20
> So make the callbacks only disable interrupts for the channels they use.
> This means channel 0 for read_raw() and channels 0-5 for the buffer (if
> the touchscreen is enabled). Since the touchscreen uses different
> channels (6 and 7), it no longer gets turned off.
>=20
> Note that only i.MX28 is affected by this issue, i.MX23 should be fine.
>=20
> Signed-off-by: Kristina Mart=C5=A1enko <kristina.martsenko@gmail.com>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index fc65cd311be9..0cf276ff0dc5
> 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -218,8 +218,11 @@ struct mxs_lradc {
>  	 * channels: #6 and #7. This means that only 6 virtual channels (instead
>  	 * of 8) will be available for buffered capture.
>  	 */
> -#define TS_VCH1		7
> -#define TS_VCH2		6
> +#define TS_VCH1				7
> +#define TS_VCH2				6

Please fix the indent in 1/4 , so you don't have to change it again this pa=
tch.

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks!

Best regards,
Marek Vasut
