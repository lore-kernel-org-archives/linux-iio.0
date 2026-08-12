Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E93471263
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553120; cv=none; b=Y+I8N4p95gK/FV57NXlD10X2gmeNpd00RS6FOLxuKjBsbnoD49gOzmVNc9htk3ccBgJufI7A3gY2boOeOCPTYK5VzPJLZFZS1uezgm0isfll0QVqRHi8x+yRkxUYh4S0qVPV9euCIJoSr9VpT/SwElSndNiKRK52ibt2LfibIn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553120; c=relaxed/simple;
	bh=4fFAtjCq/gogDR/iC9hbCXAyAB0YwdsmCUxXp71uC5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g59ZW4R8WIEYf1fgmmiIU+E6gBEY/rX6LQdlav/TgYPxAwNEgel9/+9Axd2FY307OpnfsMa54fZ3uhMKmWGDQE44Fvcs0nyHBfJomCqxP+irhadWiMtWVPOpaKV6K8KfmWHoctxLwsgFTnWUTdcTpzwsJulN/HU41hJM2+Zxdt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rtEVsdzE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtEVsdzE"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so1274871a91.3
        for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786553117; x=1787157917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GUVQGwAdKK76pB/K5waiwIxZzAwMiKqICZUp2BwS6s4=;
        b=rtEVsdzET4uPL4PY739QC4x72zbkalA86Ntqjf/fYi12sRDitDYE95vhiJUMtLlPTg
         R/LK+HE9CMdacJoj1Ag1UAyMSzyLoeYHQBfxcJ7Lq6UxjnGVDddCgKQH4q4aEZLk99tV
         AKewmOpyRPbhZVQ8qeYWvm99N1GITMK//lt2hVDyjN45HpxHrhoQW8PNus3XwENgTbs4
         52dFhss7F6/4hNnG9QLieZGBdHa0GAxJsawyRYnJj81NeGdyd/L1jIm1tLXiQT0czHTW
         9dcONbzozFhFz5C2P5z5a+x5EQ0/rkNGCotqCi/0rEbY1oqxZSa3dfdtwOKvO8plSyhR
         jSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786553117; x=1787157917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GUVQGwAdKK76pB/K5waiwIxZzAwMiKqICZUp2BwS6s4=;
        b=CnxLcvRc6hK9jzisR6WM/T3tmgH3D4cPZV9DSnT/74becdcUQL3LFVBhsClGvOLnGr
         7neRIOzEP87a/ewZtl/pGzY0l5u8vHzsq9WQSs+t/WcvZKqauRmEViVdii0Vhf+0oFGd
         ErerRFThFIqFH/oCPZ2mwlfJoZ5whskAlPfxl4s6AP3BhlYZyqdVOSAKtuQKKzevLlHN
         4tlqwwiI5ewA9edC280c/FpHhvbWb2WQRMzw4w8JOmJO004AUNsH3NfH3iBXTw0QC6aW
         SD2025JKCZUFOo1PfwElIEm62W9TWLfHUPeh8YO6N6n0rV3w+d0Z0E3peHJiUXCwJHPj
         JRrg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3dIvAnHzv6jDieaB/k1e5Ji+DKFC5dG9S49OqfDfVynHl5BccXAR4SgNM96huaodh9He3oIQsYAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQU/sD4DO6SvG8h668IdAaxDErhoHhz8iwLsPPnHw0B8xn3Ax3
	7KRyDsb3XxIOGkFrjhagIm6KtTfJq1pYk5D+PSXSDY1O0Q77fHO+BC8y
X-Gm-Gg: AR+sD11CYqxuGYSxGENP8CfMtKOEDRYSABNX365SBslvbzxaMTKouh36QsRbOHUP35/
	iLp9GU+oiCoFXJjYCT6f0AKyuk9l7msAVczWh8Lxmeu/fjlNKfoDnMP3cGO8UeWI9YrwmSGWwD5
	SDDUSLP07QJwjPZdgHXXrOcCouWv3z0zlJUQ1WFAcq6KIN5wIGwj9PD+msJUfg4p0u6NPh7+P/e
	aUMxw8DT233p7h/w/NJy9mv3Ilozx/LTEou9E18jgy0KmqD0MNVJVYs7dni2lptOIyaMXB6rAZu
	lsgYb5L9f61b9v4RiOH536XKNnEfxy81neJfJQv55eHnbOYGXiTy+98ES/lpLP3E70ogqssGIRG
	DP4t1rFBWKHf6X4/QaTtFp81kmzlrC+/8kLVdO+34NSxdAxFlIDQ51ZtWvHlCsFyivEUp1Hg9Ve
	AkANKnPbOsPB2Lol4dp7W7g4+JenCXIn50YFFkolthl9msqfpl4fdQbAlajkfcX8R8UQjh749zi
	POOm5O/AMVgVAAbvaFQzVL8VIRvOatmkGA=
X-Received: by 2002:a17:90b:540c:b0:381:3b5d:30f4 with SMTP id 98e67ed59e1d1-3930124d1b0mr7207591a91.1.1786553117024;
        Wed, 12 Aug 2026 09:45:17 -0700 (PDT)
Received: from debian.ari ([47.30.26.35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf40f7151sm12462621eec.12.2026.08.12.09.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 09:45:16 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v3 6/8] iio: adc: ti-ads1015: convert to fully managed resources
Date: Wed, 12 Aug 2026 22:14:31 +0530
Message-Id: <20260812164433.23011-7-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260812164433.23011-1-architanant5@gmail.com>
References: <20260812164433.23011-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the driver to use devm_ allocations and power
management, allowing for the complete removal of the
ads1015_remove()

Key changes:
- Use devm_add_action_or_reset() to ensure the ADC is safely powered
down upon driver removal.
- Move to devm_pm_runtime_set_active_enabled() to manage the runtime
PM lifecycle.
- Convert iio_device_register() and mutex_init() to their devm_
variants.
- Remove the thus obsolete ads1015_remove() function.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 43 ++++++++++++++----------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 895bce7859d2..f92ec5941c47 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -928,6 +928,11 @@ static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
 				  mode << ADS1015_CFG_MOD_SHIFT);
 }
 
+static void ads1015_power_off(void *st)
+{
+	ads1015_set_conv_mode(st, ADS1015_SINGLESHOT);
+}
+
 static int ads1015_probe(struct i2c_client *client)
 {
 	const struct ads1015_chip_data *chip;
@@ -948,7 +953,9 @@ static int ads1015_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 
-	mutex_init(&data->lock);
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->name = ADS1015_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1029,42 +1036,25 @@ static int ads1015_probe(struct i2c_client *client)
 
 	data->conv_invalid = true;
 
-	ret = pm_runtime_set_active(dev);
+	ret = devm_add_action_or_reset(dev, ads1015_power_off, data);
 	if (ret)
 		return ret;
+
 	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_enable(dev);
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		pm_runtime_disable(dev);
-		pm_runtime_set_suspended(dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed to register IIO device\n");
-	}
 
 	return 0;
 }
 
-static void ads1015_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ads1015_data *data = iio_priv(indio_dev);
-	int ret;
-
-	iio_device_unregister(indio_dev);
-
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-
-	/* power down single shot mode */
-	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
-	if (ret)
-		dev_warn(&client->dev, "Failed to power down (%pe)\n",
-			 ERR_PTR(ret));
-}
-
 static int ads1015_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1147,7 +1137,6 @@ static struct i2c_driver ads1015_driver = {
 		.pm = pm_ptr(&ads1015_pm_ops),
 	},
 	.probe		= ads1015_probe,
-	.remove		= ads1015_remove,
 	.id_table	= ads1015_id,
 };
 
-- 
2.39.5

