Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com, jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, stable@kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/6] IIO: IMU: ADIS16400: Add delay after self test
Date: Mon, 21 Mar 2011 16:44:36 +0100
Message-ID: <1300722280-10720-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1300722280-10720-1-git-send-email-michael.hennerich@analog.com>
References: <1300722280-10720-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Add delay after self test to satisfy timing requirements.
Increase start-up delay.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
CC: stable <stable@kernel.org>
---
 drivers/staging/iio/imu/adis16400.h      |    3 ++-
 drivers/staging/iio/imu/adis16400_core.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index 6ff33e1..90e90f0 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -17,7 +17,8 @@
 #ifndef SPI_ADIS16400_H_
 #define SPI_ADIS16400_H_

-#define ADIS16400_STARTUP_DELAY	220 /* ms */
+#define ADIS16400_STARTUP_DELAY	290 /* ms */
+#define ADIS16400_MTEST_DELAY 90 /* ms */

 #define ADIS16400_READ_REG(a)    a
 #define ADIS16400_WRITE_REG(a) ((a) | 0x80)
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 1007e3d..633b3a4 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -373,7 +373,7 @@ static int adis16400_self_test(struct device *dev)
 		dev_err(dev, "problem starting self test");
 		goto err_ret;
 	}
-
+	msleep(ADIS16400_MTEST_DELAY);
 	adis16400_check_status(dev);

 err_ret:
--
1.6.0.2
