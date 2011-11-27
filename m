Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:59470 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796Ab1K0NKH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2011 08:10:07 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/7] staging:iio:buffer add a cache of the timestamp scan index.
Date: Sun, 27 Nov 2011 13:10:07 +0000
Message-Id: <1322399412-21622-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1322399412-21622-1-git-send-email-jic23@kernel.org>
References: <1322399412-21622-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@cam.ac.uk>

Basically avoids looking it up lots of times.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/buffer.h              |    1 +
 drivers/staging/iio/industrialio-buffer.c |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 9de581e..4b8f619 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -106,6 +106,7 @@ struct iio_buffer {
 	int					scan_count;
 	long					*scan_mask;
 	bool					scan_timestamp;
+	unsigned				scan_index_timestamp;
 	const struct iio_buffer_access_funcs	*access;
 	const struct iio_buffer_setup_ops		*setup_ops;
 	struct list_head			scan_el_dev_attr_list;
diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index f757bb7..cae7922 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -313,6 +313,9 @@ int iio_buffer_register(struct iio_dev *indio_dev,
 			if (ret < 0)
 				goto error_cleanup_dynamic;
 			attrcount += ret;
+			if (channels[i].type == IIO_TIMESTAMP)
+				buffer->scan_index_timestamp =
+					channels[i].scan_index;
 		}
 		if (indio_dev->masklength && buffer->scan_mask == NULL) {
 			buffer->scan_mask
-- 
1.7.7.3

