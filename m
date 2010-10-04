Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 05/16] staging:iio:sca3000 move to new event code scheme and add combined orientations
Date: Mon,  4 Oct 2010 16:57:54 +0100
Message-Id: <1286207885-26689-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The combined orientations allow handling of typical motion and free fall
detectors to be handled as threshold events just applied to a number of
axes via boolean operations.  So freefall is when x, y and z magnitudes
are all below a threshold for a particular period.  Motion detectors
are typically whether x or y or z are above a particular value.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/sca3000_core.c |   24 ++++++++++++++++++++----
 drivers/staging/iio/sysfs.h              |    8 ++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 0eb2c4c..b5fa51f 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -865,22 +865,38 @@ static void sca3000_interrupt_handler_bh(struct work_struct *work_s)
 
 	if (rx[1] & SCA3000_INT_STATUS_FREE_FALL)
 		iio_push_event(st->indio_dev, 0,
-			       IIO_EVENT_CODE_FREE_FALL,
+			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+						  0,
+						  IIO_EV_MOD_X_AND_Y_AND_Z,
+						  IIO_EV_TYPE_MAG,
+						  IIO_EV_DIR_FALLING),
 			       st->last_timestamp);
 
 	if (rx[1] & SCA3000_INT_STATUS_Y_TRIGGER)
 		iio_push_event(st->indio_dev, 0,
-			       IIO_EVENT_CODE_ACCEL_Y_HIGH,
+			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+						  0,
+						  IIO_EV_MOD_Y,
+						  IIO_EV_TYPE_MAG,
+						  IIO_EV_DIR_RISING),
 			       st->last_timestamp);
 
 	if (rx[1] & SCA3000_INT_STATUS_X_TRIGGER)
 		iio_push_event(st->indio_dev, 0,
-			       IIO_EVENT_CODE_ACCEL_X_HIGH,
+			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+						  0,
+						  IIO_EV_MOD_X,
+						  IIO_EV_TYPE_MAG,
+						  IIO_EV_DIR_RISING),
 			       st->last_timestamp);
 
 	if (rx[1] & SCA3000_INT_STATUS_Z_TRIGGER)
 		iio_push_event(st->indio_dev, 0,
-			       IIO_EVENT_CODE_ACCEL_Z_HIGH,
+			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
+						  0,
+						  IIO_EV_MOD_Z,
+						  IIO_EV_TYPE_MAG,
+						  IIO_EV_DIR_RISING),
 			       st->last_timestamp);
 
 done:
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 491c904..2064009 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -260,6 +260,14 @@ struct iio_const_attr {
 #define IIO_EV_MOD_X			0
 #define IIO_EV_MOD_Y			1
 #define IIO_EV_MOD_Z			2
+#define IIO_EV_MOD_X_AND_Y		3
+#define IIO_EV_MOD_X_ANX_Z		4
+#define IIO_EV_MOD_Y_AND_Z		5
+#define IIO_EV_MOD_X_AND_Y_AND_Z	6
+#define IIO_EV_MOD_X_OR_Y		7
+#define IIO_EV_MOD_X_OR_Z		8
+#define IIO_EV_MOD_Y_OR_Z		9
+#define IIO_EV_MOD_X_OR_Y_OR_Z		10
 
 #define IIO_EV_TYPE_THRESH		0
 #define IIO_EV_TYPE_MAG			1
-- 
1.7.2.2
