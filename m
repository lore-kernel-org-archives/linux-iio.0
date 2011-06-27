Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 24/54] staging:iio:addac:adt7316: allocate chip state with iio_dev and use iio_priv to access.
Date: Mon, 27 Jun 2011 11:04:34 +0100
Message-Id: <1309169104-22139-25-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Various minor cleanups needed to deal with removal of iio_dev pointer from chip state.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/addac/adt7316.c |  224 +++++++++++++++++------------------
 1 files changed, 107 insertions(+), 117 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 7097deb..637316f 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -174,7 +174,6 @@
  */
 
 struct adt7316_chip_info {
-	struct iio_dev		*indio_dev;
 	struct adt7316_bus	bus;
 	u16			ldac_pin;
 	u16			int_mask;	/* 0x2f */
@@ -220,7 +219,7 @@ static ssize_t adt7316_show_enabled(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", !!(chip->config1 & ADT7316_EN));
 }
@@ -252,7 +251,7 @@ static ssize_t adt7316_store_enabled(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	int enable;
 
 	if (!memcmp(buf, "1", 1))
@@ -276,7 +275,7 @@ static ssize_t adt7316_show_select_ex_temp(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
 		return -EPERM;
@@ -290,7 +289,7 @@ static ssize_t adt7316_store_select_ex_temp(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config1;
 	int ret;
 
@@ -320,7 +319,7 @@ static ssize_t adt7316_show_mode(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	if (chip->config2 & ADT7316_AD_SINGLE_CH_MODE)
 		return sprintf(buf, "single_channel\n");
@@ -334,7 +333,7 @@ static ssize_t adt7316_store_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config2;
 	int ret;
 
@@ -370,7 +369,7 @@ static ssize_t adt7316_show_ad_channel(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	if (!(chip->config2 & ADT7316_AD_SINGLE_CH_MODE))
 		return -EPERM;
@@ -409,7 +408,7 @@ static ssize_t adt7316_store_ad_channel(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config2;
 	unsigned long data = 0;
 	int ret;
@@ -455,7 +454,7 @@ static ssize_t adt7316_show_all_ad_channels(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	if (!(chip->config2 & ADT7316_AD_SINGLE_CH_MODE))
 		return -EPERM;
@@ -477,7 +476,7 @@ static ssize_t adt7316_show_disable_averaging(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n",
 		!!(chip->config2 & ADT7316_DISABLE_AVERAGING));
@@ -489,7 +488,7 @@ static ssize_t adt7316_store_disable_averaging(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config2;
 	int ret;
 
@@ -516,7 +515,7 @@ static ssize_t adt7316_show_enable_smbus_timeout(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n",
 		!!(chip->config2 & ADT7316_EN_SMBUS_TIMEOUT));
@@ -528,7 +527,7 @@ static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config2;
 	int ret;
 
@@ -557,7 +556,7 @@ static ssize_t adt7316_store_reset(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config2;
 	int ret;
 
@@ -580,7 +579,7 @@ static ssize_t adt7316_show_powerdown(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", !!(chip->config1 & ADT7316_PD));
 }
@@ -591,7 +590,7 @@ static ssize_t adt7316_store_powerdown(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config1;
 	int ret;
 
@@ -618,7 +617,7 @@ static ssize_t adt7316_show_fast_ad_clock(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", !!(chip->config3 & ADT7316_ADCLK_22_5));
 }
@@ -629,7 +628,7 @@ static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
 	int ret;
 
@@ -656,7 +655,7 @@ static ssize_t adt7316_show_da_high_resolution(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	if (chip->config3 & ADT7316_DA_HIGH_RESOLUTION) {
 		if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
@@ -674,7 +673,7 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
 	int ret;
 
@@ -708,7 +707,7 @@ static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
 		return -EPERM;
@@ -723,7 +722,7 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
 	int ret;
 
@@ -755,7 +754,7 @@ static ssize_t adt7316_show_enable_prop_DACA(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n",
 		!!(chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA));
@@ -767,7 +766,7 @@ static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
 	int ret;
 
@@ -794,7 +793,7 @@ static ssize_t adt7316_show_enable_prop_DACB(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n",
 		!!(chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB));
@@ -806,7 +805,7 @@ static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
 	int ret;
 
@@ -833,7 +832,7 @@ static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "0x%x\n",
 		chip->dac_config & ADT7316_DA_2VREF_CH_MASK);
@@ -845,7 +844,7 @@ static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 dac_config;
 	unsigned long data = 0;
 	int ret;
@@ -876,7 +875,7 @@ static ssize_t adt7316_show_DAC_update_mode(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA))
 		return sprintf(buf, "manual\n");
@@ -900,7 +899,7 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 dac_config;
 	unsigned long data;
 	int ret;
@@ -934,7 +933,7 @@ static ssize_t adt7316_show_all_DAC_update_modes(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA)
 		return sprintf(buf, "0 - auto at any MSB DAC writing\n"
@@ -955,7 +954,7 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 ldac_config;
 	unsigned long data;
 	int ret;
@@ -994,7 +993,7 @@ static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 		return -EPERM;
@@ -1009,7 +1008,7 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 dac_config;
 	int ret;
 
@@ -1039,7 +1038,7 @@ static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 		return -EPERM;
@@ -1054,7 +1053,7 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 dac_config;
 	int ret;
 
@@ -1084,7 +1083,7 @@ static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 		return sprintf(buf, "0x%x\n",
@@ -1101,7 +1100,7 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 ldac_config;
 	unsigned long data;
 	int ret;
@@ -1220,7 +1219,7 @@ static ssize_t adt7316_show_VDD(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_VDD, buf);
 }
@@ -1231,7 +1230,7 @@ static ssize_t adt7316_show_in_temp(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_IN, buf);
 }
@@ -1243,7 +1242,7 @@ static ssize_t adt7316_show_ex_temp_AIN1(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_EX, buf);
 }
@@ -1256,7 +1255,7 @@ static ssize_t adt7316_show_AIN2(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN2, buf);
 }
@@ -1267,7 +1266,7 @@ static ssize_t adt7316_show_AIN3(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN3, buf);
 }
@@ -1278,7 +1277,7 @@ static ssize_t adt7316_show_AIN4(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN4, buf);
 }
@@ -1330,7 +1329,7 @@ static ssize_t adt7316_show_in_temp_offset(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_show_temp_offset(chip, ADT7316_IN_TEMP_OFFSET, buf);
 }
@@ -1341,7 +1340,7 @@ static ssize_t adt7316_store_in_temp_offset(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_store_temp_offset(chip, ADT7316_IN_TEMP_OFFSET, buf, len);
 }
@@ -1355,7 +1354,7 @@ static ssize_t adt7316_show_ex_temp_offset(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_show_temp_offset(chip, ADT7316_EX_TEMP_OFFSET, buf);
 }
@@ -1366,7 +1365,7 @@ static ssize_t adt7316_store_ex_temp_offset(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_store_temp_offset(chip, ADT7316_EX_TEMP_OFFSET, buf, len);
 }
@@ -1380,7 +1379,7 @@ static ssize_t adt7316_show_in_analog_temp_offset(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_show_temp_offset(chip,
 			ADT7316_IN_ANALOG_TEMP_OFFSET, buf);
@@ -1392,7 +1391,7 @@ static ssize_t adt7316_store_in_analog_temp_offset(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_store_temp_offset(chip,
 			ADT7316_IN_ANALOG_TEMP_OFFSET, buf, len);
@@ -1407,7 +1406,7 @@ static ssize_t adt7316_show_ex_analog_temp_offset(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_show_temp_offset(chip,
 			ADT7316_EX_ANALOG_TEMP_OFFSET, buf);
@@ -1419,7 +1418,7 @@ static ssize_t adt7316_store_ex_analog_temp_offset(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_store_temp_offset(chip,
 			ADT7316_EX_ANALOG_TEMP_OFFSET, buf, len);
@@ -1504,7 +1503,7 @@ static ssize_t adt7316_show_DAC_A(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_show_DAC(chip, 0, buf);
 }
@@ -1515,7 +1514,7 @@ static ssize_t adt7316_store_DAC_A(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_store_DAC(chip, 0, buf, len);
 }
@@ -1528,7 +1527,7 @@ static ssize_t adt7316_show_DAC_B(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_show_DAC(chip, 1, buf);
 }
@@ -1539,7 +1538,7 @@ static ssize_t adt7316_store_DAC_B(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_store_DAC(chip, 1, buf, len);
 }
@@ -1552,7 +1551,7 @@ static ssize_t adt7316_show_DAC_C(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_show_DAC(chip, 2, buf);
 }
@@ -1563,7 +1562,7 @@ static ssize_t adt7316_store_DAC_C(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_store_DAC(chip, 2, buf, len);
 }
@@ -1576,7 +1575,7 @@ static ssize_t adt7316_show_DAC_D(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_show_DAC(chip, 3, buf);
 }
@@ -1587,7 +1586,7 @@ static ssize_t adt7316_store_DAC_D(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_store_DAC(chip, 3, buf, len);
 }
@@ -1600,7 +1599,7 @@ static ssize_t adt7316_show_device_id(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 id;
 	int ret;
 
@@ -1618,7 +1617,7 @@ static ssize_t adt7316_show_manufactorer_id(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 id;
 	int ret;
 
@@ -1637,7 +1636,7 @@ static ssize_t adt7316_show_device_rev(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 rev;
 	int ret;
 
@@ -1655,7 +1654,7 @@ static ssize_t adt7316_show_bus_type(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 stat;
 	int ret;
 
@@ -1765,7 +1764,7 @@ static const struct attribute_group adt7516_attribute_group = {
 static irqreturn_t adt7316_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
-	struct adt7316_chip_info *chip = iio_dev_get_devdata(indio_dev);
+	struct adt7316_chip_info *chip = iio_priv(indio_dev);
 	u8 stat1, stat2;
 	int ret;
 	s64 time;
@@ -1777,43 +1776,43 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
 
 		time = iio_get_time_ns();
 		if (stat1 & (1 << 0))
-			iio_push_event(chip->indio_dev, 0,
+			iio_push_event(indio_dev, 0,
 				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_RISING),
 				       time);
 		if (stat1 & (1 << 1))
-			iio_push_event(chip->indio_dev, 0,
+			iio_push_event(indio_dev, 0,
 				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_FALLING),
 				       time);
 		if (stat1 & (1 << 2))
-			iio_push_event(chip->indio_dev, 0,
+			iio_push_event(indio_dev, 0,
 				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 1,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_RISING),
 				       time);
 		if (stat1 & (1 << 3))
-			iio_push_event(chip->indio_dev, 0,
+			iio_push_event(indio_dev, 0,
 				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 1,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_FALLING),
 				       time);
 		if (stat1 & (1 << 5))
-			iio_push_event(chip->indio_dev, 0,
+			iio_push_event(indio_dev, 0,
 				       IIO_UNMOD_EVENT_CODE(IIO_IN, 1,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_EITHER),
 				       time);
 		if (stat1 & (1 << 6))
-			iio_push_event(chip->indio_dev, 0,
+			iio_push_event(indio_dev, 0,
 				       IIO_UNMOD_EVENT_CODE(IIO_IN, 2,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_EITHER),
 				       time);
 		if (stat1 & (1 << 7))
-			iio_push_event(chip->indio_dev, 0,
+			iio_push_event(indio_dev, 0,
 				       IIO_UNMOD_EVENT_CODE(IIO_IN, 3,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_EITHER),
@@ -1822,7 +1821,7 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
 	ret = chip->bus.read(chip->bus.client, ADT7316_INT_STAT2, &stat2);
 	if (!ret) {
 		if (stat2 & ADT7316_INT_MASK2_VDD)
-			iio_push_event(chip->indio_dev, 0,
+			iio_push_event(indio_dev, 0,
 				       IIO_UNMOD_EVENT_CODE(IIO_IN,
 							    0,
 							    IIO_EV_TYPE_THRESH,
@@ -1841,7 +1840,7 @@ static ssize_t adt7316_show_int_mask(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "0x%x\n", chip->int_mask);
 }
@@ -1855,7 +1854,7 @@ static ssize_t adt7316_set_int_mask(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	unsigned long data;
 	int ret;
 	u8 mask;
@@ -1895,7 +1894,7 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 val;
 	int data;
 	int ret;
@@ -1926,7 +1925,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	long data;
 	u8 val;
 	int ret;
@@ -1965,7 +1964,7 @@ static ssize_t adt7316_show_int_enabled(struct device *dev,
 		char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sprintf(buf, "%d\n", !!(chip->config1 & ADT7316_INT_EN));
 }
@@ -1976,7 +1975,7 @@ static ssize_t adt7316_set_int_enabled(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config1;
 	int ret;
 
@@ -2090,7 +2089,7 @@ static struct attribute_group adt7516_event_attribute_group = {
 int adt7316_disable(struct device *dev)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return _adt7316_store_enabled(chip, 0);
 }
@@ -2099,7 +2098,7 @@ EXPORT_SYMBOL(adt7316_disable);
 int adt7316_enable(struct device *dev)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return _adt7316_store_enabled(chip, 1);
 }
@@ -2127,16 +2126,18 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 		const char *name)
 {
 	struct adt7316_chip_info *chip;
+	struct iio_dev *indio_dev;
 	unsigned short *adt7316_platform_data = dev->platform_data;
 	int ret = 0;
 
-	chip = kzalloc(sizeof(struct adt7316_chip_info), GFP_KERNEL);
-
-	if (chip == NULL)
-		return -ENOMEM;
-
+	indio_dev = iio_allocate_device(sizeof(*chip));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	chip = iio_priv(indio_dev);
 	/* this is only used for device removal purposes */
-	dev_set_drvdata(dev, chip);
+	dev_set_drvdata(dev, indio_dev);
 
 	chip->bus = *bus;
 
@@ -2157,22 +2158,15 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 		chip->int_mask |= ADT7516_AIN_INT_MASK;
 
-	chip->indio_dev = iio_allocate_device(0);
-	if (chip->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_chip;
-	}
-
-	chip->indio_dev->dev.parent = dev;
+	indio_dev->dev.parent = dev;
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
-		chip->indio_dev->info = &adt7516_info;
+		indio_dev->info = &adt7516_info;
 	else
-		chip->indio_dev->info = &adt7316_info;
-	chip->indio_dev->name = name;
-	chip->indio_dev->dev_data = (void *)chip;
-	chip->indio_dev->modes = INDIO_DIRECT_MODE;
+		indio_dev->info = &adt7316_info;
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(chip->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -2184,8 +2178,8 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 					   NULL,
 					   &adt7316_event_handler,
 					   chip->bus.irq_flags | IRQF_ONESHOT,
-					   chip->indio_dev->name,
-					   chip->indio_dev);
+					   indio_dev->name,
+					   indio_dev);
 		if (ret)
 			goto error_unreg_dev;
 
@@ -2206,35 +2200,31 @@ int __devinit adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	}
 
 	dev_info(dev, "%s temperature sensor, ADC and DAC registered.\n",
-			chip->indio_dev->name);
+			indio_dev->name);
 
 	return 0;
 
 error_unreg_irq:
-	free_irq(chip->bus.irq, chip->indio_dev);
+	free_irq(chip->bus.irq, indio_dev);
 error_unreg_dev:
-	iio_device_unregister(chip->indio_dev);
+	iio_device_unregister(indio_dev);
 error_free_dev:
-	iio_free_device(chip->indio_dev);
-error_free_chip:
-	kfree(chip);
-
+	iio_free_device(indio_dev);
+error_ret:
 	return ret;
 }
 EXPORT_SYMBOL(adt7316_probe);
 
 int __devexit adt7316_remove(struct device *dev)
 {
-
-	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct adt7316_chip_info *chip = dev_info->dev_data;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adt7316_chip_info *chip = iio_priv(indio_dev);
 
 	dev_set_drvdata(dev, NULL);
 	if (chip->bus.irq)
-		free_irq(chip->bus.irq, chip->indio_dev);
-	iio_device_unregister(chip->indio_dev);
-	iio_free_device(chip->indio_dev);
-	kfree(chip);
+		free_irq(chip->bus.irq, indio_dev);
+	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
 
 	return 0;
 }
-- 
1.7.3.4
