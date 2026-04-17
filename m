Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A36338A72D
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430197; cv=none; b=NPka7rMF2o3tc0cbayTIHeUJZCuCHbB0oEbxh/D8Pm1HtObbZN8qaJ4iYekRke8QEd9noXMrMGK3hZoBrn4/Cee/n3W30XK5M7lTg0pU5uGg6US47N9BCQMgovI7qGGp9zFF+3BPSDDx73v70TdupMsa7It/A6nkBbDWBdRZd7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430197; c=relaxed/simple;
	bh=tnK53EaNGIBDfxbMBE4Ggz3ws+Vp5qfLWDMmlxLbTkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BW4OiojwVGPj+POiytLiySwW9/D1110jvA+h2rgBoz+iZ9ytT+8xc0GeT7ZLgeCyzwG2zlaGnH8iVwC612PCx8J2H8i8lKgp61xpXxHMjKWdESxgnGOivj2pGXekv5PmMpXbShO18Rv3Yl77ezHk1tdaCiBNmVf2K1q//wVeonk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMyEaOZj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMyEaOZj"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b24fede2acso3929185ad.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776430196; x=1777034996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnRZcX1V5Mt/WiCCq9xYJmYuZ/r7Obi0LyG4op6I5lM=;
        b=eMyEaOZjBv1zdiemUC++B5YWJChQRD13zT9nF6VnXkZ9Ygd9/k00Vp7s3192rIj01U
         Thh0LZ4V/E4PM1OSCPcAAtrg/YXDb1WkxtGmteBVk1zWwcBp2jtLXKy298fua1iqbQ9V
         UQi1e0c/QhLslUy8pAuZhkSeu460utVT3YtOU5Ozy5jVlsBSY84dwW48kLrx278nig7n
         5BemLmYiMA/F3pkZ74Bjl8UnY6vR0kWtpeaad3V+gJjCFSq67GhgP8nszPWYxR5ECoHG
         5XaF66H32O62k9bLMPB5gZRZFolD3zVwMwSPcEksAfn+ELDP2rGGfKlF/F8RrV6NxpSS
         B7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776430196; x=1777034996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XnRZcX1V5Mt/WiCCq9xYJmYuZ/r7Obi0LyG4op6I5lM=;
        b=HYI1xVtbXarhwVgcKSnnGpPFbxj7oB4qX8pHTct9DhlMTE24gfURdFcLb691imIT/n
         8F23RgXVz3JGsZ+1NCqQ9NOIETAMahg+UG79zZny8s20iJ9jxGuqQTRnlci74cPv/dGx
         hXfz+2etflwIB0J7Nrn8lF9+j8H295hknw9N9ywY2c9JXG12OBxPurwvHK9aRiqOSAG7
         jLGZO7kDHIEVn+L6+gQ8RM5vMByztEkv3lgqmEvjlx+DzJmYuMXQkGfjxtZdsKxqwejT
         TgWL0/9Xz6wq1V5bXVvHXlJYWSyy48hUi7cv76UHJgVYOz6hiHfyugGjGNXk7BZVl3ST
         AvOw==
X-Forwarded-Encrypted: i=1; AFNElJ/L/FFMAEomHgOpkxzMCf183i3j6LVmPSgWi0WW721Uzj8dbttGXmSFrYuvy5txrs0vpUYpjmomIyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4LpR3PHxvGS8zwKx67Bdb4UbxyB/71WZAX+OL99JoNoO14EPn
	27uFB2YR7rbr0gGjQEQ6d4g3ckWrQSAC/NiWzDOzxG6xpnZ2r8WogULGu6oVQw==
X-Gm-Gg: AeBDietQyaGp2L6um2iqbLClMNC8sIDsArJLbpQZ1GRynS7U1znYJw3oRuun7OoIqz3
	bhkDUU1tPSX1Ku+YZNaqzeVkNUntYbX9XWESAL6n480bK9JyPeZrlCsJKvBqa8ECnmJMWk/RYN5
	HFtEgYDIjZANQQ+tfftcuIr8niCjDYB+GJFO8X0LqzIVEePifjamlzI1ph3q6ycbphD9D/VucYs
	o5PEtt/RaD01keFbNSl3Wh6H3q7K1rjXoAK/MlWo9MeYxbZGUhq0LdCLIWtv53Ge+8zpuVF/fNL
	ujZeFsn7kETS9dY9arLgSU53i4F6KwxZKOE1B/CmmVSmkQbKkVcxZ9iwdr1QBYEByZV6bCSPzXt
	mAwXc+VcN7+5zmsP85UsT7IXO5wDncAOSjrrAngJNutVcoAPj1ZJ4iRASLoFT++ek3UC0IRAxuZ
	j7C8xLf1dWZYt1pvFTBtwsudwJDGiXpYutUxgZ8qE2Jsp3I33AldLmF1VhmtM=
X-Received: by 2002:a17:903:bd2:b0:2b2:ccfb:8387 with SMTP id d9443c01a7336-2b5f9f534d9mr23127615ad.28.1776430195669;
        Fri, 17 Apr 2026 05:49:55 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cb92sm19428855ad.50.2026.04.17.05.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:49:55 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	puranjay@kernel.org,
	cosmin.tanislav@analog.com,
	marcelo.schmitt@analog.com,
	antoniu.miclaus@analog.com,
	ramona.gradinariu@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] iio: accel: adxl355: Use dev_err_probe
Date: Fri, 17 Apr 2026 18:19:21 +0530
Message-Id: <20260417124924.353189-6-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417124924.353189-1-sanjayembedded@gmail.com>
References: <20260417124924.353189-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

dev_err_probe() makes error code handling simpler and handles
deferred probe nicely (avoid spamming logs).

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/adxl355_core.c | 24 ++++++++----------------
 drivers/iio/accel/adxl355_i2c.c  | 11 ++++-------
 drivers/iio/accel/adxl355_spi.c  | 11 ++++-------
 3 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index a310f8e37e3d..03e5744d9667 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -336,10 +336,8 @@ static int adxl355_setup(struct adxl355_data *data)
 		return ret;
 
 	do {
-		if (--retries == 0) {
-			dev_err(data->dev, "Shadow registers mismatch\n");
-			return -EIO;
-		}
+		if (--retries == 0)
+			return dev_err_probe(data->dev, -EIO, "Shadow registers mismatch\n");
 
 		/*
 		 * Perform a software reset to make sure the device is in a consistent
@@ -775,10 +773,8 @@ static int adxl355_probe_trigger(struct iio_dev *indio_dev, int irq)
 				     irq);
 
 	ret = devm_iio_trigger_register(data->dev, data->dready_trig);
-	if (ret) {
-		dev_err(data->dev, "iio trigger register failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(data->dev, ret, "iio trigger register failed\n");
 
 	indio_dev->trig = iio_trigger_get(data->dready_trig);
 
@@ -814,18 +810,14 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->available_scan_masks = adxl355_avail_scan_masks;
 
 	ret = adxl355_setup(data);
-	if (ret) {
-		dev_err(dev, "ADXL355 setup failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "ADXL355 setup failed\n");
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      &iio_pollfunc_store_time,
 					      &adxl355_trigger_handler, NULL);
-	if (ret) {
-		dev_err(dev, "iio triggered buffer setup failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");
 
 	irq = fwnode_irq_get_byname(dev_fwnode(dev), "DRDY");
 	if (irq > 0) {
diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
index 1a512c7b792b..19490a6e1f35 100644
--- a/drivers/iio/accel/adxl355_i2c.c
+++ b/drivers/iio/accel/adxl355_i2c.c
@@ -23,6 +23,7 @@ static const struct regmap_config adxl355_i2c_regmap_config = {
 static int adxl355_i2c_probe(struct i2c_client *client)
 {
 	struct regmap *regmap;
+	struct device *dev = &client->dev;
 	const struct adxl355_chip_info *chip_data;
 
 	chip_data = i2c_get_match_data(client);
@@ -30,14 +31,10 @@ static int adxl355_i2c_probe(struct i2c_client *client)
 		return -ENODEV;
 
 	regmap = devm_regmap_init_i2c(client, &adxl355_i2c_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
-			PTR_ERR(regmap));
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Error initializing i2c regmap\n");
 
-		return PTR_ERR(regmap);
-	}
-
-	return adxl355_core_probe(&client->dev, regmap, chip_data);
+	return adxl355_core_probe(dev, regmap, chip_data);
 }
 
 static const struct i2c_device_id adxl355_i2c_id[] = {
diff --git a/drivers/iio/accel/adxl355_spi.c b/drivers/iio/accel/adxl355_spi.c
index 869e3e57d6f7..347ed62b6582 100644
--- a/drivers/iio/accel/adxl355_spi.c
+++ b/drivers/iio/accel/adxl355_spi.c
@@ -26,6 +26,7 @@ static const struct regmap_config adxl355_spi_regmap_config = {
 static int adxl355_spi_probe(struct spi_device *spi)
 {
 	const struct adxl355_chip_info *chip_data;
+	struct device *dev = &spi->dev;
 	struct regmap *regmap;
 
 	chip_data = spi_get_device_match_data(spi);
@@ -33,14 +34,10 @@ static int adxl355_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 
 	regmap = devm_regmap_init_spi(spi, &adxl355_spi_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
-			PTR_ERR(regmap));
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Error initializing spi regmap\n");
 
-		return PTR_ERR(regmap);
-	}
-
-	return adxl355_core_probe(&spi->dev, regmap, chip_data);
+	return adxl355_core_probe(dev, regmap, chip_data);
 }
 
 static const struct spi_device_id adxl355_spi_id[] = {
-- 
2.34.1

