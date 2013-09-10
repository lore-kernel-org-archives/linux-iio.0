Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f176.google.com ([209.85.215.176]:53140 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301Ab3IJMuC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:50:02 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so3855780ead.35
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 05:50:01 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 14/38] iio: accel: st: Append _accel to accelerator sensor device names
Date: Tue, 10 Sep 2013 13:49:15 +0100
Message-Id: <1378817379-8238-15-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some of ST's sensors are appended with their sensor type and some
are not. For consistency we're extending the same naming convention
throughout.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/accel/st_accel.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index c387763..d8d22e5 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -15,11 +15,11 @@
 #include <linux/iio/common/st_sensors.h>
 
 #define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc_accel"
-#define LIS3DH_ACCEL_DEV_NAME		"lis3dh"
+#define LIS3DH_ACCEL_DEV_NAME		"lis3dh_accel"
 #define LSM330D_ACCEL_DEV_NAME		"lsm330d_accel"
 #define LSM330DL_ACCEL_DEV_NAME		"lsm330dl_accel"
 #define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc_accel"
-#define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh"
+#define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh_accel"
 #define LSM303DL_ACCEL_DEV_NAME		"lsm303dl_accel"
 #define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh_accel"
 #define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm_accel"
-- 
1.8.1.2

