Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0443CC9F6
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041913; cv=none; b=qDvMBcH6ae0ARQsSEz4nOtWYzWNITbXH0Pf0TWpNqpbgqXUkGhE9kwy7iG5G62y726IK0hIzyHD340rSfte9t/o3DEn+LQzIu5IxXF/dSz1BoY9ker3K/hQb6jMWi23KSRkXO0IWWQwNguZa3i8YLJju1HXSrfoPrT4XH0Ko/rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041913; c=relaxed/simple;
	bh=BwNLo5FYKl87iXnoZu+CcTxTzv1iNen3r6e4SjxMA7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=smtQrmFT8ywg9/Ru/L6yNRWVIjAy6JGAv3PFPp7VrfqEd5YWC9B5Vefmb6F9p9Z9bxpJZIFqO6rxekhtXRMQoFLoDNXPXyQTDQRgXpG/gYAunqK7LzSDDjGmlV7bZdkzEu42TJQWmJC0R0rH+q5PnpEMKM0Kqq3lQgKKNmxJhn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=akLCnYTv; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="akLCnYTv"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-439a7e828b1so2303054fac.1
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779041907; x=1779646707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MRGfKr8H7ah4yZfqeoPinkYJCKeiXt9tjcXW8VOiYM=;
        b=akLCnYTvoJkoRaOH1FiTPQ2V8po0rpNQvMNy8szWcanBhUwyWpu4UkipkEc3aN52OZ
         rKnwH1QtD0W4cWfWtUlTC5jtFBypM2r9omg4G3bc0AlmPNIIdRyB/Lm764dHoWjGq+3h
         noD8IgrOADUpDYncuHPRoAsOzPDMESddv3IKxaxsymHBIFfsLFAgSsn+oy3nAu/jQCfc
         eInu8LlqyBrPf4H2q3Bwce3Aq2dYF0VfvV6r0FS0zW0JAT1t6o8qP9xk0crXx27yqLq0
         69O6tUt8AXvbfI2U5ApfZbltMN7fwxjKgd0gfL/RzVysEF+T3LVCsfGqC6bc0PF4Y1yf
         tFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041907; x=1779646707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8MRGfKr8H7ah4yZfqeoPinkYJCKeiXt9tjcXW8VOiYM=;
        b=IFwO798HIASBMKJH54JuYT1DOlNHT0ABsTjFeo143vOrfdo0dmcSWCW4PxbBg6thg5
         /s8gRx3nxUk86OkZAB3MxDu1t3YmgQVROh3lSyiJhF4jY0PXgaeaLxe2g2Y5aFWKjk4q
         OycVa+TbIHpkQls96T/h1+iVUHfXnyuBuGdBUi7p7YVAHFUqJqFn0F4HEm2qsEY/7zlR
         78FkCOPg8dV9INbCyb/GvuouRqSdumLpOmm4ws15iVuWOKMSicZwhk3SN0H4I3UAoPii
         R/pBq0MiSrlFx+ToY9CeEA5B1ZlEx70P/8nNG0DIzsNh/E+OFJw01byccXzQMzb0+AoZ
         UeZg==
X-Gm-Message-State: AOJu0Yy5kUbbOdf4AWjgkJOy3knWfiIFCUa5TfuJInIiaYwlLxZOt0IZ
	3YSevOGZSDkKU3DUiOtu35ZkNmCfH5hBj6XH7YWzgWONRwZaqXlRNHajXBMF/HjXYKc=
X-Gm-Gg: Acq92OGj0/NszdQ/qksNlHsaM4qqaIjYYp2jnovwYFnacMPZXNhogYFAPFVDsu8MIVe
	ZWZCrIeG3/ZwJ4fw98zLyVJ2xX1KwqLll1S6CHypmY1emS95MUWKekuH7l0YQT82phvG5cTwd74
	Kja9atkU9OWt52jayOgSdi689HKIVtczR/2eFrUzmF/AbJ9CmbqFvM++/CRVYcpByjdfEqmtr8b
	7ih8Dql4IDLUXpG6zCr9zLDbRO0e463wQgsZ6uxlu+6HSxsdxw+os6Hy6OE/ea+HUaMKcD8949u
	ZQzNndiaB1TnDgb8Fo9BO1rEvPmrbiHlGUjegO1AXhB6S3f33N66BOe6xqTJQCnQ0YNcojSauBS
	7MpHPVx+Jry6R9nyAlIyFWMj7kzjuPNAvyWD4xd3/Vy9b16OJKflHAqLAgQTn1nbthBZged+AxF
	sHYoiO9OAdTgSQIXKfARcGyecXrcHDDDiIEXL82g==
X-Received: by 2002:a05:6870:1797:b0:435:486c:f2fc with SMTP id 586e51a60fabf-439f94bfe19mr8687343fac.18.1779041907408;
        Sun, 17 May 2026 11:18:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a95766535sm2085539fac.15.2026.05.17.11.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:18:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 May 2026 13:17:19 -0500
Subject: [PATCH 2/8] iio: adc: dln2-adc: simplify timestamp channel
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-iio-timestamp-cleanup-v1-2-61fb908c11c7@baylibre.com>
References: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
In-Reply-To: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
To: Jyoti Bhayana <jbhayana@google.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=BwNLo5FYKl87iXnoZu+CcTxTzv1iNen3r6e4SjxMA7s=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqCgY8TJDJ6Ft/FcVQ5VpLbl7I3sreJsrciaZuR
 YcR8uAF1CeJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagoGPAAKCRDCzCAB/wGP
 wOqBCACLIOEEYmguYfD2EXtVfXwCV+RMMhWS2cj5j6FCUGhFAIT3c6jLdr4I9QvxORRNbgHFE+u
 8irHHh2DH8okhGX6jVbG4CmXaHnJQcresATqKmSXGuI/Y5g3mOXB69I/wgkefbvup1uazdswGAW
 GrFSQL0eYVZyNMZMWJn26wexmzWpk4waVuT6s87rOiIC1MGPCIRk7NO3le4sj8d9E2CWCjbycgf
 xq+7BVUqhUVWXYT2gbdFFdHRY2mFqcvldot7KGVW+0OrVUJd9I2oXmxfZ03O1XH5KNKNWA5CGgo
 BnO79x5kMgSBG1qUGXnvKcYFIOAi3JCqJz0ljFkZHqE2o7tV
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
manually filling in the struct iio_chan_spec fields. This makes the code
less verbose and mistake-prone.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/dln2-adc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index eb902a946efe..b7250fbe4fae 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -444,16 +444,6 @@ static int dln2_update_scan_mode(struct iio_dev *indio_dev,
 	lval.scan_type.endianness = IIO_LE;				\
 }
 
-/* Assignment version of IIO_CHAN_SOFT_TIMESTAMP */
-#define IIO_CHAN_SOFT_TIMESTAMP_ASSIGN(lval, _si) {	\
-	lval.type = IIO_TIMESTAMP;			\
-	lval.channel = -1;				\
-	lval.scan_index = _si;				\
-	lval.scan_type.sign = 's';			\
-	lval.scan_type.realbits = 64;			\
-	lval.scan_type.storagebits = 64;		\
-}
-
 static const struct iio_info dln2_adc_info = {
 	.read_raw = dln2_adc_read_raw,
 	.write_raw = dln2_adc_write_raw,
@@ -614,7 +604,7 @@ static int dln2_adc_probe(struct platform_device *pdev)
 
 	for (i = 0; i < chans; ++i)
 		DLN2_ADC_CHAN(dln2->iio_channels[i], i)
-	IIO_CHAN_SOFT_TIMESTAMP_ASSIGN(dln2->iio_channels[i], i);
+	dln2->iio_channels[i] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(i);
 
 	indio_dev->name = DLN2_ADC_MOD_NAME;
 	indio_dev->info = &dln2_adc_info;

-- 
2.43.0

