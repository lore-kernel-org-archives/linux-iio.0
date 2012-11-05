Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-191.synserver.de ([212.40.185.191]:1068 "EHLO
	smtp-out-191.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab2KEJ5G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 Nov 2012 04:57:06 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/7] staging:iio:ad7887: Allow to use internal ref in two channel mode
Date: Mon,  5 Nov 2012 10:56:44 +0100
Message-Id: <1352109406-7206-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1352109406-7206-1-git-send-email-lars@metafoo.de>
References: <1352109406-7206-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

While it is not recommended to use the internal reference in two channel mode in
order to obtain optimal performance it is still possible to use it.

While we are at it also get rid of the duplicate tx_cmd_buf entries. There are
only two unique entries. One for channel 1 and one for channel 2.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7887.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7887.c b/drivers/staging/iio/adc/ad7887.c
index 88ffc46..3ac0c30 100644
--- a/drivers/staging/iio/adc/ad7887.c
+++ b/drivers/staging/iio/adc/ad7887.c
@@ -59,7 +59,7 @@ struct ad7887_state {
 	struct spi_transfer		xfer[4];
 	struct spi_message		msg[3];
 	struct spi_message		*ring_msg;
-	unsigned char			tx_cmd_buf[8];
+	unsigned char			tx_cmd_buf[4];
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -238,6 +238,7 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 	struct ad7887_platform_data *pdata = spi->dev.platform_data;
 	struct ad7887_state *st;
 	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
+	uint8_t mode;
 	int ret;
 
 	if (indio_dev == NULL)
@@ -271,9 +272,13 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 
 	/* Setup default message */
 
-	st->tx_cmd_buf[0] = AD7887_CH_AIN0 | AD7887_PM_MODE4 |
-			    ((pdata && pdata->use_onchip_ref) ?
-			    0 : AD7887_REF_DIS);
+	mode = AD7887_PM_MODE4;
+	if (!pdata || !pdata->use_onchip_ref)
+		mode |= AD7887_REF_DIS;
+	if (pdata && pdata->en_dual)
+		mode |= AD7887_DUAL;
+
+	st->tx_cmd_buf[0] = AD7887_CH_AIN0 | mode;
 
 	st->xfer[0].rx_buf = &st->data[0];
 	st->xfer[0].tx_buf = &st->tx_cmd_buf[0];
@@ -283,29 +288,22 @@ static int __devinit ad7887_probe(struct spi_device *spi)
 	spi_message_add_tail(&st->xfer[0], &st->msg[AD7887_CH0]);
 
 	if (pdata && pdata->en_dual) {
-		st->tx_cmd_buf[0] |= AD7887_DUAL | AD7887_REF_DIS;
-
-		st->tx_cmd_buf[2] = AD7887_CH_AIN1 | AD7887_DUAL |
-				    AD7887_REF_DIS | AD7887_PM_MODE4;
-		st->tx_cmd_buf[4] = AD7887_CH_AIN0 | AD7887_DUAL |
-				    AD7887_REF_DIS | AD7887_PM_MODE4;
-		st->tx_cmd_buf[6] = AD7887_CH_AIN1 | AD7887_DUAL |
-				    AD7887_REF_DIS | AD7887_PM_MODE4;
+		st->tx_cmd_buf[2] = AD7887_CH_AIN1 | mode;
 
 		st->xfer[1].rx_buf = &st->data[0];
 		st->xfer[1].tx_buf = &st->tx_cmd_buf[2];
 		st->xfer[1].len = 2;
 
 		st->xfer[2].rx_buf = &st->data[2];
-		st->xfer[2].tx_buf = &st->tx_cmd_buf[4];
+		st->xfer[2].tx_buf = &st->tx_cmd_buf[0];
 		st->xfer[2].len = 2;
 
 		spi_message_init(&st->msg[AD7887_CH0_CH1]);
 		spi_message_add_tail(&st->xfer[1], &st->msg[AD7887_CH0_CH1]);
 		spi_message_add_tail(&st->xfer[2], &st->msg[AD7887_CH0_CH1]);
 
-		st->xfer[3].rx_buf = &st->data[0];
-		st->xfer[3].tx_buf = &st->tx_cmd_buf[6];
+		st->xfer[3].rx_buf = &st->data[2];
+		st->xfer[3].tx_buf = &st->tx_cmd_buf[2];
 		st->xfer[3].len = 2;
 
 		spi_message_init(&st->msg[AD7887_CH1]);
-- 
1.8.0

