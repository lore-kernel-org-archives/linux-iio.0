Return-Path: <SRS0=wolE=JC=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Eva Rachel Retuya <eraretuya@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/4] iio: accel: adxl345: add link to datasheet
Date: Sun, 17 Jun 2018 00:04:40 +0900
Message-Id: <1529161484-28781-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1529161484-28781-1-git-send-email-akinobu.mita@gmail.com>
References: <1529161484-28781-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add a link to the ADXL345 datasheet

Cc: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7251d0e..8e0d56b 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -6,6 +6,8 @@
  * This file is subject to the terms and conditions of version 2 of
  * the GNU General Public License. See the file COPYING in the main
  * directory of this archive for more details.
+ *
+ * Datasheet: http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
  */
 
 #include <linux/module.h>
-- 
2.7.4
