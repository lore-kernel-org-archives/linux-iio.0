Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 11/16] staging:iio:accel remove deprecated and misleading event macros.
Date: Mon,  4 Oct 2010 16:58:00 +0100
Message-Id: <1286207885-26689-12-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/accel.h |  107 -------------------------------------
 1 files changed, 0 insertions(+), 107 deletions(-)

diff --git a/drivers/staging/iio/accel/accel.h b/drivers/staging/iio/accel/accel.h
index 3b6be2e..f5f61b2 100644
--- a/drivers/staging/iio/accel/accel.h
+++ b/drivers/staging/iio/accel/accel.h
@@ -65,110 +65,3 @@
 #define IIO_DEV_ATTR_ACCEL_Z(_show, _addr)			\
 	IIO_DEVICE_ATTR(accel_z_raw, S_IRUGO, _show, NULL, _addr)
 
-/* Thresholds are somewhat chip dependent - may need quite a few defs here */
-/* For unified thresholds (shared across all directions */
-
-/**
- * IIO_DEV_ATTR_ACCEL_THRESH: unified threshold
- * @_mode: read/write
- * @_show: read detector threshold value
- * @_store: write detector threshold value
- * @_addr: driver specific data, typically a register address
- *
- * This one is for cases where as single threshold covers all directions
- **/
-#define IIO_DEV_ATTR_ACCEL_THRESH(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(thresh, _mode, _show, _store, _addr)
-
-/**
- * IIO_DEV_ATTR_ACCEL_THRESH_X: independant direction threshold, x axis
- * @_mode: readable / writable
- * @_show: read x axis detector threshold value
- * @_store: write x axis detector threshold value
- * @_addr: device driver dependant, typically a register address
- **/
-#define IIO_DEV_ATTR_ACCEL_THRESH_X(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(thresh_accel_x, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_THRESH_Y(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(thresh_accel_y, _mode, _show, _store, _addr)
-
-#define IIO_DEV_ATTR_ACCEL_THRESH_Z(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(thresh_accel_z, _mode, _show, _store, _addr)
-
-/**
- * IIO_EVENT_ATTR_ACCEL_X_HIGH: threshold event, x acceleration
- * @_show: read x acceleration high threshold
- * @_store: write x acceleration high threshold
- * @_mask: device dependant, typically a bit mask
- * @_handler: the iio_handler associated with this attribute
- **/
-#define IIO_EVENT_ATTR_ACCEL_X_HIGH(_show, _store, _mask, _handler)	\
-	IIO_EVENT_ATTR(accel_x_high, _show, _store, _mask, _handler)
-
-/**
- * IIO_EVENT_ATTR_ACCEL_X_HIGH_SH: threshold event, x accel high, shared handler
- * @_evlist: event list used to share the handler
- * @_show: attribute read
- * @_store: attribute write
- * @_mask: driver specific data, typically a bit mask
- **/
-#define IIO_EVENT_ATTR_ACCEL_X_HIGH_SH(_evlist, _show, _store, _mask)	\
-	IIO_EVENT_ATTR_SH(accel_x_high, _evlist, _show, _store, _mask)
-
-/**
- * IIO_EVENT_CODE_ACCEL_X_HIGH - event code for x axis high accel threshold
- **/
-#define IIO_EVENT_ATTR_ACCEL_Y_HIGH(_show, _store, _mask, _handler)	\
-	IIO_EVENT_ATTR(accel_y_high, _show, _store, _mask, _handler)
-
-#define IIO_EVENT_ATTR_ACCEL_Y_HIGH_SH(_evlist, _show, _store, _mask)	\
-	IIO_EVENT_ATTR_SH(accel_y_high, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_ATTR_ACCEL_Z_HIGH(_show, _store, _mask, _handler)	\
-	IIO_EVENT_ATTR(accel_z_high, _show, _store, _mask, _handler)
-
-#define IIO_EVENT_ATTR_ACCEL_Z_HIGH_SH(_evlist, _show, _store, _mask)	\
-	IIO_EVENT_ATTR_SH(accel_z_high, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_ATTR_ACCEL_X_LOW(_show, _store, _mask, _handler)	\
-	IIO_EVENT_ATTR(accel_x_low, _show, _store, _mask, _handler)
-
-#define IIO_EVENT_ATTR_ACCEL_X_LOW_SH(_evlist, _show, _store, _mask)	\
-	IIO_EVENT_ATTR_SH(accel_x_low, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_ATTR_ACCEL_Y_LOW(_show, _store, _mask, _handler) \
-	IIO_EVENT_ATTR(accel_y_low, _show, _store, _mask, _handler)
-
-#define IIO_EVENT_ATTR_ACCEL_Y_LOW_SH(_evlist, _show, _store, _mask)\
-	IIO_EVENT_ATTR_SH(accel_y_low, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_ATTR_ACCEL_Z_LOW(_show, _store, _mask, _handler)	\
-	IIO_EVENT_ATTR(accel_z_low, _show, _store, _mask, _handler)
-
-#define IIO_EVENT_ATTR_ACCEL_Z_LOW_SH(_evlist, _show, _store, _mask)	\
-	IIO_EVENT_ATTR_SH(accel_z_low, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_ATTR_FREE_FALL_DETECT(_show, _store, _mask, _handler)	\
-	IIO_EVENT_ATTR(free_fall, _show, _store, _mask, _handler)
-
-#define IIO_EVENT_ATTR_FREE_FALL_DETECT_SH(_evlist, _show, _store, _mask) \
-	IIO_EVENT_ATTR_SH(free_fall, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_ATTR_ACCEL_X_ROC_HIGH_SH(_evlist, _show, _store, _mask) \
-	IIO_EVENT_ATTR_SH(accel_x_roc_high, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_ATTR_ACCEL_X_ROC_LOW_SH(_evlist, _show, _store, _mask) \
-	IIO_EVENT_ATTR_SH(accel_x_roc_low, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_ATTR_ACCEL_Y_ROC_HIGH_SH(_evlist, _show, _store, _mask) \
-	IIO_EVENT_ATTR_SH(accel_y_roc_high, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_ATTR_ACCEL_Y_ROC_LOW_SH(_evlist, _show, _store, _mask) \
-	IIO_EVENT_ATTR_SH(accel_y_roc_low, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_ATTR_ACCEL_Z_ROC_HIGH_SH(_evlist, _show, _store, _mask) \
-	IIO_EVENT_ATTR_SH(accel_z_roc_high, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_ATTR_ACCEL_Z_ROC_LOW_SH(_evlist, _show, _store, _mask) \
-	IIO_EVENT_ATTR_SH(accel_z_roc_low, _evlist, _show, _store, _mask)
-- 
1.7.2.2
