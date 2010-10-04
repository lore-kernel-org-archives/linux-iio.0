Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 04/16] staging:iio:lis3l02dq move to new event code scheme
Date: Mon,  4 Oct 2010 16:57:53 +0100
Message-Id: <1286207885-26689-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |   36 +++++++++++++++++++++++----
 1 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 655f2b7..f52a0f5 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -639,32 +639,56 @@ static void lis3l02dq_thresh_handler_bh_no_check(struct work_struct *work_s)
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_HIGH)
 		iio_push_event(st->help.indio_dev, 0,
-			       IIO_EVENT_CODE_ACCEL_Z_HIGH,
+			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+						  0,
+						  IIO_EV_MOD_Z,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_RISING),
 			       st->thresh_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Z_LOW)
 		iio_push_event(st->help.indio_dev, 0,
-			       IIO_EVENT_CODE_ACCEL_Z_LOW,
+			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+						  0,
+						  IIO_EV_MOD_Z,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_FALLING),
 			       st->thresh_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_HIGH)
 		iio_push_event(st->help.indio_dev, 0,
-			       IIO_EVENT_CODE_ACCEL_Y_HIGH,
+			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+						  0,
+						  IIO_EV_MOD_Y,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_RISING),
 			       st->thresh_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_Y_LOW)
 		iio_push_event(st->help.indio_dev, 0,
-			       IIO_EVENT_CODE_ACCEL_Y_LOW,
+			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+						  0,
+						  IIO_EV_MOD_Y,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_FALLING),
 			       st->thresh_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_HIGH)
 		iio_push_event(st->help.indio_dev, 0,
-			       IIO_EVENT_CODE_ACCEL_X_HIGH,
+			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+						  0,
+						  IIO_EV_MOD_X,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_RISING),
 			       st->thresh_timestamp);
 
 	if (t & LIS3L02DQ_REG_WAKE_UP_SRC_INTERRUPT_X_LOW)
 		iio_push_event(st->help.indio_dev, 0,
-			       IIO_EVENT_CODE_ACCEL_X_LOW,
+			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+						  0,
+						  IIO_EV_MOD_X,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_FALLING),
 			       st->thresh_timestamp);
 	/* reenable the irq */
 	enable_irq(st->us->irq);
-- 
1.7.2.2
