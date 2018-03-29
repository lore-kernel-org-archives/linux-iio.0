Return-Path: <SRS0=2H+Q=GT=gmail.com=shreeya.patel23498@kernel.org>
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	daniel.baluta@gmail.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH v6 4/6] Staging: iio: adis16209: Remove unused headers
Date: Thu, 29 Mar 2018 14:49:22 +0530
Message-Id: <52f7695224d2026d03fc5823a8a8c45ab48bbfe9.1522306893.git.shreeya.patel23498@gmail.com>
In-Reply-To: <cover.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Remove few unused header files since the adis core handles
the sysfs and buffer support.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v6
  -Introduce this new patch in the series.

 drivers/staging/iio/accel/adis16209.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index ee7e87b..ed6d7c7 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -6,7 +6,6 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -16,8 +15,6 @@
 #include <linux/sysfs.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
 #define ADIS16209_STARTUP_DELAY_MS	220
-- 
2.7.4
