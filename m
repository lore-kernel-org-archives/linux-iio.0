Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF5B3D564B
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738525; cv=none; b=TWuobjrpbj722rJc6KVGtXv+Ol/tc8ND/HcUIZYGKoapYUWvXKf/UoT3Kz25CG9K4w26V/DN2YUE1m/10yfHdqkHR+tBv4MKRu3mjdRgysRKeVFb04dBwP6wjjfD1llZdRZOuQXhfMzxqSE6oXxJASP2AWDcoVYiwzPWJp+wwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738525; c=relaxed/simple;
	bh=jUbqI6ezBlVyFDdEQHZwsRHOEwUTcg1/vMHeRJvJv5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTq6QHyAlovafFcEK9eHjOVpCqKbPXk0BTvJr/BPhWlX3mWviv+xR8QaPpS+dVdGMRKDeioGKCx+v6lD8FHy/ZgLhtozs4znl1OT9Zd796/9Bf9O3AKK4rmSMoaBdBGU9MJiSDLkfOif3TiWFIBd2gbQ3w151hkHh8z37SL2E+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPSBT2xe; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPSBT2xe"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso7872838eec.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 11:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772738523; x=1773343323; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JjPq113nXOUWKDDAA/JDnS8+HilrFrKJ/9HVlkXWYhA=;
        b=VPSBT2xeQmmsPe5JKSy7cVMAF3fuxRFSdsGbQKzo4G1Geg+f96XUuMEo59RCkfuw/x
         Wab14HM17Hvx20A09BDzRTpTx0a1y7RtaIrp8/KMqWrwaRXHxPPQFN/l7a2CYo9+Sr0e
         dPG1yI0p2id0Kzv2USHh25Qw2R3+zRaEn8fy7I3RJts2Kp9Dc3gMr3kt6FmQIbrI4awh
         Y1k2MXLeoQDoxNxKw+h3xcbQykE+crNeRDobf7z6hAtcIHaxT4NRSfiQHSV9jgtM08nb
         w5hsdlxz5EhDGpU1lMTl0KrJf1HV/SJIAjMFDRh0cilBVpwADojuVi3dYYRukiN9RnRQ
         2xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772738523; x=1773343323;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JjPq113nXOUWKDDAA/JDnS8+HilrFrKJ/9HVlkXWYhA=;
        b=fGof7AVstuhMMvjP6LFOT4/pFL3U4uTlvuHWtp3KkNZhkziAfuyYf2fuA606WkRP/B
         kDqSwFvd80EfHuQIz/PgrJbvFrGcgZVZydYFME5UMVg7KCkAtthKEYeeJgrqb1Apg463
         1Zu//2sRZDSLkLeYpjYD31AoTRe6vLaZQCbbAkjmvh6QvsMhEIgFVNKXUV+NQx+ZDOi8
         Gy5WgleUazcaANodWnK9vvaUQ13Xu5oiZ6hPUzkhQdl+9hOHuOyW+PhKxtXnUGTiZYEe
         pZ8AIR7ElrkCco4pFsPKl4tUPfLH6DO+cVbqTfWj8KCbFsS7pRkk8Uo6Qw82FEffp1/n
         aQaw==
X-Forwarded-Encrypted: i=1; AJvYcCXnR04q4lSLPSLoUKSXlqCXNZP4hGBMCfr7i2RBokfRZijs0b1ODsmQ+3oN1jOEX6QZbaHj7VMODfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmckUjp9RbCg3M1sjRbyJHIJKD68nlP2ePYdc6FSeAN/cL6krl
	5LLGsu4U+MsDowMa0SZeQ1WB4+Ne3YKSTSW/jJLVH9yWCQcK3bHUV5f2
X-Gm-Gg: ATEYQzy1aPl9qP0c+kjWtrZt1kndWSFG8OEEsyxMjTPBi6DkyHoq2lSEIs1muSCVr55
	HkBmBQ9YvklK5M+izl1IRJ5LVU69TwNRAOzCv8oHIt4UzUnMT+2whdorRdekP4Kai1EtfsMAJ22
	Upa/NZfS24Be2V6NPgrrUA4AuqSIn37/qdUQTAIiAjtqmOesex7O3eEB9+KmLkY9DYegnmFGrFj
	wr8S25MHXGtBkmo126WSrXkAjtIYmxtPp0ypH6JjKmORrYWubLU9Vl2E3Lrt/eyitE+mu4qcEf6
	Qxo0mJIkT3V57p49u6xCu8HwsRQq3x0GH74UIupxA7ugBLiZv8HkH08SGr5gCIMVEco6v6MUYVz
	5dtohOOvKnvxCWc8lS/bIvjvgp2AJO79A2Cq4q9gSPF5hSlZjVw7ZV/P4XL7db8e5WCLaotR3np
	ZDQMIpq7jiECJr145vwrzSf9Mz08kOQwOv8OQFw1bK7Ygrjw/8ZDOuAS0Km3gNRMeRl7Kqt8daL
	Wctg+tj4eYTTPM=
X-Received: by 2002:a05:7301:1e87:b0:2ba:6aef:6959 with SMTP id 5a478bee46e88-2be311c34camr2322058eec.27.1772738523235;
        Thu, 05 Mar 2026 11:22:03 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7788:d145:a740:ca06])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be1281ff70sm10800980eec.14.2026.03.05.11.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:22:02 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 05 Mar 2026 11:21:57 -0800
Subject: [PATCH v3 6/6] iio: adc: ti-ads7950: complete conversion to using
 managed resources
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-ti-ads7950-facelift-v3-6-a23fdd1a079e@gmail.com>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
In-Reply-To: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.15-dev-94184

All resources that the driver needs have managed API now. Switch to
using them to make code clearer and drop ti_ads7950_remove().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 66 +++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 847e83baa876..a1197e9cff93 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -513,10 +513,8 @@ static int ti_ads7950_probe(struct spi_device *spi)
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
@@ -577,26 +575,22 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	else
 		st->vref_mv = ret / 1000;
 
-	mutex_init(&st->slock);
-
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
@@ -611,33 +605,12 @@ static int ti_ads7950_probe(struct spi_device *spi)
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
@@ -680,7 +653,6 @@ static struct spi_driver ti_ads7950_driver = {
 		.of_match_table = ads7950_of_table,
 	},
 	.probe		= ti_ads7950_probe,
-	.remove		= ti_ads7950_remove,
 	.id_table	= ti_ads7950_id,
 };
 module_spi_driver(ti_ads7950_driver);

-- 
2.53.0.473.g4a7958ca14-goog

