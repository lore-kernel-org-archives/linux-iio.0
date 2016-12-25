Return-Path: <SRS0=yNKi=YI=matheina.com=scott@kernel.org>
From: Scott Matheina <scott@matheina.com>
To: linux-kernel@vger.kernel.org
Cc: Scott Matheina <scott@matheina.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: [PATCHv4 8/8] Fixes style issues due to mis-aligned carry over lines
Date: Sun, 25 Dec 2016 13:56:46 -0600
Message-Id: <1482696216-8013-9-git-send-email-scott@matheina.com>
In-Reply-To: <1482696216-8013-1-git-send-email-scott@matheina.com>
References: <1482696216-8013-1-git-send-email-scott@matheina.com>
List-ID: <linux-iio@vger.kernel.org>

Lines were not aligned with (, this patch simply changes the indention, no substantive
changes function of driver.

Signed-Off-By: Scott Matheina <scott@matheina.com>
---
 drivers/staging/iio/addac/adt7316.c | 415 ++++++++++++++++++------------------
 1 file changed, 210 insertions(+), 205 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index e8e58d5..8b4a80d 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -217,8 +217,8 @@ struct adt7316_limit_regs {
 };
 
 static ssize_t adt7316_show_enabled(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				    struct device_attribute *attr,
+				    char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -227,7 +227,7 @@ static ssize_t adt7316_show_enabled(struct device *dev,
 }
 
 static ssize_t _adt7316_store_enabled(struct adt7316_chip_info *chip,
-		int enable)
+				      int enable)
 {
 	u8 config1;
 	int ret;
@@ -244,13 +244,12 @@ static ssize_t _adt7316_store_enabled(struct adt7316_chip_info *chip,
 	chip->config1 = config1;
 
 	return ret;
-
 }
 
 static ssize_t adt7316_store_enabled(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				     struct device_attribute *attr,
+				     const char *buf,
+				     size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -271,8 +270,8 @@ static iio_device_attr(enabled, 0644, adt7316_show_enabled,
 		       adt7316_store_enabled, 0);
 
 static ssize_t adt7316_show_select_ex_temp(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					   struct device_attribute *attr,
+					   char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -284,9 +283,9 @@ static ssize_t adt7316_show_select_ex_temp(struct device *dev,
 }
 
 static ssize_t adt7316_store_select_ex_temp(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -326,9 +325,9 @@ static ssize_t adt7316_show_mode(struct device *dev,
 }
 
 static ssize_t adt7316_store_mode(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				  struct device_attribute *attr,
+				  const char *buf,
+				  size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -398,9 +397,9 @@ static ssize_t adt7316_show_ad_channel(struct device *dev,
 }
 
 static ssize_t adt7316_store_ad_channel(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					struct device_attribute *attr,
+					const char *buf,
+					size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -474,9 +473,9 @@ static ssize_t adt7316_show_disable_averaging(struct device *dev,
 }
 
 static ssize_t adt7316_store_disable_averaging(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					       struct device_attribute *attr,
+					       const char *buf,
+					       size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -511,9 +510,9 @@ static ssize_t adt7316_show_enable_smbus_timeout(struct device *dev,
 }
 
 static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+						  struct device_attribute *attr,
+						  const char *buf,
+						  size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -548,9 +547,9 @@ static ssize_t adt7316_show_powerdown(struct device *dev,
 }
 
 static ssize_t adt7316_store_powerdown(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				       struct device_attribute *attr,
+				       const char *buf,
+				       size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -584,9 +583,9 @@ static ssize_t adt7316_show_fast_ad_clock(struct device *dev,
 }
 
 static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					   struct device_attribute *attr,
+					   const char *buf,
+					   size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -610,8 +609,8 @@ static iio_device_attr(fast_ad_clock, 0644, adt7316_show_fast_ad_clock,
 		       adt7316_store_fast_ad_clock, 0);
 
 static ssize_t adt7316_show_da_high_resolution(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					       struct device_attribute *attr,
+					       char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -627,9 +626,9 @@ static ssize_t adt7316_show_da_high_resolution(struct device *dev,
 }
 
 static ssize_t adt7316_store_da_high_resolution(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+						struct device_attribute *attr,
+						const char *buf,
+						size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -661,9 +660,9 @@ static iio_device_attr(da_high_resolution, 0644,
 		       adt7316_show_da_high_resolution,
 		       adt7316_store_da_high_resolution, 0);
 
-static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t adt7316_show_ain_internal_vref(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -675,10 +674,10 @@ static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
 		!!(chip->config3 & ADT7516_AIN_IN_VREF));
 }
 
-static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static ssize_t adt7316_store_ain_internal_vref(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf,
+					       size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -706,10 +705,9 @@ static iio_device_attr(ain_internal_vref, 0644,
 		       adt7316_show_ain_internal_vref,
 		       adt7316_store_ain_internal_vref, 0);
 
-
-static ssize_t adt7316_show_enable_prop_DACA(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t adt7316_show_enable_prop_daca(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -718,10 +716,10 @@ static ssize_t adt7316_show_enable_prop_DACA(struct device *dev,
 		!!(chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA));
 }
 
-static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static ssize_t adt7316_store_enable_prop_daca(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf,
+					      size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -745,9 +743,9 @@ static iio_device_attr(enable_proportion_daca, 0644,
 		       adt7316_show_enable_prop_daca,
 		       adt7316_store_enable_prop_daca, 0);
 
-static ssize_t adt7316_show_enable_prop_DACB(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t adt7316_show_enable_prop_dacb(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -756,10 +754,10 @@ static ssize_t adt7316_show_enable_prop_DACB(struct device *dev,
 		!!(chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB));
 }
 
-static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static ssize_t adt7316_store_enable_prop_dacb(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf,
+					      size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -783,9 +781,9 @@ static iio_device_attr(enable_proportion_dacb, 0644,
 		       adt7316_show_enable_prop_dacb,
 		       adt7316_store_enable_prop_dacb, 0);
 
-static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t adt7316_show_dac_2vref_ch_mask(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -794,10 +792,10 @@ static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
 		chip->dac_config & ADT7316_DA_2VREF_CH_MASK);
 }
 
-static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static ssize_t adt7316_store_dac_2vref_ch_mask(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf,
+					       size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -825,9 +823,9 @@ static iio_device_attr(dac_2vref_channels_mask, 0644,
 		       adt7316_show_dac_2vref_ch_mask,
 		       adt7316_store_dac_2vref_ch_mask, 0);
 
-static ssize_t adt7316_show_DAC_update_mode(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t adt7316_show_dac_update_mode(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -850,10 +848,10 @@ static ssize_t adt7316_show_DAC_update_mode(struct device *dev,
 	}
 }
 
-static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static ssize_t adt7316_store_dac_update_mode(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf,
+					     size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -883,9 +881,9 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
 static iio_device_attr(DAC_update_mode, 0644, adt7316_show_dac_update_mode,
 		       adt7316_store_dac_update_mode, 0);
 
-static ssize_t adt7316_show_all_DAC_update_modes(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t adt7316_show_all_dac_update_modes(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -901,8 +899,8 @@ static ssize_t adt7316_show_all_DAC_update_modes(struct device *dev,
 static iio_device_attr(all_dac_update_modes, 0444,
 		       adt7316_show_all_dac_update_modes, NULL, 0);
 
-static ssize_t adt7316_store_update_DAC(struct device *dev,
-		struct device_attribute *attr,
+static ssize_t adt7316_store_update_dac(struct device *dev,
+					struct device_attribute *attr,
 		const char *buf,
 		size_t len)
 {
@@ -938,9 +936,9 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
 
 static iio_device_attr(update_dac, 0644, NULL, adt7316_store_update_dac, 0);
 
-static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t adt7316_show_da_ab_vref_bypass(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -952,10 +950,10 @@ static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
 		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_AB));
 }
 
-static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static ssize_t adt7316_store_da_ab_vref_bypass(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf,
+					       size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -981,9 +979,9 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
 static iio_device_attr(da_ab_vref_bypass, 0644, adt7316_show_da_ab_vref_bypass,
 		       adt7316_store_da_ab_vref_bypass, 0);
 
-static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t adt7316_show_da_cd_vref_bypass(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -995,10 +993,10 @@ static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
 		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_CD));
 }
 
-static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static ssize_t adt7316_store_da_cd_vref_bypass(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf,
+					       size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1024,9 +1022,9 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
 static iio_device_attr(da_cd_vref_bypass, 0644, adt7316_show_da_cd_vref_bypass,
 		       adt7316_store_da_cd_vref_bypass, 0);
 
-static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t adt7316_show_dac_internal_vref(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1039,10 +1037,10 @@ static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
 		       !!(chip->dac_config & ADT7316_DAC_IN_VREF));
 }
 
-static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static ssize_t adt7316_store_dac_internal_vref(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf,
+					       size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1084,7 +1082,8 @@ static iio_device_attr(dac_internal_vref, 0644, adt7316_show_dac_internal_vref,
 		       adt7316_store_dac_internal_vref, 0);
 
 static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
-		int channel, char *buf)
+			       int channel,
+			       char *buf)
 {
 	u16 data;
 	u8 msb, lsb;
@@ -1092,7 +1091,7 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 	int ret;
 
 	if ((chip->config2 & ADT7316_AD_SINGLE_CH_MODE) &&
-		channel != (chip->config2 & ADT7516_AD_SINGLE_CH_MASK))
+	    channel != (chip->config2 & ADT7516_AD_SINGLE_CH_MASK))
 		return -EPERM;
 
 	switch (channel) {
@@ -1159,8 +1158,8 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 }
 
 static ssize_t adt7316_show_VDD(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				struct device_attribute *attr,
+				char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1171,8 +1170,8 @@ static ssize_t adt7316_show_VDD(struct device *dev,
 static iio_device_attr(VDD, 0444, adt7316_show_VDD, NULL, 0);
 
 static ssize_t adt7316_show_in_temp(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				    struct device_attribute *attr,
+				    char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1182,9 +1181,9 @@ static ssize_t adt7316_show_in_temp(struct device *dev,
 
 static iio_device_attr(in_temp, 0444, adt7316_show_in_temp, NULL, 0);
 
-static ssize_t adt7316_show_ex_temp_AIN1(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t adt7316_show_ex_temp_ain1(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1197,8 +1196,8 @@ static iio_device_attr(ex_temp_ain1, 0444, adt7316_show_ex_temp_ain1, NULL, 0);
 static iio_device_attr(ex_temp, 0444, adt7316_show_ex_temp_ain1, NULL, 0);
 
 static ssize_t adt7316_show_AIN2(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				 struct device_attribute *attr,
+				 char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1233,7 +1232,8 @@ static ssize_t adt7316_show_ain4(struct device *dev,
 static iio_device_attr(ain4, 0444, adt7316_show_ain4, NULL, 0);
 
 static ssize_t adt7316_show_temp_offset(struct adt7316_chip_info *chip,
-		int offset_addr, char *buf)
+					int offset_addr,
+					char *buf)
 {
 	int data;
 	u8 val;
@@ -1251,7 +1251,9 @@ static ssize_t adt7316_show_temp_offset(struct adt7316_chip_info *chip,
 }
 
 static ssize_t adt7316_store_temp_offset(struct adt7316_chip_info *chip,
-		int offset_addr, const char *buf, size_t len)
+					 int offset_addr,
+					 const char *buf,
+					 size_t len)
 {
 	int data;
 	u8 val;
@@ -1274,8 +1276,8 @@ static ssize_t adt7316_store_temp_offset(struct adt7316_chip_info *chip,
 }
 
 static ssize_t adt7316_show_in_temp_offset(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					   struct device_attribute *attr,
+					   char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1284,23 +1286,23 @@ static ssize_t adt7316_show_in_temp_offset(struct device *dev,
 }
 
 static ssize_t adt7316_store_in_temp_offset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_store_temp_offset(chip, ADT7316_IN_TEMP_OFFSET, buf,
-			len);
+					 len);
 }
 
 static iio_device_attr(in_temp_offset, 0644, adt7316_show_in_temp_offset,
 		       adt7316_store_in_temp_offset, 0);
 
 static ssize_t adt7316_show_ex_temp_offset(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					   struct device_attribute *attr,
+					   char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1309,63 +1311,62 @@ static ssize_t adt7316_show_ex_temp_offset(struct device *dev,
 }
 
 static ssize_t adt7316_store_ex_temp_offset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					    struct device_attribute *attr,
+					    const char *buf,
+					    size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_store_temp_offset(chip, ADT7316_EX_TEMP_OFFSET, buf,
-			len);
+					 len);
 }
 
-static IIO_DEVICE_ATTR(ex_temp_offset, S_IRUGO | S_IWUSR,
-		adt7316_show_ex_temp_offset,
-		adt7316_store_ex_temp_offset, 0);
+static iio_device_attr(ex_temp_offset, 0644, adt7316_show_ex_temp_offset,
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
+						   struct device_attribute *attr,
+						   const char *buf, size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return adt7316_store_temp_offset(chip,
-			ADT7316_IN_ANALOG_TEMP_OFFSET, buf, len);
+					 ADT7316_IN_ANALOG_TEMP_OFFSET,
+					 buf, len);
 }
 
-static IIO_DEVICE_ATTR(in_analog_temp_offset, S_IRUGO | S_IWUSR,
-		adt7316_show_in_analog_temp_offset,
-		adt7316_store_in_analog_temp_offset, 0);
+static iio_device_attr(in_analog_temp_offset, 0644,
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
+						   struct device_attribute *attr,
+						   const char *buf,
+						   size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1378,15 +1379,16 @@ static iio_device_attr(ex_analog_temp_offset, 0644,
 		adt7316_show_ex_analog_temp_offset,
 		adt7316_store_ex_analog_temp_offset, 0);
 
-static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
-		int channel, char *buf)
+static ssize_t adt7316_show_dac(struct adt7316_chip_info *chip,
+				int channel,
+				char *buf)
 {
 	u16 data;
 	u8 msb, lsb, offset;
 	int ret;
 
 	if (channel >= ADT7316_DA_MSB_DATA_REGS ||
-		(channel == 0 &&
+	    (channel == 0 &&
 		(chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA)) ||
 		(channel == 1 &&
 		(chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB)))
@@ -1411,15 +1413,17 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
 	return sprintf(buf, "%d\n", data);
 }
 
-static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
-		int channel, const char *buf, size_t len)
+static ssize_t adt7316_store_dac(struct adt7316_chip_info *chip,
+				 int channel,
+				 const char *buf,
+				 size_t len)
 {
 	u8 msb, lsb, offset;
 	u16 data;
 	int ret;
 
 	if (channel >= ADT7316_DA_MSB_DATA_REGS ||
-		(channel == 0 &&
+	    (channel == 0 &&
 		(chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA)) ||
 		(channel == 1 &&
 		(chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB)))
@@ -1448,9 +1452,9 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
 	return len;
 }
 
-static ssize_t adt7316_show_DAC_A(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t adt7316_show_dac_a(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1458,10 +1462,10 @@ static ssize_t adt7316_show_DAC_A(struct device *dev,
 	return adt7316_show_dac(chip, 0, buf);
 }
 
-static ssize_t adt7316_store_DAC_A(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static ssize_t adt7316_store_dac_a(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1471,9 +1475,9 @@ static ssize_t adt7316_store_DAC_A(struct device *dev,
 
 static iio_device_attr(dac_a, 0644, adt7316_show_dac_a, adt7316_store_dac_a, 0);
 
-static ssize_t adt7316_show_DAC_B(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t adt7316_show_dac_b(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1481,10 +1485,10 @@ static ssize_t adt7316_show_DAC_B(struct device *dev,
 	return adt7316_show_dac(chip, 1, buf);
 }
 
-static ssize_t adt7316_store_DAC_B(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static ssize_t adt7316_store_dac_b(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1494,9 +1498,9 @@ static ssize_t adt7316_store_DAC_B(struct device *dev,
 
 static iio_device_attr(dac_b, 0644, adt7316_show_dac_b, adt7316_store_dac_b, 0);
 
-static ssize_t adt7316_show_DAC_C(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t adt7316_show_dac_c(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1504,10 +1508,10 @@ static ssize_t adt7316_show_DAC_C(struct device *dev,
 	return adt7316_show_dac(chip, 2, buf);
 }
 
-static ssize_t adt7316_store_DAC_C(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static ssize_t adt7316_store_dac_c(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1517,9 +1521,9 @@ static ssize_t adt7316_store_DAC_C(struct device *dev,
 
 static iio_device_attr(DAC_C, 0644, adt7316_show_dac_c, adt7316_store_dac_c, 0);
 
-static ssize_t adt7316_show_DAC_D(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+static ssize_t adt7316_show_dac_d(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1527,10 +1531,10 @@ static ssize_t adt7316_show_DAC_D(struct device *dev,
 	return adt7316_show_dac(chip, 3, buf);
 }
 
-static ssize_t adt7316_store_DAC_D(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+static ssize_t adt7316_store_dac_d(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf,
+				   size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1541,8 +1545,8 @@ static ssize_t adt7316_store_DAC_D(struct device *dev,
 static iio_device_attr(DAC_D, 0644, adt7316_show_dac_d, adt7316_store_dac_d, 0);
 
 static ssize_t adt7316_show_device_id(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				      struct device_attribute *attr,
+				      char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1556,11 +1560,11 @@ static ssize_t adt7316_show_device_id(struct device *dev,
 	return sprintf(buf, "%d\n", id);
 }
 
-static IIO_DEVICE_ATTR(device_id, S_IRUGO, adt7316_show_device_id, NULL, 0);
+static iio_device_attr(device_id, 0444, adt7316_show_device_id, NULL, 0);
 
 static ssize_t adt7316_show_manufactorer_id(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					    struct device_attribute *attr,
+					    char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1578,8 +1582,8 @@ static iio_device_attr(manufactorer_id, 0444, adt7316_show_manufactorer_id,
 		       NULL, 0);
 
 static ssize_t adt7316_show_device_rev(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				       struct device_attribute *attr,
+				       char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1596,8 +1600,8 @@ static ssize_t adt7316_show_device_rev(struct device *dev,
 static iio_device_attr(device_rev, 0444, adt7316_show_device_rev, NULL, 0);
 
 static ssize_t adt7316_show_bus_type(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				     struct device_attribute *attr,
+				     char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1780,8 +1784,8 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
  * Show mask of enabled interrupts in Hex.
  */
 static ssize_t adt7316_show_int_mask(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+				     struct device_attribute *attr,
+				     char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1793,9 +1797,9 @@ static ssize_t adt7316_show_int_mask(struct device *dev,
  * Set 1 to the mask in Hex to enabled interrupts.
  */
 static ssize_t adt7316_set_int_mask(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				    struct device_attribute *attr,
+				    const char *buf,
+				    size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1832,9 +1836,10 @@ static ssize_t adt7316_set_int_mask(struct device *dev,
 
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
@@ -1844,7 +1849,7 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
 	int ret;
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT73XX &&
-		this_attr->address > ADT7316_EX_TEMP_LOW)
+	    this_attr->address > ADT7316_EX_TEMP_LOW)
 		return -EPERM;
 
 	ret = chip->bus.read(chip->bus.client, this_attr->address, &val);
@@ -1854,7 +1859,7 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
 	data = (int)val;
 
 	if (!((chip->id & ID_FAMILY_MASK) == ID_ADT75XX &&
-		(chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)) {
+	      (chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)) {
 		if (data & 0x80)
 			data -= 256;
 	}
@@ -1863,9 +1868,9 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
 }
 
 static inline ssize_t adt7316_set_ad_bound(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+					   struct device_attribute *attr,
+					   const char *buf,
+					   size_t len)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
@@ -1875,7 +1880,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
 	int ret;
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT73XX &&
-		this_attr->address > ADT7316_EX_TEMP_LOW)
+	    this_attr->address > ADT7316_EX_TEMP_LOW)
 		return -EPERM;
 
 	ret = kstrtoint(buf, 10, &data);
@@ -1883,7 +1888,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
 		return -EINVAL;
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX &&
-		(chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0) {
+	    (chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0) {
 		if (data > 255 || data < 0)
 			return -EINVAL;
 	} else {
@@ -1904,8 +1909,8 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
 }
 
 static ssize_t adt7316_show_int_enabled(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
+					struct device_attribute *attr,
+					char *buf)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -1914,9 +1919,9 @@ static ssize_t adt7316_show_int_enabled(struct device *dev,
 }
 
 static ssize_t adt7316_set_int_enabled(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
+				       struct device_attribute *attr,
+				       const char *buf,
+				       size_t len)
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
@@ -2040,7 +2045,7 @@ static const struct iio_info adt7516_info = {
  * device probe and remove
  */
 int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
-		const char *name)
+		  const char *name)
 {
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
@@ -2112,7 +2117,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 		return ret;
 
 	dev_info(dev, "%s temperature sensor, ADC and DAC registered.\n",
-			indio_dev->name);
+		 indio_dev->name);
 
 	return 0;
 }
-- 
2.7.4
