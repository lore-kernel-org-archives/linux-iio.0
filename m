Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75AE477E53
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512576; cv=none; b=o0QaR6iSV3OsTgJw7DNRSPUMQ5ocfNBzqDn2hJsNCoW3fS3wGXPp30AT7nZPrcnKPly7/fg3TuRUebsplLJngttuDk9kFWtELB+o/HWEaAbjgZWvo4WF1pYHzmLTlxmDgX9khS5Lem6cpWMGCGpgqLjNhSGV0mjrSRpHeXOaTnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512576; c=relaxed/simple;
	bh=jqPYoYhLKYYlSYtUJdzENTM/X/PaYeN8NKoJ7tNg6Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p7eP27Qws3m057aYx9V5zN5kHUF9KJtHnffYQ8c38IUVeA/aM2j6PCfiBXrbDMx28vJr+/UjOLKVbYqfiC7GEJ3yDSJuXEAcxrBzcINq/bCMFer22idHf0qbbfJZ6S+rIzRFYZODcA/eugP9hs15CKfl8aRGOUcZwSyoLKRF6Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yzy3Q5S7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yzy3Q5S7"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c1e0d00bso40479685ad.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780512575; x=1781117375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkXrBYxTI0izj6VrJvaEKI7ARZ6dKBgJhCCnnbAo+Vg=;
        b=Yzy3Q5S7xRpSvgKbXL2m//3ISfmDZzQyuEqhDXZ7zCKdMyYQ/UtTQcyDF/uwjBGc8p
         VrQsOY34uncrrVojK7OWMQ0ePx6vWaer2+WMDU7ElW1lgiNqyQpkZJvKy/pRpNgg6a32
         Rz/4SWDqlo03Jofz51ZGCE79J4Iae3JyhHoaV9JAi0AgFTVsTAndAmOLe+e3Vx1l5zIh
         CyzIf0LR4xy5UE/ju+SHrv0W8R89G0zXYGAYx7SKJM31sX0yNz8KCna0Xn/CFJgTPXhm
         5k68CCWnyWBB1rDZdMWIL4gJJVThOaIH/RNiABsxGY0Tsskp3KItHNdB9EyR9uAr3Cob
         cWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512575; x=1781117375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wkXrBYxTI0izj6VrJvaEKI7ARZ6dKBgJhCCnnbAo+Vg=;
        b=XJrdsd6RKKXK0hUs/EqnRbaIjp0izOsaa62FVd0Oetkwfl7UlxPUGfsOAnC5BiAQV0
         AqMA6wFykMfABbFzjc5vdB/sa6q90sPD+ln2GhJkV4bdmM7HO21L4FusXgv6pRVn2A8V
         6G3tbP0MCdsjrVpjSF30UNJtzbIcNmGkoLbUP+3CU7GarrNAKDZm7xbmg4iVUw/4ANJj
         4rbVZWeYT1W5qgmzT1LftTyraEM7YSpwPV78yQsqE9Odhk+9bi0tuhPdBI8z18gc/De8
         NjbZyKoDu8+y5GabPAHDiJOlES/MIou7is4xJpwraR9pPLXi3ISpksgB/2KNHxeDvoTw
         w8MA==
X-Gm-Message-State: AOJu0YxtMKU4AxNS3DqGG1MSNLxrnp2ODMD89KOXxavNgGde/tw85c1s
	7x3acfrasM4H+mpCUepsDfru4z1byCMoMn/5qcYQZSDXS/nkJKdvThBex+YoDA==
X-Gm-Gg: Acq92OGTLWuaZePEqJDJFU4h1RiEZ5r0xxsAe6bUYeIA2uhnvnAlNXyD7F3A9tOkIbX
	AowOIMlM01vPhl9ie5riOFaemHkqtP+yIAj41g3KLQO4FVg0dRI/21AuRz3QW8wh292APOBUQap
	FyinwGMfWe8E1rF5Sn67kY7v/la9y14xUoiO+uJNYMr8hYZVwGIyrTVfeNN/8t5stJZcUtD1loR
	nPExGspPvmpLRIaRXgqySKj4ABgimksurf526sE8xT9tcSH6XWcq+02tPlpItbWs2PsPQjtmbH8
	tnwuPdH7nHrtlrwe/IuMH2vkwDqnf7c4x+bFQ5s0utPGGhKrMictvV+Myv+9T/+0vWW9XG6R7gp
	RTRqW9bkhGJCCQjZ7vGAS9jBAZh4DWtI4pRp3bBV3Q2+RMiubO+pf8ASW6aiZEfBSiUoGvR3ybH
	Z4kE5xw6JOkMp4Xc3bfcLozo9QusJcYTmH0LyTnIUm3H8evNaMt4EoNgABYgMPKnxxQbx8H/7zB
	UxoC4CqqfUiN7lCeqbp4ZgihRDl4vvTpBoWnYBN6TquzoDNQHfydg==
X-Received: by 2002:a17:902:e5cf:b0:2b9:6458:1a2c with SMTP id d9443c01a7336-2c163a49fa1mr51737065ad.13.1780512574915;
        Wed, 03 Jun 2026 11:49:34 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2409:40c1:4015:6e6f:ee79:7998:9a6f:65e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d59csm32139675ad.4.2026.06.03.11.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 11:49:34 -0700 (PDT)
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
Subject: [PATCH v11 05/11] iio: adc: hx711: move scale computation to per-device storage
Date: Thu,  4 Jun 2026 00:18:53 +0530
Message-ID: <20260603184859.89693-6-piyushpatle228@gmail.com>
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

The gain-to-scale table is global today, so probe-time scale updates for
one device overwrite the values used by any earlier device instance.

Fix this by making the gain table const and storing the computed scale
values per device in hx711_data.

No functional change for single-sensor configurations.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
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

