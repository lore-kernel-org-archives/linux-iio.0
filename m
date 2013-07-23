Return-Path: <jg1.han@samsung.com>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, devel@driverdev.osuosl.org,
 linux-iio@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/2] staging: iio: replace strict_strto*() with kstrto*()
Date: Tue, 23 Jul 2013 19:19:03 +0900
Message-id: <001d01ce878e$0e76b710$2b642530$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The usage of strict_strto*() is not preferred, because
strict_strto*() is obsolete. Thus, kstrto*() should be
used.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/staging/iio/accel/sca3000_core.c           |    4 ++--
 drivers/staging/iio/accel/sca3000_ring.c           |    2 +-
 drivers/staging/iio/addac/adt7316.c                |   20 ++++++++++----------
 drivers/staging/iio/frequency/ad9832.c             |    2 +-
 drivers/staging/iio/frequency/ad9834.c             |    2 +-
 drivers/staging/iio/gyro/adis16260_core.c          |    2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |    4 ++--
 drivers/staging/iio/light/isl29018.c               |    6 +++---
 drivers/staging/iio/light/tsl2583.c                |   12 ++++++------
 drivers/staging/iio/meter/ade7753.c                |    6 +++---
 drivers/staging/iio/meter/ade7754.c                |    6 +++---
 drivers/staging/iio/meter/ade7758_core.c           |    6 +++---
 drivers/staging/iio/meter/ade7759.c                |    6 +++---
 drivers/staging/iio/meter/ade7854.c                |    8 ++++----
 drivers/staging/iio/resolver/ad2s1210.c            |   10 +++++-----
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |    2 +-
 .../staging/iio/trigger/iio-trig-periodic-rtc.c    |    2 +-
 17 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index 32950ad..1dfa1de 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -626,7 +626,7 @@ static ssize_t sca3000_set_frequency(struct device *dev,
 	int ctrlval;
 	long val;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 
@@ -936,7 +936,7 @@ static ssize_t sca3000_set_free_fall_mode(struct device *dev,
 	u8 protect_mask = SCA3000_FREE_FALL_DETECT;
 
 	mutex_lock(&st->lock);
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 3e5e860..393100b 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -181,7 +181,7 @@ static ssize_t sca3000_set_ring_int(struct device *dev,
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 506b5a7..a0e8149 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -418,7 +418,7 @@ static ssize_t adt7316_store_ad_channel(struct device *dev,
 	if (!(chip->config2 & ADT7316_AD_SINGLE_CH_MODE))
 		return -EPERM;
 
-	ret = strict_strtoul(buf, 10, &data);
+	ret = kstrtoul(buf, 10, &data);
 	if (ret)
 		return -EINVAL;
 
@@ -851,7 +851,7 @@ static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
 	unsigned long data = 0;
 	int ret;
 
-	ret = strict_strtoul(buf, 16, &data);
+	ret = kstrtoul(buf, 16, &data);
 	if (ret || data > ADT7316_DA_2VREF_CH_MASK)
 		return -EINVAL;
 
@@ -909,7 +909,7 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
 	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA))
 		return -EPERM;
 
-	ret = strict_strtoul(buf, 10, &data);
+	ret = kstrtoul(buf, 10, &data);
 	if (ret || data > ADT7316_DA_EN_MODE_MASK)
 		return -EINVAL;
 
@@ -966,7 +966,7 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
 			ADT7316_DA_EN_MODE_LDAC)
 			return -EPERM;
 
-		ret = strict_strtoul(buf, 16, &data);
+		ret = kstrtoul(buf, 16, &data);
 		if (ret || data > ADT7316_LDAC_EN_DA_MASK)
 			return -EINVAL;
 
@@ -1108,7 +1108,7 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
 	int ret;
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX) {
-		ret = strict_strtoul(buf, 16, &data);
+		ret = kstrtoul(buf, 16, &data);
 		if (ret || data > 3)
 			return -EINVAL;
 
@@ -1118,7 +1118,7 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
 		else if (data & 0x2)
 			ldac_config |= ADT7516_DAC_CD_IN_VREF;
 	} else {
-		ret = strict_strtoul(buf, 16, &data);
+		ret = kstrtoul(buf, 16, &data);
 		if (ret)
 			return -EINVAL;
 
@@ -1310,7 +1310,7 @@ static ssize_t adt7316_store_temp_offset(struct adt7316_chip_info *chip,
 	u8 val;
 	int ret;
 
-	ret = strict_strtol(buf, 10, &data);
+	ret = kstrtol(buf, 10, &data);
 	if (ret || data > 127 || data < -128)
 		return -EINVAL;
 
@@ -1479,7 +1479,7 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
 
 	offset = chip->dac_bits - 8;
 
-	ret = strict_strtoul(buf, 10, &data);
+	ret = kstrtoul(buf, 10, &data);
 	if (ret || data >= (1 << chip->dac_bits))
 		return -EINVAL;
 
@@ -1861,7 +1861,7 @@ static ssize_t adt7316_set_int_mask(struct device *dev,
 	int ret;
 	u8 mask;
 
-	ret = strict_strtoul(buf, 16, &data);
+	ret = kstrtoul(buf, 16, &data);
 	if (ret || data >= ADT7316_VDD_INT_MASK + 1)
 		return -EINVAL;
 
@@ -1936,7 +1936,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
 		this_attr->address > ADT7316_EX_TEMP_LOW)
 		return -EPERM;
 
-	ret = strict_strtol(buf, 10, &data);
+	ret = kstrtol(buf, 10, &data);
 	if (ret)
 		return -EINVAL;
 
diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 4e18380..ec0fdc1 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -83,7 +83,7 @@ static ssize_t ad9832_write(struct device *dev,
 	int ret;
 	long val;
 
-	ret = strict_strtoul(buf, 10, &val);
+	ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 5cba3c0..e5fb602 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -72,7 +72,7 @@ static ssize_t ad9834_write(struct device *dev,
 	int ret;
 	long val;
 
-	ret = strict_strtoul(buf, 10, &val);
+	ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 620d63f..6abcc15 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -69,7 +69,7 @@ static ssize_t adis16260_write_frequency(struct device *dev,
 	int ret;
 	u8 t;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 	if (val == 0)
diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 6330af6..afe191a 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -326,7 +326,7 @@ static ssize_t ad5933_store_frequency(struct device *dev,
 	long val;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &val);
+	ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		return ret;
 
@@ -405,7 +405,7 @@ static ssize_t ad5933_store(struct device *dev,
 	unsigned short dat;
 
 	if (this_attr->address != AD5933_IN_PGA_GAIN) {
-		ret = strict_strtol(buf, 10, &val);
+		ret = kstrtol(buf, 10, &val);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 82478a5..64a8be6 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -240,7 +240,7 @@ static ssize_t store_range(struct device *dev,
 	unsigned long lval;
 	unsigned int new_range;
 
-	if (strict_strtoul(buf, 10, &lval))
+	if (kstrtoul(buf, 10, &lval))
 		return -EINVAL;
 
 	if (!(lval == 1000UL || lval == 4000UL ||
@@ -282,7 +282,7 @@ static ssize_t store_resolution(struct device *dev,
 	unsigned long lval;
 	unsigned int new_adc_bit;
 
-	if (strict_strtoul(buf, 10, &lval))
+	if (kstrtoul(buf, 10, &lval))
 		return -EINVAL;
 	if (!(lval == 4 || lval == 8 || lval == 12 || lval == 16)) {
 		dev_err(dev, "The resolution is not supported\n");
@@ -321,7 +321,7 @@ static ssize_t store_prox_infrared_suppression(struct device *dev,
 	struct isl29018_chip *chip = iio_priv(indio_dev);
 	unsigned long lval;
 
-	if (strict_strtoul(buf, 10, &lval))
+	if (kstrtoul(buf, 10, &lval))
 		return -EINVAL;
 	if (!(lval == 0UL || lval == 1UL)) {
 		dev_err(dev, "The mode is not supported\n");
diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index b377dd3..daf82bc 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -495,7 +495,7 @@ static ssize_t taos_power_state_store(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	unsigned long value;
 
-	if (strict_strtoul(buf, 0, &value))
+	if (kstrtoul(buf, 0, &value))
 		return -EINVAL;
 
 	if (value == 0)
@@ -538,7 +538,7 @@ static ssize_t taos_gain_store(struct device *dev,
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
 
-	if (strict_strtoul(buf, 0, &value))
+	if (kstrtoul(buf, 0, &value))
 		return -EINVAL;
 
 	switch (value) {
@@ -584,7 +584,7 @@ static ssize_t taos_als_time_store(struct device *dev,
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
 
-	if (strict_strtoul(buf, 0, &value))
+	if (kstrtoul(buf, 0, &value))
 		return -EINVAL;
 
 	if ((value < 50) || (value > 650))
@@ -621,7 +621,7 @@ static ssize_t taos_als_trim_store(struct device *dev,
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
 
-	if (strict_strtoul(buf, 0, &value))
+	if (kstrtoul(buf, 0, &value))
 		return -EINVAL;
 
 	if (value)
@@ -646,7 +646,7 @@ static ssize_t taos_als_cal_target_store(struct device *dev,
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	unsigned long value;
 
-	if (strict_strtoul(buf, 0, &value))
+	if (kstrtoul(buf, 0, &value))
 		return -EINVAL;
 
 	if (value)
@@ -673,7 +673,7 @@ static ssize_t taos_do_calibrate(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	unsigned long value;
 
-	if (strict_strtoul(buf, 0, &value))
+	if (kstrtoul(buf, 0, &value))
 		return -EINVAL;
 
 	if (value == 1)
diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index e5943e2..fbb230a 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -188,7 +188,7 @@ static ssize_t ade7753_write_8bit(struct device *dev,
 	int ret;
 	long val;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 	ret = ade7753_spi_write_reg_8(dev, this_attr->address, val);
@@ -206,7 +206,7 @@ static ssize_t ade7753_write_16bit(struct device *dev,
 	int ret;
 	long val;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 	ret = ade7753_spi_write_reg_16(dev, this_attr->address, val);
@@ -418,7 +418,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
 	int ret;
 	u16 reg, t;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 	if (val == 0)
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 7b6503b..ea337c4 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -188,7 +188,7 @@ static ssize_t ade7754_write_8bit(struct device *dev,
 	int ret;
 	long val;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 	ret = ade7754_spi_write_reg_8(dev, this_attr->address, val);
@@ -206,7 +206,7 @@ static ssize_t ade7754_write_16bit(struct device *dev,
 	int ret;
 	long val;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 	ret = ade7754_spi_write_reg_16(dev, this_attr->address, val);
@@ -439,7 +439,7 @@ static ssize_t ade7754_write_frequency(struct device *dev,
 	int ret;
 	u8 reg, t;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 	if (val == 0)
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 8f5bcfa..35ce10a 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -271,7 +271,7 @@ static ssize_t ade7758_write_8bit(struct device *dev,
 	int ret;
 	long val;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 	ret = ade7758_spi_write_reg_8(dev, this_attr->address, val);
@@ -289,7 +289,7 @@ static ssize_t ade7758_write_16bit(struct device *dev,
 	int ret;
 	long val;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 	ret = ade7758_spi_write_reg_16(dev, this_attr->address, val);
@@ -521,7 +521,7 @@ static ssize_t ade7758_write_frequency(struct device *dev,
 	int ret;
 	u8 reg, t;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 17dc373..4cc7991 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -187,7 +187,7 @@ static ssize_t ade7759_write_8bit(struct device *dev,
 	int ret;
 	long val;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 	ret = ade7759_spi_write_reg_8(dev, this_attr->address, val);
@@ -205,7 +205,7 @@ static ssize_t ade7759_write_16bit(struct device *dev,
 	int ret;
 	long val;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 	ret = ade7759_spi_write_reg_16(dev, this_attr->address, val);
@@ -379,7 +379,7 @@ static ssize_t ade7759_write_frequency(struct device *dev,
 	int ret;
 	u16 reg, t;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		return ret;
 	if (val == 0)
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index c642da8..7a87fc9 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -102,7 +102,7 @@ static ssize_t ade7854_write_8bit(struct device *dev,
 	int ret;
 	long val;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 	ret = st->write_reg_8(dev, this_attr->address, val);
@@ -123,7 +123,7 @@ static ssize_t ade7854_write_16bit(struct device *dev,
 	int ret;
 	long val;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 	ret = st->write_reg_16(dev, this_attr->address, val);
@@ -144,7 +144,7 @@ static ssize_t ade7854_write_24bit(struct device *dev,
 	int ret;
 	long val;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 	ret = st->write_reg_24(dev, this_attr->address, val);
@@ -165,7 +165,7 @@ static ssize_t ade7854_write_32bit(struct device *dev,
 	int ret;
 	long val;
 
-	ret = strict_strtol(buf, 10, &val);
+	ret = kstrtol(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 	ret = st->write_reg_32(dev, this_attr->address, val);
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 0d3356d..01c3cd4 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -224,7 +224,7 @@ static ssize_t ad2s1210_store_fclkin(struct device *dev,
 	unsigned long fclkin;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &fclkin);
+	ret = kstrtoul(buf, 10, &fclkin);
 	if (ret)
 		return ret;
 	if (fclkin < AD2S1210_MIN_CLKIN || fclkin > AD2S1210_MAX_CLKIN) {
@@ -261,7 +261,7 @@ static ssize_t ad2s1210_store_fexcit(struct device *dev,
 	unsigned long fexcit;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &fexcit);
+	ret = kstrtoul(buf, 10, &fexcit);
 	if (ret < 0)
 		return ret;
 	if (fexcit < AD2S1210_MIN_EXCIT || fexcit > AD2S1210_MAX_EXCIT) {
@@ -301,7 +301,7 @@ static ssize_t ad2s1210_store_control(struct device *dev,
 	unsigned char data;
 	int ret;
 
-	ret = strict_strtoul(buf, 16, &udata);
+	ret = kstrtoul(buf, 16, &udata);
 	if (ret)
 		return -EINVAL;
 
@@ -355,7 +355,7 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
 	unsigned long udata;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &udata);
+	ret = kstrtoul(buf, 10, &udata);
 	if (ret || udata < 10 || udata > 16) {
 		pr_err("ad2s1210: resolution out of range\n");
 		return -EINVAL;
@@ -457,7 +457,7 @@ static ssize_t ad2s1210_store_reg(struct device *dev,
 	int ret;
 	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
 
-	ret = strict_strtoul(buf, 10, &data);
+	ret = kstrtoul(buf, 10, &data);
 	if (ret)
 		return -EINVAL;
 	mutex_lock(&st->lock);
diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 38a158b..03766bb 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -87,7 +87,7 @@ static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
 	bool enabled;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &val);
+	ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index 7969597..93c597c 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -56,7 +56,7 @@ static ssize_t iio_trig_periodic_write_freq(struct device *dev,
 	unsigned long val;
 	int ret;
 
-	ret = strict_strtoul(buf, 10, &val);
+	ret = kstrtoul(buf, 10, &val);
 	if (ret)
 		goto error_ret;
 
-- 
1.7.10.4
