Return-Path: <SRS0=KDzU=ZL=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 1/5] iio: imu: st_lsm6dsx: add support to multiple devices with the same settings
Date: Sun, 29 Jan 2017 11:49:24 +0100
Message-Id: <20170129104928.15533-2-lorenzo.bianconi@st.com>
In-Reply-To: <20170129104928.15533-1-lorenzo.bianconi@st.com>
References: <20170129104928.15533-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Add capability to support multiple devices with the same
st_lsm6dsx_settings like LSM6DSM/LSM6DSL

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 +++++++++++++++-------------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 69deafe..2c1bb9e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -20,6 +20,7 @@
 enum st_lsm6dsx_hw_id {
 	ST_LSM6DS3_ID,
 	ST_LSM6DSM_ID,
+	ST_LSM6DSX_MAX_ID,
 };
 
 #define ST_LSM6DSX_CHAN_SIZE		2
@@ -50,7 +51,7 @@ struct st_lsm6dsx_reg {
 struct st_lsm6dsx_settings {
 	u8 wai;
 	u16 max_fifo_size;
-	enum st_lsm6dsx_hw_id id;
+	enum st_lsm6dsx_hw_id id[ST_LSM6DSX_MAX_ID];
 };
 
 enum st_lsm6dsx_sensor_id {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index c92ddcc..499e60a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -74,12 +74,6 @@
 #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
 #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
 
-#define ST_LSM6DS3_WHOAMI			0x69
-#define ST_LSM6DSM_WHOAMI			0x6a
-
-#define ST_LSM6DS3_MAX_FIFO_SIZE		8192
-#define ST_LSM6DSM_MAX_FIFO_SIZE		4096
-
 #define ST_LSM6DSX_ACC_FS_2G_GAIN		IIO_G_TO_M_S_2(61)
 #define ST_LSM6DSX_ACC_FS_4G_GAIN		IIO_G_TO_M_S_2(122)
 #define ST_LSM6DSX_ACC_FS_8G_GAIN		IIO_G_TO_M_S_2(244)
@@ -164,14 +158,18 @@ static const struct st_lsm6dsx_fs_table_entry st_lsm6dsx_fs_table[] = {
 
 static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 	{
-		.wai = ST_LSM6DS3_WHOAMI,
-		.max_fifo_size = ST_LSM6DS3_MAX_FIFO_SIZE,
-		.id = ST_LSM6DS3_ID,
+		.wai = 0x69,
+		.max_fifo_size = 8192,
+		.id = {
+			[0] = ST_LSM6DS3_ID,
+		},
 	},
 	{
-		.wai = ST_LSM6DSM_WHOAMI,
-		.max_fifo_size = ST_LSM6DSM_MAX_FIFO_SIZE,
-		.id = ST_LSM6DSM_ID,
+		.wai = 0x6a,
+		.max_fifo_size = 4096,
+		.id = {
+			[0] = ST_LSM6DSM_ID,
+		},
 	},
 };
 
@@ -241,11 +239,15 @@ int st_lsm6dsx_write_with_mask(struct st_lsm6dsx_hw *hw, u8 addr, u8 mask,
 
 static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id)
 {
-	int err, i;
+	int err, i, j;
 	u8 data;
 
 	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
-		if (id == st_lsm6dsx_sensor_settings[i].id)
+		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
+			if (id == st_lsm6dsx_sensor_settings[i].id[j])
+				break;
+		}
+		if (j < ST_LSM6DSX_MAX_ID)
 			break;
 	}
 
-- 
2.9.3
