Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 06/16] staging:iio:accel remove old event codes
Date: Mon,  4 Oct 2010 16:57:55 +0100
Message-Id: <1286207885-26689-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Joanthan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/accel.h |   27 ---------------------------
 1 files changed, 0 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/iio/accel/accel.h b/drivers/staging/iio/accel/accel.h
index 01e9302..3b6be2e 100644
--- a/drivers/staging/iio/accel/accel.h
+++ b/drivers/staging/iio/accel/accel.h
@@ -119,83 +119,56 @@
 /**
  * IIO_EVENT_CODE_ACCEL_X_HIGH - event code for x axis high accel threshold
  **/
-#define IIO_EVENT_CODE_ACCEL_X_HIGH IIO_EVENT_CODE_ACCEL_BASE
-
 #define IIO_EVENT_ATTR_ACCEL_Y_HIGH(_show, _store, _mask, _handler)	\
 	IIO_EVENT_ATTR(accel_y_high, _show, _store, _mask, _handler)
 
 #define IIO_EVENT_ATTR_ACCEL_Y_HIGH_SH(_evlist, _show, _store, _mask)	\
 	IIO_EVENT_ATTR_SH(accel_y_high, _evlist, _show, _store, _mask)
 
-#define IIO_EVENT_CODE_ACCEL_Y_HIGH (IIO_EVENT_CODE_ACCEL_BASE + 1)
-
 #define IIO_EVENT_ATTR_ACCEL_Z_HIGH(_show, _store, _mask, _handler)	\
 	IIO_EVENT_ATTR(accel_z_high, _show, _store, _mask, _handler)
 
 #define IIO_EVENT_ATTR_ACCEL_Z_HIGH_SH(_evlist, _show, _store, _mask)	\
 	IIO_EVENT_ATTR_SH(accel_z_high, _evlist, _show, _store, _mask)
 
-#define IIO_EVENT_CODE_ACCEL_Z_HIGH (IIO_EVENT_CODE_ACCEL_BASE + 2)
-
 #define IIO_EVENT_ATTR_ACCEL_X_LOW(_show, _store, _mask, _handler)	\
 	IIO_EVENT_ATTR(accel_x_low, _show, _store, _mask, _handler)
 
 #define IIO_EVENT_ATTR_ACCEL_X_LOW_SH(_evlist, _show, _store, _mask)	\
 	IIO_EVENT_ATTR_SH(accel_x_low, _evlist, _show, _store, _mask)
 
-#define IIO_EVENT_CODE_ACCEL_X_LOW (IIO_EVENT_CODE_ACCEL_BASE + 3)
-
 #define IIO_EVENT_ATTR_ACCEL_Y_LOW(_show, _store, _mask, _handler) \
 	IIO_EVENT_ATTR(accel_y_low, _show, _store, _mask, _handler)
 
 #define IIO_EVENT_ATTR_ACCEL_Y_LOW_SH(_evlist, _show, _store, _mask)\
 	IIO_EVENT_ATTR_SH(accel_y_low, _evlist, _show, _store, _mask)
 
-#define IIO_EVENT_CODE_ACCEL_Y_LOW (IIO_EVENT_CODE_ACCEL_BASE + 4)
-
 #define IIO_EVENT_ATTR_ACCEL_Z_LOW(_show, _store, _mask, _handler)	\
 	IIO_EVENT_ATTR(accel_z_low, _show, _store, _mask, _handler)
 
 #define IIO_EVENT_ATTR_ACCEL_Z_LOW_SH(_evlist, _show, _store, _mask)	\
 	IIO_EVENT_ATTR_SH(accel_z_low, _evlist, _show, _store, _mask)
 
-#define IIO_EVENT_CODE_ACCEL_Z_LOW (IIO_EVENT_CODE_ACCEL_BASE + 5)
-
 #define IIO_EVENT_ATTR_FREE_FALL_DETECT(_show, _store, _mask, _handler)	\
 	IIO_EVENT_ATTR(free_fall, _show, _store, _mask, _handler)
 
 #define IIO_EVENT_ATTR_FREE_FALL_DETECT_SH(_evlist, _show, _store, _mask) \
 	IIO_EVENT_ATTR_SH(free_fall, _evlist, _show, _store, _mask)
 
-#define IIO_EVENT_CODE_FREE_FALL (IIO_EVENT_CODE_ACCEL_BASE + 6)
-
-
 #define IIO_EVENT_ATTR_ACCEL_X_ROC_HIGH_SH(_evlist, _show, _store, _mask) \
 	IIO_EVENT_ATTR_SH(accel_x_roc_high, _evlist, _show, _store, _mask)
 
-#define IIO_EVENT_CODE_ACCEL_X_ROC_HIGH (IIO_EVENT_CODE_ACCEL_BASE + 10)
-
 #define IIO_EVENT_ATTR_ACCEL_X_ROC_LOW_SH(_evlist, _show, _store, _mask) \
 	IIO_EVENT_ATTR_SH(accel_x_roc_low, _evlist, _show, _store, _mask)
 
-#define IIO_EVENT_CODE_ACCEL_X_ROC_LOW (IIO_EVENT_CODE_ACCEL_BASE + 11)
-
 #define IIO_EVENT_ATTR_ACCEL_Y_ROC_HIGH_SH(_evlist, _show, _store, _mask) \
 	IIO_EVENT_ATTR_SH(accel_y_roc_high, _evlist, _show, _store, _mask)
 
-#define IIO_EVENT_CODE_ACCEL_Y_ROC_HIGH (IIO_EVENT_CODE_ACCEL_BASE + 12)
-
 #define IIO_EVENT_ATTR_ACCEL_Y_ROC_LOW_SH(_evlist, _show, _store, _mask) \
 	IIO_EVENT_ATTR_SH(accel_y_roc_low, _evlist, _show, _store, _mask)
 
-#define IIO_EVENT_CODE_ACCEL_Y_ROC_LOW (IIO_EVENT_CODE_ACCEL_BASE + 13)
-
 #define IIO_EVENT_ATTR_ACCEL_Z_ROC_HIGH_SH(_evlist, _show, _store, _mask) \
 	IIO_EVENT_ATTR_SH(accel_z_roc_high, _evlist, _show, _store, _mask)
 
-#define IIO_EVENT_CODE_ACCEL_Z_ROC_HIGH (IIO_EVENT_CODE_ACCEL_BASE + 14)
-
 #define IIO_EVENT_ATTR_ACCEL_Z_ROC_LOW_SH(_evlist, _show, _store, _mask) \
 	IIO_EVENT_ATTR_SH(accel_z_roc_low, _evlist, _show, _store, _mask)
-
-#define IIO_EVENT_CODE_ACCEL_Z_ROC_LOW (IIO_EVENT_CODE_ACCEL_BASE + 15)
-- 
1.7.2.2
