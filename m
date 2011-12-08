Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>, <devel@driverdev.osuosl.org>,
	<linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] staging:iio: Fix scan mask update
Date: Thu, 8 Dec 2011 18:35:53 +0100
Message-ID: <1323365753-7645-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1323365753-7645-1-git-send-email-lars@metafoo.de>
References: <1323365753-7645-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

When updating the scan mask we have to check the actual scan mask for if the
channel is already enabled, not the matching scan mask from the available
scan masks. The bit will already be set there and as a result the actual
scan mask will not get updated and the channel stays disabled.

Also fix the return value of iio_scan_el_store which would return 1 instead of
the number of bytes written if the channel was already active in the scan mask.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/industrialio-buffer.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 552e33f..a03a574 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -173,7 +173,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
 error_ret:
 	mutex_unlock(&indio_dev->mlock);
 
-	return ret ? ret : len;
+	return ret < 0 ? ret : len;
 
 }
 
@@ -624,16 +624,8 @@ int iio_scan_mask_query(struct iio_dev *indio_dev,
 
 	if (!buffer->scan_mask)
 		return 0;
-	if (indio_dev->available_scan_masks)
-		mask = iio_scan_mask_match(indio_dev->available_scan_masks,
-					   indio_dev->masklength,
-					   buffer->scan_mask);
-	else
-		mask = buffer->scan_mask;
-	if (!mask)
-		return 0;
 
-	return test_bit(bit, mask);
+	return test_bit(bit, buffer->scan_mask);
 };
 EXPORT_SYMBOL_GPL(iio_scan_mask_query);
 
-- 
1.7.7.3
