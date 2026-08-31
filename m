Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0D3F4DCF;
	Mon, 31 Aug 2026 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178652; cv=none; b=ZPw+1HiQvIutblx9vf1vQklBJfBNVTuZcRTEy56XwMt8rh0JSxAxpZ49AJSmGbnhYvrPifE1AmwMrS6iu4TvUKY7h3vYdiJcBzG1/ujqynMr8FvgC6DQzQLL1qyUUT2dOcKRrLyyNHGOPnLllkF9El+/UJCCMUF5Z7od+AsJ0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178652; c=relaxed/simple;
	bh=34Br3bh4ES15KWd8ZuqEaj+uBXJutTdfjD/RifG+LSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lIbTpUjDni9SDneeJsAbxV+UXpjr/k5Uh22RnNyKnuV3OmcztCl/CgnZepwV/n/359niQkrlamfR2lt564wLCC8lbV9QkUKRSm7lGUMH5zfdObdG2TFD/wzpkH+ae5zEbiZLLZyrT5yUmFs++mTJvzVGkOJq1lbmHyVW410NjYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=BxGOxzDi; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="BxGOxzDi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788178645; x=1788437845;
	bh=YxvbCdJglJ60chOji4ihckHLdAxqWh2Hg3ol4lFeN4E=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BxGOxzDiJSCvaH3OYuctoX0gbqxvArS5+pdAc7CwR0vJhbflhpbMSjdElRAhD90DC
	 pJtGFT8y5+lA61AC+FverMm3nwuZ9UyAQEi7njXerfbr5eJdiAK/Q1KdX1y+Z79rL1
	 mCYa4BNlJv4s+AmCdN6zL148AZx+m8InBn+6csF1V4kgO7pCB+4HYOZVr1P9q5pKLc
	 8IaFPY9kvFYsJT66R3qJxw86ukQOwKxwITTs0IMgkVSwConR12zZepIiPaZM7gBsJW
	 ESHF3os65oj/hGBTFlXGwfrU2Dl/N65GTSoaHKqdx8OE749HpYLWz/XzOB7VOwF2WK
	 NFRlg36q0RvjQ==
X-Pm-Submission-Id: 4hYSfq3bdkz1DFFv
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 31 Aug 2026 14:17:09 +0200
Subject: [PATCH v7 6/8] iio: accel: mma8452: Reuse existing dev pointer in
 mma8452_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-mma8452-open-drain-v7-6-22946812c928@geanix.com>
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
In-Reply-To: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788178627; l=4085;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=34Br3bh4ES15KWd8ZuqEaj+uBXJutTdfjD/RifG+LSA=;
 b=l1OYfqKXSAz8przx9oJ+ZHD5BiPXhxmCjtzWhOb7PROI6wDqp9M3+fShvlgZXyHpfC4qToTs+
 ovCvlPB6xlpC2UIO0a/oCwVBrXrwSQpFicPUZJ1uMJtW89ynIiIkTIC
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

In commit 32a5c04d4575 ("iio: accel: mma8452: Use dev_err_probe()") the
struct device * pointer was assigned to local variable dev, so we can just
as well reuse that throughout the function for sligthly more readable code.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 2ba6e2c44cb9..bf56ebd6e091 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1587,7 +1587,7 @@ static int mma8452_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1597,21 +1597,20 @@ static int mma8452_probe(struct i2c_client *client)
 
 	data->chip_info = i2c_get_match_data(client);
 	if (!data->chip_info)
-		return dev_err_probe(&client->dev, -ENODEV,
-				     "unknown device model\n");
+		return dev_err_probe(dev, -ENODEV, "unknown device model\n");
 
-	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)
 		return ret;
 
-	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
+	data->vdd_reg = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(data->vdd_reg))
-		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_reg),
+		return dev_err_probe(dev, PTR_ERR(data->vdd_reg),
 				     "failed to get VDD regulator!\n");
 
-	data->vddio_reg = devm_regulator_get(&client->dev, "vddio");
+	data->vddio_reg = devm_regulator_get(dev, "vddio");
 	if (IS_ERR(data->vddio_reg))
-		return dev_err_probe(&client->dev, PTR_ERR(data->vddio_reg),
+		return dev_err_probe(dev, PTR_ERR(data->vddio_reg),
 				     "failed to get VDDIO regulator!\n");
 
 	ret = regulator_enable(data->vdd_reg);
@@ -1643,7 +1642,7 @@ static int mma8452_probe(struct i2c_client *client)
 		goto disable_regulators;
 	}
 
-	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
+	dev_info(dev, "registering %s accelerometer; ID 0x%x\n",
 		 data->chip_info->name, data->chip_info->chip_id);
 
 	i2c_set_clientdata(client, indio_dev);
@@ -1676,10 +1675,10 @@ static int mma8452_probe(struct i2c_client *client)
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
@@ -1687,7 +1686,7 @@ static int mma8452_probe(struct i2c_client *client)
 			if (ret < 0)
 				goto disable_regulators;
 
-			dev_dbg(&client->dev, "using interrupt line INT1\n");
+			dev_dbg(dev, "using interrupt line INT1\n");
 		}
 
 		ret = i2c_smbus_write_byte_data(client,
@@ -1736,14 +1735,13 @@ static int mma8452_probe(struct i2c_client *client)
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
@@ -1810,7 +1808,7 @@ static int mma8452_runtime_suspend(struct device *dev)
 	ret = mma8452_standby(data);
 	mutex_unlock(&data->lock);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "powering off device failed\n");
+		dev_err(dev, "powering off device failed\n");
 		return -EAGAIN;
 	}
 

-- 
2.55.0

