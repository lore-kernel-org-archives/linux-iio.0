Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2647887A
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 18:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512582; cv=none; b=RsTfnN50+XzUMbu1EqxCNWOMPr7hHbBOOeEEBDmJk5C2Fj2ZCsBTQ7TGBp5GxL1qabDZhiuDlaXWA7Ww1BMqqbW1NoGfZXHSDPYJWkd/XTyxjMiJ6bRKBKGVXezV9trQ98NyhqERY0yfq5B6luZb/iK03fj8imBrogf6qQSJsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512582; c=relaxed/simple;
	bh=GP/zXsIk7W/qQ+UNS2wJhazgPEjZIr5oEO/HNA2gsAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLuLIlguPZ6mYQoyn4NrFXN59BDhmBZNAROnWq8UyQ7aNmh2Z2AR2g8OuaXtXn9f9OgbVZg/WmYc/HJi9DGRL/tVOvmZpaeKcrwfn+F22x/L+6UwAIepkxA1PDcWWezjo1U2GQUYjLA2FfX9O+MeI+RRB/WLgiS0E63TrF5WPVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=omYHZ2SM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omYHZ2SM"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c168baac83so5477445ad.2
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512580; x=1781117380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2d3GApoepHVx+uh3La4WWn+PmYLbQZlFvom3bYXI8VQ=;
        b=omYHZ2SM0ACQiBUEAzyuKr44yVdvGKcTl848iXfq5dZvKywtqVHm43wdA6qwjWRDE3
         aTVb+w5bMg8UjaJ93wkwQ0tTXKOqzxcLNqDc3GBugBfMqBnLNtNRMcsUx4DUgAIRiu4F
         hTPWiW0PiSxaj4tB9hlSOJ9YhWu2f/QXc7wl+RR8vGCB5BzNN8fCE8ofmeh/fxItfkY1
         b+Wrt0WBkWfZNSlvZX4SfJTCgjU23rw5Kvaqttw4M2qtRB/i5vIk95Al6+NFJnjQoagr
         TaaBpwQKoZIbxWKbyh/Umfcx3cQI5kwexPktagUuS342MNyRM8VaHnY7hAXR2xeoMOOL
         PjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512580; x=1781117380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2d3GApoepHVx+uh3La4WWn+PmYLbQZlFvom3bYXI8VQ=;
        b=dC/FmtWJrbaonaKFAp90lk43fKIOCG5mxAvF1WLkVbnt8IXVLe67T+x+VT/jDoxgOv
         JcHYQPJHNUnIp/EXRUGvm6tfSaxC47b5+dEl6NaAudLMsMARXJpAfFkLARot14OjstDo
         dSFP3flT+JwYohoj3JznClDp/RDJnx42ILIX1NmPox8HX/R1U4uBgpcDlgSHxhgf9whn
         NIkitVpEbnR4rszJGsKfbzRD5DgAlt/nQBTtuysd7qUTDwSOlNi4BmkhN4hDMj9wHQd4
         Zs8WfE2Z/ox7JNXAyfat1OiM2mJMxVcCOE4Q7XufgTsweNxe2ygA4KBkce8ZGuZ3pCUq
         RtDQ==
X-Gm-Message-State: AOJu0YyNxQed+OX5wH9W50ZsekAOgpTlKsMxNcwYcTXlcp/DgujspBNm
	WNmjBFWGY+HthNOdBctbxHGfcfs5gFLVfWj9CHoS8L2DcAgyL0eL4mQFoMglfg==
X-Gm-Gg: Acq92OGe1dRqAazUckMBFVA5UzLjqfgbDiIbeMlKot042YoDhv/TPy8Bh7FDi3Xep9V
	/oqfh+i7qA9WTkF4g8hazaiNNIprYkjVwBv4Zvtai9mlANqmOAc5BoWWarjhsYnlgKWdZDkMOAV
	Qq4Zwe+ISMMo94zillw5WETA+rd9C83H51KJ7zpFLEJXFC6/YcZpB/sfJWf6U+HFohZNijTsRp1
	TIrUxMuB1kWX4RGoRXVy1yjtE0+DyWSyTggRt7WY6fFCdb2dYj5DWMaPsykmw2vWQjvo7IuNHkp
	AwTqnBP0lzaXHbERNmOP9TFfh389OWRc7s/mxgyMLIliOYUBa1TeMjUAd/eVrtr7NCTkNJoNmMQ
	U0uNFo00nPw/5iBxoGAxn45Gl0r83SA4iBoKGlC4QwF1D53kytjMVSZTSIOR/E1qrOxHhAu4g7+
	fhELUOAQFGaVg3aOYqGazyZiLa1q+fo0AjF/Wu5GpsBY4A1zAso4SrN49raalPGdSH2Wr9Ls+gE
	SwtxQXy7V6CG/QXfJSFj77qKrKCO6RJ3bO56rk01AEYR5atWGFVsg==
X-Received: by 2002:a17:903:acd:b0:2c0:ab82:6b99 with SMTP id d9443c01a7336-2c1644ec5cemr45165205ad.33.1780512580507;
        Wed, 03 Jun 2026 11:49:40 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2409:40c1:4015:6e6f:ee79:7998:9a6f:65e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d59csm32139675ad.4.2026.06.03.11.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:49:40 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	ak@it-klinger.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com
Subject: [PATCH v11 06/11] iio: adc: hx711: introduce hx711_chip_info structure
Date: Thu,  4 Jun 2026 00:18:54 +0530
Message-ID: <20260603184859.89693-7-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603184859.89693-1-piyushpatle228@gmail.com>
References: <20260603184859.89693-1-piyushpatle228@gmail.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/adc/hx711.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 86d2a70dd3de..10ccc69f209b 100644
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
+ * @num_channels: number of entries in @channels
+ * @iio_info: IIO info ops for this variant
+ */
+struct hx711_chip_info {
+	const char			*name;
+	const struct iio_chan_spec	*channels __counted_by_ptr(num_channels);
+	unsigned int			num_channels;
+	const struct iio_info		*iio_info;
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

