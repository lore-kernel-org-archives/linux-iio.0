Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56D33E348
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772994566; cv=none; b=AQdZJ0r70QeVGS+Ytx4ruF1y9o1mE5SXH1qKHf94EI5CLc6vd009WvZjm2riki5JvqNO9xWwetMJGGfGI87yR/BSAtxdsyx25BFi6D3/UDCFvEFZurr/R13u5OAbliMxggAhjPfAK0XCDfgiK3DvtldLq4QEmSBWjWoj9/FmRvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772994566; c=relaxed/simple;
	bh=PjYmpT+k/BWReQwno+eCz8dspA5NeFBxuH/Bl2Dhj5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NT5q1axfdX+DvSRFac1hiGRAyo2QVtKiwQXZXybzlXWXnqMR9LTlD+lzV3pRJjzsX5Jw+IR47YSyUWeTh0nzXJejSDRSwaf3DsAoorXVif48ds7gDon8NhUvVywInzLFHeE6TfCBTqxRox/coFejlODYo0K2nbNOGRGHr3ctrtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTp5seSQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTp5seSQ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ab077e3f32so47907365ad.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772994563; x=1773599363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYPf0gJQ1Xt4/WFQtvodMValHNTAraDsvu+wn3lhBJc=;
        b=GTp5seSQJ2cEgXnMysOTqfHRDrgjBKKltYnsHHBPXpluMLFtxa4x62SnGJe5L6ytI2
         AEjPUPvJptN/J+3obiTvmo+GZfPHe3Qw4p5dhQnhV+PGxQ9D0tEpQz6BIF6Am7ol6YG7
         b6eGA/XCfEp9EvOr92iebdY6gOxlTyRshq/wuvSdmSai5H/3P1y6LyyAG+btn8cWfRQf
         nCwUDeNQvl5HMXBEctK7h32jMtToWzTyHEFpRGaUB37thNUu1Kbv/38lqUSMNn0I9pPS
         2umgHor1KJTGZaNnja14QQl0Adw6rSF+79mnzqWMXOg59WK9yrqktf2EmXGu3tCu4sJU
         M0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772994563; x=1773599363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYPf0gJQ1Xt4/WFQtvodMValHNTAraDsvu+wn3lhBJc=;
        b=FCkjGN14zYEPCQQuFYYOTZ/DVISDGj+0QzD72V84rTpgZ+hp40ZZtqAcxsQsMi62Gf
         JQ8k5YeAy30ku2tIZkZSS+Lo0ggOkbz14iRDP3oYGnlJMIZrZ/ukZUGRXhvLd5NPF+LF
         irg2fZID5uMHl1NYMRrea8Pd7KNSh3OxwwIFCn014doqU4AG5IFuBHbZjOFkT4ZGBJM/
         ct+Z8qW/B6FTFZVpvO/lBUmv7PS+tOu6wdaXSAi1gEAZrbRFazk4twrPKDMogWNqXSGK
         Bq7gzOkW7ZBpmtW02XsT35pJ9PRW0GMnZtmpiHKVUSq9LMfHeOsFUKRgJvk/fpNtUItS
         Yd3w==
X-Forwarded-Encrypted: i=1; AJvYcCXT6WLYoxgFFB7qxjAWUHneim1XhaNEovIfsG0IlV9y3ehCyZZamUj4VkW+RsdRb0B5wfahfdVhYps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMmRcgbIEvk4cN2dwrE5Y2hR8WIwssCbnoYLr0fn8dAVFcRVdo
	CPB/hzo7mMYVdUDqItXt+ptufzr8QGPwjhjjcNM+Ub/i2nAd330V5wCd
X-Gm-Gg: ATEYQzwXnH5FwfuvO6A+N46RD1tXHO/DUrJj529eaM46aIC3Vd8lKBQIduStvjHrLdn
	HGCIX/RWPTl2BarHzaM4SgCfWQzsRu4GYu50dyzlogtU/sK30JgXLRfkh4GGEoN2ogzDIghaRzZ
	y/JSkQr5N72PcfZJsvhWvjWAZ6/NoR6APJSL8FG0qBrmsx9vX7oQ8dyiDmnPY5SH3bBDrs3p6WO
	MlY2g6CT2XuSFJ00aA6KPrUtQjI0DH49MJxI7ViQwLSaOMGKOPG2e00ZyMVWimd+lct1Gob0woI
	QGII+2eH8zFv17bc/qw7RljaT5U8itLDhLSPEdi5HAkDFNbpmWtO2soQ57FDZOGc0ls9bJJ1Hqe
	k9WQWNU4panWMb/km3KFmKjoz9Yt3VlQ4t1fseofUfBIQ1maIG5W+bFJrUE8+5DFWmZxDBBJJM4
	x6HaxatBtQOSNV4d9RgHlWZQuhupknIUb5+GJvUc+z
X-Received: by 2002:a17:903:3bc7:b0:2ae:3bb2:a8cb with SMTP id d9443c01a7336-2ae825046e0mr83539535ad.40.1772994563230;
        Sun, 08 Mar 2026 11:29:23 -0700 (PDT)
Received: from debian.ari ([152.58.179.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f783dbsm89006965ad.42.2026.03.08.11.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 11:29:22 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 3/4] iio: adc: ad799x: use devm_add_action_or_reset for regulators
Date: Sun,  8 Mar 2026 23:58:10 +0530
Message-Id: <20260308182811.33471-4-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260308182811.33471-1-architanant5@gmail.com>
References: <20260308182811.33471-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the manual regulator_disable() handling to use
devm_add_action_or_reset(). This guarantees that the regulators are
disabled in the correct reverse order of allocation during device
teardown or probe failure.

As part of this conversion, introduce a local device pointer to
simplify function calls and remove redundant goto labels for regulator
cleanup, as the devm framework now handles these automatically.

Suggested-by: David Lechner <dlechner@baylibre.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 46 ++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 28f1901698a6..f5ef6ff97c89 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -773,8 +773,14 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 };
 
+static void ad799x_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ad799x_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	int ret;
 	int extra_config = 0;
@@ -783,7 +789,7 @@ static int ad799x_probe(struct i2c_client *client)
 	const struct ad799x_chip_info *chip_info =
 		&ad799x_chip_info_tbl[id->driver_data];
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -799,7 +805,7 @@ static int ad799x_probe(struct i2c_client *client)
 
 	/* TODO: Add pdata options for filtering and bit delay */
 
-	st->reg = devm_regulator_get(&client->dev, "vcc");
+	st->reg = devm_regulator_get(dev, "vcc");
 	if (IS_ERR(st->reg))
 		return PTR_ERR(st->reg);
 	ret = regulator_enable(st->reg);
@@ -807,31 +813,38 @@ static int ad799x_probe(struct i2c_client *client)
 		return ret;
 	ret = regulator_get_voltage(st->reg);
 	if (ret < 0)
-		goto error_disable_reg;
+		return ret;
 	st->vref_uV = ret;
 
+	ret = devm_add_action_or_reset(dev, ad799x_reg_disable, st->reg);
+	if (ret)
+		return ret;
 	/* check if an external reference is supplied */
 	if (chip_info->has_vref) {
-		st->vref = devm_regulator_get_optional(&client->dev, "vref");
+		st->vref = devm_regulator_get_optional(dev, "vref");
 		ret = PTR_ERR_OR_ZERO(st->vref);
 		if (ret) {
 			if (ret != -ENODEV)
-				goto error_disable_reg;
+				return ret;
 			st->vref = NULL;
-			dev_info(&client->dev, "Using VCC reference voltage\n");
+			dev_info(dev, "Using VCC reference voltage\n");
 		}
 
 		if (st->vref) {
-			dev_info(&client->dev, "Using external reference voltage\n");
+			dev_info(dev, "Using external reference voltage\n");
 			extra_config |= AD7991_REF_SEL;
 			ret = regulator_enable(st->vref);
 			if (ret)
-				goto error_disable_reg;
+				return ret;
 
 			ret = regulator_get_voltage(st->vref);
 			if (ret < 0)
-				goto error_disable_vref;
+				return ret;
 			st->vref_uV = ret;
+
+			ret = devm_add_action_or_reset(dev, ad799x_reg_disable, st->vref);
+			if (ret)
+				return ret;
 		}
 	}
 
@@ -846,15 +859,15 @@ static int ad799x_probe(struct i2c_client *client)
 
 	ret = ad799x_update_config(st, st->chip_config->default_config | extra_config);
 	if (ret)
-		goto error_disable_vref;
+		return ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		&ad799x_trigger_handler, NULL);
 	if (ret)
-		goto error_disable_vref;
+		return ret;
 
 	if (client->irq > 0) {
-		ret = devm_request_threaded_irq(&client->dev,
+		ret = devm_request_threaded_irq(dev,
 						client->irq,
 						NULL,
 						ad799x_event_handler,
@@ -876,11 +889,6 @@ static int ad799x_probe(struct i2c_client *client)
 
 error_cleanup_ring:
 	iio_triggered_buffer_cleanup(indio_dev);
-error_disable_vref:
-	if (st->vref)
-		regulator_disable(st->vref);
-error_disable_reg:
-	regulator_disable(st->reg);
 
 	return ret;
 }
@@ -888,14 +896,10 @@ static int ad799x_probe(struct i2c_client *client)
 static void ad799x_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ad799x_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 
 	iio_triggered_buffer_cleanup(indio_dev);
-	if (st->vref)
-		regulator_disable(st->vref);
-	regulator_disable(st->reg);
 }
 
 static int ad799x_suspend(struct device *dev)
-- 
2.39.5

