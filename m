Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C942345CD9
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 03:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818049; cv=none; b=h5NMycFH+bN+XgZ5XRkrksYKRz+vNLKPTopWPPkJ42/EaybQDd/pNGMF085Q312MlMueSneYdWeMaNNUdaPGPj3918oKXsA7cRqCPsc593i/9TIWqqvpy04qBkpxgGI63+1NzZWsCtnC9Bh1zUmRsChPsxP6K3Ov2eo2wPvszZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818049; c=relaxed/simple;
	bh=u8tJfTiMhFLOgBGY/qJjB7+tG3jV629MS3lZouBe+Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3/hmwVyjJRoLAISMJ2CnZw2ruQV7UtC3EqbMwUQUd55M3Ay/uYbQdXADGdvNg5VFMEBnVpAcewiSpsZQACckEY3KuevBupbQOdrzfRAuzHEtli2PdkI1A/q/puCHC9LwlWn8xvvjVx+BPyrR/j2Vn6kqSSYqRqLmwcCJmxMTgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0qPSCR1; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0qPSCR1"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-793fdbb8d3aso31184827b3.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 19:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818047; x=1772422847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFIDfb+fiqqkIYg8UaViqwuxTwVr1uGT5nI/+TRKG8o=;
        b=b0qPSCR1SV1AG21ZNatWXh3e8QLSAIdlWXaQDSD3YSVBxGuUig5uqjr6dBCWV8+OhV
         K+NxlGwBf3jjSRzMu5XUCB2sSRAUBk7Bged7NKuXXdkDwX/G4BciR7ka1Dk6ULTqC16C
         i/EJtUT84h7g+g2zlBlHNaoz1gsYwGkr8BzaLuTVc9hZUen4gEsbnq+XAHW+XmLxutxF
         NrPkUltgufXV83gs2AcTY6w5ojq0SdhRreNOQDUouJwuot2Zy6dBHbJ6Bot+55tImsb0
         uu2+vrVw0ctU0wkO4nkkRwhUAtME6CqAwLB3PCL2GgstbrMWGJ/O+Q1WegV4Hgr5lrGx
         tHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818047; x=1772422847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SFIDfb+fiqqkIYg8UaViqwuxTwVr1uGT5nI/+TRKG8o=;
        b=Hk6opjm0HRaUh11neVIv8sNKeUHp+5XDr0bvSrp6STFQGPIbetcAHlzNOAdQxHXAFE
         usfqaBvqVPJHAZNT/aRD5p9Fr5iHsE6VXVC+E0SvOa28SIJ6z3t+Y52tNd3uT6vKqTLe
         3pwBJgOLXqYFBwTTJDXpNx6cPYFljymwYxlWagseIYWqi7M2V/IZ6i/+0jrftUoOqo7o
         9Fi8YAx9/58EjL6lrRxb2pmMzjNyrMmVDe3S1Krk8XkeewyGsGABRBuozY115c/gNz2x
         YAs+Cd4dNxWTqAsveSNPt+t3XVjoRFDvWwwrbJ5WgaSGtXE/H9fxWaJJp6bmt0+mjeiS
         MzYA==
X-Forwarded-Encrypted: i=1; AJvYcCUbRMrVBS2bs5hHnTpwgQJlPjgsesA2o8kLPCg67n3/s015021wYLqYHvbQAOrV9cW6MhnO06maaYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxoi64b8VlGelGY/0V29qJQTM5+G95wkVpdVFp9CX/BILNfWvQF
	0TPqbXWQ2kmXO3rkxzPtcCaOyo/EkVNv7k7f2widcJcHPlq8Ycnv7c1Y
X-Gm-Gg: ATEYQzyysgGO7OyPXJDGVikvFDXZdel1G+vwdpfoAXHxXQLCruxi8gvkpticsFBZhAF
	yLvAhP7mIrW+KxI3QAZN10TCFD2wDO+ciP6j9gcB8d6vOtu7mwejS9Xx4NYioRGJ13O4Q9y4ZAC
	9vbWLDKsu9Q7mpDm/NDOpt6iVUYUaHjDzttboT5Mvun1SOI0EbHdOIB+7L9YyoU+jyV5GJSuWyc
	wyR122FV7gW1Ojq7nudvnec80D2OoztK3y8nfQm1X/MkWzy2v0obns3xrSWyl09/KUlbUy/CHNW
	Qv6LtE/u1a118X5RsEAuNvp8t2bfH3K82TrUjKIqkTtJGKRsM3B4BCk8vrpWQGNRDrkxTsglfy8
	5qc6kGwojjwuNifX+O0Y/SPK7NP8atBAvwhZZw4jmpZZV93G0oOjoAmufra1a9MnJIOJV2Ww195
	dsXKbHFjzqvLQuNkXNnhwDNS0+TE/eGounURUQkyPSo5V5PL/5wYEyqraq4fUwhnvarpoVAphaB
	btwboFDG9zu4a3e7DMY4R6y
X-Received: by 2002:a05:690c:a92:b0:797:df7c:3e1b with SMTP id 00721157ae682-79828ef29afmr63385657b3.4.1771818047348;
        Sun, 22 Feb 2026 19:40:47 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd5939sm27285237b3.15.2026.02.22.19.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 19:40:46 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v5 07/10] iio: light: gp2ap020a00f: Use temporary variable for struct device
Date: Sun, 22 Feb 2026 21:40:17 -0600
Message-ID: <20260223034020.27625-8-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223034020.27625-1-ethantidmore06@gmail.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
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
v5:
- No change.
v4:
- Integrate Andy Shevchenko's cleanups.

 drivers/iio/light/gp2ap020a00f.c | 34 +++++++++++++++-----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index b2434d00e10a..97630ce9ade0 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1187,6 +1187,7 @@ static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
 static int gp2ap020a00f_read_channel(struct gp2ap020a00f_data *data,
 				struct iio_chan_spec const *chan, int *val)
 {
+	struct device *dev = &data->client->dev;
 	enum gp2ap020a00f_cmd cmd;
 	int err;
 
@@ -1206,27 +1207,23 @@ static int gp2ap020a00f_read_channel(struct gp2ap020a00f_data *data,
 
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
 
@@ -1415,18 +1412,19 @@ static const struct iio_buffer_setup_ops gp2ap020a00f_buffer_setup_ops = {
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
 
@@ -1436,7 +1434,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 
 	regmap = devm_regmap_init_i2c(client, &gp2ap020a00f_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Regmap initialization failed.\n");
+		dev_err(dev, "Regmap initialization failed.\n");
 		err = PTR_ERR(regmap);
 		goto error_regulator_disable;
 	}
@@ -1447,7 +1445,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 			ARRAY_SIZE(gp2ap020a00f_reg_init_tab));
 
 	if (err < 0) {
-		dev_err(&client->dev, "Device initialization failed.\n");
+		dev_err(dev, "Device initialization failed.\n");
 		goto error_regulator_disable;
 	}
 
@@ -1472,11 +1470,10 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
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
 
@@ -1488,7 +1485,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 				   "gp2ap020a00f_als_event",
 				   indio_dev);
 	if (err < 0) {
-		dev_err(&client->dev, "Irq request failed.\n");
+		dev_err(dev, "Irq request failed.\n");
 		goto error_uninit_buffer;
 	}
 
@@ -1496,7 +1493,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 
 	err = iio_trigger_register(data->trig);
 	if (err < 0) {
-		dev_err(&client->dev, "Failed to register iio trigger.\n");
+		dev_err(dev, "Failed to register iio trigger.\n");
 		goto error_free_irq;
 	}
 
@@ -1522,12 +1519,13 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
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

