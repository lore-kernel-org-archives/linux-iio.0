Return-Path: <SRS0=hlQU=5L=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com,
	denis.ciocca@st.com
Subject: [PATCH 2/2] iio: magnetometer: st_magn_spi: fix spi_device_id table
Date: Tue,  6 Jun 2017 22:51:24 +0200
Message-Id: <20170606205124.14905-3-lorenzo.bianconi@st.com>
In-Reply-To: <20170606205124.14905-1-lorenzo.bianconi@st.com>
References: <20170606205124.14905-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Remove LSM303DLHC, LSM303DLM from st_magn_id_table since LSM303DL series
does not support spi interface

Fixes: 872e79add756 (iio: magn: Add STMicroelectronics magn driver)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/magnetometer/st_magn_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 6325e7dc8e03..f3cb4dc05391 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -48,8 +48,6 @@ static int st_magn_spi_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id st_magn_id_table[] = {
-	{ LSM303DLHC_MAGN_DEV_NAME },
-	{ LSM303DLM_MAGN_DEV_NAME },
 	{ LIS3MDL_MAGN_DEV_NAME },
 	{ LSM303AGR_MAGN_DEV_NAME },
 	{},
-- 
2.12.2
