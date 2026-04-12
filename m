Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AAB367F3B
	for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775986709; cv=none; b=PzzagsDnTEwYvPXInf7hJWjCFq1JsRXFd/hWhsZrmKQMbYq+gUsNbWENQfaiRAvg6awsIgZ71muGg1RY9aGo3fQRWR81xOKMgCp3OoNs5jmXoUto9YqNJJ2k4YGVnu08fMLcsp2vmx/hx30khxmBBFmRT1dUYmJUaERs+mnngrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775986709; c=relaxed/simple;
	bh=fKhxy+uUkv7uyoUtuBiGeXl0glQsbzn+BjMiYVG5E10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZngUPS1luvcWBUPUU9FuyhhCCqu6eL74z0HOz3RxZtwxl/CLiPieKdxWbZSFf9kBZNYKmZBENym3HRPrFFJstf11yVManbvT9Q8PaNzl8/IZhMjJQnZoOz1vC0xok//qpQ0gZDiBsPqsMBQq7uFy0BVIUoCF1p9t5Pbj7GXLkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tDMKJSrI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tDMKJSrI"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-824c9da9928so2476999b3a.3
        for <linux-iio@vger.kernel.org>; Sun, 12 Apr 2026 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775986708; x=1776591508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5lS9m0YKF/AhL70UDdpLWZKYq+rkGRCMnHCx58rcr0=;
        b=tDMKJSrIJgC1UC4OoirqjIw8UXeRMvAwFDU6Ul5uiGz2IcoYRx57aeLFykBcj3RJwv
         bq2oGqqKmUpk1h0/hQtlGJ4UM9yulo8DBSrd00DfefHSlFe5v6/4QaXzdBX0391BYPzD
         87r3X31IQBpoDYCJPoLq9oLzfiTktShe+BOXLAy8ABUE7+a8P3mz4Fz5a1e4OMxchPSP
         WvRaIz1Dq/bpJAm0bL2ztftUZkFxvmdpchXpHo9gg/uChGtwgrPi5XIOELixvRfvgbL6
         Z/uqZfpR9I4ld9BotVqus6+KX7/A8jXDMG7+zQbZfi52FzV6FlczcQXko7QdMGhay4oY
         Cfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775986708; x=1776591508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5lS9m0YKF/AhL70UDdpLWZKYq+rkGRCMnHCx58rcr0=;
        b=lPZKmMGxt4TafzRoVeQDnHELFn+6RlC8H8pBM2TZ/xbpwYdFGQnj3RdYifSe6t6kTZ
         TKoWDA3Qqqs6vXcz2e5y0YPoeJy/WgbW7O2/BJOXgDa+lRGrclLhaTUyWoLHk6JtAL2X
         pEvPpUlS6W23CAvUUrA/3dwuY1/UrYS0NBE+E6WygH8Awu0LrM0rHjPpxOuFDn69ecai
         +Cu7hBKTgFJSGcZsPKFaRRKAGSuvl+Gkpnjz6p3ivUvZfAW/hRTtOHoIsyeqt2szZ/xk
         aQGaH8uoKPhL/E0CXEUJeuq2hflu3MKzQxfT1pGBA/ozL4J1cCyloOrXtbaC6lLbINCs
         yCmw==
X-Forwarded-Encrypted: i=1; AJvYcCVeP3n6h9Z/iHrZamxqxKps92zRXBcmOgLL2hMIeGEIV/kh08foCS/aWfBhEJBCJi/CJ5gC8CNIqHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2MbWm3w9mKc/Fg5dlWlrtjEhbGvpbjhbyXROi0uJal61wJLmH
	ZsgplvNVlV0YRvoAeLqRwmpy7qRIQ+ND7VUM/O5Gt2c0G13fH0ylQ/FV
X-Gm-Gg: AeBDiescXQ0xPzomC1jRcOkk2AL6FJE6HwcUN+1w30YAuq2flyct66hwut9SW6Cc9wp
	tXi2wtM4Y6l6ia/0LrxZ38ZEEmp4mYvub7XMSAPTo8PkTVXVpZg/W66wLcJH39pI4vTRJQ8cND0
	JXa7VK3la9lHxgMhnMjTvzWOeJ0bY3VGX49xnLUv2HRxO2kCBwv69WLCMjkUjUi/ay+FZUqHM7q
	CZqkYzk7r2lrA38ZkGSW+KtYcvaWR7o99B87j3p0jPyav8g7rgv5XuTNnX9f/vBn6HyfWatE5Af
	XzqpqrOiLZ51yK8TrwWfHFzhaVpKwxhg0zYncUt7kqzM9UYYDrIvgxO+gRmzdKG+WGsvfKMxKoR
	NZ6UbUXH1QFgWj9QbAYWNfTlNctkDQTTF3BMqsj6uuFUDrJv29pATHApM9cjTMEanr8ah2FB7lJ
	EpzfTJ4az66/QjrEMI21OLu1Ob6C7K6lmW4wK2CkI1f4egKWJmyvhm9VeioEziqiu4wE7L01On
X-Received: by 2002:a05:6a00:408d:b0:82a:8163:4bf4 with SMTP id d2e1a72fcca58-82f0c27749cmr10120883b3a.46.1775986707878;
        Sun, 12 Apr 2026 02:38:27 -0700 (PDT)
Received: from debian.ari ([152.56.156.42])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c36130csm7885038b3a.24.2026.04.12.02.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 02:38:27 -0700 (PDT)
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
Subject: [PATCH v8 5/5] iio: adc: ad799x: convert to fully managed resources and drop remove()
Date: Sun, 12 Apr 2026 15:07:39 +0530
Message-Id: <20260412093739.17116-6-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260412093739.17116-1-architanant5@gmail.com>
References: <20260412093739.17116-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the driver's remaining manual resource management to use the
devm_ infrastructure, allowing for the complete removal of the
ad799x_remove() function and the simplification of the probe error paths.

Specifically:
- Initialize the mutex using devm_mutex_init() and move it to the top
  of probe() (before IRQ registration) to prevent a race condition where
  an interrupt could attempt to take an uninitialized lock.
- Use devm_add_action_or_reset() to ensure that the VCC and VREF
  regulators are disabled safely and in the correct order during driver
  teardown or probe failure.
- Refactor the optional VREF error handling path for better readability.
- Convert iio_triggered_buffer_setup() and iio_device_register() to
  their devm_ variants.

Because all resources are now managed by the devm core, the unwinding
order is guaranteed to follow the reverse order of allocation. All manual
error handling goto labels in ad799x_probe() have been removed.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Suggested-by: David Lechner <dlechner@baylibre.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 70 +++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index e37bb64edd2b..0ceedea5df0b 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -775,6 +775,11 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 };
 
+static void ad799x_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ad799x_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -794,6 +799,10 @@ static int ad799x_probe(struct i2c_client *client)
 	/* this is only used for device removal purposes */
 	i2c_set_clientdata(client, indio_dev);
 
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
 	st->id = id->driver_data;
 	if (client->irq > 0 && chip_info->irq_config.info)
 		st->chip_config = &chip_info->irq_config;
@@ -809,15 +818,19 @@ static int ad799x_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, ad799x_reg_disable, st->reg);
+	if (ret)
+		return ret;
+
 	/* check if an external reference is supplied */
 	if (chip_info->has_vref) {
 		st->vref = devm_regulator_get_optional(dev, "vref");
 		ret = PTR_ERR_OR_ZERO(st->vref);
-		if (ret) {
-			if (ret != -ENODEV)
-				goto error_disable_reg;
+		if (ret == -ENODEV) {
 			st->vref = NULL;
 			dev_info(dev, "Using VCC reference voltage\n");
+		} else if (ret) {
+			return ret;
 		}
 
 		if (st->vref) {
@@ -825,10 +838,15 @@ static int ad799x_probe(struct i2c_client *client)
 			extra_config |= AD7991_REF_SEL;
 			ret = regulator_enable(st->vref);
 			if (ret)
-				goto error_disable_reg;
+				return ret;
+
+			ret = devm_add_action_or_reset(dev, ad799x_reg_disable, st->vref);
+			if (ret)
+				return ret;
+
 			ret = regulator_get_voltage(st->vref);
 			if (ret < 0)
-				goto error_disable_vref;
+				return ret;
 			st->vref_uV = ret;
 		}
 	}
@@ -836,7 +854,7 @@ static int ad799x_probe(struct i2c_client *client)
 	if (!st->vref) {
 		ret = regulator_get_voltage(st->reg);
 		if (ret < 0)
-			goto error_disable_reg;
+			return ret;
 		st->vref_uV = ret;
 	}
 
@@ -851,12 +869,12 @@ static int ad799x_probe(struct i2c_client *client)
 
 	ret = ad799x_update_config(st, st->chip_config->default_config | extra_config);
 	if (ret)
-		goto error_disable_vref;
+		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 		&ad799x_trigger_handler, NULL);
 	if (ret)
-		goto error_disable_vref;
+		return ret;
 
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(dev,
@@ -868,39 +886,10 @@ static int ad799x_probe(struct i2c_client *client)
 						client->name,
 						indio_dev);
 		if (ret)
-			goto error_cleanup_ring;
+			return ret;
 	}
 
-	mutex_init(&st->lock);
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_cleanup_ring;
-
-	return 0;
-
-error_cleanup_ring:
-	iio_triggered_buffer_cleanup(indio_dev);
-error_disable_vref:
-	if (st->vref)
-		regulator_disable(st->vref);
-error_disable_reg:
-	regulator_disable(st->reg);
-
-	return ret;
-}
-
-static void ad799x_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ad799x_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	iio_triggered_buffer_cleanup(indio_dev);
-	if (st->vref)
-		regulator_disable(st->vref);
-	regulator_disable(st->reg);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int ad799x_suspend(struct device *dev)
@@ -970,7 +959,6 @@ static struct i2c_driver ad799x_driver = {
 		.pm = pm_sleep_ptr(&ad799x_pm_ops),
 	},
 	.probe = ad799x_probe,
-	.remove = ad799x_remove,
 	.id_table = ad799x_id,
 };
 module_i2c_driver(ad799x_driver);
-- 
2.39.5

