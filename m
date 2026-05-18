Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DA43C5835;
	Mon, 18 May 2026 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090641; cv=none; b=X094iTFwqZCGwXaQ86kPkWge3B03oHVAS3uTAvL8nWGysvpm6+pFh+I5lAMMpROE8c2RVMB0FHkA0741+n7Djvv8x8B++WvKMndSBwctPCFcAN/hexKOcTtVQy68kIYNN6d+Yu0RUZlV2xl22eA5iNAHmjDrow7uJX/GukYWN+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090641; c=relaxed/simple;
	bh=L3SFGcMUzcDzpjakQjdld7MbV/fV98urqNcZ8p9Ct7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9cIH8VQPIDo1PND9KW5y2Tsll6u61IkY/vZAXCrrTeA380ZjpNBWRomm5/j0UYPr5lnxPuLOGxrpl1l+OsbqvLPb94dyJXiOHFM4bkLRtFpa8Lsna+yap3jAwPZvDTGPF5xk7nrO5TZQZEtO2XFb0IhyEOeUXVd3KiIEdkXUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgIaGUC2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgIaGUC2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2293EC2BCF5;
	Mon, 18 May 2026 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779090640;
	bh=L3SFGcMUzcDzpjakQjdld7MbV/fV98urqNcZ8p9Ct7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dgIaGUC2rggFU1LI4TW1uE8QRp6ZYYz/lP5IqtDghNiQN2RACLDHds3elD1BJQAOA
	 xnRXsGnM9tggnS+HJEcMbFQSr67Mtb1+X460o64MAWlwGcuMLofpLVlnpMjrw9wJJP
	 zVjI+5bQ054KYpG9VRvpAxCa/1RZaIJsSOhcVgRb+SZyHeWyLA82DxGJa440lEi6gN
	 AEMgaftqTTvBHDXw5qLhDhu6oGI3OKMYBsgTd2YHRtNT/42DCVRsi1nWc0VL5Xbw4A
	 a5tRpJbWrPkXmTTB74FyRVIcVpWpcLdfWliinVUtIameT5aFuA1XFANcId45Ej9MlQ
	 HSccOIfBcp3KQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130EBCD4F3C;
	Mon, 18 May 2026 07:50:40 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 18 May 2026 09:50:25 +0200
Subject: [PATCH v8 1/5] iio: magnetometer: ak8975: switch to using managed
 resources
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-magnetometer-fixes-post-pickup-v8-1-088d610108a0@gmail.com>
References: <20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0@gmail.com>
In-Reply-To: <20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779090640; l=5045;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=givHTS5pQ9lRym85HWLXh4HlEe6bie7ypSYk6PAi+Po=;
 b=ul6qbMTg8niw+bAiPexJiqR8GR3eE7Fot7gNCdyq35CdtfgoMiLTl8ryRN0Zd4tQ4EOgCg7QO
 fYvEzoHm2aTB77cGUcRI6R09K4oYHzHgOzyWcF/LAxLZYescKOHVr9F
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

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
 drivers/iio/magnetometer/ak8975.c | 77 ++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index bb74abb648f138352576a68c49d3c7dce7cc068e..de4402201783430fc69369f1accaab35145e9f0c 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -935,9 +935,25 @@ static const struct iio_buffer_setup_ops ak8975_buffer_setup_ops = {
 	.preenable = ak8975_buffer_preenable,
 	.postdisable = ak8975_buffer_postdisable,
 };
+
+static void devm_ak8975_power_off(void *data)
+{
+	struct ak8975_data *ak = data;
+	struct device *dev = &ak->client->dev;
+
+	/* Only power down if currently active */
+	if (pm_runtime_suspended(dev))
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
@@ -1005,10 +1021,21 @@ static int ak8975_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	/*
+	 * Set device as active early so pm_runtime_status_suspended() works
+	 * correctly if probe fails before pm_runtime is enabled. Do not attempt
+	 * to move this line lower.
+	 */
+	pm_runtime_set_active(dev);
+
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
 
@@ -1016,10 +1043,13 @@ static int ak8975_probe(struct i2c_client *client)
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
@@ -1027,52 +1057,32 @@ static int ak8975_probe(struct i2c_client *client)
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
@@ -1166,7 +1176,6 @@ static struct i2c_driver ak8975_driver = {
 		.acpi_match_table = ak_acpi_match,
 	},
 	.probe		= ak8975_probe,
-	.remove		= ak8975_remove,
 	.id_table	= ak8975_id,
 };
 module_i2c_driver(ak8975_driver);

-- 
2.47.3


