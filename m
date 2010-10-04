Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 07/16] staging:iio:tsl2563 move to new event numbering scheme and remove old definitions
Date: Mon,  4 Oct 2010 16:57:56 +0100
Message-Id: <1286207885-26689-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/light.h   |    2 --
 drivers/staging/iio/light/tsl2563.c |    7 +++++--
 drivers/staging/iio/sysfs.h         |    1 -
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/light.h b/drivers/staging/iio/light/light.h
index e4e1e2c..8328658 100644
--- a/drivers/staging/iio/light/light.h
+++ b/drivers/staging/iio/light/light.h
@@ -2,6 +2,4 @@
 
 /* Light to digital sensor attributes */
 
-#define IIO_EVENT_CODE_LIGHT_THRESH IIO_EVENT_CODE_LIGHT_BASE
-
 
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index 98f8b78..98149e1 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -706,8 +706,11 @@ static void tsl2563_int_bh(struct work_struct *work_s)
 	u8 cmd = TSL2563_CMD | TSL2563_CLEARINT;
 
 	iio_push_event(chip->indio_dev, 0,
-		IIO_EVENT_CODE_LIGHT_BASE,
-		chip->event_timestamp);
+		       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_LIGHT,
+					    0,
+					    IIO_EV_TYPE_THRESH,
+					    IIO_EV_DIR_EITHER),
+		       chip->event_timestamp);
 
 	/* reenable_irq */
 	enable_irq(chip->client->irq);
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 2064009..116dacf 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -294,7 +294,6 @@ struct iio_const_attr {
 #define IIO_EVENT_CODE_ACCEL_BASE	300
 #define IIO_EVENT_CODE_GYRO_BASE	400
 #define IIO_EVENT_CODE_MISC_BASE	600
-#define IIO_EVENT_CODE_LIGHT_BASE	700
 
 #define IIO_EVENT_CODE_DEVICE_SPECIFIC	1000
 
-- 
1.7.2.2
