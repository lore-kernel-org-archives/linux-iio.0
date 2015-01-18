Return-Path: <stefan.wahren@i2se.com>
Date: Sun, 18 Jan 2015 12:21:17 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
Reply-To: Stefan Wahren <stefan.wahren@i2se.com>
To: =?UTF-8?Q?=22Kristina_Mart=C5=A1enko=22?= <kristina.martsenko@gmail.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, devel@driverdev.osuosl.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Juergen Beisert <jbe@pengutronix.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org, Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>
Message-ID: <496109820.289562.1421580077115.JavaMail.open-xchange@oxbaltgw03.schlund.de>
In-Reply-To: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com>
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com>
Subject: Re: [PATCH 0/4] iio: mxs-lradc: fix interactions between the
 touchscreen and the ADC
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Kristina,

> Kristina Mart=C5=A1enko <kristina.martsenko@gmail.com> hat am 17. Januar =
2015 um
> 01:22 geschrieben:
>
>
> Hi,
>
> These patches fix some issues with using the touchscreen and reading
> other ADC channels at the same time.
>
> The main issue is that the "virtual" channels the touchscreen uses can
> overlap with the channels that the iio buffer is configured to read,
> causing the touchscreen to read those channels instead, and report wrong
> values. Patch #1 fixes that by separating the channels they use.
>
> Patches #2 and #3 stop buffered mode and sysfs reads from disabling the
> touchscreen. Patch #4 keeps the buffer from reporting wrong values when
> the touchscreen is in use.
>
> Note that I've only tested these patches on i.MX28. I checked the i.MX23
> reference manual [1], and there don't seem to be any differences in the
> parts I changed, but it would still be nice if someone could test on
> i.MX23 as well.

i have a iMX233-Olinuxino-MAXI, but no touchscreen. If it does make sense
to you, could you please send me testing instructions and i'll give it a tr=
y?

Stefan

>
> The patches were tested on next-20150113 and rebased onto iio/togreg.
>
> Thanks,
> Kristina
