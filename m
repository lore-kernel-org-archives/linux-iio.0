Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5203A6B65
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443150; cv=none; b=WtzwfUCjI6mxCALA0LGMGnGDRHdagUr4cHWVxcP1JmSwk5NQOP6IKCzQOKLEpvORN/XjxDD0slEMA0iSLv9bn53vrHet9YlPw8B3G/vgDcerTMGgllRHpzGcLmcNLCMHByqF8TC1ZQtL0ZGGFVtRTChOT5dMoSYKwdZlDe7RAbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443150; c=relaxed/simple;
	bh=RRlULnfgdIr2LAuHXuYKNLgPv8/jvuBAfJgo7/rWLok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5YxErenxY/kwmjMmlV5sGluFKhrqu+Y36ulGEdJlNy95aYWtkVMTfmT8hHEw4wqiAkw7KYgVzDTlw2jKGuGG4NzCUAQ+r+YwnEfhkK4o1mBNpvY/UviBlJN20ht/WouaxWUKieAtGWRLPijlMv3h5QQCmmRJhQVmS7E+xK6gYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzsFhKcs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzsFhKcs"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso23302095e9.3
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 06:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781443147; x=1782047947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FJ773jx2YEe+XPJ7Me3c8yC1oo/Nugn9hSb+DWyils0=;
        b=lzsFhKcs7qRYkgzHgDZKJnZk43k9Ivkj4pUXIdXkbm/hs7XUWMpRM5VdQRVIyRxz9Y
         HjplCO6mu9tj6iWlET9LDEp5hOyJo+NgvBV48T/O35vwFE19/CDVPeuPX+19XLp/fqcW
         NRTEI9dRDKqNYcJf8X2gSDB3miHKiKCcoDxgOoRSfIOPrP5cXLNcQRNcFgkKCYEA0Er3
         4IHQx1nQiaBMTiovoreYvmdQGw44DB80C+xXBqnXSxBLVpkAHyPrRPpm0ZM/QAB5yChC
         Ip/PdsbogYCoZbuJeVPcjXjekpmqmXZq+hFJyjgcexCwuLg6sL1YZpLVkCUTgI+R+9zR
         5j0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781443147; x=1782047947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FJ773jx2YEe+XPJ7Me3c8yC1oo/Nugn9hSb+DWyils0=;
        b=sgGpl/BJWfg/8YCf98JSPdzYnoEWllSxFGZwNeYpuPMCvmHHEAcQ3MTsvdN2nQyqGv
         7awTuPC5LQxnVdqWlreJEOn4Fw41XK+lk9KyhRmr2fRi/BquwqH9DsqkYFEQmctmwh3D
         pgCkgnwj0HkDk6J1onuV3jGM92olazCsFjItl3+uxZpSMTUw0n1Ce5CAzJ243UHOhrnS
         EnIFP3Q+dhN20nEbaPqLs0p3dQJ/bIZBmU1B6VMtIj3//hes3yjMRvP16bB1x1uTNYTK
         2BWyvyqt6Neco+9gA4wHeznQAEz48SCVPRbYrfDGAvMVrG46uvgM+PlfCSkFLGI9g8qV
         A1aw==
X-Gm-Message-State: AOJu0YwYzTl7VE+0HdoArTVeEa4HGDIqhH+PFbk7Xa0GQbS1MXE3/3pM
	tMuY71lb7r70VYyVFkc7LJ0/gWO/GppxdTW+daLn2QS/RMyKFQkTdGq5
X-Gm-Gg: Acq92OFXnEyzHBg157i6YEH3TaaRoy1n3Gy6hv/Tr2O/voZnCozm8RzJNkpB5vvyxEa
	WHVAKe0IrLKJnqERD2Xk6SEGpj04u3JRtEHn3II6w5WULtQ/B1miRp2qic4CrPsytZxkGD4SGv5
	+hW0IJNtoRPCKsooqC8WMvXs2Zr7Sfz/VknVd+eRyNKqWIrsmKF+8cyKd2AS4TJt+tozfyBRjGD
	FDxVBsBsK+tM+VJevDtdHoo/lp3Ue4iGrP2WLV27Tz8giK2i8anNn59ZF8dA7WOJl2pfhIuROjW
	bnT3ocimu7mqWQ0V1R+lt5MMAmdaGjeRYhOqq0D4LLwDTbpmpqGJv2wVJ2uBVY2KuLgyNnL6wqW
	uvULsxt+/+skZbDDSlm3P3Tf9bnJ/20kHDas1NxBpbT9o8a5d8zRdne0cqkqHDF3nWDNsIgawV1
	KzAt6uQ7Q6B9WJVutKdawC71DeBo3pdU6BtRyKi0lvziCtWYOvy2uTa0g1q0F2yzt9Sc4Yr1VBZ
	WQ+tePEi42WD/gMzb3DzVJyFTwbM/oGYZXQ2NW6Erz7j0ro0KS//B+Q74PvUd3WKKW0xCMKJYl0
	AJttHWDmA52+sMhBQ35dTILltLLvig9ZAmpkP6Xt
X-Received: by 2002:a05:600c:548a:b0:490:3c15:7146 with SMTP id 5b1f17b1804b1-492200dc914mr78378995e9.19.1781443147307;
        Sun, 14 Jun 2026 06:19:07 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922037055csm168406355e9.13.2026.06.14.06.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:19:06 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 14 Jun 2026 15:19:04 +0200
Subject: [PATCH v6 2/8] iio: light: opt3001: use local struct device and
 i2c_client variables
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-opt3001-cleanup-v6-2-e3f5901dcc26@gmail.com>
References: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
In-Reply-To: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781443145; l=13602;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=RRlULnfgdIr2LAuHXuYKNLgPv8/jvuBAfJgo7/rWLok=;
 b=gb+ebUipkJOK3V6sdfcjxzPFRGD3uP7i/lVe80+ujwJkan9f5ZiGOaLEyHctf7IvaxT4m3Iya
 tNQ+M7x8gKYAUViAIMy3BAboDCstjPwB+ol+CGsW6KTr5nweluMD2ph
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Switch the driver to use local variables for struct device and struct
i2c_client and remove struct device member from struct opt3001, as the
former can be derived from struct client.

No functional change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 139 +++++++++++++++++++++++---------------------
 1 file changed, 73 insertions(+), 66 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 6a39f116f931..28455d887e1d 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -101,7 +101,6 @@ struct opt3001_chip_info {
 
 struct opt3001 {
 	struct i2c_client	*client;
-	struct device		*dev;
 
 	struct mutex		lock;
 	bool			ok_to_ignore_lock;
@@ -313,6 +312,8 @@ static const struct iio_chan_spec opt3002_channels[] = {
 
 static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 {
+	struct i2c_client *client = opt->client;
+	struct device *dev = &client->dev;
 	int ret;
 	u16 mantissa;
 	u16 reg;
@@ -326,12 +327,12 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 		 * doing so will overwrite the low-level limit value however we
 		 * will restore this value later on.
 		 */
-		ret = i2c_smbus_write_word_swapped(opt->client,
-					OPT3001_LOW_LIMIT,
-					OPT3001_LOW_LIMIT_EOC_ENABLE);
+		ret = i2c_smbus_write_word_swapped(client,
+						   OPT3001_LOW_LIMIT,
+						   OPT3001_LOW_LIMIT_EOC_ENABLE);
 		if (ret < 0) {
-			dev_err(opt->dev, "failed to write register %02x\n",
-					OPT3001_LOW_LIMIT);
+			dev_err(dev, "failed to write register %02x\n",
+				OPT3001_LOW_LIMIT);
 			return ret;
 		}
 
@@ -343,21 +344,20 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 	opt->result_ready = false;
 
 	/* Configure for single-conversion mode and start a new conversion */
-	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_CONFIGURATION);
 		goto err;
 	}
 
 	reg = ret;
 	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SINGLE);
 
-	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
-			reg);
+	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to write register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(dev, "failed to write register %02x\n",
+			OPT3001_CONFIGURATION);
 		goto err;
 	}
 
@@ -375,10 +375,9 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 		msleep(timeout);
 
 		/* Check result ready flag */
-		ret = i2c_smbus_read_word_swapped(opt->client,
-						  OPT3001_CONFIGURATION);
+		ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
 		if (ret < 0) {
-			dev_err(opt->dev, "failed to read register %02x\n",
+			dev_err(dev, "failed to read register %02x\n",
 				OPT3001_CONFIGURATION);
 			goto err;
 		}
@@ -389,9 +388,9 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 		}
 
 		/* Obtain value */
-		ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_RESULT);
+		ret = i2c_smbus_read_word_swapped(client, OPT3001_RESULT);
 		if (ret < 0) {
-			dev_err(opt->dev, "failed to read register %02x\n",
+			dev_err(dev, "failed to read register %02x\n",
 				OPT3001_RESULT);
 			goto err;
 		}
@@ -416,12 +415,12 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 		 * bit-overlap and therefore can't be done.
 		 */
 		value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
-		ret = i2c_smbus_write_word_swapped(opt->client,
+		ret = i2c_smbus_write_word_swapped(client,
 						   OPT3001_LOW_LIMIT,
 						   value);
 		if (ret < 0) {
-			dev_err(opt->dev, "failed to write register %02x\n",
-					OPT3001_LOW_LIMIT);
+			dev_err(dev, "failed to write register %02x\n",
+				OPT3001_LOW_LIMIT);
 			return ret;
 		}
 	}
@@ -444,13 +443,15 @@ static int opt3001_get_int_time(struct opt3001 *opt, int *val, int *val2)
 
 static int opt3001_set_int_time(struct opt3001 *opt, int time)
 {
+	struct i2c_client *client = opt->client;
+	struct device *dev = &client->dev;
 	int ret;
 	u16 reg;
 
-	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_CONFIGURATION);
 		return ret;
 	}
 
@@ -469,8 +470,7 @@ static int opt3001_set_int_time(struct opt3001 *opt, int time)
 		return -EINVAL;
 	}
 
-	return i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
-			reg);
+	return i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
 }
 
 static int opt3001_read_raw(struct iio_dev *iio,
@@ -565,6 +565,8 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 		int val, int val2)
 {
 	struct opt3001 *opt = iio_priv(iio);
+	struct i2c_client *client = opt->client;
+	struct device *dev = &client->dev;
 	int ret;
 	int whole;
 	int integer;
@@ -583,7 +585,7 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 
 	ret = opt3001_find_scale(opt, val, val2, &exponent);
 	if (ret < 0) {
-		dev_err(opt->dev, "can't find scale for %d.%06u\n", val, val2);
+		dev_err(dev, "can't find scale for %d.%06u\n", val, val2);
 		goto err;
 	}
 
@@ -611,9 +613,9 @@ static int opt3001_write_event_value(struct iio_dev *iio,
 		goto err;
 	}
 
-	ret = i2c_smbus_write_word_swapped(opt->client, reg, value);
+	ret = i2c_smbus_write_word_swapped(client, reg, value);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to write register %02x\n", reg);
+		dev_err(dev, "failed to write register %02x\n", reg);
 		goto err;
 	}
 
@@ -637,6 +639,8 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 		enum iio_event_direction dir, bool state)
 {
 	struct opt3001 *opt = iio_priv(iio);
+	struct i2c_client *client = opt->client;
+	struct device *dev = &client->dev;
 	int ret;
 	u16 mode;
 	u16 reg;
@@ -652,21 +656,20 @@ static int opt3001_write_event_config(struct iio_dev *iio,
 	mode = state ? OPT3001_CONFIGURATION_M_CONTINUOUS
 		: OPT3001_CONFIGURATION_M_SHUTDOWN;
 
-	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_CONFIGURATION);
 		goto err;
 	}
 
 	reg = ret;
 	opt3001_set_mode(opt, &reg, mode);
 
-	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
-			reg);
+	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to write register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(dev, "failed to write register %02x\n",
+			OPT3001_CONFIGURATION);
 		goto err;
 	}
 
@@ -688,13 +691,15 @@ static const struct iio_info opt3001_info = {
 
 static int opt3001_read_id(struct opt3001 *opt)
 {
+	struct i2c_client *client = opt->client;
+	struct device *dev = &client->dev;
 	char manufacturer[2];
 	u16 device_id;
 	int ret;
 
-	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_MANUFACTURER_ID);
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_MANUFACTURER_ID);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
+		dev_err(dev, "failed to read register %02x\n",
 				OPT3001_MANUFACTURER_ID);
 		return ret;
 	}
@@ -702,29 +707,31 @@ static int opt3001_read_id(struct opt3001 *opt)
 	manufacturer[0] = ret >> 8;
 	manufacturer[1] = ret & 0xff;
 
-	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_DEVICE_ID);
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_DEVICE_ID);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
+		dev_err(dev, "failed to read register %02x\n",
 			OPT3001_DEVICE_ID);
 		return ret;
 	}
 
 	device_id = ret;
 
-	dev_info(opt->dev, "Found %c%c OPT%04x\n", manufacturer[0],
-			manufacturer[1], device_id);
+	dev_info(dev, "Found %c%c OPT%04x\n", manufacturer[0], manufacturer[1],
+		 device_id);
 
 	return 0;
 }
 
 static int opt3001_configure(struct opt3001 *opt)
 {
+	struct i2c_client *client = opt->client;
+	struct device *dev = &client->dev;
 	int ret;
 	u16 reg;
 
-	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
+		dev_err(dev, "failed to read register %02x\n",
 				OPT3001_CONFIGURATION);
 		return ret;
 	}
@@ -750,17 +757,16 @@ static int opt3001_configure(struct opt3001 *opt)
 	reg &= ~OPT3001_CONFIGURATION_ME;
 	reg &= ~OPT3001_CONFIGURATION_FC_MASK;
 
-	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
-			reg);
+	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to write register %02x\n",
+		dev_err(dev, "failed to write register %02x\n",
 				OPT3001_CONFIGURATION);
 		return ret;
 	}
 
-	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_LOW_LIMIT);
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_LOW_LIMIT);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
+		dev_err(dev, "failed to read register %02x\n",
 				OPT3001_LOW_LIMIT);
 		return ret;
 	}
@@ -768,9 +774,9 @@ static int opt3001_configure(struct opt3001 *opt)
 	opt->low_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
 	opt->low_thresh_exp = OPT3001_REG_EXPONENT(ret);
 
-	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_HIGH_LIMIT);
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_HIGH_LIMIT);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
+		dev_err(dev, "failed to read register %02x\n",
 				OPT3001_HIGH_LIMIT);
 		return ret;
 	}
@@ -785,6 +791,8 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 {
 	struct iio_dev *iio = _iio;
 	struct opt3001 *opt = iio_priv(iio);
+	struct i2c_client *client = opt->client;
+	struct device *dev = &client->dev;
 	int ret;
 	bool wake_result_ready_queue = false;
 	enum iio_chan_type chan_type = opt->chip_info->chan_type;
@@ -793,10 +801,10 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 	if (!ok_to_ignore_lock)
 		mutex_lock(&opt->lock);
 
-	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_CONFIGURATION);
 		goto out;
 	}
 
@@ -815,10 +823,10 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
 							IIO_EV_DIR_FALLING),
 					iio_get_time_ns(iio));
 	} else if (ret & OPT3001_CONFIGURATION_CRF) {
-		ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_RESULT);
+		ret = i2c_smbus_read_word_swapped(client, OPT3001_RESULT);
 		if (ret < 0) {
-			dev_err(opt->dev, "failed to read register %02x\n",
-					OPT3001_RESULT);
+			dev_err(dev, "failed to read register %02x\n",
+				OPT3001_RESULT);
 			goto out;
 		}
 		opt->result = ret;
@@ -851,7 +859,6 @@ static int opt3001_probe(struct i2c_client *client)
 
 	opt = iio_priv(iio);
 	opt->client = client;
-	opt->dev = dev;
 	opt->chip_info = i2c_get_match_data(client);
 
 	mutex_init(&opt->lock);
@@ -885,7 +892,7 @@ static int opt3001_probe(struct i2c_client *client)
 		}
 		opt->use_irq = true;
 	} else {
-		dev_dbg(opt->dev, "enabling interrupt-less operation\n");
+		dev_dbg(dev, "enabling interrupt-less operation\n");
 	}
 
 	ret = iio_device_register(iio);
@@ -905,6 +912,7 @@ static void opt3001_remove(struct i2c_client *client)
 {
 	struct iio_dev *iio = i2c_get_clientdata(client);
 	struct opt3001 *opt = iio_priv(iio);
+	struct device *dev = &client->dev;
 	int ret;
 	u16 reg;
 
@@ -913,21 +921,20 @@ static void opt3001_remove(struct i2c_client *client)
 	if (opt->use_irq)
 		free_irq(client->irq, iio);
 
-	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_CONFIGURATION);
 		return;
 	}
 
 	reg = ret;
 	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SHUTDOWN);
 
-	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
-			reg);
+	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to write register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(dev, "failed to write register %02x\n",
+			OPT3001_CONFIGURATION);
 	}
 }
 

-- 
2.54.0

