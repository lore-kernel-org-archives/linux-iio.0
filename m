Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 6/6] staging:iio:ad799x: Preallocate sample buffer
Date: Tue, 26 Mar 2013 19:43:04 +0100
Message-Id: <1364323384-30863-6-git-send-email-lars@metafoo.de>
In-Reply-To: <1364323384-30863-1-git-send-email-lars@metafoo.de>
References: <1364323384-30863-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Avoid allocating and freeing the sample buffer for each transfer. Instead
allocate it once when we start sampling. Also pre-compute the number of bytes we
need to transfer in the same way.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad799x.h      |  3 +++
 drivers/staging/iio/adc/ad799x_core.c |  8 ++++++++
 drivers/staging/iio/adc/ad799x_ring.c | 16 ++++------------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 82e83bb..b51680c 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -106,6 +106,9 @@ struct ad799x_state {
 	u16				int_vref_mv;
 	unsigned			id;
 	u16				config;
+
+	u8				*rx_buf;
+	unsigned int			transfer_size;
 };
 
 /*
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index b751055..8dc97b3 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -104,6 +104,13 @@ static int ad7997_8_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct ad799x_state *st = iio_priv(indio_dev);
 
+	kfree(st->rx_buf);
+	st->rx_buf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	if (!st->rx_buf)
+		return -ENOMEM;
+
+	st->transfer_size = bitmap_weight(scan_mask, indio_dev->masklength) * 2;
+
 	switch (st->id) {
 	case ad7997:
 	case ad7998:
@@ -665,6 +672,7 @@ static int ad799x_remove(struct i2c_client *client)
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
+	kfree(st->rx_buf);
 	iio_device_free(indio_dev);
 
 	return 0;
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 2c5f384..c2ebae1 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -36,14 +36,9 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad799x_state *st = iio_priv(indio_dev);
 	s64 time_ns;
-	__u8 *rxbuf;
 	int b_sent;
 	u8 cmd;
 
-	rxbuf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (rxbuf == NULL)
-		goto out;
-
 	switch (st->id) {
 	case ad7991:
 	case ad7995:
@@ -66,20 +61,17 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	}
 
 	b_sent = i2c_smbus_read_i2c_block_data(st->client,
-			cmd, bitmap_weight(indio_dev->active_scan_mask,
-					   indio_dev->masklength) * 2, rxbuf);
+			cmd, st->transfer_size, st->rx_buf);
 	if (b_sent < 0)
-		goto done;
+		goto out;
 
 	time_ns = iio_get_time_ns();
 
 	if (indio_dev->scan_timestamp)
-		memcpy(rxbuf + indio_dev->scan_bytes - sizeof(s64),
+		memcpy(st->rx_buf + indio_dev->scan_bytes - sizeof(s64),
 			&time_ns, sizeof(time_ns));
 
-	iio_push_to_buffers(indio_dev, rxbuf);
-done:
-	kfree(rxbuf);
+	iio_push_to_buffers(indio_dev, st->rx_buf);
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
1.8.0
