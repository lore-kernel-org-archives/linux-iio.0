Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 08/11] staging:iio: Fix IIO_EVENT_ATTR initialization of list head
Date: Mon, 24 May 2010 22:02:53 +0100
Message-Id: <1274734976-7941-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
References: <1274734976-7941-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/sysfs.h |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index afcf5ab..79926ef 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -293,10 +293,7 @@ struct iio_const_attr {
  * @_handler: handler function to be called
  **/
 #define IIO_EVENT_ATTR(_name, _show, _store, _mask, _handler)		\
-	static struct iio_event_handler_list				\
-	iio_event_##_name = {						\
-		.handler = _handler,					\
-	};								\
+	IIO_EVENT_SH(_name, _handler);					\
 	static struct							\
 	iio_event_attr							\
 	iio_event_attr_##_name						\
@@ -324,6 +321,7 @@ struct iio_const_attr {
 #define IIO_EVENT_CODE_GYRO_BASE	400
 #define IIO_EVENT_CODE_ADC_BASE		500
 #define IIO_EVENT_CODE_MISC_BASE	600
+#define IIO_EVENT_CODE_LIGHT_BASE	700
 
 #define IIO_EVENT_CODE_DEVICE_SPECIFIC	1000
 
-- 
1.7.0.4
