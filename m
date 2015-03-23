Return-Path: <robert.dolca@intel.com>
From: Robert Dolca <robert.dolca@intel.com>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Robert Dolca <robert.dolca@intel.com>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: [PATCH] IIO: Add support for L3GD20H gyroscope
Date: Mon, 23 Mar 2015 15:40:25 +0200
Message-Id: <1427118025-4380-2-git-send-email-robert.dolca@intel.com>
In-Reply-To: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>
List-ID: <linux-iio@vger.kernel.org>

It can be used exactly like L3GD20 but it has a different WhoAmI
register value.

Signed-off-by: Robert Dolca <robert.dolca@intel.com>
---
 drivers/iio/gyro/st_gyro_core.c | 83 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index f07a233..21395f2 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -87,6 +87,31 @@
 #define ST_GYRO_2_DRDY_IRQ_INT2_MASK		0x08
 #define ST_GYRO_2_MULTIREAD_BIT			true
 
+/* CUSTOM VALUES FOR SENSOR 3 */
+#define ST_GYRO_3_WAI_EXP			0xd7
+#define ST_GYRO_3_ODR_ADDR			0x20
+#define ST_GYRO_3_ODR_MASK			0xc0
+#define ST_GYRO_3_ODR_AVL_95HZ_VAL		0x00
+#define ST_GYRO_3_ODR_AVL_190HZ_VAL		0x01
+#define ST_GYRO_3_ODR_AVL_380HZ_VAL		0x02
+#define ST_GYRO_3_ODR_AVL_760HZ_VAL		0x03
+#define ST_GYRO_3_PW_ADDR			0x20
+#define ST_GYRO_3_PW_MASK			0x08
+#define ST_GYRO_3_FS_ADDR			0x23
+#define ST_GYRO_3_FS_MASK			0x30
+#define ST_GYRO_3_FS_AVL_250_VAL		0x00
+#define ST_GYRO_3_FS_AVL_500_VAL		0x01
+#define ST_GYRO_3_FS_AVL_2000_VAL		0x02
+#define ST_GYRO_3_FS_AVL_250_GAIN		IIO_DEGREE_TO_RAD(8750)
+#define ST_GYRO_3_FS_AVL_500_GAIN		IIO_DEGREE_TO_RAD(17500)
+#define ST_GYRO_3_FS_AVL_2000_GAIN		IIO_DEGREE_TO_RAD(70000)
+#define ST_GYRO_3_BDU_ADDR			0x23
+#define ST_GYRO_3_BDU_MASK			0x80
+#define ST_GYRO_3_DRDY_IRQ_ADDR			0x22
+#define ST_GYRO_3_DRDY_IRQ_INT2_MASK		0x08
+#define ST_GYRO_3_MULTIREAD_BIT			true
+
+
 static const struct iio_chan_spec st_gyro_16bit_channels[] = {
 	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
@@ -225,6 +250,64 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 		.multi_read_bit = ST_GYRO_2_MULTIREAD_BIT,
 		.bootime = 2,
 	},
+	{
+		.wai = ST_GYRO_3_WAI_EXP,
+		.sensors_supported = {
+			[0] = L3GD20_GYRO_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_gyro_16bit_channels,
+		.odr = {
+			.addr = ST_GYRO_3_ODR_ADDR,
+			.mask = ST_GYRO_3_ODR_MASK,
+			.odr_avl = {
+				{ 95, ST_GYRO_3_ODR_AVL_95HZ_VAL, },
+				{ 190, ST_GYRO_3_ODR_AVL_190HZ_VAL, },
+				{ 380, ST_GYRO_3_ODR_AVL_380HZ_VAL, },
+				{ 760, ST_GYRO_3_ODR_AVL_760HZ_VAL, },
+			},
+		},
+		.pw = {
+			.addr = ST_GYRO_3_PW_ADDR,
+			.mask = ST_GYRO_3_PW_MASK,
+			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = ST_GYRO_3_FS_ADDR,
+			.mask = ST_GYRO_3_FS_MASK,
+			.fs_avl = {
+				[0] = {
+					.num = ST_GYRO_FS_AVL_250DPS,
+					.value = ST_GYRO_3_FS_AVL_250_VAL,
+					.gain = ST_GYRO_3_FS_AVL_250_GAIN,
+				},
+				[1] = {
+					.num = ST_GYRO_FS_AVL_500DPS,
+					.value = ST_GYRO_3_FS_AVL_500_VAL,
+					.gain = ST_GYRO_3_FS_AVL_500_GAIN,
+				},
+				[2] = {
+					.num = ST_GYRO_FS_AVL_2000DPS,
+					.value = ST_GYRO_3_FS_AVL_2000_VAL,
+					.gain = ST_GYRO_3_FS_AVL_2000_GAIN,
+				},
+			},
+		},
+		.bdu = {
+			.addr = ST_GYRO_3_BDU_ADDR,
+			.mask = ST_GYRO_3_BDU_MASK,
+		},
+		.drdy_irq = {
+			.addr = ST_GYRO_3_DRDY_IRQ_ADDR,
+			.mask_int2 = ST_GYRO_3_DRDY_IRQ_INT2_MASK,
+		},
+		.multi_read_bit = ST_GYRO_3_MULTIREAD_BIT,
+		.bootime = 2,
+	},
 };
 
 static int st_gyro_read_raw(struct iio_dev *indio_dev,
-- 
1.9.1
