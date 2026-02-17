Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7083630CDBD;
	Tue, 17 Feb 2026 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323809; cv=none; b=TAG4BUGwgdoRKGurHanFWHGE3+PxocoTzRStx2DkA3W/xY2bmwkE8cPSVrETC4j6GKvVa1qd4Mi8qOmZKm05dSvbwqSLUM1+2gAdQISpzmXpTZUk1BzZeU1qSHm2CJ+iIUbOy1M74LxzpCDAmJpM4FRrnAOxcgF++V3wi/CQHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323809; c=relaxed/simple;
	bh=eGUs7x+4HZuePC29IWZg62VTGnfMD8N37njny/g88lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPGjzG8SW5gEKbrpoBgDc5Rnb9lkFYBqz7fhxjBh12BsS+sDFs7EU51S2jQP7vsB9hy9BQlW2G+vEK8uCnP/Xxcs3w38cR3z5VdqRqlVmdq80VnQFwKaDzp0Bttfr7dSgwtjXjorZPqwsdPHWwntRgse/XvJ2oIAWc5UUoHViZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kiSIvQA1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kiSIvQA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771323808; x=1802859808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eGUs7x+4HZuePC29IWZg62VTGnfMD8N37njny/g88lE=;
  b=kiSIvQA1c1vRm5VlpT+f95nEDlEoyIg3euxE9YI2WS9U6d0CFcYxXTas
   0WgeFVPBOPcQCxktCYio0KXLag6U2GgzXpzjsXYEZ4pPXUi0zaASjl9fj
   ZaXjTPbnHB68UiFZK1V+CB7+ZgNjjuPoSl+VwEEzoa7Kt8tzH/lJaBfs4
   jNrD/60N1T0jpu31gHeJFe9eoepCnneWyJclGDjQk8nHFnREGcqCgI7Ph
   TMi66Goh8FH0v7n7dd6OyV+Okn09lvrFHrXCNaVzE70dWQ2c5UyHdCGco
   Zaf7OkvyPgsIrQVMXEXm2XvVYhcChW/or9iH0L7FIeBi+5PZ5K/mm3ulL
   w==;
X-CSE-ConnectionGUID: Itw+QNC8SHC9IL5swhh6VQ==
X-CSE-MsgGUID: 8EyFO1pzTn+g/RsFOsmXJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72099177"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72099177"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 02:23:26 -0800
X-CSE-ConnectionGUID: SxfS74WyT8ubVHUXr7SVEQ==
X-CSE-MsgGUID: AOUNGkuqTDS3Hi8Ww8GK+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="236851649"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 17 Feb 2026 02:23:24 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 62AB89E; Tue, 17 Feb 2026 11:23:23 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v1 4/7] iio: light: gp2ap020a00f: Use temporary variable for struct device
Date: Tue, 17 Feb 2026 11:15:14 +0100
Message-ID: <20260217102318.1354103-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260217102318.1354103-1-andriy.shevchenko@linux.intel.com>
References: <20260217102318.1354103-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/gp2ap020a00f.c | 34 +++++++++++++++-----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 6c0788720af4..af5eb77cb8c6 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1194,6 +1194,7 @@ static int gp2ap020a00f_read_event_config(struct iio_dev *indio_dev,
 static int gp2ap020a00f_read_channel(struct gp2ap020a00f_data *data,
 				struct iio_chan_spec const *chan, int *val)
 {
+	struct device *dev = &data->client->dev;
 	enum gp2ap020a00f_cmd cmd;
 	int err;
 
@@ -1213,27 +1214,23 @@ static int gp2ap020a00f_read_channel(struct gp2ap020a00f_data *data,
 
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
 
@@ -1423,18 +1420,19 @@ static const struct iio_buffer_setup_ops gp2ap020a00f_buffer_setup_ops = {
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
 
@@ -1444,7 +1442,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 
 	regmap = devm_regmap_init_i2c(client, &gp2ap020a00f_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Regmap initialization failed.\n");
+		dev_err(dev, "Regmap initialization failed.\n");
 		err = PTR_ERR(regmap);
 		goto error_regulator_disable;
 	}
@@ -1455,7 +1453,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 			ARRAY_SIZE(gp2ap020a00f_reg_init_tab));
 
 	if (err < 0) {
-		dev_err(&client->dev, "Device initialization failed.\n");
+		dev_err(dev, "Device initialization failed.\n");
 		goto error_regulator_disable;
 	}
 
@@ -1480,11 +1478,10 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
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
 
@@ -1496,7 +1493,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 				   "gp2ap020a00f_als_event",
 				   indio_dev);
 	if (err < 0) {
-		dev_err(&client->dev, "Irq request failed.\n");
+		dev_err(dev, "Irq request failed.\n");
 		goto error_uninit_buffer;
 	}
 
@@ -1504,7 +1501,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 
 	err = iio_trigger_register(data->trig);
 	if (err < 0) {
-		dev_err(&client->dev, "Failed to register iio trigger.\n");
+		dev_err(dev, "Failed to register iio trigger.\n");
 		goto error_free_irq;
 	}
 
@@ -1530,12 +1527,13 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
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
2.50.1

