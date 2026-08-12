Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF75463B95
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545077; cv=none; b=NFG2eQKZeHh61qfwfiiySQ0zrwNBKSMKi6xos1CVx3Aueqwwx0TsgfhucCdNziEvYVwSXpccVDxwf8fOwDyNmUEW3IK07i9ZnDmOavnCaaTERGHYX4ZoGNZabJQVifI+Vs9Cq2Jb0SUAR2GKRCn8oIMO293RgGNb80MZDeND588=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545077; c=relaxed/simple;
	bh=gPR2ObyQvW8OM8BSHrpHDJoOtSHCtpa4ZLA4WD4+Opc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SEOC0ye3Sm+r6aFXxtfrc/qPRlt4XKdXNSNqDyX8tQH9+6zZoLr6Nlqqj0WHG/w4wwE9eR5/b9m9tDPotRAvG7t8PmHG9yJszbIJH3FEuUDzaYK+uIIYmipVMMneQPi5h9deP1hNhmNu8TRQxkHmaMr7SvHWEomrSeUu8Xk/uJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=LtyIKTsN; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="LtyIKTsN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786545061; x=1786804261;
	bh=KslHpslC7vJccQ/CYVv8G91Fsus5PafzrnbdiE2LXTU=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LtyIKTsNdAIyUEapyh2kZt1INU7I69khHgY7sqzSvuyFXBj3R0tMjwjv5zVwVDRpl
	 5Y09X/guwGd+i/cOeqkBs/hikPE+HrOB8NGrE+POcohk9IuFZ9BOvv0S7Vd/ltZgAC
	 AlHhA/Az3UzMnjVN0QPtg2lku1YD53+2fWE1zNcvIu0LeNJ2AIxiNoNZyCDpSD/70a
	 45O55nau1fuGTq3SqcUgqnwco+JVdNMQryXfgEvB89z83yGCJvJjbxHWwSvwvFJ/zR
	 OkLdmJY+lnpFVLdg9vhQYjSFu7aXh53OBviKYJtbRXIv8G6UgPcByv2O6rZQenIgj2
	 YJWxMjxdqSMOw==
X-Pm-Submission-Id: 4hKrWl3RPBz2Sd2n
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 12 Aug 2026 16:30:37 +0200
Subject: [PATCH v4 6/6] iio: accel: mma8452: Reuse existing dev pointer in
 mma8452_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-mma8452-open-drain-v4-6-bfca15d02b59@geanix.com>
References: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com>
In-Reply-To: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786545039; l=3699;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=gPR2ObyQvW8OM8BSHrpHDJoOtSHCtpa4ZLA4WD4+Opc=;
 b=THRC8avmJtducuhc3V7bjLxXAdmKDUhY+YGegyNjBkj/WQ17W1UOT3LO1L7adVI7Nh84v/qrI
 ilsF0p/2/WWDDRryNM9fUHA/ij9X+/kTpGTywiUpwxMreH54f0CdYmK
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

In commit 32a5c04d4575 ("iio: accel: mma8452: Use dev_err_probe()") the
struct device * pointer was assigned to local variable dev, so we can just
as well reuse that throughout the function for sligthly more readable code.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7992f9e38818..2fbf9f9ed9d7 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1581,7 +1581,7 @@ static int mma8452_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1591,21 +1591,21 @@ static int mma8452_probe(struct i2c_client *client)
 
 	data->chip_info = i2c_get_match_data(client);
 	if (!data->chip_info)
-		return dev_err_probe(&client->dev, -ENODEV,
+		return dev_err_probe(dev, -ENODEV,
 				     "unknown device model\n");
 
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
@@ -1637,7 +1637,7 @@ static int mma8452_probe(struct i2c_client *client)
 		goto disable_regulators;
 	}
 
-	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
+	dev_info(dev, "registering %s accelerometer; ID 0x%x\n",
 		 data->chip_info->name, data->chip_info->chip_id);
 
 	i2c_set_clientdata(client, indio_dev);
@@ -1670,10 +1670,10 @@ static int mma8452_probe(struct i2c_client *client)
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
@@ -1681,7 +1681,7 @@ static int mma8452_probe(struct i2c_client *client)
 			if (ret < 0)
 				goto disable_regulators;
 
-			dev_dbg(&client->dev, "using interrupt line INT1\n");
+			dev_dbg(dev, "using interrupt line INT1\n");
 		}
 
 		ret = i2c_smbus_write_byte_data(client,
@@ -1730,14 +1730,13 @@ static int mma8452_probe(struct i2c_client *client)
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

-- 
2.55.0

