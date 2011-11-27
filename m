Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 04/16] staging:iio: scrap scan_count and ensure all drivers use active_scan_mask
Date: Sun, 27 Nov 2011 13:33:33 +0000
Message-Id: <1322400825-29400-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1322400825-29400-1-git-send-email-jic23@kernel.org>
References: <1322400825-29400-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

Obviously drivers should only use this for pushing to buffers.
They need buffer->scan_mask for pulling from them post demux.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_ring.c      |   10 +++++-----
 drivers/staging/iio/accel/adis16203_ring.c      |   10 +++++-----
 drivers/staging/iio/accel/adis16204_ring.c      |   10 +++++-----
 drivers/staging/iio/accel/adis16209_ring.c      |    5 +++--
 drivers/staging/iio/accel/adis16240_ring.c      |    5 +++--
 drivers/staging/iio/accel/lis3l02dq_ring.c      |   23 +++++++++++++----------
 drivers/staging/iio/adc/ad7192.c                |   10 ++++++----
 drivers/staging/iio/adc/ad7298_ring.c           |   12 +++++++-----
 drivers/staging/iio/adc/ad7476_ring.c           |    3 ++-
 drivers/staging/iio/adc/ad7793.c                |   11 ++++++-----
 drivers/staging/iio/adc/ad7887_ring.c           |    8 +++++---
 drivers/staging/iio/adc/ad799x_ring.c           |   13 ++++++++-----
 drivers/staging/iio/buffer.h                    |    2 --
 drivers/staging/iio/gyro/adis16260_ring.c       |    5 +++--
 drivers/staging/iio/iio_simple_dummy_buffer.c   |    7 +++++--
 drivers/staging/iio/impedance-analyzer/ad5933.c |   14 ++++++++------
 drivers/staging/iio/imu/adis16400_ring.c        |   19 +++++++++++--------
 drivers/staging/iio/industrialio-buffer.c       |    2 --
 drivers/staging/iio/meter/ade7758_ring.c        |    7 ++++---
 19 files changed, 99 insertions(+), 77 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 936e8cb..68d4b38 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -74,11 +74,11 @@ static irqreturn_t adis16201_trigger_handler(int irq, void *p)
 		return -ENOMEM;
 	}
 
-	if (ring->scan_count)
-		if (adis16201_read_ring_data(indio_dev, st->rx) >= 0)
-			for (; i < ring->scan_count; i++)
-				data[i] = be16_to_cpup(
-					(__be16 *)&(st->rx[i*2]));
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)
+	    && adis16201_read_ring_data(indio_dev, st->rx) >= 0)
+		for (; i < bitmap_weight(indio_dev->active_scan_mask,
+					 indio_dev->masklength); i++)
+			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
diff --git a/drivers/staging/iio/accel/adis16203_ring.c b/drivers/staging/iio/accel/adis16203_ring.c
index d41a50b..0f9d18a 100644
--- a/drivers/staging/iio/accel/adis16203_ring.c
+++ b/drivers/staging/iio/accel/adis16203_ring.c
@@ -74,11 +74,11 @@ static irqreturn_t adis16203_trigger_handler(int irq, void *p)
 		return -ENOMEM;
 	}
 
-	if (ring->scan_count)
-		if (adis16203_read_ring_data(&indio_dev->dev, st->rx) >= 0)
-			for (; i < ring->scan_count; i++)
-				data[i] = be16_to_cpup(
-					(__be16 *)&(st->rx[i*2]));
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength) &&
+	    adis16203_read_ring_data(&indio_dev->dev, st->rx) >= 0)
+		for (; i < bitmap_weight(indio_dev->active_scan_mask,
+					 indio_dev->masklength); i++)
+			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
diff --git a/drivers/staging/iio/accel/adis16204_ring.c b/drivers/staging/iio/accel/adis16204_ring.c
index d05d311..8010c1d 100644
--- a/drivers/staging/iio/accel/adis16204_ring.c
+++ b/drivers/staging/iio/accel/adis16204_ring.c
@@ -71,11 +71,11 @@ static irqreturn_t adis16204_trigger_handler(int irq, void *p)
 		return -ENOMEM;
 	}
 
-	if (ring->scan_count)
-		if (adis16204_read_ring_data(&indio_dev->dev, st->rx) >= 0)
-			for (; i < ring->scan_count; i++)
-				data[i] = be16_to_cpup(
-					(__be16 *)&(st->rx[i*2]));
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength) &&
+	    adis16204_read_ring_data(&indio_dev->dev, st->rx) >= 0)
+		for (; i < bitmap_weight(indio_dev->active_scan_mask,
+					 indio_dev->masklength); i++)
+			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index da9946a..8629fea 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -72,9 +72,10 @@ static irqreturn_t adis16209_trigger_handler(int irq, void *p)
 		return -ENOMEM;
 	}
 
-	if (ring->scan_count &&
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength) &&
 	    adis16209_read_ring_data(&indio_dev->dev, st->rx) >= 0)
-		for (; i < ring->scan_count; i++)
+		for (; i < bitmap_weight(indio_dev->active_scan_mask,
+					 indio_dev->masklength); i++)
 			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
diff --git a/drivers/staging/iio/accel/adis16240_ring.c b/drivers/staging/iio/accel/adis16240_ring.c
index aa215b9..9a3dba2 100644
--- a/drivers/staging/iio/accel/adis16240_ring.c
+++ b/drivers/staging/iio/accel/adis16240_ring.c
@@ -69,9 +69,10 @@ static irqreturn_t adis16240_trigger_handler(int irq, void *p)
 		return -ENOMEM;
 	}
 
-	if (ring->scan_count &&
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength) &&
 	    adis16240_read_ring_data(&indio_dev->dev, st->rx) >= 0)
-		for (; i < ring->scan_count; i++)
+		for (; i < bitmap_weight(indio_dev->active_scan_mask,
+					 indio_dev->masklength); i++)
 			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 1d36050..4d40505 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -87,13 +87,13 @@ static const u8 read_all_tx_array[] = {
  **/
 static int lis3l02dq_read_all(struct iio_dev *indio_dev, u8 *rx_array)
 {
-	struct iio_buffer *buffer = indio_dev->buffer;
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
 	struct spi_transfer *xfers;
 	struct spi_message msg;
 	int ret, i, j = 0;
 
-	xfers = kzalloc((buffer->scan_count) * 2
+	xfers = kzalloc(bitmap_weight(indio_dev->active_scan_mask,
+						 indio_dev->masklength) * 2
 			* sizeof(*xfers), GFP_KERNEL);
 	if (!xfers)
 		return -ENOMEM;
@@ -101,7 +101,7 @@ static int lis3l02dq_read_all(struct iio_dev *indio_dev, u8 *rx_array)
 	mutex_lock(&st->buf_lock);
 
 	for (i = 0; i < ARRAY_SIZE(read_all_tx_array)/4; i++)
-		if (test_bit(i, buffer->scan_mask)) {
+		if (test_bit(i, indio_dev->active_scan_mask)) {
 			/* lower byte */
 			xfers[j].tx_buf = st->tx + 2*j;
 			st->tx[2*j] = read_all_tx_array[i*4];
@@ -129,7 +129,8 @@ static int lis3l02dq_read_all(struct iio_dev *indio_dev, u8 *rx_array)
 	 * values in alternate bytes
 	 */
 	spi_message_init(&msg);
-	for (j = 0; j < buffer->scan_count * 2; j++)
+	for (j = 0; j < bitmap_weight(indio_dev->active_scan_mask,
+				      indio_dev->masklength) * 2; j++)
 		spi_message_add_tail(&xfers[j], &msg);
 
 	ret = spi_sync(st->us, &msg);
@@ -145,14 +146,16 @@ static int lis3l02dq_get_buffer_element(struct iio_dev *indio_dev,
 	int ret, i;
 	u8 *rx_array ;
 	s16 *data = (s16 *)buf;
+	int scan_count = bitmap_weight(indio_dev->active_scan_mask,
+				       indio_dev->masklength);
 
-	rx_array = kzalloc(4 * (indio_dev->buffer->scan_count), GFP_KERNEL);
+	rx_array = kzalloc(4 * scan_count, GFP_KERNEL);
 	if (rx_array == NULL)
 		return -ENOMEM;
 	ret = lis3l02dq_read_all(indio_dev, rx_array);
 	if (ret < 0)
 		return ret;
-	for (i = 0; i < indio_dev->buffer->scan_count; i++)
+	for (i = 0; i < scan_count; i++)
 		data[i] = combine_8_to_16(rx_array[i*4+1],
 					rx_array[i*4+3]);
 	kfree(rx_array);
@@ -175,7 +178,7 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 		return -ENOMEM;
 	}
 
-	if (buffer->scan_count)
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		len = lis3l02dq_get_buffer_element(indio_dev, data);
 
 	  /* Guaranteed to be aligned with 8 byte boundary */
@@ -363,17 +366,17 @@ static int lis3l02dq_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto error_ret;
 
-	if (iio_scan_mask_query(indio_dev->buffer, 0)) {
+	if (test_bit(0, indio_dev->active_scan_mask)) {
 		t |= LIS3L02DQ_REG_CTRL_1_AXES_X_ENABLE;
 		oneenabled = true;
 	} else
 		t &= ~LIS3L02DQ_REG_CTRL_1_AXES_X_ENABLE;
-	if (iio_scan_mask_query(indio_dev->buffer, 1)) {
+	if (test_bit(1, indio_dev->active_scan_mask)) {
 		t |= LIS3L02DQ_REG_CTRL_1_AXES_Y_ENABLE;
 		oneenabled = true;
 	} else
 		t &= ~LIS3L02DQ_REG_CTRL_1_AXES_Y_ENABLE;
-	if (iio_scan_mask_query(indio_dev->buffer, 2)) {
+	if (test_bit(2, indio_dev->active_scan_mask)) {
 		t |= LIS3L02DQ_REG_CTRL_1_AXES_Z_ENABLE;
 		oneenabled = true;
 	} else
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index ad6cef5..1b6ecc8 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -479,12 +479,14 @@ static int ad7192_ring_preenable(struct iio_dev *indio_dev)
 	size_t d_size;
 	unsigned channel;
 
-	if (!ring->scan_count)
+	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
-	channel = find_first_bit(ring->scan_mask, indio_dev->masklength);
+	channel = find_first_bit(indio_dev->active_scan_mask,
+				 indio_dev->masklength);
 
-	d_size = ring->scan_count *
+	d_size = bitmap_weight(indio_dev->active_scan_mask,
+			       indio_dev->masklength) *
 		 indio_dev->channels[0].scan_type.storagebits / 8;
 
 	if (ring->scan_timestamp) {
@@ -544,7 +546,7 @@ static irqreturn_t ad7192_trigger_handler(int irq, void *p)
 	s64 dat64[2];
 	s32 *dat32 = (s32 *)dat64;
 
-	if (ring->scan_count)
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		__ad7192_read_reg(st, 1, 1, AD7192_REG_DATA,
 				  dat32,
 				  indio_dev->channels[0].scan_type.realbits/8);
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 611e212..5695eb2 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -61,8 +61,9 @@ static int ad7298_ring_preenable(struct iio_dev *indio_dev)
 	size_t d_size;
 	int i, m;
 	unsigned short command;
-
-	d_size = ring->scan_count * (AD7298_STORAGE_BITS / 8);
+	int scan_count = bitmap_weight(indio_dev->active_scan_mask,
+				       indio_dev->masklength);
+	d_size = scan_count * (AD7298_STORAGE_BITS / 8);
 
 	if (ring->scan_timestamp) {
 		d_size += sizeof(s64);
@@ -79,7 +80,7 @@ static int ad7298_ring_preenable(struct iio_dev *indio_dev)
 	command = AD7298_WRITE | st->ext_ref;
 
 	for (i = 0, m = AD7298_CH(0); i < AD7298_MAX_CHAN; i++, m >>= 1)
-		if (test_bit(i, ring->scan_mask))
+		if (test_bit(i, indio_dev->active_scan_mask))
 			command |= m;
 
 	st->tx_buf[0] = cpu_to_be16(command);
@@ -96,7 +97,7 @@ static int ad7298_ring_preenable(struct iio_dev *indio_dev)
 	spi_message_add_tail(&st->ring_xfer[0], &st->ring_msg);
 	spi_message_add_tail(&st->ring_xfer[1], &st->ring_msg);
 
-	for (i = 0; i < ring->scan_count; i++) {
+	for (i = 0; i < scan_count; i++) {
 		st->ring_xfer[i + 2].rx_buf = &st->rx_buf[i];
 		st->ring_xfer[i + 2].len = 2;
 		st->ring_xfer[i + 2].cs_change = 1;
@@ -134,7 +135,8 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
 			&time_ns, sizeof(time_ns));
 	}
 
-	for (i = 0; i < ring->scan_count; i++)
+	for (i = 0; i < bitmap_weight(indio_dev->active_scan_mask,
+						 indio_dev->masklength); i++)
 		buf[i] = be16_to_cpu(st->rx_buf[i]);
 
 	indio_dev->buffer->access->store_to(ring, (u8 *)buf, time_ns);
diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
index 2dad7f8..ff0656a 100644
--- a/drivers/staging/iio/adc/ad7476_ring.c
+++ b/drivers/staging/iio/adc/ad7476_ring.c
@@ -56,7 +56,8 @@ static int ad7476_ring_preenable(struct iio_dev *indio_dev)
 	struct ad7476_state *st = iio_priv(indio_dev);
 	struct iio_buffer *ring = indio_dev->buffer;
 
-	st->d_size = ring->scan_count *
+	st->d_size = bitmap_weight(indio_dev->active_scan_mask,
+				   indio_dev->masklength) *
 		st->chip_info->channel[0].scan_type.storagebits / 8;
 
 	if (ring->scan_timestamp) {
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 8a0729c..432f60e 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -342,14 +342,15 @@ static int ad7793_ring_preenable(struct iio_dev *indio_dev)
 	size_t d_size;
 	unsigned channel;
 
-	if (!ring->scan_count)
+	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
-	channel = find_first_bit(ring->scan_mask,
+	channel = find_first_bit(indio_dev->active_scan_mask,
 				 indio_dev->masklength);
 
-	d_size = ring->scan_count *
-		 indio_dev->channels[0].scan_type.storagebits / 8;
+	d_size = bitmap_weight(indio_dev->active_scan_mask,
+			       indio_dev->masklength) *
+		indio_dev->channels[0].scan_type.storagebits / 8;
 
 	if (ring->scan_timestamp) {
 		d_size += sizeof(s64);
@@ -411,7 +412,7 @@ static irqreturn_t ad7793_trigger_handler(int irq, void *p)
 	s64 dat64[2];
 	s32 *dat32 = (s32 *)dat64;
 
-	if (ring->scan_count)
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		__ad7793_read_reg(st, 1, 1, AD7793_REG_DATA,
 				  dat32,
 				  indio_dev->channels[0].scan_type.realbits/8);
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index fee338c..f53a663 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -65,7 +65,8 @@ static int ad7887_ring_preenable(struct iio_dev *indio_dev)
 	struct ad7887_state *st = iio_priv(indio_dev);
 	struct iio_buffer *ring = indio_dev->buffer;
 
-	st->d_size = ring->scan_count *
+	st->d_size = bitmap_weight(indio_dev->active_scan_mask,
+				   indio_dev->masklength) *
 		st->chip_info->channel[0].scan_type.storagebits / 8;
 
 	if (ring->scan_timestamp) {
@@ -80,7 +81,7 @@ static int ad7887_ring_preenable(struct iio_dev *indio_dev)
 			set_bytes_per_datum(indio_dev->buffer, st->d_size);
 
 	/* We know this is a single long so can 'cheat' */
-	switch (*ring->scan_mask) {
+	switch (*indio_dev->active_scan_mask) {
 	case (1 << 0):
 		st->ring_msg = &st->msg[AD7887_CH0];
 		break;
@@ -121,7 +122,8 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 	__u8 *buf;
 	int b_sent;
 
-	unsigned int bytes = ring->scan_count *
+	unsigned int bytes = bitmap_weight(indio_dev->active_scan_mask,
+					   indio_dev->masklength) *
 		st->chip_info->channel[0].scan_type.storagebits / 8;
 
 	buf = kzalloc(st->d_size, GFP_KERNEL);
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 50c1216..5841c3c 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -71,9 +71,10 @@ static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 	 */
 
 	if (st->id == ad7997 || st->id == ad7998)
-		ad7997_8_set_scan_mode(st, *ring->scan_mask);
+		ad7997_8_set_scan_mode(st, *indio_dev->active_scan_mask);
 
-	st->d_size = ring->scan_count * 2;
+	st->d_size = bitmap_weight(indio_dev->active_scan_mask,
+				   indio_dev->masklength) * 2;
 
 	if (ring->scan_timestamp) {
 		st->d_size += sizeof(s64);
@@ -115,12 +116,13 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	case ad7991:
 	case ad7995:
 	case ad7999:
-		cmd = st->config | (*ring->scan_mask << AD799X_CHANNEL_SHIFT);
+		cmd = st->config |
+			(*indio_dev->active_scan_mask << AD799X_CHANNEL_SHIFT);
 		break;
 	case ad7992:
 	case ad7993:
 	case ad7994:
-		cmd = (*ring->scan_mask << AD799X_CHANNEL_SHIFT) |
+		cmd = (*indio_dev->active_scan_mask << AD799X_CHANNEL_SHIFT) |
 			AD7998_CONV_RES_REG;
 		break;
 	case ad7997:
@@ -132,7 +134,8 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	}
 
 	b_sent = i2c_smbus_read_i2c_block_data(st->client,
-			cmd, ring->scan_count * 2, rxbuf);
+			cmd, bitmap_weight(indio_dev->active_scan_mask,
+					   indio_dev->masklength) * 2, rxbuf);
 	if (b_sent < 0)
 		goto done;
 
diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 58c7571..7fc0894 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -73,7 +73,6 @@ struct iio_buffer_access_funcs {
  * @bytes_per_datum:	[DEVICE] size of individual datum including timestamp
  * @scan_el_attrs:	[DRIVER] control of scan elements if that scan mode
  *			control method is used
- * @scan_count:	[INTERN] the number of elements in the current scan mode
  * @scan_mask:		[INTERN] bitmask used in masking scan mode elements
  * @scan_timestamp:	[INTERN] does the scan mode include a timestamp
  * @access:		[DRIVER] buffer access functions associated with the
@@ -88,7 +87,6 @@ struct iio_buffer {
 	int					length;
 	int					bytes_per_datum;
 	struct attribute_group			*scan_el_attrs;
-	int					scan_count;
 	long					*scan_mask;
 	bool					scan_timestamp;
 	unsigned				scan_index_timestamp;
diff --git a/drivers/staging/iio/gyro/adis16260_ring.c b/drivers/staging/iio/gyro/adis16260_ring.c
index 446d78f..88e96af 100644
--- a/drivers/staging/iio/gyro/adis16260_ring.c
+++ b/drivers/staging/iio/gyro/adis16260_ring.c
@@ -74,9 +74,10 @@ static irqreturn_t adis16260_trigger_handler(int irq, void *p)
 		return -ENOMEM;
 	}
 
-	if (ring->scan_count &&
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength) &&
 	    adis16260_read_ring_data(&indio_dev->dev, st->rx) >= 0)
-		for (; i < ring->scan_count; i++)
+		for (; i < bitmap_weight(indio_dev->active_scan_mask,
+					 indio_dev->masklength); i++)
 			data[i] = be16_to_cpup((__be16 *)&(st->rx[i*2]));
 
 	/* Guaranteed to be aligned with 8 byte boundary */
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index ce098be..59e3186 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -57,7 +57,7 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	if (data == NULL)
 		return -ENOMEM;
 
-	if (buffer->scan_count) {
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)) {
 		/*
 		 * Three common options here:
 		 * hardware scans: certain combinations of channels make
@@ -75,7 +75,10 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 		 * in the constant table fakedata.
 		 */
 		int i, j;
-		for (i = 0, j = 0; i < buffer->scan_count; i++) {
+		for (i = 0, j = 0;
+		     i < bitmap_weight(indio_dev->active_scan_mask,
+				       indio_dev->masklength);
+		     i++) {
 			j = find_next_bit(buffer->scan_mask,
 					  indio_dev->masklength, j + 1);
 			/* random access read form the 'device' */
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index b059b78..23241c4 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -537,14 +537,14 @@ static const struct iio_info ad5933_info = {
 static int ad5933_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct ad5933_state *st = iio_priv(indio_dev);
-	struct iio_buffer *ring = indio_dev->buffer;
 	size_t d_size;
 	int ret;
 
-	if (!ring->scan_count)
+	if (bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
-	d_size = ring->scan_count *
+	d_size = bitmap_weight(indio_dev->active_scan_mask,
+			       indio_dev->masklength) *
 		 ad5933_channels[1].scan_type.storagebits / 8;
 
 	if (indio_dev->buffer->access->set_bytes_per_datum)
@@ -640,12 +640,14 @@ static void ad5933_work(struct work_struct *work)
 	ad5933_i2c_read(st->client, AD5933_REG_STATUS, 1, &status);
 
 	if (status & AD5933_STAT_DATA_VALID) {
+		int scan_count = bitmap_weight(indio_dev->active_scan_mask,
+					       indio_dev->masklength);
 		ad5933_i2c_read(st->client,
-				test_bit(1, ring->scan_mask) ?
+				test_bit(1, indio_dev->active_scan_mask) ?
 				AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DATA,
-				ring->scan_count * 2, (u8 *)buf);
+				scan_count * 2, (u8 *)buf);
 
-		if (ring->scan_count == 2) {
+		if (scan_count == 2) {
 			buf[0] = be16_to_cpu(buf[0]);
 			buf[1] = be16_to_cpu(buf[1]);
 		} else {
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index e8aaa84..249d11f 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -79,14 +79,16 @@ static int adis16350_spi_read_all(struct device *dev, u8 *rx)
 	struct spi_message msg;
 	int i, j = 0, ret;
 	struct spi_transfer *xfers;
+	int scan_count = bitmap_weight(indio_dev->active_scan_mask,
+				       indio_dev->masklength);
 
-	xfers = kzalloc(sizeof(*xfers)*indio_dev->buffer->scan_count + 1,
+	xfers = kzalloc(sizeof(*xfers)*(scan_count + 1),
 			GFP_KERNEL);
 	if (xfers == NULL)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(read_all_tx_array); i++)
-		if (test_bit(i, indio_dev->buffer->scan_mask)) {
+		if (test_bit(i, indio_dev->active_scan_mask)) {
 			xfers[j].tx_buf = &read_all_tx_array[i];
 			xfers[j].bits_per_word = 16;
 			xfers[j].len = 2;
@@ -97,7 +99,7 @@ static int adis16350_spi_read_all(struct device *dev, u8 *rx)
 	xfers[j].len = 2;
 
 	spi_message_init(&msg);
-	for (j = 0; j < indio_dev->buffer->scan_count + 1; j++)
+	for (j = 0; j < scan_count + 1; j++)
 		spi_message_add_tail(&xfers[j], &msg);
 
 	ret = spi_sync(st->us, &msg);
@@ -119,26 +121,27 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	s16 *data;
 	size_t datasize = ring->access->get_bytes_per_datum(ring);
 	/* Asumption that long is enough for maximum channels */
-	unsigned long mask = *ring->scan_mask;
-
+	unsigned long mask = *indio_dev->active_scan_mask;
+	int scan_count = bitmap_weight(indio_dev->active_scan_mask,
+				       indio_dev->masklength);
 	data = kmalloc(datasize , GFP_KERNEL);
 	if (data == NULL) {
 		dev_err(&st->us->dev, "memory alloc failed in ring bh");
 		return -ENOMEM;
 	}
 
-	if (ring->scan_count) {
+	if (scan_count) {
 		if (st->variant->flags & ADIS16400_NO_BURST) {
 			ret = adis16350_spi_read_all(&indio_dev->dev, st->rx);
 			if (ret < 0)
 				goto err;
-			for (; i < ring->scan_count; i++)
+			for (; i < scan_count; i++)
 				data[i]	= *(s16 *)(st->rx + i*2);
 		} else {
 			ret = adis16400_spi_read_burst(&indio_dev->dev, st->rx);
 			if (ret < 0)
 				goto err;
-			for (; i < indio_dev->buffer->scan_count; i++) {
+			for (; i < scan_count; i++) {
 				j = __ffs(mask);
 				mask &= ~(1 << j);
 				data[i] = be16_to_cpup(
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index c1c97e1..79f1543 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -138,7 +138,6 @@ static ssize_t iio_scan_el_show(struct device *dev,
 static int iio_scan_mask_clear(struct iio_buffer *buffer, int bit)
 {
 	clear_bit(bit, buffer->scan_mask);
-	buffer->scan_count--;
 	return 0;
 }
 
@@ -613,7 +612,6 @@ int iio_scan_mask_set(struct iio_buffer *buffer, int bit)
 		}
 	}
 	bitmap_copy(buffer->scan_mask, trialmask, indio_dev->masklength);
-	buffer->scan_count++;
 
 	kfree(trialmask);
 
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 464713a..028470c 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -67,7 +67,7 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
 	s64 dat64[2];
 	u32 *dat32 = (u32 *)dat64;
 
-	if (ring->scan_count)
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		if (ade7758_spi_read_burst(&indio_dev->dev) >= 0)
 			*dat32 = get_unaligned_be32(&st->rx_buf[5]) & 0xFFFFFF;
 
@@ -96,10 +96,11 @@ static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 	size_t d_size;
 	unsigned channel;
 
-	if (!ring->scan_count)
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
 		return -EINVAL;
 
-	channel = find_first_bit(ring->scan_mask, indio_dev->masklength);
+	channel = find_first_bit(indio_dev->active_scan_mask,
+				 indio_dev->masklength);
 
 	d_size = st->ade7758_ring_channels[channel].scan_type.storagebits / 8;
 
-- 
1.7.7.3
