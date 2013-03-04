Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-112.synserver.de ([212.40.185.112]:1027 "EHLO
	smtp-out-103.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758158Ab3CDT2u (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Mar 2013 14:28:50 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Patrick Vasseur <patrick.vasseur@c-s.fr>,
	Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/3] iio:ad7923: Implement scale reporting
Date: Mon,  4 Mar 2013 20:30:30 +0100
Message-Id: <1362425431-24725-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1362425431-24725-1-git-send-email-lars@metafoo.de>
References: <1362425431-24725-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver already claims to support scale reporting in its channel spec, but
doesn't actually implement this yet. This patch uses the regulator API to get
the reference voltage and calculates the scale based on that. The patch also
moves the global configuration bits into a field in the ad7923_state struct,
since depending on the RANGE bit, the range goes either from 0 to VREF or from 0
to 2 * VREF. So we need to know the setting of the RANGE bit when calculating
the scale.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Patrick Vasseur <patrick.vasseur@c-s.fr>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>

---
Note, the patch assumes that the unit for voltages is millivolt.
---
 drivers/iio/adc/ad7923.c | 60 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 36eee24..11ccc42 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/spi/spi.h>
+#include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/module.h>
@@ -56,6 +57,11 @@ struct ad7923_state {
 	struct spi_transfer		scan_single_xfer[2];
 	struct spi_message		ring_msg;
 	struct spi_message		scan_single_msg;
+
+	struct regulator		*reg;
+
+	unsigned int			settings;
+
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -100,10 +106,9 @@ static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
 
 	len = 0;
 	for_each_set_bit(i, active_scan_mask, AD7923_MAX_CHAN) {
-		cmd = AD7923_WRITE_CR | AD7923_CODING | AD7923_RANGE |
-			AD7923_PM_MODE_WRITE(AD7923_PM_MODE_OPS) |
+		cmd = AD7923_WRITE_CR | AD7923_CHANNEL_WRITE(i) |
 			AD7923_SEQUENCE_WRITE(AD7923_SEQUENCE_OFF) |
-			AD7923_CHANNEL_WRITE(i);
+			st->settings;
 		cmd <<= AD7923_SHIFT_REGISTER;
 		st->tx_buf[len++] = cpu_to_be16(cmd);
 	}
@@ -163,9 +168,9 @@ static int ad7923_scan_direct(struct ad7923_state *st, unsigned ch)
 {
 	int ret, cmd;
 
-	cmd = AD7923_WRITE_CR | AD7923_PM_MODE_WRITE(AD7923_PM_MODE_OPS) |
-		AD7923_SEQUENCE_WRITE(AD7923_SEQUENCE_OFF) | AD7923_CODING |
-		AD7923_CHANNEL_WRITE(ch) | AD7923_RANGE;
+	cmd = AD7923_WRITE_CR | AD7923_CHANNEL_WRITE(ch) |
+		AD7923_SEQUENCE_WRITE(AD7923_SEQUENCE_OFF) |
+		st->settings;
 	cmd <<= AD7923_SHIFT_REGISTER;
 	st->tx_buf[0] = cpu_to_be16(cmd);
 
@@ -176,6 +181,22 @@ static int ad7923_scan_direct(struct ad7923_state *st, unsigned ch)
 	return be16_to_cpu(st->rx_buf[0]);
 }
 
+static int ad7923_get_range(struct ad7923_state *st)
+{
+	int vref;
+
+	vref = regulator_get_voltage(st->reg);
+	if (vref < 0)
+		return vref;
+
+	vref /= 1000;
+
+	if (!(st->settings & AD7923_RANGE))
+		vref *= 2;
+
+	return vref;
+}
+
 static int ad7923_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -203,6 +224,13 @@ static int ad7923_read_raw(struct iio_dev *indio_dev,
 			return -EIO;
 
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		ret = ad7923_get_range(st);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
 	}
 	return -EINVAL;
 }
@@ -227,6 +255,8 @@ static int ad7923_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 
 	st->spi = spi;
+	st->settings = AD7923_CODING | AD7923_RANGE |
+			AD7923_PM_MODE_WRITE(AD7923_PM_MODE_OPS);
 
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->dev.parent = &spi->dev;
@@ -247,10 +277,19 @@ static int ad7923_probe(struct spi_device *spi)
 	spi_message_add_tail(&st->scan_single_xfer[0], &st->scan_single_msg);
 	spi_message_add_tail(&st->scan_single_xfer[1], &st->scan_single_msg);
 
+	st->reg = regulator_get(&spi->dev, "refin");
+	if (IS_ERR(st->reg)) {
+		ret = PTR_ERR(st->reg);
+		goto error_free;
+	}
+	ret = regulator_enable(st->reg);
+	if (ret)
+		goto error_put_reg;
+
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 			&ad7923_trigger_handler, NULL);
 	if (ret)
-		goto error_free;
+		goto error_disable_reg;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -260,6 +299,10 @@ static int ad7923_probe(struct spi_device *spi)
 
 error_cleanup_ring:
 	iio_triggered_buffer_cleanup(indio_dev);
+error_disable_reg:
+	regulator_disable(st->reg);
+error_put_reg:
+	regulator_put(st->reg);
 error_free:
 	iio_device_free(indio_dev);
 
@@ -269,9 +312,12 @@ error_free:
 static int ad7923_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad7923_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
+	regulator_disable(st->reg);
+	regulator_put(st->reg);
 	iio_device_free(indio_dev);
 
 	return 0;
-- 
1.8.0

