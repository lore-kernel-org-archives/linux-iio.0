Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0709937883E
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430183; cv=none; b=CXV753s+G8G5jcYUWhizcpuezSx+Cq8Dox1lyM/v5ecZg6aMiVyaMKNmijWZvZc7zml9LPGqTXO9yZZgMEXePK1Kj/V6JyvszC2+7DxEFdMkT2m0xO2KISRNn8KQGkBPmmWp2wNTeCqJ5Yj3mbBigmoeOm46wQ5YpaaAgGrVJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430183; c=relaxed/simple;
	bh=t/PYPN/FNxWeoIy07qENKLtWK5VFABvTmes/ubhCSGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/91dHSIzHofiwO4fYZ1NlBSWQla6qFcYMhzPv3tVvru2yi2PvoAP9VoDK24+cq5oDq88GwUiolYiAjZeVoVRbTPnunekVLrjpaG2nDLjx9Fz6xiBCv/HPAke0+F7c33taJ50v6nULmHxg1aENSp5RB6hKnHEZ4W2s+4UV4/2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8Iv2O5p; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8Iv2O5p"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad617d5b80so3793565ad.1
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776430181; x=1777034981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vruBcRB4ust+Byaj+7nyfLxpyKyFagHRqNw2VFcgzW4=;
        b=n8Iv2O5p0wMIajY1naMuns0uwwWieA3QkSU+eRdZaRfA0FGft+26EW264mENtUjIoa
         dV3ukdLhMGLsyjKh7pPXFwJnmtK/CPj63DtHXBeLe9ln9dRiMhJLYcFEKOowu0aKq/0r
         XMak9K8ZvRAK7DJYJTYF/9pPoppOjm3gJDNXCTWFL/fYmEfhBgq4l3plwcnSkgRbC0Qo
         UkHqUIQIjMkKf7ljbSZqAbZTuIWGhs5BVygZejvpU9HJlOwCnVsn5fnOVhRqXUr0HK4O
         TieQ+dHKbkfjDurrweRqvw4s2d3YRiUB4DEBV6Lz1i1F4W9zgJltKU4vmOd76QGpckoX
         ZFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776430181; x=1777034981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vruBcRB4ust+Byaj+7nyfLxpyKyFagHRqNw2VFcgzW4=;
        b=I74OJV5Blb3Zf+hxZeod9SlS/6VSTdvzU6ijDx3ol2PDNcaG4U5DAaB+coL97FzHwj
         /M+H7zJcTzEMkvvXVUQfrw9kyVaL3Ow4KxHafyeSrG29yqZjlnucwPK+zBGegR81KQ52
         IlURk+lqc0U4WnDau9Q2CbrFlPSAJx+btQwbKZtxXQnR7xfM7Kuaoe+QESJ6RFKoz664
         fZeM083GKakc5wFF3U1h9V7wCjQaqj2tvNuK5nLi0eO3aR0YJviXhdr4DrTeNor2F6di
         eYlMpXVifXwFOqibkVkOYD8OJF3ZUp7IF0dh5I3zV4xMsZv8TE8C4nXe2YvwElhCQKwt
         E1NQ==
X-Forwarded-Encrypted: i=1; AFNElJ8vk5A7rLUnzm9HFNOY/b/WLgMQAs3ecjYJYsvbWAOYUQMXJEfL+Tj5X3eUVK/Hnt85Q0i/pMV4UrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysgQemZzKjluHuB5iuY54g4C9HKsQGi9ozNOuL7gYcaacxOEqN
	uo/kxYhrz9oo4IV+d8dTpUQs7MNVr9zdOZ0UKb2NNp85Zp5uUn49zjAfrrJr0g==
X-Gm-Gg: AeBDies3w65KZUsNURMu4wA8XPx6v7sxeHQVg8T71BSt2QyxPZxGJNNBt2Lut97x5KD
	lHcRtORMk5apLK0AXh5WyJgNSbMym9t1mLOiZQsb4uGWXA0WBvA66ZUIjZJvZn2YTUY21xEsPD7
	D/9YmynoeTssDuwg2bmTL2e1IgqcP3qUO/uuYFM/4RKgTOgi+llOCF0cIaWImQX3OCSZxaXkS9B
	YvVpF26zAShUaj3QuMteo1uxl8R39LxTafj479GRDcv50mQnrgHseGlP3DpOsiyhb0y7E9E6dws
	+cOHeHZammKYpJTvei9Hf5dTOz/18gL24u3A59QJpMHI+Zhr9HXlqdpnrD+1uMUbSER3ewniyQZ
	C0ILqUEDdV7kJNBiKaQprtL5Mgq1tqxj5yK3pfWgfXzgsy2EsxAv9u7skeIAym4y44j8BA8kUvi
	j4LynLG3Q7Bp7QiMf4Bf8cJvIrzeCLzNMoUhGTgjvT5KoUm7gMm8wITHCKa4k=
X-Received: by 2002:a17:902:8e82:b0:2b0:b41e:c5c3 with SMTP id d9443c01a7336-2b5f9f6710bmr21491155ad.29.1776430181197;
        Fri, 17 Apr 2026 05:49:41 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cb92sm19428855ad.50.2026.04.17.05.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 05:49:40 -0700 (PDT)
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
Subject: [PATCH v2 2/8] iio: accel: adxl313: Use dev_err_probe
Date: Fri, 17 Apr 2026 18:19:18 +0530
Message-Id: <20260417124924.353189-3-sanjayembedded@gmail.com>
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
 drivers/iio/accel/adxl313_core.c |  6 ++----
 drivers/iio/accel/adxl313_i2c.c  | 10 ++++------
 drivers/iio/accel/adxl313_spi.c  | 10 ++++------
 3 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 1fc96b7b0f1f..6dc918c4ae17 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -1252,10 +1252,8 @@ int adxl313_core_probe(struct device *dev,
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
index b67ff0b4dc54..6736b83f23bd 100644
--- a/drivers/iio/accel/adxl313_i2c.c
+++ b/drivers/iio/accel/adxl313_i2c.c
@@ -65,6 +65,7 @@ MODULE_DEVICE_TABLE(of, adxl313_of_match);
 static int adxl313_i2c_probe(struct i2c_client *client)
 {
 	const struct adxl313_chip_info *chip_data;
+	struct device *dev = &client->dev;
 	struct regmap *regmap;
 
 	/*
@@ -75,13 +76,10 @@ static int adxl313_i2c_probe(struct i2c_client *client)
 
 	regmap = devm_regmap_init_i2c(client,
 				      &adxl31x_i2c_regmap_config[chip_data->type]);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Error initializing i2c regmap: %ld\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Error initializing i2c regmap\n");
 
-	return adxl313_core_probe(&client->dev, regmap, chip_data, NULL);
+	return adxl313_core_probe(dev, regmap, chip_data, NULL);
 }
 
 static struct i2c_driver adxl313_i2c_driver = {
diff --git a/drivers/iio/accel/adxl313_spi.c b/drivers/iio/accel/adxl313_spi.c
index dedb0885c277..555c11b68421 100644
--- a/drivers/iio/accel/adxl313_spi.c
+++ b/drivers/iio/accel/adxl313_spi.c
@@ -70,6 +70,7 @@ static int adxl313_spi_setup(struct device *dev, struct regmap *regmap)
 static int adxl313_spi_probe(struct spi_device *spi)
 {
 	const struct adxl313_chip_info *chip_data;
+	struct device *dev = &spi->dev;
 	struct regmap *regmap;
 	int ret;
 
@@ -83,13 +84,10 @@ static int adxl313_spi_probe(struct spi_device *spi)
 	regmap = devm_regmap_init_spi(spi,
 				      &adxl31x_spi_regmap_config[chip_data->type]);
 
-	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Error initializing spi regmap\n");
 
-	return adxl313_core_probe(&spi->dev, regmap,
+	return adxl313_core_probe(dev, regmap,
 				  chip_data, &adxl313_spi_setup);
 }
 
-- 
2.34.1

