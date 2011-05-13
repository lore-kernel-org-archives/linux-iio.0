Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/5] staging:iio:max1363 misc cleanups and use of for_each_bit_set to simplify event code spitting out.
Date: Fri, 13 May 2011 17:09:00 +0100
Message-Id: <1305302943-16475-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305302943-16475-1-git-send-email-jic23@cam.ac.uk>
References: <1305302943-16475-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363.h      |   64 ------------------
 drivers/staging/iio/adc/max1363_core.c |  114 +++++++++++++++++--------------
 drivers/staging/iio/adc/max1363_ring.c |    1 +
 3 files changed, 63 insertions(+), 116 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363.h b/drivers/staging/iio/adc/max1363.h
index 5243b5a..360bfc5 100644
--- a/drivers/staging/iio/adc/max1363.h
+++ b/drivers/staging/iio/adc/max1363.h
@@ -67,70 +67,6 @@ struct max1363_mode {
 	long		modemask;
 };
 
-#define MAX1363_MODE_SINGLE(_num, _mask) {				\
-		.conf = MAX1363_CHANNEL_SEL(_num)			\
-			| MAX1363_CONFIG_SCAN_SINGLE_1			\
-			| MAX1363_CONFIG_SE,				\
-			.modemask = _mask,				\
-			}
-
-#define MAX1363_MODE_SCAN_TO_CHANNEL(_num, _mask) {			\
-		.conf = MAX1363_CHANNEL_SEL(_num)			\
-			| MAX1363_CONFIG_SCAN_TO_CS			\
-			| MAX1363_CONFIG_SE,				\
-			.modemask = _mask,				\
-			}
-
-
-/* note not available for max1363 hence naming */
-#define MAX1236_MODE_SCAN_MID_TO_CHANNEL(_mid, _num, _mask) {		\
-		.conf = MAX1363_CHANNEL_SEL(_num)			\
-			| MAX1236_SCAN_MID_TO_CHANNEL			\
-			| MAX1363_CONFIG_SE,				\
-			.modemask = _mask				\
-}
-
-#define MAX1363_MODE_DIFF_SINGLE(_nump, _numm, _mask) {			\
-		.conf = MAX1363_CHANNEL_SEL(_nump)			\
-			| MAX1363_CONFIG_SCAN_SINGLE_1			\
-			| MAX1363_CONFIG_DE,				\
-			.modemask = _mask				\
-			}
-
-/* Can't think how to automate naming so specify for now */
-#define MAX1363_MODE_DIFF_SCAN_TO_CHANNEL(_num, _numvals, _mask) { \
-		.conf = MAX1363_CHANNEL_SEL(_num)			\
-			| MAX1363_CONFIG_SCAN_TO_CS			\
-			| MAX1363_CONFIG_DE,				\
-			.modemask = _mask				\
-			}
-
-/* note only available for max1363 hence naming */
-#define MAX1236_MODE_DIFF_SCAN_MID_TO_CHANNEL(_num, _numvals, _mask) { \
-		.conf = MAX1363_CHANNEL_SEL(_num)			\
-			| MAX1236_SCAN_MID_TO_CHANNEL			\
-			| MAX1363_CONFIG_SE,				\
-			.modemask = _mask				\
-}
-
-/* This may seem an overly long winded way to do this, but at least it makes
- * clear what all the various options actually do. Alternative suggestions
- * that don't require user to have intimate knowledge of the chip welcomed.
- */
-enum max1363_channels {
-	max1363_in0, max1363_in1, max1363_in2, max1363_in3,
-	max1363_in4, max1363_in5, max1363_in6, max1363_in7,
-	max1363_in8, max1363_in9, max1363_in10, max1363_in11,
-
-	max1363_in0min1, max1363_in2min3,
-	max1363_in4min5, max1363_in6min7,
-	max1363_in8min9, max1363_in10min11,
-
-	max1363_in1min0, max1363_in3min2,
-	max1363_in5min4, max1363_in7min6,
-	max1363_in9min8, max1363_in11min10,
-};
-
 /* This must be maintained along side the max1363_mode_table in max1363_core */
 enum max1363_modes {
 	/* Single read of a single channel */
diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 8d09bf3..98cebd2 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -38,8 +38,50 @@
 #include "adc.h"
 #include "max1363.h"
 
-/* Here we claim all are 16 bits. This currently does no harm and saves
- * us a lot of scan element listings */
+#define MAX1363_MODE_SINGLE(_num, _mask) {				\
+		.conf = MAX1363_CHANNEL_SEL(_num)			\
+			| MAX1363_CONFIG_SCAN_SINGLE_1			\
+			| MAX1363_CONFIG_SE,				\
+			.modemask = _mask,				\
+			}
+
+#define MAX1363_MODE_SCAN_TO_CHANNEL(_num, _mask) {			\
+		.conf = MAX1363_CHANNEL_SEL(_num)			\
+			| MAX1363_CONFIG_SCAN_TO_CS			\
+			| MAX1363_CONFIG_SE,				\
+			.modemask = _mask,				\
+			}
+
+/* note not available for max1363 hence naming */
+#define MAX1236_MODE_SCAN_MID_TO_CHANNEL(_mid, _num, _mask) {		\
+		.conf = MAX1363_CHANNEL_SEL(_num)			\
+			| MAX1236_SCAN_MID_TO_CHANNEL			\
+			| MAX1363_CONFIG_SE,				\
+			.modemask = _mask				\
+}
+
+#define MAX1363_MODE_DIFF_SINGLE(_nump, _numm, _mask) {			\
+		.conf = MAX1363_CHANNEL_SEL(_nump)			\
+			| MAX1363_CONFIG_SCAN_SINGLE_1			\
+			| MAX1363_CONFIG_DE,				\
+			.modemask = _mask				\
+			}
+
+/* Can't think how to automate naming so specify for now */
+#define MAX1363_MODE_DIFF_SCAN_TO_CHANNEL(_num, _numvals, _mask) {	\
+		.conf = MAX1363_CHANNEL_SEL(_num)			\
+			| MAX1363_CONFIG_SCAN_TO_CS			\
+			| MAX1363_CONFIG_DE,				\
+			.modemask = _mask				\
+			}
+
+/* note only available for max1363 hence naming */
+#define MAX1236_MODE_DIFF_SCAN_MID_TO_CHANNEL(_num, _numvals, _mask) {	\
+		.conf = MAX1363_CHANNEL_SEL(_num)			\
+			| MAX1236_SCAN_MID_TO_CHANNEL			\
+			| MAX1363_CONFIG_SE,				\
+			.modemask = _mask				\
+}
 
 static const struct max1363_mode max1363_mode_table[] = {
 	/* All of the single channel options first */
@@ -120,18 +162,9 @@ static int max1363_write_basic_config(struct i2c_client *client,
 				      unsigned char d1,
 				      unsigned char d2)
 {
-	int ret;
-	u8 *tx_buf = kmalloc(2, GFP_KERNEL);
-
-	if (!tx_buf)
-		return -ENOMEM;
-	tx_buf[0] = d1;
-	tx_buf[1] = d2;
-
-	ret = i2c_master_send(client, tx_buf, 2);
-	kfree(tx_buf);
+	u8 tx_buf[2] = {d1, d2};
 
-	return (ret > 0) ? 0 : ret;
+	return i2c_master_send(client, tx_buf, 2);
 }
 
 int max1363_set_scan_mode(struct max1363_state *st)
@@ -179,13 +212,11 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 		}
 	} else {
 		/* Check to see if current scan mode is correct */
-		if (st->current_mode !=
-		    &max1363_mode_table[chan->address]) {
+		if (st->current_mode != &max1363_mode_table[chan->address]) {
 			/* Update scan mode if needed */
-			st->current_mode
-				= &max1363_mode_table[chan->address];
+			st->current_mode = &max1363_mode_table[chan->address];
 			ret = max1363_set_scan_mode(st);
-			if (ret)
+			if (ret < 0)
 				goto error_ret;
 		}
 		if (st->chip_info->bits != 8) {
@@ -560,49 +591,28 @@ static int max1363_write_thresh(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static const int max1363_event_codes[] = {
+	IIO_EVENT_CODE_IN_LOW_THRESH(3), IIO_EVENT_CODE_IN_HIGH_THRESH(3),
+	IIO_EVENT_CODE_IN_LOW_THRESH(2), IIO_EVENT_CODE_IN_HIGH_THRESH(2),
+	IIO_EVENT_CODE_IN_LOW_THRESH(1), IIO_EVENT_CODE_IN_HIGH_THRESH(1),
+	IIO_EVENT_CODE_IN_LOW_THRESH(0), IIO_EVENT_CODE_IN_HIGH_THRESH(0)
+};
+
 static irqreturn_t max1363_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct max1363_state *st = iio_priv(indio_dev);
 	s64 timestamp = iio_get_time_ns();
+	unsigned long mask, loc;
 	u8 rx;
 	u8 tx[2] = { st->setupbyte,
 		     MAX1363_MON_INT_ENABLE | (st->monitor_speed << 1) | 0xF0 };
 
 	i2c_master_recv(st->client, &rx, 1);
-	/* todo - begging for use of for_each_set_bit */
-	if (rx & (1 << 0))
-		iio_push_event(indio_dev, 0,
-			IIO_EVENT_CODE_IN_LOW_THRESH(3),
-			timestamp);
-	if (rx & (1 << 1))
-		iio_push_event(indio_dev, 0,
-			IIO_EVENT_CODE_IN_HIGH_THRESH(3),
-			timestamp);
-	if (rx & (1 << 2))
-		iio_push_event(indio_dev, 0,
-			IIO_EVENT_CODE_IN_LOW_THRESH(2),
-			timestamp);
-	if (rx & (1 << 3))
-		iio_push_event(indio_dev, 0,
-			IIO_EVENT_CODE_IN_HIGH_THRESH(2),
-			timestamp);
-	if (rx & (1 << 4))
-		iio_push_event(indio_dev, 0,
-			IIO_EVENT_CODE_IN_LOW_THRESH(1),
-			timestamp);
-	if (rx & (1 << 5))
-		iio_push_event(indio_dev, 0,
-			IIO_EVENT_CODE_IN_HIGH_THRESH(1),
-			timestamp);
-	if (rx & (1 << 6))
-		iio_push_event(indio_dev, 0,
-			IIO_EVENT_CODE_IN_LOW_THRESH(0),
-			timestamp);
-	if (rx & (1 << 7))
-		iio_push_event(indio_dev, 0,
-			IIO_EVENT_CODE_IN_HIGH_THRESH(0),
-			timestamp);
+	mask = rx;
+	for_each_set_bit(loc, &mask, 8)
+		iio_push_event(indio_dev, 0, max1363_event_codes[loc],
+			       timestamp);
 	i2c_master_send(st->client, tx, 2);
 
 	return IRQ_HANDLED;
@@ -1283,7 +1293,7 @@ static int __devinit max1363_probe(struct i2c_client *client,
 	indio_dev->info = st->chip_info->info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	ret = max1363_initial_setup(st);
-	if (ret)
+	if (ret < 0)
 		goto error_free_available_scan_masks;
 
 	ret = max1363_register_ring_funcs_and_init(indio_dev);
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index 9638909..1587aec1 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -63,6 +63,7 @@ error_ret:
 	return ret;
 }
 
+
 /**
  * max1363_ring_preenable() - setup the parameters of the ring before enabling
  *
-- 
1.7.3.4
