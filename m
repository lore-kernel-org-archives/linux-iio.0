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
Subject: [PATCH 3/4] iio: mxs-lradc: make ADC reads not unschedule touchscreen conversions
Date: Sat, 17 Jan 2015 02:22:10 +0200
Message-Id: <1421454131-3501-4-git-send-email-kristina.martsenko@gmail.com>
In-Reply-To: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com>
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Reading a channel through sysfs, or starting a buffered capture, can
occasionally turn off the touchscreen.

This is because the read_raw() and buffer preenable()/postdisable()
callbacks unschedule current conversions on all channels. If a delay
channel happens to schedule a touchscreen conversion at the same time,
the conversion gets cancelled and the touchscreen sequence stops.

This is probably related to this note from the reference manual:

	"If a delay group schedules channels to be sampled and a manual
	write to the schedule field in CTRL0 occurs while the block is
	discarding samples, the LRADC will switch to the new schedule
	and will not sample the channels that were previously scheduled.
	The time window for this to happen is very small and lasts only
	while the LRADC is discarding samples."

So make the callbacks only unschedule conversions for the channels they
use. This means channel 0 for read_raw() and channels 0-5 for the buffer
(if the touchscreen is enabled). Since the touchscreen uses different
channels (6 and 7), it no longer gets turned off.

This is tested and fixes the issue on i.MX28, but hasn't been tested on
i.MX23.

Signed-off-by: Kristina Martšenko <kristina.martsenko@gmail.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 0cf276ff0dc5..5b5cb205b9ed 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -825,7 +825,7 @@ static int mxs_lradc_read_single(struct iio_dev *iio_dev, int chan, int *val)
 	if (lradc->soc == IMX28_LRADC)
 		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ_EN(0),
 			LRADC_CTRL1);
-	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
+	mxs_lradc_reg_clear(lradc, 0x1, LRADC_CTRL0);
 
 	/* Enable / disable the divider per requirement */
 	if (test_bit(chan, &lradc->is_divided))
@@ -1273,7 +1273,7 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
 		mxs_lradc_reg_clear(lradc,
 			lradc->buffer_vchans << LRADC_CTRL1_LRADC_IRQ_EN_OFFSET,
 			LRADC_CTRL1);
-	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
+	mxs_lradc_reg_clear(lradc, lradc->buffer_vchans, LRADC_CTRL0);
 
 	for_each_set_bit(chan, iio->active_scan_mask, LRADC_MAX_TOTAL_CHANS) {
 		ctrl4_set |= chan << LRADC_CTRL4_LRADCSELECT_OFFSET(ofs);
@@ -1306,7 +1306,7 @@ static int mxs_lradc_buffer_postdisable(struct iio_dev *iio)
 	mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |
 					LRADC_DELAY_KICK, LRADC_DELAY(0));
 
-	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
+	mxs_lradc_reg_clear(lradc, lradc->buffer_vchans, LRADC_CTRL0);
 	if (lradc->soc == IMX28_LRADC)
 		mxs_lradc_reg_clear(lradc,
 			lradc->buffer_vchans << LRADC_CTRL1_LRADC_IRQ_EN_OFFSET,
-- 
2.2.0
