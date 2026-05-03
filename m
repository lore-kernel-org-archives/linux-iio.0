Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADECF3AEF22
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810239; cv=none; b=Fs7vxgsEabzU1NmxBWj0D4BBRBEifZz3nVTbUsNh+npbd/R3d7NhTrvtBswuYUNZJpdyJfBxnw1Qc+beVljbkp2Ch5twd5YkhK9zuYKGZ2EK42o1p6RDJwnUl9Jf7Zbo92A4NGFCaUHT++gEdf86mDeO3kXFPzqXlbpr+ydKnRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810239; c=relaxed/simple;
	bh=P64uRrZ7ZmO3sOlQxIgx97yRzn4q043tWEzhnD3RF+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMoq6q27kgh1TGeGlcD82/x09DSwzdsIbj8uS8JbQjGMnK2etm1KBtbKFiIarEtppxI+MwuHp1MPcREhr1y5dadK0NvM2CQAIb4dE/ji0M7WmJuLhEI8+g9xBxlGrtlfDwDRESoBxRYmSRgYQPQwguCZ3hJxDlFSqKm8mVAOp84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LskTw1vr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LskTw1vr"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so1369197b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810238; x=1778415038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMaRNLqWzuSGKC5pBOc/ZA5KEyrFd0iuihOG00TOr+w=;
        b=LskTw1vrJIgEW9aVD92gG0C41aTxoX6P6SD8Fonoua7nig/yKQ60KjE0Qokk3SFCiZ
         n4xncuFjdkvopiSaN5rO+xQH1VtnObsczTOKBobXvCBnNppiZhMVJf/sRVsK9vuPCblV
         hIuQiJOLXsqxXUKNpCrbtiNSGtCnTLhp1MJUZtc1jEQlEGrZ7gYDSOzGBqAk+DMt2jlJ
         xnfvR6T4MWBVfAu39WTaquuQh4UU0d1JaTnN1JhT5peArDHcawCHiIP/+9R08sD+KDNb
         ZJvZl8AU72VLtkT9u7YJ6l/Wa+FyweFaDI8GkRc2xIAZTFcX4yaiFMWbVQTo1mSD+egf
         cbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810238; x=1778415038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RMaRNLqWzuSGKC5pBOc/ZA5KEyrFd0iuihOG00TOr+w=;
        b=H3/45BA8cjNec4oAjTOW3Hjw37HUhMGGmt3UdhcXs2DtpZnHVwTrTvmSyK7hg9umZ+
         +57pIDUbqvlbpMnVE1X2mKwNfjO9ZyRpfpQhNkjo3wfgTKNQkaBU5LjIvBRR4vbhDUlB
         0O8Xk3U1uy+AGIMI8ae8NADvHd39muDytHmEomHOVWql9igpSedZ3SWPpspTtbh9GkEy
         mJkfY141Z48rHYD0TLyuBbQqvL87VsHbwQAL3Aog//oUYi0VGTlYKF0Gh2hbWT69OEAr
         wk0VVrddog40/YMC+OBmahYml2JtaMffsbcNmTGsC31l32E1CKQogsVE6ampxB4BPTTu
         Y5RQ==
X-Forwarded-Encrypted: i=1; AFNElJ8EVdb2Vm+TQZolg2T/CyLqUaYpF7F68P2xquccD60RpPz0NL9AAEaIf7p1m4idgxszWe5TYSoUIBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztgLNUPNRNmhn1Fbe0h1mcdh2rfM6axAzAG+m1+XEQXzk392Pv
	E6YkbRj3M1Nbk6QeIXNRCObQSe8I/IBpJ/IBgT5hXl2Q4Ljn+36cjUQL
X-Gm-Gg: AeBDiesLvrg9VQgxjdZNVBG+31JOLGceEkz49ebEImCDc4HwiFJtYehL3A9JHOItD9F
	xQfRZN4IZQ6qhAMK4cGUJ0ykcUYvjGfaj3RUOHBXh+a4+X5T7OWAKhZ2OsS8cEqudXqb17HZJtH
	No0XRHY1A6XlmQArF2nm0jyqR8nAL7OZgNvgmiSiS7y/GLNG33PCguEFkvFUY3evx+6UrbMUtqE
	wyGjpBt5S+O7AlKrYg8MpGwivG59WP7fE3wsbsfWrKJAR7L5difY691OIE+TmIg1EteusY3Ua3l
	b2KBDslsGd2s3moq+JAw++1NGRwcFIRR5VZU9Bq79a+agWOayTXtlbfUcxHviYj+JemQr2ck8lO
	3gn1WxBh5JUjf0ZVOpNFR1KNaqOlmFZRPR5tQPN+fUBJkY3cvQssyxWchj3kdVq8UgGEgz84TxX
	dFFhRgpt4VmG8RBBkFi21Q69Ergw2LBjN8j1+aemDTWMiAYjqfP+H4B7oZ13Z3zZNE3jZ1f2j/R
	9lXBNWId2Tz3sw2WI1jlAzwHRRSxE8Dx6ExGtvlOTq16paGiBCXKdRcRf4NdKt9dNHND2E=
X-Received: by 2002:aa7:8f91:0:b0:835:3949:3c29 with SMTP id d2e1a72fcca58-83539494429mr2685123b3a.23.1777810238087;
        Sun, 03 May 2026 05:10:38 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8357c4f4530sm1474364b3a.9.2026.05.03.05.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:10:36 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 06/11] iio: adc: hx711: introduce hx711_chip_info structure
Date: Sun,  3 May 2026 17:39:35 +0530
Message-ID: <20260503120949.80292-7-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503120949.80292-1-piyushpatle228@gmail.com>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a per-variant static configuration structure and populate the IIO
device fields from it at probe time.

This is a preparatory change for adding support for more HX711-compatible
hardware variants without duplicating the probe-time setup.

No functional change for existing HX711 users.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 drivers/iio/adc/hx711.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 8485e18c949d..534b73fcaab8 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -4,6 +4,8 @@
  *
  * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
  */
+#include <linux/array_size.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -74,6 +76,20 @@ static int hx711_get_scale_to_gain(const int *gain_scale, int scale)
 	return -EINVAL;
 }
 
+/**
+ * struct hx711_chip_info - per-variant static configuration
+ * @name: IIO device name
+ * @channels: channel specification array
+ * @iio_info: IIO info ops for this variant
+ * @num_channels: number of entries in @channels
+ */
+struct hx711_chip_info {
+	const char			*name;
+	const struct iio_chan_spec	*channels;
+	const struct iio_info		*iio_info;
+	unsigned int			num_channels;
+};
+
 struct hx711_data {
 	struct device		*dev;
 	struct gpio_desc	*gpiod_pd_sck;
@@ -81,6 +97,7 @@ struct hx711_data {
 	int			gain_set;	/* gain set on device */
 	int			gain_chan_a;	/* gain for channel A */
 	int			gain_scale[HX711_GAIN_MAX];
+	const struct hx711_chip_info	*chip_info;
 	struct mutex		lock;
 	/*
 	 * triggered buffer
@@ -456,8 +473,16 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
+static const struct hx711_chip_info hx711_chip = {
+	.name		= "hx711",
+	.channels	= hx711_chan_spec,
+	.iio_info	= &hx711_iio_info,
+	.num_channels	= ARRAY_SIZE(hx711_chan_spec),
+};
+
 static int hx711_probe(struct platform_device *pdev)
 {
+	const struct hx711_chip_info *chip_info;
 	struct device *dev = &pdev->dev;
 	struct hx711_data *hx711_data;
 	struct iio_dev *indio_dev;
@@ -473,6 +498,12 @@ static int hx711_probe(struct platform_device *pdev)
 
 	mutex_init(&hx711_data->lock);
 
+	chip_info = device_get_match_data(dev);
+	if (!chip_info)
+		return dev_err_probe(dev, -ENODEV, "missing driver data\n");
+
+	hx711_data->chip_info = chip_info;
+
 	/*
 	 * PD_SCK stands for power down and serial clock input of HX711
 	 * in the driver it is an output
@@ -534,11 +565,11 @@ static int hx711_probe(struct platform_device *pdev)
 	hx711_data->data_ready_delay_ns =
 				1000000000 / hx711_data->clock_frequency;
 
-	indio_dev->name = "hx711";
-	indio_dev->info = &hx711_iio_info;
+	indio_dev->name = chip_info->name;
+	indio_dev->info = chip_info->iio_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = hx711_chan_spec;
-	indio_dev->num_channels = ARRAY_SIZE(hx711_chan_spec);
+	indio_dev->channels = chip_info->channels;
+	indio_dev->num_channels = chip_info->num_channels;
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      iio_pollfunc_store_time,
@@ -555,7 +586,7 @@ static int hx711_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_hx711_match[] = {
-	{ .compatible = "avia,hx711", },
+	{ .compatible = "avia,hx711", .data = &hx711_chip },
 	{ }
 };
 
-- 
2.43.0

