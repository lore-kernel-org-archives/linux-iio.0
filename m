Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3429040D574;
	Wed, 19 Aug 2026 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127391; cv=none; b=mTj9RbEayT+wJXvv6oPxbzCOMIvKWdpXhrgJJGpehuAuTZUW6C8b/ShfpuSBmiMD4glbvH3d17PytJbUBAbERRr7mP3TFJ9DPt+gPQrpZFR+Jh4dvqT6zmkLbsexFCcyA8oiRqUkPB8uiE+FkXEFPxolvVpKwXXiVu2w9+cjx9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127391; c=relaxed/simple;
	bh=zS8pidQ1mEadcEjjYN01ocB65EC9PKhbCuWuE5NGL5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gb+cRTVE7EhwnUQVvpuHVhl/hV+FZhp48alJcQXzZbRJqugzlbL/BKrpRGtcZ+czmfFAYf+CoNjicfUP4KObOKazYnRVM/267RlT6RkyAaIgVM/V7SRx9V9IRqeSBJ4TGEWG+yYPf2uvg9vT+xX0BPDSRv5dp4TRTgV0L4t1v2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=IJiLK5cY; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="IJiLK5cY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787127356; x=1787386556;
	bh=6nHoTnGTwSgjLBaedsdqQuiT9UNbLckAf+tplzrcQG8=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=IJiLK5cYvC/30gtNQl4f+0xyq5sO1SU7/mMAmM2HqZC6eJzJ0scBeGX4chRlc02iH
	 N2oV02+55hWkxKKpq0LAB9K1pMj7oIBVuvrX855YVg1iLL8TGaSKD5R1BaulNOA7TQ
	 mdy0LPCjcLT81vsVFHjrh+P3SibaXNcGD9MJVeY2pkc4VHdmyImd8Vyi1V3dij9j5X
	 UBVF0muu1NtPvVxrHevf0G00+sDb8uxfrc869P8+0GbxFvQDrkfOTbCJj9u0/EoEoy
	 N7s9WEj2p80fuGPiex9GCAEUoMEblfxK/2jvy/r973P2lWzIDr5PxoM/AwdCS298hW
	 Lv6tfonBpPGsg==
X-Pm-Submission-Id: 4hPzsl489mz1DDs3
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 19 Aug 2026 10:15:33 +0200
Subject: [PATCH RESEND v5 6/6] iio: accel: mma8452: Reuse existing dev
 pointer in mma8452_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-mma8452-open-drain-v5-6-d8aa590d7c36@geanix.com>
References: <20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com>
In-Reply-To: <20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787127340; l=3727;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=zS8pidQ1mEadcEjjYN01ocB65EC9PKhbCuWuE5NGL5Y=;
 b=XNmUX0dG9EsrmrUQz2RniNJs7D1U3dsFk6bDbnmbIAmK6IlNQGLJfFXb30WHEBrAUUV9Rp7Ts
 SOnEyYum1O9AGIVvWrOeXTaRbDq+5wpodLifyPlfNxIxbEBi77QcEbY
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

In commit 32a5c04d4575 ("iio: accel: mma8452: Use dev_err_probe()") the
struct device * pointer was assigned to local variable dev, so we can just
as well reuse that throughout the function for sligthly more readable code.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 060a6207e52d..bf5cb1c4425a 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1582,7 +1582,7 @@ static int mma8452_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1592,21 +1592,20 @@ static int mma8452_probe(struct i2c_client *client)
 
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
@@ -1638,7 +1637,7 @@ static int mma8452_probe(struct i2c_client *client)
 		goto disable_regulators;
 	}
 
-	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
+	dev_info(dev, "registering %s accelerometer; ID 0x%x\n",
 		 data->chip_info->name, data->chip_info->chip_id);
 
 	i2c_set_clientdata(client, indio_dev);
@@ -1671,10 +1670,10 @@ static int mma8452_probe(struct i2c_client *client)
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
@@ -1682,7 +1681,7 @@ static int mma8452_probe(struct i2c_client *client)
 			if (ret < 0)
 				goto disable_regulators;
 
-			dev_dbg(&client->dev, "using interrupt line INT1\n");
+			dev_dbg(dev, "using interrupt line INT1\n");
 		}
 
 		ret = i2c_smbus_write_byte_data(client,
@@ -1731,14 +1730,13 @@ static int mma8452_probe(struct i2c_client *client)
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

