Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:5372 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757014Ab0JLIhc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Oct 2010 04:37:32 -0400
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: linux-iio@vger.kernel.org, drivers@analog.com, jic23@cam.ac.uk,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] staging: iio: adc: ad799x miscellaneous cleanups
Date: Tue, 12 Oct 2010 10:30:51 +0200
Message-ID: <1286872251-28938-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

-Simplify by using iio_alloc_pollfunc helper function
-Print in_scale in decimal format.
-Simplify ring pointer dereferences

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad799x_core.c |    9 ++-----
 drivers/staging/iio/adc/ad799x_ring.c |   34 ++++++++++++++------------------
 2 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 35fad73..6309d52 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -428,14 +428,11 @@ static ssize_t ad799x_show_scale(struct device *dev,
 	/* Driver currently only support internal vref */
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad799x_state *st = iio_dev_get_devdata(dev_info);
+
 	/* Corresponds to Vref / 2^(bits) */
+	unsigned int scale_uv = (st->int_vref_mv * 1000) >> st->chip_info->bits;
 
-	if ((1 << (st->chip_info->bits + 1))
-	    > st->int_vref_mv)
-		return sprintf(buf, "0.5\n");
-	else
-		return sprintf(buf, "%d\n",
-			st->int_vref_mv >> st->chip_info->bits);
+	return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
 }
 
 static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad799x_show_scale, NULL, 0);
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index c6871fa..975cdcb 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -32,6 +32,7 @@ int ad799x_single_channel_from_ring(struct ad799x_state *st, long mask)
 	struct iio_ring_buffer *ring = st->indio_dev->ring;
 	int count = 0, ret;
 	u16 *ring_data;
+
 	if (!(ring->scan_mask & mask)) {
 		ret = -EBUSY;
 		goto error_ret;
@@ -70,6 +71,7 @@ error_ret:
  **/
 static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 {
+	struct iio_ring_buffer *ring = indio_dev->ring;
 	struct ad799x_state *st = indio_dev->dev_data;
 	size_t d_size;
 	unsigned long numvals;
@@ -80,16 +82,15 @@ static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 	 */
 
 	if (st->id == ad7997 || st->id == ad7998)
-		ad799x_set_scan_mode(st, st->indio_dev->ring->scan_mask);
+		ad799x_set_scan_mode(st, ring->scan_mask);
 
-	numvals = st->indio_dev->ring->scan_count;
+	numvals = ring->scan_count;
 
-	if (indio_dev->ring->access.set_bytes_per_datum) {
+	if (ring->access.set_bytes_per_datum) {
 		d_size = numvals*2 + sizeof(s64);
 		if (d_size % 8)
 			d_size += 8 - (d_size % 8);
-		indio_dev->ring->access.set_bytes_per_datum(indio_dev->ring,
-							    d_size);
+		ring->access.set_bytes_per_datum(ring, d_size);
 	}
 
 	return 0;
@@ -124,14 +125,15 @@ static void ad799x_poll_bh_to_ring(struct work_struct *work_s)
 	struct ad799x_state *st = container_of(work_s, struct ad799x_state,
 						  poll_work);
 	struct iio_dev *indio_dev = st->indio_dev;
-	struct iio_sw_ring_buffer *ring = iio_to_sw_ring(indio_dev->ring);
+	struct iio_ring_buffer *ring = indio_dev->ring;
+	struct iio_sw_ring_buffer *ring_sw = iio_to_sw_ring(indio_dev->ring);
 	s64 time_ns;
 	__u8 *rxbuf;
 	int b_sent;
 	size_t d_size;
 	u8 cmd;
 
-	unsigned long numvals = st->indio_dev->ring->scan_count;
+	unsigned long numvals = ring->scan_count;
 
 	/* Ensure the timestamp is 8 byte aligned */
 	d_size = numvals*2 + sizeof(s64);
@@ -158,14 +160,13 @@ static void ad799x_poll_bh_to_ring(struct work_struct *work_s)
 	case ad7991:
 	case ad7995:
 	case ad7999:
-		cmd = st->config | (st->indio_dev->ring->scan_mask <<
-			AD799X_CHANNEL_SHIFT);
+		cmd = st->config | (ring->scan_mask << AD799X_CHANNEL_SHIFT);
 		break;
 	case ad7992:
 	case ad7993:
 	case ad7994:
-		cmd = (st->indio_dev->ring->scan_mask <<
-			AD799X_CHANNEL_SHIFT) | AD7998_CONV_RES_REG;
+		cmd = (ring->scan_mask << AD799X_CHANNEL_SHIFT) |
+			AD7998_CONV_RES_REG;
 		break;
 	case ad7997:
 	case ad7998:
@@ -184,7 +185,7 @@ static void ad799x_poll_bh_to_ring(struct work_struct *work_s)
 
 	memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
 
-	indio_dev->ring->access.store_to(&ring->buf, rxbuf, time_ns);
+	ring->access.store_to(&ring_sw->buf, rxbuf, time_ns);
 done:
 	kfree(rxbuf);
 	atomic_dec(&st->protect_ring);
@@ -203,14 +204,9 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	}
 	/* Effectively select the ring buffer implementation */
 	iio_ring_sw_register_funcs(&st->indio_dev->ring->access);
-	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
-	if (indio_dev->pollfunc == NULL) {
-		ret = -ENOMEM;
+	ret = iio_alloc_pollfunc(indio_dev, NULL, &ad799x_poll_func_th);
+	if (ret)
 		goto error_deallocate_sw_rb;
-	}
-	/* Configure the polling function called on trigger interrupts */
-	indio_dev->pollfunc->poll_func_main = &ad799x_poll_func_th;
-	indio_dev->pollfunc->private_data = indio_dev;
 
 	/* Ring buffer functions - here trigger setup related */
 
-- 
1.6.0.2

