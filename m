Return-Path: <octavian.purdila@intel.com>
From: Octavian Purdila <octavian.purdila@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adriana.reus@intel.com,
	linux-api@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 1/3] iio: add hwfifo attributes helpers
Date: Wed, 29 Apr 2015 14:18:58 +0300
Message-Id: <1430306340-5026-2-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1430306340-5026-1-git-send-email-octavian.purdila@intel.com>
References: <1430306340-5026-1-git-send-email-octavian.purdila@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 11 ++++-------
 include/linux/iio/sysfs.h        | 12 ++++++++++++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 73e8773..b4ca361 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -870,13 +870,10 @@ static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
 	return sprintf(buf, "%d\n", state);
 }
 
-static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
-static IIO_CONST_ATTR(hwfifo_watermark_max,
-		      __stringify(BMC150_ACCEL_FIFO_LENGTH));
-static IIO_DEVICE_ATTR(hwfifo_enabled, S_IRUGO,
-		       bmc150_accel_get_fifo_state, NULL, 0);
-static IIO_DEVICE_ATTR(hwfifo_watermark, S_IRUGO,
-		       bmc150_accel_get_fifo_watermark, NULL, 0);
+static IIO_CONST_ATTR_HWFIFO_WATERMARK_MIN(1);
+static IIO_CONST_ATTR_HWFIFO_WATERMARK_MAX(BMC150_ACCEL_FIFO_LENGTH);
+static IIO_DEV_ATTR_HWFIFO_ENABLED(bmc150_accel_get_fifo_state);
+static IIO_DEV_ATTR_HWFIFO_WATERMARK(bmc150_accel_get_fifo_watermark);
 
 static const struct attribute *bmc150_accel_fifo_attributes[] = {
 	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index 8a1d186..8822bab 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -124,4 +124,16 @@ struct iio_const_attr {
 #define IIO_CONST_ATTR_TEMP_SCALE(_string)		\
 	IIO_CONST_ATTR(in_temp_scale, _string)
 
+#define IIO_CONST_ATTR_HWFIFO_WATERMARK_MIN(_min)	\
+	IIO_CONST_ATTR(hwfifo_watermark_min, __stringify(_min))
+
+#define IIO_CONST_ATTR_HWFIFO_WATERMARK_MAX(_max)	\
+	IIO_CONST_ATTR(hwfifo_watermark_max, __stringify(_max))
+
+#define IIO_DEV_ATTR_HWFIFO_ENABLED(_hwfifo_get_state)	\
+	IIO_DEVICE_ATTR(hwfifo_enabled, S_IRUGO, _hwfifo_get_state, NULL, 0)
+
+#define IIO_DEV_ATTR_HWFIFO_WATERMARK(_hwfifo_get_wm)	\
+	IIO_DEVICE_ATTR(hwfifo_watermark, S_IRUGO, _hwfifo_get_wm, NULL, 0)
+
 #endif /* _INDUSTRIAL_IO_SYSFS_H_ */
-- 
1.9.1
