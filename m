Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 03/16] staging:iio:adc events update to new numbering system
Date: Mon,  4 Oct 2010 16:57:52 +0100
Message-Id: <1286207885-26689-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/adc.h |    8 ++++++--
 drivers/staging/iio/sysfs.h   |    1 -
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/adc.h b/drivers/staging/iio/adc/adc.h
index 953b5ce..4f13427 100644
--- a/drivers/staging/iio/adc/adc.h
+++ b/drivers/staging/iio/adc/adc.h
@@ -34,5 +34,9 @@
 #define IIO_CONST_ATTR_IN_NAMED_SCALE(_name, _string)			\
 	IIO_CONST_ATTR(in_##_name##_scale, _string)
 
-#define IIO_EVENT_CODE_IN_HIGH_THRESH(a) (IIO_EVENT_CODE_ADC_BASE  + a)
-#define IIO_EVENT_CODE_IN_LOW_THRESH(a) (IIO_EVENT_CODE_ADC_BASE  + a + 32)
+#define IIO_EVENT_CODE_IN_HIGH_THRESH(a)				\
+	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, a, IIO_EV_TYPE_THRESH,	\
+			     IIO_EV_DIR_RISING)
+#define IIO_EVENT_CODE_IN_LOW_THRESH(a)				     \
+	IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN, a, IIO_EV_TYPE_THRESH, \
+			     IIO_EV_DIR_FALLING)
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 7707f8f..491c904 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -285,7 +285,6 @@ struct iio_const_attr {
 #define IIO_EVENT_CODE_RING_BASE	200
 #define IIO_EVENT_CODE_ACCEL_BASE	300
 #define IIO_EVENT_CODE_GYRO_BASE	400
-#define IIO_EVENT_CODE_ADC_BASE		500
 #define IIO_EVENT_CODE_MISC_BASE	600
 #define IIO_EVENT_CODE_LIGHT_BASE	700
 
-- 
1.7.2.2
