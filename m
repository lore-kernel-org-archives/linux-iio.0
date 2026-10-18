Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDC14AA416
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792333939; cv=none; b=Hchne7/WzERiL3r4gpmJZFI33+c3NqSAmtB8wuZWtcGO/GGSihX/07Y0XaKs6Ds8I7D4wiJIx7RIcDrC/M/ixoXcTFcHArXDA6WiiaDn6HWWtO/elyQf8B/3ntv8MgvZfeJOf5NaGauhu8xkNwa5y5XbKriVW7H04SCjgoxSMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792333939; c=relaxed/simple;
	bh=hO1lb9C3PGd2eLddLtW3HNb9sxEOVVq71jcipiN125w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nFHXJdGEg/UUPcq7anq8R32YRKfJl2LSYvZfsWVjUgsYJhzxzCvnALXrXUwTyvls6Y7G5v5SpikYu8P/0ZjGiryR96EbMV77GxVllqhY5HzlYB869zVKMyGGYXxgYxCTfb/aPdppvL7uJuLJ8ylB6zU5i1E5T7Jw8f5zDCZY/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFqW2MBe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFqW2MBe"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso10330305e9.3
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 07:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792333936; x=1792938736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkN2oKFPPbg5tFRXQX1y714/CfymyQfd47i4DNaqs98=;
        b=bFqW2MBeHK4bpq1BXa0fnCWeQBhl34e84cJWrzrZnAzrl/cZZNbNGLlWf0yKe3fV7p
         MS6fgYJrVhsODcD7qRAnrMkdNmWja/nF9Rwu3QveNihkEkzabPmPSb8UyDhtmRQcuP11
         HAFL5YTcKDGWr3qCiyqb6grEk8U4yiykCrbKIIKWq0RO2rgcLrm/uEW8F8BnRT3XVnWC
         ZXrKAoaOJCOsW906FgfN+zFKkt1zAxhsteYPom0pMBnlRO3gvj2CvTcY9yksSieKCt4+
         dUhWJ5EU/YqQshiBshDs/dzSKDywaCged0bS5O1VwLNcMI4LxMoSXUPw+HIgWFJs50Vy
         RIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792333936; x=1792938736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkN2oKFPPbg5tFRXQX1y714/CfymyQfd47i4DNaqs98=;
        b=sAlFJ0+FgplUjf1AksywkHS+XrvZr+pdNt3qxakaWBPvwliQCw0QMh5sdsRpnono4U
         1yzHgNefL6zFv78ZDvf13J8/cQtbPCCsV2nU1prmNmNutlOwkZhMivdiI65B1m8PH5nf
         0Sy8bRvOo999OXIMophbi1UfyJWKdjKRNPnQzUB1fiRee3P9J4fNVDCGd1BgQouoTVvX
         bosY3jnWCWpDyD3Q7TjI+67qE3kUsIASnqUxHD+fZVppmScYrsTesXJRAwNf949ikt+s
         HYUAwUUy7GBKe8X0dPEdJFU9NyGl16pQl3Oa8BDVp8iXTMrdwYtzb+TLpYbJH9QrZ6DQ
         J5rw==
X-Forwarded-Encrypted: i=1; AKwUvBzLMAdO5adVYZJnVMD9DCMwz+8nEQMVVS9Qii+xeSk8KDzUTrTPnDDpmZFA0nKagwHI4dHrVhThkPA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIB0VLdOO8hkMuDAKQzTExGKVIeZMNxDLt6SW57bdggoChTqrC+
	XmOzcDjUzWJPDj4rgGe7W1ZVQ+hWzhteKZJE1g9sgxuZTb1KT4J4j7V0
X-Gm-Gg: AYBFou11IxeUbU6s68PxnhDDMaCpFG76tMa0bC6mbyPixEp/wbraxAUsZ2hHkQenVAG
	5cX07fEkNJIO9+DJ2d6bELIy302jLlEhJT2XK/sGOW7Wh1cYzb2vE+sgOHbSUAVRbilV3LNzwYO
	X5xIZgY8FF7HGWewAxjVD/8yT5Z5woNLvgpqQAAEx/RrWTUCmGbo+sJ2QSOCiHURKvi8j5LQLNA
	HIoD2aobOg+DqezzsbkZDLL3+K9peEni3aEql5WiUcoPTxrr0T2BneeYhoJmmX3whweDCXYdo9C
	plWgTBafANVfMrWdmovw6GmwBlbu+3RgSv4EQ35sRC2YkO/QRmfFufkrxJDfSmHu/DV2QC7hQAc
	gbY1C1M/YsU/ClZVAsxUO+P2GJjsd2gSZGlfFBO0qPbJWceJefAO9no6y7JhL4nYCExvzx2hHOS
	7co0qWL+vNClpieNHwnllxe98HW/sYnbFu6PdxTCzWgNxsYLKYuxjs52jZHKWVl6uLP+lje69Ok
	mSGtkSMHACG83EpaVE=
X-Received: by 2002:a05:6000:468d:b0:48d:fd4d:7fbf with SMTP id ffacd0b85a97d-48e07988954mr7012542f8f.4.1792333936135;
        Sun, 18 Oct 2026 07:32:16 -0700 (PDT)
Received: from fedora ([154.182.76.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4fe9d9sm16240317f8f.40.2026.10.18.07.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 07:32:15 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v4] staging: iio: adt7316: use kstrtobool() for sysfs boolean parsing
Date: Sun, 18 Oct 2026 17:31:08 +0300
Message-ID: <20261018143108.14750-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual character checks (e.g., buf[0] == '1') with the standard
kstrtobool() API in sysfs store functions.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
Changes in v4:
- Removed Joshua's Reviewed-by tag.

Changes in v3:
- Change _adt7316_store_enabled() parameter type from int to bool to match callers (Andy Shevchenko).
- Update adt7316_disable() and adt7316_enable() to pass false/true instead of 0/1 (Andy Shevchenko).

Changes in v2:
- Include <linux/kstrtox.h>.
- Rename the boolean variable from 'req' to 'val' for clarity.
- Add Reviewed-by tag from Joshua Crofts.

 drivers/staging/iio/addac/adt7316.c | 101 ++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 20f6052cc7fb..ec1c33ad5ace 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/rtc.h>
 #include <linux/module.h>
+#include <linux/kstrtox.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/events.h>
@@ -220,7 +221,7 @@ static ssize_t adt7316_show_enabled(struct device *dev,
 }
 
 static ssize_t _adt7316_store_enabled(struct adt7316_chip_info *chip,
-				      int enable)
+				      bool enable)
 {
 	u8 config1;
 	int ret;
@@ -246,12 +247,12 @@ static ssize_t adt7316_store_enabled(struct device *dev,
 {
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
-	int enable;
+	bool enable;
+	int ret;
 
-	if (buf[0] == '1')
-		enable = 1;
-	else
-		enable = 0;
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
 
 	if (_adt7316_store_enabled(chip, enable) < 0)
 		return -EIO;
@@ -285,13 +286,18 @@ static ssize_t adt7316_store_select_ex_temp(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config1;
+	bool val;
 	int ret;
 
 	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
 		return -EPERM;
 
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
 	config1 = chip->config1 & (~ADT7516_SEL_EX_TEMP);
-	if (buf[0] == '1')
+	if (val)
 		config1 |= ADT7516_SEL_EX_TEMP;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
@@ -482,10 +488,15 @@ static ssize_t adt7316_store_disable_averaging(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config2;
+	bool val;
 	int ret;
 
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
 	config2 = chip->config2 & (~ADT7316_DISABLE_AVERAGING);
-	if (buf[0] == '1')
+	if (val)
 		config2 |= ADT7316_DISABLE_AVERAGING;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
@@ -521,10 +532,15 @@ static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config2;
+	bool val;
 	int ret;
 
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
 	config2 = chip->config2 & (~ADT7316_EN_SMBUS_TIMEOUT);
-	if (buf[0] == '1')
+	if (val)
 		config2 |= ADT7316_EN_SMBUS_TIMEOUT;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
@@ -559,10 +575,15 @@ static ssize_t adt7316_store_powerdown(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config1;
+	bool val;
 	int ret;
 
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
 	config1 = chip->config1 & (~ADT7316_PD);
-	if (buf[0] == '1')
+	if (val)
 		config1 |= ADT7316_PD;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
@@ -597,10 +618,15 @@ static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
+	bool val;
 	int ret;
 
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
 	config3 = chip->config3 & (~ADT7316_ADCLK_22_5);
-	if (buf[0] == '1')
+	if (val)
 		config3 |= ADT7316_ADCLK_22_5;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
@@ -640,13 +666,18 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
+	bool val;
 	int ret;
 
 	if (chip->id == ID_ADT7318 || chip->id == ID_ADT7519)
 		return -EPERM;
 
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
 	config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
-	if (buf[0] == '1')
+	if (val)
 		config3 |= ADT7316_DA_HIGH_RESOLUTION;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
@@ -685,12 +716,17 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
+	bool val;
 	int ret;
 
 	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
 		return -EPERM;
 
-	if (buf[0] != '1')
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	if (!val)
 		config3 = chip->config3 & (~ADT7516_AIN_IN_VREF);
 	else
 		config3 = chip->config3 | ADT7516_AIN_IN_VREF;
@@ -728,10 +764,15 @@ static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
+	bool val;
 	int ret;
 
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
 	config3 = chip->config3 & (~ADT7316_EN_IN_TEMP_PROP_DACA);
-	if (buf[0] == '1')
+	if (val)
 		config3 |= ADT7316_EN_IN_TEMP_PROP_DACA;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
@@ -767,10 +808,15 @@ static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
+	bool val;
 	int ret;
 
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
 	config3 = chip->config3 & (~ADT7316_EN_EX_TEMP_PROP_DACB);
-	if (buf[0] == '1')
+	if (val)
 		config3 |= ADT7316_EN_EX_TEMP_PROP_DACB;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
@@ -967,10 +1013,15 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 dac_config;
+	bool val;
 	int ret;
 
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
 	dac_config = chip->dac_config & (~ADT7316_VREF_BYPASS_DAC_AB);
-	if (buf[0] == '1')
+	if (val)
 		dac_config |= ADT7316_VREF_BYPASS_DAC_AB;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
@@ -1006,10 +1057,15 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 dac_config;
+	bool val;
 	int ret;
 
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
 	dac_config = chip->dac_config & (~ADT7316_VREF_BYPASS_DAC_CD);
-	if (buf[0] == '1')
+	if (val)
 		dac_config |= ADT7316_VREF_BYPASS_DAC_CD;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
@@ -1969,10 +2025,15 @@ static ssize_t adt7316_set_int_enabled(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config1;
+	bool val;
 	int ret;
 
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
 	config1 = chip->config1 & (~ADT7316_INT_EN);
-	if (buf[0] == '1')
+	if (val)
 		config1 |= ADT7316_INT_EN;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
@@ -2084,7 +2145,7 @@ static int adt7316_disable(struct device *dev)
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return _adt7316_store_enabled(chip, 0);
+	return _adt7316_store_enabled(chip, false);
 }
 
 static int adt7316_enable(struct device *dev)
@@ -2092,7 +2153,7 @@ static int adt7316_enable(struct device *dev)
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return _adt7316_store_enabled(chip, 1);
+	return _adt7316_store_enabled(chip, true);
 }
 
 EXPORT_GPL_SIMPLE_DEV_PM_OPS(adt7316_pm_ops, adt7316_disable, adt7316_enable);
-- 
2.54.0

