Return-Path: <SRS0=sxJY=FG=gmail.com=himanshujha199640@kernel.org>
From: Himanshu Jha <himanshujha199640@gmail.com>
To: 21cnbao@gmail.com,
	jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 1/4] staging: iio: accel: adis16201: Use SPDX identifier
Date: Mon, 12 Feb 2018 17:24:56 +0530
Message-Id: <1518436499-8584-2-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Use SPDX identifier format instead of GPLv2. Also, rearrange the headers
in the alphabetical order.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 2ebd275..b2145c9 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -1,19 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer
  *
  * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/delay.h>
-#include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/module.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.7.4
