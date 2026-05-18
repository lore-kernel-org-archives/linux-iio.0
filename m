Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999CA39F16B
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141784; cv=none; b=b9kFbEzrpfjTWsWldY00o2+xGAsHpLv/z+Q9OhcjBrfE48icQ+/TjMlbno/v9XsSkogTkecOfYYGO66wX0uxNM8mnaf6bDg7mbYmj8/RLtpWy0LJGtyyNcTU9gUUc0rW4xzfoMIwAxuEmGTy2myloX65IKbhZTvbkAeaU8swqdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141784; c=relaxed/simple;
	bh=/PNDd1zkwk3hDyvDb6EEtW8rYpRWUoc8QUNLfK9WR8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZPX5eSsvc6EPhnVuZFfoJaFiq+lTljhL0Em+S1nG/Buq78s6XjgxbspC/GvlqxSIBo/ty+Uun+FvITe9DJNrElOikx3TAiKsVIbfV+o/FSl0pzx1jflEXfwDIAFoc6rj67sirsbrEwQ1eGx2pn9vGMKNqJ9NaJgVbmOHZnKtes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzxP95nd; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzxP95nd"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-83537a80ab6so1916919b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779141782; x=1779746582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fjhdCnbV8ukBtWzUYd6fHgql0XE/IRGNUdKMo9fQMM=;
        b=RzxP95ndTU2X/JgovZNgeCxSc/6gRqDr4+Z+lK5iGYAM+gAN2FWx6qUPW/Ab/xB7OE
         L/BAfu+pWC4h1yG5NGsN0S9HkvGdeSUfw0wDTFTWHTLzj6iXdGOxZw5otatAnz1muHdr
         87lPENNBXNu+ck9eKya+V6VuTGQujiKtr7EOM+b4nqsNWyRvc7sE5FqlXZnIFc24d9SR
         sqtCk8yL6N5IIIP6dR1Qn/sbU+Z9XGF7dEoH3xts3CXm720R1FDqcoH1GkTM+9rpejqB
         14MpxWhqUQN0zlRpusbazDOrWq/I7rKC45hv8uh/Vul0gxd8UMaQYYZfU2cVA4M9xbB1
         CGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141782; x=1779746582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5fjhdCnbV8ukBtWzUYd6fHgql0XE/IRGNUdKMo9fQMM=;
        b=ob50K4exnhsVz89z1MPu9omf6/xs7pkUN8fXPGZe+7rLOYDADaROVZrP925uXUiTKk
         ZjzN+hgkILFI9cWiDPkfxYhIJ78GWgxvmate9FI2rsfTSQF7Wdhtr8cUUtlksgouNcIn
         36esMEeZ2HFZx5You6rXTxLo43L/zoNi2pg+XD7GFN8ggFo7kQwE50koOPST5iS3tSMB
         EqpBbpp7LwRW6WninsOxgTgoIKI1z1qltukOuCgZeyu6DH52W20wJGr7Ps/eNxP00YR4
         v0kYJJ/RFr9GurkQbNfO1X6QVVyGrIqj2joOy72KwMCXbdhXxACh6Qrnpmc/nHkXHxf+
         dGvQ==
X-Gm-Message-State: AOJu0YyAXiKxU/pZqa5PKslAzolTu//SzecHveNGBmYIKG+ib50cSOhC
	MFYSkeOfgUuMOSdlPyGQ6B0tKJDuNnHicfOGagOkuqM763+TAmINC4Da
X-Gm-Gg: Acq92OE5rD86M8smt7zsO5oHcmj+5+nh4l8I+JJ1c0aM9aVZCXaB6A/SgAHuJXngdQp
	NE1CQQswbI1lC/z09S7igdW/EArKPiArvO+HLP2cHxc5isZOICqZVlh5WPSnGnG2A6lEV/sy9xG
	BXxp3oXK1TDHNdvf49BMR3VqwvitZDyX8WMBeVHZd904wxoAYsnJtr07eksFAjrXOI05hxHyB7M
	8s+soES3Q+sgLQ/2cS6UDYLKYitYjO3pC2p6KjVO/ZxLYfiYz4xlhmHjgoac8rP1HcDhgBT8Nhy
	bt/6ZUS0AKPd/q//JUYDWpYkPGyueLJClI4CMXYEg8VJFINV6BCfsFBjud6psuqp9LDJ9GIGv/l
	5nz7Id86Z5vxyw2mV2kvYxzmMKyto8Nh1GMONEQEeXWGyjjzxLpe0ziQXGS/riAE2bigB8ah0fn
	7hkVo3HqJZVDrVI9n9+TD+OlV8x1KMRgr8rl6T4WPDizYlMxmhnFaKcbA9D3hHBXNjVxeadRlc2
	8z9VTlzwgzFGa9TKybZUqtRx5UMZS2pxwfsECreVROy17b+/o7Q2JASVhJl
X-Received: by 2002:a05:6a00:4fc8:b0:81f:5037:a317 with SMTP id d2e1a72fcca58-83f33c957bcmr17839336b3a.11.1779141781908;
        Mon, 18 May 2026 15:03:01 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977b128sm15772960b3a.22.2026.05.18.15.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:03:01 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v9 06/11] iio: adc: hx711: introduce hx711_chip_info structure
Date: Tue, 19 May 2026 03:32:22 +0530
Message-ID: <20260518220228.63322-7-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518220228.63322-1-piyushpatle228@gmail.com>
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
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
No code change from v8.

Regarding the __counted_by_ptr() annotation on hx711_chip_info.channels:
this annotation was introduced in include/linux/compiler_types.h in
commit 4b8a2e8e09be ("compiler_types.h: Add __counted_by_ptr()") which
landed in 6.12-rc1.  This tree is 6.17, so the macro is
well-defined.  Jonathan Cameron requested this annotation in his v7
review; Sashiko's v8 bot flag was a false positive.

Regarding the legacy platform_device probe path: the concern that
probe could succeed without chip_info (returning a useless device) was
acknowledged.  Jonathan has indicated the current device_get_match_data()
guard is acceptable, so no change was made.

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

