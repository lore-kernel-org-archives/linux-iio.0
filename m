Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332931C567
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 04:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775450380; cv=none; b=tWqwZybD7YnMQkOfOkOTWS0DGPU2TWqYEko43dSLy26hMElkbfJ0oGbA+E9uuxcqBkkBj8jX7Y2yLrtsHh4ywgUmumzBUIeZgMp44Fit9Lets4fIx9DZbTuvid4u1FLECJPbAfV44A76lGEugp/cznxqNzeECThix76YC6icx00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775450380; c=relaxed/simple;
	bh=q1ErVgV21ILDuUcdhUgtkkx+/oTMzLm9AIurDmszr/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mwrEOKhIJxsuHthuejUdaRv0ZeJxxLd2bRhF0TV9DSw3zIh55y5ScHXZyv5g7/3HcEYjdQkn7CxSH/Otm9M6Aqs38YIwJn+2yxaeSJyIaHUGv2oE3JIHqpr7/CI+E2QnnqMp5+L2fI63dMHUnrgSjNiep8kB9tOJ0CQK5Ag9fMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VybCdcSP; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VybCdcSP"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12a74039dc6so2519248c88.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 21:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775450376; x=1776055176; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=muAbhbsfMeNqO7iyxZwi7/vPm//pj1ujL1kw3AyjdRw=;
        b=VybCdcSPDY3l8Sdjo4ZN7cbq2f87d0EGqYZ0p3gLfuWSf5tzRsPZEpP/jAYnpYBhxI
         fdDZvi9Y7od3B/wUNsP+X+XCsaVuBFwCMaRKXIVteOX56zp1wxq/PbOHqwPajucC66Rf
         Cm52vQsMife9df5FFJGDrf7YvG9aLeZyO0SFM82icX7p60A3J88Z9Vbw5ZLYzDEnsyl5
         Z8M73TOrfL/4Da/+J76ScnaXQ2GdPR6/wGz+ydODIh4wrBR8z4fpEgmPrKaAW01WhEkO
         pcIKN8jpdtDmuwYGns3XjG0LnzyY/lmIUeW9a4xyQeHoDeOhZk69HhEZCg7rlfaa2+NH
         qwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775450376; x=1776055176;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=muAbhbsfMeNqO7iyxZwi7/vPm//pj1ujL1kw3AyjdRw=;
        b=G1gsi06K94HWP7Dx5MAvufjs4xrwaGa0DxYHqpHF6mWYpQRIDYPTXGw0GCSm+JfOkg
         MVfhgaL0cQlqo6986vePt5VweJq46o3cpjZAi15dH0CalwpNoxtfvvOkT9OO11NueFQb
         eDZ9GOIcNTVdSPKHDw/NRmPAG/+SWtKmhDyR37A+xJeHiduXrwbKwaFNcHmAFbT7WUB3
         obQt9O4OaaI0pWsRbbFXrjAGUTbLp/wVsJ2K3a9J2TgiY9txsXqEnWeK0FYWYajk+vdW
         PEcC8DlOtZw0y1M16ry5BYmZq/Hodezw6VSavb5Ev2yQePX2AuLQW21UWenlHzeKmoIu
         8SgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1rrBytfq0zyj5RgnPkSFhXN8YHxzeggxGmZ142jJjE5X961t9eTZ0vi7Bkkh5aCnJV6/0OnxWYi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUsIfAOHgBjVu0vC50B6CsX//VRXyHUthp2wUECfCch4Y4WbA
	61YAXs4WPKb7xWN/SmWU1io6PfMP+AssntEdeyZ0dy0WMuOYmEJon1ij
X-Gm-Gg: AeBDievHSxo3Mx6wHDh0TbvcwU+R774Z+EI6QWz4+A7TspTtLS4LNd/fzn3k53sHAZ1
	m/omSDmlV0OKkzNoj96bVhhV5Fi147+hOsDx1f5JzJ+9EaCyodN+76pZ78JIWz3gYEvAKVwE7Ar
	DhBbrr7FdOHGDjuqZoR46gIMzz1c9L7tCyBWdvwB9uE6J40MV9hUWXqZblt5NoAoG1BSbVZw7Rp
	HpuS2ZoSbDEnm8OR4vNvOyaNPPBQAKO7cfqZuCkHFyc95DKclwidnnfPZG8362z1KNlJVRhonXS
	Y8OFJ9gfEdlr0t0J8BB6QThIUxQF2WmRbXJARJNl/rsP2GeLKNL/QAdC0y6Ee3mMjnt+gskCLVK
	3L5IZLxBibOHQ6MzQgWD7xhUc40YBQIlGwp7XFNTUPE5tj5ZfuD1ompca/NLsuEgYmnQWvpsjZu
	FwclVABSkJYnQLDOJ8s1XrGQJTVcyig8WN7UXOS2LHtLQcrPDTOYHcT301763qPzuPOrxW5Y9JA
	d+bgrVGyV8w1gw=
X-Received: by 2002:a05:7022:e02:b0:12b:f881:d8d0 with SMTP id a92af1059eb24-12bfb7459f4mr5048040c88.18.1775450376503;
        Sun, 05 Apr 2026 21:39:36 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:fe13:98b9:9e98:d1bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm15182005c88.0.2026.04.05.21.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 21:39:34 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 05 Apr 2026 21:39:26 -0700
Subject: [PATCH v5 4/4] iio: adc: ti-ads7950: complete conversion to using
 managed resources
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-ti-ads7950-facelift-v5-4-1f980ed3cf9e@gmail.com>
References: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
In-Reply-To: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.16-dev-6911d

All resources that the driver needs have managed API now. Switch to
using them to make code clearer and drop ti_ads7950_remove().

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 70 ++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 0b98c8e7385d..882b280d9e0b 100644
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
@@ -559,7 +555,9 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	spi_message_init_with_transfers(&st->scan_single_msg,
 					st->scan_single_xfer, 3);
 
-	mutex_init(&st->slock);
+	ret = devm_mutex_init(&spi->dev, &st->slock);
+	if (ret)
+		return ret;
 
 	/* Use hard coded value for reference voltage in ACPI case */
 	if (ACPI_COMPANION(&spi->dev)) {
@@ -573,24 +571,22 @@ static int ti_ads7950_probe(struct spi_device *spi)
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
@@ -605,33 +601,12 @@ static int ti_ads7950_probe(struct spi_device *spi)
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
@@ -674,7 +649,6 @@ static struct spi_driver ti_ads7950_driver = {
 		.of_match_table = ads7950_of_table,
 	},
 	.probe		= ti_ads7950_probe,
-	.remove		= ti_ads7950_remove,
 	.id_table	= ti_ads7950_id,
 };
 module_spi_driver(ti_ads7950_driver);

-- 
2.53.0.1213.gd9a14994de-goog

