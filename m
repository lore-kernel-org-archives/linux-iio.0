Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO: kfifo_buf: Fix erroneous timestamp handling.
Date: Thu, 7 Apr 2011 12:55:15 +0200
Message-ID: <1302173715-21582-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Saving the timestamp should not be part of the buffer implementation.
Apart from that, the code present doesn't make sense at all.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/kfifo_buf.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index a56c0cb..cc58b1b 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -167,16 +167,11 @@ int iio_store_to_kfifo(struct iio_ring_buffer *r, u8 *data, s64 timestamp)
 {
 	int ret;
 	struct iio_kfifo *kf = iio_to_kfifo(r);
-	u8 *datal = kmalloc(r->bytes_per_datum, GFP_KERNEL);
-	memcpy(datal, data, r->bytes_per_datum - sizeof(timestamp));
-	memcpy(datal + r->bytes_per_datum - sizeof(timestamp),
-		&timestamp, sizeof(timestamp));
+
 	ret = kfifo_in(&kf->kf, data, r->bytes_per_datum);
-	if (ret != r->bytes_per_datum) {
-		kfree(datal);
+	if (ret != r->bytes_per_datum)
 		return -EBUSY;
-	}
-	kfree(datal);
+
 	return 0;
 }
 EXPORT_SYMBOL(iio_store_to_kfifo);
-- 
1.6.0.2
