Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0EE213E89
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283142; cv=none; b=dWpzw9NMlzKyKuw5HnLt7hseY4Eab5csvRXmT91RUnn3dALIJQahICiB8rulQKSMUzDq6C2tJS1ULE7yfDlfZyUxGGrDS98Z8DmzXPJPb8PGM9r8knDcKT7VeQnLYTLTjKcbDMv+a+ci+lh1HxWzVJEWs/Payw1Zv6RDDN5OJbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283142; c=relaxed/simple;
	bh=5SBDIrzGAQEBhEnuVBvjyWjW+cvgWc+5Dhaw9jOzesI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AlhRfiw9TQnJ8rV7ARA3h4B0XewGdN1Wp9yQGGUHG2G4Ytz83iRJLt2eTFehcSQR+5hVyKzxNsVberf/yaoJdeG5kcw9eSDpHYk8NMIq7MeXFk8hWf9Gg9mJUtNwvUr4QR3tq5psL68ckbqrdg/8y7THZU4YL5wHo85HT3Tc/b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pyX+UMUT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pyX+UMUT"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b042c0759so437220f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 06 Oct 2026 03:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791283139; x=1791887939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0PKrnSSgSMY6ZmA5twi9Nx86W77c8h087WtIxcCKmQ0=;
        b=pyX+UMUTHn7PFHouaOVd5uID28UVxhEMuLqB0ZTWeMIiEL/lxyseo2TsVxQ+SsTo38
         Fe8CiATIwr6F39IKuDhjJGeTpfb1Ma3UIRAP0DK2HQROEXXGqjnl3eh7SNPg0B6oCGUR
         yxNe3JhaHg/+iaLHGseu7IMcUw3dwOd4I9mn3VH60JygeTtTtFdThMqePXYi4iz4rB41
         5iEv6iKE+JlLuBYSgvzLGFFoeNE02RyXrXuFB4CsIz1rR5W96WwnekHVuCKYTeNsSn11
         rtuTeDRSmyrdfqXUGVXxBe4v5NgYoG/AiuNvwakkbuP7EFT7FptA2cOw11y1Z4/sLHCO
         okuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791283139; x=1791887939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0PKrnSSgSMY6ZmA5twi9Nx86W77c8h087WtIxcCKmQ0=;
        b=qLaPV71BcJkGmyxbUnDeMPCDTpFahD+ZKNexjl51NtPNwBUz/Grb7rjv2AvQ/a2NLH
         sFw7dOJeHJd/4eGX6GsWkVN9ukQHkl+jnjvzEUmerOykmTcEdz6xMV6RLDrk1F1hcRq0
         P7CFBXTplndH68WlpJw5kdDhuA8VKD+KLJPhrdV4/alC4uBZ4xz3fKqrUYwud901A6AX
         89dhDIfu7d6UtKM0A3J/UnkPoDiGsO2c2pAcBJNIj/OC+7SE9dGzvbrQ93vFfgMEIC10
         Z9m6a5ZFt1niq2+CIDqbrMRe5owlaYdGRC4zpErAqAVjhGil/1eJ0O+lO7oL/adw2uzE
         80YA==
X-Forwarded-Encrypted: i=1; AKwUvBwQs1sb4yDLkm42Spe4C7xojVpebqJ66UMr0vTWXzEoWqmwsJLp0YI1J/8TQpK2h6W61odYZa1Dxjg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOdceN7nqEF9xD4CbjAeUQ1Qr11QyaN592UhEJhZa9rA1Z8NCl
	0zMTnVwuMrGrwIbdNn5Z3gRaITnMVg0DSpZFTHpkVzcJbWUXXcyXA/2+
X-Gm-Gg: AYBFou1GeGi7CTqKvhIM7/QJJViszNRBtyYB2YI0ZXiOIi2XouImCq0U8V3fHu9d0Ke
	PYde74L+e59vJr9Gc9hc5LDXE5iWiHBjIdvDzHDPBwnuwQp1fCB6xed9oDglRDn25f0vtSwK6t/
	PLrUN9vGRhUKE2wizoE+SI59o21cG3NhtubX6F5YWziiDZwKsh++VXOBxgDkNW/FGUOLe+tx3m2
	t6wChvzPwbIw9D/ieU4byNcDkEGZLa9WX91TDEv5jLO41EQPjNSZojV3/grI7CU0nE22bM2d/Bd
	pENEse7v1ANVqbNxC3DYf5YSdMbB7igtiW16q28hF/UsQbGJSA6UiqYNu5Yy+tqtDvRuFOfm9rS
	vOJDRbnWhO7RGZDfeZBudxgMZ8WEDWPvdRHxctLsRKAtlR8cbDwiFKx5qtu7VerwWprfVTMqIr0
	l3f1/aMEOdo5EuuoBUAGEGx095Jonc1CtWqXueCLw2VzPwERa2vUiBizi5CNxWGNx6PSdVtM1hD
	is32roTzEI9gxym9y0=
X-Received: by 2002:a05:6000:298e:20b0:485:8a47:5b91 with SMTP id ffacd0b85a97d-48c6d1ee143mr1211829f8f.46.1791283138652;
        Tue, 06 Oct 2026 03:38:58 -0700 (PDT)
Received: from fedora ([154.183.153.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c6cd717f8sm2526963f8f.48.2026.10.06.03.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:38:58 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH] staging: iio: adt7316: use kstrtobool() for sysfs boolean parsing
Date: Tue,  6 Oct 2026 13:33:50 +0300
Message-ID: <20261006103350.32853-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual and unsafe character checks (e.g., buf[0] == '1') with the
standard kstrtobool() API in sysfs store functions. This ensures proper
handling of standard boolean inputs, fixes potential safety issues, and
adheres to the Linux kernel coding style.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 94 +++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 20f6052cc7fb..21a1b811a142 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -246,12 +246,12 @@ static ssize_t adt7316_store_enabled(struct device *dev,
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
@@ -285,13 +285,18 @@ static ssize_t adt7316_store_select_ex_temp(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config1;
+	bool req;
 	int ret;
 
 	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
 		return -EPERM;
 
+	ret = kstrtobool(buf, &req);
+	if (ret)
+		return ret;
+
 	config1 = chip->config1 & (~ADT7516_SEL_EX_TEMP);
-	if (buf[0] == '1')
+	if (req)
 		config1 |= ADT7516_SEL_EX_TEMP;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
@@ -482,10 +487,15 @@ static ssize_t adt7316_store_disable_averaging(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config2;
+	bool req;
 	int ret;
 
+	ret = kstrtobool(buf, &req);
+	if (ret)
+		return ret;
+
 	config2 = chip->config2 & (~ADT7316_DISABLE_AVERAGING);
-	if (buf[0] == '1')
+	if (req)
 		config2 |= ADT7316_DISABLE_AVERAGING;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
@@ -521,10 +531,15 @@ static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config2;
+	bool req;
 	int ret;
 
+	ret = kstrtobool(buf, &req);
+	if (ret)
+		return ret;
+
 	config2 = chip->config2 & (~ADT7316_EN_SMBUS_TIMEOUT);
-	if (buf[0] == '1')
+	if (req)
 		config2 |= ADT7316_EN_SMBUS_TIMEOUT;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
@@ -559,10 +574,15 @@ static ssize_t adt7316_store_powerdown(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config1;
+	bool req;
 	int ret;
 
+	ret = kstrtobool(buf, &req);
+	if (ret)
+		return ret;
+
 	config1 = chip->config1 & (~ADT7316_PD);
-	if (buf[0] == '1')
+	if (req)
 		config1 |= ADT7316_PD;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
@@ -597,10 +617,15 @@ static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
+	bool req;
 	int ret;
 
+	ret = kstrtobool(buf, &req);
+	if (ret)
+		return ret;
+
 	config3 = chip->config3 & (~ADT7316_ADCLK_22_5);
-	if (buf[0] == '1')
+	if (req)
 		config3 |= ADT7316_ADCLK_22_5;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
@@ -640,13 +665,18 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
+	bool req;
 	int ret;
 
 	if (chip->id == ID_ADT7318 || chip->id == ID_ADT7519)
 		return -EPERM;
 
+	ret = kstrtobool(buf, &req);
+	if (ret)
+		return ret;
+
 	config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
-	if (buf[0] == '1')
+	if (req)
 		config3 |= ADT7316_DA_HIGH_RESOLUTION;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
@@ -685,12 +715,17 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
+	bool req;
 	int ret;
 
 	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
 		return -EPERM;
 
-	if (buf[0] != '1')
+	ret = kstrtobool(buf, &req);
+	if (ret)
+		return ret;
+
+	if (!req)
 		config3 = chip->config3 & (~ADT7516_AIN_IN_VREF);
 	else
 		config3 = chip->config3 | ADT7516_AIN_IN_VREF;
@@ -728,10 +763,15 @@ static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
+	bool req;
 	int ret;
 
+	ret = kstrtobool(buf, &req);
+	if (ret)
+		return ret;
+
 	config3 = chip->config3 & (~ADT7316_EN_IN_TEMP_PROP_DACA);
-	if (buf[0] == '1')
+	if (req)
 		config3 |= ADT7316_EN_IN_TEMP_PROP_DACA;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
@@ -767,10 +807,15 @@ static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config3;
+	bool req;
 	int ret;
 
+	ret = kstrtobool(buf, &req);
+	if (ret)
+		return ret;
+
 	config3 = chip->config3 & (~ADT7316_EN_EX_TEMP_PROP_DACB);
-	if (buf[0] == '1')
+	if (req)
 		config3 |= ADT7316_EN_EX_TEMP_PROP_DACB;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
@@ -967,10 +1012,15 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 dac_config;
+	bool req;
 	int ret;
 
+	ret = kstrtobool(buf, &req);
+	if (ret)
+		return ret;
+
 	dac_config = chip->dac_config & (~ADT7316_VREF_BYPASS_DAC_AB);
-	if (buf[0] == '1')
+	if (req)
 		dac_config |= ADT7316_VREF_BYPASS_DAC_AB;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
@@ -1006,10 +1056,15 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 dac_config;
+	bool req;
 	int ret;
 
+	ret = kstrtobool(buf, &req);
+	if (ret)
+		return ret;
+
 	dac_config = chip->dac_config & (~ADT7316_VREF_BYPASS_DAC_CD);
-	if (buf[0] == '1')
+	if (req)
 		dac_config |= ADT7316_VREF_BYPASS_DAC_CD;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
@@ -1969,10 +2024,15 @@ static ssize_t adt7316_set_int_enabled(struct device *dev,
 	struct iio_dev *dev_info = dev_to_iio_dev(dev);
 	struct adt7316_chip_info *chip = iio_priv(dev_info);
 	u8 config1;
+	bool req;
 	int ret;
 
+	ret = kstrtobool(buf, &req);
+	if (ret)
+		return ret;
+
 	config1 = chip->config1 & (~ADT7316_INT_EN);
-	if (buf[0] == '1')
+	if (req)
 		config1 |= ADT7316_INT_EN;
 
 	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
-- 
2.54.0

