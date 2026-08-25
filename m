Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE93E1204;
	Tue, 25 Aug 2026 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646504; cv=none; b=as2VWgPxcKxjUya3CYUihb7M2ZyqbUcDhj41m9BSGhYae3Zyy3eU6Z4zDeXlxcyF3ydQ2t6n+HU9MTUWZ+e44mnVMFKVSbducaUg5lyW8vMyunpvjzTufj+kkkLKxmhKWzumsT2vfE6R4rLbcIlbJz5YJPjgenmENX5n6NC3Bu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646504; c=relaxed/simple;
	bh=bojCcomNTsdEGb4oeI4rcH3xpLlA9mJQriR/9T1ndoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tKBb3QOGfyANuOefEAzreoBdgnY5N6qzL1KHsPW0j/M7rEcDArm+6tP+sgSe2CZuCmY30FQVNyKHUzKo+IGbjbsjK9YaLADJjrF1E1xY7GwAVEqi1Hedp+t8hq5lkUdAPTqyycIr9UuJ8sRB+SZAPVSe9HE8VRKeUcVXLGGY2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mqmiiysv; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mqmiiysv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787646488; x=1787905688;
	bh=+WAZ4hdv+APN6X7EegqQeBOAzEEU6LCBR/Gp11AEPYg=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mqmiiysvD020t46eLzBJ+tmjLUIr62B0k0uPXOIYMOiMNdpsjagfuoP+Ve8Bng/lS
	 uUlUUrBIQoIQvKb2+0ddjbvcppfKTTFud/cbnz+YlYe09dDJvgaEsQJXFEoSNaCdI9
	 D4Byjh4Pnpw4Qr5ko+lTrFHqOEZvXdqKCrkh7LCilq+ffyjErteFkUidXJrcKONiYb
	 g9CeyDqXdnN9rBv9nHd/d3F0zYKbuW9jodqXW3TglEJii0P9ZhB2cOdyR5h/lFwP0m
	 0ZROiALSY6X+oTrylHSLK7i2o13qupD3EopBZc/SbutvQIOOX81l+91RHqbRD+XEf7
	 mS4yJvwRkiLrA==
X-Pm-Submission-Id: 4hTgs3344Wz2SdHS
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 25 Aug 2026 10:27:44 +0200
Subject: [PATCH v6 6/9] iio: accel: mma8452: Reuse existing dev pointer in
 mma8452_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-mma8452-open-drain-v6-6-9b252804ee80@geanix.com>
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
In-Reply-To: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787646470; l=4502;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=bojCcomNTsdEGb4oeI4rcH3xpLlA9mJQriR/9T1ndoA=;
 b=C5KuQGS24dzGUd9/7Yf5RS3dcvJqTNJSy++rQc3/YgjSWS1/NYOmynM1i2PYM/xt56sh/daQR
 hjXOaAozd+1Cjn7PH9p0r5CZNPOSQls82nVvceRbX1uqXF83ZZRKyeq
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

In commit 32a5c04d4575 ("iio: accel: mma8452: Use dev_err_probe()") the
struct device * pointer was assigned to local variable dev, so we can just
as well reuse that throughout the function for sligthly more readable code.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index d1e8eb2a4ad3..7ef1a9a91c31 100644
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
@@ -1801,7 +1799,8 @@ static void mma8452_remove(struct i2c_client *client)
 #ifdef CONFIG_PM
 static int mma8452_runtime_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int ret;
 
@@ -1809,7 +1808,7 @@ static int mma8452_runtime_suspend(struct device *dev)
 	ret = mma8452_standby(data);
 	mutex_unlock(&data->lock);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "powering off device failed\n");
+		dev_err(&client->dev, "powering off device failed\n");
 		return -EAGAIN;
 	}
 

-- 
2.55.0

