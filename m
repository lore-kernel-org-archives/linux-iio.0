Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:18957 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932514Ab3GBKNo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 06:13:44 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MPB00HY70DJ3GC0@mailout1.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 02 Jul 2013 19:13:43 +0900 (KST)
From: Jacek Anaszewski <j.anaszewski@samsung.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, s.nawrocki@samsun.com,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH 2/2] iio: lps331ap: Modify in_temp_scale calculation way
Date: Tue, 02 Jul 2013 12:13:23 +0200
Message-id: <1372760003-32090-3-git-send-email-j.anaszewski@samsung.com>
In-reply-to: <1372760003-32090-1-git-send-email-j.anaszewski@samsung.com>
References: <1372760003-32090-1-git-send-email-j.anaszewski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch modifies the way how the in_temp_scale output value is
calculated. With this implementation it is more clear how the value
is obtained.

Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/iio/pressure/st_pressure_core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 89eb40a..09d94a6 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -31,6 +31,9 @@
 #define ST_PRESS_LSB_PER_MBAR			4096UL
 #define ST_PRESS_KPASCAL_NANO_SCALE		(100000000UL / \
 						 ST_PRESS_LSB_PER_MBAR)
+#define ST_PRESS_LSB_PER_CELSIUS		480UL
+#define ST_PRESS_CELSIUS_NANO_SCALE		(1000000000UL / \
+						 ST_PRESS_LSB_PER_CELSIUS)
 #define ST_PRESS_NUMBER_DATA_CHANNELS		1
 
 /* DEFAULT VALUE FOR SENSORS */
@@ -53,8 +56,8 @@
 #define ST_PRESS_1_FS_ADDR			0x23
 #define ST_PRESS_1_FS_MASK			0x30
 #define ST_PRESS_1_FS_AVL_1260_VAL		0x00
-#define ST_PRESS_1_FS_AVL_TEMP_GAIN		2083000
 #define ST_PRESS_1_FS_AVL_1260_GAIN		ST_PRESS_KPASCAL_NANO_SCALE
+#define ST_PRESS_1_FS_AVL_TEMP_GAIN		ST_PRESS_CELSIUS_NANO_SCALE
 #define ST_PRESS_1_BDU_ADDR			0x20
 #define ST_PRESS_1_BDU_MASK			0x04
 #define ST_PRESS_1_DRDY_IRQ_ADDR		0x22
-- 
1.7.5.4

