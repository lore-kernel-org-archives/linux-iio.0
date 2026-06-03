Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7DE3E51D8
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506779; cv=none; b=HT6F79Zjwqt+1dUeC0FrYwkRynJVYA39vUtrN/mTOBJou1T3tpaE4sueG0dnbrPwuIyem8cdVQzwDY/N7omepMnaejKkygnVVUTUnEdc76LPwnkU9jOZnZRygYy+Ku/zBRyKhnzTtdMkPZqTSXbdizBCuQtPjMx9auiuiuairkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506779; c=relaxed/simple;
	bh=UbnijoFxISD3PLOdi16aV450N7OVHX/fvpdUD5RitaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EMeoUCudtPy17iZYOOuJ8HjSNIhVy9Gvq7jBhN+dZcwdd+XsMgGpR662+X8YnpUIM+AatxDu+ioDfaLS00yNn8UNL27XwJVvdTQ088RSMn9TjN7swRZ63YOdP1cZCGLrpt+Sk1Xk55nMnlEoDaIoleE216AFEZ1RwUaXnr2i2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFOga5K2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFOga5K2"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45fe59255beso2410404f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 10:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780506776; x=1781111576; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=We/M6X3ECs+FNGq2oecfl9rIF1LYGFQdK9y85nZ/zJY=;
        b=VFOga5K2ZH0SUxqrMwZE/oITHoj8025mWBUQDJvfWuSCBf/Za9elHR+W+nkBABnoBl
         faXXqK1KTlik0ppr4c4Jt6RzkkehVcPLyBC69qtvQTliV2U3lvngK0nV6Pks5eZ1tqaW
         De2zDbsdxnMNKVuuNgED8km8vPypM3auRRfMu0oDGU/erddF0bsu1UbBvEeYDv92A3Xv
         1yH1Pi0zyEkdxAFE7ksxeF1eCIxAmP1IgQuJ+LBfgSAl+bro6IaLQz43wm7mZOMXSr8c
         f3AYAM6RWtNYut28nope6NLBQJtWxTY0qbCTPSDLp9whv8P5JxX7UWLDtgPsaxTqGvuR
         mh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506776; x=1781111576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=We/M6X3ECs+FNGq2oecfl9rIF1LYGFQdK9y85nZ/zJY=;
        b=H3553ONyGIdYQDkIG//9KTapiwIAJtS5cqqGclZObEwCE63/+1k3TgOooTUVFOksVj
         jorfkPT2E7XeyBeRdDhEdKAP2kbuxrEIK7zWZvIDpanQGw9CVznyX4kjA5A7qwT6jgHy
         rnLzfsb8Qs8M3Lv47ooz+GSAeAVjccXO9INa3CdGhDw+Y+w6TDG41rYPW9+yxEIm4maV
         1URUxVfaAI3kokoIieK+5gNswVKhLL+ejQN/0KMtKHjGoPEXaP9PVbb4lohlizUwsHaw
         NsxJvAetJivGDV54EqIJirLhDSPBJAbTGazysLseK8E3B1zNrUd4FO2QrvlMvhIuzXVj
         LlxQ==
X-Gm-Message-State: AOJu0YyEoILLabPW8nbBU51kAAlQr9hfFlOsV+YatEIpLWZmVJJ2aMY3
	hqDpVx/6eao0NLTBMhW4qTYOyPAnQyDJzFPiH8nJUMb4G/PLHeQ36Z6k
X-Gm-Gg: Acq92OHeWwRblAv7Dq+cY5eXtanS7Xx3qeM03fc/4j92oSbK8haxkrbZ1YMZTcGeXNg
	/oVZ0V4oGjMAL0QDF7vb8aUeOmpL2YubMK/oPX5galP6NJmW7U27zC83KMyxzYjdbQuenIbA3GL
	Kp3HcdGXGAUgCI2jySU89KSdM2HRoXsAoJ5uTgh7U9PSMAtQfyyxPfYxPQHMpo7nw/jAaQar3GT
	mdRfBMnnbBd09MamrIvXRfhE/GJnp2uL8dQwl9zGHyumdwWknKs6QUXfVnffWoVNLCP/y3cFf92
	pRPBR4se/xppL2A5FvDBiZAg5gOzBnsPj8XMBuKrkSMwf2kUsFKptHPMrQHQh7VzLAVci/a1hxr
	YIudEftLsbq6lBJYX2iHNhBHzB3DgNjKL6qdtDl95AEZ8IP8WhuMfFpi2hacCZEQFbLSLcFNl3k
	FU7TuxnKEYlsvOZyDvkQKKzYeubToWA+tteumKUYNxnf8XEsAD3n2/s2fYTjCLwPdKFmQRHicrc
	+vyzXZyZgZho4WdIAwCt1lOE/+1J3/N6AsSNTEj+5h9nat42RFs+Bne7GvJHrlSWz3mCCI7zfkx
	hGb7+2btKJhWRbBFJ6EjBjafrEECcCCDpBMhqrLHR3RyiRhvBfw=
X-Received: by 2002:a05:6000:4692:b0:460:2477:2277 with SMTP id ffacd0b85a97d-4602477246dmr2331756f8f.31.1780506775606;
        Wed, 03 Jun 2026 10:12:55 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm8797506f8f.17.2026.06.03.10.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:12:55 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 03 Jun 2026 19:12:53 +0200
Subject: [PATCH v5 2/8] iio: light: opt3001: use local struct device and
 i2c_client variables
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-opt3001-cleanup-v5-2-3ef7b926d555@gmail.com>
References: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
In-Reply-To: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780506773; l=13720;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=UbnijoFxISD3PLOdi16aV450N7OVHX/fvpdUD5RitaM=;
 b=R8gSN9bh+XegbKEh8SADCm5m5qFb7D2BwLWV0zve8zfM28I5odE9QsEHFl5JuP1Z8hxFh0Kvn
 PdOqihcfgenDQYrH1+9EneniGzHtrucgqfa5WE7KOD37vnQt6XNezeO
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Switch the driver to use local variables for struct device and struct
i2c_client and remove struct device member from struct opt3001, as the
former can be derived from struct client.

While at it, ensure that parentheses alignment is correct in functions
that were changed in this patch.

No functional change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 149 +++++++++++++++++++++++---------------------
 1 file changed, 78 insertions(+), 71 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 6a39f116f931..efaad85dfaf3 100644
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
 
@@ -688,44 +691,48 @@ static const struct iio_info opt3001_info = {
 
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
-				OPT3001_MANUFACTURER_ID);
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_MANUFACTURER_ID);
 		return ret;
 	}
 
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
-				OPT3001_CONFIGURATION);
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_CONFIGURATION);
 		return ret;
 	}
 
@@ -750,28 +757,27 @@ static int opt3001_configure(struct opt3001 *opt)
 	reg &= ~OPT3001_CONFIGURATION_ME;
 	reg &= ~OPT3001_CONFIGURATION_FC_MASK;
 
-	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
-			reg);
+	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to write register %02x\n",
-				OPT3001_CONFIGURATION);
+		dev_err(dev, "failed to write register %02x\n",
+			OPT3001_CONFIGURATION);
 		return ret;
 	}
 
-	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_LOW_LIMIT);
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_LOW_LIMIT);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_LOW_LIMIT);
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_LOW_LIMIT);
 		return ret;
 	}
 
 	opt->low_thresh_mantissa = OPT3001_REG_MANTISSA(ret);
 	opt->low_thresh_exp = OPT3001_REG_EXPONENT(ret);
 
-	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_HIGH_LIMIT);
+	ret = i2c_smbus_read_word_swapped(client, OPT3001_HIGH_LIMIT);
 	if (ret < 0) {
-		dev_err(opt->dev, "failed to read register %02x\n",
-				OPT3001_HIGH_LIMIT);
+		dev_err(dev, "failed to read register %02x\n",
+			OPT3001_HIGH_LIMIT);
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

