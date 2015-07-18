Return-Path: <cristina.opriceana@gmail.com>
Date: Sat, 18 Jul 2015 17:31:27 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH] iio: Fix iio_validate_scan_mask_oneshot function name typo
Message-ID: <7d56ec6a8a6fdd76d8cc9abf4330c34061873920.1437229669.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Rename function to iio_validate_scan_mask_oneshot() since it's used to
validate that only one channel is selected.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 drivers/iio/adc/ad_sigma_delta.c         | 2 +-
 drivers/iio/industrialio-buffer.c        | 8 ++++----
 drivers/staging/iio/meter/ade7758_ring.c | 2 +-
 include/linux/iio/buffer.h               | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d10bd0c..2fa4e42 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -400,7 +400,7 @@ static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
 	.postenable = &ad_sd_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
 	.postdisable = &ad_sd_buffer_postdisable,
-	.validate_scan_mask = &iio_validate_scan_mask_onehot,
+	.validate_scan_mask = &iio_validate_scan_mask_oneshot,
 };
 
 static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index f72be48..b13f941 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1106,7 +1106,7 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
 }
 
 /**
- * iio_validate_scan_mask_onehot() - Validates that exactly one channel is selected
+ * iio_validate_scan_mask_oneshot() - Validates that exactly one channel is selected
  * @indio_dev: the iio device
  * @mask: scan mask to be checked
  *
@@ -1114,12 +1114,12 @@ void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
  * can be used for devices where only one channel can be active for sampling at
  * a time.
  */
-bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
-	const unsigned long *mask)
+bool iio_validate_scan_mask_oneshot(struct iio_dev *indio_dev,
+				    const unsigned long *mask)
 {
 	return bitmap_weight(mask, indio_dev->masklength) == 1;
 }
-EXPORT_SYMBOL_GPL(iio_validate_scan_mask_onehot);
+EXPORT_SYMBOL_GPL(iio_validate_scan_mask_oneshot);
 
 int iio_scan_mask_query(struct iio_dev *indio_dev,
 			struct iio_buffer *buffer, int bit)
diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
index 9a24e02..d2fa9ef 100644
--- a/drivers/staging/iio/meter/ade7758_ring.c
+++ b/drivers/staging/iio/meter/ade7758_ring.c
@@ -103,7 +103,7 @@ static const struct iio_buffer_setup_ops ade7758_ring_setup_ops = {
 	.preenable = &ade7758_ring_preenable,
 	.postenable = &iio_triggered_buffer_postenable,
 	.predisable = &iio_triggered_buffer_predisable,
-	.validate_scan_mask = &iio_validate_scan_mask_onehot,
+	.validate_scan_mask = &iio_validate_scan_mask_oneshot,
 };
 
 void ade7758_unconfigure_ring(struct iio_dev *indio_dev)
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 1600c55..78d27b7 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -152,8 +152,8 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
 
 int iio_update_demux(struct iio_dev *indio_dev);
 
-bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
-	const unsigned long *mask);
+bool iio_validate_scan_mask_oneshot(struct iio_dev *indio_dev,
+				    const unsigned long *mask);
 
 struct iio_buffer *iio_buffer_get(struct iio_buffer *buffer);
 void iio_buffer_put(struct iio_buffer *buffer);
-- 
1.9.1
