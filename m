Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:6410 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191AbcERPBz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 May 2016 11:01:55 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Ge Gao <ggao@invensense.com>, Peter Rosin <peda@axentia.se>,
	linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: [PATCH v2 6/7] iio: inv_mpu6050: Reformat sample for active scan mask
Date: Wed, 18 May 2016 18:00:53 +0300
Message-Id: <7df4b331d35e3e6a19d13ccbcb5d12f0347b660c.1463582011.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1463582011.git.leonard.crestez@intel.com>
References: <cover.1463582011.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1463582011.git.leonard.crestez@intel.com>
References: <cover.1463582011.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Right now it is possible to only enable some of the x/y/z channels, for
example you can enable accel_z without x or y but if you actually do
that what you get is actually only the x channel.

Fix this by reformatting the hardware sample to only include the
requested channels.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |   8 +++
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 107 ++++++++++++++++++++++++++++-
 2 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 85f9b50..ec1401d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -152,6 +152,11 @@ struct inv_mpu6050_state {
 	/* Value of I2C_MST_STATUS after slv4_done */
 	u8 slv4_done_status;
 #endif
+
+#define INV_MPU6050_MAX_SCAN_ELEMENTS 7
+	unsigned int scan_offsets[INV_MPU6050_MAX_SCAN_ELEMENTS];
+	unsigned int scan_lengths[INV_MPU6050_MAX_SCAN_ELEMENTS];
+	bool realign_required;
 };
 
 /*register and associated bit definition*/
@@ -274,6 +279,9 @@ enum inv_mpu6050_scan {
 	INV_MPU6050_SCAN_TIMESTAMP,
 };
 
+#define INV_MPU6050_SCAN_MASK_ACCEL    0x07
+#define INV_MPU6050_SCAN_MASK_GYRO     0x38
+
 enum inv_mpu6050_filter_e {
 	INV_MPU6050_FILTER_256HZ_NOLPF2 = 0,
 	INV_MPU6050_FILTER_188HZ,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 56ee1e2..49e503c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -24,6 +24,90 @@
 #include <linux/spi/spi.h>
 #include "inv_mpu_iio.h"
 
+static void inv_mpu_get_scan_offsets(
+		struct iio_dev *indio_dev,
+		const unsigned long *mask,
+		const unsigned int masklen,
+		unsigned int *scan_offsets)
+{
+	unsigned int pos = 0;
+
+	if (*mask & INV_MPU6050_SCAN_MASK_ACCEL) {
+		scan_offsets[INV_MPU6050_SCAN_ACCL_X] = pos + 0;
+		scan_offsets[INV_MPU6050_SCAN_ACCL_Y] = pos + 2;
+		scan_offsets[INV_MPU6050_SCAN_ACCL_Z] = pos + 4;
+		pos += 6;
+	}
+	if (*mask & INV_MPU6050_SCAN_MASK_GYRO) {
+		scan_offsets[INV_MPU6050_SCAN_GYRO_X] = pos + 0;
+		scan_offsets[INV_MPU6050_SCAN_GYRO_Y] = pos + 2;
+		scan_offsets[INV_MPU6050_SCAN_GYRO_Z] = pos + 4;
+		pos += 6;
+	}
+}
+
+/* This is slowish but relatively common */
+static const struct iio_chan_spec *
+iio_chan_by_scan_index(struct iio_dev *indio_dev, int index)
+{
+	int i;
+
+	for (i = 0; i < indio_dev->num_channels; ++i)
+		if (indio_dev->channels[i].scan_index == index)
+			return &indio_dev->channels[i];
+
+	return NULL;
+}
+
+static int iio_check_scan_offsets_aligned(
+		struct iio_dev *indio_dev,
+		const unsigned long *mask,
+		unsigned int masklen,
+		unsigned int *scan_offsets)
+{
+	int scan_index;
+	unsigned int pos = 0;
+	const struct iio_chan_spec *chan;
+
+	for_each_set_bit(scan_index, mask, masklen) {
+		chan = iio_chan_by_scan_index(indio_dev, scan_index);
+		if (scan_offsets[scan_index] != pos)
+			return false;
+		pos = ALIGN(pos + chan->scan_type.storagebits / 8,
+			    chan->scan_type.storagebits / 8);
+	}
+
+	return true;
+}
+
+static void iio_get_scan_lengths(struct iio_dev *indio_dev, unsigned int *scan_length)
+{
+	int i;
+	const struct iio_chan_spec *chan;
+
+	for (i = 0; i < indio_dev->num_channels; ++i) {
+		chan = &indio_dev->channels[i];
+		if (chan->scan_index < 0)
+			continue;
+		scan_length[chan->scan_index] = chan->scan_type.storagebits / 8;
+	}
+}
+
+static void iio_realign_sample(
+		struct iio_dev *indio_dev,
+		const u8 *ibuf, u8 *obuf,
+		const unsigned int *scan_offset,
+		const unsigned int *scan_lengths)
+{
+	unsigned int pos = 0;
+	int i;
+
+	for_each_set_bit(i, indio_dev->active_scan_mask, indio_dev->masklength) {
+		memcpy(&obuf[pos], &ibuf[scan_offset[i]], scan_lengths[i]);
+		pos = ALIGN(pos + scan_lengths[i], scan_lengths[i]);
+	}
+}
+
 static void inv_clear_kfifo(struct inv_mpu6050_state *st)
 {
 	unsigned long flags;
@@ -38,7 +122,9 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 {
 	int result;
 	u8 d;
-	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	const unsigned long *mask = indio_dev->active_scan_mask;
+	unsigned int masklen = indio_dev->masklength;
 
 	/* disable interrupt */
 	result = regmap_update_bits(st->map, st->reg->int_enable,
@@ -93,6 +179,13 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 	if (result)
 		goto reset_fifo_fail;
 
+	/* check realign required */
+	inv_mpu_get_scan_offsets(indio_dev, mask, masklen, st->scan_offsets);
+	st->realign_required = !iio_check_scan_offsets_aligned(
+			indio_dev, mask, masklen, st->scan_offsets);
+	if (st->realign_required)
+		iio_get_scan_lengths(indio_dev, st->scan_lengths);
+
 	return 0;
 
 reset_fifo_fail:
@@ -201,8 +294,16 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		if (result == 0)
 			timestamp = 0;
 
-		result = iio_push_to_buffers_with_timestamp(indio_dev, data,
-							    timestamp);
+		if (st->realign_required) {
+			u8 adata[INV_MPU6050_OUTPUT_DATA_SIZE];
+			iio_realign_sample(indio_dev, data, adata,
+					    st->scan_offsets, st->scan_lengths);
+			result = iio_push_to_buffers_with_timestamp(
+					indio_dev, adata, timestamp);
+		} else {
+			result = iio_push_to_buffers_with_timestamp(
+					indio_dev, data, timestamp);
+		}
 		if (result)
 			goto flush_fifo;
 		fifo_count -= bytes_per_datum;
-- 
2.5.5

