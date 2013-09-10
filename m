Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:37000 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab3IJMuD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:50:03 -0400
Received: by mail-ea0-f173.google.com with SMTP id g10so3864926eak.4
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 05:50:02 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 15/38] iio: gyro: st: Append _gyro to gyroscope sensor device names
Date: Tue, 10 Sep 2013 13:49:16 +0100
Message-Id: <1378817379-8238-16-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some of ST's sensors are appended with their sensor type and some
are not. For consistency we're extending the same naming convention
throughout.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/gyro/st_gyro.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index f8f2bf8..5f0ec99 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -14,13 +14,13 @@
 #include <linux/types.h>
 #include <linux/iio/common/st_sensors.h>
 
-#define L3G4200D_GYRO_DEV_NAME		"l3g4200d"
+#define L3G4200D_GYRO_DEV_NAME		"l3g4200d_gyro"
 #define LSM330D_GYRO_DEV_NAME		"lsm330d_gyro"
 #define LSM330DL_GYRO_DEV_NAME		"lsm330dl_gyro"
 #define LSM330DLC_GYRO_DEV_NAME		"lsm330dlc_gyro"
-#define L3GD20_GYRO_DEV_NAME		"l3gd20"
-#define L3GD20H_GYRO_DEV_NAME		"l3gd20h"
-#define L3G4IS_GYRO_DEV_NAME		"l3g4is_ui"
+#define L3GD20_GYRO_DEV_NAME		"l3gd20_gyro"
+#define L3GD20H_GYRO_DEV_NAME		"l3gd20h_gyro"
+#define L3G4IS_GYRO_DEV_NAME		"l3g4is_ui_gyro"
 #define LSM330_GYRO_DEV_NAME		"lsm330_gyro"
 
 /**
-- 
1.8.1.2

