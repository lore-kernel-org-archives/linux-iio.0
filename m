Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707803D88EC
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789927530; cv=none; b=ftipT77ld61asHDSqDotG5AVDcAWAhWRVqiNdQOVpozleYCJJydc7mpT8su5TNFlOGT9UkENoWgfWnxbYkEmuST5ziVut6jvb2glL/mnQnMdAcLaqK5GcI/waPWDZPff7si3l1Y4X+SW9Dd1YW5qKqBIkMnlsJuGNTl2tzKoMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789927530; c=relaxed/simple;
	bh=BwmxFH2C+DfSY+nIiFts6BYW5ZTNOSbT64e6crQC/pU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LXIH/JPXf23GtHDM28AVl2ThY+rpJ+Rd1o9yoJXOtC5aKaI2ow74hiEfCLu+9QGIdjuLRbAzSOpTr5ZAmeknUXgg6+ToSLQyuadqq2VDpHuH5vriSIrMRyfJILsDLg2gU7Ab69P3LA+3e+4TCKBWJJXDVXtBIqBbW6GqLMY87/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipls20XY; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipls20XY"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so11182695e9.1
        for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 11:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789927527; x=1790532327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pMQIFtLzEXfAqoUeE/5GZXXM8VqBX7/IdrQeaFnts9Y=;
        b=ipls20XY/dqXwQSYmTu4BaoImvvvHLaFTirdVKPLe/EZAzSrqRw143zuZhFR33qUBJ
         ADSYzaUexfGPJzsSa2UrIoe2E2qteyfbFXTkMZc/jYGX16ZBInA2pv0yrLc7HcSU3XC2
         2dbvuZdE8X103ELP6v3LDcIkMTD0FZRhrNS1xH0ISx4KNPherMY5juaMbqaNCzCJnldI
         WYT2p3PFihJUO4ptcndXnFGDmxPi9qEXvTnhcCqmpUqjaJs1jwMMP/XczNgg2I/gFuED
         zPjPUhgQ1F3EQFzq6HEuuTsLeWizexZ+cyXqDocfmmyhqya6ZXMzijOZtS50h2cztESA
         NLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789927527; x=1790532327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pMQIFtLzEXfAqoUeE/5GZXXM8VqBX7/IdrQeaFnts9Y=;
        b=E2PMYStyvDOQPx12d9/a4nR+oo8k79uVJfoYXq4WsYguIzOdHgUNu0nZUjFW4eB9ee
         MN11ApX0btmd0x3+wxBHgcl37I0NVDIdSxVV3pqbp133gHGDTF/wAEXd7LaPso9fK98X
         rd6vSQzdHYMY6GiwrXi6OKMBeHyR5rDw2bvMZyUia+MP0zXvTIdENNXBIaB4d0/3cBjr
         XGjLhRlubJoEZ7uxogGhvrxwbJtaNvuEIMhK4wpDNzAjRRg1YOdGGm/+1jm+U+4VSp7j
         emetR0/JU+VvqtEtHjVMRBRvFdI18scXBXlnMejmCEqNV15Ez728tth4mUP56aVsktr2
         N2vQ==
X-Gm-Message-State: AFuF++khgBa0CaNlsezlWRHM0MTqOSTPoWbwWwUkkfr/PHSiEXLs+kDw
	Hu1ikQmt9kz1jpXx1T+tWYqPJyj8yAY2URBC5PAr4l6KunAmWFJhBrwfiSDYVA==
X-Gm-Gg: AYBFou0tvauy+AjciOo/ZHiSQwfzh/ge6rLl9r8h/BkpeDOR6pAdHccm34KZTGdNBxN
	TRrecXAHK1+hZ5knTE0sPEeJQQpbPSF4+SDpi4Cr7l/6nw70E2FsdoT/afQZV8JOArWgwcUJk+6
	sNVERSITguIpHXxilT8nQmCPH7RvKEBWK6/97CiC3ZgXHOhqZvLTWM57v47YoXHSHFAF0PYoarf
	GtABBI8Bbsf3+VEX3MRI4be6MgsTTBD25Q1pTHs031tN32fSznWduW9rqfkCgSZfDODkwPepBMO
	PXIFKlVAtZfko+Ym0AYiz4yFhpt+6rwzUp+PLOh8mifp8bwjImHeYQior9ZeNjg/VlDrwvWsC55
	ISlJe4w4Ib5Yj5lpdAPQQel4sauzhcclKkKr6KuzmxApaAtuNjuUmGZW30kVwyJ2zbXgmibjoWh
	+pYcImLe4EPBUOr1ZE3fl2/RWNaI9U723i5NdHhhHh1aLWV8gUZz1Dj0jUyXkX9ej13FAQa64JQ
	PGF4QxQKiDY4GEC2+o/FF9He5mu6t5vNn3X3oy/7Hsio+xysebjoewQzHcbfwsftiPpPCmcuSsS
	KofiTo2hyU9ArXXx2pZt51l0CJkhdd0M/COwbSN3Yl3tHqO0P8rnRGzj1eyKwogJFmUsvz6Vqo+
	WD7pD3Hh0+YaTEzpYjUprz7JljblqA7Ze9nw=
X-Received: by 2002:a05:600c:6309:b0:49e:6b55:22b8 with SMTP id 5b1f17b1804b1-49fc5669353mr108129965e9.4.1789927526579;
        Sun, 20 Sep 2026 11:05:26 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0f7b9bsm164648055e9.5.2026.09.20.11.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:05:26 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 20 Sep 2026 20:05:23 +0200
Subject: [PATCH v9 1/5] iio: magnetometer: ak8975: switch to using managed
 resources
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-ak8975-cleanup-v9-1-1b0f00ec19ef@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789927524; l=5704;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=OAFebd1XqhPLIm0Fc8MFZqjA1WKWD2dGwHfG18EEwB4=;
 b=yD2mRsiPLjvzli1PdtqX82j0QCxo3Tb8REjRM/85MN1dNpn63XW8FysudD9qvUIE5VEpC5dRx
 SniqBJ+IDMbDISexkkwsZCvVNWOv1aiSMgb2pcxNvkV8mk1mJZdPH0V
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Switch the driver to use managed resources (devm_*) which simplifier
error handling and allows removing ak8975_remove() method from
the driver.

Note, on error path we now also set mode to POWER_DOWN state which is
fine. Even if the device is in that mode, there is no problem to set
that mode again, it should be no-op.

Additionally, remove any pm_runtime_get/put*() function calls that
dummy cycled the counter to autosuspend the device.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 80 +++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 8b0c07f82602..d217fdf34bce 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -418,6 +418,7 @@ struct ak8975_data {
 	wait_queue_head_t	data_ready_queue;
 	unsigned long		flags;
 	u8			cntl_cache;
+	bool			powered_on;
 	struct iio_mount_matrix orientation;
 	struct regulator	*vdd;
 	struct regulator	*vid;
@@ -430,7 +431,7 @@ struct ak8975_data {
 };
 
 /* Enable attached power regulator if any. */
-static int ak8975_power_on(const struct ak8975_data *data)
+static int ak8975_power_on(struct ak8975_data *data)
 {
 	int ret;
 
@@ -457,16 +458,22 @@ static int ak8975_power_on(const struct ak8975_data *data)
 	 */
 	fsleep(500);
 
+	data->powered_on = true;
 	return 0;
 }
 
 /* Disable attached power regulator if any. */
-static void ak8975_power_off(const struct ak8975_data *data)
+static void ak8975_power_off(struct ak8975_data *data)
 {
+	if (!data->powered_on)
+		return;
+
 	gpiod_set_value_cansleep(data->reset_gpiod, 1);
 
 	regulator_disable(data->vid);
 	regulator_disable(data->vdd);
+
+	data->powered_on = false;
 }
 
 /*
@@ -934,9 +941,23 @@ static const struct iio_buffer_setup_ops ak8975_buffer_setup_ops = {
 	.preenable = ak8975_buffer_preenable,
 	.postdisable = ak8975_buffer_postdisable,
 };
+
+static void devm_ak8975_power_off(void *data)
+{
+	struct ak8975_data *ak = data;
+
+	if (!ak->powered_on)
+		return;
+
+	/* Soft-stop the chip before hard-stopping the regulators */
+	ak8975_set_mode(data, POWER_DOWN);
+	ak8975_power_off(data);
+}
+
 static int ak8975_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	struct device *dev = &client->dev;
 	struct ak8975_data *data;
 	struct iio_dev *indio_dev;
 	struct gpio_desc *eoc_gpiod;
@@ -1004,10 +1025,14 @@ static int ak8975_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, devm_ak8975_power_off, data);
+	if (ret)
+		return ret;
+
 	ret = ak8975_who_i_am(data, data->def->type);
 	if (ret) {
 		dev_err(&client->dev, "Unexpected device\n");
-		goto power_off;
+		return ret;
 	}
 	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
 
@@ -1015,10 +1040,13 @@ static int ak8975_probe(struct i2c_client *client)
 	ret = ak8975_setup(data);
 	if (ret) {
 		dev_err(&client->dev, "%s initialization fails\n", name);
-		goto power_off;
+		return ret;
 	}
 
-	mutex_init(&data->lock);
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
 	indio_dev->channels = ak8975_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
 	indio_dev->info = &ak8975_info;
@@ -1026,52 +1054,33 @@ static int ak8975_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
-					 &ak8975_buffer_setup_ops);
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      ak8975_handle_trigger,
+					      &ak8975_buffer_setup_ops);
 	if (ret) {
 		dev_err(&client->dev, "triggered buffer setup failed\n");
-		goto power_off;
+		return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
+	pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret) {
 		dev_err(&client->dev, "device register failed\n");
-		goto cleanup_buffer;
+		return ret;
 	}
 
-	/* Enable runtime PM */
-	pm_runtime_get_noresume(&client->dev);
-	pm_runtime_set_active(&client->dev);
-	pm_runtime_enable(&client->dev);
 	/*
 	 * The device comes online in 500us, so add two orders of magnitude
 	 * of delay before autosuspending: 50 ms.
 	 */
 	pm_runtime_set_autosuspend_delay(&client->dev, 50);
 	pm_runtime_use_autosuspend(&client->dev);
-	pm_runtime_put(&client->dev);
 
 	return 0;
-
-cleanup_buffer:
-	iio_triggered_buffer_cleanup(indio_dev);
-power_off:
-	ak8975_power_off(data);
-	return ret;
-}
-
-static void ak8975_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ak8975_data *data = iio_priv(indio_dev);
-
-	pm_runtime_get_sync(&client->dev);
-	pm_runtime_put_noidle(&client->dev);
-	pm_runtime_disable(&client->dev);
-	iio_device_unregister(indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	ak8975_set_mode(data, POWER_DOWN);
-	ak8975_power_off(data);
 }
 
 static int ak8975_runtime_suspend(struct device *dev)
@@ -1165,7 +1174,6 @@ static struct i2c_driver ak8975_driver = {
 		.acpi_match_table = ak_acpi_match,
 	},
 	.probe		= ak8975_probe,
-	.remove		= ak8975_remove,
 	.id_table	= ak8975_id,
 };
 module_i2c_driver(ak8975_driver);

-- 
2.55.0

