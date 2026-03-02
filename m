Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349E412E1E9
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456829; cv=none; b=R3p78+9ZFAFQYOPmVE2Gyh9sEEtz8NyCsT31AjG24iSY2JB0+wo/27udLcCGgxhDngubR7IeGliZI7vdEYvJWEdbytjQ3rT5EF2FrHuRN5qxy6Pr71w+pI5omVT9DNmIdCaOgJUxE1D4RCWWtFrUImBpb19Vq15R7Q/OF1qJ/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456829; c=relaxed/simple;
	bh=aQ7zABqojbwxrU4SsOcLTgZNgpwW7JwcYk5QGDZUQ+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kNCG6rZ+okQBjS1YBi32YNLcgIAU031jNMcRATkw9QxAGfEo8JfhFgfqMhKXo+Zkcv5TuOPmornaZ40CmUhep2liu4xeK/qYlDbFkkUWAk8NcH2yRwlnSGnnL7KVKsnHeflNifmpi6znJCXwmNpl40Mfos9IyxddfQRUqoL89Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVIDnc/d; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVIDnc/d"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c70bc5b4e86so1688309a12.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 05:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772456827; x=1773061627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEGlEibZYgaxceaxVmMyXueExIiVmPPFnlkrZeXfPYQ=;
        b=RVIDnc/daZu0AHoUwfLAfzmswrGuVO3BveOnVd9pragn8tbE6DqjbcgVl5ZZrj3oVK
         q+NcJoKD9sjESDqhCFmnp3TQbk0ct/wQ89D3VN28j+l3+fF4XhPI0lWdM8jjkfPEcX5A
         wOS7lW2+uN2gXnfF3c0ykpm6NpJcJs2XA9Rzwlv3Wi8kaW80WRLQ97KEEojsE+hNUlc/
         06Rr07OhzpZS0nj79A0Jg77c7TFD7wPlOL4HnRFeew6rJMDbC89veFw9ZfIwei1kgmsu
         +Wnoogbk0xZxFy1vvcO93gTniqVZtDUnJHcLTs0uQ69VrSVD0z2/ZI+dFVU5suOPlyge
         k+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772456827; x=1773061627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bEGlEibZYgaxceaxVmMyXueExIiVmPPFnlkrZeXfPYQ=;
        b=eRfYDVRzFaNmT2V3ccN4QHXJgmoOC9N7xWweB1yaG6cZkBDEETmoHiX8DUligp6piN
         tO79LLvzjnqXlCrKXZRdvpUYBPnJsC0MGcJ2I2eMDbBtQhtnCHkcfdq36apg2y4RXl7V
         Mw7GZK6HCyI7XIQJnL2he/C2CauQduwZCmT7vp83Deq3Ap6EfU4d3TCrhCI+De6X9WU8
         VH3mxr4XryxGIo1rexHsA8TH053VDU8ark/kYhTkF4RMMZ/0BBGbV9VjI2RNiA4oz176
         J0JX5UyeQE4Gsn2skeblSF3rc+cXid90atYf68HC4beEgugrnD/aPlQJb6s6FgOU7qTM
         EGjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbwnSfE7hboFrBsHSjKPJBB2keVDXlDAiUh5HCZOBfKIV/oFkDABc2yFBJL+Jc+hFD8dKcEAG9pXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyMI68HSntrISiTgmEjb6Ur7yWi3r699iHG2Fweo4YHxM58jN1
	bDntkysm90khSd4M/EegXa1U+J7/Ni0M84KLFf8BXwIhMlcATyLljSIZ
X-Gm-Gg: ATEYQzxiQfb7qrTs+wXNo3mVAHV5C2YZQj8cRZTI+qWLiJDaE96KO9shrJ82a5koP+8
	MeRflN9b3t/l9sSaEhb2DOfHq9NSNDFms3YlylYDg4E6Q6tD72tUGZYvPzZCKRqOWk869p0KKfp
	OpUSbdp7CAwUWvHk74rG0B7svnIPV0HLLppl5+q+Ighf2xlgQ/LkWoDZ/wVU85o3yIloBwiKrgX
	fZyjkIMCokkYcVzhQVaKYmGNaovmCVrpkhUZc3n34IwcvLuLfNY/g3MJhRfIGWTIqnKxzdK9cOA
	puFYbVrVbyYCgs640uikueDh7qJI5m4rrDnuOYRwjjCPCVwYT8kAuPDIULXNf0x9D9SA3gPwIIs
	lZ1q43+AHZvLtBRjUFKS8SYRfMV1j1dxb/u80yYLQJiy5BhOoXipTK8R4B7tzR3bY7WGVlQ0oUI
	E/oua9vp0X/erLIZ15+sK10SF7tjrRa9zbzO71yET0oA==
X-Received: by 2002:a17:90b:288b:b0:359:88c5:3ae4 with SMTP id 98e67ed59e1d1-35988c541c3mr3965793a91.25.1772456827351;
        Mon, 02 Mar 2026 05:07:07 -0800 (PST)
Received: from debian.ari ([152.58.176.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3597b448e38sm7444585a91.5.2026.03.02.05.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:07:06 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v3 4/4] iio: adc: ad799x: use devm_iio_device_register and drop remove
Date: Mon,  2 Mar 2026 18:36:32 +0530
Message-Id: <20260302130632.29144-5-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302130632.29144-1-architanant5@gmail.com>
References: <20260302130632.29144-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the driver to use the device-managed versions of
iio_device_register() and iio_triggered_buffer_setup().

Because all resources (buffer, regulators, IRQs, IIO device) are now
managed by the devm core, the unwinding order is guaranteed to be
safe and correct. We can safely remove all manual error handling goto
labels in ad799x_probe() and delete the ad799x_remove() function
entirely.

This eliminates boilerplate code and prevents future resource leaks.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 43 ++++++++++------------------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 1a96b5417ecf..2b40ef2da7a2 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -822,7 +822,7 @@ static int ad799x_probe(struct i2c_client *client)
 		return ret;
 	ret = regulator_get_voltage(st->reg);
 	if (ret < 0)
-		goto error_disable_reg;
+		return ret;
 	st->vcc_uv = ret;
 
 	ret = devm_add_action_or_reset(&client->dev, ad799x_reg_disable, st->reg);
@@ -835,7 +835,7 @@ static int ad799x_probe(struct i2c_client *client)
 		ret = PTR_ERR_OR_ZERO(st->vref);
 		if (ret) {
 			if (ret != -ENODEV)
-				goto error_disable_reg;
+				return ret;
 			st->vref = NULL;
 			dev_info(&client->dev, "Using VCC reference voltage\n");
 		}
@@ -845,17 +845,17 @@ static int ad799x_probe(struct i2c_client *client)
 			extra_config |= AD7991_REF_SEL;
 			ret = regulator_enable(st->vref);
 			if (ret)
-				goto error_disable_reg;
+				return ret;
 
 			ret = regulator_get_voltage(st->vref);
 			if (ret < 0)
-				goto error_disable_vref;
+				return ret;
 			st->vref_uv = ret;
 
 			ret = devm_add_action_or_reset(&client->dev, ad799x_reg_disable,
 							st->vref);
 			if (ret)
-				goto error_disable_reg;
+				return ret;
 		}
 	}
 
@@ -870,12 +870,12 @@ static int ad799x_probe(struct i2c_client *client)
 
 	ret = ad799x_update_config(st, st->chip_config->default_config | extra_config);
 	if (ret)
-		goto error_disable_vref;
+		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
 		&ad799x_trigger_handler, NULL);
 	if (ret)
-		goto error_disable_vref;
+		return ret;
 
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev,
@@ -887,36 +887,16 @@ static int ad799x_probe(struct i2c_client *client)
 						client->name,
 						indio_dev);
 		if (ret)
-			goto error_cleanup_ring;
+			return ret;
 	}
 
 	mutex_init(&st->lock);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret)
-		goto error_cleanup_ring;
+		return ret;
 
 	return 0;
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
 }
 
 static int ad799x_suspend(struct device *dev)
@@ -986,7 +966,6 @@ static struct i2c_driver ad799x_driver = {
 		.pm = pm_sleep_ptr(&ad799x_pm_ops),
 	},
 	.probe = ad799x_probe,
-	.remove = ad799x_remove,
 	.id_table = ad799x_id,
 };
 module_i2c_driver(ad799x_driver);
-- 
2.39.5

