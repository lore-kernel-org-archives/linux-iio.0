Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D1316197
	for <linux-iio@vger.kernel.org>; Fri,  3 Apr 2026 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203618; cv=none; b=MuX+iwCjm/19kAOXroFLDoBThk0ufCtf/jJ3gm2LlwmVhIKs5O+FHnwxU/Pm92x1fIq807UJjKG3xcfFTbvMz49JNO+DVftW6IHoujDkIlif4bxPaV8nP/tNvUY4l+zUKAVMkY3tzMgucVf9eW76Sn5Kz+GTF+hCFCHiFpnctnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203618; c=relaxed/simple;
	bh=m1KMSyTgNoTIjs0yfbu3OFUljzgRa7Od+ZK3UUmuaKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cAtqxQAwgFGVxZTaSjmGBUWIiK3Hju7EgMYE0w+riqZNeh+uMcM56q+KtoC0+wWQFjYomHTCb1FB6JCcH8+1K8z0TF5UOzpNTItbLhoBHIbkSgcLRlp6MfLwFYRVZQltY7tBPdLOAccO5kp7tvqFGdPJAD4BWYtUt+RprukZ3Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL2M4Okh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL2M4Okh"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so772015b3a.3
        for <linux-iio@vger.kernel.org>; Fri, 03 Apr 2026 01:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775203610; x=1775808410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTtWp6TMoxddZliac+SyJr7XIDYz1K5UHMGnb/koc6g=;
        b=HL2M4OkhlDKV39yQmT4yAMAASyq+ODmQqgc3DM1mpBYVZjXSm5Iu71C0ScB5wHEVBu
         5zNsSXkSIB0bQxIVRe/EDguWIilGFZ0BqKB08FBVLs7xuZfMeKArTDomYexy88e+/+g6
         Ny4j41jO+P5icKlwU8mCrqnnw62/W+DEf+rcmN7Mhc2ugwjMnhzF3aNEjlhbIOYFEjSc
         GAEWGQhatMpILB82qhbEYghesei97+bE6U+LLfNnpcNM5KXlNQlbtYFjQ5/NvBUvrEF0
         pAU6IMeJnUsgcpMTJpe2ueb3Ko74FtfL1rJEfniO4cmyVon0R/gLjvy2/xChXJZSQGle
         OS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775203610; x=1775808410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tTtWp6TMoxddZliac+SyJr7XIDYz1K5UHMGnb/koc6g=;
        b=OXxWmjAAQvdlg7L99Et+iX1sk5oARFw4rTSR8U2t7ht2NjXjrTDoxc0H12A7Q2msZb
         YlVjQVoTx5J7Iem1XflWTcjZYXHrys9XjhrAio96JTVfV3iZt2MQn85W7mV+LPMd1LIp
         A4Zu9sG0SspRomLk0HexAOeOo03kQPvymEfhfsuzlj0PJK2hx0jTbuhEQ4i2vBype7TH
         fK/DSYEdTNOwRBrHkQwbL90bFkn0YXUO0s3eqWzyMnCWQuC3X2KxGIg1vPWHU2gIfpxA
         m2P0XccKPoTkqW82vtvZ0+EcNCS3qFbnShuiGcTqwR9XJP4j8IsAqTMdBNA5wdbwxAfn
         Yhmw==
X-Forwarded-Encrypted: i=1; AJvYcCWJBIxd9YGraWz91QgFEy12iyhuIzocIVmQAcNHWprCpImLXcrA9lwEo+EOrd4BjQi8BgJyXThZiBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJuXZcrSu5ng/GuW/81TIH9GcUvzhSQX1t9gEdroWfY7PNxomH
	VrUxcGzy7Ht0ywfOQVJ6ioKFCJubbsqc488cycmFNBSHvAeAXe18Z4sD
X-Gm-Gg: AeBDietWCnwF/Zf/JYB2w/g7vegXWHtweCoAEhISytofzf6amgjWGUCuW9IbsZ4j+DP
	uYUkKhCBX3UtIhlbvw4Sj4e7S50o8bkt6ObzmG605I056rU3ONx8hLKcrDfKjfbtIKoXprQ89is
	jYXFWGTV6vXD5lcbpekUJj19ZLwmUvNktogHCRr94AnWHayl6DhX/XCp/zRyaXc+/0MZmpH5mqv
	sGkjhjTV9/veypWrXjYLDFt5H8lte5LBlyebVAfqhKukTLelvtiBE7GXOoylxipnuv7kX1rTEFA
	wkP6zR8nXyKiSkBDMG3beSMtk9tM0ofFwrQjCvFA6NXVo0nqN8PGsMFs39qb4EWf2X3CT1blNrW
	DrVlE+XWethxQ5tXl/EK1iQFmjIEtNFcE+6i+v3Aue6xocAk1KpggSqheG6k6r/eJ9JCC+fc3DG
	YrogHjoIG+iCTtUErsNpbT/bpMfKB+hg4hcGCQB1i3U40JEKEglP36MRJdqEdX5ugwQaYQqCoOv
	w==
X-Received: by 2002:a05:6a00:2d15:b0:82c:9c47:fefb with SMTP id d2e1a72fcca58-82d0da4de31mr2178254b3a.20.1775203610142;
        Fri, 03 Apr 2026 01:06:50 -0700 (PDT)
Received: from debian.ari ([152.58.181.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ad8asm5481093b3a.40.2026.04.03.01.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:06:49 -0700 (PDT)
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
Subject: [PATCH v7 5/5] iio: adc: ad799x: convert to fully managed resources and drop remove()
Date: Fri,  3 Apr 2026 13:36:14 +0530
Message-Id: <20260403080614.14213-6-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260403080614.14213-1-architanant5@gmail.com>
References: <20260403080614.14213-1-architanant5@gmail.com>
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
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 69 ++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index e37bb64edd2b..9170109d64ef 100644
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
@@ -793,6 +798,9 @@ static int ad799x_probe(struct i2c_client *client)
 	st = iio_priv(indio_dev);
 	/* this is only used for device removal purposes */
 	i2c_set_clientdata(client, indio_dev);
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
 
 	st->id = id->driver_data;
 	if (client->irq > 0 && chip_info->irq_config.info)
@@ -809,15 +817,19 @@ static int ad799x_probe(struct i2c_client *client)
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
@@ -825,10 +837,15 @@ static int ad799x_probe(struct i2c_client *client)
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
@@ -836,7 +853,7 @@ static int ad799x_probe(struct i2c_client *client)
 	if (!st->vref) {
 		ret = regulator_get_voltage(st->reg);
 		if (ret < 0)
-			goto error_disable_reg;
+			return ret;
 		st->vref_uV = ret;
 	}
 
@@ -851,12 +868,12 @@ static int ad799x_probe(struct i2c_client *client)
 
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
@@ -868,39 +885,10 @@ static int ad799x_probe(struct i2c_client *client)
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
@@ -970,7 +958,6 @@ static struct i2c_driver ad799x_driver = {
 		.pm = pm_sleep_ptr(&ad799x_pm_ops),
 	},
 	.probe = ad799x_probe,
-	.remove = ad799x_remove,
 	.id_table = ad799x_id,
 };
 module_i2c_driver(ad799x_driver);
-- 
2.39.5

