Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9D3F39DF
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 17:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866848; cv=none; b=tdivO/pLtrEuneC0gmggyoxEenVzqLJqTXAT9bkl8kmIO0LF+PvKjR9yXf/tyxeUX4VvG9Y1Ng0Xr2w1GKN6GYyHa604H7zMz77vUqove+BCtQtDVgpre16ZEmzv2ARvWB75jsTrS4AzJHQ8sx9je6rNIqmts24W7Z6XcVAifLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866848; c=relaxed/simple;
	bh=QpOYFv8tYMRTdnNISpiGdgVYHufG68uVcQwITa5shwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J4Qjwx4Me2TIyb2fBzWOUtQX/V/BqOzUdvc1Glsn/ECurVTSoHMNjTY4DmEvBgx4jCgGm1gm5lrq5cW1U9uh/YS2TbEN3e5Wu4phfX+L/d6VWVIpcUoSGkHMvp++2NF1IVrSEf/FRJhWXU6yJlmUa8dsLqrlnGzEJFXyFJjZWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LysmruCW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LysmruCW"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso75017b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866846; x=1779471646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcTs3eLyOIE0l5GPVRit0A4+HMRVxCXis7Msp6YvA7k=;
        b=LysmruCWLLA+qeUSFHWT3o8XBjJYByrhpoRtqpxx5eV3mpG8Na61N9NWiA68QVUP0k
         u+SnKMZv2F6mGeVJVIxUSJ4fzyotGhMm70br/l8k9GqkYsMC7/pcXj9nO41m4GeFP8ar
         1tgy/Yh/MQBlrWYHXJqxfrTkeyatne8783CjDV969FW3IhjEZ+2S6EYYPjHAah3z22AE
         6uC1r0cwUneqYwvbIsAUZU78d4wnWCqGxQ29+i2CfC85/Wy9Y94M24UmNdUYqeciBmhx
         +chXlfs0IeDo6YBi7BwnW0iH9qDyKTbrv+Cmngrmn715V4pta8fyzGUI0+Vn8rQEw+/I
         oIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866846; x=1779471646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fcTs3eLyOIE0l5GPVRit0A4+HMRVxCXis7Msp6YvA7k=;
        b=Yu0CJwrhY/Nlrbas1Jgwv75LtA1BUwCG5fVAzYLGNhBjADS0UZaTb7SphhpAT9iuj+
         d+upEvXlVfwwvFfi7xE/mNICeewrmCLGBlXa5qm+Z1BvvtMByCNsxD2mKvVBxlMxqY6u
         O5XDij7u890zFknXVb3+KjRDlCWlXwzdevTZ7w/ig6K2Fcg29giWzJ4YlyCVIK/dGvLg
         ge/3Yd8MnZZNU46m69UQjENfaOoaPBWO1NlUZpvmgEgs+6fg2S3hQ9eVHKQqmB8Tk6Jy
         7Y1/z8VigCW2s8QK4HUNt+KuiIPfImtvz7kL4gTM2/zfmcBwxf+u15pvq8SSQGcTiSTV
         rA1w==
X-Forwarded-Encrypted: i=1; AFNElJ9DlN25e+LY6P23U/bHZclWSamcqoO5/FPvlYwhmzRhm8TRPSV2xAz2kfzU5JVqtBNJsn0+PdWTEyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcMxOErbQdSiZ9GQGLmg/1la8mX2tW9NY2CiHj6mv9SItIqgZ
	osvIoI3O5QwYE7s0r9XzBpXmXW48FDeiRb+wwhoO/K5/nGgcIOlttiFd
X-Gm-Gg: Acq92OG+vpdJ0gJpGSSR7/dbuOKtwQMlCRXdj8K45O6MD35YR0N70OE44JKr4wKB2a7
	ja2qy+WwgsTcxFezlJDwWeXs+aVSKlStZVQFFYYyp5D6qRBqidnT6dYNO9JxmCKC7zmYXmn45Pj
	CrOaQyhyuj8PXcGUqDveqJUqzXzTh1/FqjZTu3B3qnjFrFd68gbOq7Yus/+v84U8YiHZtsF/v+4
	n8yJywvIXUT0tbJctyhilnDCf9XoJrVP0/ex58DQT2Nhl9jPVdLPv1+98oJuWELXvQINHt9yJF3
	s86AvfG0LqKENB9N6Ccxn2LFNTE3LHmpaH7uwfRQRvxzB1pyVzw8rN4abboNxcUaX0wPR+XLfWb
	JTbtV8faGS2GUxy37HsTxn4Zt1JXWGKr2YcWAutitZ9owiWBlXgjgG3I8j/NDIMzn2wCvxRNiHf
	5ySpqiA3rT6Lm85cGH++8pfA6eW8QX0QsE2WK7Z3pj39aDhCCMKLUlEq92QSY=
X-Received: by 2002:a05:6a00:4f8f:b0:837:b5b6:1b98 with SMTP id d2e1a72fcca58-83f33c7aef6mr5385845b3a.12.1778866846467;
        Fri, 15 May 2026 10:40:46 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2875f0fbsm5579034b3a.57.2026.05.15.10.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:40:46 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	tglx@kernel.org,
	christophe.jaillet@wanadoo.fr,
	mingo@kernel.org,
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/12] iio: ssp_sensors: use local struct device
Date: Fri, 15 May 2026 23:10:10 +0530
Message-Id: <20260515174017.3962168-6-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515174017.3962168-1-sanjayembedded@gmail.com>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Introduce a struct device *dev derived from &spi->dev to improve
readability and drop redundant "Probe failed!" log in probe path.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v8:
- Following input from Andy and Jonathan don't mix variable reorder
  with new variable addition and drop redundant log
- v7 change: https://lore.kernel.org/all/20260426091710.3722035-6-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 4280eb590c03..a652bb56c61f 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -487,27 +487,28 @@ EXPORT_SYMBOL_NS(ssp_register_consumer, "IIO_SSP_SENSORS");
 
 static int ssp_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	int ret, i;
 	struct ssp_data *data;
 
-	data = ssp_parse_dt(&spi->dev);
+	data = ssp_parse_dt(dev);
 	if (!data) {
-		dev_err(&spi->dev, "Failed to find platform data\n");
+		dev_err(dev, "Failed to find platform data\n");
 		return -ENODEV;
 	}
 
-	ret = mfd_add_devices(&spi->dev, PLATFORM_DEVID_NONE,
+	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 			      sensorhub_sensor_devs,
 			      ARRAY_SIZE(sensorhub_sensor_devs), NULL, 0, NULL);
 	if (ret < 0) {
-		dev_err(&spi->dev, "mfd add devices fail\n");
+		dev_err(dev, "mfd add devices fail\n");
 		return ret;
 	}
 
 	spi->mode = SPI_MODE_1;
 	ret = spi_setup(spi);
 	if (ret < 0) {
-		dev_err(&spi->dev, "Failed to setup spi\n");
+		dev_err(dev, "Failed to setup spi\n");
 		goto err_setup_spi;
 	}
 
@@ -543,7 +544,7 @@ static int ssp_probe(struct spi_device *spi)
 				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				   "SSP_Int", data);
 	if (ret < 0) {
-		dev_err(&spi->dev, "Irq request fail\n");
+		dev_err(dev, "Irq request fail\n");
 		goto err_setup_irq;
 	}
 
@@ -557,11 +558,11 @@ static int ssp_probe(struct spi_device *spi)
 	if (data->fw_dl_state == SSP_FW_DL_STATE_NONE) {
 		ret = ssp_initialize_mcu(data);
 		if (ret < 0) {
-			dev_err(&spi->dev, "Initialize_mcu failed\n");
+			dev_err(dev, "Initialize_mcu failed\n");
 			goto err_read_reg;
 		}
 	} else {
-		dev_err(&spi->dev, "Firmware version not supported\n");
+		dev_err(dev, "Firmware version not supported\n");
 		ret = -EPERM;
 		goto err_read_reg;
 	}
@@ -574,9 +575,7 @@ static int ssp_probe(struct spi_device *spi)
 	mutex_destroy(&data->pending_lock);
 	mutex_destroy(&data->comm_lock);
 err_setup_spi:
-	mfd_remove_devices(&spi->dev);
-
-	dev_err(&spi->dev, "Probe failed!\n");
+	mfd_remove_devices(dev);
 
 	return ret;
 }
-- 
2.34.1

