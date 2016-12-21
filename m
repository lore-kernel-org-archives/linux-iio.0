Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35841 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755402AbcLUDAI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2016 22:00:08 -0500
Received: by mail-oi0-f65.google.com with SMTP id u15so26575245oie.3
        for <linux-iio@vger.kernel.org>; Tue, 20 Dec 2016 19:00:08 -0800 (PST)
From: Scott Matheina <scott@matheina.com>
To: gregkh@linuxfoundation.org
Cc: Scott Matheina <scott@matheina.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] indention and space fixes to align with linux style
Date: Tue, 20 Dec 2016 20:58:13 -0600
Message-Id: <1482289187-7276-1-git-send-email-scott@matheina.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixed indention and space issues to align the code with the linux style guide.

Signed-off-by: Scott Matheina <scott@matheina.com>
---
 drivers/staging/iio/addac/adt7316.c | 603 ++++++++++++++++--------------------
 1 file changed, 266 insertions(+), 337 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index a7d90c8..6ba8d35 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -176,16 +176,16 @@
  */

 struct adt7316_chip_info {
-	struct adt7316_bus	bus;
-	u16			ldac_pin;
-	u16			int_mask;	/* 0x2f */
-	u8			config1;
-	u8			config2;
-	u8			config3;
-	u8			dac_config;	/* DAC config */
-	u8			ldac_config;	/* LDAC config */
-	u8			dac_bits;	/* 8, 10, 12 */
-	u8			id;		/* chip id */
+	struct adt7316_bus bus;
+	u16 ldac_pin;
+	u16 int_mask;		/* 0x2f */
+	u8 config1;
+	u8 config2;
+	u8 config3;
+	u8 dac_config;		/* DAC config */
+	u8 ldac_config;		/* LDAC config */
+	u8 dac_bits;		/* 8, 10, 12 */
+	u8 id;			/* chip id */
 };

 /*
@@ -212,13 +212,12 @@ struct adt7316_chip_info {
  */

 struct adt7316_limit_regs {
-	u16	data_high;
-	u16	data_low;
+	u16 data_high;
+	u16 data_low;
 };

 static ssize_t adt7316_show_enabled(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				    struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -227,7 +226,7 @@ static ssize_t adt7316_show_enabled(struct device *dev,
 }

 static ssize_t _adt7316_store_enabled(struct adt7316_chip_info *chip,
-		int enable)
+				      int enable)
 {
 	u8 config1;
 	int ret;
@@ -248,9 +247,8 @@ static ssize_t _adt7316_store_enabled(struct adt7316_chip_info *chip,
 }

 static ssize_t adt7316_store_enabled(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -268,13 +266,11 @@ static ssize_t adt7316_store_enabled(struct device *dev,
 }

 static IIO_DEVICE_ATTR(enabled, S_IRUGO | S_IWUSR,
-		adt7316_show_enabled,
-		adt7316_store_enabled,
-		0);
+		       adt7316_show_enabled, adt7316_store_enabled, 0);

 static ssize_t adt7316_show_select_ex_temp(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					   struct device_attribute *attr,
+					   char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -286,9 +282,8 @@ static ssize_t adt7316_show_select_ex_temp(struct device *dev,
 }

 static ssize_t adt7316_store_select_ex_temp(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -312,13 +307,11 @@ static ssize_t adt7316_store_select_ex_temp(struct device *dev,
 }

 static IIO_DEVICE_ATTR(select_ex_temp, S_IRUGO | S_IWUSR,
-		adt7316_show_select_ex_temp,
-		adt7316_store_select_ex_temp,
-		0);
+		       adt7316_show_select_ex_temp,
+		       adt7316_store_select_ex_temp, 0);

 static ssize_t adt7316_show_mode(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				 struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -330,9 +323,8 @@ static ssize_t adt7316_show_mode(struct device *dev,
 }

 static ssize_t adt7316_store_mode(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				  struct device_attribute *attr,
+				  const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -353,13 +345,10 @@ static ssize_t adt7316_store_mode(struct device *dev,
 }

 static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
-		adt7316_show_mode,
-		adt7316_store_mode,
-		0);
+		       adt7316_show_mode, adt7316_store_mode, 0);

 static ssize_t adt7316_show_all_modes(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				      struct device_attribute *attr, char *buf)
 {
 	return sprintf(buf, "single_channel\nround_robin\n");
 }
@@ -367,8 +356,7 @@ static ssize_t adt7316_show_all_modes(struct device *dev,
 static IIO_DEVICE_ATTR(all_modes, S_IRUGO, adt7316_show_all_modes, NULL, 0);

 static ssize_t adt7316_show_ad_channel(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				       struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -383,7 +371,7 @@ static ssize_t adt7316_show_ad_channel(struct device *dev,
 		return sprintf(buf, "1 - Internal Temperature\n");
 	case ADT7316_AD_SINGLE_CH_EX:
 		if (((chip->id & ID_FAMILY_MASK) == ID_ADT75XX) &&
-			(chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)
+		    (chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)
 			return sprintf(buf, "2 - AIN1\n");

 		return sprintf(buf, "2 - External Temperature\n");
@@ -405,9 +393,8 @@ static ssize_t adt7316_show_ad_channel(struct device *dev,
 }

 static ssize_t adt7316_store_ad_channel(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					struct device_attribute *attr,
+					const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -434,7 +421,6 @@ static ssize_t adt7316_store_ad_channel(struct device *dev,
 		config2 = chip->config2 & (~ADT7316_AD_SINGLE_CH_MASK);
 	}

-
 	config2 |= data;

 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
@@ -447,13 +433,11 @@ static ssize_t adt7316_store_ad_channel(struct device *dev,
 }

 static IIO_DEVICE_ATTR(ad_channel, S_IRUGO | S_IWUSR,
-		adt7316_show_ad_channel,
-		adt7316_store_ad_channel,
-		0);
+		       adt7316_show_ad_channel, adt7316_store_ad_channel, 0);

 static ssize_t adt7316_show_all_ad_channels(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					    struct device_attribute *attr,
+					    char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -463,30 +447,29 @@ static ssize_t adt7316_show_all_ad_channels(struct device *dev,

 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 		return sprintf(buf, "0 - VDD\n1 - Internal Temperature\n"
-				"2 - External Temperature or AIN1\n"
-				"3 - AIN2\n4 - AIN3\n5 - AIN4\n");
+			       "2 - External Temperature or AIN1\n"
+			       "3 - AIN2\n4 - AIN3\n5 - AIN4\n");
 	return sprintf(buf, "0 - VDD\n1 - Internal Temperature\n"
-			"2 - External Temperature\n");
+		       "2 - External Temperature\n");
 }

 static IIO_DEVICE_ATTR(all_ad_channels, S_IRUGO,
-		adt7316_show_all_ad_channels, NULL, 0);
+		       adt7316_show_all_ad_channels, NULL, 0);

 static ssize_t adt7316_show_disable_averaging(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					      struct device_attribute *attr,
+					      char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return sprintf(buf, "%d\n",
-		!!(chip->config2 & ADT7316_DISABLE_AVERAGING));
+		       !!(chip->config2 & ADT7316_DISABLE_AVERAGING));
 }

 static ssize_t adt7316_store_disable_averaging(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					       struct device_attribute *attr,
+					       const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -507,25 +490,23 @@ static ssize_t adt7316_store_disable_averaging(struct device *dev,
 }

 static IIO_DEVICE_ATTR(disable_averaging, S_IRUGO | S_IWUSR,
-		adt7316_show_disable_averaging,
-		adt7316_store_disable_averaging,
-		0);
+		       adt7316_show_disable_averaging,
+		       adt7316_store_disable_averaging, 0);

 static ssize_t adt7316_show_enable_smbus_timeout(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+						 struct device_attribute *attr,
+						 char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return sprintf(buf, "%d\n",
-		!!(chip->config2 & ADT7316_EN_SMBUS_TIMEOUT));
+		       !!(chip->config2 & ADT7316_EN_SMBUS_TIMEOUT));
 }

 static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+						  struct device_attribute *attr,
+						  const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -546,13 +527,11 @@ static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
 }

 static IIO_DEVICE_ATTR(enable_smbus_timeout, S_IRUGO | S_IWUSR,
-		adt7316_show_enable_smbus_timeout,
-		adt7316_store_enable_smbus_timeout,
-		0);
+		       adt7316_show_enable_smbus_timeout,
+		       adt7316_store_enable_smbus_timeout, 0);

 static ssize_t adt7316_show_powerdown(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				      struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -561,9 +540,8 @@ static ssize_t adt7316_show_powerdown(struct device *dev,
 }

 static ssize_t adt7316_store_powerdown(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -584,13 +562,11 @@ static ssize_t adt7316_store_powerdown(struct device *dev,
 }

 static IIO_DEVICE_ATTR(powerdown, S_IRUGO | S_IWUSR,
-		adt7316_show_powerdown,
-		adt7316_store_powerdown,
-		0);
+		       adt7316_show_powerdown, adt7316_store_powerdown, 0);

 static ssize_t adt7316_show_fast_ad_clock(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					  struct device_attribute *attr,
+					  char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -599,9 +575,8 @@ static ssize_t adt7316_show_fast_ad_clock(struct device *dev,
 }

 static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					   struct device_attribute *attr,
+					   const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -622,13 +597,12 @@ static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
 }

 static IIO_DEVICE_ATTR(fast_ad_clock, S_IRUGO | S_IWUSR,
-		adt7316_show_fast_ad_clock,
-		adt7316_store_fast_ad_clock,
-		0);
+		       adt7316_show_fast_ad_clock,
+		       adt7316_store_fast_ad_clock, 0);

 static ssize_t adt7316_show_da_high_resolution(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					       struct device_attribute *attr,
+					       char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -644,9 +618,8 @@ static ssize_t adt7316_show_da_high_resolution(struct device *dev,
 }

 static ssize_t adt7316_store_da_high_resolution(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+						struct device_attribute *attr,
+						const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -674,13 +647,12 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
 }

 static IIO_DEVICE_ATTR(da_high_resolution, S_IRUGO | S_IWUSR,
-		adt7316_show_da_high_resolution,
-		adt7316_store_da_high_resolution,
-		0);
+		       adt7316_show_da_high_resolution,
+		       adt7316_store_da_high_resolution, 0);

 static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					      struct device_attribute *attr,
+					      char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -688,14 +660,12 @@ static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
 	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
 		return -EPERM;

-	return sprintf(buf, "%d\n",
-		!!(chip->config3 & ADT7516_AIN_IN_VREF));
+	return sprintf(buf, "%d\n", !!(chip->config3 & ADT7516_AIN_IN_VREF));
 }

 static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					       struct device_attribute *attr,
+					       const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -720,26 +690,23 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
 }

 static IIO_DEVICE_ATTR(AIN_internal_Vref, S_IRUGO | S_IWUSR,
-		adt7316_show_AIN_internal_Vref,
-		adt7316_store_AIN_internal_Vref,
-		0);
-
+		       adt7316_show_AIN_internal_Vref,
+		       adt7316_store_AIN_internal_Vref, 0);

 static ssize_t adt7316_show_enable_prop_DACA(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					     struct device_attribute *attr,
+					     char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return sprintf(buf, "%d\n",
-		!!(chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA));
+		       !!(chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA));
 }

 static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					      struct device_attribute *attr,
+					      const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -760,25 +727,23 @@ static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
 }

 static IIO_DEVICE_ATTR(enable_proportion_DACA, S_IRUGO | S_IWUSR,
-		adt7316_show_enable_prop_DACA,
-		adt7316_store_enable_prop_DACA,
-		0);
+		       adt7316_show_enable_prop_DACA,
+		       adt7316_store_enable_prop_DACA, 0);

 static ssize_t adt7316_show_enable_prop_DACB(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					     struct device_attribute *attr,
+					     char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return sprintf(buf, "%d\n",
-		!!(chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB));
+		       !!(chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB));
 }

 static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					      struct device_attribute *attr,
+					      const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -799,25 +764,23 @@ static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
 }

 static IIO_DEVICE_ATTR(enable_proportion_DACB, S_IRUGO | S_IWUSR,
-		adt7316_show_enable_prop_DACB,
-		adt7316_store_enable_prop_DACB,
-		0);
+		       adt7316_show_enable_prop_DACB,
+		       adt7316_store_enable_prop_DACB, 0);

 static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					      struct device_attribute *attr,
+					      char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return sprintf(buf, "0x%x\n",
-		chip->dac_config & ADT7316_DA_2VREF_CH_MASK);
+		       chip->dac_config & ADT7316_DA_2VREF_CH_MASK);
 }

 static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					       struct device_attribute *attr,
+					       const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -842,13 +805,12 @@ static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
 }

 static IIO_DEVICE_ATTR(DAC_2Vref_channels_mask, S_IRUGO | S_IWUSR,
-		adt7316_show_DAC_2Vref_ch_mask,
-		adt7316_store_DAC_2Vref_ch_mask,
-		0);
+		       adt7316_show_DAC_2Vref_ch_mask,
+		       adt7316_store_DAC_2Vref_ch_mask, 0);

 static ssize_t adt7316_show_DAC_update_mode(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					    struct device_attribute *attr,
+					    char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -858,23 +820,19 @@ static ssize_t adt7316_show_DAC_update_mode(struct device *dev,

 	switch (chip->dac_config & ADT7316_DA_EN_MODE_MASK) {
 	case ADT7316_DA_EN_MODE_SINGLE:
-		return sprintf(buf,
-			"0 - auto at any MSB DAC writing\n");
+		return sprintf(buf, "0 - auto at any MSB DAC writing\n");
 	case ADT7316_DA_EN_MODE_AB_CD:
-		return sprintf(buf,
-			"1 - auto at MSB DAC AB and CD writing\n");
+		return sprintf(buf, "1 - auto at MSB DAC AB and CD writing\n");
 	case ADT7316_DA_EN_MODE_ABCD:
-		return sprintf(buf,
-			"2 - auto at MSB DAC ABCD writing\n");
-	default: /* ADT7316_DA_EN_MODE_LDAC */
+		return sprintf(buf, "2 - auto at MSB DAC ABCD writing\n");
+	default:		/* ADT7316_DA_EN_MODE_LDAC */
 		return sprintf(buf, "3 - manual\n");
 	}
 }

 static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					     struct device_attribute *attr,
+					     const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -902,33 +860,30 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
 }

 static IIO_DEVICE_ATTR(DAC_update_mode, S_IRUGO | S_IWUSR,
-		adt7316_show_DAC_update_mode,
-		adt7316_store_DAC_update_mode,
-		0);
+		       adt7316_show_DAC_update_mode,
+		       adt7316_store_DAC_update_mode, 0);

 static ssize_t adt7316_show_all_DAC_update_modes(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+						 struct device_attribute *attr,
+						 char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA)
 		return sprintf(buf, "0 - auto at any MSB DAC writing\n"
-				"1 - auto at MSB DAC AB and CD writing\n"
-				"2 - auto at MSB DAC ABCD writing\n"
-				"3 - manual\n");
+			       "1 - auto at MSB DAC AB and CD writing\n"
+			       "2 - auto at MSB DAC ABCD writing\n"
+			       "3 - manual\n");
 	return sprintf(buf, "manual\n");
 }

 static IIO_DEVICE_ATTR(all_DAC_update_modes, S_IRUGO,
-		adt7316_show_all_DAC_update_modes, NULL, 0);
-
+		       adt7316_show_all_DAC_update_modes, NULL, 0);

 static ssize_t adt7316_store_update_DAC(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					struct device_attribute *attr,
+					const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -938,7 +893,7 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,

 	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDCA) {
 		if ((chip->dac_config & ADT7316_DA_EN_MODE_MASK) !=
-			ADT7316_DA_EN_MODE_LDAC)
+		    ADT7316_DA_EN_MODE_LDAC)
 			return -EPERM;

 		ret = kstrtou8(buf, 16, &data);
@@ -949,7 +904,7 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
 		ldac_config |= data;

 		ret = chip->bus.write(chip->bus.client, ADT7316_LDAC_CONFIG,
-			ldac_config);
+				      ldac_config);
 		if (ret)
 			return -EIO;
 	} else {
@@ -961,13 +916,11 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
 }

 static IIO_DEVICE_ATTR(update_DAC, S_IRUGO | S_IWUSR,
-		NULL,
-		adt7316_store_update_DAC,
-		0);
+		       NULL, adt7316_store_update_DAC, 0);

 static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					      struct device_attribute *attr,
+					      char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -976,13 +929,12 @@ static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
 		return -EPERM;

 	return sprintf(buf, "%d\n",
-		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_AB));
+		       !!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_AB));
 }

 static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					       struct device_attribute *attr,
+					       const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1006,13 +958,12 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
 }

 static IIO_DEVICE_ATTR(DA_AB_Vref_bypass, S_IRUGO | S_IWUSR,
-		adt7316_show_DA_AB_Vref_bypass,
-		adt7316_store_DA_AB_Vref_bypass,
-		0);
+		       adt7316_show_DA_AB_Vref_bypass,
+		       adt7316_store_DA_AB_Vref_bypass, 0);

 static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					      struct device_attribute *attr,
+					      char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1021,13 +972,12 @@ static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
 		return -EPERM;

 	return sprintf(buf, "%d\n",
-		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_CD));
+		       !!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_CD));
 }

 static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					       struct device_attribute *attr,
+					       const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1051,29 +1001,27 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
 }

 static IIO_DEVICE_ATTR(DA_CD_Vref_bypass, S_IRUGO | S_IWUSR,
-		adt7316_show_DA_CD_Vref_bypass,
-		adt7316_store_DA_CD_Vref_bypass,
-		0);
+		       adt7316_show_DA_CD_Vref_bypass,
+		       adt7316_store_DA_CD_Vref_bypass, 0);

 static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					      struct device_attribute *attr,
+					      char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 		return sprintf(buf, "0x%x\n",
-			(chip->dac_config & ADT7516_DAC_IN_VREF_MASK) >>
-			ADT7516_DAC_IN_VREF_OFFSET);
+			       (chip->dac_config & ADT7516_DAC_IN_VREF_MASK) >>
+			       ADT7516_DAC_IN_VREF_OFFSET);
 	return sprintf(buf, "%d\n",
 		       !!(chip->dac_config & ADT7316_DAC_IN_VREF));
 }

 static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					       struct device_attribute *attr,
+					       const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1102,7 +1050,7 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
 	}

 	ret = chip->bus.write(chip->bus.client, ADT7316_LDAC_CONFIG,
-			ldac_config);
+			      ldac_config);
 	if (ret)
 		return -EIO;

@@ -1112,12 +1060,11 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
 }

 static IIO_DEVICE_ATTR(DAC_internal_Vref, S_IRUGO | S_IWUSR,
-		adt7316_show_DAC_internal_Vref,
-		adt7316_store_DAC_internal_Vref,
-		0);
+		       adt7316_show_DAC_internal_Vref,
+		       adt7316_store_DAC_internal_Vref, 0);

 static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
-		int channel, char *buf)
+			       int channel, char *buf)
 {
 	u16 data;
 	u8 msb, lsb;
@@ -1125,18 +1072,18 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 	int ret;

 	if ((chip->config2 & ADT7316_AD_SINGLE_CH_MODE) &&
-		channel != (chip->config2 & ADT7516_AD_SINGLE_CH_MASK))
+	    channel != (chip->config2 & ADT7516_AD_SINGLE_CH_MASK))
 		return -EPERM;

 	switch (channel) {
 	case ADT7316_AD_SINGLE_CH_IN:
 		ret = chip->bus.read(chip->bus.client,
-			ADT7316_LSB_IN_TEMP_VDD, &lsb);
+				     ADT7316_LSB_IN_TEMP_VDD, &lsb);
 		if (ret)
 			return -EIO;

 		ret = chip->bus.read(chip->bus.client,
-			ADT7316_AD_MSB_DATA_BASE + channel, &msb);
+				     ADT7316_AD_MSB_DATA_BASE + channel, &msb);
 		if (ret)
 			return -EIO;

@@ -1145,34 +1092,34 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 		break;
 	case ADT7316_AD_SINGLE_CH_VDD:
 		ret = chip->bus.read(chip->bus.client,
-			ADT7316_LSB_IN_TEMP_VDD, &lsb);
+				     ADT7316_LSB_IN_TEMP_VDD, &lsb);
 		if (ret)
 			return -EIO;

 		ret = chip->bus.read(chip->bus.client,
-
-			ADT7316_AD_MSB_DATA_BASE + channel, &msb);
+				     ADT7316_AD_MSB_DATA_BASE + channel, &msb);
 		if (ret)
 			return -EIO;

 		data = msb << ADT7316_T_VALUE_FLOAT_OFFSET;
 		data |= (lsb & ADT7316_LSB_VDD_MASK) >> ADT7316_LSB_VDD_OFFSET;
 		return sprintf(buf, "%d\n", data);
-	default: /* ex_temp and ain */
+	default:		/* ex_temp and ain */
 		ret = chip->bus.read(chip->bus.client,
-			ADT7316_LSB_EX_TEMP_AIN, &lsb);
+				     ADT7316_LSB_EX_TEMP_AIN, &lsb);
 		if (ret)
 			return -EIO;

 		ret = chip->bus.read(chip->bus.client,
-			ADT7316_AD_MSB_DATA_BASE + channel, &msb);
+				     ADT7316_AD_MSB_DATA_BASE + channel, &msb);
 		if (ret)
 			return -EIO;

 		data = msb << ADT7316_T_VALUE_FLOAT_OFFSET;
 		data |= lsb & (ADT7316_LSB_EX_TEMP_MASK <<
-			(ADT7516_LSB_AIN_SHIFT * (channel -
-			(ADT7316_MSB_EX_TEMP - ADT7316_AD_MSB_DATA_BASE))));
+			       (ADT7516_LSB_AIN_SHIFT * (channel -
+							 (ADT7316_MSB_EX_TEMP -
+							  ADT7316_AD_MSB_DATA_BASE))));

 		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 			return sprintf(buf, "%d\n", data);
@@ -1187,24 +1134,23 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 	}

 	return sprintf(buf, "%c%d.%.2d\n", sign,
-		(data >> ADT7316_T_VALUE_FLOAT_OFFSET),
-		(data & ADT7316_T_VALUE_FLOAT_MASK) * 25);
+		       (data >> ADT7316_T_VALUE_FLOAT_OFFSET),
+		       (data & ADT7316_T_VALUE_FLOAT_MASK) * 25);
 }

 static ssize_t adt7316_show_VDD(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_VDD, buf);
 }
+
 static IIO_DEVICE_ATTR(VDD, S_IRUGO, adt7316_show_VDD, NULL, 0);

 static ssize_t adt7316_show_in_temp(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				    struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1215,8 +1161,8 @@ static ssize_t adt7316_show_in_temp(struct device *dev,
 static IIO_DEVICE_ATTR(in_temp, S_IRUGO, adt7316_show_in_temp, NULL, 0);

 static ssize_t adt7316_show_ex_temp_AIN1(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					 struct device_attribute *attr,
+					 char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1225,44 +1171,44 @@ static ssize_t adt7316_show_ex_temp_AIN1(struct device *dev,
 }

 static IIO_DEVICE_ATTR(ex_temp_AIN1, S_IRUGO, adt7316_show_ex_temp_AIN1,
-		NULL, 0);
+		       NULL, 0);
 static IIO_DEVICE_ATTR(ex_temp, S_IRUGO, adt7316_show_ex_temp_AIN1, NULL, 0);

 static ssize_t adt7316_show_AIN2(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				 struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN2, buf);
 }
+
 static IIO_DEVICE_ATTR(AIN2, S_IRUGO, adt7316_show_AIN2, NULL, 0);

 static ssize_t adt7316_show_AIN3(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				 struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN3, buf);
 }
+
 static IIO_DEVICE_ATTR(AIN3, S_IRUGO, adt7316_show_AIN3, NULL, 0);

 static ssize_t adt7316_show_AIN4(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				 struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN4, buf);
 }
+
 static IIO_DEVICE_ATTR(AIN4, S_IRUGO, adt7316_show_AIN4, NULL, 0);

 static ssize_t adt7316_show_temp_offset(struct adt7316_chip_info *chip,
-		int offset_addr, char *buf)
+					int offset_addr, char *buf)
 {
 	int data;
 	u8 val;
@@ -1280,7 +1226,8 @@ static ssize_t adt7316_show_temp_offset(struct adt7316_chip_info *chip,
 }

 static ssize_t adt7316_store_temp_offset(struct adt7316_chip_info *chip,
-		int offset_addr, const char *buf, size_t len)
+					 int offset_addr, const char *buf,
+					 size_t len)
 {
 	int data;
 	u8 val;
@@ -1293,7 +1240,7 @@ static ssize_t adt7316_store_temp_offset(struct adt7316_chip_info *chip,
 	if (data < 0)
 		data += 256;

-	val = (u8)data;
+	val = (u8) data;

 	ret = chip->bus.write(chip->bus.client, offset_addr, val);
 	if (ret)
@@ -1303,8 +1250,8 @@ static ssize_t adt7316_store_temp_offset(struct adt7316_chip_info *chip,
 }

 static ssize_t adt7316_show_in_temp_offset(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					   struct device_attribute *attr,
+					   char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1313,24 +1260,23 @@ static ssize_t adt7316_show_in_temp_offset(struct device *dev,
 }

 static ssize_t adt7316_store_in_temp_offset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return adt7316_store_temp_offset(chip, ADT7316_IN_TEMP_OFFSET, buf,
-			len);
+					 len);
 }

 static IIO_DEVICE_ATTR(in_temp_offset, S_IRUGO | S_IWUSR,
-		adt7316_show_in_temp_offset,
-		adt7316_store_in_temp_offset, 0);
+		       adt7316_show_in_temp_offset,
+		       adt7316_store_in_temp_offset, 0);

 static ssize_t adt7316_show_ex_temp_offset(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					   struct device_attribute *attr,
+					   char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1339,100 +1285,100 @@ static ssize_t adt7316_show_ex_temp_offset(struct device *dev,
 }

 static ssize_t adt7316_store_ex_temp_offset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return adt7316_store_temp_offset(chip, ADT7316_EX_TEMP_OFFSET, buf,
-			len);
+					 len);
 }

 static IIO_DEVICE_ATTR(ex_temp_offset, S_IRUGO | S_IWUSR,
-		adt7316_show_ex_temp_offset,
-		adt7316_store_ex_temp_offset, 0);
+		       adt7316_show_ex_temp_offset,
+		       adt7316_store_ex_temp_offset, 0);

 static ssize_t adt7316_show_in_analog_temp_offset(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+						  struct device_attribute *attr,
+						  char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return adt7316_show_temp_offset(chip,
-			ADT7316_IN_ANALOG_TEMP_OFFSET, buf);
+					ADT7316_IN_ANALOG_TEMP_OFFSET, buf);
 }

 static ssize_t adt7316_store_in_analog_temp_offset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+						   struct device_attribute
+						   *attr, const char *buf,
+						   size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return adt7316_store_temp_offset(chip,
-			ADT7316_IN_ANALOG_TEMP_OFFSET, buf, len);
+					 ADT7316_IN_ANALOG_TEMP_OFFSET, buf,
+					 len);
 }

 static IIO_DEVICE_ATTR(in_analog_temp_offset, S_IRUGO | S_IWUSR,
-		adt7316_show_in_analog_temp_offset,
-		adt7316_store_in_analog_temp_offset, 0);
+		       adt7316_show_in_analog_temp_offset,
+		       adt7316_store_in_analog_temp_offset, 0);

 static ssize_t adt7316_show_ex_analog_temp_offset(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+						  struct device_attribute *attr,
+						  char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return adt7316_show_temp_offset(chip,
-			ADT7316_EX_ANALOG_TEMP_OFFSET, buf);
+					ADT7316_EX_ANALOG_TEMP_OFFSET, buf);
 }

 static ssize_t adt7316_store_ex_analog_temp_offset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+						   struct device_attribute
+						   *attr, const char *buf,
+						   size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);

 	return adt7316_store_temp_offset(chip,
-			ADT7316_EX_ANALOG_TEMP_OFFSET, buf, len);
+					 ADT7316_EX_ANALOG_TEMP_OFFSET, buf,
+					 len);
 }

 static IIO_DEVICE_ATTR(ex_analog_temp_offset, S_IRUGO | S_IWUSR,
-		adt7316_show_ex_analog_temp_offset,
-		adt7316_store_ex_analog_temp_offset, 0);
+		       adt7316_show_ex_analog_temp_offset,
+		       adt7316_store_ex_analog_temp_offset, 0);

 static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
-		int channel, char *buf)
+				int channel, char *buf)
 {
 	u16 data;
 	u8 msb, lsb, offset;
 	int ret;

 	if (channel >= ADT7316_DA_MSB_DATA_REGS ||
-		(channel == 0 &&
-		(chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA)) ||
-		(channel == 1 &&
-		(chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB)))
+	    (channel == 0 &&
+	     (chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA)) ||
+	    (channel == 1 && (chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB)))
 		return -EPERM;

 	offset = chip->dac_bits - 8;

 	if (chip->dac_bits > 8) {
 		ret = chip->bus.read(chip->bus.client,
-			ADT7316_DA_DATA_BASE + channel * 2, &lsb);
+				     ADT7316_DA_DATA_BASE + channel * 2, &lsb);
 		if (ret)
 			return -EIO;
 	}

 	ret = chip->bus.read(chip->bus.client,
-		ADT7316_DA_DATA_BASE + 1 + channel * 2, &msb);
+			     ADT7316_DA_DATA_BASE + 1 + channel * 2, &msb);
 	if (ret)
 		return -EIO;

@@ -1442,17 +1388,16 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
 }

 static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
-		int channel, const char *buf, size_t len)
+				 int channel, const char *buf, size_t len)
 {
 	u8 msb, lsb, offset;
 	u16 data;
 	int ret;

 	if (channel >= ADT7316_DA_MSB_DATA_REGS ||
-		(channel == 0 &&
-		(chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA)) ||
-		(channel == 1 &&
-		(chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB)))
+	    (channel == 0 &&
+	     (chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA)) ||
+	    (channel == 1 && (chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB)))
 		return -EPERM;

 	offset = chip->dac_bits - 8;
@@ -1464,14 +1409,14 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
 	if (chip->dac_bits > 8) {
 		lsb = data & (1 << offset);
 		ret = chip->bus.write(chip->bus.client,
-			ADT7316_DA_DATA_BASE + channel * 2, lsb);
+				      ADT7316_DA_DATA_BASE + channel * 2, lsb);
 		if (ret)
 			return -EIO;
 	}

 	msb = data >> offset;
 	ret = chip->bus.write(chip->bus.client,
-		ADT7316_DA_DATA_BASE + 1 + channel * 2, msb);
+			      ADT7316_DA_DATA_BASE + 1 + channel * 2, msb);
 	if (ret)
 		return -EIO;

@@ -1479,8 +1424,7 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
 }

 static ssize_t adt7316_show_DAC_A(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				  struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1489,9 +1433,8 @@ static ssize_t adt7316_show_DAC_A(struct device *dev,
 }

 static ssize_t adt7316_store_DAC_A(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1500,11 +1443,10 @@ static ssize_t adt7316_store_DAC_A(struct device *dev,
 }

 static IIO_DEVICE_ATTR(DAC_A, S_IRUGO | S_IWUSR, adt7316_show_DAC_A,
-		adt7316_store_DAC_A, 0);
+		       adt7316_store_DAC_A, 0);

 static ssize_t adt7316_show_DAC_B(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				  struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1513,9 +1455,8 @@ static ssize_t adt7316_show_DAC_B(struct device *dev,
 }

 static ssize_t adt7316_store_DAC_B(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1524,11 +1465,10 @@ static ssize_t adt7316_store_DAC_B(struct device *dev,
 }

 static IIO_DEVICE_ATTR(DAC_B, S_IRUGO | S_IWUSR, adt7316_show_DAC_B,
-		adt7316_store_DAC_B, 0);
+		       adt7316_store_DAC_B, 0);

 static ssize_t adt7316_show_DAC_C(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				  struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1537,9 +1477,8 @@ static ssize_t adt7316_show_DAC_C(struct device *dev,
 }

 static ssize_t adt7316_store_DAC_C(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1548,11 +1487,10 @@ static ssize_t adt7316_store_DAC_C(struct device *dev,
 }

 static IIO_DEVICE_ATTR(DAC_C, S_IRUGO | S_IWUSR, adt7316_show_DAC_C,
-		adt7316_store_DAC_C, 0);
+		       adt7316_store_DAC_C, 0);

 static ssize_t adt7316_show_DAC_D(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				  struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1561,9 +1499,8 @@ static ssize_t adt7316_show_DAC_D(struct device *dev,
 }

 static ssize_t adt7316_store_DAC_D(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				   struct device_attribute *attr,
+				   const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1572,11 +1509,10 @@ static ssize_t adt7316_store_DAC_D(struct device *dev,
 }

 static IIO_DEVICE_ATTR(DAC_D, S_IRUGO | S_IWUSR, adt7316_show_DAC_D,
-		adt7316_store_DAC_D, 0);
+		       adt7316_store_DAC_D, 0);

 static ssize_t adt7316_show_device_id(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				      struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1593,8 +1529,8 @@ static ssize_t adt7316_show_device_id(struct device *dev,
 static IIO_DEVICE_ATTR(device_id, S_IRUGO, adt7316_show_device_id, NULL, 0);

 static ssize_t adt7316_show_manufactorer_id(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					    struct device_attribute *attr,
+					    char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1609,11 +1545,10 @@ static ssize_t adt7316_show_manufactorer_id(struct device *dev,
 }

 static IIO_DEVICE_ATTR(manufactorer_id, S_IRUGO,
-		adt7316_show_manufactorer_id, NULL, 0);
+		       adt7316_show_manufactorer_id, NULL, 0);

 static ssize_t adt7316_show_device_rev(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				       struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1630,8 +1565,7 @@ static ssize_t adt7316_show_device_rev(struct device *dev,
 static IIO_DEVICE_ATTR(device_rev, S_IRUGO, adt7316_show_device_rev, NULL, 0);

 static ssize_t adt7316_show_bus_type(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				     struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1795,7 +1729,7 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_EITHER),
 				       time);
-		}
+	}
 	ret = chip->bus.read(chip->bus.client, ADT7316_INT_STAT2, &stat2);
 	if (!ret) {
 		if (stat2 & ADT7316_INT_MASK2_VDD)
@@ -1814,8 +1748,7 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
  * Show mask of enabled interrupts in Hex.
  */
 static ssize_t adt7316_show_int_mask(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				     struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1827,9 +1760,8 @@ static ssize_t adt7316_show_int_mask(struct device *dev,
  * Set 1 to the mask in Hex to enabled interrupts.
  */
 static ssize_t adt7316_set_int_mask(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				    struct device_attribute *attr,
+				    const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1842,7 +1774,7 @@ static ssize_t adt7316_set_int_mask(struct device *dev,
 		return -EINVAL;

 	if (data & ADT7316_VDD_INT_MASK)
-		mask = 0;			/* enable vdd int */
+		mask = 0;	/* enable vdd int */
 	else
 		mask = ADT7316_INT_MASK2_VDD;	/* disable vdd int */

@@ -1866,9 +1798,10 @@ static ssize_t adt7316_set_int_mask(struct device *dev,

 	return len;
 }
+
 static inline ssize_t adt7316_show_ad_bound(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					    struct device_attribute *attr,
+					    char *buf)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
@@ -1878,7 +1811,7 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
 	int ret;

 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT73XX &&
-		this_attr->address > ADT7316_EX_TEMP_LOW)
+	    this_attr->address > ADT7316_EX_TEMP_LOW)
 		return -EPERM;

 	ret = chip->bus.read(chip->bus.client, this_attr->address, &val);
@@ -1888,7 +1821,7 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
 	data = (int)val;

 	if (!((chip->id & ID_FAMILY_MASK) == ID_ADT75XX &&
-		(chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)) {
+	      (chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)) {
 		if (data & 0x80)
 			data -= 256;
 	}
@@ -1897,9 +1830,8 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
 }

 static inline ssize_t adt7316_set_ad_bound(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					   struct device_attribute *attr,
+					   const char *buf, size_t len)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
@@ -1909,7 +1841,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
 	int ret;

 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT73XX &&
-		this_attr->address > ADT7316_EX_TEMP_LOW)
+	    this_attr->address > ADT7316_EX_TEMP_LOW)
 		return -EPERM;

 	ret = kstrtoint(buf, 10, &data);
@@ -1917,7 +1849,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
 		return -EINVAL;

 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX &&
-		(chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0) {
+	    (chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0) {
 		if (data > 255 || data < 0)
 			return -EINVAL;
 	} else {
@@ -1928,7 +1860,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
 			data += 256;
 	}

-	val = (u8)data;
+	val = (u8) data;

 	ret = chip->bus.write(chip->bus.client, this_attr->address, val);
 	if (ret)
@@ -1938,8 +1870,8 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
 }

 static ssize_t adt7316_show_int_enabled(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					struct device_attribute *attr,
+					char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1948,9 +1880,8 @@ static ssize_t adt7316_show_int_enabled(struct device *dev,
 }

 static ssize_t adt7316_set_int_enabled(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1972,8 +1903,7 @@ static ssize_t adt7316_set_int_enabled(struct device *dev,

 static IIO_DEVICE_ATTR(int_mask,
 		       S_IRUGO | S_IWUSR,
-		       adt7316_show_int_mask, adt7316_set_int_mask,
-		       0);
+		       adt7316_show_int_mask, adt7316_set_int_mask, 0);
 static IIO_DEVICE_ATTR(in_temp_high_value,
 		       S_IRUGO | S_IWUSR,
 		       adt7316_show_ad_bound, adt7316_set_ad_bound,
@@ -2026,8 +1956,7 @@ static IIO_DEVICE_ATTR(ain4_low_value,
 		       ADT7516_AIN4_LOW);
 static IIO_DEVICE_ATTR(int_enabled,
 		       S_IRUGO | S_IWUSR,
-		       adt7316_show_int_enabled,
-		       adt7316_set_int_enabled, 0);
+		       adt7316_show_int_enabled, adt7316_set_int_enabled, 0);

 static struct attribute *adt7316_event_attributes[] = {
 	&iio_dev_attr_int_mask.dev_attr.attr,
@@ -2101,8 +2030,7 @@ static const struct iio_info adt7516_info = {
 /*
  * device probe and remove
  */
-int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
-		const char *name)
+int adt7316_probe(struct device *dev, struct adt7316_bus *bus, const char *name)
 {
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
@@ -2152,8 +2080,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 						adt7316_event_handler,
 						chip->bus.irq_flags |
 						IRQF_ONESHOT,
-						indio_dev->name,
-						indio_dev);
+						indio_dev->name, indio_dev);
 		if (ret)
 			return ret;

@@ -2174,12 +2101,14 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 		return ret;

 	dev_info(dev, "%s temperature sensor, ADC and DAC registered.\n",
-			indio_dev->name);
+		 indio_dev->name);

 	return 0;
 }
+
 EXPORT_SYMBOL(adt7316_probe);

 MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
-MODULE_DESCRIPTION("Analog Devices ADT7316/7/8 and ADT7516/7/9 digital temperature sensor, ADC and DAC driver");
+MODULE_DESCRIPTION
+    ("Analog Devices ADT7316/7/8 and ADT7516/7/9 digital temperature sensor, ADC and DAC driver");
 MODULE_LICENSE("GPL v2");
--
2.7.4

