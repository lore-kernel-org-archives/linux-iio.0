Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36205 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751483AbdFFUv3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jun 2017 16:51:29 -0400
Received: by mail-wr0-f194.google.com with SMTP id e23so10112411wre.3
        for <linux-iio@vger.kernel.org>; Tue, 06 Jun 2017 13:51:28 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com,
        denis.ciocca@st.com
Subject: [PATCH 1/2] iio: accel: st_accel_spi: fix spi_device_id table
Date: Tue,  6 Jun 2017 22:51:23 +0200
Message-Id: <20170606205124.14905-2-lorenzo.bianconi@st.com>
In-Reply-To: <20170606205124.14905-1-lorenzo.bianconi@st.com>
References: <20170606205124.14905-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove LSM303DL, LSM303DLM, LSM303DLH, LSM303DLHC from st_accel_id_table
since LSM303DL series does not support spi interface

Fixes: d62511689de5 (iio: accel: Add STMicroelectronics accel driver)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/accel/st_accel_spi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 29a15f27a51b..1a867f5563a4 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -47,15 +47,11 @@ static int st_accel_spi_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id st_accel_id_table[] = {
-	{ LSM303DLH_ACCEL_DEV_NAME },
-	{ LSM303DLHC_ACCEL_DEV_NAME },
 	{ LIS3DH_ACCEL_DEV_NAME },
 	{ LSM330D_ACCEL_DEV_NAME },
 	{ LSM330DL_ACCEL_DEV_NAME },
 	{ LSM330DLC_ACCEL_DEV_NAME },
 	{ LIS331DLH_ACCEL_DEV_NAME },
-	{ LSM303DL_ACCEL_DEV_NAME },
-	{ LSM303DLM_ACCEL_DEV_NAME },
 	{ LSM330_ACCEL_DEV_NAME },
 	{ LSM303AGR_ACCEL_DEV_NAME },
 	{ LIS2DH12_ACCEL_DEV_NAME },
-- 
2.12.2

