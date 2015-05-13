Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-163.synserver.de ([212.40.185.163]:1053 "EHLO
	smtp-out-163.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934103AbbEMOE5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2015 10:04:57 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/8] iio: __iio_update_buffers: Slightly refactor scan mask memory management
Date: Wed, 13 May 2015 16:04:45 +0200
Message-Id: <1431525891-19285-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1431525891-19285-1-git-send-email-lars@metafoo.de>
References: <1431525891-19285-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add a small helper function iio_free_scan_mask() that takes a mask and
frees its memory if the scan masks for the device are dynamically
allocated, otherwise does nothing. This means we don't have to open-code
the same check over and over again in __iio_update_buffers.

Also free compound_mask as soon a we are done using it. This constrains its
usage to a specific region of the function will make further refactoring
and splitting the function into smaller sub-parts more easier.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 1f91031..2afe3db 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -575,6 +575,14 @@ static void iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
 	buffer->access->set_bytes_per_datum(buffer, bytes);
 }
 
+static void iio_free_scan_mask(struct iio_dev *indio_dev,
+	const unsigned long *mask)
+{
+	/* If the mask is dynamically allocated free it, otherwise do nothing */
+	if (!indio_dev->available_scan_masks)
+		kfree(mask);
+}
+
 static int __iio_update_buffers(struct iio_dev *indio_dev,
 		       struct iio_buffer *insert_buffer,
 		       struct iio_buffer *remove_buffer)
@@ -612,8 +620,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 	/* If no buffers in list, we are done */
 	if (list_empty(&indio_dev->buffer_list)) {
 		indio_dev->currentmode = INDIO_DIRECT_MODE;
-		if (indio_dev->available_scan_masks == NULL)
-			kfree(old_mask);
+		iio_free_scan_mask(indio_dev, old_mask);
 		return 0;
 	}
 
@@ -621,8 +628,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 	compound_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
 				sizeof(long), GFP_KERNEL);
 	if (compound_mask == NULL) {
-		if (indio_dev->available_scan_masks == NULL)
-			kfree(old_mask);
+		iio_free_scan_mask(indio_dev, old_mask);
 		return -ENOMEM;
 	}
 	indio_dev->scan_timestamp = 0;
@@ -637,6 +643,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 			iio_scan_mask_match(indio_dev->available_scan_masks,
 					    indio_dev->masklength,
 					    compound_mask);
+		kfree(compound_mask);
 		if (indio_dev->active_scan_mask == NULL) {
 			/*
 			 * Roll back.
@@ -648,7 +655,6 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 				success = -EINVAL;
 			}
 			else {
-				kfree(compound_mask);
 				ret = -EINVAL;
 				return ret;
 			}
@@ -721,10 +727,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
 		}
 	}
 
-	if (indio_dev->available_scan_masks)
-		kfree(compound_mask);
-	else
-		kfree(old_mask);
+	iio_free_scan_mask(indio_dev, old_mask);
 
 	return success;
 
@@ -736,8 +739,8 @@ error_run_postdisable:
 error_remove_inserted:
 	if (insert_buffer)
 		iio_buffer_deactivate(insert_buffer);
+	iio_free_scan_mask(indio_dev, indio_dev->active_scan_mask);
 	indio_dev->active_scan_mask = old_mask;
-	kfree(compound_mask);
 	return ret;
 }
 
-- 
1.8.0

