Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5D1471262
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 18:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789927532; cv=none; b=qCVxL+u82c/weT27VDz4ctyftnpUWusF8oMR5NJ0AaIYsnwbsj4CfFXlVVhbuK15er5HA6t7t76lPw4RcpIEvXGOeHOAO3aubgzUS4iMyg0N1QRwQJ45ePI/gBX1XnsoRUcZ2gMloWqnGztgjHEcwL8r3HhJ0i+xepj1a0VWjXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789927532; c=relaxed/simple;
	bh=YgCqOrWQxVJ9FlU8nNZ/kRHpsjDAdbKIMAISWP9FdQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WsDMYCJmCnvy+5qvg3kodXzbdFtMixpxPvxqhLcZqk86gxfpfSwg5KHwMXkFa7BlBm/Pt9DerBtd5zG81ijXxn+3YxUxS0Onvvp4lX6cBRI9HizIJ/2rdhcxzeSuRATPTUdbV7iKIYNUL2P+8r5qReuCuUcGSw+T3PCmhzAwMio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhJDI0Wh; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhJDI0Wh"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b965f447cso18704375e9.3
        for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789927528; x=1790532328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wcqgoArmWocaqUGN27gh98cUQRMjwBxwt3AvnyaBbC0=;
        b=fhJDI0WhNqk2oSE3sTpAqWtDnzU30RE45zaWkKMjGUq01QJhqGzY3oC3iPE9/176NH
         XhfUe+BoZJV6rj9AtqpmfhlzRaiu1P/t38Mb7KqyG8gHeZ+KV+xE9ZxEAM0fEpUw1Zb5
         MWUcKk1TTPVpstjzBeo2Sy8gJsPk2NJUBBoeId/noOmYDWxJr6qL3EEXWvLWkS46kxx5
         ho6DmH4/MhAmK2DMYkMY1JRELX4D41sSaTtfnp8vIp7mDlo/keDdLXFDd597Ue0WT3i6
         KgiNcE0NMj+XP1PcI8kEHu0fcpZSAXxtiCo6Ogjn4/gNzlho7OQl4IVo/v8D9kw3/Rl/
         /OgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789927528; x=1790532328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wcqgoArmWocaqUGN27gh98cUQRMjwBxwt3AvnyaBbC0=;
        b=GJWPpAdfjxTM1AZiCZ9219/8/w3s73xj7R2eHA3XvUPR6COLaXB0IgRvdOr0Lt74LQ
         DJU7WodVuS4WpAo62Et1Cmch8dmugbEvlfvgVOJx59kfV0eSbjFcWobbvEvUPIDijbsk
         lcIrtUMw5eqBch3vkOx+MzseIhgjLFRfUs9nG86Smo6lthiNANSrhG14/PNCzxmdkxbs
         XiERFR954OUIhoUqWEHm9RufBkGcs6Hz5NTWHWJKhOw984qVNJVhaYuJxUudNgK9yNoB
         jDrpzWRTFPoKaXt6BTYpnXox6UrB18aFZDYBkYQllsIO2DnpfsJRtwsXcvk3Ttz1O7xM
         S6jw==
X-Gm-Message-State: AFuF++kVE9cxUna4gGYT8ycr9Q+RWgR3hA1lc+CjZUAKimqIZVPxbZtb
	fTZSV5PD+gW/Im8eG6leT9VAgsqkIeBvy631pKOgcgg2KqO7cv+FI9fd
X-Gm-Gg: AYBFou3vbNtN+5szUowarxuEAHgW2xQSngGCF13fs/dCV/RydbPbhBPdcMcqwcq/PHC
	HPoSWv9ifpwxdu+3Ju4KaD4EHaUH+KBtZpv2k8TLztHEGbQkwJbifYVX9BlzMbhxdJLQvwJKje9
	VSb7s0NSlSiwrmei7fUEgkNn3efErFnx0tvtEQT5DJqq+3HGB7Qjjyo/dGngbbiyVrn/Yn51hAE
	2obpjx8ldO8Lcxq6MAAe+jLtgeYt+T9lfYYh8AJKNnRE9thQ1Cj4He3yGKqYFF1AQW0NnGZVOPY
	hc/Ej5J18pEJPqpsoBSXEj30q3V/eGGa5nZ6mCEjZM9MBJOOPdiFoKhOf2hlUpIUbGkaey+amjV
	2uLR0aNfmJoQhbmsTP6mi2hTT6eGf8hYneQZjSqjKWRLZyKsCyNR7xFu9+K5HR6m8Jz/TJw7mIi
	ag99/2AzlFuE6URFhYGLi6B3vtntWfKKWicmMGdVPtQF9TFPgoxMugSg7C210umPXPxRNPuPSkn
	a8I2DQ1cVBBelyG0KahKo8S1ABbBFbeXYyRXpxG9wX+08cBl5/X1mdsVPYe+wj4nCDJFo//oX+o
	6lnqPT1KGh1lxgdimcP1fvrWFodwk9nf2kcB9jYtbjJzUO7O0kQu071BASa/QdukD/O8hPZTjjv
	WYMcSvYbTZ1dN/wNRSIqrCQ4QgqtbrBl+ys65b+r+n+SHTQ==
X-Received: by 2002:a05:600c:4f09:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-49fc56692c6mr115229405e9.2.1789927528351;
        Sun, 20 Sep 2026 11:05:28 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0f7b9bsm164648055e9.5.2026.09.20.11.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:05:27 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 20 Sep 2026 20:05:25 +0200
Subject: [PATCH v9 3/5] iio: magnetometer: ak8975: use temporary variable
 for struct device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260920-ak8975-cleanup-v9-3-1b0f00ec19ef@gmail.com>
References: <20260920-ak8975-cleanup-v9-0-1b0f00ec19ef@gmail.com>
In-Reply-To: <20260920-ak8975-cleanup-v9-0-1b0f00ec19ef@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789927524; l=8345;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=pQ2sT/6TLCQz8CRTj1fj/jJzxcC1GLC9Mr0TP4ugBFU=;
 b=uwDRET1cn92/LUbE3/IdCFE9JScqH/8OTTrvf+yXNpCEcc7WO8xCDmxVRxGwmVNRGDtv0FQa3
 bojCudeqOLVDE7uJn/g5J0Jg38hsTAWCWVP9WDAaSKuYZkEfp29ffGX
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Use temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 65 +++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 59a7bb83a731..42f6892f4efd 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -433,18 +433,17 @@ struct ak8975_data {
 /* Enable attached power regulator if any. */
 static int ak8975_power_on(struct ak8975_data *data)
 {
+	struct device *dev = &data->client->dev;
 	int ret;
 
 	ret = regulator_enable(data->vdd);
 	if (ret) {
-		dev_warn(&data->client->dev,
-			 "Failed to enable specified Vdd supply\n");
+		dev_warn(dev, "Failed to enable specified Vdd supply\n");
 		return ret;
 	}
 	ret = regulator_enable(data->vid);
 	if (ret) {
-		dev_warn(&data->client->dev,
-			 "Failed to enable specified Vid supply\n");
+		dev_warn(dev, "Failed to enable specified Vid supply\n");
 		regulator_disable(data->vdd);
 		return ret;
 	}
@@ -580,6 +579,7 @@ static irqreturn_t ak8975_irq_handler(int irq, void *data)
 static int ak8975_setup_irq(struct ak8975_data *data)
 {
 	struct i2c_client *client = data->client;
+	struct device *dev = &client->dev;
 	int irq;
 	int ret;
 
@@ -590,9 +590,8 @@ static int ak8975_setup_irq(struct ak8975_data *data)
 	else
 		irq = gpiod_to_irq(data->eoc_gpiod);
 
-	ret = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
-			       IRQF_TRIGGER_RISING,
-			       dev_name(&client->dev), data);
+	ret = devm_request_irq(dev, irq, ak8975_irq_handler, IRQF_TRIGGER_RISING,
+			       dev_name(dev), data);
 	if (ret)
 		return ret;
 
@@ -608,12 +607,13 @@ static int ak8975_setup_irq(struct ak8975_data *data)
 static int ak8975_setup(struct ak8975_data *data)
 {
 	struct i2c_client *client = data->client;
+	struct device *dev = &client->dev;
 	int ret;
 
 	/* Write the fused rom access mode. */
 	ret = ak8975_set_mode(data, FUSE_ROM);
 	if (ret < 0) {
-		dev_err(&client->dev, "Error in setting fuse access mode\n");
+		dev_err(dev, "Error in setting fuse access mode\n");
 		return ret;
 	}
 
@@ -623,26 +623,25 @@ static int ak8975_setup(struct ak8975_data *data)
 							sizeof(data->asa),
 							data->asa);
 	if (ret < 0) {
-		dev_err(&client->dev, "Not able to read asa data\n");
+		dev_err(dev, "Not able to read asa data\n");
 		return ret;
 	}
 	if (ret != sizeof(data->asa)) {
-		dev_err(&client->dev, "Error reading asa data\n");
+		dev_err(dev, "Error reading asa data\n");
 		return -EIO;
 	}
 
 	/* After reading fuse ROM data set power-down mode */
 	ret = ak8975_set_mode(data, POWER_DOWN);
 	if (ret < 0) {
-		dev_err(&client->dev, "Error in setting power-down mode\n");
+		dev_err(dev, "Error in setting power-down mode\n");
 		return ret;
 	}
 
 	if (data->eoc_gpiod || client->irq > 0) {
 		ret = ak8975_setup_irq(data);
 		if (ret < 0) {
-			dev_err(&client->dev,
-				"Error setting data ready interrupt\n");
+			dev_err(dev, "Error setting data ready interrupt\n");
 			return ret;
 		}
 	}
@@ -748,10 +747,11 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	struct ak8975_data *data = iio_priv(indio_dev);
 	const struct i2c_client *client = data->client;
 	const struct ak_def *def = data->def;
+	struct device *dev = &data->client->dev;
 	__le16 rval;
 	int ret;
 
-	pm_runtime_get_sync(&data->client->dev);
+	pm_runtime_get_sync(dev);
 
 	mutex_lock(&data->lock);
 
@@ -773,20 +773,20 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	/* Read out ST2 for release lock on measurement data. */
 	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST2]);
 	if (ret < 0) {
-		dev_err(&client->dev, "Error in reading ST2\n");
+		dev_err(dev, "Error in reading ST2\n");
 		goto exit;
 	}
 
 	if (ret & (data->def->ctrl_masks[ST2_DERR] |
 		   data->def->ctrl_masks[ST2_HOFL])) {
-		dev_err(&client->dev, "ST2 status error 0x%x\n", ret);
+		dev_err(dev, "ST2 status error 0x%x\n", ret);
 		ret = -EINVAL;
 		goto exit;
 	}
 
 	mutex_unlock(&data->lock);
 
-	pm_runtime_put_autosuspend(&data->client->dev);
+	pm_runtime_put_autosuspend(dev);
 
 	/* Swap bytes and convert to valid range. */
 	*val = clamp_t(s16, le16_to_cpu(rval), -def->range, def->range);
@@ -795,8 +795,8 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 exit:
 	mutex_unlock(&data->lock);
-	pm_runtime_put_autosuspend(&data->client->dev);
-	dev_err(&client->dev, "Error in reading axis\n");
+	pm_runtime_put_autosuspend(dev);
+	dev_err(dev, "Error in reading axis\n");
 	return ret;
 }
 
@@ -966,7 +966,7 @@ static int ak8975_probe(struct i2c_client *client)
 	 * We may not have a GPIO based IRQ to scan, that is fine, we will
 	 * poll if so.
 	 */
-	eoc_gpiod = devm_gpiod_get_optional(&client->dev, NULL, GPIOD_IN);
+	eoc_gpiod = devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
 	if (IS_ERR(eoc_gpiod))
 		return PTR_ERR(eoc_gpiod);
 	gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
@@ -976,13 +976,12 @@ static int ak8975_probe(struct i2c_client *client)
 	 * deassert reset on ak8975_power_on() and assert reset on
 	 * ak8975_power_off().
 	 */
-	reset_gpiod = devm_gpiod_get_optional(&client->dev,
-					      "reset", GPIOD_OUT_HIGH);
+	reset_gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpiod))
 		return PTR_ERR(reset_gpiod);
 
 	/* Register with IIO */
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -994,7 +993,7 @@ static int ak8975_probe(struct i2c_client *client)
 	data->reset_gpiod = reset_gpiod;
 	data->eoc_irq = 0;
 
-	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
 
@@ -1004,16 +1003,16 @@ static int ak8975_probe(struct i2c_client *client)
 		return -ENODEV;
 
 	/* If enumerated via firmware node, fix the ABI */
-	if (dev_fwnode(&client->dev))
-		name = dev_name(&client->dev);
+	if (dev_fwnode(dev))
+		name = dev_name(dev);
 	else
 		name = id->name;
 
 	/* Fetch the regulators */
-	data->vdd = devm_regulator_get(&client->dev, "vdd");
+	data->vdd = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(data->vdd))
 		return PTR_ERR(data->vdd);
-	data->vid = devm_regulator_get(&client->dev, "vid");
+	data->vid = devm_regulator_get(dev, "vid");
 	if (IS_ERR(data->vid))
 		return PTR_ERR(data->vid);
 
@@ -1029,7 +1028,7 @@ static int ak8975_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "Unexpected device\n");
 
-	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
+	dev_dbg(dev, "Asahi compass chip %s\n", name);
 
 	/* Perform some basic start-of-day setup of the device. */
 	ret = ak8975_setup(data);
@@ -1066,8 +1065,8 @@ static int ak8975_probe(struct i2c_client *client)
 	 * The device comes online in 500us, so add two orders of magnitude
 	 * of delay before autosuspending: 50 ms.
 	 */
-	pm_runtime_set_autosuspend_delay(&client->dev, 50);
-	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_set_autosuspend_delay(dev, 50);
+	pm_runtime_use_autosuspend(dev);
 
 	return 0;
 }
@@ -1082,7 +1081,7 @@ static int ak8975_runtime_suspend(struct device *dev)
 	/* Set the device in power down if it wasn't already */
 	ret = ak8975_set_mode(data, POWER_DOWN);
 	if (ret < 0) {
-		dev_err(&client->dev, "Error in setting power-down mode\n");
+		dev_err(dev, "Error in setting power-down mode\n");
 		return ret;
 	}
 	/* Next cut the regulators */
@@ -1106,7 +1105,7 @@ static int ak8975_runtime_resume(struct device *dev)
 	 */
 	ret = ak8975_set_mode(data, POWER_DOWN);
 	if (ret < 0) {
-		dev_err(&client->dev, "Error in setting power-down mode\n");
+		dev_err(dev, "Error in setting power-down mode\n");
 		return ret;
 	}
 

-- 
2.55.0

