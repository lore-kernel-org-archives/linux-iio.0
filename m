Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087A3E7169
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706325; cv=none; b=RLvnJkAZduMtggdS6yYUmvCYSXufHlGXMbvb3AZRvrqtJSMjSnW1TQE0j5O7wLdC5Sg7NH7XU7Bl8FINkDY3nSbi6tu+oS3MtIm3qvTbJ0a2Ud40k5XNQ/hbLis4XKpQpRbv8lC+tjPm64KPMScFdNWD+FC93sr9P1sfeERDRk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706325; c=relaxed/simple;
	bh=jqPYoYhLKYYlSYtUJdzENTM/X/PaYeN8NKoJ7tNg6Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/mVR/I+0iZ6SlzCjeF/6+3PQ/36PYudI3VMz7C4mgoS+bxPEtfFcnGfylla0NlOuBXTx3c16Qy/YBRLUivBUhiz/Hzwgsgopfn+lU1V/vCj6F5X0ZZYiTO6CFLl0rLTGcQVrK+wNOMcjZI2gHc2PkaumAg4QEFKeqgDShvDPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=raPianl2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raPianl2"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3695bf7d082so8543537a91.0
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779706323; x=1780311123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkXrBYxTI0izj6VrJvaEKI7ARZ6dKBgJhCCnnbAo+Vg=;
        b=raPianl2aAU5SCgXT1HVAAaAbEst5RjcHjMgZMSXqTLot7y0CWP8Vg785j+ofSEHyf
         VE/E0xxZn+tKg01sy4UX9Vg/Woa6znSPJwk5e6UDE3gDKooskW6DohxST7/tHJ8s+yKi
         wNiaNRkzNlJDvTl6km/J/XyKabykRaM7y0imw+FDMEUIzVkv8EYeCXlUNG20pyiZlkHh
         leSvsUwJTU7jiKozkflJMBGzA+nJGpBUK1iIotWRdyw6nAh0FrROcy8YDRoQq5JuWCfT
         mAumT1LMHROhK+MZ9LZq673gFw9OzP3tx9pBoSw38rsZ+97PJ/4sNrFuR4KzOaiHd+L/
         9+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779706323; x=1780311123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wkXrBYxTI0izj6VrJvaEKI7ARZ6dKBgJhCCnnbAo+Vg=;
        b=dqFTTds7SpGdrQz/wIm8/FJsXIhTJr/0mLLROYgIOoJmNafjte/MRU2lcGJk9acFCm
         /fuQ93FYme7ySGbCwOUDbF2fzkviqIQ6jx0DM5wEjRubBbeLyGwdUxJzRlTB06z5B1cN
         onLN4HLZXU5ig5jdr7iPaq4APXoEUdlsYfa6OeqiYTgfgslkzRcSJ8r0tnUgON7jhk24
         n3ZI6nO19sQhWfuG3jOJR5WCFUDtFGOqaykFEC5vaZ8NNlAJsCmYHVVOkrZqAeuQUfWt
         h0Ho0kVwoiHytGwtHF7n99lolSzhpIkpHO7aAgcE3KlxcCJeipgeBKdYFKEM4TA+VIOM
         SvOQ==
X-Gm-Message-State: AOJu0Yw8jbDWHU8fBDJPjQxw8nqYh4J9v0WQJ5/m9ksE7VOY+PHvAjmm
	zLy2opnJDixNbVXj/xo8iQt+7RI6p29/Z/FZPvnuJPFpKBfVhE4HxEpcSJfNQknm
X-Gm-Gg: Acq92OFlrS7eCztVvnEyzG+XrEz6DTwgJgSAlHK4xCVEbzQWHljVYHUJ2A0smh+MsIC
	3SSVgtAh7r20agHAYkeL9h6ycDMFFRFkreOHIUK9ql42zia30YWYVLKQNbo03QaxlbGwH7lI7Ab
	Bw8AXQmcIoI7sF8M+gJbwE8EtFcd9RLBFenmkmw7kXV5UGLZz3R1DUCBW5wX1T7w4nR17rthhVb
	SPNfp9RtFkRQU4qFujX47IJm/8HPOngr4QUCM/oBGeHkQk7jsCWyLJ+beb5E6/vQ5knCXlLgcvs
	z5P/T1ufTkXv5Es1NbTWYJ/2WjCeT5w3uKVZ2D61cgM/mJDmlIiI96vMKCzh8gFtQ8IIvPomxra
	iaJHTTkCyFydCuqeIup14BP/x+KjTG/6HVQhasDtj5bTSuYe1GDk3kNu9XeNSyFN7XVwesUNKx4
	14bHfSZ2TkMvY1b/VAHKw/++9iQoTys0RNgPBQbeaSC1QDXAZ1wt3efz8WPMxSBK3uMLJuFOqie
	oRrVmhNX2lA2JREVrw3fVl3qU27X1RFlxByq8bruQ==
X-Received: by 2002:a17:90a:c88d:b0:366:10f1:3d86 with SMTP id 98e67ed59e1d1-36a67616988mr14689661a91.22.1779706323154;
        Mon, 25 May 2026 03:52:03 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:2011:e829:fadd:33b:8fc3:b2c8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7265a001sm9302388a91.7.2026.05.25.03.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:52:02 -0700 (PDT)
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
Subject: [PATCH v10 05/11] iio: adc: hx711: move scale computation to per-device storage
Date: Mon, 25 May 2026 16:21:21 +0530
Message-ID: <20260525105127.180156-6-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525105127.180156-1-piyushpatle228@gmail.com>
References: <20260525105127.180156-1-piyushpatle228@gmail.com>
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

