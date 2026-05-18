Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F782F7F12
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141780; cv=none; b=lRIKR7GnVRvhvBzdprQ1RgoJVsD66Lf4qzovr9YEpUDtOV9PdYe7VazQfsg5sb7zWzBLVpxuf2q7kK2HFxAGzm9Zoe0UMS8NQA5TU/LGiA2kcMctD42tC56ySa52bzUqNFqvPjHLSl4t7Kvf7Nhi1Uk10g3E+VOSdrXNmu8rxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141780; c=relaxed/simple;
	bh=YIgzdEh/qr3hlX5d3x7wEDgkdp098G1nkKAjjuV5Y7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hpb0EF428nhmr8VcdkduDrF4wT8lXCBT2gWKun3ZHHuSR2oUYnYRIZ4ZXW2DgKHkSnoiNRpQHe9GMnhy1gNca9jGAQ/GjbQUkvxHYFbPRn1lwOb8vt0qIFkFNxk4zOH6gSVxVV6MW0qVy/0nBwmghT2WQLEayrJqp3wJ5Md2zoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uzmnk/Mb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uzmnk/Mb"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so1983497b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779141778; x=1779746578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvK2VJD8fl/Rjr0aAvzpby1wY4IjpgTnX0YvfLJpkFQ=;
        b=Uzmnk/MbTBsVOb9lDVD5zubjipoeduNTWfuI6vYvMENntdWqcHbhR3rqCMjyDO7m5n
         auY7hJNcvxvxnyypYDEZArlZVan4aEpI3wx0aueuGx/RG6n39LMWEaTJ0X8QnoeXRo6C
         AZ7zRVHkIa8XnF1GdcgZMGTXJfOgmByPIk8jpcI0YyLDdMpmbwViwD9KOGOxGcKHjr0V
         RbvvMwuHwV7OLK24jO09udZncwfSx6lDRcAclXB8dveVz+OXv7fpWZdElpnyhix1q35e
         uIQk7qpZS67XjpagzhH1/a4DN92RjAdIQGvyuGI2vidSowntKFPvc+WnKOjTmuHJnmrN
         2DXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141778; x=1779746578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bvK2VJD8fl/Rjr0aAvzpby1wY4IjpgTnX0YvfLJpkFQ=;
        b=Vu8LJRh37jbXGOLvjQuWNTj99N2kYz3XCDHfz8+Gv8BblpafbyogEarLtyH+mQbQKF
         g4v8Zs/FIg2szhqDKYBRwciGnB9XyDa19S1vrUjky+sMCVSsGAMXlzq1k15OSbnc+L66
         x8GIRslKOf61/JhlHkDWVx9TrUM27Y2rnrDwFddjbXBW1jpWnSVrdQQm1vJD5hEApyeb
         ymv4+JhtqLnWfiPo3MBfRC7I68JWULEWnNxOCFr09oZIDpDYAFvM2saHJkrxK3WD+DrK
         wx8uL8+DTVaVqWPTfjPS+osYwBiAiw1ck+WWNFWzaSi27nqlkb6m11x04m/Cbgm9yk8i
         EtEA==
X-Gm-Message-State: AOJu0Yw8VxXVlUD7YLCwqstuyIpxWXoFNgw4S0o7kzNgRhGqziR9DsOc
	xcZK2+3smye1GBqfBsI621SPmb1dqsdvtfHeZQulljYAFKFA60advuhR
X-Gm-Gg: Acq92OGYFHrd4xA6UGGqWWv3L13h0WrPQxVW1nl6O1n0/Z+Axhqo7EBF3Er+fd/sKGV
	u7DPoe05hJvc0q3YMR+/PWLacqIG24Bc0Fn+uBgiBx6J4w9pH0vXTU1cehmBel97+mm/rsNBclI
	tZyWIGEHMQojKeeRHmbo8R4sx++osVLRSFnQnIfeXP25POi4VvUDfQXMoJ5fTSpronvImviK8KB
	d5/dBEnJ7c2eKHDorSeHdb5gJIGFkt4IlwS805KwTr3c9IsM/bo+3L8Q9iIK3BM97jA0o5n7RG9
	3F+LRv8lN0NwlMTTCRdBuU/YLJwn3cgFj0+XnxbQDcLqFXkMexIyNSVSwlb4f5EO3ExXZncLO8m
	JiTaMhcVxaOCQBPNlgkrnLc9lw+aeg+6UXXarw94gn6oTs0zKogf5mNx5G4zHHZ1Bogd+8FVLXG
	clbU8L+3qTaPnGoo8Z52hofnLYf5tg9LNiFc3RjD5kfKWVcLuVGgv8dhtJIByv75Cm8F+zCMJot
	F7W8Dv0NgLM0rRgJTZTuDc0FAfg76Gtnc349UQdJ0+bC9grm3khWEhrByRO+haQYWOYgVY=
X-Received: by 2002:a05:6a00:2d19:b0:82f:a89e:e16f with SMTP id d2e1a72fcca58-83f33b2f58fmr17303350b3a.14.1779141777904;
        Mon, 18 May 2026 15:02:57 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977b128sm15772960b3a.22.2026.05.18.15.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:02:57 -0700 (PDT)
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
Subject: [PATCH v9 05/11] iio: adc: hx711: move scale computation to per-device storage
Date: Tue, 19 May 2026 03:32:21 +0530
Message-ID: <20260518220228.63322-6-piyushpatle228@gmail.com>
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

The gain-to-scale table is global today, so probe-time scale updates for
one device overwrite the values used by any earlier device instance.

Fix this by making the gain table const and storing the computed scale
values per device in hx711_data.

No functional change for single-sensor configurations.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
No change from v8. Already applied to iio.git testing branch.
 drivers/iio/adc/hx711.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 1db8b68a8f64..86d2a70dd3de 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -28,22 +28,20 @@
 struct hx711_gain_to_scale {
 	int			gain;
 	int			gain_pulse;
-	int			scale;
 	int			channel;
 };
 
 /*
  * .scale depends on AVDD which in turn is known as soon as the regulator
- * is available
- * therefore we set .scale in hx711_probe()
+ * is available; it is stored per device in hx711_data.gain_scale[]
  *
  * channel A in documentation is channel 0 in source code
  * channel B in documentation is channel 1 in source code
  */
-static struct hx711_gain_to_scale hx711_gain_to_scale[HX711_GAIN_MAX] = {
-	{ 128, 1, 0, 0 },
-	{  32, 2, 0, 1 },
-	{  64, 3, 0, 0 }
+static const struct hx711_gain_to_scale hx711_gain_to_scale[HX711_GAIN_MAX] = {
+	{ 128, 1, 0 },
+	{  32, 2, 1 },
+	{  64, 3, 0 },
 };
 
 static int hx711_get_gain_to_pulse(int gain)
@@ -56,22 +54,22 @@ static int hx711_get_gain_to_pulse(int gain)
 	return 1;
 }
 
-static int hx711_get_gain_to_scale(int gain)
+static int hx711_get_gain_to_scale(const int *gain_scale, int gain)
 {
 	int i;
 
 	for (i = 0; i < HX711_GAIN_MAX; i++)
 		if (hx711_gain_to_scale[i].gain == gain)
-			return hx711_gain_to_scale[i].scale;
+			return gain_scale[i];
 	return 0;
 }
 
-static int hx711_get_scale_to_gain(int scale)
+static int hx711_get_scale_to_gain(const int *gain_scale, int scale)
 {
 	int i;
 
 	for (i = 0; i < HX711_GAIN_MAX; i++)
-		if (hx711_gain_to_scale[i].scale == scale)
+		if (gain_scale[i] == scale)
 			return hx711_gain_to_scale[i].gain;
 	return -EINVAL;
 }
@@ -82,6 +80,7 @@ struct hx711_data {
 	struct gpio_desc	*gpiod_dout;
 	int			gain_set;	/* gain set on device */
 	int			gain_chan_a;	/* gain for channel A */
+	int			gain_scale[HX711_GAIN_MAX];
 	struct mutex		lock;
 	/*
 	 * triggered buffer
@@ -290,7 +289,8 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
 		*val = 0;
 		mutex_lock(&hx711_data->lock);
 
-		*val2 = hx711_get_gain_to_scale(hx711_data->gain_set);
+		*val2 = hx711_get_gain_to_scale(hx711_data->gain_scale,
+						hx711_data->gain_set);
 
 		mutex_unlock(&hx711_data->lock);
 
@@ -321,7 +321,7 @@ static int hx711_write_raw(struct iio_dev *indio_dev,
 
 		mutex_lock(&hx711_data->lock);
 
-		gain = hx711_get_scale_to_gain(val2);
+		gain = hx711_get_scale_to_gain(hx711_data->gain_scale, val2);
 		if (gain < 0) {
 			mutex_unlock(&hx711_data->lock);
 			return gain;
@@ -386,6 +386,7 @@ static ssize_t hx711_scale_available_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
+	struct hx711_data *hx711_data = iio_priv(dev_to_iio_dev(dev));
 	struct iio_dev_attr *iio_attr = to_iio_dev_attr(attr);
 	int channel = iio_attr->address;
 	int i, len = 0;
@@ -393,7 +394,7 @@ static ssize_t hx711_scale_available_show(struct device *dev,
 	for (i = 0; i < HX711_GAIN_MAX; i++)
 		if (hx711_gain_to_scale[i].channel == channel)
 			len += sprintf(buf + len, "0.%09d ",
-					hx711_gain_to_scale[i].scale);
+				       hx711_data->gain_scale[i]);
 
 	len += sprintf(buf + len, "\n");
 
@@ -511,7 +512,7 @@ static int hx711_probe(struct platform_device *pdev)
 	ret *= 100;
 
 	for (i = 0; i < HX711_GAIN_MAX; i++)
-		hx711_gain_to_scale[i].scale =
+		hx711_data->gain_scale[i] =
 			ret / hx711_gain_to_scale[i].gain / 1678;
 
 	hx711_data->gain_set = 128;
-- 
2.43.0

