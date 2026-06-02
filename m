Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F2B3A425B
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 19:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427001; cv=none; b=pRRdGsVWTSiM7zOwKYeZ15n8tyTfDu8d7Ot24G1DqsF1setA6KpSQWbVWBylThwJJYPF63Yu0/yK6f8dtgjd2gb/ZFXjgxxevKeiPMFT771ouqpZxJG0euK6JVjjPIh0e1I/3iihhQbu2evN0C50zbUExcUxIs3c6+5tAJDtQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427001; c=relaxed/simple;
	bh=zJTu9veXEM3Lrrt040/1KsikJHjCRx0dCltdW93CFPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOUTvR4e9J+WaAIDmAIdZnKHPmG0T9DQdKrOnjIztVCuLgoo58Q4DvB2Hqw8eaTP9nxLMhwJQXj+gaqcm3VwHCMv2nhTqxZqi50HOrOb+VEVxP7rPJgOPypUO5GmozrmyM+gSw3E/+1vmCruROLXOQt/huu006H9DAHN0Ks7LCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdKRhZ/H; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdKRhZ/H"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49068493267so68627725e9.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 12:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780426997; x=1781031797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vNX7HWh/NKDhCbF70pYqvTRR2al/vJaAaaX8bCfRONo=;
        b=MdKRhZ/HlVQzSD/KFNQd02wtIP63RQQH/bq6oXVzcYRcnxtViHMsolCOp0pvtBJ4XX
         1Tb4lMVBDWYoXGY/6WKB/MfgMcEV1ZWyZL/nCpAtCmAcbstni7g7+dmZ814pQkV0myt3
         xudFXF6NIqODYIJvCRMj8pIbpRCpLcUOu/eWp5LSRIfUiDh9uNEbqrdfmrttZvcRUq1d
         hL+O0VGHIKGS8M7Ft5F5aFOy6xDMPQmPcouQYFAb9b2BhPh46cDG7g7sV50hJtXW3y7x
         wnVJKwOUk0CmxPraNecRkQReIfSla7dX15RnHCxdZlDkk6gzl76Z8BAUVlSbpANIWrZc
         3heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780426997; x=1781031797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNX7HWh/NKDhCbF70pYqvTRR2al/vJaAaaX8bCfRONo=;
        b=OZXpmpR3WVx7RwvgqY+474+TUok+Q6Wh9O0k7vNe//GYcSrhxvacMb6PbTCLJzwBUD
         7xIRRJBv4B9vQD3rvN49XADOcG0Br3BlhtwF78ilGYwK+xH5EKk/h0xsipVCIT+yA8yL
         ulR+q2rqJimeXw0pDfi3FkUUhJb/t3oHv27dBtl6gjWyYJk85lErTt3F88ACspymgxCZ
         Upz4ZZu1H+aEbjZb82Jwf8OSfm37j32wfFUfkzj51Od2dWKXup1n/eTR/MsHpJ9pDTV+
         zB32LV71/lthKXzJ02v056ogWiYO9u/4UMNREzsxKAb+MwyO6boKmnqUfkPtog/2YATa
         tdJA==
X-Gm-Message-State: AOJu0Yyi+/hmqyezBrZldNI6CrBK4Pnzw/RysJeHBOfHjKMnGcxrXdeW
	qS33242iGqM8E5ZEhmcWwP4GseBdhGya8SS8EmZ9zTbOIfdTv85uGVCh
X-Gm-Gg: Acq92OE5dCG1OdCJPuQwX3CpghnQTtvtm4bYEA8h/ujlHmWE4Id0+hgCkalPQtvjhd+
	RAk30x19pg/MBOlIKZ5beBFD0daPj1LjQ10FbFEYlF3HU2cxkKOz1uIsg7EoHgftQXWxXdpKvpj
	E/e4k21xrkgP/R6o4vVHTKJeg/G+8z/KHfIEpqA+BO+1o5pKvEdUwVbM4lkzoS+jiUJLE2TcZDk
	vy6CGVdOXGwv/w4eJgp5qltmWaQxPFAe+w+J4tmN29rl3sZ/wSQkmavcVMX2qQeuoAchecz1FSs
	Uk7stsm8Yx0ZLk1waJlHP9reCgcIEpPRl22lh6bo2i9anNHCY/3V8z4AoWbExJHZziVJCNqpVBF
	BF8rrdbUPfx+XImOv3LFXxvTIlNb85vZ5Om2yU/iY72Lr3Kv4e87W+bBFQjh2lb3HYs6cDG4ldj
	YLyqtfIABzJnQ+KLXVl8Gw+MSLTbbxQGhCFxY0B9DgK7s7XHdg/sZvcepjGLRxIrTCOFbESIXh9
	ybIb3FMSUA51KujyvVfBkQ0Dw==
X-Received: by 2002:a05:600c:3495:b0:490:3c90:2cda with SMTP id 5b1f17b1804b1-490b5ed636amr1404525e9.20.1780426996666;
        Tue, 02 Jun 2026 12:03:16 -0700 (PDT)
Received: from fedora ([105.190.243.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f368e9fsm1374473f8f.37.2026.06.02.12.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:03:16 -0700 (PDT)
From: Jad Keskes <inasj268@gmail.com>
To: linux-staging@lists.linux.dev
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	Jad Keskes <inasj268@gmail.com>
Subject: [PATCH v2] staging: iio: addac: fix CamelCase naming in adt7316
Date: Tue,  2 Jun 2026 20:03:08 +0100
Message-ID: <20260602190308.158051-1-inasj268@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

checkpatch flagged a few CamelCase names in this driver.
AIN and DAC prefixes are lowercased as standard kernel style.
Vref is kept capitalized since V stands for Voltage and is a
proper technical abbreviation.

DA_AB and DA_CD are renamed to dac_ab and dac_cd to match the
register constants ADT7316_VREF_BYPASS_DAC_AB and
ADT7316_VREF_BYPASS_DAC_CD that they reference.

Signed-off-by: Jad Keskes <inasj268@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 64 ++++++++++++++---------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 8a9a8262c..b5d62f1d3 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -663,7 +663,7 @@ static IIO_DEVICE_ATTR(da_high_resolution, 0644,
 		adt7316_store_da_high_resolution,
 		0);
 
-static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
+static ssize_t adt7316_show_ain_internal_Vref(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -677,7 +677,7 @@ static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
 		!!(chip->config3 & ADT7516_AIN_IN_VREF));
 }
 
-static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
+static ssize_t adt7316_store_ain_internal_Vref(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -704,9 +704,9 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(AIN_internal_Vref, 0644,
-		adt7316_show_AIN_internal_Vref,
-		adt7316_store_AIN_internal_Vref,
+static IIO_DEVICE_ATTR(ain_internal_Vref, 0644,
+		adt7316_show_ain_internal_Vref,
+		adt7316_store_ain_internal_Vref,
 		0);
 
 static ssize_t adt7316_show_enable_prop_DACA(struct device *dev,
@@ -787,7 +787,7 @@ static IIO_DEVICE_ATTR(enable_proportion_DACB, 0644,
 		       adt7316_store_enable_prop_DACB,
 		       0);
 
-static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
+static ssize_t adt7316_show_dac_2Vref_ch_mask(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -798,7 +798,7 @@ static ssize_t adt7316_show_DAC_2Vref_ch_mask(struct device *dev,
 		chip->dac_config & ADT7316_DA_2VREF_CH_MASK);
 }
 
-static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
+static ssize_t adt7316_store_dac_2Vref_ch_mask(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -825,9 +825,9 @@ static ssize_t adt7316_store_DAC_2Vref_ch_mask(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(DAC_2Vref_channels_mask, 0644,
-		       adt7316_show_DAC_2Vref_ch_mask,
-		       adt7316_store_DAC_2Vref_ch_mask,
+static IIO_DEVICE_ATTR(dac_2Vref_channels_mask, 0644,
+		       adt7316_show_dac_2Vref_ch_mask,
+		       adt7316_store_dac_2Vref_ch_mask,
 		       0);
 
 static ssize_t adt7316_show_DAC_update_mode(struct device *dev,
@@ -948,7 +948,7 @@ static IIO_DEVICE_ATTR(update_DAC, 0644,
 		       adt7316_store_update_DAC,
 		       0);
 
-static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
+static ssize_t adt7316_show_dac_ab_Vref_bypass(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -959,7 +959,7 @@ static ssize_t adt7316_show_DA_AB_Vref_bypass(struct device *dev,
 		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_AB));
 }
 
-static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
+static ssize_t adt7316_store_dac_ab_Vref_bypass(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -982,12 +982,12 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(DA_AB_Vref_bypass, 0644,
-		       adt7316_show_DA_AB_Vref_bypass,
-		       adt7316_store_DA_AB_Vref_bypass,
+static IIO_DEVICE_ATTR(dac_ab_Vref_bypass, 0644,
+		       adt7316_show_dac_ab_Vref_bypass,
+		       adt7316_store_dac_ab_Vref_bypass,
 		       0);
 
-static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
+static ssize_t adt7316_show_dac_cd_Vref_bypass(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -998,7 +998,7 @@ static ssize_t adt7316_show_DA_CD_Vref_bypass(struct device *dev,
 		!!(chip->dac_config & ADT7316_VREF_BYPASS_DAC_CD));
 }
 
-static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
+static ssize_t adt7316_store_dac_cd_Vref_bypass(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -1021,12 +1021,12 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(DA_CD_Vref_bypass, 0644,
-		       adt7316_show_DA_CD_Vref_bypass,
-		       adt7316_store_DA_CD_Vref_bypass,
+static IIO_DEVICE_ATTR(dac_cd_Vref_bypass, 0644,
+		       adt7316_show_dac_cd_Vref_bypass,
+		       adt7316_store_dac_cd_Vref_bypass,
 		       0);
 
-static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
+static ssize_t adt7316_show_dac_internal_Vref(struct device *dev,
 					      struct device_attribute *attr,
 					      char *buf)
 {
@@ -1041,7 +1041,7 @@ static ssize_t adt7316_show_DAC_internal_Vref(struct device *dev,
 		       !!(chip->ldac_config & ADT7316_DAC_IN_VREF));
 }
 
-static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
+static ssize_t adt7316_store_dac_internal_Vref(struct device *dev,
 					       struct device_attribute *attr,
 					       const char *buf,
 					       size_t len)
@@ -1082,9 +1082,9 @@ static ssize_t adt7316_store_DAC_internal_Vref(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(DAC_internal_Vref, 0644,
-		       adt7316_show_DAC_internal_Vref,
-		       adt7316_store_DAC_internal_Vref,
+static IIO_DEVICE_ATTR(dac_internal_Vref, 0644,
+		       adt7316_show_dac_internal_Vref,
+		       adt7316_store_dac_internal_Vref,
 		       0);
 
 static ssize_t adt7316_show_ad(struct adt7316_chip_info *chip,
@@ -1644,13 +1644,13 @@ static struct attribute *adt7316_attributes[] = {
 	&iio_dev_attr_da_high_resolution.dev_attr.attr,
 	&iio_dev_attr_enable_proportion_DACA.dev_attr.attr,
 	&iio_dev_attr_enable_proportion_DACB.dev_attr.attr,
-	&iio_dev_attr_DAC_2Vref_channels_mask.dev_attr.attr,
+	&iio_dev_attr_dac_2Vref_channels_mask.dev_attr.attr,
 	&iio_dev_attr_DAC_update_mode.dev_attr.attr,
 	&iio_dev_attr_all_DAC_update_modes.dev_attr.attr,
 	&iio_dev_attr_update_DAC.dev_attr.attr,
-	&iio_dev_attr_DA_AB_Vref_bypass.dev_attr.attr,
-	&iio_dev_attr_DA_CD_Vref_bypass.dev_attr.attr,
-	&iio_dev_attr_DAC_internal_Vref.dev_attr.attr,
+	&iio_dev_attr_dac_ab_Vref_bypass.dev_attr.attr,
+	&iio_dev_attr_dac_cd_Vref_bypass.dev_attr.attr,
+	&iio_dev_attr_dac_internal_Vref.dev_attr.attr,
 	&iio_dev_attr_VDD.dev_attr.attr,
 	&iio_dev_attr_in_temp.dev_attr.attr,
 	&iio_dev_attr_ex_temp.dev_attr.attr,
@@ -1684,15 +1684,15 @@ static struct attribute *adt7516_attributes[] = {
 	&iio_dev_attr_enable_smbus_timeout.dev_attr.attr,
 	&iio_dev_attr_powerdown.dev_attr.attr,
 	&iio_dev_attr_fast_ad_clock.dev_attr.attr,
-	&iio_dev_attr_AIN_internal_Vref.dev_attr.attr,
+	&iio_dev_attr_ain_internal_Vref.dev_attr.attr,
 	&iio_dev_attr_da_high_resolution.dev_attr.attr,
 	&iio_dev_attr_enable_proportion_DACA.dev_attr.attr,
 	&iio_dev_attr_enable_proportion_DACB.dev_attr.attr,
-	&iio_dev_attr_DAC_2Vref_channels_mask.dev_attr.attr,
+	&iio_dev_attr_dac_2Vref_channels_mask.dev_attr.attr,
 	&iio_dev_attr_DAC_update_mode.dev_attr.attr,
 	&iio_dev_attr_all_DAC_update_modes.dev_attr.attr,
 	&iio_dev_attr_update_DAC.dev_attr.attr,
-	&iio_dev_attr_DAC_internal_Vref.dev_attr.attr,
+	&iio_dev_attr_dac_internal_Vref.dev_attr.attr,
 	&iio_dev_attr_VDD.dev_attr.attr,
 	&iio_dev_attr_in_temp.dev_attr.attr,
 	&iio_dev_attr_ex_temp_AIN1.dev_attr.attr,
-- 
2.54.0

