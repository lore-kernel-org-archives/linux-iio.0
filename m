Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E0F4AE12C
	for <linux-iio@vger.kernel.org>; Wed,  7 Oct 2026 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381148; cv=none; b=OlMHiPXImSS9R1DQFbWWaj/eV1b16ggjwGZ4hV+w4qkRudx928S1/KXwcDmGLVEpcqEHkK3Ch+ZKC3r+4JMUzJn8riIWITymwnjW5r1b07KGOkASbWuxCUFMqUR6IBOOVI7HlLAetpuAwBf++s91wQvw2BYd9x9LJ0O2TDSWtp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381148; c=relaxed/simple;
	bh=gGwjSvl+z9pW6bbPCaaNS0klvdQ7vWn6BaNEIaLW0xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCJiqEinuRElEryavtBmIRGu9Mq4KFHnzgG5ZTdnT1ZNw8UmTIeaPki2nzwg6Ev0es+VpOAZCQ4Pac3EGusO5jDHhs88dkq6s0mLXC9hRAUUh/jchqI0C/gEq8gqKdXJGdiztUcRbm+wLiQVlKFkCCD3wxGWQYqqDWg1HGTYk1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3vmzwBt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3vmzwBt"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b0946c2c2so1312546f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 07 Oct 2026 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791381128; x=1791985928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aMm89ZuMFRUcykpwHvtlCEKlZZULqgCCXLBJZNe/c4Y=;
        b=i3vmzwBtV0mZhg+8DgXJ3bvE0p+8BQKU6i2n8rlN18EPzT6MC7YfLH6x0d2JLLVUx/
         gyX100cj2xhKF6J/bJZyWxYRVXx4cjtSYispW1sGrBufI8IOlFE5ebU5sd4bw4uU7xma
         yR5B4iSWNFlvvEIA9rq4t7YhY9Wn081QG49GRKfZVvXGRs8PM5lJ4fBSVLxBLmEB0vkx
         F10VYxtE3K/jFUHkrAFuY11r0ZrvAI2QUdmuEPC5I93/QMXAbxfiPHRSuKXrl6iRlNga
         aL77GK6pER7MKb7ZglvSB8peNTiLkABcYq6u83R5wIFakHJj3qhH0+v8Wuf/FeB+EMGO
         6AWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791381128; x=1791985928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aMm89ZuMFRUcykpwHvtlCEKlZZULqgCCXLBJZNe/c4Y=;
        b=swA02PyQPRI4Hwv3dSQTm5Es8P9ezOSHMhUpPdz3tte4fQkO8j0OD9loIEXOcBv3ve
         yq7HNRVKY6pOp15BtxZ5I3yR8Jjwqi1K7jZ6517Lp9vTfkVR02hDFX0YrRSu9DKtOj4G
         S9BXdMiLXWvD73YxUdguU+YHoJWDbss12ugolpX+dfjS7S1Wpcvh+Ub1LedM4TQdgmqD
         yF5w+GmQiBcSiRgK86RRZ/mExqqo4CenHFBR1RyAm0FKlIxAuHnZBoJjxKf8dld7UpIY
         KL9ke4x1PMwvlOBHkw0n+2zlYbKH56doKoRSXi6tPY1DDre8ego4BbvIPigq7Q/6tzUT
         hjqA==
X-Forwarded-Encrypted: i=1; AKwUvBzNqvbfoDqkYIqs+19sZcOIhok9+YhiWC3mjLCHmKvktW7hQuK7Z4PWiYyGM1mTgOiFTxtXBsXZmWI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6RFgrWeE8HquHkOCZFZaLI6aOYRzEnTyUrSFJbqPy+MonVPIU
	MgMebF8CgDDfFII/wJCbB5y69Kr19IjeefSP0J5UM7CJ8NHxVL2D4e1r
X-Gm-Gg: AYBFou3RkZC3KqF/QoF5DAaOzjbT6F7laWGn9UnQZkDtnFk/vgUVcS3x2bZj0oHnL6/
	g3xEGxu3XAjCo3ENDY2eKRn/amAFmzTWqKkW3AGkiZN+YFPfWwWV4wB+VaHJq/UbuRLttmPcBKL
	HKV/QFaT4SsBNy8+JCKMNrbVr7arV7OlC3lWzuvW84hDxRHrJvySDvoKLIyHFNKeJMxfmjg7hBD
	110mmHco8a7SzMIrDhygTxiCIvBPuQ77f1dAypFbhmiUpvP3KkyCj4MLpUMOWCarrx5+87c4KVB
	ZNKAh3xudQdP6CrvkydsxZLPHci+I+cQls07zjjJR3WWQGYV168SxMOPjUG/VdsY4PnhVKEwnDq
	/I5ORwytVn/vUfDexUQr7PjoJPZh8VC7o1/nCZzf3PnXVuni5CQ1FoHn5Afeg30sueKuGo/3Cbs
	geUt86XxhGfvv5aaMzDRf+cb07IhFxMGWKXoeo4emHwoxJc/0jHToiWAavJIT2NMKK2eRX+OMoN
	BumwikPXWgLFdKVtyyegavvBoya3Q==
X-Received: by 2002:a05:6000:128d:b0:48c:7161:43e3 with SMTP id ffacd0b85a97d-48c72889494mr3126374f8f.54.1791381127670;
        Wed, 07 Oct 2026 06:52:07 -0700 (PDT)
Received: from fedora ([154.183.153.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c75b4e399sm3651658f8f.56.2026.10.07.06.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 06:52:07 -0700 (PDT)
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
Subject: [PATCH v2] staging: iio: adt7316: use kstrtobool() for sysfs boolean parsing
Date: Wed,  7 Oct 2026 16:51:51 +0300
Message-ID: <20261007135151.11780-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual and unsafe character checks (e.g., buf[0] == '1') with
the standard kstrtobool() API in sysfs store functions. This ensures
proper handling of standard boolean inputs, fixes potential safety
issues, and adheres to the Linux kernel coding style.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
Changes in v2:
- Included <linux/kstrtox.h> explicitly as requested.
- Renamed the boolean variable from 'req' to 'val'. (My initial thought was 'req' as an abbreviation for 'user request', but 'val' is much clearer and avoids any confusion with block/network requests).
- Added Reviewed-by tag from Joshua.

 drivers/staging/iio/addac/adt7316.c | 95 +++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 20f6052cc7fb..719261cfce9e 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/rtc.h>
 #include <linux/module.h>
+#include <linux/kstrtox.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/events.h>
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
-- 
2.54.0

