Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:38054 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab0IEWUe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Sep 2010 18:20:34 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de, drivers@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/4] staging:iio:adis16350 add non burst buffer fill and fix burst logic
Date: Sun,  5 Sep 2010 23:20:15 +0100
Message-Id: <1283725218-15157-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283725218-15157-1-git-send-email-jic23@cam.ac.uk>
References: <1283725218-15157-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If the adis16350 etc support burst mode it is undocumented and does
not seem to work. Hence this adds an alternate read function.
It also fixes the logic for cases where not all channels are
present in the burst path.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16350.h      |    2 +
 drivers/staging/iio/imu/adis16350_core.c |    9 ++--
 drivers/staging/iio/imu/adis16350_ring.c |   75 +++++++++++++++++++++++++++---
 3 files changed, 75 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16350.h b/drivers/staging/iio/imu/adis16350.h
index b00001e..07d3eeb 100644
--- a/drivers/staging/iio/imu/adis16350.h
+++ b/drivers/staging/iio/imu/adis16350.h
@@ -107,6 +107,7 @@
  * @tx:			transmit buffer
  * @rx:			recieve buffer
  * @buf_lock:		mutex to protect tx and rx
+ * @burst_available:	does the device support burst reading
  **/
 struct adis16350_state {
 	struct spi_device		*us;
@@ -117,6 +118,7 @@ struct adis16350_state {
 	u8				*tx;
 	u8				*rx;
 	struct mutex			buf_lock;
+	unsigned int			burst_available:1;
 };
 
 int adis16350_set_irq(struct device *dev, bool enable);
diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index cc33843..d8181f9 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -615,6 +615,7 @@ static int __devinit adis16350_probe(struct spi_device *spi)
 	}
 	st->us = spi;
 	mutex_init(&st->buf_lock);
+	st->burst_available = spi_get_device_id(spi)->driver_data;
 	/* setup the industrialio driver allocated elements */
 	st->indio_dev = iio_allocate_device();
 	if (st->indio_dev == NULL) {
@@ -722,10 +723,10 @@ static const struct spi_device_id adis16350_id[] = {
 	{"adis16350", 0},
 	{"adis16354", 0},
 	{"adis16355", 0},
-	{"adis16360", 0},
-	{"adis16362", 0},
-	{"adis16364", 0},
-	{"adis16365", 0},
+	{"adis16360", 1},
+	{"adis16362", 1},
+	{"adis16364", 1},
+	{"adis16365", 1},
 	{}
 };
 
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index aefbae5..1970247 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -126,6 +126,56 @@ static int adis16350_spi_read_burst(struct device *dev, u8 *rx)
 	return ret;
 }
 
+static const u16 read_all_tx_array[] = {
+	be16_to_cpu(ADIS16350_READ_REG(ADIS16350_SUPPLY_OUT)),
+	be16_to_cpu(ADIS16350_READ_REG(ADIS16350_XGYRO_OUT)),
+	be16_to_cpu(ADIS16350_READ_REG(ADIS16350_YGYRO_OUT)),
+	be16_to_cpu(ADIS16350_READ_REG(ADIS16350_ZGYRO_OUT)),
+	be16_to_cpu(ADIS16350_READ_REG(ADIS16350_XACCL_OUT)),
+	be16_to_cpu(ADIS16350_READ_REG(ADIS16350_YACCL_OUT)),
+	be16_to_cpu(ADIS16350_READ_REG(ADIS16350_ZACCL_OUT)),
+	be16_to_cpu(ADIS16350_READ_REG(ADIS16350_XTEMP_OUT)),
+	be16_to_cpu(ADIS16350_READ_REG(ADIS16350_YTEMP_OUT)),
+	be16_to_cpu(ADIS16350_READ_REG(ADIS16350_ZTEMP_OUT)),
+	be16_to_cpu(ADIS16350_READ_REG(ADIS16350_AUX_ADC)),
+};
+
+static int adis16350_spi_read_all(struct device *dev, u16 *rx_array)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16350_state *st = iio_dev_get_devdata(indio_dev);
+
+	struct spi_message msg;
+	int i, j = 0, ret;
+	struct spi_transfer *xfers;
+
+	xfers = kzalloc(sizeof(*xfers)*
+			st->indio_dev->ring->scan_count + 1,
+		GFP_KERNEL);
+	if (xfers == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(read_all_tx_array); i++)
+		if (st->indio_dev->ring->scan_mask & (1 << i)) {
+			xfers[j].tx_buf = &read_all_tx_array[i];
+			xfers[j].bits_per_word = 16;
+			xfers[j].len = 2;
+			xfers[j + 1].rx_buf = rx_array + j;
+			j++;
+		}
+	xfers[j].bits_per_word = 16;
+	xfers[j].len = 2;
+
+	spi_message_init(&msg);
+	for (j = 0; j < st->indio_dev->ring->scan_count + 1; j++)
+		spi_message_add_tail(&xfers[j], &msg);
+
+	ret = spi_sync(st->us, &msg);
+	kfree(xfers);
+
+	return ret;
+}
+
 /* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
  * specific to be rolled into the core.
  */
@@ -136,22 +186,33 @@ static void adis16350_trigger_bh_to_ring(struct work_struct *work_s)
 			       work_trigger_to_ring);
 	struct iio_ring_buffer *ring = st->indio_dev->ring;
 
-	int i = 0;
+	int i = 0, j = 0;
 	s16 *data;
 	size_t datasize = ring->access.get_bytes_per_datum(ring);
 
-	data = kmalloc(datasize , GFP_KERNEL);
+	data = kmalloc(datasize, GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return;
 	}
 
-	if (ring->scan_count)
-		if (adis16350_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
+	if (ring->scan_count) {
+		if (st->burst_available) {
+			if (adis16350_spi_read_burst(&st->indio_dev->dev,
+							st->rx) < 0)
+				return;
+		for (; i < ring->scan_count; i++)
+			if (st->indio_dev->ring->scan_mask & (1 << i))
+				data[j++] = le16_to_cpup(
+					(__le16 *)&(st->rx[i*2]));
+		} else {
+			if (adis16350_spi_read_all(&st->indio_dev->dev,
+							(u16 *)st->rx) < 0)
+				return;
 			for (; i < ring->scan_count; i++)
-				data[i] = be16_to_cpup(
-					(__be16 *)&(st->rx[i*2]));
-
+				data[i] = *(u16 *)&(st->rx[i*2]);
+		}
+	}
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
-- 
1.7.0.4

