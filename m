Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843553E0090;
	Mon, 18 May 2026 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090641; cv=none; b=s5gaIQIFw55MIjT8/g4EdTO4wl99+CI7LHNG0Z4o4q4chT06CdS4vdmj9facxjxKqoGdHtMhgwCkLNiClxdVawsRFVBFh/y0zKT+W3jqNuodngNv1WpUYY2BSZovGPleZn6DhRsWp1TR8bbezQryyDaqx0nY8ojm3EZ3AlLCOfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090641; c=relaxed/simple;
	bh=LPMMeRotTvJ3x7wTNmob9kcjWns9R95Pq8+qeh9qnxE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uq91XnxTzmjkb73R4GVm/pGmZopBPZyRKNASNw5Hbu4leCCchKGN61C3HnSV67DUedvwfCS2jlhS7mR1zvnSPVLAD8s2gqlGm0CLedG9e9iYr0Wqv+gEuYxx+RL1jMh+VQSZYYXUEG4lrzmr2gk7fv4Y6eTsAajEdH1tvPdKbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkgVfLPV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkgVfLPV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48421C2BCF6;
	Mon, 18 May 2026 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779090640;
	bh=LPMMeRotTvJ3x7wTNmob9kcjWns9R95Pq8+qeh9qnxE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EkgVfLPViYOk3ChlMt+zTTIRY/nQftiP6Cb+i1NpKLKBTYbtu67aItF26IxF8YGT9
	 bTiajb+fF5XEkU+CEMuJzI4KR+XOsu5zEa7WN/dg4jy4AZWBJ5CVIL1tscXxNWozWe
	 OpDIw+GV1x9YVtT/Cl5N83S+DgjtZLOpHIhyyzcDuu55jzD8YCVTX7yhuqKbGc6shT
	 3g5ezWZMXEdteyw+6aiGp1f/yW6u6OK4rb4WTZlEEWs2joxK17yfNXbN3eDsaoWubn
	 oQQM891YsVhkcPbOKWa/I7ps8dwh8DQPRVHrczXPE8CxkMh9yhrvNVxNDdi3MIsG36
	 trZSvQREK+oow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE9ACD4F48;
	Mon, 18 May 2026 07:50:40 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 18 May 2026 09:50:27 +0200
Subject: [PATCH v8 3/5] iio: magnetometer: ak8975: use temporary variable
 for struct device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-magnetometer-fixes-post-pickup-v8-3-088d610108a0@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779090640; l=8351;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=fj3a/1mBXtCXzLsk2ujeqiVE658SWCx0SgFuPZgY3/E=;
 b=rxYyfWt5CsM4ze8bLLpnN/QB8RJjJRvAnez+KNTpJtvUJNqCafos5NLYqv3hTdDy41XTSkbgh
 WkW9C++Y400DpX8xHeUprfoE1UbUtocCnC590jP+NGs36pV5QgQ0ce3
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Use temporary variable for struct device to make code neater.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 63 +++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index e7cd28ab37aaeb2b68758a42ba40a87c71bd1e24..7ab4c4d69d8b73c6f367f6e62fee3017d8691b67 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -433,18 +433,17 @@ struct ak8975_data {
 /* Enable attached power regulator if any. */
 static int ak8975_power_on(const struct ak8975_data *data)
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
@@ -574,6 +573,7 @@ static irqreturn_t ak8975_irq_handler(int irq, void *data)
 static int ak8975_setup_irq(struct ak8975_data *data)
 {
 	struct i2c_client *client = data->client;
+	struct device *dev = &client->dev;
 	int irq;
 	int ret;
 
@@ -584,9 +584,8 @@ static int ak8975_setup_irq(struct ak8975_data *data)
 	else
 		irq = gpiod_to_irq(data->eoc_gpiod);
 
-	ret = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
-			       IRQF_TRIGGER_RISING,
-			       dev_name(&client->dev), data);
+	ret = devm_request_irq(dev, irq, ak8975_irq_handler, IRQF_TRIGGER_RISING,
+			       dev_name(dev), data);
 	if (ret)
 		return ret;
 
@@ -602,12 +601,13 @@ static int ak8975_setup_irq(struct ak8975_data *data)
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
 
@@ -617,7 +617,7 @@ static int ak8975_setup(struct ak8975_data *data)
 							sizeof(data->asa),
 							data->asa);
 	if (ret < 0) {
-		dev_err(&client->dev, "Not able to read asa data\n");
+		dev_err(dev, "Not able to read asa data\n");
 		return ret;
 	}
 	if (ret != sizeof(data->asa)) {
@@ -628,15 +628,14 @@ static int ak8975_setup(struct ak8975_data *data)
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
@@ -742,10 +741,11 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	struct ak8975_data *data = iio_priv(indio_dev);
 	const struct i2c_client *client = data->client;
 	const struct ak_def *def = data->def;
+	struct device *dev = &data->client->dev;
 	__le16 rval;
 	int ret;
 
-	pm_runtime_get_sync(&data->client->dev);
+	pm_runtime_get_sync(dev);
 
 	mutex_lock(&data->lock);
 
@@ -767,20 +767,20 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
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
@@ -789,8 +789,8 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 exit:
 	mutex_unlock(&data->lock);
-	pm_runtime_put_autosuspend(&data->client->dev);
-	dev_err(&client->dev, "Error in reading axis\n");
+	pm_runtime_put_autosuspend(dev);
+	dev_err(dev, "Error in reading axis\n");
 	return ret;
 }
 
@@ -962,7 +962,7 @@ static int ak8975_probe(struct i2c_client *client)
 	 * We may not have a GPIO based IRQ to scan, that is fine, we will
 	 * poll if so.
 	 */
-	eoc_gpiod = devm_gpiod_get_optional(&client->dev, NULL, GPIOD_IN);
+	eoc_gpiod = devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
 	if (IS_ERR(eoc_gpiod))
 		return PTR_ERR(eoc_gpiod);
 	gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
@@ -972,13 +972,12 @@ static int ak8975_probe(struct i2c_client *client)
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
 
@@ -990,7 +989,7 @@ static int ak8975_probe(struct i2c_client *client)
 	data->reset_gpiod = reset_gpiod;
 	data->eoc_irq = 0;
 
-	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
 
@@ -1000,16 +999,16 @@ static int ak8975_probe(struct i2c_client *client)
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
 
@@ -1032,7 +1031,7 @@ static int ak8975_probe(struct i2c_client *client)
 	if (ret)
 		return dev_err_probe(dev, ret, "Unexpected device\n");
 
-	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
+	dev_dbg(dev, "Asahi compass chip %s\n", name);
 
 	/* Perform some basic start-of-day setup of the device. */
 	ret = ak8975_setup(data);
@@ -1068,8 +1067,8 @@ static int ak8975_probe(struct i2c_client *client)
 	 * The device comes online in 500us, so add two orders of magnitude
 	 * of delay before autosuspending: 50 ms.
 	 */
-	pm_runtime_set_autosuspend_delay(&client->dev, 50);
-	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_set_autosuspend_delay(dev, 50);
+	pm_runtime_use_autosuspend(dev);
 
 	return 0;
 }
@@ -1084,7 +1083,7 @@ static int ak8975_runtime_suspend(struct device *dev)
 	/* Set the device in power down if it wasn't already */
 	ret = ak8975_set_mode(data, POWER_DOWN);
 	if (ret < 0) {
-		dev_err(&client->dev, "Error in setting power-down mode\n");
+		dev_err(dev, "Error in setting power-down mode\n");
 		return ret;
 	}
 	/* Next cut the regulators */
@@ -1108,7 +1107,7 @@ static int ak8975_runtime_resume(struct device *dev)
 	 */
 	ret = ak8975_set_mode(data, POWER_DOWN);
 	if (ret < 0) {
-		dev_err(&client->dev, "Error in setting power-down mode\n");
+		dev_err(dev, "Error in setting power-down mode\n");
 		return ret;
 	}
 

-- 
2.47.3


