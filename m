Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:46847 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbbAYQaJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Jan 2015 11:30:09 -0500
Received: by mail-lb0-f170.google.com with SMTP id w7so4388272lbi.1
        for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2015 08:30:08 -0800 (PST)
From: =?UTF-8?q?Kristina=20Mart=C5=A1enko?=
	<kristina.martsenko@gmail.com>
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
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	=?UTF-8?q?Kristina=20Mart=C5=A1enko?=
	<kristina.martsenko@gmail.com>
Subject: [PATCH v2 2/4] iio: mxs-lradc: make ADC reads not disable touchscreen interrupts
Date: Sun, 25 Jan 2015 18:28:20 +0200
Message-Id: <1422203302-17090-3-git-send-email-kristina.martsenko@gmail.com>
In-Reply-To: <1422203302-17090-1-git-send-email-kristina.martsenko@gmail.com>
References: <1422203302-17090-1-git-send-email-kristina.martsenko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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
Reviewed-by: Marek Vasut <marex@denx.de>
---
 drivers/staging/iio/adc/mxs-lradc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 4e574b76ead0..653af03bc69d 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -220,6 +220,9 @@ struct mxs_lradc {
 	 */
 #define TOUCHSCREEN_VCHANNEL1		7
 #define TOUCHSCREEN_VCHANNEL2		6
+#define BUFFER_VCHANS_LIMITED		0x3f
+#define BUFFER_VCHANS_ALL		0xff
+	u8			buffer_vchans;
 
 	/*
 	 * Furthermore, certain LRADC channels are shared between touchscreen
@@ -819,7 +822,7 @@ static int mxs_lradc_read_single(struct iio_dev *iio_dev, int chan, int *val)
 	 * used if doing raw sampling.
 	 */
 	if (lradc->soc == IMX28_LRADC)
-		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
+		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_LRADC_IRQ_EN(0),
 			LRADC_CTRL1);
 	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
 
@@ -1266,8 +1269,9 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
 	}
 
 	if (lradc->soc == IMX28_LRADC)
-		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
-							LRADC_CTRL1);
+		mxs_lradc_reg_clear(lradc,
+			lradc->buffer_vchans << LRADC_CTRL1_LRADC_IRQ_EN_OFFSET,
+			LRADC_CTRL1);
 	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
 
 	for_each_set_bit(chan, iio->active_scan_mask, LRADC_MAX_TOTAL_CHANS) {
@@ -1303,8 +1307,9 @@ static int mxs_lradc_buffer_postdisable(struct iio_dev *iio)
 
 	mxs_lradc_reg_clear(lradc, 0xff, LRADC_CTRL0);
 	if (lradc->soc == IMX28_LRADC)
-		mxs_lradc_reg_clear(lradc, LRADC_CTRL1_MX28_LRADC_IRQ_EN_MASK,
-					LRADC_CTRL1);
+		mxs_lradc_reg_clear(lradc,
+			lradc->buffer_vchans << LRADC_CTRL1_LRADC_IRQ_EN_OFFSET,
+			LRADC_CTRL1);
 
 	kfree(lradc->buffer);
 	mutex_unlock(&lradc->lock);
@@ -1542,6 +1547,11 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 
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

