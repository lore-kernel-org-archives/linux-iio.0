Return-Path: <kristina.martsenko@gmail.com>
From: =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>,
	Juergen Beisert <jbe@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	=?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@gmail.com>
Subject: [PATCH 0/4] iio: mxs-lradc: fix interactions between the touchscreen and the ADC
Date: Sat, 17 Jan 2015 02:22:07 +0200
Message-Id: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi,

These patches fix some issues with using the touchscreen and reading
other ADC channels at the same time.

The main issue is that the "virtual" channels the touchscreen uses can
overlap with the channels that the iio buffer is configured to read,
causing the touchscreen to read those channels instead, and report wrong
values. Patch #1 fixes that by separating the channels they use.

Patches #2 and #3 stop buffered mode and sysfs reads from disabling the
touchscreen. Patch #4 keeps the buffer from reporting wrong values when
the touchscreen is in use.

Note that I've only tested these patches on i.MX28. I checked the i.MX23
reference manual [1], and there don't seem to be any differences in the
parts I changed, but it would still be nice if someone could test on
i.MX23 as well.

The patches were tested on next-20150113 and rebased onto iio/togreg.

Thanks,
Kristina

[1]
i.MX23: http://cache.freescale.com/files/dsp/doc/ref_manual/IMX23RM.pdf
i.MX28: http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf


Kristina Martšenko (4):
  iio: mxs-lradc: separate touchscreen and buffer virtual channels
  iio: mxs-lradc: make ADC reads not disable touchscreen interrupts
  iio: mxs-lradc: make ADC reads not unschedule touchscreen conversions
  iio: mxs-lradc: only update the buffer when its conversions have
    finished

 drivers/staging/iio/adc/mxs-lradc.c | 192 +++++++++++++++++-------------------
 1 file changed, 91 insertions(+), 101 deletions(-)

-- 
2.2.0
