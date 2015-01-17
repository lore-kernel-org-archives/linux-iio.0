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
Subject: [PATCH 2/4] iio: mxs-lradc: make ADC reads not disable touchscreen interrupts
Date: Sat, 17 Jan 2015 02:22:09 +0200
Message-Id: <1421454131-3501-3-git-send-email-kristina.martsenko@gmail.com>
In-Reply-To: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com>
References: <1421454131-3501-1-git-send-email-kristina.martsenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Reading a channel through sysfs, or starting a buffered capture, will
currently turn off the touchscreen. This is because the read_raw() and
buffer preenable()/postdisable() callbacks disable interrupts for all
LRADC channels, including those the touchscreen uses.

So make the callbacks only disable interrupts for the channels they use.
This means channel 0 for read_raw() and channels 0-5 for the buffer (if
the touchscreen is enabled). Since the touchscreen uses different
channels (6 and 7), it no longer gets turned off.

Note that only i.MX28 is affected by this issue, i.MX23 should be fine.

Signed-off-by: Kristina Martšenko <kristina.martsenko@gmail.com>
---
 drivers/staging/iio/adc/mxs-lradc.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index fc65cd311be9..0cf276ff0dc5 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -218,8 +218,11 @@ struct mxs_lradc {
 	 * channels: #6 and #7. This means that only 6 virtual channels (instead
 	 * of 8) will be available for buffered capture.
 	 */
-#define TS_VCH1		7
-#define TS_VCH2		6
+#define TS_VCH1				7
+#define TS_VCH2				6
+#define BUFFER_VCHANS_LIMITED		0x3f
+#define BUFFER_VCHANS_ALL		0xff
+	u8			buffer_vchans;
 
 	/*
 	 * Furthermore, certain LRADC channels are shared between touchscreen
@@ -820,7 +823,7 @@ static int mxs_lradc_read_single(struct iio_dev *iio_dev, int chan, int *val)
 	 * used if doing raw sampling.
 	 */
 	if (lradc->soc == IMX28_LRADC)
-		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
+		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ_EN(0),
 			LRADC_CTRL1);
 	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
 
@@ -1267,8 +1270,9 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
 	}
 
 	if (lradc->soc == IMX28_LRADC)
-		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
-							LRADC_CTRL1);
+		mxs_lradc_reg_clear(lradc,
+			lradc->buffer_vchans << LRADC_CTRL1_LRADC_IRQ_EN_OFFSET,
+			LRADC_CTRL1);
 	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
 
 	for_each_set_bit(chan, iio->active_scan_mask, LRADC_MAX_TOTAL_CHANS) {
@@ -1304,8 +1308,9 @@ static int mxs_lradc_buffer_postdisable(struct iio_dev *iio)
 
 	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
 	if (lradc->soc == IMX28_LRADC)
-		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
-					LRADC_CTRL1);
+		mxs_lradc_reg_clear(lradc,
+			lradc->buffer_vchans << LRADC_CTRL1_LRADC_IRQ_EN_OFFSET,
+			LRADC_CTRL1);
 
 	kfree(lradc->buffer);
 	mutex_unlock(&lradc->lock);
@@ -1561,6 +1566,11 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 
 	touch_ret = mxs_lradc_probe_touchscreen(lradc, node);
 
+	if (touch_ret == 0)
+		lradc->buffer_vchans = BUFFER_VCHANS_LIMITED;
+	else
+		lradc->buffer_vchans = BUFFER_VCHANS_ALL;
+
 	/* Grab all IRQ sources */
 	for (i = 0; i < of_cfg->irq_count; i++) {
 		lradc->irq[i] = platform_get_irq(pdev, i);
-- 
2.2.0
