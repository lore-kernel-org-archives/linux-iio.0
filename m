Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F384F384CEF;
	Sat,  8 Aug 2026 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208307; cv=none; b=Gcu9mNKEHjLA1bixf7ks30kpOLjEQPA2TJdVI/Ilj1qaWmuyThq5K1SwcB9M2zhgnEaofRtDkWWBFkam1fBtyLZiEI7vf8R1C0359+LXhytG9db+MyziwGHDTa4LqSgIavPyG8xJfMcZbXpG/ibN0TB09w7KttYlyTzw+Jrs+kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208307; c=relaxed/simple;
	bh=5MI7knjElq6eNpaZCdmw31TCtxTB6G/t5OmsxOIIxQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=daJ6vsIkw1J4vbfVj2nQ3bybT5uPTq8c6h7jOM5tunaMG9OJ+4Yoek+DgqnI7HLD9mNpOo1PsLfYJdzqPAmvt3p+H9L7xk7MZq6eVPZgHHB7vWz0PAU8PMclonhDgxt8YTsTBcD92ywTGIR7myrVMVMeUZb9eJUdTzS8p18tHfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnOXjMXV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnOXjMXV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A264EC2BCF7;
	Sat,  8 Aug 2026 16:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786208306;
	bh=5MI7knjElq6eNpaZCdmw31TCtxTB6G/t5OmsxOIIxQM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DnOXjMXVn4ymg4zMmnM/+iVggHczKAhRUYRvqWXCufS8ayO6RwNBE9ZbLay5AXrCA
	 n7sXRYlxw1xWHXMfhdNFFkw8FiaK05+7BGKEzxYtjUsd9Cu4rPgGGXVl6g9ECoeNsy
	 14qbB+0urgnG82odZ7l+ET9Vh8EhEPymGN8e4UuGZXSOIGQh2mMlwDdX19aJT0ZzfQ
	 ow1t48ymacJmQ7JfnQCG9N3PhtT3bt71guyzJZToRW1lVaprV2MX3MUdL7dIYtZSPI
	 os+pEQpKyxHvetdbTWUYMNjDAGVUJPZKWPRCsy+LUJWfR91eQ6HUkqeeXxMhstjMS2
	 RPisIy5cYq80A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FECC5AD2C;
	Sat,  8 Aug 2026 16:58:26 +0000 (UTC)
From: Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
Date: Sat, 08 Aug 2026 22:28:14 +0530
Subject: [PATCH v5 2/4] iio: accel: mma8452: use local struct device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-15-apr-pm-iio-mma8452-v4-temp-v5-2-d177e93ce3f8@gmail.com>
References: <20260808-15-apr-pm-iio-mma8452-v4-temp-v5-0-d177e93ce3f8@gmail.com>
In-Reply-To: <20260808-15-apr-pm-iio-mma8452-v4-temp-v5-0-d177e93ce3f8@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786208304; l=4596;
 i=sanjayembeddedse@gmail.com; s=20260702; h=from:subject:message-id;
 bh=LXfSnV6rBvAa1+8KwnMa4fMrZA8D3loMbNKlUnNF0CM=;
 b=6z8XKHl+BuAKd8GYNkxz87hJd+hu4XW3WvL62HT2idawPbRJYOaDq1q9SWAYiYQXUYKDprn5S
 p5VoV70kPblB9/h5rzHP0726fVhY5IGlVlIEA7moiXuHZ4RpK4ebteX
X-Developer-Key: i=sanjayembeddedse@gmail.com; a=ed25519;
 pk=PcneEFtkmY+Ldl+KmOTpB/Q/HDsqko6Fb0/Z/5cuycI=
X-Endpoint-Received: by B4 Relay for sanjayembeddedse@gmail.com/20260702
 with auth_id=848
X-Original-From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reply-To: sanjayembeddedse@gmail.com

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Introduce a local struct device pointer derived from &client->dev.
This avoids repeated &client->dev usage and improves readability.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

---
changes in v4:
- address coding style comment given by Andy
- v3 link -> https://lore.kernel.org/all/20260505174640.3998281-8-sanjayembedded@gmail.com/
---
 drivers/iio/accel/mma8452.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 772463d5ff47..af0cc5970f3b 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -222,15 +222,15 @@ static int mma8452_drdy(struct mma8452_data *data)
 static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
 {
 #ifdef CONFIG_PM
+	struct device *dev = &client->dev;
 	int ret;
 
 	if (on)
-		ret = pm_runtime_resume_and_get(&client->dev);
+		ret = pm_runtime_resume_and_get(dev);
 	else
-		ret = pm_runtime_put_autosuspend(&client->dev);
+		ret = pm_runtime_put_autosuspend(dev);
 	if (ret < 0) {
-		dev_err(&client->dev,
-			"failed to change power state to %d\n", on);
+		dev_err(dev, "failed to change power state to %d\n", on);
 
 		return ret;
 	}
@@ -1552,7 +1552,7 @@ static int mma8452_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1562,10 +1562,9 @@ static int mma8452_probe(struct i2c_client *client)
 
 	data->chip_info = i2c_get_match_data(client);
 	if (!data->chip_info)
-		return dev_err_probe(&client->dev, -ENODEV,
-				     "unknown device model\n");
+		return dev_err_probe(dev, -ENODEV, "unknown device model\n");
 
-	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
 
@@ -1598,7 +1597,7 @@ static int mma8452_probe(struct i2c_client *client)
 		goto disable_regulators;
 	}
 
-	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
+	dev_info(dev, "registering %s accelerometer; ID 0x%x\n",
 		 data->chip_info->name, data->chip_info->chip_id);
 
 	i2c_set_clientdata(client, indio_dev);
@@ -1631,10 +1630,10 @@ static int mma8452_probe(struct i2c_client *client)
 	if (client->irq) {
 		int irq2;
 
-		irq2 = fwnode_irq_get_byname(dev_fwnode(&client->dev), "INT2");
+		irq2 = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
 
 		if (irq2 == client->irq) {
-			dev_dbg(&client->dev, "using interrupt line INT2\n");
+			dev_dbg(dev, "using interrupt line INT2\n");
 		} else {
 			ret = i2c_smbus_write_byte_data(client,
 							MMA8452_CTRL_REG5,
@@ -1642,7 +1641,7 @@ static int mma8452_probe(struct i2c_client *client)
 			if (ret < 0)
 				goto disable_regulators;
 
-			dev_dbg(&client->dev, "using interrupt line INT1\n");
+			dev_dbg(dev, "using interrupt line INT1\n");
 		}
 
 		ret = i2c_smbus_write_byte_data(client,
@@ -1679,14 +1678,13 @@ static int mma8452_probe(struct i2c_client *client)
 			goto buffer_cleanup;
 	}
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret < 0)
 		goto free_irq;
 
-	pm_runtime_enable(&client->dev);
-	pm_runtime_set_autosuspend_delay(&client->dev,
-					 MMA8452_AUTO_SUSPEND_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, MMA8452_AUTO_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
@@ -1721,11 +1719,12 @@ static void mma8452_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct mma8452_data *data = iio_priv(indio_dev);
+	struct device *dev = &client->dev;
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
@@ -1748,7 +1747,7 @@ static int mma8452_runtime_suspend(struct device *dev)
 	ret = mma8452_standby(data);
 	mutex_unlock(&data->lock);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "powering off device failed\n");
+		dev_err(dev, "powering off device failed\n");
 		return -EAGAIN;
 	}
 

-- 
2.34.1


