Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 02/11] staging:iio:dummy driver: Add example usecases for the new *_available interface.
Date: Sun, 17 Nov 2013 15:14:53 +0000
Message-Id: <1384701302-26564-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1384701302-26564-1-git-send-email-jic23@kernel.org>
References: <1384701302-26564-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/iio_simple_dummy.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index 1fac9894b18c..8697bdcedf07 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -84,6 +84,9 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 		/* Channel has a numeric index of 0 */
 		.indexed = 1,
 		.channel = 0,
+		.info_mask_separate_available =
+		BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_OFFSET),
 		/* What other information is available? */
 		.info_mask_separate =
 		/*
@@ -304,7 +307,30 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
 	mutex_unlock(&st->lock);
 	return ret;
 }
-
+static const int test_avail_list[] = { 0, 1, 1, 0, 3, 3000 };
+
+static int iio_dummy_read_avail(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				const int **vals,
+				int *type,
+				int *length,
+				long mask_el)
+{
+	switch (mask_el) {
+	case IIO_CHAN_INFO_RAW:
+		*length = ARRAY_SIZE(test_avail_list);
+		*vals = test_avail_list;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OFFSET:
+		*length = ARRAY_SIZE(test_avail_list);
+		*vals = test_avail_list;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_RANGE;
+	default:
+		return -EINVAL;
+	}
+}
 /**
  * iio_dummy_write_raw() - data write function.
  * @indio_dev:	the struct iio_dev associated with this device instance
@@ -368,6 +394,7 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info iio_dummy_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &iio_dummy_read_raw,
+	.read_avail = &iio_dummy_read_avail,
 	.write_raw = &iio_dummy_write_raw,
 #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
 	.read_event_config_new = &iio_simple_dummy_read_event_config,
-- 
1.8.4.2
