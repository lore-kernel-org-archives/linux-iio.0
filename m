Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45157 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbeBQQQ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Feb 2018 11:16:28 -0500
Received: by mail-pl0-f67.google.com with SMTP id p5so3323880plo.12
        for <linux-iio@vger.kernel.org>; Sat, 17 Feb 2018 08:16:28 -0800 (PST)
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, daniel.baluta@nxp.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH 1/3] Staging: iio: adis16209: Use SPDX identifier
Date: Sat, 17 Feb 2018 21:34:56 +0530
Message-Id: <6771b95bbfb8301724086dba4d92df6a6b11d6f7.1518883035.git.shreeya.patel23498@gmail.com>
In-Reply-To: <cover.1518883035.git.shreeya.patel23498@gmail.com>
References: <cover.1518883035.git.shreeya.patel23498@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use SPDX identifier format instead of GPLv2. Also rearrange the
headers in alphabetical order.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/accel/adis16209.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 7fcef9a..e3d9f80 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -1,19 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer
  *
  * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
-#include <linux/module.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.7.4

