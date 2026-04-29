Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E93405F7
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 05:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441581; cv=none; b=RIoaOxKPHhGOMH5Wdhi1m3W8TYuKPhikdaPLJe9oL0zMRH8zxCUELz8/W8EscnVGui8qFhaS0z6ZG7bd4/uNBDzpZi4q4aQSE0nCD3ZWoAuFrYy13bwLBvbMkIgkReRIUxjNR0RDcHdOGShthtS7PjsFaGQNYE76zrnxdyXkm44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441581; c=relaxed/simple;
	bh=2qGN2/JyY+PW6JisHDd1B4IGPJkoaZpsrPLx3iP/KD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5IPg7NjVCrA0Sqj3/YIKkFrUwRRjXQJCLPdOUX5l54jXC1iBP7I5m4tlIZG8kMJ5M9PzJ0JzPVXoqc3Pw3UegPl2Wsfw3L5w91PY+BGvuw2nDMYXq4y28jqG26G8OHrYgtHXCD12bctOp5Opir8pVX5WjjNMaSwm/m9qHKkx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cayF7/Hg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cayF7/Hg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b4583f0a1aso76979705ad.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 22:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777441579; x=1778046379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AugfgYXfL/2aKKIAu18a96jQgE8unArPdW53FSnoNU=;
        b=cayF7/HgnC52gvZlADdmjoSDAZqSN/OUVMv7VaEZgmOLzcue1rlUTXH65kbF1IqWuE
         Q3WRNzQhE6/AZmZNOOrHJPUYMbkNT4f1huk62tc2DEymqM7WOscGxExurYlAGiIDPsbt
         R7Ez6Wm/+DLbkMVxA71q7xP9+lIG63FIOPy5aS+bZDxkS1dcqqzgdJbZfYB5AGABqxDx
         t79wlRoEfPammYsJeVh1pO/fe8OlGLIDCABmdLPQx+ySmzKQkTM5Ll9sKtN1z+y7DDSt
         KjXz13q5N+nPm0PIgWkQ2ZszFtbjkVaSClQhEJpy0TSjX3xvRl0BnKokAKU2zaj+1xcc
         hu/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777441579; x=1778046379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6AugfgYXfL/2aKKIAu18a96jQgE8unArPdW53FSnoNU=;
        b=VjMsJgGMGnNd2eo+tt3jwNMEhrb92bnoBa5SHF3szuibvkP5je8JRqrdkvYRzcO2jk
         kdvsYdxlO1EVXj0FTkEQSUTYsyWOIA/jIfDkOMvLjqsBBCR0SVzfsiNWOyrblotu6Sp3
         1Xj6vOjPb0888FHkgzJv7llMC6oVRbqC7iDyRZ6So2+fBdEqA0tnAiKGvGcTOPTaBukH
         Yvhh8uGbQtPGvod9sgsUcCUSDreVbbFCgOg1O9e2uq4DPAz01QnaoB/IeWYRqvisRqNv
         zAoaxv9iqV58l3u43uM+AqzPrvkvbnOp4v63kIxgbDiQ8qAl4VUgdTcVLR4p79pmjB0L
         ye3A==
X-Forwarded-Encrypted: i=1; AFNElJ+TPXTZtaa6XFyCQL1nPTJ16zT6ZYgpQGJX/ttrONOMMnIoftL0J1jsDZrTFiIsk6rgxeK7ZtU4Vl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkFE/KfiqUUnqryxLrV031Z1zp4uNkHoylDSjI6T40/ZnBw2Gb
	7cTgtXarOzS0dyzPtF5Av2ZPNzzpsvg1lfKpVYGWF85nws+1HVJd0uMF
X-Gm-Gg: AeBDieuwccLZjGhFgYeSH0Ye6f9iyTdCZ6zWX820GZcQTfY4Thva6/KIwbifF/dJGk9
	c4dx8yka1TaLMSOz7a7Q3b3POcfz/HV4jLwxNS+q5tAvOfUKG05M1ipXYQOypwzeTiR8wjZJoxn
	fP4nwGb/5EXizQSdFt2JmDcsBl8/xL9OMLF7F7SRQ9PFNeD6kDGc/FyEd+Xkd6+lMd6s8CUgSNG
	xzLj0ndj1rsn6GD573vElJikjRi5othuIS4WBug0JdEYLxQXJSV4ldedqS4ALlKGWyWfCiMbTIE
	5w9ECDr4hA9TrTA06AvpKHg2Y2gwlz9VRtuW+VPhhUVr1+pLWeYAlfaR6HatJ5SSXnmFrAgciUb
	wvQMCVNZ5f3OTD9GEPDv28pHoQTfY0ZEFKRFPMOhlHdQ6ZqkyvDO+ln7tO+UQqFeNegFls41hm0
	5MF2OMtyIYgoGagyJeeItrhOwKnBZFdSNbg7yMquOQ5q6LuqaSo4DJEdjUUmk1Uos0AYdo7evdK
	5QWNBeyKrDa5oVOBUYSgo0ul8BTdeXIL3tpniqpPGnHcXF99w==
X-Received: by 2002:a17:902:e34a:b0:2b0:4579:ae6 with SMTP id d9443c01a7336-2b97c4cb993mr46159175ad.38.1777441579261;
        Tue, 28 Apr 2026 22:46:19 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:5fb:20b2:c2f6:85bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879656dsm9346365ad.25.2026.04.28.22.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 22:46:18 -0700 (PDT)
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
Subject: [PATCH v5 06/11] iio: adc: hx711: introduce hx711_chip_info structure
Date: Wed, 29 Apr 2026 11:15:39 +0530
Message-ID: <20260429054544.123862-7-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429054544.123862-1-piyushpatle228@gmail.com>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
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
Changes in v5:
- State explicitly that this is preparatory for adding another
  HX711-compatible variant.
- Move linux/array_size.h and linux/dev_printk.h here where they become
  needed.
- Use "missing driver data" for the NULL guard and preserve local
  declaration ordering.
Changes in v4:
- New patch split out from the earlier refactor during review.
- Keep hx711_chip_info fields in their final order from introduction.
- Add the NULL guard on device_get_match_data().
---
drivers/iio/adc/hx711.c | 43 +++++++++++++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 8485e18c949d..666f64284a0d 100644
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
@@ -456,11 +473,19 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
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
-	struct device *dev = &pdev->dev;
+	const struct hx711_chip_info *chip_info;
 	struct hx711_data *hx711_data;
 	struct iio_dev *indio_dev;
+	struct device *dev = &pdev->dev;
 	int ret;
 	int i;
 
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
