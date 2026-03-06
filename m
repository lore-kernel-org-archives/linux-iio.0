Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F3E374E59
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772781472; cv=none; b=gn4eayZN2c411yfALz/A7asaCIzTsyOFujCLGOoxEHJDeiXca2Hv2XYRo6tg3OagAZ/WZUn8wvIo4yvPaxisZr+kERYQd93/ZL7uWIYe1HmCDfM/1FfsYkB7nE0Jpa/wInPlY7xvM0QrfI27KCOowdgufGk0BIiuk9+n/knpBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772781472; c=relaxed/simple;
	bh=FnnVUipcnXp2uwXZ+svU7qIgeUZRJVxaE3eFoy49gvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lA6dm7fMhB+rhUsg/N7I2cGwbwuJP1NDL3l/ApiW1A3bshW3zZRbBbby9CYKsvcclgvUhp4zurRIAkcAOj7lLnwDhY0+1eybfBfWTQpvK6VDFBrYZN6sT67Ek7Zwdtnfb55aE7s4xjTWkwPcBZcEhi9WOH84ylRksd9TBZWN6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS2j+4su; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS2j+4su"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2be1c918173so8069840eec.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 23:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772781469; x=1773386269; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZgrgHECWYzN34F/29U4qOQ3ECWsuSmnQ/TM4j8ot7k=;
        b=IS2j+4suZ+lJSfCwmA0Pxk31ltBBL/S7GHgLt+hlY6ubw8weo8rrQJv6NXE/yWD1tI
         dAa5LZGtjoynF7G7rUkiGDNe2IiDDuM08FRDMG1U/dCWQzaVmhKJVo8wooNBQ2TMHkzP
         bRkGfE4OlMf9Jy5A19ea+erXc5rJMEM0AZAYE0HlesQtcHriAimmdWfltJhdPPXvDWig
         qnuP7DLyyOP6T9qfGDzRFcVxS8V/mQeUhxgEz9tc2krvBlg2fDJeOr1YB+rRjso+XOds
         MiD+BwqVQTdU+1jqLHgiODCHBG6hLbVAtdcaXBH1j0rQsrFPem3ZDvcvY0Qx+/fUS5iD
         nY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772781469; x=1773386269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/ZgrgHECWYzN34F/29U4qOQ3ECWsuSmnQ/TM4j8ot7k=;
        b=eMMgRA9zx0GThiRXxAxTeoVHUn7ouE6Bu729S5RtWir9pbrWGFPY/IRrsy4tup3xO+
         sN7t/ZXUxoKpapF2rCfVlMJ2+itx2ojEUtajnBoyF9wt54p3NmBqnb8cJkVUJCIb6cIg
         BZw7OogSI0o3e4zOncigU3VRqjvbYRUsrkViu4K+blCUHvggDo6jeAl4igcF30J8Ho5h
         ajY4ckKRiTaM7MY0SZNeIlAvxSLeGglLP3K6F3teLOA2INIJIrHmEE+rgvoaXOVQLcvm
         Cq8h9q0J8cN3BI2KdAMTEIpCXe6zhp4akRObJCMeMValViFsC7mImJdbS0/rtWVgo9IJ
         wsyw==
X-Forwarded-Encrypted: i=1; AJvYcCXcP7QldnOmSCSdmkdH8TmxWfzfo+d9QaS1+has00/fAjwrgdS7AwAsHX8V1hIAiHKylSP48zxWLfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGKFliFPsDKwwHpUyQtVvux7v9+298v+WY79n4FokyGI8kjCmd
	0fNsj091LeNp7YDc9UogOKOUX4ZC/kTEdFsG1mlgmG3MC8QDoRykwGhrHKHorBf/
X-Gm-Gg: ATEYQzyIhcZbmP2BCHlot0//J6DYXxd3HOT4IwKZCho/9O74ZodLZJB4hOdc/34KfR0
	yxDbQ+jp4V8lSuqNGWz1adejdQDpqcRQdlmfJ+IzDQ8yKVW+yviCXfeWGAxeBkfKJqDawHyRw2G
	Uik0zwzImECmfS1R4B42pMKV+/hkndzKmUHR3MvjfsjyuESI+M3I+gSejWZRHlcclkundarsKUA
	Qm+/H7TLwiCy6omn/POjGDiQSWGfLMS/cTaYZ3fRRP3opLUXEzwHQSljfwwPKK/P0VXKPOeCdKM
	qfjZVPJhz2aliEm68264GVPxKc+DdI1Ovu/7kAuFICQ4PqAPXLuAXwOK7VTFjzmVtNncWrC+QXb
	AewR9JQG/cK7aMbqVTGLjYITANE7WT1WyYbODG1Fitfx3/5yxzCnYpRABsIO3UBo/Uuzg8eyTHJ
	94GAthud8RX9w0HWowIE1DhI3e1f2WeufC1ET04Q==
X-Received: by 2002:a05:7301:1f12:b0:2b7:f809:9c3f with SMTP id 5a478bee46e88-2be4e03d117mr546570eec.24.1772781468675;
        Thu, 05 Mar 2026 23:17:48 -0800 (PST)
Received: from [192.168.1.187] ([76.50.196.152])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f96f25bsm545713eec.28.2026.03.05.23.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 23:17:48 -0800 (PST)
From: Michael Harris <michaelharriscode@gmail.com>
Date: Thu, 05 Mar 2026 23:17:00 -0800
Subject: [PATCH v2 3/4] staging: iio: adt7316: add config names to
 registers and reorder
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-adt7316-correct-macros-v2-3-3702e3841c42@gmail.com>
References: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
In-Reply-To: <20260305-adt7316-correct-macros-v2-0-3702e3841c42@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Michael Harris <michaelharriscode@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772781459; l=30783;
 i=michaelharriscode@gmail.com; s=20260130; h=from:subject:message-id;
 bh=FnnVUipcnXp2uwXZ+svU7qIgeUZRJVxaE3eFoy49gvk=;
 b=2kNg/qcuMdazf5pZYi+fpH4hNsPd5QizJoqKWEecoTJD2hHF/i9Ctby5DqmmZnMC8s+kUnMEr
 UqpJQjgtURoALK5Jb73QZF3yfi7HUoslVqEFCvA7DXHUdHNrIFnPMQL
X-Developer-Key: i=michaelharriscode@gmail.com; a=ed25519;
 pk=td/zQD3XANAhdG3Kf3mSetXiynk1Ql0eM4s0+eks5DU=

Add config names to macros to make it more clear which register they're
affecting. Also renamed ADT7316_EN to further clarify what
it's enabling.

Some macros were reordered, so that mask values were below the actual
mask.

Signed-off-by: Michael Harris <michaelharriscode@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 299 +++++++++++++++++++-----------------
 1 file changed, 154 insertions(+), 145 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index b8b66f4dd14bb59c3d29fdd569d84f0dd786db9e..ea7d97bb0f378f3a3ce1225d8d13af2c5955ca56 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -90,61 +90,61 @@
 /*
  * ADT7316 config1
  */
-#define ADT7316_EN			0x1
-#define ADT7516_SEL_EX_TEMP		0x4
-#define ADT7516_SEL_AIN1_2_EX_TEMP_MASK	0x6
-#define ADT7516_SEL_AIN3		0x8
-#define ADT7316_INT_EN			0x20
-#define ADT7316_INT_POLARITY		0x40
-#define ADT7316_PD			0x80
+#define ADT7316_CONFIG1_MONITOR_EN		0x1
+#define ADT7516_CONFIG1_SEL_AIN1_2_EX_TEMP_MASK	0x6
+#define ADT7516_CONFIG1_SEL_EX_TEMP		0x4
+#define ADT7516_CONFIG1_SEL_AIN3		0x8
+#define ADT7316_CONFIG1_INT_EN			0x20
+#define ADT7316_CONFIG1_INT_POLARITY		0x40
+#define ADT7316_CONFIG1_PD			0x80
 
 /*
  * ADT7316 config2
  */
-#define ADT7316_AD_SINGLE_CH_MASK	0x3
-#define ADT7516_AD_SINGLE_CH_MASK	0x7
-#define ADT7316_AD_SINGLE_CH_VDD	0
-#define ADT7316_AD_SINGLE_CH_IN		1
-#define ADT7316_AD_SINGLE_CH_EX		2
-#define ADT7516_AD_SINGLE_CH_AIN1	2
-#define ADT7516_AD_SINGLE_CH_AIN2	3
-#define ADT7516_AD_SINGLE_CH_AIN3	4
-#define ADT7516_AD_SINGLE_CH_AIN4	5
-#define ADT7316_AD_SINGLE_CH_MODE	0x10
-#define ADT7316_DISABLE_AVERAGING	0x20
-#define ADT7316_EN_SMBUS_TIMEOUT	0x40
-#define ADT7316_RESET			0x80
+#define ADT7316_CONFIG2_AD_SINGLE_CH_MASK	0x3
+#define ADT7516_CONFIG2_AD_SINGLE_CH_MASK	0x7
+#define ADT7316_CONFIG2_AD_SINGLE_CH_VDD	0
+#define ADT7316_CONFIG2_AD_SINGLE_CH_IN		1
+#define ADT7316_CONFIG2_AD_SINGLE_CH_EX		2
+#define ADT7516_CONFIG2_AD_SINGLE_CH_AIN1	2
+#define ADT7516_CONFIG2_AD_SINGLE_CH_AIN2	3
+#define ADT7516_CONFIG2_AD_SINGLE_CH_AIN3	4
+#define ADT7516_CONFIG2_AD_SINGLE_CH_AIN4	5
+#define ADT7316_CONFIG2_AD_SINGLE_CH_MODE	0x10
+#define ADT7316_CONFIG2_DISABLE_AVERAGING	0x20
+#define ADT7316_CONFIG2_EN_SMBUS_TIMEOUT	0x40
+#define ADT7316_CONFIG2_RESET			0x80
 
 /*
  * ADT7316 config3
  */
-#define ADT7316_ADCLK_22_5		0x1
-#define ADT7316_DA_HIGH_RESOLUTION	0x2
-#define ADT7316_DA_EN_VIA_DAC_LDAC	0x8
-#define ADT7516_AIN_IN_VREF		0x10
-#define ADT7316_EN_IN_TEMP_PROP_DACA	0x20
-#define ADT7316_EN_EX_TEMP_PROP_DACB	0x40
+#define ADT7316_CONFIG3_ADCLK_22_5		0x1
+#define ADT7316_CONFIG3_DA_HIGH_RESOLUTION	0x2
+#define ADT7316_CONFIG3_DA_EN_VIA_DAC_LDAC	0x8
+#define ADT7516_CONFIG3_AIN_IN_VREF		0x10
+#define ADT7316_CONFIG3_EN_IN_TEMP_PROP_DACA	0x20
+#define ADT7316_CONFIG3_EN_EX_TEMP_PROP_DACB	0x40
 
 /*
  * ADT7316 DAC config
  */
-#define ADT7316_DA_2VREF_CH_MASK	0xF
-#define ADT7316_DA_EN_MODE_MASK		0x30
-#define ADT7316_DA_EN_MODE_SINGLE	0x00
-#define ADT7316_DA_EN_MODE_AB_CD	0x10
-#define ADT7316_DA_EN_MODE_ABCD		0x20
-#define ADT7316_DA_EN_MODE_LDAC		0x30
-#define ADT7316_VREF_BYPASS_DAC_AB	0x40
-#define ADT7316_VREF_BYPASS_DAC_CD	0x80
+#define ADT7316_DAC_CONFIG_2VREF_CH_MASK	0xF
+#define ADT7316_DAC_CONFIG_EN_MODE_MASK		0x30
+#define ADT7316_DAC_CONFIG_EN_MODE_SINGLE	0x00
+#define ADT7316_DAC_CONFIG_EN_MODE_AB_CD	0x10
+#define ADT7316_DAC_CONFIG_EN_MODE_ABCD		0x20
+#define ADT7316_DAC_CONFIG_EN_MODE_LDAC		0x30
+#define ADT7316_DAC_CONFIG_VREF_BYPASS_AB	0x40
+#define ADT7316_DAC_CONFIG_VREF_BYPASS_CD	0x80
 
 /*
  * ADT7316 LDAC config
  */
-#define ADT7316_LDAC_EN_DA_MASK		0xF
-#define ADT7316_DAC_IN_VREF		0x10
-#define ADT7516_DAC_AB_IN_VREF		0x10
-#define ADT7516_DAC_CD_IN_VREF		0x20
-#define ADT7516_DAC_IN_VREF_MASK	0x30
+#define ADT7316_LDAC_CONFIG_EN_DA_MASK		0xF
+#define ADT7316_LDAC_CONFIG_DAC_IN_VREF		0x10
+#define ADT7516_LDAC_CONFIG_DAC_AB_IN_VREF	0x10
+#define ADT7516_LDAC_CONFIG_DAC_CD_IN_VREF	0x20
+#define ADT7516_LDAC_CONFIG_DAC_IN_VREF_MASK	0x30
 
 /*
  * ADT7316 INT_MASK2
@@ -219,7 +219,8 @@ static ssize_t adt7316_show_enabled(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return sysfs_emit(buf, "%d\n", !!(chip->config1 & ADT7316_EN));
+	return sysfs_emit(buf, "%d\n",
+			  !!(chip->config1 & ADT7316_CONFIG1_MONITOR_EN));
 }
 
 static ssize_t _adt7316_store_enabled(struct adt7316_chip_info *chip,
@@ -229,9 +230,9 @@ static ssize_t _adt7316_store_enabled(struct adt7316_chip_info *chip,
 	int ret;
 
 	if (enable)
-		config1 = chip->config1 | ADT7316_EN;
+		config1 = chip->config1 | ADT7316_CONFIG1_MONITOR_EN;
 	else
-		config1 = chip->config1 & ~ADT7316_EN;
+		config1 = chip->config1 & ~ADT7316_CONFIG1_MONITOR_EN;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
 	if (ret)
@@ -277,7 +278,8 @@ static ssize_t adt7316_show_select_ex_temp(struct device *dev,
 	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
 		return -EPERM;
 
-	return sysfs_emit(buf, "%d\n", !!(chip->config1 & ADT7516_SEL_EX_TEMP));
+	return sysfs_emit(buf, "%d\n",
+			  !!(chip->config1 & ADT7516_CONFIG1_SEL_EX_TEMP));
 }
 
 static ssize_t adt7316_store_select_ex_temp(struct device *dev,
@@ -293,9 +295,9 @@ static ssize_t adt7316_store_select_ex_temp(struct device *dev,
 	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
 		return -EPERM;
 
-	config1 = chip->config1 & (~ADT7516_SEL_EX_TEMP);
+	config1 = chip->config1 & (~ADT7516_CONFIG1_SEL_EX_TEMP);
 	if (buf[0] == '1')
-		config1 |= ADT7516_SEL_EX_TEMP;
+		config1 |= ADT7516_CONFIG1_SEL_EX_TEMP;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
 	if (ret)
@@ -318,7 +320,7 @@ static ssize_t adt7316_show_mode(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	if (chip->config2 & ADT7316_AD_SINGLE_CH_MODE)
+	if (chip->config2 & ADT7316_CONFIG2_AD_SINGLE_CH_MODE)
 		return sysfs_emit(buf, "single_channel\n");
 
 	return sysfs_emit(buf, "round_robin\n");
@@ -334,9 +336,9 @@ static ssize_t adt7316_store_mode(struct device *dev,
 	u8 config2;
 	int ret;
 
-	config2 = chip->config2 & (~ADT7316_AD_SINGLE_CH_MODE);
+	config2 = chip->config2 & (~ADT7316_CONFIG2_AD_SINGLE_CH_MODE);
 	if (!memcmp(buf, "single_channel", 14))
-		config2 |= ADT7316_AD_SINGLE_CH_MODE;
+		config2 |= ADT7316_CONFIG2_AD_SINGLE_CH_MODE;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
 	if (ret)
@@ -368,31 +370,31 @@ static ssize_t adt7316_show_ad_channel(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	if (!(chip->config2 & ADT7316_AD_SINGLE_CH_MODE))
+	if (!(chip->config2 & ADT7316_CONFIG2_AD_SINGLE_CH_MODE))
 		return -EPERM;
 
-	switch (chip->config2 & ADT7516_AD_SINGLE_CH_MASK) {
-	case ADT7316_AD_SINGLE_CH_VDD:
+	switch (chip->config2 & ADT7516_CONFIG2_AD_SINGLE_CH_MASK) {
+	case ADT7316_CONFIG2_AD_SINGLE_CH_VDD:
 		return sysfs_emit(buf, "0 - VDD\n");
-	case ADT7316_AD_SINGLE_CH_IN:
+	case ADT7316_CONFIG2_AD_SINGLE_CH_IN:
 		return sysfs_emit(buf, "1 - Internal Temperature\n");
-	case ADT7316_AD_SINGLE_CH_EX:
+	case ADT7316_CONFIG2_AD_SINGLE_CH_EX:
 		if (((chip->id & ID_FAMILY_MASK) == ID_ADT75XX) &&
-		    (chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)
+		    (chip->config1 & ADT7516_CONFIG1_SEL_AIN1_2_EX_TEMP_MASK) == 0)
 			return sysfs_emit(buf, "2 - AIN1\n");
 
 		return sysfs_emit(buf, "2 - External Temperature\n");
-	case ADT7516_AD_SINGLE_CH_AIN2:
-		if ((chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)
+	case ADT7516_CONFIG2_AD_SINGLE_CH_AIN2:
+		if ((chip->config1 & ADT7516_CONFIG1_SEL_AIN1_2_EX_TEMP_MASK) == 0)
 			return sysfs_emit(buf, "3 - AIN2\n");
 
 		return sysfs_emit(buf, "N/A\n");
-	case ADT7516_AD_SINGLE_CH_AIN3:
-		if (chip->config1 & ADT7516_SEL_AIN3)
+	case ADT7516_CONFIG2_AD_SINGLE_CH_AIN3:
+		if (chip->config1 & ADT7516_CONFIG1_SEL_AIN3)
 			return sysfs_emit(buf, "4 - AIN3\n");
 
 		return sysfs_emit(buf, "N/A\n");
-	case ADT7516_AD_SINGLE_CH_AIN4:
+	case ADT7516_CONFIG2_AD_SINGLE_CH_AIN4:
 		return sysfs_emit(buf, "5 - AIN4\n");
 	default:
 		return sysfs_emit(buf, "N/A\n");
@@ -410,7 +412,7 @@ static ssize_t adt7316_store_ad_channel(struct device *dev,
 	u8 data;
 	int ret;
 
-	if (!(chip->config2 & ADT7316_AD_SINGLE_CH_MODE))
+	if (!(chip->config2 & ADT7316_CONFIG2_AD_SINGLE_CH_MODE))
 		return -EPERM;
 
 	ret = kstrtou8(buf, 10, &data);
@@ -421,12 +423,12 @@ static ssize_t adt7316_store_ad_channel(struct device *dev,
 		if (data > 5)
 			return -EINVAL;
 
-		config2 = chip->config2 & (~ADT7516_AD_SINGLE_CH_MASK);
+		config2 = chip->config2 & (~ADT7516_CONFIG2_AD_SINGLE_CH_MASK);
 	} else {
 		if (data > 2)
 			return -EINVAL;
 
-		config2 = chip->config2 & (~ADT7316_AD_SINGLE_CH_MASK);
+		config2 = chip->config2 & (~ADT7316_CONFIG2_AD_SINGLE_CH_MASK);
 	}
 
 	config2 |= data;
@@ -452,7 +454,7 @@ static ssize_t adt7316_show_all_ad_channels(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	if (!(chip->config2 & ADT7316_AD_SINGLE_CH_MODE))
+	if (!(chip->config2 & ADT7316_CONFIG2_AD_SINGLE_CH_MODE))
 		return -EPERM;
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
@@ -474,7 +476,7 @@ static ssize_t adt7316_show_disable_averaging(struct device *dev,
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sysfs_emit(buf, "%d\n",
-		!!(chip->config2 & ADT7316_DISABLE_AVERAGING));
+		!!(chip->config2 & ADT7316_CONFIG2_DISABLE_AVERAGING));
 }
 
 static ssize_t adt7316_store_disable_averaging(struct device *dev,
@@ -487,9 +489,9 @@ static ssize_t adt7316_store_disable_averaging(struct device *dev,
 	u8 config2;
 	int ret;
 
-	config2 = chip->config2 & (~ADT7316_DISABLE_AVERAGING);
+	config2 = chip->config2 & (~ADT7316_CONFIG2_DISABLE_AVERAGING);
 	if (buf[0] == '1')
-		config2 |= ADT7316_DISABLE_AVERAGING;
+		config2 |= ADT7316_CONFIG2_DISABLE_AVERAGING;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
 	if (ret)
@@ -513,7 +515,7 @@ static ssize_t adt7316_show_enable_smbus_timeout(struct device *dev,
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sysfs_emit(buf, "%d\n",
-		!!(chip->config2 & ADT7316_EN_SMBUS_TIMEOUT));
+		!!(chip->config2 & ADT7316_CONFIG2_EN_SMBUS_TIMEOUT));
 }
 
 static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
@@ -526,9 +528,9 @@ static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
 	u8 config2;
 	int ret;
 
-	config2 = chip->config2 & (~ADT7316_EN_SMBUS_TIMEOUT);
+	config2 = chip->config2 & (~ADT7316_CONFIG2_EN_SMBUS_TIMEOUT);
 	if (buf[0] == '1')
-		config2 |= ADT7316_EN_SMBUS_TIMEOUT;
+		config2 |= ADT7316_CONFIG2_EN_SMBUS_TIMEOUT;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
 	if (ret)
@@ -551,7 +553,7 @@ static ssize_t adt7316_show_powerdown(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return sysfs_emit(buf, "%d\n", !!(chip->config1 & ADT7316_PD));
+	return sysfs_emit(buf, "%d\n", !!(chip->config1 & ADT7316_CONFIG1_PD));
 }
 
 static ssize_t adt7316_store_powerdown(struct device *dev,
@@ -564,9 +566,9 @@ static ssize_t adt7316_store_powerdown(struct device *dev,
 	u8 config1;
 	int ret;
 
-	config1 = chip->config1 & (~ADT7316_PD);
+	config1 = chip->config1 & (~ADT7316_CONFIG1_PD);
 	if (buf[0] == '1')
-		config1 |= ADT7316_PD;
+		config1 |= ADT7316_CONFIG1_PD;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
 	if (ret)
@@ -589,7 +591,8 @@ static ssize_t adt7316_show_fast_ad_clock(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return sysfs_emit(buf, "%d\n", !!(chip->config3 & ADT7316_ADCLK_22_5));
+	return sysfs_emit(buf, "%d\n",
+			  !!(chip->config3 & ADT7316_CONFIG3_ADCLK_22_5));
 }
 
 static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
@@ -602,9 +605,9 @@ static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
 	u8 config3;
 	int ret;
 
-	config3 = chip->config3 & (~ADT7316_ADCLK_22_5);
+	config3 = chip->config3 & (~ADT7316_CONFIG3_ADCLK_22_5);
 	if (buf[0] == '1')
-		config3 |= ADT7316_ADCLK_22_5;
+		config3 |= ADT7316_CONFIG3_ADCLK_22_5;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
 	if (ret)
@@ -627,7 +630,7 @@ static ssize_t adt7316_show_da_high_resolution(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	if (chip->config3 & ADT7316_DA_HIGH_RESOLUTION) {
+	if (chip->config3 & ADT7316_CONFIG3_DA_HIGH_RESOLUTION) {
 		if (chip->id != ID_ADT7318 && chip->id != ID_ADT7519)
 			return sysfs_emit(buf, "1 (10 bits)\n");
 	}
@@ -648,9 +651,9 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
 	if (chip->id == ID_ADT7318 || chip->id == ID_ADT7519)
 		return -EPERM;
 
-	config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
+	config3 = chip->config3 & (~ADT7316_CONFIG3_DA_HIGH_RESOLUTION);
 	if (buf[0] == '1')
-		config3 |= ADT7316_DA_HIGH_RESOLUTION;
+		config3 |= ADT7316_CONFIG3_DA_HIGH_RESOLUTION;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
 	if (ret)
@@ -677,7 +680,7 @@ static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
 		return -EPERM;
 
 	return sysfs_emit(buf, "%d\n",
-		!!(chip->config3 & ADT7516_AIN_IN_VREF));
+		!!(chip->config3 & ADT7516_CONFIG3_AIN_IN_VREF));
 }
 
 static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
@@ -694,9 +697,9 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
 		return -EPERM;
 
 	if (buf[0] != '1')
-		config3 = chip->config3 & (~ADT7516_AIN_IN_VREF);
+		config3 = chip->config3 & (~ADT7516_CONFIG3_AIN_IN_VREF);
 	else
-		config3 = chip->config3 | ADT7516_AIN_IN_VREF;
+		config3 = chip->config3 | ADT7516_CONFIG3_AIN_IN_VREF;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
 	if (ret)
@@ -720,7 +723,7 @@ static ssize_t adt7316_show_enable_prop_DACA(struct device *dev,
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sysfs_emit(buf, "%d\n",
-		!!(chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA));
+		!!(chip->config3 & ADT7316_CONFIG3_EN_IN_TEMP_PROP_DACA));
 }
 
 static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
@@ -733,9 +736,9 @@ static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
 	u8 config3;
 	int ret;
 
-	config3 = chip->config3 & (~ADT7316_EN_IN_TEMP_PROP_DACA);
+	config3 = chip->config3 & (~ADT7316_CONFIG3_EN_IN_TEMP_PROP_DACA);
 	if (buf[0] == '1')
-		config3 |= ADT7316_EN_IN_TEMP_PROP_DACA;
+		config3 |= ADT7316_CONFIG3_EN_IN_TEMP_PROP_DACA;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
 	if (ret)
@@ -759,7 +762,7 @@ static ssize_t adt7316_show_enable_prop_DACB(struct device *dev,
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sysfs_emit(buf, "%d\n",
-		!!(chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB));
+		!!(chip->config3 & ADT7316_CONFIG3_EN_EX_TEMP_PROP_DACB));
 }
 
 static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
@@ -772,9 +775,9 @@ static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
 	u8 config3;
 	int ret;
 
-	config3 = chip->config3 & (~ADT7316_EN_EX_TEMP_PROP_DACB);
+	config3 = chip->config3 & (~ADT7316_CONFIG3_EN_EX_TEMP_PROP_DACB);
 	if (buf[0] == '1')
-		config3 |= ADT7316_EN_EX_TEMP_PROP_DACB;
+		config3 |= ADT7316_CONFIG3_EN_EX_TEMP_PROP_DACB;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
 	if (ret)
@@ -798,7 +801,7 @@ static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sysfs_emit(buf, "0x%x\n",
-		chip->dac_config & ADT7316_DA_2VREF_CH_MASK);
+		chip->dac_config & ADT7316_DAC_CONFIG_2VREF_CH_MASK);
 }
 
 static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
@@ -813,10 +816,10 @@ static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
 	int ret;
 
 	ret = kstrtou8(buf, 16, &data);
-	if (ret || data > ADT7316_DA_2VREF_CH_MASK)
+	if (ret || data > ADT7316_DAC_CONFIG_2VREF_CH_MASK)
 		return -EINVAL;
 
-	dac_config = chip->dac_config & (~ADT7316_DA_2VREF_CH_MASK);
+	dac_config = chip->dac_config & (~ADT7316_DAC_CONFIG_2VREF_CH_MASK);
 	dac_config |= data;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
@@ -840,20 +843,20 @@ static ssize_t adt7316_show_DAC_update_mode(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDAC))
+	if (!(chip->config3 & ADT7316_CONFIG3_DA_EN_VIA_DAC_LDAC))
 		return sysfs_emit(buf, "manual\n");
 
-	switch (chip->dac_config & ADT7316_DA_EN_MODE_MASK) {
-	case ADT7316_DA_EN_MODE_SINGLE:
+	switch (chip->dac_config & ADT7316_DAC_CONFIG_EN_MODE_MASK) {
+	case ADT7316_DAC_CONFIG_EN_MODE_SINGLE:
 		return sysfs_emit(buf,
 			"0 - auto at any MSB DAC writing\n");
-	case ADT7316_DA_EN_MODE_AB_CD:
+	case ADT7316_DAC_CONFIG_EN_MODE_AB_CD:
 		return sysfs_emit(buf,
 			"1 - auto at MSB DAC AB and CD writing\n");
-	case ADT7316_DA_EN_MODE_ABCD:
+	case ADT7316_DAC_CONFIG_EN_MODE_ABCD:
 		return sysfs_emit(buf,
 			"2 - auto at MSB DAC ABCD writing\n");
-	default: /* ADT7316_DA_EN_MODE_LDAC */
+	default: /* ADT7316_DAC_CONFIG_EN_MODE_LDAC */
 		return sysfs_emit(buf, "3 - manual\n");
 	}
 }
@@ -869,15 +872,15 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
 	u8 data;
 	int ret;
 
-	if (!(chip->config3 & ADT7316_DA_EN_VIA_DAC_LDAC))
+	if (!(chip->config3 & ADT7316_CONFIG3_DA_EN_VIA_DAC_LDAC))
 		return -EPERM;
 
 	ret = kstrtou8(buf, 10, &data);
-	if (ret || !FIELD_FIT(ADT7316_DA_EN_MODE_MASK, data))
+	if (ret || !FIELD_FIT(ADT7316_DAC_CONFIG_EN_MODE_MASK, data))
 		return -EINVAL;
 
-	dac_config = chip->dac_config & (~ADT7316_DA_EN_MODE_MASK);
-	dac_config |= FIELD_PREP(ADT7316_DA_EN_MODE_MASK, data);
+	dac_config = chip->dac_config & (~ADT7316_DAC_CONFIG_EN_MODE_MASK);
+	dac_config |= FIELD_PREP(ADT7316_DAC_CONFIG_EN_MODE_MASK, data);
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
 	if (ret)
@@ -900,7 +903,7 @@ static ssize_t adt7316_show_all_DAC_update_modes(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDAC)
+	if (chip->config3 & ADT7316_CONFIG3_DA_EN_VIA_DAC_LDAC)
 		return sysfs_emit(buf, "0 - auto at any MSB DAC writing\n"
 				"1 - auto at MSB DAC AB and CD writing\n"
 				"2 - auto at MSB DAC ABCD writing\n"
@@ -922,16 +925,17 @@ static ssize_t adt7316_store_update_DAC(struct device *dev,
 	u8 data;
 	int ret;
 
-	if (chip->config3 & ADT7316_DA_EN_VIA_DAC_LDAC) {
-		if ((chip->dac_config & ADT7316_DA_EN_MODE_MASK) !=
-			ADT7316_DA_EN_MODE_LDAC)
+	if (chip->config3 & ADT7316_CONFIG3_DA_EN_VIA_DAC_LDAC) {
+		if ((chip->dac_config & ADT7316_DAC_CONFIG_EN_MODE_MASK) !=
+			ADT7316_DAC_CONFIG_EN_MODE_LDAC)
 			return -EPERM;
 
 		ret = kstrtou8(buf, 16, &data);
-		if (ret || data > ADT7316_LDAC_EN_DA_MASK)
+		if (ret || data > ADT7316_LDAC_CONFIG_EN_DA_MASK)
 			return -EINVAL;
 
-		ldac_config = chip->ldac_config & (~ADT7316_LDAC_EN_DA_MASK);
+		ldac_config = chip->ldac_config &
+			(~ADT7316_LDAC_CONFIG_EN_DA_MASK);
 		ldac_config |= data;
 
 		ret = chip->bus.write(chip->bus.client, ADT7316_LDAC_CONFIG,
@@ -959,7 +963,7 @@ static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sysfs_emit(buf, "%d\n",
-		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_AB));
+		!!(chip->dac_config & ADT7316_DAC_CONFIG_VREF_BYPASS_AB));
 }
 
 static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
@@ -972,9 +976,9 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
 	u8 dac_config;
 	int ret;
 
-	dac_config = chip->dac_config & (~ADT7316_VREF_BYPASS_DAC_AB);
+	dac_config = chip->dac_config & (~ADT7316_DAC_CONFIG_VREF_BYPASS_AB);
 	if (buf[0] == '1')
-		dac_config |= ADT7316_VREF_BYPASS_DAC_AB;
+		dac_config |= ADT7316_DAC_CONFIG_VREF_BYPASS_AB;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
 	if (ret)
@@ -998,7 +1002,7 @@ static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
 	return sysfs_emit(buf, "%d\n",
-		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_CD));
+		!!(chip->dac_config & ADT7316_DAC_CONFIG_VREF_BYPASS_CD));
 }
 
 static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
@@ -1011,9 +1015,9 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
 	u8 dac_config;
 	int ret;
 
-	dac_config = chip->dac_config & (~ADT7316_VREF_BYPASS_DAC_CD);
+	dac_config = chip->dac_config & (~ADT7316_DAC_CONFIG_VREF_BYPASS_CD);
 	if (buf[0] == '1')
-		dac_config |= ADT7316_VREF_BYPASS_DAC_CD;
+		dac_config |= ADT7316_DAC_CONFIG_VREF_BYPASS_CD;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
 	if (ret)
@@ -1038,9 +1042,10 @@ static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 		return sysfs_emit(buf, "0x%x\n",
-			FIELD_GET(ADT7516_DAC_IN_VREF_MASK, chip->ldac_config));
+			FIELD_GET(ADT7516_LDAC_CONFIG_DAC_IN_VREF_MASK,
+				  chip->ldac_config));
 	return sysfs_emit(buf, "%d\n",
-		       !!(chip->ldac_config & ADT7316_DAC_IN_VREF));
+		       !!(chip->ldac_config & ADT7316_LDAC_CONFIG_DAC_IN_VREF));
 }
 
 static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
@@ -1059,19 +1064,22 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
 		if (ret || data > 3)
 			return -EINVAL;
 
-		ldac_config = chip->ldac_config & (~ADT7516_DAC_IN_VREF_MASK);
+		ldac_config = chip->ldac_config &
+			(~ADT7516_LDAC_CONFIG_DAC_IN_VREF_MASK);
 		if (data & 0x1)
-			ldac_config |= ADT7516_DAC_AB_IN_VREF;
+			ldac_config |= ADT7516_LDAC_CONFIG_DAC_AB_IN_VREF;
 		if (data & 0x2)
-			ldac_config |= ADT7516_DAC_CD_IN_VREF;
+			ldac_config |= ADT7516_LDAC_CONFIG_DAC_CD_IN_VREF;
 	} else {
 		ret = kstrtou8(buf, 16, &data);
 		if (ret)
 			return -EINVAL;
 
-		ldac_config = chip->ldac_config & (~ADT7316_DAC_IN_VREF);
+		ldac_config = chip->ldac_config &
+			(~ADT7316_LDAC_CONFIG_DAC_IN_VREF);
 		if (data)
-			ldac_config = chip->ldac_config | ADT7316_DAC_IN_VREF;
+			ldac_config = chip->ldac_config |
+				ADT7316_LDAC_CONFIG_DAC_IN_VREF;
 	}
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_LDAC_CONFIG,
@@ -1092,13 +1100,13 @@ static IIO_DEVICE_ATTR(DAC_internal_Vref, 0644,
 static u8 adt7316_extract_ad_lsb(u8 lsb, int channel)
 {
 	switch (channel) {
-	case ADT7316_AD_SINGLE_CH_EX:
+	case ADT7316_CONFIG2_AD_SINGLE_CH_EX:
 		return FIELD_GET(ADT7316_LSB_EX_TEMP_AIN1_MASK, lsb);
-	case ADT7516_AD_SINGLE_CH_AIN2:
+	case ADT7516_CONFIG2_AD_SINGLE_CH_AIN2:
 		return FIELD_GET(ADT7516_LSB_AIN2_MASK, lsb);
-	case ADT7516_AD_SINGLE_CH_AIN3:
+	case ADT7516_CONFIG2_AD_SINGLE_CH_AIN3:
 		return FIELD_GET(ADT7516_LSB_AIN3_MASK, lsb);
-	case ADT7516_AD_SINGLE_CH_AIN4:
+	case ADT7516_CONFIG2_AD_SINGLE_CH_AIN4:
 		return FIELD_GET(ADT7516_LSB_AIN4_MASK, lsb);
 	default:
 		return 0;
@@ -1112,12 +1120,12 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 	u8 msb, lsb;
 	int ret;
 
-	if ((chip->config2 & ADT7316_AD_SINGLE_CH_MODE) &&
-	    channel != (chip->config2 & ADT7516_AD_SINGLE_CH_MASK))
+	if ((chip->config2 & ADT7316_CONFIG2_AD_SINGLE_CH_MODE) &&
+	    channel != (chip->config2 & ADT7516_CONFIG2_AD_SINGLE_CH_MASK))
 		return -EPERM;
 
 	switch (channel) {
-	case ADT7316_AD_SINGLE_CH_IN:
+	case ADT7316_CONFIG2_AD_SINGLE_CH_IN:
 		ret = chip->bus.read(chip->bus.client,
 			ADT7316_LSB_IN_TEMP_VDD, &lsb);
 		if (ret)
@@ -1131,7 +1139,7 @@ static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
 		data = FIELD_PREP(ADT7316_AD_MSB_MASK, msb);
 		data |= lsb & ADT7316_LSB_IN_TEMP_MASK;
 		break;
-	case ADT7316_AD_SINGLE_CH_VDD:
+	case ADT7316_CONFIG2_AD_SINGLE_CH_VDD:
 		ret = chip->bus.read(chip->bus.client,
 			ADT7316_LSB_IN_TEMP_VDD, &lsb);
 		if (ret)
@@ -1182,7 +1190,7 @@ static ssize_t adt7316_show_VDD(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_VDD, buf);
+	return adt7316_show_ad(chip, ADT7316_CONFIG2_AD_SINGLE_CH_VDD, buf);
 }
 static IIO_DEVICE_ATTR(VDD, 0444, adt7316_show_VDD, NULL, 0);
 
@@ -1193,7 +1201,7 @@ static ssize_t adt7316_show_in_temp(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_IN, buf);
+	return adt7316_show_ad(chip, ADT7316_CONFIG2_AD_SINGLE_CH_IN, buf);
 }
 
 static IIO_DEVICE_ATTR(in_temp, 0444, adt7316_show_in_temp, NULL, 0);
@@ -1205,7 +1213,7 @@ static ssize_t adt7316_show_ex_temp_AIN1(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return adt7316_show_ad(chip, ADT7316_AD_SINGLE_CH_EX, buf);
+	return adt7316_show_ad(chip, ADT7316_CONFIG2_AD_SINGLE_CH_EX, buf);
 }
 
 static IIO_DEVICE_ATTR(ex_temp_AIN1, 0444, adt7316_show_ex_temp_AIN1,
@@ -1219,7 +1227,7 @@ static ssize_t adt7316_show_AIN2(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN2, buf);
+	return adt7316_show_ad(chip, ADT7516_CONFIG2_AD_SINGLE_CH_AIN2, buf);
 }
 static IIO_DEVICE_ATTR(AIN2, 0444, adt7316_show_AIN2, NULL, 0);
 
@@ -1230,7 +1238,7 @@ static ssize_t adt7316_show_AIN3(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN3, buf);
+	return adt7316_show_ad(chip, ADT7516_CONFIG2_AD_SINGLE_CH_AIN3, buf);
 }
 static IIO_DEVICE_ATTR(AIN3, 0444, adt7316_show_AIN3, NULL, 0);
 
@@ -1241,7 +1249,7 @@ static ssize_t adt7316_show_AIN4(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return adt7316_show_ad(chip, ADT7516_AD_SINGLE_CH_AIN4, buf);
+	return adt7316_show_ad(chip, ADT7516_CONFIG2_AD_SINGLE_CH_AIN4, buf);
 }
 static IIO_DEVICE_ATTR(AIN4, 0444, adt7316_show_AIN4, NULL, 0);
 
@@ -1403,9 +1411,9 @@ static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
 
 	if (channel >= ADT7316_DA_MSB_DATA_REGS ||
 	    (channel == 0 &&
-	    (chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA)) ||
+	    (chip->config3 & ADT7316_CONFIG3_EN_IN_TEMP_PROP_DACA)) ||
 	    (channel == 1 &&
-	    (chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB)))
+	    (chip->config3 & ADT7316_CONFIG3_EN_EX_TEMP_PROP_DACB)))
 		return -EPERM;
 
 	offset = chip->dac_bits - 8;
@@ -1440,9 +1448,9 @@ static ssize_t adt7316_store_DAC(struct adt7316_chip_info *chip,
 
 	if (channel >= ADT7316_DA_MSB_DATA_REGS ||
 	    (channel == 0 &&
-	    (chip->config3 & ADT7316_EN_IN_TEMP_PROP_DACA)) ||
+	    (chip->config3 & ADT7316_CONFIG3_EN_IN_TEMP_PROP_DACA)) ||
 	    (channel == 1 &&
-	    (chip->config3 & ADT7316_EN_EX_TEMP_PROP_DACB)))
+	    (chip->config3 & ADT7316_CONFIG3_EN_EX_TEMP_PROP_DACB)))
 		return -EPERM;
 
 	offset = chip->dac_bits - 8;
@@ -1834,7 +1842,7 @@ static int adt7316_setup_irq(struct iio_dev *indio_dev)
 	}
 
 	if (irq_type & IRQF_TRIGGER_HIGH)
-		chip->config1 |= ADT7316_INT_POLARITY;
+		chip->config1 |= ADT7316_CONFIG1_INT_POLARITY;
 
 	return 0;
 }
@@ -1918,7 +1926,7 @@ static inline ssize_t adt7316_show_ad_bound(struct device *dev,
 	data = (int)val;
 
 	if (!((chip->id & ID_FAMILY_MASK) == ID_ADT75XX &&
-	      (chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0)) {
+	      (chip->config1 & ADT7516_CONFIG1_SEL_AIN1_2_EX_TEMP_MASK) == 0)) {
 		if (data & 0x80)
 			data -= 256;
 	}
@@ -1947,7 +1955,7 @@ static inline ssize_t adt7316_set_ad_bound(struct device *dev,
 		return -EINVAL;
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX &&
-	    (chip->config1 & ADT7516_SEL_AIN1_2_EX_TEMP_MASK) == 0) {
+	    (chip->config1 & ADT7516_CONFIG1_SEL_AIN1_2_EX_TEMP_MASK) == 0) {
 		if (data > 255 || data < 0)
 			return -EINVAL;
 	} else {
@@ -1974,7 +1982,8 @@ static ssize_t adt7316_show_int_enabled(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 
-	return sysfs_emit(buf, "%d\n", !!(chip->config1 & ADT7316_INT_EN));
+	return sysfs_emit(buf, "%d\n",
+			  !!(chip->config1 & ADT7316_CONFIG1_INT_EN));
 }
 
 static ssize_t adt7316_set_int_enabled(struct device *dev,
@@ -1987,9 +1996,9 @@ static ssize_t adt7316_set_int_enabled(struct device *dev,
 	u8 config1;
 	int ret;
 
-	config1 = chip->config1 & (~ADT7316_INT_EN);
+	config1 = chip->config1 & (~ADT7316_CONFIG1_INT_EN);
 	if (buf[0] == '1')
-		config1 |= ADT7316_INT_EN;
+		config1 |= ADT7316_CONFIG1_INT_EN;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
 	if (ret)
@@ -2167,9 +2176,9 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	}
 
 	if (!chip->ldac_pin) {
-		chip->config3 |= ADT7316_DA_EN_VIA_DAC_LDAC;
+		chip->config3 |= ADT7316_CONFIG3_DA_EN_VIA_DAC_LDAC;
 		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
-			chip->config1 |= ADT7516_SEL_AIN3;
+			chip->config1 |= ADT7516_CONFIG1_SEL_AIN3;
 	}
 	chip->int_mask = ADT7316_TEMP_INT_MASK | ADT7316_VDD_INT_MASK;
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)

-- 
2.53.0

