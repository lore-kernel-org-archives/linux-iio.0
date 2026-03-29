Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A59836E482
	for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2026 22:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774824443; cv=none; b=hARaCisATC3ZOCu+8LVZlmLWZ5/biHr17yHlK4kpJf9KOMZeU0hRvL/smd6wCPEBUKODLF3Lw1EBmS+8odE4qCfgcUz/r5Zt0ct19bXcOMAysdlUee1fJ735tIxlQ+I2X/Z1Ro9zlaLlqXn8cqmaEKaw9LDuxPAOLm5rUzjcOtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774824443; c=relaxed/simple;
	bh=vwpbqrdZWg2IZwLAqAvEpGuR5LpR+6ltHKabiSi+AJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dy2d2PDgba8FUGkzrHxjJtuj1WoMcAzi5iywq6/hFNeHTm41Lg01BrncEV777a+U9r+i/Po/MVRYvD4cOnaOokhd8xNu1tB+jNPFWHyfti/VNVdPZkvQHIwQybAevY2uivhO+Odl+6Q85nOyJJhVMN0KG/NJeoJe0lcvCdVHHQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfewBTZe; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfewBTZe"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so7680933eec.1
        for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2026 15:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774824437; x=1775429237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+M5YsOq3vk2JVYTGrQ8f5AMbXIKgHmkOF2OORVkBAw=;
        b=cfewBTZeel9IF/6M+EKcatDd1aajhVSb5EHkuvat9le936bVm77lu0t9j3HCktW8ah
         o3iflk+1eZPzNsmt/xIifQtLyks/9pu5M5YWo5KvOHaqAloB2H2iPitpNCnxCHwPsm8W
         iMtQDs9oIkcXQmND30JFKYDa77nrxeXOTHayQy5syFNohe9nCSGZZlcIhTLKUgMo7Fjm
         KAT7lCF9pf9OrJEIichFEJ0OHuZXhjuNu9tqiG9hKP1YWDxTcjpkwgk2FuCxJL0pdyBf
         z98LwKgu5Jy4z3IvsVDbt85xhpFgl9ymFn8W7E0ooRb0FCPfhQGMNB5EzCTmqvDfjMAf
         9ESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774824437; x=1775429237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+M5YsOq3vk2JVYTGrQ8f5AMbXIKgHmkOF2OORVkBAw=;
        b=Av/5R5J+PQpBNFHn/Ud4lf3HhLkiyKtkohCC50V89UEvnvDNS1ecoSwRTrdLAclD+1
         XGybwJcjPJXxiQVWW4GjSTAWqi1GADfG4FZ6cmgQgJNajM7Vj4+Q8X9MaH2hEUzdFzWY
         PohwP43ZW6kAxvmaqISXhFj9p4nSDjkQ48Tr9H5jLZaOgYp6Gde+QwXYYulAa2vIP6CD
         0/DCtg18WIvptzt+XdRlaNEtkJY3DmVSbN8K8k7voLiVFClwcCtzCBmL7MgURhjejPI8
         Eucl69kZiRMWPhJ4L6U6ocLQPbi9lhl5wZfBIsCy3frbGweF5sHTo5dxrcueIuKzN12p
         Y+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCV5zgZIX/6WWc30UUU0wvM3ipwUSvsFL2ZdMwf5vTD0Np3yMbfIObTf5jDwUE97KdX1ECLYgNgocH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzksgcN7iGmz2eB6o2prALXnRdSAJNr7Mk9NtUqE1R+CMCh++2X
	enUmGCn5lSvc2Qwy9ePZTHSH+BPFKIHnFf4hbE9bZxCKCmkgWKKXVMSk
X-Gm-Gg: ATEYQzyObFH4qDD2bxQHS1epLNVtTf0s72zpq4sVF+BxoON7N9nDclpzOdJtE9lMK9n
	MV9No6xuE2O7lpSxDxtQ7iylpiZ9v/sVr950lVtDPdlUoda+yACj2gdWvijPZOrCbfHP6DhXwTv
	TLhwa8v+7t4jqcvNlXYbwXFdFWyB9Tvy5GbbSRtmTZchvTETI07i6n3Kukz0TrMyJdkA/bfyLF8
	jjRV4u8qv6jSyA8c3k68LfCeKV0s9/qybKKbkZJQq2C0WIo2o1wCdmFmBAUdWyscM78FneaN0dh
	3S+doarKldk6hpyBE9IlMDnBVYEOzao9MqsLLrZVGXzchAhcP5Fc18rWD2br6K9pkmGeB6tq5tB
	zijA4/CQGAcueib3bjTyLIJDqAM7yKh7PsohONTg8rV7mesKQyH+adkJVwxe78gWhmVKqjTOPKL
	Lp/VVF/VSAN/02ur6uye2TlRsGMyRasAel8rSZuymvBGdkiMu5sZs827UfHXVHmg0/fr0NfAJTj
	pSDPULo8hCQ+NM=
X-Received: by 2002:a05:693c:3282:b0:2c0:c96a:a4db with SMTP id 5a478bee46e88-2c185d8e84emr5487052eec.4.1774824437396;
        Sun, 29 Mar 2026 15:47:17 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7265:773a:8e51:c62f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c7971d97sm5840295eec.30.2026.03.29.15.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 15:47:16 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 29 Mar 2026 15:47:09 -0700
Subject: [PATCH v4 4/4] iio: adc: ti-ads7950: complete conversion to using
 managed resources
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260329-ti-ads7950-facelift-v4-4-c568c508c49a@gmail.com>
References: <20260329-ti-ads7950-facelift-v4-0-c568c508c49a@gmail.com>
In-Reply-To: <20260329-ti-ads7950-facelift-v4-0-c568c508c49a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.15-dev-a6826

All resources that the driver needs have managed API now. Switch to
using them to make code clearer and drop ti_ads7950_remove().

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 66 +++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 0b98c8e7385d..234249ab76d8 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -506,10 +506,8 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	spi->bits_per_word = 16;
 	spi->mode |= SPI_CS_WORD;
 	ret = spi_setup(spi);
-	if (ret) {
-		dev_err(&spi->dev, "Error in spi setup\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret, "Error in spi setup\n");
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -517,8 +515,6 @@ static int ti_ads7950_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	spi_set_drvdata(spi, indio_dev);
-
 	st->spi = spi;
 
 	info = spi_get_device_match_data(spi);
@@ -573,24 +569,22 @@ static int ti_ads7950_probe(struct spi_device *spi)
 		st->vref_mv = ret / 1000;
 	}
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 &ti_ads7950_trigger_handler, NULL);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
-		goto error_destroy_mutex;
-	}
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
+					      &ti_ads7950_trigger_handler,
+					      NULL);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to setup triggered buffer\n");
 
 	ret = ti_ads7950_init_hw(st);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to init adc chip\n");
-		goto error_cleanup_ring;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to init adc chip\n");
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to register iio device\n");
-		goto error_cleanup_ring;
-	}
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to register iio device\n");
 
 	/* Add GPIO chip */
 	st->chip.label = dev_name(&st->spi->dev);
@@ -605,33 +599,12 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	st->chip.get = ti_ads7950_get;
 	st->chip.set = ti_ads7950_set;
 
-	ret = gpiochip_add_data(&st->chip, st);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to init GPIOs\n");
-		goto error_iio_device;
-	}
+	ret = devm_gpiochip_add_data(&spi->dev, &st->chip, st);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to init GPIOs\n");
 
 	return 0;
-
-error_iio_device:
-	iio_device_unregister(indio_dev);
-error_cleanup_ring:
-	iio_triggered_buffer_cleanup(indio_dev);
-error_destroy_mutex:
-	mutex_destroy(&st->slock);
-
-	return ret;
-}
-
-static void ti_ads7950_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ti_ads7950_state *st = iio_priv(indio_dev);
-
-	gpiochip_remove(&st->chip);
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	mutex_destroy(&st->slock);
 }
 
 static const struct spi_device_id ti_ads7950_id[] = {
@@ -674,7 +647,6 @@ static struct spi_driver ti_ads7950_driver = {
 		.of_match_table = ads7950_of_table,
 	},
 	.probe		= ti_ads7950_probe,
-	.remove		= ti_ads7950_remove,
 	.id_table	= ti_ads7950_id,
 };
 module_spi_driver(ti_ads7950_driver);

-- 
2.53.0.1018.g2bb0e51243-goog

