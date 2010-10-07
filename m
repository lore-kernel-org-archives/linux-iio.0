Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/3] staging:iio: timestamp_en naming typo fix.
Date: Thu,  7 Oct 2010 13:10:19 +0100
Message-Id: <1286453421-7584-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286453421-7584-1-git-send-email-jic23@cam.ac.uk>
References: <1286453421-7584-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/ring_generic.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/ring_generic.h b/drivers/staging/iio/ring_generic.h
index abd52ea..6975722 100644
--- a/drivers/staging/iio/ring_generic.h
+++ b/drivers/staging/iio/ring_generic.h
@@ -276,7 +276,7 @@ ssize_t iio_scan_el_ts_show(struct device *dev, struct device_attribute *attr,
  **/
 #define IIO_SCAN_EL_TIMESTAMP(number)				\
 	struct iio_scan_el iio_scan_el_timestamp = {		\
-		.dev_attr = __ATTR(_timestamp_en,		\
+		.dev_attr = __ATTR(timestamp_en,		\
 				   S_IRUGO | S_IWUSR,		\
 				   iio_scan_el_ts_show,		\
 				   iio_scan_el_ts_store),	\
-- 
1.7.2.2
