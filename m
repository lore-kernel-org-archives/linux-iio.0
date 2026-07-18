Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF52C21F1
	for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784361043; cv=none; b=r5Lg0xT4We2M5m9IuFeW+2YBdkZiEMoZ+JxMwNcVs9sLLiqDJAiNChkOYTg4qhzbO8+NNM2f+LePEWXqIxH7LbCM3im/dTpmqhAvOga3T8KkaE9Jo09LMxuUhNw7cQqGpid8Cz2ExBBJfFid1TxGdshP/KsgKKwQXb49YUNbndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784361043; c=relaxed/simple;
	bh=gy8PFLftQdi21+SU+Q3p/8r8TWSzS3vDI9YIvfJSDu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ISDn/i6ETblWpi7m35+0cJYlLkBGj1OnwQDDwyZFCFuirgibzsw71CCmcHrIUNFm2BBdcgpczmsu3OkPjNtwhMqA/cqXhCRhEuSWTx7zProz0k/3ttshBsf+o4Io5mie9/BR0P6WUWqJ9oCixICxN5WSiusixGXSbyBL3EVbUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhK1+tHj; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhK1+tHj"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso5881634a12.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 00:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784361041; x=1784965841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PzCo3k1Bxl99xio9k4SN7aS6QcizNh1S7ZH6FAX6MJA=;
        b=EhK1+tHjhAKKNGTORy0gRqhYaYPcGYjWh6/mrjwGHhLKHTvrLlQOl7RTgmtTvfT1om
         33ktr9aj4hqb0MXKxYTt9yS6tow2ApU4INMhZyIgq8iHTnCuxpQdCp+r7gj1iBHiBTIC
         wMKEvK7Gqh/f+DnCdgPuWX++VG8YYKlXXQ+vlbs0pm6cahqMDVwCccYyyqm3kjwPKE7l
         OAbbcL4Z5E05Yk+Zrrvo+++CQu4jP0LGpdv9AA1DqXuijvCnr4L2GqA9XWB/GtBTur5k
         a8K9Uxbip4PVC2ncdKlIbXJ1n9lyvAaKMlym9F8FQsn/zuUFqhWjUSqy9j0OhG+ukLwC
         x0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784361041; x=1784965841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PzCo3k1Bxl99xio9k4SN7aS6QcizNh1S7ZH6FAX6MJA=;
        b=L/v6AhLnxs9dSrooEdt5Xcuguq2tl/cVdVHTi1kbVHeZmCWvATqm2oCTyCRdYfdXfG
         1zmRYlYs1REOxkFR8LyZvuGjBkrQTDBHkokikErUal2ssM5dx6V1oaeaWWLohmZ6/eKS
         CPQ+KNN4jY6JX4bedYJdx0ujkNcXPNfMZ+95pdXQGgbnrpRjuAdctATAmAUXN/ij0T3y
         dkW7CyaAkZM7wcjNKqo3dswDAB0Jdqk4DMnwy/Ur1z6XJgOIKiJsTqcfXnc1LeTc+f+c
         gNgdmVfMnctc4mu9IzVfN2lVkPYYrKDv6miOCBNbYn/3mCRXpvA5J5+FC7xlBvHXQ4G7
         G2vw==
X-Forwarded-Encrypted: i=1; AHgh+RrQIgZHQe98d4ruM7nNksfjC4fJPGdcDneV0DqM5nB9nF9meCOwpvXtJIUj7Eyx97Cnawjh7P7DmBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+x9nb2wIz5tAaumpJWJTyzka0UWXXPQUVs8cx0IanHNk4j7f
	AwjVhwducbHQ/BXq2iVgmhTz21oHhcAPfMIET0CxPHXvhDoIj0o/p9bn
X-Gm-Gg: AfdE7clhL2oKXmoi96qWUk9SiRlfPY48lxgpDDUUf0hWeDCrIwEjaJW1uyqzzKRbJWD
	oJ5SECYn0bduURTirhSt2WzVbLhAg/smBUDHXO4KrVxjed6ZSfBm7vhbguUJB+GiL6Onm4QRIbc
	C0clKu4+XXRRr/mnIkWrT0Kpoz5F1xicQe6GdtGTwL5dr2LeSolM78hFA4Fth5hwuw6VI4xIn4c
	q6kdYSx937iyRTIsSc/esII8ti5JpyKx3wPGE00HquhTNm/2nwAAJdELiWrvd2aJFvgX+88Qt72
	dcEDPL7oRKTu9/BTVYDAZGZiCKpm3Pklasa88kHq8xEEdvHQWTQXaGIETlAsb4jETZSAjfxVEaJ
	SrlVndIuz2BSVamIxw0T/3j0OJEXXNK2lN2SzRQMoPq78y7haV6BpL1ADOzBqmdI3usdV9nGnMz
	h6JMkJVH3QqXa4gMDHY8REYL4DLKaMcdVaGZ1gkhIjrE9LQ7Lc5pWN
X-Received: by 2002:a05:6a21:1f8d:b0:3c3:68a5:50b3 with SMTP id adf61e73a8af0-3c3ad9d9809mr6773067637.57.1784361041550;
        Sat, 18 Jul 2026 00:50:41 -0700 (PDT)
Received: from debian.ari ([152.56.157.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20bf96sm14354220eec.28.2026.07.18.00.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 00:50:41 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH 2/3] iio: adc: ti-ads1015: use local device pointer in probe
Date: Sat, 18 Jul 2026 13:20:15 +0530
Message-Id: <20260718075016.27750-3-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260718075016.27750-1-architanant5@gmail.com>
References: <20260718075016.27750-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a local device pointer 'dev' in ads1015_probe to
avoid accessing &client->dev repeatedly.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index d95efb870bde..0232a4ca2d77 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -937,12 +937,13 @@ static int ads1015_probe(struct i2c_client *client)
 	struct ads1015_data *data;
 	int ret;
 	int i;
+	struct device *dev = &client->dev;
 
 	chip = i2c_get_match_data(client);
 	if (!chip)
-		return dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
+		return dev_err_probe(dev, -EINVAL, "Unknown chip\n");
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -978,15 +979,15 @@ static int ads1015_probe(struct i2c_client *client)
 					    &ads1015_regmap_config :
 					    &tla2024_regmap_config);
 	if (IS_ERR(data->regmap)) {
-		dev_err(&client->dev, "Failed to allocate register map\n");
+		dev_err(dev, "Failed to allocate register map\n");
 		return PTR_ERR(data->regmap);
 	}
 
-	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ads1015_trigger_handler,
 					      &ads1015_buffer_setup_ops);
 	if (ret < 0) {
-		dev_err(&client->dev, "iio triggered buffer setup failed\n");
+		dev_err(dev, "iio triggered buffer setup failed\n");
 		return ret;
 	}
 
@@ -1018,7 +1019,7 @@ static int ads1015_probe(struct i2c_client *client)
 		if (ret)
 			return ret;
 
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
+		ret = devm_request_threaded_irq(dev, client->irq,
 						NULL, ads1015_event_handler,
 						irq_trig | IRQF_ONESHOT,
 						client->name, indio_dev);
@@ -1032,16 +1033,16 @@ static int ads1015_probe(struct i2c_client *client)
 
 	data->conv_invalid = true;
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret)
 		return ret;
-	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
-	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
-		dev_err(&client->dev, "Failed to register IIO device\n");
+		dev_err(dev, "Failed to register IIO device\n");
 		return ret;
 	}
 
-- 
2.39.5

