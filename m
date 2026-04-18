Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80855387587
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 14:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776523672; cv=none; b=MWXQcJBzbd27pIlI7XHoGXOYgz59tS1Y9uXDRtg1mAcOd/0AJX8VdbBBnnbC58oINDfyUjhzoq3q6wrOZyS/ut0q6OnU5kevI3+oMmmrr5EbD6knDoJEr4xRTWHdmBqQ6ZrbHwD3g6zu8JBktkTCwdZrrciPbFTAY8JYkHvmmkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776523672; c=relaxed/simple;
	bh=ph482mdUz0pWl0OhYadrfp4dm9vKSDKlVaw1EwDrgLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9nWUb44KMm+Ugjo14iuYUXyHUmHIl9PvgQzRvg0oszdDVjRf+N5j9dONKhZ80wCyA+0UJ0ZIf8yFi9Pgz8HJzdPrA3wsPo1tdGGhe+1Yat2hyWxgwqsv8zSU6uQ8ALEN1wGrCoeCBAADiUyFOO1c0klas9W3lzuARWGysftc6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/aeekct; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/aeekct"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso1922815e87.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776523669; x=1777128469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJ0ZocjWEH0SujlKl/cIeDMBxgBomMJ+ZN9u8iNbXAE=;
        b=A/aeekctnv0Q0F5ZOFiHtN4aqotpscFYLvTQdFf2KD8pirGp6sHbU3bdPJZ121qnxm
         b3Oinian//IwLbH9h6DkQ74S28UnnYTyM2MW/58oaj6In0rXhxjL+EZ7Q2VjtQkYXRZY
         UXepEzGECgGJRF0I42L2S25aUJXlwzN7jmg/POyL6FbHswNJR5OVNiKUN0fqXVPH4rsu
         7DDhKi0IpWPU36hITwaNt6sm7PePfC8w/mZy4zmBkiL5u13ywKLPJd/BwYaBRSAhCWkQ
         sZKaLKAYAzd0ss+0/xgwqr3dZnicUwC91yH18zYlv6r6p7ei0KjqSaRYRlfSWVK6pIGR
         QE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776523669; x=1777128469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bJ0ZocjWEH0SujlKl/cIeDMBxgBomMJ+ZN9u8iNbXAE=;
        b=U3OQ2zn9oVYn8Vi0xHZA+dFXJkANt/WPkNPToUiPPFHRwSfHzmWvMMjUL7QqqD9v0O
         46xsVd9M3QjswZobEfjOnD1FpNYIepYZ53PtRcaDCEMoAPP3GErqhRyBb+PunY+M6GaL
         Kmi9KCd/FTo7ByWnOxxM3RRZTYdte6YEAokh7yw+OnaxUUF9nBnKqYLnk7Ojj6iYl3wD
         7ir26qArv5KfUmQDIUJNVQjua+4ZMKJwoBToiPEGs/CFOVSR2DJXetMUhWgNOk9svOZz
         PXBh8w4h1NLeCWJF2x7U8oghYjfQw8Azw+rJ2Tu8QvQmMbdGUY2ZqvuBvu927I1v5mAb
         mNZw==
X-Gm-Message-State: AOJu0YybplnUsbp4IldJthY8Hip/QXPky8UGuOz+/G42LPkOvP3IqS9G
	tSDqnhePqfoix8MVGQg9JA0l0rKFb5lDXk0uUuG6gvCUUUztSeFtUKCV
X-Gm-Gg: AeBDiesxXemVPyka/XviUS+2TFuBSrjLJn2JS7yVtxli9UvbxZhLBQffj6zUxw9yr35
	SajFZ492m5SwAfw7XK9iufJOpiwU1EINzXydSwZ/1OkVKo9HWutfAXFuEGL8iwNj/hwEAAnWGou
	dw1skdI6DPJ7rpUc3xdEUTASva5Hg07qVnoMF7tvqFfPvpun7SQ6uaYTCCm+qtTzSltI7A3N68n
	q0YbrjXKN9FqTRRMhVtzR9xuSyPXz/bmsjLtWtWpH9twbz6gkLTuO42/74C7yoHdnjCzlvpFZZq
	NU8Sjjz6L/n9aGMPhBeBwgvwWCAdvrfNh35J/TLDfKKvUVps+UfdJFmXBq3lF+o+rfGrXI+WtHZ
	aQNQFBe/KwyqgLDAz3TW9jEElmpIvDboWEjqPd+VNQnYZfD7l1DeRYDqkTCn5+lSWZQ5L1y06hm
	TK19cAyhlAYAMyuMvB9AA1g4DKyGorZuv6Tw==
X-Received: by 2002:a05:6512:6193:b0:5a4:1add:c574 with SMTP id 2adb3069b0e04-5a41addc6aamr1448350e87.5.1776523668435;
        Sat, 18 Apr 2026 07:47:48 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb4f51easm10901001fa.6.2026.04.18.07.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:47:47 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] misc: apds990x: Use more device managed approach in the probe
Date: Sat, 18 Apr 2026 17:47:13 +0300
Message-ID: <20260418144716.132936-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260418144716.132936-1-clamor95@gmail.com>
References: <20260418144716.132936-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes to the driver. The probe code was refactored to
switch to devm_ versions of functions and reduce the nesting of labels.
This is in preparation for OF conversion and platform data removal.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/misc/apds990x.c | 80 +++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 52 deletions(-)

diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index b69c3a1c94d1..742ab331a221 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -1053,9 +1053,10 @@ static const struct attribute_group apds990x_attribute_group[] = {
 static int apds990x_probe(struct i2c_client *client)
 {
 	struct apds990x_chip *chip;
+	struct device *dev = &client->dev;
 	int err;
 
-	chip = kzalloc_obj(*chip);
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
@@ -1066,11 +1067,8 @@ static int apds990x_probe(struct i2c_client *client)
 	mutex_init(&chip->mutex);
 	chip->pdata	= client->dev.platform_data;
 
-	if (chip->pdata == NULL) {
-		dev_err(&client->dev, "platform data is mandatory\n");
-		err = -EINVAL;
-		goto fail1;
-	}
+	if (chip->pdata == NULL)
+		return dev_err_probe(dev, -EINVAL, "platform data is mandatory\n");
 
 	if (chip->pdata->cf.ga == 0) {
 		/* set uncovered sensor default parameters */
@@ -1113,75 +1111,61 @@ static int apds990x_probe(struct i2c_client *client)
 	chip->regs[0].supply = reg_vcc;
 	chip->regs[1].supply = reg_vled;
 
-	err = regulator_bulk_get(&client->dev,
-				 ARRAY_SIZE(chip->regs), chip->regs);
-	if (err < 0) {
-		dev_err(&client->dev, "Cannot get regulators\n");
-		goto fail1;
-	}
+	err = devm_regulator_bulk_get(dev, ARRAY_SIZE(chip->regs), chip->regs);
+	if (err)
+		return dev_err_probe(dev, err, "failed to get supplies\n");
 
 	err = regulator_bulk_enable(ARRAY_SIZE(chip->regs), chip->regs);
-	if (err < 0) {
-		dev_err(&client->dev, "Cannot enable regulators\n");
-		goto fail2;
-	}
+	if (err < 0)
+		return dev_err_probe(dev, err, "cannot enable regulators\n");
 
 	usleep_range(APDS_STARTUP_DELAY, 2 * APDS_STARTUP_DELAY);
 
 	err = apds990x_detect(chip);
 	if (err < 0) {
-		dev_err(&client->dev, "APDS990X not found\n");
-		goto fail3;
+		dev_err(dev, "APDS990X not found\n");
+		goto error_regulator;
 	}
 
-	pm_runtime_set_active(&client->dev);
+	pm_runtime_set_active(dev);
 
 	apds990x_configure(chip);
 	apds990x_set_arate(chip, APDS_LUX_DEFAULT_RATE);
 	apds990x_mode_on(chip);
 
-	pm_runtime_enable(&client->dev);
+	pm_runtime_enable(dev);
 
 	if (chip->pdata->setup_resources) {
 		err = chip->pdata->setup_resources();
 		if (err) {
 			err = -EINVAL;
-			goto fail4;
+			goto error_pm;
 		}
 	}
 
-	err = sysfs_create_group(&chip->client->dev.kobj,
-				apds990x_attribute_group);
+	err = devm_device_add_group(dev, apds990x_attribute_group);
 	if (err < 0) {
-		dev_err(&chip->client->dev, "Sysfs registration failed\n");
-		goto fail5;
+		dev_err(dev, "Sysfs registration failed\n");
+		goto error_resourses;
 	}
 
-	err = request_threaded_irq(client->irq, NULL,
-				apds990x_irq,
-				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_LOW |
-				IRQF_ONESHOT,
-				"apds990x", chip);
+	err = devm_request_threaded_irq(dev, client->irq, NULL, apds990x_irq,
+					IRQF_TRIGGER_FALLING | IRQF_TRIGGER_LOW |
+					IRQF_ONESHOT, "apds990x", chip);
 	if (err) {
-		dev_err(&client->dev, "could not get IRQ %d\n",
-			client->irq);
-		goto fail6;
+		dev_err(dev, "could not get IRQ %d\n", client->irq);
+		goto error_resourses;
 	}
+
 	return err;
-fail6:
-	sysfs_remove_group(&chip->client->dev.kobj,
-			&apds990x_attribute_group[0]);
-fail5:
+error_resourses:
 	if (chip->pdata && chip->pdata->release_resources)
 		chip->pdata->release_resources();
-fail4:
-	pm_runtime_disable(&client->dev);
-fail3:
+error_pm:
+	pm_runtime_disable(dev);
+error_regulator:
 	regulator_bulk_disable(ARRAY_SIZE(chip->regs), chip->regs);
-fail2:
-	regulator_bulk_free(ARRAY_SIZE(chip->regs), chip->regs);
-fail1:
-	kfree(chip);
+
 	return err;
 }
 
@@ -1189,10 +1173,6 @@ static void apds990x_remove(struct i2c_client *client)
 {
 	struct apds990x_chip *chip = i2c_get_clientdata(client);
 
-	free_irq(client->irq, chip);
-	sysfs_remove_group(&chip->client->dev.kobj,
-			apds990x_attribute_group);
-
 	if (chip->pdata && chip->pdata->release_resources)
 		chip->pdata->release_resources();
 
@@ -1201,10 +1181,6 @@ static void apds990x_remove(struct i2c_client *client)
 
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
-
-	regulator_bulk_free(ARRAY_SIZE(chip->regs), chip->regs);
-
-	kfree(chip);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.51.0

