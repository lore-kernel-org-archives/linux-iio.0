Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/5] staging:iio:kfifo remove entirely pointless code.
Date: Thu, 20 Oct 2011 17:29:25 +0100
Message-Id: <1319128169-3722-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319128169-3722-1-git-send-email-jic23@cam.ac.uk>
References: <1319128169-3722-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I really don't want to think about how this bit got
in there.  It allocates some storage - copies something
into it then frees it without making use of it.
Oops.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/kfifo_buf.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
index e8c234b..fd98a0e 100644
--- a/drivers/staging/iio/kfifo_buf.c
+++ b/drivers/staging/iio/kfifo_buf.c
@@ -150,16 +150,9 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
 {
 	int ret;
 	struct iio_kfifo *kf = iio_to_kfifo(r);
-	u8 *datal = kmalloc(r->bytes_per_datum, GFP_KERNEL);
-	memcpy(datal, data, r->bytes_per_datum - sizeof(timestamp));
-	memcpy(datal + r->bytes_per_datum - sizeof(timestamp),
-		&timestamp, sizeof(timestamp));
 	ret = kfifo_in(&kf->kf, data, r->bytes_per_datum);
-	if (ret != r->bytes_per_datum) {
-		kfree(datal);
+	if (ret != r->bytes_per_datum)
 		return -EBUSY;
-	}
-	kfree(datal);
 	return 0;
 }
 
-- 
1.7.7
