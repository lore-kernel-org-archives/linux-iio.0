Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:32964 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932644AbcLYTmT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Dec 2016 14:42:19 -0500
Received: by mail-oi0-f68.google.com with SMTP id f201so43085759oib.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Dec 2016 11:42:19 -0800 (PST)
From: Scott Matheina <scott@matheina.com>
To: linux-kernel@vger.kernel.org
Cc: Scott Matheina <scott@matheina.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCHv4 3/8] Fix camel case issues
Date: Sun, 25 Dec 2016 13:41:07 -0600
Message-Id: <1482694902-7400-4-git-send-email-scott@matheina.com>
In-Reply-To: <1482694902-7400-1-git-send-email-scott@matheina.com>
References: <1482694902-7400-1-git-send-email-scott@matheina.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Cases of camel case were fixed by making variables lower case throughout
the file.

Signed-off-by: Scott Matheina <scott@matheina.com>
---
 drivers/staging/iio/addac/adt7316.c | 82 ++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 13d9ed2..2b584a0 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1485,7 +1485,7 @@ static ssize_t adt7316_show_DAC_A(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return adt7316_show_DAC(chip, 0, buf);
+	return adt7316_show_dac(chip, 0, buf);
 }
 
 static ssize_t adt7316_store_DAC_A(struct device *dev,
@@ -1496,7 +1496,7 @@ static ssize_t adt7316_store_DAC_A(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return adt7316_store_DAC(chip, 0, buf, len);
+	return adt7316_store_dac(chip, 0, buf, len);
 }
 
 static IIO_DEVICE_ATTR(DAC_A, S_IRUGO | S_IWUSR, adt7316_show_DAC_A,
@@ -1509,7 +1509,7 @@ static ssize_t adt7316_show_DAC_B(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return adt7316_show_DAC(chip, 1, buf);
+	return adt7316_show_dac(chip, 1, buf);
 }
 
 static ssize_t adt7316_store_DAC_B(struct device *dev,
@@ -1520,7 +1520,7 @@ static ssize_t adt7316_store_DAC_B(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return adt7316_store_DAC(chip, 1, buf, len);
+	return adt7316_store_dac(chip, 1, buf, len);
 }
 
 static IIO_DEVICE_ATTR(DAC_B, S_IRUGO | S_IWUSR, adt7316_show_DAC_B,
@@ -1533,7 +1533,7 @@ static ssize_t adt7316_show_DAC_C(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return adt7316_show_DAC(chip, 2, buf);
+	return adt7316_show_dac(chip, 2, buf);
 }
 
 static ssize_t adt7316_store_DAC_C(struct device *dev,
@@ -1544,7 +1544,7 @@ static ssize_t adt7316_store_DAC_C(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return adt7316_store_DAC(chip, 2, buf, len);
+	return adt7316_store_dac(chip, 2, buf, len);
 }
 
 static IIO_DEVICE_ATTR(DAC_C, S_IRUGO | S_IWUSR, adt7316_show_DAC_C,
@@ -1557,7 +1557,7 @@ static ssize_t adt7316_show_DAC_D(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return adt7316_show_DAC(chip, 3, buf);
+	return adt7316_show_dac(chip, 3, buf);
 }
 
 static ssize_t adt7316_store_DAC_D(struct device *dev,
@@ -1568,7 +1568,7 @@ static ssize_t adt7316_store_DAC_D(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return adt7316_store_DAC(chip, 3, buf, len);
+	return adt7316_store_dac(chip, 3, buf, len);
 }
 
 static IIO_DEVICE_ATTR(DAC_D, S_IRUGO | S_IWUSR, adt7316_show_DAC_D,
@@ -1661,26 +1661,26 @@ static struct attribute *adt7316_attributes[] = {
 	&iio_dev_attr_powerdown.dev_attr.attr,
 	&iio_dev_attr_fast_ad_clock.dev_attr.attr,
 	&iio_dev_attr_da_high_resolution.dev_attr.attr,
-	&iio_dev_attr_enable_proportion_DACA.dev_attr.attr,
-	&iio_dev_attr_enable_proportion_DACB.dev_attr.attr,
-	&iio_dev_attr_DAC_2Vref_channels_mask.dev_attr.attr,
-	&iio_dev_attr_DAC_update_mode.dev_attr.attr,
-	&iio_dev_attr_all_DAC_update_modes.dev_attr.attr,
-	&iio_dev_attr_update_DAC.dev_attr.attr,
-	&iio_dev_attr_DA_AB_Vref_bypass.dev_attr.attr,
-	&iio_dev_attr_DA_CD_Vref_bypass.dev_attr.attr,
-	&iio_dev_attr_DAC_internal_Vref.dev_attr.attr,
-	&iio_dev_attr_VDD.dev_attr.attr,
+	&iio_dev_attr_enable_proportion_daca.dev_attr.attr,
+	&iio_dev_attr_enable_proportion_dacb.dev_attr.attr,
+	&iio_dev_attr_dac_2vref_channels_mask.dev_attr.attr,
+	&iio_dev_attr_dac_internal_vref.dev_attr.attr,
+	&iio_dev_attr_all_dac_update_modes.dev_attr.attr,
+	&iio_dev_attr_update_dac.dev_attr.attr,
+	&iio_dev_attr_da_ab_vref_bypass.dev_attr.attr,
+	&iio_dev_attr_da_cd_vref_bypass.dev_attr.attr,
+	&iio_dev_attr_dac_internal_vref.dev_attr.attr,
+	&iio_dev_attr_vdd.dev_attr.attr,
 	&iio_dev_attr_in_temp.dev_attr.attr,
 	&iio_dev_attr_ex_temp.dev_attr.attr,
 	&iio_dev_attr_in_temp_offset.dev_attr.attr,
 	&iio_dev_attr_ex_temp_offset.dev_attr.attr,
 	&iio_dev_attr_in_analog_temp_offset.dev_attr.attr,
 	&iio_dev_attr_ex_analog_temp_offset.dev_attr.attr,
-	&iio_dev_attr_DAC_A.dev_attr.attr,
-	&iio_dev_attr_DAC_B.dev_attr.attr,
-	&iio_dev_attr_DAC_C.dev_attr.attr,
-	&iio_dev_attr_DAC_D.dev_attr.attr,
+	&iio_dev_attr_dac_a.dev_attr.attr,
+	&iio_dev_attr_dac_b.dev_attr.attr,
+	&iio_dev_attr_dac_c.dev_attr.attr,
+	&iio_dev_attr_dac_d.dev_attr.attr,
 	&iio_dev_attr_device_id.dev_attr.attr,
 	&iio_dev_attr_manufactorer_id.dev_attr.attr,
 	&iio_dev_attr_device_rev.dev_attr.attr,
@@ -1703,31 +1703,31 @@ static struct attribute *adt7516_attributes[] = {
 	&iio_dev_attr_enable_smbus_timeout.dev_attr.attr,
 	&iio_dev_attr_powerdown.dev_attr.attr,
 	&iio_dev_attr_fast_ad_clock.dev_attr.attr,
-	&iio_dev_attr_AIN_internal_Vref.dev_attr.attr,
+	&iio_dev_attr_ain_internal_vref.dev_attr.attr,
 	&iio_dev_attr_da_high_resolution.dev_attr.attr,
-	&iio_dev_attr_enable_proportion_DACA.dev_attr.attr,
-	&iio_dev_attr_enable_proportion_DACB.dev_attr.attr,
-	&iio_dev_attr_DAC_2Vref_channels_mask.dev_attr.attr,
-	&iio_dev_attr_DAC_update_mode.dev_attr.attr,
-	&iio_dev_attr_all_DAC_update_modes.dev_attr.attr,
-	&iio_dev_attr_update_DAC.dev_attr.attr,
-	&iio_dev_attr_DA_AB_Vref_bypass.dev_attr.attr,
-	&iio_dev_attr_DA_CD_Vref_bypass.dev_attr.attr,
-	&iio_dev_attr_DAC_internal_Vref.dev_attr.attr,
-	&iio_dev_attr_VDD.dev_attr.attr,
+	&iio_dev_attr_enable_proportion_daca.dev_attr.attr,
+	&iio_dev_attr_enable_proportion_dacb.dev_attr.attr,
+	&iio_dev_attr_dac_2vref_channels_mask.dev_attr.attr,
+	&iio_dev_attr_dac_update_mode.dev_attr.attr,
+	&iio_dev_attr_all_dac_update_modes.dev_attr.attr,
+	&iio_dev_attr_update_dac.dev_attr.attr,
+	&iio_dev_attr_da_ab_vref_bypass.dev_attr.attr,
+	&iio_dev_attr_da_cd_vref_bypass.dev_attr.attr,
+	&iio_dev_attr_dac_internal_vref.dev_attr.attr,
+	&iio_dev_attr_vdd.dev_attr.attr,
 	&iio_dev_attr_in_temp.dev_attr.attr,
-	&iio_dev_attr_ex_temp_AIN1.dev_attr.attr,
-	&iio_dev_attr_AIN2.dev_attr.attr,
-	&iio_dev_attr_AIN3.dev_attr.attr,
-	&iio_dev_attr_AIN4.dev_attr.attr,
+	&iio_dev_attr_ex_temp_ain1.dev_attr.attr,
+	&iio_dev_attr_ain2.dev_attr.attr,
+	&iio_dev_attr_ain3.dev_attr.attr,
+	&iio_dev_attr_ain4.dev_attr.attr,
 	&iio_dev_attr_in_temp_offset.dev_attr.attr,
 	&iio_dev_attr_ex_temp_offset.dev_attr.attr,
 	&iio_dev_attr_in_analog_temp_offset.dev_attr.attr,
 	&iio_dev_attr_ex_analog_temp_offset.dev_attr.attr,
-	&iio_dev_attr_DAC_A.dev_attr.attr,
-	&iio_dev_attr_DAC_B.dev_attr.attr,
-	&iio_dev_attr_DAC_C.dev_attr.attr,
-	&iio_dev_attr_DAC_D.dev_attr.attr,
+	&iio_dev_attr_dac_a.dev_attr.attr,
+	&iio_dev_attr_dac_b.dev_attr.attr,
+	&iio_dev_attr_dac_c.dev_attr.attr,
+	&iio_dev_attr_dac_d.dev_attr.attr,
 	&iio_dev_attr_device_id.dev_attr.attr,
 	&iio_dev_attr_manufactorer_id.dev_attr.attr,
 	&iio_dev_attr_device_rev.dev_attr.attr,
-- 
2.7.4

