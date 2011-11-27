Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 14/16] staging:iio:adc:max1363 stop reading from buffer for sysfs access
Date: Sun, 27 Nov 2011 13:33:43 +0000
Message-Id: <1322400825-29400-15-git-send-email-jic23@kernel.org>
In-Reply-To: <1322400825-29400-1-git-send-email-jic23@kernel.org>
References: <1322400825-29400-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

No known use case and makes in kernel interface work more complex.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/max1363.h      |    7 ----
 drivers/staging/iio/adc/max1363_core.c |   51 +++++++++++++------------------
 drivers/staging/iio/adc/max1363_ring.c |   36 ----------------------
 3 files changed, 21 insertions(+), 73 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
index fb52783..2cd0112 100644
--- a/drivers/staging/iio/adc/max1363.h
+++ b/drivers/staging/iio/adc/max1363.h
@@ -154,8 +154,6 @@ int max1363_set_scan_mode(struct max1363_state *st);
 #ifdef CONFIG_MAX1363_RING_BUFFER
 int max1363_update_scan_mode(struct iio_dev *indio_dev,
 			     const unsigned long *scan_mask);
-int max1363_single_channel_from_ring(const long *mask,
-				     struct max1363_state *st);
 int max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev);
 void max1363_ring_cleanup(struct iio_dev *indio_dev);
 
@@ -166,11 +164,6 @@ int max1363_update_scan_mode(struct iio_dev *indio_dev,
 	return 0;
 }
 
-int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
-{
-	return -EINVAL;
-}
-
 static inline int
 max1363_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 0b97123..1ce89ef 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -191,7 +191,6 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	int ret = 0;
 	s32 data;
 	char rxbuf[2];
-	const unsigned long *mask;
 	struct max1363_state *st = iio_priv(indio_dev);
 	struct i2c_client *client = st->client;
 
@@ -200,46 +199,38 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 	 * If monitor mode is enabled, the method for reading a single
 	 * channel will have to be rather different and has not yet
 	 * been implemented.
+	 *
+	 * Also, cannot read directly if buffered capture enabled.
 	 */
-	if (st->monitor_on) {
+	if (st->monitor_on || iio_buffer_enabled(indio_dev)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
 
-	/* If ring buffer capture is occurring, query the buffer */
-	if (iio_buffer_enabled(indio_dev)) {
-		mask = max1363_mode_table[chan->address].modemask;
-		data = max1363_single_channel_from_ring(mask, st);
+	/* Check to see if current scan mode is correct */
+	if (st->current_mode != &max1363_mode_table[chan->address]) {
+		/* Update scan mode if needed */
+		st->current_mode = &max1363_mode_table[chan->address];
+		ret = max1363_set_scan_mode(st);
+		if (ret < 0)
+			goto error_ret;
+	}
+	if (st->chip_info->bits != 8) {
+		/* Get reading */
+		data = i2c_master_recv(client, rxbuf, 2);
 		if (data < 0) {
 			ret = data;
 			goto error_ret;
 		}
+		data = (s32)(rxbuf[1]) | ((s32)(rxbuf[0] & 0x0F)) << 8;
 	} else {
-		/* Check to see if current scan mode is correct */
-		if (st->current_mode != &max1363_mode_table[chan->address]) {
-			/* Update scan mode if needed */
-			st->current_mode = &max1363_mode_table[chan->address];
-			ret = max1363_set_scan_mode(st);
-			if (ret < 0)
-				goto error_ret;
-		}
-		if (st->chip_info->bits != 8) {
-			/* Get reading */
-			data = i2c_master_recv(client, rxbuf, 2);
-			if (data < 0) {
-				ret = data;
-				goto error_ret;
-			}
-			data = (s32)(rxbuf[1]) | ((s32)(rxbuf[0] & 0x0F)) << 8;
-		} else {
-			/* Get reading */
-			data = i2c_master_recv(client, rxbuf, 1);
-			if (data < 0) {
-				ret = data;
-				goto error_ret;
-			}
-			data = rxbuf[0];
+		/* Get reading */
+		data = i2c_master_recv(client, rxbuf, 1);
+		if (data < 0) {
+			ret = data;
+			goto error_ret;
 		}
+		data = rxbuf[0];
 	}
 	*val = data;
 error_ret:
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 3a38a26..f730b3f 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -21,42 +21,6 @@
 
 #include "max1363.h"
 
-int max1363_single_channel_from_ring(const long *mask, struct max1363_state *st)
-{
-	struct iio_buffer *ring = iio_priv_to_dev(st)->buffer;
-	int count = 0, ret, index;
-	u8 *ring_data;
-	index = find_first_bit(mask, MAX1363_MAX_CHANNELS);
-
-	if (!(test_bit(index, st->current_mode->modemask))) {
-		ret = -EBUSY;
-		goto error_ret;
-	}
-
-	ring_data = kmalloc(ring->access->get_bytes_per_datum(ring),
-			    GFP_KERNEL);
-	if (ring_data == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	ret = ring->access->read_last(ring, ring_data);
-	if (ret)
-		goto error_free_ring_data;
-	/* Need a count of channels prior to this one */
-
-	count = bitmap_weight(mask, index - 1);
-	if (st->chip_info->bits != 8)
-		ret = ((int)(ring_data[count*2 + 0] & 0x0F) << 8)
-			+ (int)(ring_data[count*2 + 1]);
-	else
-		ret = ring_data[count];
-
-error_free_ring_data:
-	kfree(ring_data);
-error_ret:
-	return ret;
-}
-
 int max1363_update_scan_mode(struct iio_dev *indio_dev,
 			     const unsigned long *scan_mask)
 {
-- 
1.7.7.3
