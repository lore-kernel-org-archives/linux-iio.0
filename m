Return-Path: <SRS0=MY0P=3R=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH] iio: imu: st_lsm6dsx: simplify data ready pin parsing
Date: Sun,  9 Apr 2017 20:03:37 +0200
Message-Id: <20170409180337.12717-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Simplify st_lsm6dsx_of_get_drdy_pin routine since of_property_read_u32
error conditions are already managed in st_lsm6dsx_get_drdy_reg()

Fixes: dba329048ee5 (iio: imu: st_lsm6dsx: add possibility to select drdy pin)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 98b51d7..462a27b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -559,19 +559,11 @@ static const unsigned long st_lsm6dsx_available_scan_masks[] = {0x7, 0x0};
 static int st_lsm6dsx_of_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_pin)
 {
 	struct device_node *np = hw->dev->of_node;
-	int err;
 
 	if (!np)
 		return -EINVAL;
 
-	err = of_property_read_u32(np, "st,drdy-int-pin", drdy_pin);
-	if (err == -ENODATA) {
-		/* if the property has not been specified use default value */
-		*drdy_pin = 1;
-		err = 0;
-	}
-
-	return err;
+	return of_property_read_u32(np, "st,drdy-int-pin", drdy_pin);
 }
 
 static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
-- 
2.9.3
