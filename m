Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F8D279792
	for <linux-iio@vger.kernel.org>; Thu, 19 Feb 2026 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771468182; cv=none; b=Z8DLj2oCxE20GAJPQG8iep3tZFDV8HwzHVW2C2LxYy8t5vLaY25urWvUJvWTt3X57MFN/r/kHk+DgiFKrDFHp2uAZHlAL+hdrx3REmuZWyFDgtQYMlW06Oi7p5TUsbVPq4Kc8ukBs0NCBQ0L3Febd+GErYiuPKA91lgEbROYyyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771468182; c=relaxed/simple;
	bh=kauiL/ONWk2RY4xVUjE4kT+PlTVn5lZxv/b4OFnIWtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blyI24HmpngXxZx4GeB/bTlrDHYLpHG7mObplbwA39lrapWe1dwzmy88qZbE4dmqRgBdRoqMMwwku7r3ScghyqJ6geeuloXEYDpCHFSXMgA2WhTJ7ssKoCm8tNsaCJMOE5dDTkeGscGKIwvCY7H/uPGj3mCRpKtBqM9zwba2K6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irb+B+g5; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irb+B+g5"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2baa098ffc6so446228eec.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 18:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771468180; x=1772072980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1ZTHJlxuM3aGdOYJnVvaMVfaR/Kwe29wbgQ93rKb+E=;
        b=irb+B+g5bq5qwaeDebSv+F7Bj1xwGldMkWuC4sXz422pLm0SzMem7PJCD2Db1XZx6A
         5XdBeXxCCh4zrF21i9sNCuPPx4M//RjdIUWxwGFbUfI/bNr2W+DLirSlACbvdqHvhxvk
         GKueIoU2nXMDL0EJsPqaA2Um0rYIgMUiD3HOFQW71RVx10wsy262odbZWa8bgFHMt6Xn
         n4xKdvRp9ST4EyNX9yksq71cMwtcVPq2qRFhJ9S6F6V+bilS8CH7Oq7NaW1bvYGSTVOb
         RFWbcJ18/uN5oum+TCvGnVCeSq7HeqIj1D45ImcpRREW+HO9Fw8GIUTPMeC3HBox1JbP
         1KoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771468180; x=1772072980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M1ZTHJlxuM3aGdOYJnVvaMVfaR/Kwe29wbgQ93rKb+E=;
        b=kT0SLe7zZWVVsouuwwmbGw1blG0MM4o6DS1Lq+9oa3XIbMAYG4HIU210MD0Vk5wryr
         4paBxLx8lWU3s3VNz77lJ4pDrGQM7E/eJpqTr22/IDydSVNLPlD5UbSyeo0VYIimvVw+
         rzZc6AmHMVEOnpOifVsJPGATqvc6wPtVY/raqcpKHrhOMEiaYTx7AXi+pv5CnKtunSKg
         HszE6xRw/T83Od9fqJJSZV7S9XXMI+VuWDALEvCXzg3ykD+Uai922vSGVPicbV34IPZC
         gMMe9bGdrea8H92ejq1QOuCbl6E2kbceFXLVVxm1t1bItL2aPP2QYAInGJIR5JcJYm6h
         p2jw==
X-Forwarded-Encrypted: i=1; AJvYcCUBPDk1GHR6gvb8rmg+NE4x71xhKTZElPotpD5uimv5bb7/MbkECilVwS7X2WpqmtSjpv9axT7BJCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSrYezY1mFNcZ0uEjLZ1GRN5hH/FCjwv1YbB6zYV/JJ4dcGQGt
	U2JMtq7spKdHBBAU0Haubb5Ho73+/pUNflX9n0Im+g+WxZes/k6/TUdn
X-Gm-Gg: AZuq6aLxB6iXefleT0z6A2ct0WbUfit7jhWkaOvSDWJ64A7+dCf/sJLwOIuRmME0/B0
	GagjoF8YDts+C2ojRsNY15Fsc3Sthnz+ztZfipWbUWg+W/ouDPF6j29otELxdumTQYdCxLvIv5P
	3TIozuS7c/vNcUp99EPxAo0hcN43sW37OEwQ+M/PGhcwTudDgx/nvYWYNviNmSndMKg330mrj3l
	en2adfFwNS2BI8pFeQsP+3cll8PqtZZkuqxf04r2B9mACo0lOGT3sXQsc3wR23VCHNkht7QnKFN
	8dgfFebVC3SqDSPJ1vbXEYrpbZceMvkyJKJmRIONjFQUGGZR2eUIa9UsRwfN4R/xU/i3wSSbtod
	7Eb/6TMUbLux5pzmP3YpK3S9fovwDXb6CiTmNE1U1WMHTSD4HnFBnTFBUTAaPUinnkwHxK34Xcw
	adKj6uYhM/RR3mphVgDFWvtcTwH3H4KBq2jcFxpAgVMl7+fZxJ+STYlHjIPMQ6Deo+0+u+iZc1l
	IuOZXOtBM42+9wtrpcd2Rmuog==
X-Received: by 2002:a05:7301:d19:b0:2ba:6d87:cf68 with SMTP id 5a478bee46e88-2baba05b5c2mr9113620eec.16.1771468179912;
        Wed, 18 Feb 2026 18:29:39 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:265b:f5ad:9e03:677e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb577bcasm19609433eec.12.2026.02.18.18.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 18:29:39 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v2 4/4] iio: adc: ti-ads7950: complete conversion to using managed resources
Date: Wed, 18 Feb 2026 18:29:28 -0800
Message-ID: <20260219022929.3558081-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
In-Reply-To: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All resources that the driver needs have managed API now. Switch to
using them to make code clearer and drop ti_ads7950_remove().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 98 +++++++++++++++---------------------
 1 file changed, 40 insertions(+), 58 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index d31397f37ec4..1c53e000bdcc 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -528,19 +528,26 @@ static int ti_ads7950_init_hw(struct ti_ads7950_state *st)
 	return 0;
 }
 
+static void ti_ads7950_power_off(void *data)
+{
+	struct ti_ads7950_state *st = data;
+
+	regulator_disable(st->reg);
+}
+
 static int ti_ads7950_probe(struct spi_device *spi)
 {
 	struct ti_ads7950_state *st;
 	struct iio_dev *indio_dev;
 	const struct ti_ads7950_chip_info *info;
-	int ret;
+	int error;
 
 	spi->bits_per_word = 16;
 	spi->mode |= SPI_CS_WORD;
-	ret = spi_setup(spi);
-	if (ret < 0) {
+	error = spi_setup(spi);
+	if (error) {
 		dev_err(&spi->dev, "Error in spi setup\n");
-		return ret;
+		return error;
 	}
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -598,36 +605,36 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	mutex_init(&st->slock);
 
 	st->reg = devm_regulator_get(&spi->dev, "vref");
-	if (IS_ERR(st->reg)) {
-		ret = dev_err_probe(&spi->dev, PTR_ERR(st->reg),
+	error = PTR_ERR_OR_ZERO(st->reg);
+	if (error)
+		return dev_err_probe(&spi->dev, error,
 				     "Failed to get regulator \"vref\"\n");
-		goto error_destroy_mutex;
-	}
 
-	ret = regulator_enable(st->reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable regulator \"vref\"\n");
-		goto error_destroy_mutex;
-	}
+	error = regulator_enable(st->reg);
+	if (error)
+		return dev_err_probe(&spi->dev, error,
+				     "Failed to enable regulator \"vref\"\n");
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-					 &ti_ads7950_trigger_handler, NULL);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
-		goto error_disable_reg;
-	}
+	error = devm_add_action_or_reset(&spi->dev, ti_ads7950_power_off, st);
+	if (error)
+		return error;
 
-	ret = ti_ads7950_init_hw(st);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to init adc chip\n");
-		goto error_cleanup_ring;
-	}
+	error = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
+						&ti_ads7950_trigger_handler,
+						NULL);
+	if (error)
+		return dev_err_probe(&spi->dev, error,
+				     "Failed to setup triggered buffer\n");
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to register iio device\n");
-		goto error_cleanup_ring;
-	}
+	error = ti_ads7950_init_hw(st);
+	if (error)
+		return dev_err_probe(&spi->dev, error,
+				     "Failed to init adc chip\n");
+
+	error = devm_iio_device_register(&spi->dev, indio_dev);
+	if (error)
+		return dev_err_probe(&spi->dev, error,
+				     "Failed to register iio device\n");
 
 	/* Add GPIO chip */
 	st->chip.label = dev_name(&st->spi->dev);
@@ -642,36 +649,12 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	st->chip.get = ti_ads7950_get;
 	st->chip.set = ti_ads7950_set;
 
-	ret = gpiochip_add_data(&st->chip, st);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to init GPIOs\n");
-		goto error_iio_device;
-	}
+	error = devm_gpiochip_add_data(&spi->dev, &st->chip, st);
+	if (error)
+		return dev_err_probe(&spi->dev, error,
+				     "Failed to init GPIOs\n");
 
 	return 0;
-
-error_iio_device:
-	iio_device_unregister(indio_dev);
-error_cleanup_ring:
-	iio_triggered_buffer_cleanup(indio_dev);
-error_disable_reg:
-	regulator_disable(st->reg);
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
-	regulator_disable(st->reg);
-	mutex_destroy(&st->slock);
 }
 
 static const struct spi_device_id ti_ads7950_id[] = {
@@ -714,7 +697,6 @@ static struct spi_driver ti_ads7950_driver = {
 		.of_match_table = ads7950_of_table,
 	},
 	.probe		= ti_ads7950_probe,
-	.remove		= ti_ads7950_remove,
 	.id_table	= ti_ads7950_id,
 };
 module_spi_driver(ti_ads7950_driver);
-- 
2.53.0.335.g19a08e0c02-goog

