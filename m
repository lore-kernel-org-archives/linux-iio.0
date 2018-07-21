Return-Path: <SRS0=jEZM=KF=lechnology.com=david@kernel.org>
From: David Lechner <david@lechnology.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: adc: ti-ads7950: allow simultaneous use of buffer and direct mode
Date: Sat, 21 Jul 2018 14:37:34 -0500
Message-Id: <20180721193734.6427-3-david@lechnology.com>
In-Reply-To: <20180721193734.6427-1-david@lechnology.com>
References: <20180721193734.6427-1-david@lechnology.com>
List-ID: <linux-iio@vger.kernel.org>

This modifies the TI ADS7950 A/DC driver to allow the simultaneous use
of both the triggered buffer and reading channels directly (via in-
kernel API or sysfs).

The use case for this is on LEGO MINDSTORMS EV3. Two of the voltage
channels are used in-kernel by a power supply driver, which reads the
values using iio_read_channel_processed(). These channels are only read
at a slow rate (<= 1Hz).  However, we want to be able to read 12 other
channels at the same time using the triggered buffer at a high rate (>=
100Hz).

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/iio/adc/ti-ads7950.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index f08c4de2bd10..eae987bef994 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -60,6 +60,8 @@ struct ti_ads7950_state {
 	unsigned int		vref_mv;
 
 	unsigned int		settings;
+	__be16			single_tx;
+	__be16			single_rx;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -287,18 +289,26 @@ static irqreturn_t ti_ads7950_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int ti_ads7950_scan_direct(struct ti_ads7950_state *st, unsigned int ch)
+static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 {
+	struct ti_ads7950_state *st = iio_priv(indio_dev);
 	int ret, cmd;
 
+	mutex_lock(&indio_dev->mlock);
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
+	mutex_unlock(&indio_dev->mlock);
 
-	return be16_to_cpu(st->rx_buf[0]);
+	return ret;
 }
 
 static int ti_ads7950_get_range(struct ti_ads7950_state *st)
@@ -330,13 +340,7 @@ static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-
-		ret = iio_device_claim_direct_mode(indio_dev);
-		if (ret < 0)
-			return ret;
-
-		ret = ti_ads7950_scan_direct(st, chan->address);
-		iio_device_release_direct_mode(indio_dev);
+		ret = ti_ads7950_scan_direct(indio_dev, chan->address);
 		if (ret < 0)
 			return ret;
 
@@ -402,13 +406,13 @@ static int ti_ads7950_probe(struct spi_device *spi)
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
