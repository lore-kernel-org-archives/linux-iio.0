Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807593090F7
	for <linux-iio@vger.kernel.org>; Wed, 18 Feb 2026 04:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389474; cv=none; b=e7C+DkA3JCcQ5FsmECwlRlNS8NE2Y3WZr7IRBknwgzSsW8VDkCnA0YJIEeiigli5V5T6MzEUNsF+c955M1wS5Wv6q3iavx18kli748CoCUQy+o+38QfR1tzjm2V1yQR1K5ixKbhjpS4nQJIotMz8PhskLASAc1cQ/306PxHQN9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389474; c=relaxed/simple;
	bh=I33BA+Xs3H2s+wN1ueVG8ItbqrqoSJ0FwZ0ktBaaB18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjH4Bb3E4JlLV1mel3e1NYsyKeocUYGCLiRLVEK1/IzgsWLR3GCbfomNDn5s5l+cJKR6yD5hkHCyzmOUkJqZ5hn0+hzxGsVqvNJ3cZy6yAMa3qs5zERXUDFnOqr8g7zSWw2qoQZy68LYLRjsCo4o7nrFI2PCdyoQSrWK2pg4JRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/hLL/Xb; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/hLL/Xb"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-797afd2e872so32143077b3.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 20:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771389472; x=1771994272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj54F/VLsWjgNsa4Etjj+8Jo41r9O+F6M7507QFPSho=;
        b=d/hLL/XbveBythF4/YMkxXTX7oPkNEa8H29/dgw41c3ZXCxaVfxhdp9LxEK+5+UaT4
         EwoHIy70s9Jss3NJaY4NxhQ43yFxQHiz49Pq2F4OX1ZxAswcjKwsTe5W0/nTwnFukAnV
         4sy5AP9wALQtZVjbH59Cj2yDblmJkrVowYeSOC5wDokygzNrcbM1+YCjTtT/1ePoSYMl
         oFrih/uPmm83eXo6448/tDY13RpWn1N/9jeBcXciFfBiIynesn6M1jCt4vRiPq9UFQ5o
         rZZRGm24AihHHmN1b7lKSgE7huqU20ToSabya+pzb4gjkCW0+/X6ML+1Y5Y+HrStxZsQ
         I9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771389472; x=1771994272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pj54F/VLsWjgNsa4Etjj+8Jo41r9O+F6M7507QFPSho=;
        b=SRmJ7nmIQh0pWifqsfJGsYLb1pntNd/U+pN6LMTllzZ58SLsFNiSFR2xgP7zBRkCRF
         G0TXkEGBorGzwqvIfthVydO521vwBngbdHj159Pxdr/iZe0vx81nruPgFWGyIwOv3ClV
         T1rxiG7KqkpvcElWXcu6rxGcaAB6IMLTKaHHkeFO6Hs9wKo5v7LeCdeFOwJTtF25O2Bt
         7SHDLtvy6EEuPKIYMEL/c5qEXDqnDK/9tE10tCZGZbjxbHxMWKZIoXSpxrSlsjTAE3V1
         9WeGzZ3nYZG0SCRi5JgX4xuHf7vs9PSQKK5rXP/4v5AWZZ8ZLsJj44dVDN+HVg0Y5BZZ
         kdAw==
X-Forwarded-Encrypted: i=1; AJvYcCVSETUzKh/oRlAZue6IvDSgRvJbjKXV8gAG/PsuJmxFTuJU4Zuy/JEqcmIQon9NKiHBZiGOR/s0zJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzygO8aP4DiZQd5hP72dry8H8a+TUqFEh0pbHfTiD+hcIsN3qg9
	/IvwFvSpdPQjBucE4DKBVc3SkuNMZrU3NLJwO7fVANk8vyDwhRPR9+fE
X-Gm-Gg: AZuq6aLXsVfpVvM0OAOtO/vvNRjRGeSOmu+klNcJYGW30TE8JfFb7g5v0pATvpZo0xA
	X0E4jGR525iKAeK1GlUzCCpdb9p+mII3Dyk9B6OYDSIBLxy4Y1R9EJ65YGMSNk4Urwy/i6upVbH
	UiJuidaXYIx5J6uwvnh10OtsP1sfUlNAmSeZhv/hBYJ8+SZImnSRq2Z4wxqtwgfD6XUej2Mfj0l
	ycRZ8ioycinGAXrbQWoD3G50N7T3w6S9sSgGqvEPr3Cei7F0jv0rR7kx/+XU4M+jlcqwYhyag8t
	1r9xebFHmRqT8JSx36Yl1Q1wXkjJYNz8VyG28sgbrz3D7MJCeUS72+B0v7KS4bbBmETlH8dRBpJ
	dOfs2mxro4hgxgEaEGR6TBymbuGtlEXY5WRa7FPwqFSTB5y/yrKVJbz7z2c6QYA8pIccJNwD8bg
	hN6TMh0A/EJbNaXT9kHhx6xQseAiSHtlaKlMB3CKn/1knrCiSMVYcYsPSzcBmSfJIOpoNyG2EV8
	t+1CIjAgPlbSPJal3KbnV6D4KlaIhOlsKLyN47vKvTAIhFgoVltfA==
X-Received: by 2002:a05:690c:600d:b0:796:c34b:9b01 with SMTP id 00721157ae682-797ac62e274mr115747997b3.55.1771389472482;
        Tue, 17 Feb 2026 20:37:52 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c23e4bdsm119850617b3.32.2026.02.17.20.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 20:37:51 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: jic23@kernel.org,
	andy@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v4 6/9] iio: light: gp2ap020a00f: Use temporary variable for struct device
Date: Tue, 17 Feb 2026 22:37:25 -0600
Message-ID: <20260218043728.609659-7-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218043728.609659-1-ethantidmore06@gmail.com>
References: <20260218043728.609659-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Use temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v4:
- Integrate Andy Shevchenko's cleanups.

 drivers/iio/light/gp2ap020a00f.c | 34 +++++++++++++++-----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index f9ff8bbbe5ec..54b5d1993035 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1192,6 +1192,7 @@ static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
 static int gp2ap020a00f_read_channel(struct gp2ap020a00f_data *data,
 				struct iio_chan_spec const *chan, int *val)
 {
+	struct device *dev = &data->client->dev;
 	enum gp2ap020a00f_cmd cmd;
 	int err;
 
@@ -1211,27 +1212,23 @@ static int gp2ap020a00f_read_channel(struct gp2ap020a00f_data *data,
 
 	err = gp2ap020a00f_exec_cmd(data, cmd);
 	if (err < 0) {
-		dev_err(&data->client->dev,
-			"gp2ap020a00f_exec_cmd failed\n");
-		goto error_ret;
+		dev_err(dev, "gp2ap020a00f_exec_cmd failed\n");
+		return err;
 	}
 
 	err = gp2ap020a00f_read_output(data, chan->address, val);
 	if (err < 0)
-		dev_err(&data->client->dev,
-			"gp2ap020a00f_read_output failed\n");
+		dev_err(dev, "gp2ap020a00f_read_output failed\n");
 
 	err = gp2ap020a00f_set_operation_mode(data,
 					GP2AP020A00F_OPMODE_SHUTDOWN);
 	if (err < 0)
-		dev_err(&data->client->dev,
-			"Failed to shut down the device.\n");
+		dev_err(dev, "Failed to shut down the device.\n");
 
 	if (cmd == GP2AP020A00F_CMD_READ_RAW_CLEAR ||
 	    cmd == GP2AP020A00F_CMD_READ_RAW_IR)
 		gp2ap020a00f_output_to_lux(data, val);
 
-error_ret:
 	return err;
 }
 
@@ -1421,18 +1418,19 @@ static const struct iio_buffer_setup_ops gp2ap020a00f_buffer_setup_ops = {
 static int gp2ap020a00f_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	struct device *dev = &client->dev;
 	struct gp2ap020a00f_data *data;
 	struct iio_dev *indio_dev;
 	struct regmap *regmap;
 	int err;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
 
-	data->vled_reg = devm_regulator_get(&client->dev, "vled");
+	data->vled_reg = devm_regulator_get(dev, "vled");
 	if (IS_ERR(data->vled_reg))
 		return PTR_ERR(data->vled_reg);
 
@@ -1442,7 +1440,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 
 	regmap = devm_regmap_init_i2c(client, &gp2ap020a00f_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Regmap initialization failed.\n");
+		dev_err(dev, "Regmap initialization failed.\n");
 		err = PTR_ERR(regmap);
 		goto error_regulator_disable;
 	}
@@ -1453,7 +1451,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 			ARRAY_SIZE(gp2ap020a00f_reg_init_tab));
 
 	if (err < 0) {
-		dev_err(&client->dev, "Device initialization failed.\n");
+		dev_err(dev, "Device initialization failed.\n");
 		goto error_regulator_disable;
 	}
 
@@ -1478,11 +1476,10 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 		goto error_regulator_disable;
 
 	/* Allocate trigger */
-	data->trig = devm_iio_trigger_alloc(&client->dev, "%s-trigger",
-							indio_dev->name);
+	data->trig = devm_iio_trigger_alloc(dev, "%s-trigger", indio_dev->name);
 	if (data->trig == NULL) {
 		err = -ENOMEM;
-		dev_err(&indio_dev->dev, "Failed to allocate iio trigger.\n");
+		dev_err(dev, "Failed to allocate iio trigger.\n");
 		goto error_uninit_buffer;
 	}
 
@@ -1494,7 +1491,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 				   "gp2ap020a00f_als_event",
 				   indio_dev);
 	if (err < 0) {
-		dev_err(&client->dev, "Irq request failed.\n");
+		dev_err(dev, "Irq request failed.\n");
 		goto error_uninit_buffer;
 	}
 
@@ -1502,7 +1499,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 
 	err = iio_trigger_register(data->trig);
 	if (err < 0) {
-		dev_err(&client->dev, "Failed to register iio trigger.\n");
+		dev_err(dev, "Failed to register iio trigger.\n");
 		goto error_free_irq;
 	}
 
@@ -1528,12 +1525,13 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
+	struct device *dev = &client->dev;
 	int err;
 
 	err = gp2ap020a00f_set_operation_mode(data,
 					GP2AP020A00F_OPMODE_SHUTDOWN);
 	if (err < 0)
-		dev_err(&indio_dev->dev, "Failed to power off the device.\n");
+		dev_err(dev, "Failed to power off the device.\n");
 
 	iio_device_unregister(indio_dev);
 	iio_trigger_unregister(data->trig);
-- 
2.53.0

