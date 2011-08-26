Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 05/12] staging:iio: Switch the channel masks to bitmaps so as to allow for more channels.
Date: Fri, 26 Aug 2011 11:16:28 +0100
Message-Id: <1314353795-7437-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
References: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This is as light as possible on changes to current drivers.
Some drivers make assumptions that their masks fit in a single
long.  Given they were previously working this is clearly valid if
not tidy.

The max1363 is an example where there should be no such assumptions.

V2: Add the new ad5933

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_ring.c      |    5 +-
 drivers/staging/iio/adc/ad7192.c                |    6 +-
 drivers/staging/iio/adc/ad7298_ring.c           |    4 +-
 drivers/staging/iio/adc/ad7793.c                |   18 +++--
 drivers/staging/iio/adc/ad7887.h                |    4 +-
 drivers/staging/iio/adc/ad7887_ring.c           |   10 ++-
 drivers/staging/iio/adc/ad799x.h                |    4 +-
 drivers/staging/iio/adc/ad799x_core.c           |    2 +-
 drivers/staging/iio/adc/ad799x_ring.c           |   18 ++---
 drivers/staging/iio/adc/max1363.h               |    8 +-
 drivers/staging/iio/adc/max1363_core.c          |   37 +++++----
 drivers/staging/iio/adc/max1363_ring.c          |   22 +++---
 drivers/staging/iio/iio.h                       |    5 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |    2 +-
 drivers/staging/iio/imu/adis16400_ring.c        |    9 +-
 drivers/staging/iio/industrialio-ring.c         |  103 ++++++++++++++++++++++-
 drivers/staging/iio/meter/ade7758.h             |    2 +-
 drivers/staging/iio/meter/ade7758_core.c        |    2 +-
 drivers/staging/iio/meter/ade7758_ring.c        |    2 +-
 drivers/staging/iio/ring_generic.h              |   64 +-------------
 20 files changed, 190 insertions(+), 137 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index d67d783..c816933 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -61,8 +61,9 @@ ssize_t lis3l02dq_read_accel_from_ring(struct iio_ring_buffer *ring,
 	ret = ring->access->read_last(ring, (u8 *)data);
 	if (ret)
 		goto error_free_data;
-	*val = data[bitmap_weight(&ring->scan_mask, index)];
+	*val = data[bitmap_weight(ring->scan_mask, index)];
 error_free_data:
+
 	kfree(data);
 
 	return ret;
@@ -99,7 +100,7 @@ static int lis3l02dq_read_all(struct iio_dev *indio_dev, u8 *rx_array)
 	mutex_lock(&st->buf_lock);
 
 	for (i = 0; i < ARRAY_SIZE(read_all_tx_array)/4; i++)
-		if (ring->scan_mask & (1 << i)) {
+		if (test_bit(i, ring->scan_mask)) {
 			/* lower byte */
 			xfers[j].tx_buf = st->tx + 2*j;
 			st->tx[2*j] = read_all_tx_array[i*4];
diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 80b067c..c67da6a 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -146,7 +146,7 @@ struct ad7192_state {
 	u32				mode;
 	u32				conf;
 	u32				scale_avail[8][2];
-	u32				available_scan_masks[9];
+	long				available_scan_masks[9];
 	u8				gpocon;
 	u8				devid;
 	/*
@@ -460,7 +460,7 @@ static int ad7192_scan_from_ring(struct ad7192_state *st, unsigned ch, int *val)
 	s64 dat64[2];
 	u32 *dat32 = (u32 *)dat64;
 
-	if (!(ring->scan_mask & (1 << ch)))
+	if (!(test_bit(ch, ring->scan_mask)))
 		return  -EBUSY;
 
 	ret = ring->access->read_last(ring, (u8 *) &dat64);
@@ -482,7 +482,7 @@ static int ad7192_ring_preenable(struct iio_dev *indio_dev)
 	if (!ring->scan_count)
 		return -EINVAL;
 
-	channel = __ffs(ring->scan_mask);
+	channel = find_first_bit(ring->scan_mask, indio_dev->masklength);
 
 	d_size = ring->scan_count *
 		 indio_dev->channels[0].scan_type.storagebits / 8;
diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
index 741818c..246b2e7 100644
--- a/drivers/staging/iio/adc/ad7298_ring.c
+++ b/drivers/staging/iio/adc/ad7298_ring.c
@@ -24,7 +24,7 @@ int ad7298_scan_from_ring(struct iio_dev *dev_info, long ch)
 	int ret;
 	u16 *ring_data;
 
-	if (!(ring->scan_mask & (1 << ch))) {
+	if (!(test_bit(ch, ring->scan_mask))) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -79,7 +79,7 @@ static int ad7298_ring_preenable(struct iio_dev *indio_dev)
 	command = AD7298_WRITE | st->ext_ref;
 
 	for (i = 0, m = AD7298_CH(0); i < AD7298_MAX_CHAN; i++, m >>= 1)
-		if (ring->scan_mask & (1 << i))
+		if (test_bit(i, ring->scan_mask))
 			command |= m;
 
 	st->tx_buf[0] = cpu_to_be16(command);
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 38095eb..b42a7ac 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -51,7 +51,8 @@ struct ad7793_state {
 	u16				mode;
 	u16				conf;
 	u32				scale_avail[8][2];
-	u32				available_scan_masks[7];
+	/* Note this uses fact that 8 the mask always fits in a long */
+	unsigned long			available_scan_masks[7];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -321,7 +322,7 @@ static int ad7793_scan_from_ring(struct ad7793_state *st, unsigned ch, int *val)
 	s64 dat64[2];
 	u32 *dat32 = (u32 *)dat64;
 
-	if (!(ring->scan_mask & (1 << ch)))
+	if (!(test_bit(ch, ring->scan_mask)))
 		return  -EBUSY;
 
 	ret = ring->access->read_last(ring, (u8 *) &dat64);
@@ -343,7 +344,8 @@ static int ad7793_ring_preenable(struct iio_dev *indio_dev)
 	if (!ring->scan_count)
 		return -EINVAL;
 
-	channel = __ffs(ring->scan_mask);
+	channel = find_first_bit(ring->scan_mask,
+				 indio_dev->masklength);
 
 	d_size = ring->scan_count *
 		 indio_dev->channels[0].scan_type.storagebits / 8;
@@ -875,10 +877,12 @@ static int __devinit ad7793_probe(struct spi_device *spi)
 	indio_dev->num_channels = 7;
 	indio_dev->info = &ad7793_info;
 
-	for (i = 0; i < indio_dev->num_channels; i++)
-		st->available_scan_masks[i] = (1 << i) | (1 <<
-			indio_dev->channels[indio_dev->num_channels - 1].
-			scan_index);
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		set_bit(i, &st->available_scan_masks[i]);
+		set_bit(indio_dev->
+			channels[indio_dev->num_channels - 1].scan_index,
+			&st->available_scan_masks[i]);
+	}
 
 	init_waitqueue_head(&st->wq_data_avail);
 
diff --git a/drivers/staging/iio/adc/ad7887.h b/drivers/staging/iio/adc/ad7887.h
index 837046c..1b7a772 100644
--- a/drivers/staging/iio/adc/ad7887.h
+++ b/drivers/staging/iio/adc/ad7887.h
@@ -83,11 +83,11 @@ enum ad7887_supported_device_ids {
 };
 
 #ifdef CONFIG_IIO_RING_BUFFER
-int ad7887_scan_from_ring(struct ad7887_state *st, long mask);
+int ad7887_scan_from_ring(struct ad7887_state *st, int channum);
 int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad7887_ring_cleanup(struct iio_dev *indio_dev);
 #else /* CONFIG_IIO_RING_BUFFER */
-static inline int ad7887_scan_from_ring(struct ad7887_state *st, long mask)
+static inline int ad7887_scan_from_ring(struct ad7887_state *st, int channum)
 {
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
index 6b3daf4..36e118c 100644
--- a/drivers/staging/iio/adc/ad7887_ring.c
+++ b/drivers/staging/iio/adc/ad7887_ring.c
@@ -19,13 +19,13 @@
 
 #include "ad7887.h"
 
-int ad7887_scan_from_ring(struct ad7887_state *st, long mask)
+int ad7887_scan_from_ring(struct ad7887_state *st, int channum)
 {
 	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
 	int count = 0, ret;
 	u16 *ring_data;
 
-	if (!(ring->scan_mask & mask)) {
+	if (!(test_bit(channum, ring->scan_mask))) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -41,7 +41,8 @@ int ad7887_scan_from_ring(struct ad7887_state *st, long mask)
 		goto error_free_ring_data;
 
 	/* for single channel scan the result is stored with zero offset */
-	if ((ring->scan_mask == ((1 << 1) | (1 << 0))) && (mask == (1 << 1)))
+	if ((test_bit(1, ring->scan_mask) || test_bit(0, ring->scan_mask)) &&
+	    (channum == 1))
 		count = 1;
 
 	ret = be16_to_cpu(ring_data[count]);
@@ -78,7 +79,8 @@ static int ad7887_ring_preenable(struct iio_dev *indio_dev)
 		indio_dev->ring->access->set_bytes_per_datum(indio_dev->ring,
 							    st->d_size);
 
-	switch (ring->scan_mask) {
+	/* We know this is a single long so can 'cheat' */
+	switch (*ring->scan_mask) {
 	case (1 << 0):
 		st->ring_msg = &st->msg[AD7887_CH0];
 		break;
diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 0dc9b4c..98f06f6 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -124,11 +124,11 @@ struct ad799x_platform_data {
 int ad7997_8_set_scan_mode(struct ad799x_state *st, unsigned mask);
 
 #ifdef CONFIG_AD799X_RING_BUFFER
-int ad799x_single_channel_from_ring(struct ad799x_state *st, long mask);
+int ad799x_single_channel_from_ring(struct ad799x_state *st, int channum);
 int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void ad799x_ring_cleanup(struct iio_dev *indio_dev);
 #else /* CONFIG_AD799X_RING_BUFFER */
-int ad799x_single_channel_from_ring(struct ad799x_state *st, long mask)
+int ad799x_single_channel_from_ring(struct ad799x_state *st, int channum)
 {
 	return -EINVAL;
 }
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index ca2d822..0a80744 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -150,7 +150,7 @@ static int ad799x_read_raw(struct iio_dev *dev_info,
 		mutex_lock(&dev_info->mlock);
 		if (iio_ring_enabled(dev_info))
 			ret = ad799x_single_channel_from_ring(st,
-				1 << chan->address);
+							      chan->address);
 		else
 			ret = ad799x_scan_direct(st, chan->address);
 		mutex_unlock(&dev_info->mlock);
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 8f1fc52..438e81d 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -23,13 +23,13 @@
 
 #include "ad799x.h"
 
-int ad799x_single_channel_from_ring(struct ad799x_state *st, long mask)
+int ad799x_single_channel_from_ring(struct ad799x_state *st, int channum)
 {
 	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
 	int count = 0, ret;
 	u16 *ring_data;
 
-	if (!(ring->scan_mask & mask)) {
+	if (!(test_bit(channum, ring->scan_mask))) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -44,13 +44,7 @@ int ad799x_single_channel_from_ring(struct ad799x_state *st, long mask)
 	if (ret)
 		goto error_free_ring_data;
 	/* Need a count of channels prior to this one */
-	mask >>= 1;
-	while (mask) {
-		if (mask & ring->scan_mask)
-			count++;
-		mask >>= 1;
-	}
-
+	count = bitmap_weight(ring->scan_mask, channum);
 	ret = be16_to_cpu(ring_data[count]);
 
 error_free_ring_data:
@@ -77,7 +71,7 @@ static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 	 */
 
 	if (st->id == ad7997 || st->id == ad7998)
-		ad7997_8_set_scan_mode(st, ring->scan_mask);
+		ad7997_8_set_scan_mode(st, *ring->scan_mask);
 
 	st->d_size = ring->scan_count * 2;
 
@@ -121,12 +115,12 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	case ad7991:
 	case ad7995:
 	case ad7999:
-		cmd = st->config | (ring->scan_mask << AD799X_CHANNEL_SHIFT);
+		cmd = st->config | (*ring->scan_mask << AD799X_CHANNEL_SHIFT);
 		break;
 	case ad7992:
 	case ad7993:
 	case ad7994:
-		cmd = (ring->scan_mask << AD799X_CHANNEL_SHIFT) |
+		cmd = (*ring->scan_mask << AD799X_CHANNEL_SHIFT) |
 			AD7998_CONV_RES_REG;
 		break;
 	case ad7997:
diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
index 360bfc5..cbcb08a 100644
--- a/drivers/staging/iio/adc/max1363.h
+++ b/drivers/staging/iio/adc/max1363.h
@@ -57,6 +57,7 @@
 #define MAX1363_SCAN_MASK			0x60
 #define MAX1363_SE_DE_MASK			0x01
 
+#define MAX1363_MAX_CHANNELS 25
 /**
  * struct max1363_mode - scan mode information
  * @conf:	The corresponding value of the configuration register
@@ -64,7 +65,7 @@
  */
 struct max1363_mode {
 	int8_t		conf;
-	long		modemask;
+	DECLARE_BITMAP(modemask, MAX1363_MAX_CHANNELS);
 };
 
 /* This must be maintained along side the max1363_mode_table in max1363_core */
@@ -145,13 +146,14 @@ struct max1363_state {
 };
 
 const struct max1363_mode
-*max1363_match_mode(u32 mask, const struct max1363_chip_info *ci);
+*max1363_match_mode(unsigned long *mask, const struct max1363_chip_info *ci);
 
 int max1363_set_scan_mode(struct max1363_state *st);
 
 #ifdef CONFIG_MAX1363_RING_BUFFER
 
-int max1363_single_channel_from_ring(long mask, struct max1363_state *st);
+int max1363_single_channel_from_ring(const long *mask,
+				     struct max1363_state *st);
 int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void max1363_ring_cleanup(struct iio_dev *indio_dev);
 
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 5cf8c98..a564a8c 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -41,14 +41,14 @@
 		.conf = MAX1363_CHANNEL_SEL(_num)			\
 			| MAX1363_CONFIG_SCAN_SINGLE_1			\
 			| MAX1363_CONFIG_SE,				\
-			.modemask = _mask,				\
+			.modemask[0] = _mask,				\
 			}
 
 #define MAX1363_MODE_SCAN_TO_CHANNEL(_num, _mask) {			\
 		.conf = MAX1363_CHANNEL_SEL(_num)			\
 			| MAX1363_CONFIG_SCAN_TO_CS			\
 			| MAX1363_CONFIG_SE,				\
-			.modemask = _mask,				\
+			.modemask[0] = _mask,				\
 			}
 
 /* note not available for max1363 hence naming */
@@ -56,14 +56,14 @@
 		.conf = MAX1363_CHANNEL_SEL(_num)			\
 			| MAX1236_SCAN_MID_TO_CHANNEL			\
 			| MAX1363_CONFIG_SE,				\
-			.modemask = _mask				\
+			.modemask[0] = _mask				\
 }
 
 #define MAX1363_MODE_DIFF_SINGLE(_nump, _numm, _mask) {			\
 		.conf = MAX1363_CHANNEL_SEL(_nump)			\
 			| MAX1363_CONFIG_SCAN_SINGLE_1			\
 			| MAX1363_CONFIG_DE,				\
-			.modemask = _mask				\
+			.modemask[0] = _mask				\
 			}
 
 /* Can't think how to automate naming so specify for now */
@@ -71,7 +71,7 @@
 		.conf = MAX1363_CHANNEL_SEL(_num)			\
 			| MAX1363_CONFIG_SCAN_TO_CS			\
 			| MAX1363_CONFIG_DE,				\
-			.modemask = _mask				\
+			.modemask[0] = _mask				\
 			}
 
 /* note only available for max1363 hence naming */
@@ -79,7 +79,7 @@
 		.conf = MAX1363_CHANNEL_SEL(_num)			\
 			| MAX1236_SCAN_MID_TO_CHANNEL			\
 			| MAX1363_CONFIG_SE,				\
-			.modemask = _mask				\
+			.modemask[0] = _mask				\
 }
 
 static const struct max1363_mode max1363_mode_table[] = {
@@ -146,13 +146,15 @@ static const struct max1363_mode max1363_mode_table[] = {
 };
 
 const struct max1363_mode
-*max1363_match_mode(u32 mask, const struct max1363_chip_info *ci)
+*max1363_match_mode(unsigned long *mask, const struct max1363_chip_info *ci)
 {
 	int i;
 	if (mask)
 		for (i = 0; i < ci->num_modes; i++)
-			if (!((~max1363_mode_table[ci->mode_list[i]].modemask) &
-			      mask))
+			if (bitmap_subset(mask,
+					  max1363_mode_table[ci->mode_list[i]].
+					  modemask,
+					  MAX1363_MAX_CHANNELS))
 				return &max1363_mode_table[ci->mode_list[i]];
 	return NULL;
 }
@@ -186,7 +188,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	int ret = 0;
 	s32 data;
 	char rxbuf[2];
-	long mask;
+	const unsigned long *mask;
 	struct max1363_state *st = iio_priv(indio_dev);
 	struct i2c_client *client = st->client;
 
@@ -643,7 +645,7 @@ static int max1363_monitor_mode_update(struct max1363_state *st, int enabled)
 	int ret, i = 3, j;
 	unsigned long numelements;
 	int len;
-	long modemask;
+	const long *modemask;
 
 	if (!enabled) {
 		/* transition to ring capture is not currently supported */
@@ -671,7 +673,7 @@ static int max1363_monitor_mode_update(struct max1363_state *st, int enabled)
 		st->configbyte |= max1363_mode_table[d1m0to3m2].conf;
 		modemask = max1363_mode_table[d1m0to3m2].modemask;
 	}
-	numelements = hweight_long(modemask);
+	numelements = bitmap_weight(modemask, MAX1363_MAX_CHANNELS);
 	len = 3 * numelements + 3;
 	tx_buf = kmalloc(len, GFP_KERNEL);
 	if (!tx_buf) {
@@ -687,7 +689,7 @@ static int max1363_monitor_mode_update(struct max1363_state *st, int enabled)
 	 * setup to match what we need.
 	 */
 	for (j = 0; j < 8; j++)
-		if (modemask & (1 << j)) {
+		if (test_bit(j, modemask)) {
 			/* Establish the mode is in the scan */
 			if (st->mask_low & (1 << j)) {
 				tx_buf[i] = (st->thresh_low[j] >> 4) & 0xFF;
@@ -1280,7 +1282,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	st->client = client;
 
 	indio_dev->available_scan_masks
-		= kzalloc(sizeof(*indio_dev->available_scan_masks)*
+		= kzalloc(BITS_TO_LONGS(MAX1363_MAX_CHANNELS)*
 			  (st->chip_info->num_modes + 1), GFP_KERNEL);
 	if (!indio_dev->available_scan_masks) {
 		ret = -ENOMEM;
@@ -1288,9 +1290,10 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	}
 
 	for (i = 0; i < st->chip_info->num_modes; i++)
-		indio_dev->available_scan_masks[i] =
-			max1363_mode_table[st->chip_info->mode_list[i]]
-			.modemask;
+		bitmap_copy(indio_dev->available_scan_masks +
+			    BITS_TO_LONGS(MAX1363_MAX_CHANNELS)*i,
+			    max1363_mode_table[st->chip_info->mode_list[i]]
+			    .modemask, MAX1363_MAX_CHANNELS);
 	/* Estabilish that the iio_dev is a child of the i2c device */
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = id->name;
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index be601e0..abe9e03 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -21,12 +21,14 @@
 
 #include "max1363.h"
 
-int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
+int max1363_single_channel_from_ring(const long *mask, struct max1363_state *st)
 {
 	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
-	int count = 0, ret;
+	int count = 0, ret, index;
 	u8 *ring_data;
-	if (!(st->current_mode->modemask & mask)) {
+	index = find_first_bit(mask, MAX1363_MAX_CHANNELS);
+
+	if (!(test_bit(index, st->current_mode->modemask))) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -41,12 +43,8 @@ int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
 	if (ret)
 		goto error_free_ring_data;
 	/* Need a count of channels prior to this one */
-	mask >>= 1;
-	while (mask) {
-		if (mask & st->current_mode->modemask)
-			count++;
-		mask >>= 1;
-	}
+
+	count = bitmap_weight(mask, index - 1);
 	if (st->chip_info->bits != 8)
 		ret = ((int)(ring_data[count*2 + 0] & 0x0F) << 8)
 			+ (int)(ring_data[count*2 + 1]);
@@ -85,7 +83,8 @@ static int max1363_ring_preenable(struct iio_dev *indio_dev)
 
 	max1363_set_scan_mode(st);
 
-	numvals = hweight_long(st->current_mode->modemask);
+	numvals = bitmap_weight(st->current_mode->modemask,
+				indio_dev->masklength);
 	if (ring->access->set_bytes_per_datum) {
 		if (ring->scan_timestamp)
 			d_size += sizeof(s64);
@@ -110,7 +109,8 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
 	__u8 *rxbuf;
 	int b_sent;
 	size_t d_size;
-	unsigned long numvals = hweight_long(st->current_mode->modemask);
+	unsigned long numvals = bitmap_weight(st->current_mode->modemask,
+					      MAX1363_MAX_CHANNELS);
 
 	/* Ensure the timestamp is 8 byte aligned */
 	if (st->chip_info->bits != 8)
diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index daaea94..635fa73 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -272,6 +272,8 @@ struct iio_info {
  * @mlock:		[INTERN] lock used to prevent simultaneous device state
  *			changes
  * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
+ * @masklength:		[INTERN] the length of the mask established from
+ *			channels
  * @trig:		[INTERN] current device trigger (ring buffer modes)
  * @pollfunc:		[DRIVER] function run on trigger being received
  * @channels:		[DRIVER] channel specification structure table
@@ -294,7 +296,8 @@ struct iio_dev {
 	struct iio_ring_buffer		*ring;
 	struct mutex			mlock;
 
-	u32				*available_scan_masks;
+	unsigned long			*available_scan_masks;
+	unsigned			masklength;
 	struct iio_trigger		*trig;
 	struct iio_poll_func		*pollfunc;
 
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 1c1cd8e..e199bbe 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -640,7 +640,7 @@ static void ad5933_work(struct work_struct *work)
 
 	if (status & AD5933_STAT_DATA_VALID) {
 		ad5933_i2c_read(st->client,
-				(ring->scan_mask & (1 << 0)) ?
+				test_bit(1, ring->scan_mask) ?
 				AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DATA,
 				ring->scan_count * 2, (u8 *)buf);
 
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index 3fc2403..1a47d07 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -85,7 +85,7 @@ static int adis16350_spi_read_all(struct device *dev, u8 *rx)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(read_all_tx_array); i++)
-		if (indio_dev->ring->scan_mask & (1 << i)) {
+		if (test_bit(i, indio_dev->ring->scan_mask)) {
 			xfers[j].tx_buf = &read_all_tx_array[i];
 			xfers[j].bits_per_word = 16;
 			xfers[j].len = 2;
@@ -117,7 +117,8 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	int i = 0, j, ret = 0;
 	s16 *data;
 	size_t datasize = ring->access->get_bytes_per_datum(ring);
-	unsigned long mask = ring->scan_mask;
+	/* Asumption that long is enough for maximum channels */
+	unsigned long mask = *ring->scan_mask;
 
 	data = kmalloc(datasize , GFP_KERNEL);
 	if (data == NULL) {
@@ -189,8 +190,8 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	ring->scan_timestamp = true;
 	ring->setup_ops = &adis16400_ring_setup_ops;
 	ring->owner = THIS_MODULE;
-	/* Set default scan mode */
-	ring->scan_mask = st->variant->default_scan_mask;
+	/* Set default scan mode - assumes single long is big enough */
+	*ring->scan_mask = st->variant->default_scan_mask;
 	ring->scan_count = hweight_long(st->variant->default_scan_mask);
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index 23967d4..6f14c0d 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -132,9 +132,7 @@ static ssize_t iio_scan_el_show(struct device *dev,
 
 static int iio_scan_mask_clear(struct iio_ring_buffer *ring, int bit)
 {
-	if (bit > IIO_MAX_SCAN_LENGTH)
-		return -EINVAL;
-	ring->scan_mask &= ~(1 << bit);
+	clear_bit(bit, ring->scan_mask);
 	ring->scan_count--;
 	return 0;
 }
@@ -323,11 +321,27 @@ int iio_ring_buffer_register(struct iio_dev *indio_dev,
 	if (channels) {
 		/* new magic */
 		for (i = 0; i < num_channels; i++) {
+			/* Establish necessary mask length */
+			if (channels[i].scan_index >
+			    (int)indio_dev->masklength - 1)
+				indio_dev->masklength
+					= indio_dev->channels[i].scan_index + 1;
+
 			ret = iio_ring_add_channel_sysfs(indio_dev,
 							 &channels[i]);
 			if (ret < 0)
 				goto error_cleanup_group;
 		}
+		if (indio_dev->masklength && ring->scan_mask == NULL) {
+			ring->scan_mask
+				= kzalloc(sizeof(*ring->scan_mask)*
+					  BITS_TO_LONGS(indio_dev->masklength),
+					  GFP_KERNEL);
+			if (ring->scan_mask == NULL) {
+				ret = -ENOMEM;
+				goto error_cleanup_group;
+			}
+		}
 	}
 
 	return 0;
@@ -343,6 +357,7 @@ EXPORT_SYMBOL(iio_ring_buffer_register);
 
 void iio_ring_buffer_unregister(struct iio_dev *indio_dev)
 {
+	kfree(indio_dev->ring->scan_mask);
 	if (indio_dev->ring->attrs)
 		sysfs_remove_group(&indio_dev->dev.kobj,
 				   indio_dev->ring->attrs);
@@ -539,3 +554,85 @@ int iio_sw_ring_preenable(struct iio_dev *indio_dev)
 	return 0;
 }
 EXPORT_SYMBOL(iio_sw_ring_preenable);
+
+
+/* note NULL used as error indicator as it doesn't make sense. */
+static unsigned long *iio_scan_mask_match(unsigned long *av_masks,
+					  unsigned int masklength,
+					  unsigned long *mask)
+{
+	if (bitmap_empty(mask, masklength))
+		return NULL;
+	while (*av_masks) {
+		if (bitmap_subset(mask, av_masks, masklength))
+			return av_masks;
+		av_masks += BITS_TO_LONGS(masklength);
+	}
+	return NULL;
+}
+
+/**
+ * iio_scan_mask_set() - set particular bit in the scan mask
+ * @ring: the ring buffer whose scan mask we are interested in
+ * @bit: the bit to be set.
+ **/
+int iio_scan_mask_set(struct iio_ring_buffer *ring, int bit)
+{
+	struct iio_dev *dev_info = ring->indio_dev;
+	unsigned long *mask;
+	unsigned long *trialmask;
+
+	trialmask = kmalloc(sizeof(*trialmask)*
+			    BITS_TO_LONGS(dev_info->masklength),
+			    GFP_KERNEL);
+
+	if (trialmask == NULL)
+		return -ENOMEM;
+	if (!dev_info->masklength) {
+		WARN_ON("trying to set scan mask prior to registering ring\n");
+		kfree(trialmask);
+		return -EINVAL;
+	}
+	bitmap_copy(trialmask, ring->scan_mask, dev_info->masklength);
+	set_bit(bit, trialmask);
+
+	if (dev_info->available_scan_masks) {
+		mask = iio_scan_mask_match(dev_info->available_scan_masks,
+					   dev_info->masklength,
+					   trialmask);
+		if (!mask) {
+			kfree(trialmask);
+			return -EINVAL;
+		}
+	}
+	bitmap_copy(ring->scan_mask, trialmask, dev_info->masklength);
+	ring->scan_count++;
+
+	kfree(trialmask);
+
+	return 0;
+};
+EXPORT_SYMBOL_GPL(iio_scan_mask_set);
+
+int iio_scan_mask_query(struct iio_ring_buffer *ring, int bit)
+{
+	struct iio_dev *dev_info = ring->indio_dev;
+	long *mask;
+
+	if (bit > dev_info->masklength)
+		return -EINVAL;
+
+	if (!ring->scan_mask)
+		return 0;
+	if (dev_info->available_scan_masks)
+		mask = iio_scan_mask_match(dev_info->available_scan_masks,
+					   dev_info->masklength,
+					   ring->scan_mask);
+	else
+		mask = ring->scan_mask;
+	if (!mask)
+		return 0;
+
+	return test_bit(bit, mask);
+};
+EXPORT_SYMBOL_GPL(iio_scan_mask_query);
diff --git a/drivers/staging/iio/meter/ade7758.h b/drivers/staging/iio/meter/ade7758.h
index 4d73e1a..20a2bca 100644
--- a/drivers/staging/iio/meter/ade7758.h
+++ b/drivers/staging/iio/meter/ade7758.h
@@ -122,7 +122,7 @@ struct ade7758_state {
 	u8			*tx;
 	u8			*rx;
 	struct mutex		buf_lock;
-	u32			available_scan_masks[AD7758_NUM_WAVESRC];
+	unsigned long		available_scan_masks[AD7758_NUM_WAVESRC];
 	struct iio_chan_spec	*ade7758_ring_channels;
 	struct spi_transfer	ring_xfer[4];
 	struct spi_message	ring_msg;
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 151b28f..13a7e9f 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -766,7 +766,7 @@ static int __devinit ade7758_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	for (i = 0; i < AD7758_NUM_WAVESRC; i++)
-		st->available_scan_masks[i] = 1 << i;
+		set_bit(i, &st->available_scan_masks[i]);
 
 	indio_dev->available_scan_masks = st->available_scan_masks;
 
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 5e740e3..9934f50 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -98,7 +98,7 @@ static int ade7758_ring_preenable(struct iio_dev *indio_dev)
 	if (!ring->scan_count)
 		return -EINVAL;
 
-	channel = __ffs(ring->scan_mask);
+	channel = find_first_bit(ring->scan_mask, indio_dev->masklength);
 
 	d_size = st->ade7758_ring_channels[channel].scan_type.storagebits / 8;
 
diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index 25aacf3..7a47f62 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -104,7 +104,7 @@ struct iio_ring_buffer {
 	int					bpe;
 	struct attribute_group			*scan_el_attrs;
 	int					scan_count;
-	unsigned long				scan_mask;
+	long					*scan_mask;
 	bool					scan_timestamp;
 	const struct iio_ring_access_funcs	*access;
 	const struct iio_ring_setup_ops		*setup_ops;
@@ -124,6 +124,8 @@ struct iio_ring_buffer {
 void iio_ring_buffer_init(struct iio_ring_buffer *ring,
 			  struct iio_dev *dev_info);
 
+void iio_ring_buffer_deinit(struct iio_ring_buffer *ring);
+
 /**
  * __iio_update_ring_buffer() - update common elements of ring buffers
  * @ring:		ring buffer that is the event source
@@ -137,70 +139,14 @@ static inline void __iio_update_ring_buffer(struct iio_ring_buffer *ring,
 	ring->length = length;
 }
 
-/*
- * These are mainly provided to allow for a change of implementation if a device
- * has a large number of scan elements
- */
-#define IIO_MAX_SCAN_LENGTH 31
-
-/* note 0 used as error indicator as it doesn't make sense. */
-static inline u32 iio_scan_mask_match(u32 *av_masks, u32 mask)
-{
-	while (*av_masks) {
-		if (!(~*av_masks & mask))
-			return *av_masks;
-		av_masks++;
-	}
-	return 0;
-}
-
-static inline int iio_scan_mask_query(struct iio_ring_buffer *ring, int bit)
-{
-	struct iio_dev *dev_info = ring->indio_dev;
-	u32 mask;
-
-	if (bit > IIO_MAX_SCAN_LENGTH)
-		return -EINVAL;
-
-	if (!ring->scan_mask)
-		return 0;
-
-	if (dev_info->available_scan_masks)
-		mask = iio_scan_mask_match(dev_info->available_scan_masks,
-					ring->scan_mask);
-	else
-		mask = ring->scan_mask;
-
-	if (!mask)
-		return -EINVAL;
-
-	return !!(mask & (1 << bit));
-};
+int iio_scan_mask_query(struct iio_ring_buffer *ring, int bit);
 
 /**
  * iio_scan_mask_set() - set particular bit in the scan mask
  * @ring: the ring buffer whose scan mask we are interested in
  * @bit: the bit to be set.
  **/
-static inline int iio_scan_mask_set(struct iio_ring_buffer *ring, int bit)
-{
-	struct iio_dev *dev_info = ring->indio_dev;
-	u32 mask;
-	u32 trialmask = ring->scan_mask | (1 << bit);
-
-	if (bit > IIO_MAX_SCAN_LENGTH)
-		return -EINVAL;
-	if (dev_info->available_scan_masks) {
-		mask = iio_scan_mask_match(dev_info->available_scan_masks,
-					trialmask);
-		if (!mask)
-			return -EINVAL;
-	}
-	ring->scan_mask = trialmask;
-	ring->scan_count++;
-
-	return 0;
-};
+int iio_scan_mask_set(struct iio_ring_buffer *ring, int bit);
 
 #define to_iio_ring_buffer(d)				\
 	container_of(d, struct iio_ring_buffer, dev)
-- 
1.7.3.4
