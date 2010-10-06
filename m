Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: drivers@analog.com, linux-iio@vger.kernel.org, jic23@cam.ac.uk,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] staging: iio: adc: ad799x: prevent buffer overflow
Date: Wed, 6 Oct 2010 16:22:17 +0200
Message-ID: <1286374937-29156-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

ring->access.read_last() reads the entire datum from the ring including padding and time stamp.

Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad799x_ring.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 0f2041a..d0217f8 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -29,28 +29,26 @@
 
 int ad799x_single_channel_from_ring(struct ad799x_state *st, long mask)
 {
-	unsigned long numvals;
+	struct iio_ring_buffer *ring = st->indio_dev->ring;
 	int count = 0, ret;
 	u16 *ring_data;
-	if (!(st->indio_dev->ring->scan_mask & mask)) {
+	if (!(ring->scan_mask & mask)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
-	numvals = st->indio_dev->ring->scan_count;
 
-	ring_data = kmalloc(numvals*2, GFP_KERNEL);
+	ring_data = kmalloc(ring->access.get_bytes_per_datum(ring), GFP_KERNEL);
 	if (ring_data == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	ret = st->indio_dev->ring->access.read_last(st->indio_dev->ring,
-						(u8 *) ring_data);
+	ret = ring->access.read_last(ring, (u8 *) ring_data);
 	if (ret)
 		goto error_free_ring_data;
 	/* Need a count of channels prior to this one */
 	mask >>= 1;
 	while (mask) {
-		if (mask & st->indio_dev->ring->scan_mask)
+		if (mask & ring->scan_mask)
 			count++;
 		mask >>= 1;
 	}
-- 
1.6.0.2
