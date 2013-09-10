Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:44423 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344Ab3IJMuE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:50:04 -0400
Received: by mail-ea0-f182.google.com with SMTP id o10so3942404eaj.27
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2013 05:50:03 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de, linus.walleij@linaro.org, denis.ciocca@st.com,
	linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 16/38] iio: magn: st: Append _magn to magnetometer sensor device names
Date: Tue, 10 Sep 2013 13:49:17 +0100
Message-Id: <1378817379-8238-17-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some of ST's sensors are appended with their sensor type and some
are not. For consistency we're extending the same naming convention
throughout.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/magnetometer/st_magn.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index 694e33e..f185720 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -16,7 +16,7 @@
 
 #define LSM303DLHC_MAGN_DEV_NAME	"lsm303dlhc_magn"
 #define LSM303DLM_MAGN_DEV_NAME		"lsm303dlm_magn"
-#define LIS3MDL_MAGN_DEV_NAME		"lis3mdl"
+#define LIS3MDL_MAGN_DEV_NAME		"lis3mdl_magn"
 
 int st_magn_common_probe(struct iio_dev *indio_dev,
 					struct st_sensors_platform_data *pdata);
-- 
1.8.1.2

