Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Kristina =?utf-8?q?Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
Subject: Re: [PATCH 4/4] iio: mxs-lradc: only update the buffer when its conversions have finished
Date: Sun, 18 Jan 2015 01:23:37 +0100
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
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com> <1421454131-3501-5-git-send-email-kristina.martsenko@gmail.com>
In-Reply-To: <1421454131-3501-5-git-send-email-kristina.martsenko@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201501180123.37397.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

On Saturday, January 17, 2015 at 01:22:11 AM, Kristina Mart=C5=A1enko wrote:
> Using the touchscreen while running buffered capture results in the
> buffer reporting lots of wrong values, often just zeros. This is because
> we push readings to the buffer every time a touchscreen interrupt
> arrives, including when the buffer's own conversions have not yet
> finished. So let's only push to the buffer when its conversions are
> ready.
>=20
> Signed-off-by: Kristina Mart=C5=A1enko <kristina.martsenko@gmail.com>

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
