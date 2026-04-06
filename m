Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AC8350298
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 04:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775450377; cv=none; b=WvmLqwNbD0TIRxHdm0IVKUc8GzGsgz7X6P2nJGe1ESY/+cH18CTb1+XLI77xA0ncUeq3oJVRKrMfjBVag4puVN/3vKFuNtYoqvR7KqwOzZxQ6oCcv/YiVqaLPJf5tkG3h8H182PrlWxCxBSzGcV3GSYyNo5uDJMNPkMH3T1Nx4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775450377; c=relaxed/simple;
	bh=jWsQsT6/Mu9a3P6wxYYDo0MqxdW/7rVXJ/kMeejbGis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EA3DqGkyn4FK+kmBOSXW3A9xiF/PqyjAl0HsFH1tYG0OMkmRG74BaGoMECH9HIp55hk2cSQnQPt4Ps4P7VzxwVt7gpCT7rNGk8dcL742FFOT2AKcXYJu0JubBmDdgkBeTHUeJEFWOjpOLM/eRxtztrvXIPgFyJJ4NfacQGZMqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5HFP4tP; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5HFP4tP"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c0b72dac7so590415c88.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 21:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775450374; x=1776055174; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBFK0WbO5+WLvAVMP/XY5fTWFLTdlcIvaSfOJd72QI8=;
        b=G5HFP4tPadZfkQBFCUPuTy0QHjXGZZusDCKuwFTdy7ODZYC6OoCQV5ZRoMPDEM+Tr9
         mYmsXA/MEdAbi+PkxdhACPiR2IlyK1kLsPyyT6K1Yxx++IN58Q90MFJyHt7g9knbVjU8
         /wLcFnLso1Yx9xrn5qOs4MjvdMMPgEmMNVi8QVMmWShsCpfEjMMS4Xi4Hh3QscCTJFqK
         lO+VMrZX0jZQJ68OXBWhq64MOwMTYFRmK3k1RBhW7ge+SpAMuyqsSV4i7wXJoGKti7+y
         pyU1S1L73jxZBWiFY41h/wHysiiKOwt+g+k52yPjrd0O48pieSDb3H9kT/xbRmLWARX2
         4SYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775450374; x=1776055174;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tBFK0WbO5+WLvAVMP/XY5fTWFLTdlcIvaSfOJd72QI8=;
        b=IaUhLJ77IeG6jsUE3u/7rzVkvBcpbP+tBWkkYuVkPyrcx7FrFje3bnBGzE8zAOVJoB
         xVwkCntTNXrGoiYf+JIAbCXH6giXjmh+OiuBWAV+TjCFp755lmWEA3jmR0A408pjYNm1
         GcSIKyc3sKu1Hs3591EfLYovMm2ExIAwNBCpx6HLIx6p6pkgrrTQRjHlC47LG33bxauB
         9Mi+Opf5sBVhce91VtdZIhHtgYaURaZVv1bno/TAc3zgnvm0PiyCJHiNJ8i1B9ex9ge2
         L4LHDJs1ICZ3mrmpPiJHrcWvXwVt0SFJ9e3wbDUIkdmGNHaKAQiTfh9wWoS3ZmedmTMV
         CtTw==
X-Forwarded-Encrypted: i=1; AJvYcCW5uZ1+4poMvmMgfIfP0doMELDgeUkluV4+tEFSjqb8GOzJaoL0Bo8X9ljOtVHlgdTqbfkALRpX1fk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa4+7NQsZ0cnPqfS/JQd5Kv3ol7hxHZwLTXKBoDu7UNNxIUxaH
	aNDnqNJv7NdvQ912cnHMelVN8ptvc0aQ3M23Pwr9PcYBZzydedLV0Lqh
X-Gm-Gg: AeBDiesu1+iM7wY63Ib71U3uWImNj7F1s9bO76shhJy0mU7fLqdkGtqb2j4MRaffTQh
	PQWi0VCLOFDfqSXht2XufB8kM4b/OCcuqQwnDtEAyybKec5pDs/+fsVd6w0bpoly9ZSFMLO9N3E
	eAoiUtvX5P9pvk0fWJE+AMd8WvVFKV1ej/18B/yAd8o9ScA/ahBg+oDldBxxVQk4wMdcuflPxit
	2Vst4jqjXwD0huAp763pEH551WjRbZvxAXG2RWyutiJOWZ7gmVrXuOaFbgAcVxvELi1Genmj2S3
	fyTtwBqgE/8pxJIIZ5vaHP+fmhacTwvq1YqIfHL3veDsnFskSyCFbirXRLMd3FPeox10NMtRK2D
	5AHoocpLEm+TYXgjihag/c83IyBr3bjsvmW7vAAe431axkfiGUiVJ7pPVK+MZD9ac04qTRBJqzz
	f5oXHnC8s1GFOTfit/PeOnzof8DsDIHjLSL1Wp7Z1nXXAPPHqGdglygKs4drwekOTHTRQWuGCXA
	5jFBCs6DPvcRKg=
X-Received: by 2002:a05:7022:48c:b0:128:d084:e921 with SMTP id a92af1059eb24-12bfb70dd27mr5179501c88.14.1775450374090;
        Sun, 05 Apr 2026 21:39:34 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:fe13:98b9:9e98:d1bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm15182005c88.0.2026.04.05.21.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 21:39:33 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 05 Apr 2026 21:39:25 -0700
Subject: [PATCH v5 3/4] iio: adc: ti-ads7950: switch to using
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-ti-ads7950-facelift-v5-3-1f980ed3cf9e@gmail.com>
References: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
In-Reply-To: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-6911d

The regulator is enabled for the entire time the driver is bound to the
device, and we only need to access it to fetch voltage, which can be
done at probe time.

Switch to using devm_regulator_get_enable_read_voltage() which
simplifies probing and unbinding code.

Suggested-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/iio/adc/ti-ads7950.c | 48 ++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index c31c706c92a9..0b98c8e7385d 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -334,19 +334,9 @@ static int ti_ads7950_scan_direct(struct iio_dev *indio_dev, unsigned int ch)
 	return st->single_rx;
 }
 
-static int ti_ads7950_get_range(struct ti_ads7950_state *st)
+static unsigned int ti_ads7950_get_range(struct ti_ads7950_state *st)
 {
-	int vref;
-
-	if (st->vref_mv) {
-		vref = st->vref_mv;
-	} else {
-		vref = regulator_get_voltage(st->reg);
-		if (vref < 0)
-			return vref;
-
-		vref /= 1000;
-	}
+	unsigned int vref = st->vref_mv;
 
 	if (st->cmd_settings_bitmask & TI_ADS7950_CR_RANGE_5V)
 		vref *= 2;
@@ -375,11 +365,7 @@ static int ti_ads7950_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = ti_ads7950_get_range(st);
-		if (ret < 0)
-			return ret;
-
-		*val = ret;
+		*val = ti_ads7950_get_range(st);
 		*val2 = (1 << chan->scan_type.realbits) - 1;
 
 		return IIO_VAL_FRACTIONAL;
@@ -573,30 +559,25 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	spi_message_init_with_transfers(&st->scan_single_msg,
 					st->scan_single_xfer, 3);
 
-	/* Use hard coded value for reference voltage in ACPI case */
-	if (ACPI_COMPANION(&spi->dev))
-		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;
-
 	mutex_init(&st->slock);
 
-	st->reg = devm_regulator_get(&spi->dev, "vref");
-	if (IS_ERR(st->reg)) {
-		ret = dev_err_probe(&spi->dev, PTR_ERR(st->reg),
-				     "Failed to get regulator \"vref\"\n");
-		goto error_destroy_mutex;
-	}
+	/* Use hard coded value for reference voltage in ACPI case */
+	if (ACPI_COMPANION(&spi->dev)) {
+		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;
+	} else {
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vref");
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get regulator \"vref\"\n");
 
-	ret = regulator_enable(st->reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable regulator \"vref\"\n");
-		goto error_destroy_mutex;
+		st->vref_mv = ret / 1000;
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 					 &ti_ads7950_trigger_handler, NULL);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
-		goto error_disable_reg;
+		goto error_destroy_mutex;
 	}
 
 	ret = ti_ads7950_init_hw(st);
@@ -636,8 +617,6 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 error_cleanup_ring:
 	iio_triggered_buffer_cleanup(indio_dev);
-error_disable_reg:
-	regulator_disable(st->reg);
 error_destroy_mutex:
 	mutex_destroy(&st->slock);
 
@@ -652,7 +631,6 @@ static void ti_ads7950_remove(struct spi_device *spi)
 	gpiochip_remove(&st->chip);
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	regulator_disable(st->reg);
 	mutex_destroy(&st->slock);
 }
 

-- 
2.53.0.1213.gd9a14994de-goog

