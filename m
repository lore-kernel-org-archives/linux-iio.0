Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911A13446AB
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776316614; cv=none; b=EecPf0Tuso6spmnJBeQBCCIjEgEnPhB/QrsOnO27c4klEbd5vY/ejQuMNeEPgCP7xtfhpX2o1kO1jm1a6kZKi/sVj+OtaeHDdPFOgEKBJClEP+5N/eaSdUfLLKRAfu5mQQ02SLhrilPW9ooRR9RTyKYBGFnfKg73xeovErzwqUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776316614; c=relaxed/simple;
	bh=UKSSe1/e50TTEiAHIlvcerCNjjv2hXqo6dnk/WjKCyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFryLga9my9CvH1EjH8YIIRlraw8p24Fy7V4rSeefJ2UvB4asZe9NANa6BfTzJ4XZHB6yPodcaVgyNN6mOut7sY+CfxQZi4S4L3eyxB3CpXmZlyqSGRrkR+ivT8vAuO2U7n2pKQnY7uybW+lgfj5gbh8j0C2OWu+TK8ug6GDEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0ZuuIvX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0ZuuIvX"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82418b0178cso3906823b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 22:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776316608; x=1776921408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLshPt1Skm2DtadDEq1VBxK5b4P4BIol5EeO2Icx+Go=;
        b=g0ZuuIvXnZRcD36TLusRPE2mzh/nwAeHzAJL8Z0IwiSDh7FaG6doSXRrHAPRm3vuFS
         IB0i+O1H1VotuodVigrFCiTR5rgfBe4rq+laqf1qcGe2/Ly6MfcCiryf2ZWo9JXoxeJ0
         mgkDWI5/o9Z3Qv8xOGidnevNMWhEfv6cw7NhKRzjTCoMHd5e6YWVc3h7ggBDacasBH8I
         Rc6ktNY/yZ4u4Lni6WdWBqSMxiY0w02mOOfyWDVVzhNQF++zzoHY7/nGnH3bSM2Bdl2J
         f7rv0Y/17bLYiMHLEZ8o9tQyQLPRybihCpMs/MhZ4Hg+uB/Jk2Pk67PkmjJPdnSkElO/
         J6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776316608; x=1776921408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PLshPt1Skm2DtadDEq1VBxK5b4P4BIol5EeO2Icx+Go=;
        b=DVBeN4dIbxA6rnMddzHXuzUjSWJElD2SI0st02LMpDmM0diTj+ACVmKcXeC/RO2FfR
         BEFOeIxohqsyKfjBr5lY0X/XGKj+w4m6Rdz2YKwe1UDsz8gSmpjZ9uXP47F0GgEX5OtT
         1TpYRi81dCQtmMzpAlWaYz2Hx27nxMyCNvt/P3d1yLAlDPej6uQqvMvF9RreYhPpAiCL
         UL918eVOD9qV6Cl3UbZSS83VyLGhnGKtEPLu+LigJTKq13GlVhiUWdFY2ylbkQ8VNV+k
         B7jTFUMFhgZHtfKoM3INkrScJ+QqXI/9RuaFq8VP+7flPFdy9fLVbJyZbtglt+OKWIFH
         zK2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8R+lUiM67jspnTEx0fxjLac7t/vB1LRebzdIth62ckog0P+TSSvpoHOShFZks8dFP6A3/92keTt2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWA+ywaf+JW6eccwU++suLQHWpF5YDq3/h9TwRm4f7Z1FTfvB8
	nadwmw9uaiBSVSg4hMHbJ9jTBjs1395ao0+3IJwSbX8/561nh8x44LdH
X-Gm-Gg: AeBDietxPKIjuSuJS3az68qW8kog2BPlqJkRcIzbrrptHNCaQYm74iCP6NL3uRUtJhJ
	e6BcPYPaWKDebsoqf1EJ7jafQpJRnOaoYGRvdFnJfzTpj2WMNk07RXZ6XQQyIYu1UAyXp9oukVP
	dhj9VqhiDgzih4WfRS5FLOFdIUECQsUCV81SSKt/AesbvzBKoau+FrQE2MRglijwjoTAzHdDvlg
	prcgpnawcSKTIJ36H13ZPUKYTQf5XojlIj2tVV6HO2QJNEG7k4sgUqBZ8rRKPjW9pQUC4QMm1GR
	dPrhB23FdQ5tIXtWQnRBq0+GXdtMbf+lQfoBz145IAqdhggGyeEYp1AB5O6SS6xVIddSDfhb9tw
	CoNt3cfz4m6satgMZoTPGcvjIVESD/9Z8u31zxhse+H7A0quWLNjFvoEgC2vLyYZ/k9XZJJ1UEN
	53S5ofcGQyAT0Pb73RNGDsalOnfjw6lhVOU6sRGgSlkjQdbmbrPXmWfWzrvg8=
X-Received: by 2002:a05:6a00:2791:b0:82a:e3de:27c2 with SMTP id d2e1a72fcca58-82f0c253663mr25800207b3a.41.1776316608014;
        Wed, 15 Apr 2026 22:16:48 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f67476a5fsm3948364b3a.60.2026.04.15.22.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 22:16:47 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: accel: adxl313: Use dev_err_probe
Date: Thu, 16 Apr 2026 10:46:31 +0530
Message-Id: <20260416051631.551250-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416051631.551250-1-sanjayembedded@gmail.com>
References: <20260416051631.551250-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

dev_err_probe() makes error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 6 ++----
 drivers/iio/accel/adxl313_i2c.c  | 8 +++-----
 drivers/iio/accel/adxl313_spi.c  | 8 +++-----
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 339570701083..1e9df5702de4 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -1251,10 +1251,8 @@ int adxl313_core_probe(struct device *dev,
 	indio_dev->available_scan_masks = adxl313_scan_masks;
 
 	ret = adxl313_setup(dev, data, setup);
-	if (ret) {
-		dev_err(dev, "ADXL313 setup failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "ADXL313 setup failed\n");
 
 	int_line = adxl313_get_int_type(dev, &irq);
 	if (int_line == ADXL313_INT_NONE) {
diff --git a/drivers/iio/accel/adxl313_i2c.c b/drivers/iio/accel/adxl313_i2c.c
index b67ff0b4dc54..896d6ee8a3ef 100644
--- a/drivers/iio/accel/adxl313_i2c.c
+++ b/drivers/iio/accel/adxl313_i2c.c
@@ -75,11 +75,9 @@ static int adxl313_i2c_probe(struct i2c_client *client)
 
 	regmap = devm_regmap_init_i2c(client,
 				      &adxl31x_i2c_regmap_config[chip_data->type]);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "Error initializing i2c regmap\n");
 
 	return adxl313_core_probe(&client->dev, regmap, chip_data, NULL);
 }
diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
index dedb0885c277..6a0deea2209f 100644
--- a/drivers/iio/accel/adxl313_spi.c
+++ b/drivers/iio/accel/adxl313_spi.c
@@ -83,11 +83,9 @@ static int adxl313_spi_probe(struct spi_device *spi)
 	regmap = devm_regmap_init_spi(spi,
 				      &adxl31x_spi_regmap_config[chip_data->type]);
 
-	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "Error initializing spi regmap\n");
 
 	return adxl313_core_probe(&spi->dev, regmap,
 				  chip_data, &adxl313_spi_setup);
-- 
2.34.1

