Return-Path: <SRS0=+IOg=GM=gmail.com=himanshujha199640@kernel.org>
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	21cnbao@gmail.com,
	Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 1/4] Staging: iio: accel: adis16201: Remove unused headers
Date: Fri, 23 Mar 2018 00:42:42 +0530
Message-Id: <1521745965-26972-1-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1521230786-18155-10-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-10-git-send-email-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Remove few unused headers files since the adis core handles the buffer and
sysfs support.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 97e25a3..b04dbb3 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -6,7 +6,6 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -16,8 +15,6 @@
 #include <linux/sysfs.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
 #define ADIS16201_STARTUP_DELAY_MS			220
-- 
2.7.4
