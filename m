Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBEA3B5832
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284650; cv=none; b=ppsEmFfMqa0Nr74YhU82h9QxzfVCKgPW8TE/Jfs7NCejRVRRX+q0U/mbXhw8jH+NSs46nGw3nzqlgXG+CdMBQlIpJ4LwjAI0QDXLCcQnVehxhbcPsvXnteqP6sjttiiDQ4Cz0gA5y+E8je4RWm8GEGSPJVbeWMY8WkY9SPlOows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284650; c=relaxed/simple;
	bh=Sl/Z8A9CH0hwBYW/4R15ug+b331jMcEoqL6KKcM+CBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXrUhNt/V8LJTXdEng7p6hko4hcHR3xaEelwFm5fErwNQOYKHbtweiHt9pEMTTHtm8qMbE/4KUPbaPCgmwzvk1AzGAJ5HyPDs0WpzRN1yo/R9BtEuaTI6HIVjM1X4KDMJW1k/lxkYgESk6QQh+u8cvRPG6yYe+ih6+bWOAJfHu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtC3cCPJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtC3cCPJ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82418b0178cso6137617b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 03:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777284648; x=1777889448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iW96GUGG0VeP8kNBbycKsFQZuoW+cNCY8i/cQua94o=;
        b=WtC3cCPJlhpr7Cp0rRk4zHLUIBva5lPmiYNGG4922V3SNRsuOd5nmQVs7LD3o8EeIV
         wcVv2fRUpWCskuB3RcjayqkC8iNqIA0qzY4xoYG1eyQq3gfgiB7iP0LE0JPCvqunmVxk
         62rer+Ku1qntRKK8QhlOMEzuIDc/1BBAU3feC6WHTVokvoggifmm0bf8TL6yJ3xCI70a
         d1tM0Andv+C8fqoBwvtQhbx98YqjGfiAAQ/88PTyRIiGEw1/S7NgfZhaADZU5voV8NRd
         DGtljcQw/P18Vo4oVUF+/pOGVcHpNyDRxy0Bmgy1lzg+K3wGFt5Cu5ESnXq2NMlX7SMY
         7BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777284648; x=1777889448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8iW96GUGG0VeP8kNBbycKsFQZuoW+cNCY8i/cQua94o=;
        b=IoukOIpqe010SvKu6d1OX5Ssz+QbgI56HOutL/5AM5iSMfkRrIAA5BXznksx77a5s8
         pi5wafrWiNZjxWkfjxxlStCu0qc7PKqSowx69B6vuWzB8yHvlbuOD6oGbbQzpZlwYhIc
         E28N8bbMty3IodK4kd1MImqMvKSm4aPtXXkYqzaTcEIjR2NHJIdLT/eMsU3mpLquAM9T
         Jx2jv/Fqhelegu8/ttj0LtkRr/WkkWld+kGMurNXcLdwwldQaDOIrx0giiGDc5IGMSAv
         FQ2ox9X1PXnFcxvpsfHZXkuScbfdjGNxES0MpUbpErnz8u86IjhTgyVNYf1Y10img3qL
         0PHQ==
X-Forwarded-Encrypted: i=1; AFNElJ82Tn3/Y0YyPyhLBYNNS+H/YnxqMdH3wOObIRFCuLhNQpFlYPNKsG+5qHYhdo7W+v7MmVir+oHipx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDMJaPuUoxVfuyNPG/ZoZpBddEWekZnw09VTSOLLltlwih+ZIX
	LiV16gIW7R8GlM/gGRvGV4l7FaETX2VH+F1u7tVbflLhKI1RDlVSg/kf
X-Gm-Gg: AeBDiesmj9WWGl5Rj6PuhoyMF/eKBHOtQ4TnesGWSodBzHIH4piZbV9vSoP2gDb8Kep
	NZ+vqpmiQdkUlGwkEcTNfWvQvN8yDg4tU3Zbl1dJfR4tyWx53uT6fc5ivjE+DUWDUA2a3OwGN0x
	Bi8DNb5mUgn262nKNfsXbbtoE9Gsp6Y67m7LB7jOEqx+9kU7notv6RH2sqeGL/uXSVthCY2/8bs
	f6hksG0HC+e65z6PPcFGcqRtkH1lVW+N19qS4ppMYRTqT4qZ7ahb4LmpFinj5NXebRRRih6oFc2
	Www1UImR5sdBsU207OnJdITsU3SAwRpR7Hv1GXUKzq/uDTZq+yHZsOLoDW5d80ls/pn7fuM10gb
	NOpPblM/FbQy7hY3BB7sWpRFI2mErEl2Q2iFKijzCapSaibBUcjmHSyjrs/r1yTKbaiIjL2/zYA
	Js+JMvLI3nVPXQpnssJg2BaZaOyl1dJPXAkLgLpWNUYkULngfdJSrLIKWX0e6eA29lv7JhWd9Um
	EKTfQHLN/GUr5KK3LH8AC99qqNr5gk4Tq94FVpwJOvHKaYvag==
X-Received: by 2002:a05:6a00:3e09:b0:82f:3828:a01d with SMTP id d2e1a72fcca58-82f8c8befa5mr42875610b3a.29.1777284648045;
        Mon, 27 Apr 2026 03:10:48 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d016:e577:22da:dc9:7f6c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebba485sm39534225b3a.38.2026.04.27.03.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 03:10:47 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] iio: adc: hx711: introduce hx711_chip_info per-variant structure
Date: Mon, 27 Apr 2026 15:39:35 +0530
Message-ID: <20260427100950.33936-5-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427100950.33936-1-piyushpatle228@gmail.com>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add struct hx711_chip_info to hold per-variant static configuration:
device name, IIO channel spec array, IIO info ops pointer, and channel
count. Store a chip_info pointer in hx711_data and populate indio_dev
fields from it at probe time instead of hardcoding them.

Use device_get_match_data() to look up the chip_info pointer from the
of_device_id table. Guard against a NULL return so that the driver
fails cleanly if probed via the platform name match path without
associated match data.

No functional change for existing HX711 users.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
Changes in v4:
- New patch. Split out from the v3 refactor patch as requested by
  Andy Shevchenko.
- Place hx711_chip_info fields in their final order from the start so
  that the HX710B support patch (which adds fixed_gain/fixed_gain_val)
  appends new fields without reordering existing ones.
- Add NULL guard on device_get_match_data() return value to handle the
  platform alias match path that can bind without match data.
---
 drivers/iio/adc/hx711.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 32362771cfc8..2a6e9645f54d 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -76,6 +76,20 @@ static int hx711_get_scale_to_gain(const int *gain_scale, int scale)
 	return -EINVAL;
 }
 
+/**
+ * struct hx711_chip_info - per-variant static configuration
+ * @name:         IIO device name
+ * @channels:     channel specification array
+ * @iio_info:     IIO info ops for this variant
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
@@ -83,6 +97,7 @@ struct hx711_data {
 	int			gain_set;	/* gain set on device */
 	int			gain_chan_a;	/* gain for channel A */
 	int			gain_scale[HX711_GAIN_MAX];
+	const struct hx711_chip_info	*chip_info;
 	struct mutex		lock;
 	/*
 	 * triggered buffer
@@ -459,10 +474,18 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
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
 	struct device *dev = &pdev->dev;
 	struct hx711_data *hx711_data;
+	const struct hx711_chip_info *chip_info;
 	struct iio_dev *indio_dev;
 	int ret;
 	int i;
@@ -476,6 +499,11 @@ static int hx711_probe(struct platform_device *pdev)
 
 	mutex_init(&hx711_data->lock);
 
+	chip_info = device_get_match_data(dev);
+	if (!chip_info)
+		return dev_err_probe(dev, -ENODEV, "missing match data\n");
+	hx711_data->chip_info = chip_info;
+
 	/*
 	 * PD_SCK stands for power down and serial clock input of HX711
 	 * in the driver it is an output
@@ -537,11 +565,11 @@ static int hx711_probe(struct platform_device *pdev)
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
@@ -558,7 +586,7 @@ static int hx711_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id of_hx711_match[] = {
-	{ .compatible = "avia,hx711", },
+	{ .compatible = "avia,hx711", .data = &hx711_chip },
 	{ }
 };
 
-- 
2.43.0

