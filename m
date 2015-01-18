Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Kristina =?utf-8?q?Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
Subject: Re: [PATCH 3/4] iio: mxs-lradc: make ADC reads not unschedule touchscreen conversions
Date: Sun, 18 Jan 2015 01:22:09 +0100
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
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com> <1421454131-3501-4-git-send-email-kristina.martsenko@gmail.com>
In-Reply-To: <1421454131-3501-4-git-send-email-kristina.martsenko@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201501180122.09232.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Saturday, January 17, 2015 at 01:22:10 AM, Kristina Mart=C5=A1enko wrote:
> Reading a channel through sysfs, or starting a buffered capture, can
> occasionally turn off the touchscreen.
>=20
> This is because the read_raw() and buffer preenable()/postdisable()
> callbacks unschedule current conversions on all channels. If a delay
> channel happens to schedule a touchscreen conversion at the same time,
> the conversion gets cancelled and the touchscreen sequence stops.
>=20
> This is probably related to this note from the reference manual:
>=20
> 	"If a delay group schedules channels to be sampled and a manual
> 	write to the schedule field in CTRL0 occurs while the block is
> 	discarding samples, the LRADC will switch to the new schedule
> 	and will not sample the channels that were previously scheduled.
> 	The time window for this to happen is very small and lasts only
> 	while the LRADC is discarding samples."
>=20
> So make the callbacks only unschedule conversions for the channels they
> use. This means channel 0 for read_raw() and channels 0-5 for the buffer
> (if the touchscreen is enabled). Since the touchscreen uses different
> channels (6 and 7), it no longer gets turned off.
>=20
> This is tested and fixes the issue on i.MX28, but hasn't been tested on
> i.MX23.
>=20
> Signed-off-by: Kristina Mart=C5=A1enko <kristina.martsenko@gmail.com>

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
