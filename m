Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/7] staging:iio:buffer add a cache of the timestamp scan index.
Date: Sun,  4 Dec 2011 20:56:57 +0000
Message-Id: <1323032222-21338-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1323032222-21338-1-git-send-email-jic23@kernel.org>
References: <1323032222-21338-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

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
index 8c55980..b2cf3e3 100644
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
 			buffer->scan_mask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
-- 
1.7.7.4
