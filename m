Return-Path: <SRS0=LA0V=EE=melexis.com=cmo@kernel.org>
From: Crt Mori <cmo@melexis.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Crt Mori <cmo@melexis.com>
Subject: [PATCH v12 3/3] iio: temperature: Adding support for MLX90632
Date: Tue,  9 Jan 2018 16:19:21 +0100
Message-Id: <20180109151921.30392-1-cmo@melexis.com>
List-ID: <linux-iio@vger.kernel.org>

Melexis has just released Infra Red temperature sensor MLX90632 used
for contact-less temperature measurement. Driver provides basic
functionality for reporting object (and ambient) temperature with
support for object emissivity.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 MAINTAINERS                        |   7 +
 drivers/iio/temperature/Kconfig    |  12 +
 drivers/iio/temperature/Makefile   |   1 +
 drivers/iio/temperature/mlx90632.c | 754 +++++++++++++++++++++++++++++++++++++
 4 files changed, 774 insertions(+)
 create mode 100644 drivers/iio/temperature/mlx90632.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d3d750b19c0..81aec02b08b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8690,6 +8690,13 @@ W:	http://www.melexis.com
 S:	Supported
 F:	drivers/iio/temperature/mlx90614.c
 
+MELEXIS MLX90632 DRIVER
+M:	Crt Mori <cmo@melexis.com>
+L:	linux-iio@vger.kernel.org
+W:	http://www.melexis.com
+S:	Supported
+F:	drivers/iio/temperature/mlx90632.c
+
 MELFAS MIP4 TOUCHSCREEN DRIVER
 M:	Sangwon Jee <jeesw@melfas.com>
 W:	http://www.melfas.com
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 5378976d6d27..82e4a62745e2 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -43,6 +43,18 @@ config MLX90614
 	  This driver can also be built as a module. If so, the module will
 	  be called mlx90614.
 
+config MLX90632
+	tristate "MLX90632 contact-less infrared sensor with medical accuracy"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the Melexis
+	  MLX90632 contact-less infrared sensor with medical accuracy
+	  connected with I2C.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called mlx90632.
+
 config TMP006
 	tristate "TMP006 infrared thermopile sensor"
 	depends on I2C
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index ad1d668de546..44644fe01bc9 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_HID_SENSOR_TEMP) += hid-sensor-temperature.o
 obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
 obj-$(CONFIG_MLX90614) += mlx90614.o
+obj-$(CONFIG_MLX90632) += mlx90632.o
 obj-$(CONFIG_TMP006) += tmp006.o
 obj-$(CONFIG_TMP007) += tmp007.o
 obj-$(CONFIG_TSYS01) += tsys01.o
diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
new file mode 100644
index 000000000000..b4b7c998ddfd
--- /dev/null
+++ b/drivers/iio/temperature/mlx90632.c
@@ -0,0 +1,754 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mlx90632.c - Melexis MLX90632 contactless IR temperature sensor
+ *
+ * Copyright (c) 2017 Melexis <cmo@melexis.com>
+ *
+ * Driver for the Melexis MLX90632 I2C 16-bit IR thermopile sensor
+ */
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/math64.h>
+#include <linux/of.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/* Memory sections addresses */
+#define MLX90632_ADDR_RAM	0x4000 /* Start address of ram */
+#define MLX90632_ADDR_EEPROM	0x2480 /* Start address of user eeprom */
+
+/* EEPROM addresses - used at startup */
+#define MLX90632_EE_CTRL	0x24d4 /* Control register initial value */
+#define MLX90632_EE_I2C_ADDR	0x24d5 /* I2C address register initial value */
+#define MLX90632_EE_VERSION	0x240b /* EEPROM version reg address */
+#define MLX90632_EE_P_R		0x240c /* P_R calibration register 32bit */
+#define MLX90632_EE_P_G		0x240e /* P_G calibration register 32bit */
+#define MLX90632_EE_P_T		0x2410 /* P_T calibration register 32bit */
+#define MLX90632_EE_P_O		0x2412 /* P_O calibration register 32bit */
+#define MLX90632_EE_Aa		0x2414 /* Aa calibration register 32bit */
+#define MLX90632_EE_Ab		0x2416 /* Ab calibration register 32bit */
+#define MLX90632_EE_Ba		0x2418 /* Ba calibration register 32bit */
+#define MLX90632_EE_Bb		0x241a /* Bb calibration register 32bit */
+#define MLX90632_EE_Ca		0x241c /* Ca calibration register 32bit */
+#define MLX90632_EE_Cb		0x241e /* Cb calibration register 32bit */
+#define MLX90632_EE_Da		0x2420 /* Da calibration register 32bit */
+#define MLX90632_EE_Db		0x2422 /* Db calibration register 32bit */
+#define MLX90632_EE_Ea		0x2424 /* Ea calibration register 32bit */
+#define MLX90632_EE_Eb		0x2426 /* Eb calibration register 32bit */
+#define MLX90632_EE_Fa		0x2428 /* Fa calibration register 32bit */
+#define MLX90632_EE_Fb		0x242a /* Fb calibration register 32bit */
+#define MLX90632_EE_Ga		0x242c /* Ga calibration register 32bit */
+
+#define MLX90632_EE_Gb		0x242e /* Gb calibration register 16bit */
+#define MLX90632_EE_Ka		0x242f /* Ka calibration register 16bit */
+
+#define MLX90632_EE_Ha		0x2481 /* Ha customer calib value reg 16bit */
+#define MLX90632_EE_Hb		0x2482 /* Hb customer calib value reg 16bit */
+
+/* Register addresses - volatile */
+#define MLX90632_REG_I2C_ADDR	0x3000 /* Chip I2C address register */
+
+/* Control register address - volatile */
+#define MLX90632_REG_CONTROL	0x3001 /* Control Register address */
+#define   MLX90632_CFG_PWR_MASK		GENMASK(2, 1) /* PowerMode Mask */
+/* PowerModes statuses */
+#define MLX90632_PWR_STATUS(ctrl_val) (ctrl_val << 1)
+#define MLX90632_PWR_STATUS_HALT MLX90632_PWR_STATUS(0) /* hold */
+#define MLX90632_PWR_STATUS_SLEEP_STEP MLX90632_PWR_STATUS(1) /* sleep step*/
+#define MLX90632_PWR_STATUS_STEP MLX90632_PWR_STATUS(2) /* step */
+#define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous*/
+
+/* Device status register - volatile */
+#define MLX90632_REG_STATUS	0x3fff /* Device status register */
+#define   MLX90632_STAT_BUSY		BIT(10) /* Device busy indicator */
+#define   MLX90632_STAT_EE_BUSY		BIT(9) /* EEPROM busy indicator */
+#define   MLX90632_STAT_BRST		BIT(8) /* Brown out reset indicator */
+#define   MLX90632_STAT_CYCLE_POS	GENMASK(6, 2) /* Data position */
+#define   MLX90632_STAT_DATA_RDY	BIT(0) /* Data ready indicator */
+
+/* RAM_MEAS address-es for each channel */
+#define MLX90632_RAM_1(meas_num)	(MLX90632_ADDR_RAM + 3 * meas_num)
+#define MLX90632_RAM_2(meas_num)	(MLX90632_ADDR_RAM + 3 * meas_num + 1)
+#define MLX90632_RAM_3(meas_num)	(MLX90632_ADDR_RAM + 3 * meas_num + 2)
+
+/* Magic constants */
+#define MLX90632_ID_MEDICAL	0x0105 /* EEPROM DSPv5 Medical device id */
+#define MLX90632_ID_CONSUMER	0x0205 /* EEPROM DSPv5 Consumer device id */
+#define MLX90632_RESET_CMD	0x0006 /* Reset sensor (address or global) */
+#define MLX90632_REF_12		12LL /**< ResCtrlRef value of Ch 1 or Ch 2 */
+#define MLX90632_REF_3		12LL /**< ResCtrlRef value of Channel 3 */
+#define MLX90632_MAX_MEAS_NUM	31 /**< Maximum measurements in list */
+
+struct mlx90632_data {
+	struct i2c_client *client;
+	struct mutex lock; /* Multiple reads for single measurement */
+	struct regmap *regmap;
+	u16 emissivity;
+};
+
+static const struct regmap_range mlx90632_volatile_reg_range[] = {
+	regmap_reg_range(MLX90632_REG_I2C_ADDR, MLX90632_REG_CONTROL),
+	regmap_reg_range(MLX90632_REG_STATUS, MLX90632_REG_STATUS),
+	regmap_reg_range(MLX90632_RAM_1(0),
+			 MLX90632_RAM_3(MLX90632_MAX_MEAS_NUM)),
+};
+
+static const struct regmap_access_table mlx90632_volatile_regs_tbl = {
+	.yes_ranges = mlx90632_volatile_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(mlx90632_volatile_reg_range),
+};
+
+static const struct regmap_range mlx90632_read_reg_range[] = {
+	regmap_reg_range(MLX90632_EE_VERSION, MLX90632_EE_Ka),
+	regmap_reg_range(MLX90632_EE_CTRL, MLX90632_EE_I2C_ADDR),
+	regmap_reg_range(MLX90632_EE_Ha, MLX90632_EE_Hb),
+	regmap_reg_range(MLX90632_REG_I2C_ADDR, MLX90632_REG_CONTROL),
+	regmap_reg_range(MLX90632_REG_STATUS, MLX90632_REG_STATUS),
+	regmap_reg_range(MLX90632_RAM_1(0),
+			 MLX90632_RAM_3(MLX90632_MAX_MEAS_NUM)),
+};
+
+static const struct regmap_access_table mlx90632_readable_regs_tbl = {
+	.yes_ranges = mlx90632_read_reg_range,
+	.n_yes_ranges = ARRAY_SIZE(mlx90632_read_reg_range),
+};
+
+static const struct regmap_range mlx90632_no_write_reg_range[] = {
+	regmap_reg_range(MLX90632_EE_VERSION, MLX90632_EE_Ka),
+	regmap_reg_range(MLX90632_RAM_1(0),
+			 MLX90632_RAM_3(MLX90632_MAX_MEAS_NUM)),
+};
+
+static const struct regmap_access_table mlx90632_writeable_regs_tbl = {
+	.no_ranges = mlx90632_no_write_reg_range,
+	.n_no_ranges = ARRAY_SIZE(mlx90632_no_write_reg_range),
+};
+
+static const struct regmap_config mlx90632_regmap = {
+	.reg_bits = 16,
+	.val_bits = 16,
+
+	.volatile_table = &mlx90632_volatile_regs_tbl,
+	.rd_table = &mlx90632_readable_regs_tbl,
+	.wr_table = &mlx90632_writeable_regs_tbl,
+
+	.use_single_rw = true,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
+{
+	return regmap_update_bits(regmap, MLX90632_REG_CONTROL,
+				  MLX90632_CFG_PWR_MASK,
+				  MLX90632_PWR_STATUS_SLEEP_STEP);
+}
+
+static s32 mlx90632_pwr_continuous(struct regmap *regmap)
+{
+	return regmap_update_bits(regmap, MLX90632_REG_CONTROL,
+				  MLX90632_CFG_PWR_MASK,
+				  MLX90632_PWR_STATUS_CONTINUOUS);
+}
+
+/**
+ * mlx90632_perform_measurement - Trigger and retrieve current measurement cycle
+ * @*data: pointer to mlx90632_data object containing regmap information
+ *
+ * Perform a measurement and return latest measurement cycle position reported
+ * by sensor. This is a blocking function for 500ms, as that is default sensor
+ * refresh rate.
+ */
+static int mlx90632_perform_measurement(struct mlx90632_data *data)
+{
+	int ret, tries = 100;
+	unsigned int reg_status;
+
+	ret = regmap_update_bits(data->regmap, MLX90632_REG_STATUS,
+				 MLX90632_STAT_DATA_RDY, 0);
+	if (ret < 0)
+		return ret;
+
+	while (tries-- > 0) {
+		ret = regmap_read(data->regmap, MLX90632_REG_STATUS,
+				  &reg_status);
+		if (ret < 0)
+			return ret;
+		if (reg_status & MLX90632_STAT_DATA_RDY)
+			break;
+		usleep_range(10000, 11000);
+	}
+
+	if (tries < 0) {
+		dev_err(&data->client->dev, "data not ready");
+		return -ETIMEDOUT;
+	}
+
+	return (reg_status & MLX90632_STAT_CYCLE_POS) >> 2;
+}
+
+static int mlx90632_channel_new_select(int perform_ret, uint8_t *channel_new,
+				       uint8_t *channel_old)
+{
+	switch (perform_ret) {
+	case 1:
+		*channel_new = 1;
+		*channel_old = 2;
+		break;
+	case 2:
+		*channel_new = 2;
+		*channel_old = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mlx90632_read_ambient_raw(struct regmap *regmap,
+				     s16 *ambient_new_raw, s16 *ambient_old_raw)
+{
+	int ret;
+	unsigned int read_tmp;
+
+	ret = regmap_read(regmap, MLX90632_RAM_3(1), &read_tmp);
+	if (ret < 0)
+		return ret;
+	*ambient_new_raw = (s16)read_tmp;
+
+	ret = regmap_read(regmap, MLX90632_RAM_3(2), &read_tmp);
+	if (ret < 0)
+		return ret;
+	*ambient_old_raw = (s16)read_tmp;
+
+	return ret;
+}
+
+static int mlx90632_read_object_raw(struct regmap *regmap,
+				    int perform_measurement_ret,
+				    s16 *object_new_raw, s16 *object_old_raw)
+{
+	int ret;
+	unsigned int read_tmp;
+	s16 read;
+	u8 channel = 0;
+	u8 channel_old = 0;
+
+	ret = mlx90632_channel_new_select(perform_measurement_ret, &channel,
+					  &channel_old);
+	if (ret != 0)
+		return ret;
+
+	ret = regmap_read(regmap, MLX90632_RAM_2(channel), &read_tmp);
+	if (ret < 0)
+		return ret;
+
+	read = (s16)read_tmp;
+
+	ret = regmap_read(regmap, MLX90632_RAM_1(channel), &read_tmp);
+	if (ret < 0)
+		return ret;
+	*object_new_raw = (read + (s16)read_tmp) / 2;
+
+	ret = regmap_read(regmap, MLX90632_RAM_2(channel_old), &read_tmp);
+	if (ret < 0)
+		return ret;
+	read = (s16)read_tmp;
+
+	ret = regmap_read(regmap, MLX90632_RAM_1(channel_old), &read_tmp);
+	if (ret < 0)
+		return ret;
+	*object_old_raw = (read + (s16)read_tmp) / 2;
+
+	return ret;
+}
+
+static int mlx90632_read_all_channel(struct mlx90632_data *data,
+				     s16 *ambient_new_raw, s16 *ambient_old_raw,
+				     s16 *object_new_raw, s16 *object_old_raw)
+{
+	s32 ret, measurement;
+
+	mutex_lock(&data->lock);
+	measurement = mlx90632_perform_measurement(data);
+	if (measurement < 0) {
+		ret = measurement;
+		goto read_unlock;
+	}
+	ret = mlx90632_read_ambient_raw(data->regmap, ambient_new_raw,
+					ambient_old_raw);
+	if (ret < 0)
+		goto read_unlock;
+
+	ret = mlx90632_read_object_raw(data->regmap, measurement,
+				       object_new_raw, object_old_raw);
+read_unlock:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int mlx90632_read_ee_register(struct regmap *regmap, u16 reg_lsb,
+				     s32 *reg_value)
+{
+	s32 ret;
+	unsigned int read;
+	u32 value;
+
+	ret = regmap_read(regmap, reg_lsb, &read);
+	if (ret < 0)
+		return ret;
+
+	value = read;
+
+	ret = regmap_read(regmap, reg_lsb + 1, &read);
+	if (ret < 0)
+		return ret;
+
+	*reg_value = (read << 16) | (value & 0xffff);
+
+	return 0;
+}
+
+static s64 mlx90632_preprocess_temp_amb(s16 ambient_new_raw,
+					s16 ambient_old_raw, s16 Gb)
+{
+	s64 VR_Ta, kGb, tmp;
+
+	kGb = ((s64)Gb * 1000LL) >> 10ULL;
+	VR_Ta = (s64)ambient_old_raw * 1000000LL +
+		kGb * div64_s64(((s64)ambient_new_raw * 1000LL),
+			(MLX90632_REF_3));
+	tmp = div64_s64(
+			 div64_s64(((s64)ambient_new_raw * 1000000000000LL),
+				   (MLX90632_REF_3)), VR_Ta);
+	return div64_s64(tmp << 19ULL, 1000LL);
+}
+
+static s64 mlx90632_preprocess_temp_obj(s16 object_new_raw, s16 object_old_raw,
+					s16 ambient_new_raw,
+					s16 ambient_old_raw, s16 Ka)
+{
+	s64 VR_IR, kKa, tmp;
+
+	kKa = ((s64)Ka * 1000LL) >> 10ULL;
+	VR_IR = (s64)ambient_old_raw * 1000000LL +
+		kKa * div64_s64(((s64)ambient_new_raw * 1000LL),
+			(MLX90632_REF_3));
+	tmp = div64_s64(
+			div64_s64(((s64)((object_new_raw + object_old_raw) / 2)
+				   * 1000000000000LL), (MLX90632_REF_12)),
+			VR_IR);
+	return div64_s64((tmp << 19ULL), 1000LL);
+}
+
+static s32 mlx90632_calc_temp_ambient(s16 ambient_new_raw, s16 ambient_old_raw,
+				      s32 P_T, s32 P_R, s32 P_G, s32 P_O,
+				      s16 Gb)
+{
+	s64 Asub, Bsub, Ablock, Bblock, Cblock, AMB, sum;
+
+	AMB = mlx90632_preprocess_temp_amb(ambient_new_raw, ambient_old_raw,
+					   Gb);
+	Asub = ((s64)P_T * 10000000000LL) >> 44ULL;
+	Bsub = AMB - (((s64)P_R * 1000LL) >> 8ULL);
+	Ablock = Asub * (Bsub * Bsub);
+	Bblock = (div64_s64(Bsub * 10000000LL, P_G)) << 20ULL;
+	Cblock = ((s64)P_O * 10000000000LL) >> 8ULL;
+
+	sum = div64_s64(Ablock, 1000000LL) + Bblock + Cblock;
+
+	return div64_s64(sum, 10000000LL);
+}
+
+static s32 mlx90632_calc_temp_object_iteration(s32 prev_object_temp, s64 object,
+					       s64 TAdut, s32 Fa, s32 Fb,
+					       s32 Ga, s16 Ha, s16 Hb,
+					       u16 emissivity)
+{
+	s64 calcedKsTO, calcedKsTA, ir_Alpha, TAdut4, Alpha_corr;
+	s64 Ha_customer, Hb_customer;
+
+	Ha_customer = ((s64)Ha * 1000000LL) >> 14ULL;
+	Hb_customer = ((s64)Hb * 100) >> 10ULL;
+
+	calcedKsTO = ((s64)((s64)Ga * (prev_object_temp - 25 * 1000LL)
+			     * 1000LL)) >> 36LL;
+	calcedKsTA = ((s64)(Fb * (TAdut - 25 * 1000000LL))) >> 36LL;
+	Alpha_corr = div64_s64((((s64)(Fa * 10000000000LL) >> 46LL)
+				* Ha_customer), 1000LL);
+	Alpha_corr *= ((s64)(1 * 1000000LL + calcedKsTO + calcedKsTA));
+	Alpha_corr = emissivity * div64_s64(Alpha_corr, 100000LL);
+	Alpha_corr = div64_s64(Alpha_corr, 1000LL);
+	ir_Alpha = div64_s64((s64)object * 10000000LL, Alpha_corr);
+	TAdut4 = (div64_s64(TAdut, 10000LL) + 27315) *
+		(div64_s64(TAdut, 10000LL) + 27315) *
+		(div64_s64(TAdut, 10000LL)  + 27315) *
+		(div64_s64(TAdut, 10000LL) + 27315);
+
+	return (int_sqrt64(int_sqrt64(ir_Alpha * 1000000000000LL + TAdut4))
+		- 27315 - Hb_customer) * 10;
+}
+
+static s32 mlx90632_calc_temp_object(s64 object, s64 ambient, s32 Ea, s32 Eb,
+				     s32 Fa, s32 Fb, s32 Ga, s16 Ha, s16 Hb,
+				     u16 tmp_emi)
+{
+	s64 kTA, kTA0, TAdut;
+	s64 temp = 25000;
+	s8 i;
+
+	kTA = (Ea * 1000LL) >> 16LL;
+	kTA0 = (Eb * 1000LL) >> 8LL;
+	TAdut = div64_s64(((ambient - kTA0) * 1000000LL), kTA) + 25 * 1000000LL;
+
+	/* Iterations of calculation as described in datasheet */
+	for (i = 0; i < 5; ++i) {
+		temp = mlx90632_calc_temp_object_iteration(temp, object, TAdut,
+							   Fa, Fb, Ga, Ha, Hb,
+							   tmp_emi);
+	}
+	return temp;
+}
+
+static int mlx90632_calc_object_dsp105(struct mlx90632_data *data, int *val)
+{
+	s32 ret;
+	s32 Ea, Eb, Fa, Fb, Ga;
+	unsigned int read_tmp;
+	s16 Ha, Hb, Gb, Ka;
+	s16 ambient_new_raw, ambient_old_raw, object_new_raw, object_old_raw;
+	s64 object, ambient;
+
+	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_Ea, &Ea);
+	if (ret < 0)
+		return ret;
+	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_Eb, &Eb);
+	if (ret < 0)
+		return ret;
+	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_Fa, &Fa);
+	if (ret < 0)
+		return ret;
+	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_Fb, &Fb);
+	if (ret < 0)
+		return ret;
+	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_Ga, &Ga);
+	if (ret < 0)
+		return ret;
+	ret = regmap_read(data->regmap, MLX90632_EE_Ha, &read_tmp);
+	if (ret < 0)
+		return ret;
+	Ha = (s16)read_tmp;
+	ret = regmap_read(data->regmap, MLX90632_EE_Hb, &read_tmp);
+	if (ret < 0)
+		return ret;
+	Hb = (s16)read_tmp;
+	ret = regmap_read(data->regmap, MLX90632_EE_Gb, &read_tmp);
+	if (ret < 0)
+		return ret;
+	Gb = (s16)read_tmp;
+	ret = regmap_read(data->regmap, MLX90632_EE_Ka, &read_tmp);
+	if (ret < 0)
+		return ret;
+	Ka = (s16)read_tmp;
+
+	ret = mlx90632_read_all_channel(data,
+					&ambient_new_raw, &ambient_old_raw,
+					&object_new_raw, &object_old_raw);
+	if (ret < 0)
+		return ret;
+
+	ambient = mlx90632_preprocess_temp_amb(ambient_new_raw,
+					       ambient_old_raw, Gb);
+	object = mlx90632_preprocess_temp_obj(object_new_raw,
+					      object_old_raw,
+					      ambient_new_raw,
+					      ambient_old_raw, Ka);
+
+	*val = mlx90632_calc_temp_object(object, ambient, Ea, Eb, Fa, Fb, Ga,
+					 Ha, Hb, data->emissivity);
+	return 0;
+}
+
+static int mlx90632_calc_ambient_dsp105(struct mlx90632_data *data, int *val)
+{
+	s32 ret;
+	unsigned int read_tmp;
+	s32 PT, PR, PG, PO;
+	s16 Gb;
+	s16 ambient_new_raw, ambient_old_raw;
+
+	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_P_R, &PR);
+	if (ret < 0)
+		return ret;
+	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_P_G, &PG);
+	if (ret < 0)
+		return ret;
+	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_P_T, &PT);
+	if (ret < 0)
+		return ret;
+	ret = mlx90632_read_ee_register(data->regmap, MLX90632_EE_P_O, &PO);
+	if (ret < 0)
+		return ret;
+	ret = regmap_read(data->regmap, MLX90632_EE_Gb, &read_tmp);
+	if (ret < 0)
+		return ret;
+	Gb = (s16)read_tmp;
+
+	ret = mlx90632_read_ambient_raw(data->regmap, &ambient_new_raw,
+					&ambient_old_raw);
+	*val = mlx90632_calc_temp_ambient(ambient_new_raw, ambient_old_raw,
+					  PT, PR, PG, PO, Gb);
+	return ret;
+}
+
+static int mlx90632_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *channel, int *val,
+			     int *val2, long mask)
+{
+	struct mlx90632_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		switch (channel->channel2) {
+		case IIO_MOD_TEMP_AMBIENT:
+			ret = mlx90632_calc_ambient_dsp105(data, val);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		case IIO_MOD_TEMP_OBJECT:
+			ret = mlx90632_calc_object_dsp105(data, val);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_CALIBEMISSIVITY:
+		if (data->emissivity == 1000) {
+			*val = 1;
+			*val2 = 0;
+		} else {
+			*val = 0;
+			*val2 = data->emissivity * 1000;
+		}
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mlx90632_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *channel, int val,
+			      int val2, long mask)
+{
+	struct mlx90632_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBEMISSIVITY:
+		/* Confirm we are within 0 and 1.0 */
+		if (val < 0 || val2 < 0 || val > 1 ||
+		    (val == 1 && val2 != 0))
+			return -EINVAL;
+		data->emissivity = val * 1000 + val2 / 1000;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_chan_spec mlx90632_channels[] = {
+	{
+		.type = IIO_TEMP,
+		.modified = 1,
+		.channel2 = IIO_MOD_TEMP_AMBIENT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+	{
+		.type = IIO_TEMP,
+		.modified = 1,
+		.channel2 = IIO_MOD_TEMP_OBJECT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+			BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
+	},
+};
+
+static const struct iio_info mlx90632_info = {
+	.read_raw = mlx90632_read_raw,
+	.write_raw = mlx90632_write_raw,
+};
+
+static int mlx90632_sleep(struct mlx90632_data *data)
+{
+	regcache_mark_dirty(data->regmap);
+
+	dev_dbg(&data->client->dev, "Requesting sleep");
+	return mlx90632_pwr_set_sleep_step(data->regmap);
+}
+
+static int mlx90632_wakeup(struct mlx90632_data *data)
+{
+	int ret;
+
+	ret = regcache_sync(data->regmap);
+	if (ret < 0) {
+		dev_err(&data->client->dev,
+			"Failed to sync regmap registers: %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(&data->client->dev, "Requesting wake-up\n");
+	return mlx90632_pwr_continuous(data->regmap);
+}
+
+static int mlx90632_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct mlx90632_data *mlx90632;
+	struct regmap *regmap;
+	int ret;
+	unsigned int read;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*mlx90632));
+	if (!indio_dev) {
+		dev_err(&client->dev, "Failed to allocate device\n");
+		return -ENOMEM;
+	}
+
+	regmap = devm_regmap_init_i2c(client, &mlx90632_regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(&client->dev, "Failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+
+	mlx90632 = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	mlx90632->client = client;
+	mlx90632->regmap = regmap;
+
+	mutex_init(&mlx90632->lock);
+	pm_runtime_set_active(&client->dev);
+	pm_runtime_enable(&client->dev);
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = id->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &mlx90632_info;
+	indio_dev->channels = mlx90632_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mlx90632_channels);
+
+	ret = mlx90632_wakeup(mlx90632);
+	if (ret < 0) {
+		dev_err(&client->dev, "Wakeup failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(mlx90632->regmap, MLX90632_EE_VERSION, &read);
+	if (ret < 0) {
+		dev_err(&client->dev, "read of version failed: %d\n", ret);
+		return ret;
+	}
+	if (read == MLX90632_ID_MEDICAL) {
+		dev_dbg(&client->dev,
+			"Detected Medical EEPROM calibration %x\n", read);
+	} else if (read == MLX90632_ID_CONSUMER) {
+		dev_dbg(&client->dev,
+			"Detected Consumer EEPROM calibration %x\n", read);
+	} else {
+		dev_err(&client->dev,
+			"EEPROM version mismatch %x (expected %x or %x)\n",
+			read, MLX90632_ID_CONSUMER, MLX90632_ID_MEDICAL);
+		return -EPROTONOSUPPORT;
+	}
+
+	mlx90632->emissivity = 1000;
+
+	return iio_device_register(indio_dev);
+}
+
+static int mlx90632_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct mlx90632_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	mlx90632_sleep(data);
+
+	pm_runtime_disable(&client->dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id mlx90632_id[] = {
+	{ "mlx90632", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mlx90632_id);
+
+static const struct of_device_id mlx90632_of_match[] = {
+	{ .compatible = "melexis,mlx90632" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mlx90632_of_match);
+
+static int __maybe_unused mlx90632_pm_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mlx90632_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = mlx90632_sleep(data);
+	if (ret < 0)
+		return ret;
+
+	pm_runtime_set_suspended(dev);
+
+	return 0;
+}
+
+static int __maybe_unused mlx90632_pm_resume(struct device *dev)
+{
+	int ret;
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct mlx90632_data *data = iio_priv(indio_dev);
+
+	ret = mlx90632_wakeup(data);
+	if (ret < 0)
+		return ret;
+
+	pm_runtime_set_active(dev);
+
+	return 0;
+}
+
+static UNIVERSAL_DEV_PM_OPS(mlx90632_pm_ops, mlx90632_pm_suspend,
+			    mlx90632_pm_resume, NULL);
+
+static struct i2c_driver mlx90632_driver = {
+	.driver = {
+		.name	= "mlx90632",
+		.of_match_table = mlx90632_of_match,
+		.pm	= &mlx90632_pm_ops,
+	},
+	.probe = mlx90632_probe,
+	.remove = mlx90632_remove,
+	.id_table = mlx90632_id,
+};
+module_i2c_driver(mlx90632_driver);
+
+MODULE_AUTHOR("Crt Mori <cmo@melexis.com>");
+MODULE_DESCRIPTION("Melexis MLX90632 contactless Infra Red temperature sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
2.15.0
