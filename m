Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FED93B894A
	for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826207; cv=none; b=kBH+0cPt6l9wZ4eWsqje7Q/jN4F6a7PkWBbDz5XpqteNaan7HUu+PQq5nCQh+3iqxCeyN8Q494hns0mgM98QM9JREArGP1J/3S6Wm1bX/MJPhclj08jpCcK3pRJ/xtsI5w+RgrqgbfrGAINNNW4/XpJxxNWxAxi0CHUQxjSqnh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826207; c=relaxed/simple;
	bh=Tk8gsHUA/br8aqrC1iyhj1FHWqR7iTwilxeIVhkRv9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DbApiRZavx9ElYBwnmzCVo/vRIxs9ppbzxOoCP51Tzbw49J30zdSVwebFDFwTnmso6XqivPOQjWzbM5pXmkJElahXpTmapr2MEd+eBHcq7G/27IiZFsa/1PSDuJh4z3zC2mE2JwWCREpKfYp0GcGaiai7WbYi/qn4x0fl/7DNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOHjbepp; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOHjbepp"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35ba2ae4df3so2068318a91.2
        for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 02:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773826200; x=1774431000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9q1E7NzrKrJ5QZEJfz50RfWy0GA0rHOKbA0v+tdNbCk=;
        b=AOHjbeppezO+IB3o22PtkZEljCIWN/f0U085hTyGBxAj3qPKpiDn5BLbyYpNasceuT
         iLhEASduwPMzmBipPm3hM8boqad5dzc0xGvLILa5TDx1xxXvDiZBBUW1Z99CAJw5r7az
         fCZk2DNUxLxZzx+wvW7DVT9Yfz2dnrblVUnRA/RTH1jgKkRMU7O2/+w1GOegaicRQv4X
         MUAThMAJB2ejYYb2OR0ZyzeQ1ibT+U+saTpK+4DH618dziDEQnXsdGsFkOBH4qm4DONw
         uv4HD0wauiklnpmccpJY865hb1oLRDdUxKDZwwfjpEb8XQBt8NcTQFT86lr1X4km+NIK
         2ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773826200; x=1774431000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9q1E7NzrKrJ5QZEJfz50RfWy0GA0rHOKbA0v+tdNbCk=;
        b=CqINmyVxCrrnGSL+v40d45720+EmvZdFpdqbAK8/J/yBJtJcuFjhbEq0l5Ogpc6CiL
         Lo0G/bkJBu83mhfSvSRDhYIJmUMOx38xseuCqVmWaro+lV1DNk3o3y4K+jBUVuSOQ9fd
         Y/sJ/Ys//hebnu/03IG63FbZ1S8J9sEmSJoUZBL6a73irXWgvg07Cvy85awUAdJsnVv6
         AuxNyLahT/bvbz3hhn3/Z6z53FznGTY016/cfVlo1C+/tDMj6SuVn8YoABBXQ3vTDbtu
         bdNAb7aut0192QY5KJnsOqAKrMi/07ageVcwMbBDLGkzodNOwkofqh7QRWRXimkZ8WFh
         4n7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOE4wv7UV2BYGv8gG9p6E+CTf6fJr4McxrzOZyIWTQf+lfp2ig4MuOIo/xvocUbE2XnhJSi6c9wz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIGf0aa1zvuQVKTmWAqemKOsYyLMPALw+DIybIHL9Wu4o6WEN
	V8I3nLwz4BFtdo2xstbafhUeV/+SbFhquhtAllADYFrGgDQNft71anN0
X-Gm-Gg: ATEYQzwauSMFaLHix81a7WzLb9T6GNDibBlJr2Fv3iIkSLxq8hDm0iCZ46lWxUZbllr
	RNdV/Sq+RTD8LOlEXXLkKq4bitEvNFVxRXTWKeob2Dq6CagMBqtwVJzteay1iZLPJSSiOvq/msy
	p/BWH1zCO9Go5+K6bi+R4HPJxOyL3ClP6ysIy2bpitOSS4gBznQ0CZcSZ8+8elnv4ca72dL9gzY
	WyZZn0MDkwBH4nOgcUpftCrqAbvxcWwbfLRHNmwG9SmaMu8CGJLhK5Zv5jlmUQN0MQX9FnV3DLM
	4KxP6i2CmMMCbBA3iLrwSGdJiqER6xf2amV2sLBSc95eNzCXJ2+oSt/5j6ESUtDzD7QkkfAjGWd
	mvdMsoRn2Riw81gc6ru/eQ05NlGuo9EYlHIKVvYAHzJk++2SRoSaSxb7DNa2UV7C1zX57nXBsus
	esVsCr5jv5z+W1I/5iTaiwzH7PR94iNgkX7KDmMg6lTjfxc2/iwYY9o8B9VaJ8uxawtHc6vNYR
X-Received: by 2002:a17:903:2445:b0:2ae:ceb0:d5eb with SMTP id d9443c01a7336-2b06e30fcadmr29723885ad.6.1773826200285;
        Wed, 18 Mar 2026 02:30:00 -0700 (PDT)
Received: from debian.ari ([152.58.182.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e616351sm21168315ad.67.2026.03.18.02.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 02:29:59 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v5 4/4] iio: adc: ad799x: use devm_iio_device_register and drop remove()
Date: Wed, 18 Mar 2026 14:57:15 +0530
Message-Id: <20260318092715.42538-5-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260318092715.42538-1-architanant5@gmail.com>
References: <20260318092715.42538-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the driver to use the device-managed versions of
iio_device_register(), iio_triggered_buffer_setup(), and mutex_init().

Use devm_add_action_or_reset() to ensure that the VCC and VREF
regulators are disabled safely and in the correct order during
driver teardown or probe failure.

Because all resources (buffer, regulators, IRQs, IIO device, mutex)
are now fully managed by the devm core, the unwinding order is
guaranteed to be correct (reverse order of allocation). We can now
safely remove all manual error handling goto labels in ad799x_probe()
and delete the ad799x_remove() function entirely.

This eliminates boilerplate code and prevents potential resource leaks.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 62 ++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index ae2ad4bd37cc..3d745612bb80 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -774,6 +774,11 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
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
@@ -808,13 +813,17 @@ static int ad799x_probe(struct i2c_client *client)
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
 		if (ret) {
 			if (ret != -ENODEV)
-				goto error_disable_reg;
+				return ret;
 			st->vref = NULL;
 			dev_info(dev, "Using VCC reference voltage\n");
 		}
@@ -824,10 +833,15 @@ static int ad799x_probe(struct i2c_client *client)
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
@@ -835,7 +849,7 @@ static int ad799x_probe(struct i2c_client *client)
 	if (!st->vref) {
 		ret = regulator_get_voltage(st->reg);
 		if (ret < 0)
-			goto error_disable_reg;
+			return ret;
 		st->vref_uV = ret;
 	}
 
@@ -850,12 +864,12 @@ static int ad799x_probe(struct i2c_client *client)
 
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
@@ -867,39 +881,14 @@ static int ad799x_probe(struct i2c_client *client)
 						client->name,
 						indio_dev);
 		if (ret)
-			goto error_cleanup_ring;
+			return ret;
 	}
 
-	mutex_init(&st->lock);
-
-	ret = iio_device_register(indio_dev);
+	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
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
+		return ret;
 
-	iio_triggered_buffer_cleanup(indio_dev);
-	if (st->vref)
-		regulator_disable(st->vref);
-	regulator_disable(st->reg);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int ad799x_suspend(struct device *dev)
@@ -969,7 +958,6 @@ static struct i2c_driver ad799x_driver = {
 		.pm = pm_sleep_ptr(&ad799x_pm_ops),
 	},
 	.probe = ad799x_probe,
-	.remove = ad799x_remove,
 	.id_table = ad799x_id,
 };
 module_i2c_driver(ad799x_driver);
-- 
2.39.5

