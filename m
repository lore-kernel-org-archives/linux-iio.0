Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60237 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046Ab3GBKNl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 06:13:41 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MPB00F5K0ESSU00@mailout4.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 02 Jul 2013 19:13:40 +0900 (KST)
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, s.nawrocki@samsun.com,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 1/2] iio: lps331ap: Fix wrong in_pressure_scale output value
Date: Tue, 02 Jul 2013 12:13:22 +0200
Message-id: <1372760003-32090-2-git-send-email-j.anaszewski@samsung.com>
In-reply-to: <1372760003-32090-1-git-send-email-j.anaszewski@samsung.com>
References: <1372760003-32090-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes improper in_pressure_scale output that is
returned by the lps331ap barometer sensor driver. According
to the documentation the pressure after applying the scale has to
be expressed in kilopascal units. With erroneous implementation
the scale value larger by two orders of magnitude is returned -
2441410 instead of 24414.

Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/iio/pressure/st_pressure_core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index aacea2a..89eb40a 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -28,7 +28,9 @@
 #include <linux/iio/common/st_sensors.h>
 #include "st_pressure.h"
 
-#define ST_PRESS_MBAR_TO_KPASCAL(x)		(x * 10)
+#define ST_PRESS_LSB_PER_MBAR			4096UL
+#define ST_PRESS_KPASCAL_NANO_SCALE		(100000000UL / \
+						 ST_PRESS_LSB_PER_MBAR)
 #define ST_PRESS_NUMBER_DATA_CHANNELS		1
 
 /* DEFAULT VALUE FOR SENSORS */
@@ -51,8 +53,8 @@
 #define ST_PRESS_1_FS_ADDR			0x23
 #define ST_PRESS_1_FS_MASK			0x30
 #define ST_PRESS_1_FS_AVL_1260_VAL		0x00
-#define ST_PRESS_1_FS_AVL_1260_GAIN		ST_PRESS_MBAR_TO_KPASCAL(244141)
 #define ST_PRESS_1_FS_AVL_TEMP_GAIN		2083000
+#define ST_PRESS_1_FS_AVL_1260_GAIN		ST_PRESS_KPASCAL_NANO_SCALE
 #define ST_PRESS_1_BDU_ADDR			0x20
 #define ST_PRESS_1_BDU_MASK			0x04
 #define ST_PRESS_1_DRDY_IRQ_ADDR		0x22
-- 
1.7.5.4

