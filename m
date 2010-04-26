Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 04/19] staging:iio: Support functions for scan mask matching
Date: Mon, 26 Apr 2010 21:07:55 +0100
Message-Id: <1272312490-9791-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1272312490-9791-4-git-send-email-jic23@cam.ac.uk>
References: <1272312490-9791-1-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-2-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-3-git-send-email-jic23@cam.ac.uk>
 <1272312490-9791-4-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h |   45 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 71dbfe1..a12072a 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -96,6 +96,7 @@ void iio_remove_event_from_list(struct iio_event_handler_list *el,
  *			control method is used
  * @scan_count:	[INTERN] the number of elements in the current scan mode
  * @scan_mask:		[INTERN] bitmask used in masking scan mode elements
+ * @available_scan_masks: [DRIVER] optional array of allowed bitmasks
  * @scan_timestamp:	[INTERN] does the scan mode include a timestamp
  * @trig:		[INTERN] current device trigger (ring buffer modes)
  * @pollfunc:		[DRIVER] function run on trigger being recieved
@@ -122,7 +123,8 @@ struct iio_dev {
 	struct attribute_group		*scan_el_attrs;
 	int				scan_count;
 
-	u16				scan_mask;
+	u32				scan_mask;
+	u32				*available_scan_masks;
 	bool				scan_timestamp;
 	struct iio_trigger		*trig;
 	struct iio_poll_func		*pollfunc;
@@ -132,22 +134,57 @@ struct iio_dev {
  * These are mainly provided to allow for a change of implementation if a device
  * has a large number of scan elements
  */
-#define IIO_MAX_SCAN_LENGTH 15
+#define IIO_MAX_SCAN_LENGTH 31
+
+/* note 0 used as error indicator as it doesn't make sense. */
+static inline u32 iio_scan_mask_match(u32 *av_masks, u32 mask)
+{
+	while (*av_masks) {
+		if (!(~*av_masks & mask))
+			return *av_masks;
+		av_masks++;
+	}
+	return 0;
+}
 
 static inline int iio_scan_mask_query(struct iio_dev *dev_info, int bit)
 {
+	u32 mask;
+
 	if (bit > IIO_MAX_SCAN_LENGTH)
 		return -EINVAL;
+
+	if (!dev_info->scan_mask)
+		return 0;
+
+	if (dev_info->available_scan_masks)
+		mask = iio_scan_mask_match(dev_info->available_scan_masks,
+					dev_info->scan_mask);
 	else
-		return !!(dev_info->scan_mask & (1 << bit));
+		mask = dev_info->scan_mask;
+
+	if (!mask)
+		return -EINVAL;
+
+	return !!(mask & (1 << bit));
 };
 
 static inline int iio_scan_mask_set(struct iio_dev *dev_info, int bit)
 {
+	u32 mask;
+	u32 trialmask = dev_info->scan_mask | (1 << bit);
+
 	if (bit > IIO_MAX_SCAN_LENGTH)
 		return -EINVAL;
-	dev_info->scan_mask |= (1 << bit);
+	if (dev_info->available_scan_masks) {
+		mask = iio_scan_mask_match(dev_info->available_scan_masks,
+					trialmask);
+		if (!mask)
+			return -EINVAL;
+	}
+	dev_info->scan_mask = trialmask;
 	dev_info->scan_count++;
+
 	return 0;
 };
 
-- 
1.6.4.4
