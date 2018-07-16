Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:55068 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbeGQAFt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Jul 2018 20:05:49 -0400
From: David Lechner <david@lechnology.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ti-ads7950: allow simultaneous use of buffer and direct mode
Date: Mon, 16 Jul 2018 18:35:50 -0500
Message-Id: <20180716233550.6449-1-david@lechnology.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This modifies the TI ADS7950 A/DC driver to allow the simultaneous use
of both the triggered buffer and reading channels directly (via in-
kernel API or sysfs).

The use case for this is on LEGO MINDSTORMS EV3. Two of the voltage
channels are used in-kernel by a power supply driver, which reads the
values using iio_read_channel_processed(). These channels are only read
at a slow rate (<= 1Hz).  However, we want to be able to read 12 other
channels at the same time using the triggered buffer at a high rate (>=
100Hz) without breaking the power supply driver.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/iio/adc/ti-ads7950.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 0225c1b333ab..ba7e5a027490 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -58,6 +58,7 @@
 	(((val) >> (dec)) & ((1 << (bits)) - 1))
 
 struct ti_ads7950_state {
+	struct iio_dev		*indio_dev;
 	struct spi_device	*spi;
 	struct spi_transfer	ring_xfer[TI_ADS7950_MAX_CHAN + 2];
 	struct spi_transfer	scan_single_xfer[3];
@@ -68,6 +69,8 @@ struct ti_ads7950_state {
 	unsigned int		vref_mv;
 
 	unsigned int		settings;
+	__be16			single_tx;
+	__be16			single_rx;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -299,14 +302,21 @@ static int ti_ads7950_scan_direct(struct ti_ads7950_state *st, unsigned int ch)
 {
 	int ret, cmd;
 
+	mutex_lock(&st->indio_dev->mlock);
+
 	cmd = TI_ADS7950_CR_WRITE | TI_ADS7950_CR_CHAN(ch) | st->settings;
-	st->tx_buf[0] = cpu_to_be16(cmd);
+	st->single_tx = cpu_to_be16(cmd);
 
 	ret = spi_sync(st->spi, &st->scan_single_msg);
 	if (ret)
-		return ret;
+		goto out;
+
+	ret = be16_to_cpu(st->single_rx);
+
+out:
+	mutex_unlock(&st->indio_dev->mlock);
 
-	return be16_to_cpu(st->rx_buf[0]);
+		return ret;
 }
 
 static int ti_ads7950_get_range(struct ti_ads7950_state *st)
@@ -338,13 +348,7 @@ static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret < 0)
-			return ret;
-
 		ret = ti_ads7950_scan_direct(st, chan->address);
-		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 
@@ -389,6 +393,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, indio_dev);
 
+	st->indio_dev = indio_dev;
 	st->spi = spi;
 	st->settings = TI_ADS7950_CR_MANUAL | TI_ADS7950_CR_RANGE_5V;
 
@@ -410,13 +415,13 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	 * was read at the end of the first transfer.
 	 */
 
-	st->scan_single_xfer[0].tx_buf = &st->tx_buf[0];
+	st->scan_single_xfer[0].tx_buf = &st->single_tx;
 	st->scan_single_xfer[0].len = 2;
 	st->scan_single_xfer[0].cs_change = 1;
-	st->scan_single_xfer[1].tx_buf = &st->tx_buf[0];
+	st->scan_single_xfer[1].tx_buf = &st->single_tx;
 	st->scan_single_xfer[1].len = 2;
 	st->scan_single_xfer[1].cs_change = 1;
-	st->scan_single_xfer[2].rx_buf = &st->rx_buf[0];
+	st->scan_single_xfer[2].rx_buf = &st->single_rx;
 	st->scan_single_xfer[2].len = 2;
 
 	spi_message_init_with_transfers(&st->scan_single_msg,
-- 
2.17.1

