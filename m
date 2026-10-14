Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A774BE425
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791969088; cv=none; b=RnxF8EnIiBfnVwAhxB2yonF/kKH+UE/EkxGS//o8fz5rAZrzBA7fp6zfnjBtqCuTlMKE2HGMX7l+ll82f0sebY5HnTu0MA4EkC263s4bnYFT5co9nJYfLAyKuor6FcGtWyK7Di828n/lc59VvOqtMVA+TcOntPXOWWlZjxmcplY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791969088; c=relaxed/simple;
	bh=nAu7LIZANKaIdRP2tQMSLxV1Uz3IqfRUrBNPtyD2LKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CkTGUNOYWykov9HPCHu4Fvus4RTp1iBV1t6y1K9I3o6A/oGlV8zSxl/ysAI9+KU2Rb9hjeIQ+0n61zleBUF0KaW7/d5icb6cx1ZHQFaLYXVIjj+YQGZZPMVj8g1ZTlhPXGeolAuyKr5zP/RqN7t4ecXcTE7suoFWwYufEL8tI/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vl1LuPOk; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl1LuPOk"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c45111bebso2309121f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791969080; x=1792573880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vONfw/TZke4lqika6uARsXYGMHvc3TAPnV1C0jVfP8U=;
        b=Vl1LuPOkmEbtCbMN9IrHQr0OB4tPADhvq3vyu9LEQyKhSxzMy2/P4PXllfbIrVJ/Wg
         1Jve5zsYMdQ2ScJmD87GxY6F+yq8O86j5ZuIkIwoTzIxqqnwbsVeyNGg18YijMZzD59s
         RcunAjdvFFheHw5QfjySzkqEu0c7PJNdwhxLRnZPY1vgBnjewSbVVR9rdA5PWIkWg18Z
         R2zubpUm9eaWRpdAPYE8sD9C1vjMbcguqtk6FVPFKn3Tez16ReLRghIzt7mHc4jKOQzD
         BHhf/WcP8hVwL8OZpy0VuSLeTMWccSJADYuT1QfkAmp0KaNGT/i6E4IYYbMEe3MB254H
         y7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791969080; x=1792573880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vONfw/TZke4lqika6uARsXYGMHvc3TAPnV1C0jVfP8U=;
        b=ekrwAAhJflCtEpUYeS2mJMHQf9BaYXCR0ICpthuCHKxkROZBtiB5jEf/4OeOQtArYH
         0wrLbXknw3e6xruIOJPZijxAPlK3hCjy4qjwOS3fCtaf4PNmKCtAHkSyZwul602bF9aJ
         YrKJcUdGJbuDldNffvEwuuUL2qVul8UhKe5FsngzNoi206daY9iV0GAFQK7wTg3SNF85
         16AXmMUMiPht2ezn9iUhqiz1oEuS0qIX/cbQ5QrmYNodm8ykP2uv4GCQQ+1lUgtvUXCQ
         ZJJnEgKU5JTLMoInGmaeWI9alTq0jgnYB5pH1X8jd8+ERlWCjbSyQHvevd7pbFJLdDWX
         y/2w==
X-Forwarded-Encrypted: i=1; AKwUvBy4MEn/AUzQ4k4/Ag4NkGnIG8Jc65YMHC1xVH9FdoWrgRl39ezHxJA8ZM5K6dfcTC+kFcrgfUijip4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJx8oDChNmHg8qhAECH8TQgKHrgJ+KFoajaVN/kZ5mplxRxTHH+
	eqCaSfYh7OtNkM7vqXafm0PrYg6kMjvNxvQImCbHjxNSAKME9m3ggAL8
X-Gm-Gg: AYBFou0uK6DuC/FxPobPzRpw6W3dyANkhRCNP9/DDFuDtiwjEV0EUJQwoRgtCHSZWWB
	7aD0xySxWH0B7r1heXZpjgtDIGbAXCAaj8zPyOEnuh9utoX6ZkMvxvoHQK+1/Hjs1p13Hd39NpX
	i0ezAaFkcdlr+dlsCIw7qcqpQ1z9smLLOoWhidbdyBGvvukIE4io3oj1lttgFTHxvSyzW29oTTq
	vBQvdmVlz1BVId1fS1wsWxHqtq7EucQXh9MsZxszOU1xdqUVJW0ejH+Z1Z2pHb5V3i8/vUXgDn9
	06T3xs+R2edoyfzDobcdYTrbP0Vz6I6woQjXywTPKGJG4bQkMyNC2IG5sw0wZGvKOYTcEBwHKy4
	+6ZFd23ZRjxaM3ZLbg/CGTtfxPhJjdzC8IwESA69NnoeQikQq2f1tEtnnfxd1Wwg/JwVrSEWpqd
	d0vNp/RSLLIXtsdyuXfbN9UHnnXDbQmCX4HOzGaSZJt9Ca72pic4GMBUeZB5jjoDjf6Bpkif8TA
	rSb/OB87GF617FtOcw=
X-Received: by 2002:a05:600c:4ecc:b0:49c:fa21:e749 with SMTP id 5b1f17b1804b1-4a18e4d55f2mr339497015e9.31.1791969080038;
        Wed, 14 Oct 2026 02:11:20 -0700 (PDT)
Received: from fedora ([154.183.128.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18beacd2csm468876155e9.14.2026.10.14.02.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:11:19 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	u.kleine-koenig@baylibre.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v3] staging: iio: adt7316: use kstrtobool() for sysfs boolean parsing
Date: Wed, 14 Oct 2026 12:11:11 +0300
Message-ID: <20261014091111.20059-1-abdelnasserhussein11@gmail.com>
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

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
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

