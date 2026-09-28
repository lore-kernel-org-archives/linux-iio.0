Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373D4756C4
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584013; cv=none; b=Jhunxb3jKywsI6MyX12NGKSyJZhxnDz32SphemKEdLKm6vTbhFQ85QzYY+AXbLHLSbHFZG3zNUzX/d+5goM/r7iAEPzl4kkQdygaheSNszRGX83uVOPK+O5ZrkR0hiTp11ntZJRJtWHfQe01Ao5HS9jBUbEh+oznjMmzWJOFO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584013; c=relaxed/simple;
	bh=oyTsDKxlsAv6YtjCMarHV3m081TpTe743p4uxpuZpkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZkWK9Ks6qfRO3fgJ39xLPdiZnB0TiX9mmyGmLaZ6Rsm0/A0VVAq4KZ/cfBaId0kXVRLGkULqvJdLDqdjfA8QCMKf7h65qAIAksi5Yc5FyVoY3NpqfgqMsR4bh0ezg+XkA8qRBrj2dU0GkG0JnFz7/hBEDvorz5J9jO5f1OmvuRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=RhKDvFR/; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="RhKDvFR/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1790584006; x=1790843206;
	bh=D3csb1h/+bja1wK6CStFmw7G93ndMJmKRxnYM1geIUo=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RhKDvFR/P0ZvA1mpjDr27BK/trn/3nRdO4m85ugm7UWKuBOjKb8RgFXHK+1AUKGbP
	 X4JE42MA3PXOuBMPrUZJVoOKwHl9z2sY+bmEqTZRHbcaYGXYuKNhYJBD4mjqhXl3Er
	 87MjZ15BIcWPXNdEG67VnBGV0SxoY1kHQgVYGxRqCX9igamxRyZn3sDYYx4hDHV9Wr
	 JUyWw84MWBvkL7+3kH+XcYSctqKeCz/GI7d4nOb1XBlm1mdY2/89WDeYPV3zXnOFAy
	 mEJ/N91IJsDRjjQruNR6pYy1LM2NcCjpi8uCnu999nlUKTpyjZjOuuawbzYK1+I5FW
	 Gm2HFh1MjQPhQ==
X-Pm-Submission-Id: 4htZCm6Zsdz1DFG0
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 28 Sep 2026 10:26:26 +0200
Subject: [PATCH v10 10/10] iio: accel: mma8452: Support interrupt sharing
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mma8452-open-drain-v10-10-b906fb408386@geanix.com>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
In-Reply-To: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790583982; l=7994;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=oyTsDKxlsAv6YtjCMarHV3m081TpTe743p4uxpuZpkI=;
 b=W2IjSOuZasoL/VL/M7EJzuS80hEx/YgIUKem1qeq1Moil3PXnMPz4MDaK1SrDMmmy+rdAH5nj
 IH6e2xtytEeAwrb6MxrcJMvyQMjSFjIewGkWchxWPYgjIwteznKaMh8
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Adding support for sharing interrupt line with other device requires the
interrupt handler to handle runtime PM suspension properly, ignoring the
irq if the device is suspended (maybe even off). And while at it, we use
the PM reference to ensure we do not get suspended while processing an irq.

In order to prevent the chip from raising irq while suspended (that is when
using fixed regulator, where suspend just means setting the device in
STANDBY mode), we disable all interrupt sources by clearing CTRL_REG4, and
then restores the value again when resuming.

The scoped_guard in mma8452_runtime_suspend() is changed to a plain
mutex_lock() instead, both to prevent mixing guards and goto, but also to
ensure that we stay in STANDBY mode while writing to CTRL_REG4 and all the
way up to disabling the device as much as possible.

With that in place, it is safe to add the IRQF_SHARED flag.

Keep in mind that the device by default is using push-pull for the irq pin,
which might require additional hardware design to allow interrupt sharing.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 120 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 93 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index dc8031e14c29..f05dd936b7f3 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -119,6 +119,7 @@
  * @sleep_val:			time in ms to sleep while waiting for drdy
  * @ctrl_reg1:			CTRL_REG1 register shadow value
  * @data_cfg:			DATA_CFG register shadow value
+ * @ctrl_reg4:			CTRL_REG4 register value to restore on resume
  * @open_drain:			true for irq pin in open-drain mode
  */
 struct mma8452_data {
@@ -137,6 +138,7 @@ struct mma8452_data {
 	int sleep_val;
 	u8 ctrl_reg1;
 	u8 data_cfg;
+	u8 ctrl_reg4;
 	bool open_drain;
 };
 
@@ -1086,15 +1088,32 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
 	struct mma8452_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
 	irqreturn_t ret = IRQ_NONE;
+	int pm_status;
 	int src;
 
+	pm_status = pm_runtime_get_if_active(dev);
+	if (pm_status == 0)
+		/* device is powered down */
+		return IRQ_NONE;
+	if (IS_ENABLED(CONFIG_PM) && pm_status < 0)
+		/* runtime PM was disabled, possibly suspending */
+		return IRQ_HANDLED;
+
+	/*
+	 * pm_status is now 1 or -EINVAL (with CONFIG_PM not enabled). If
+	 * pm_status==1, runtime PM is enabled and device is RPM_ACTIVE. If
+	 * pm_status==-EINVAL, runtime PM is build-time disabled (i.e. CONFIG_PM
+	 * not enabled), and we can/must assume device is active.
+	 */
+
 	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
 	if (src < 0)
-		return IRQ_NONE;
+		goto out_runtime_put;
 
 	if (!(src & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
-		return IRQ_NONE;
+		goto out_runtime_put;
 
 	if (src & MMA8452_INT_DRDY) {
 		iio_trigger_poll_nested(indio_dev->trig);
@@ -1120,6 +1139,10 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 		ret = IRQ_HANDLED;
 	}
 
+out_runtime_put:
+	if (pm_status > 0)
+		pm_runtime_put_autosuspend(dev);
+
 	return ret;
 }
 
@@ -1707,6 +1730,14 @@ static int mma8452_probe(struct i2c_client *client)
 	if (ret < 0)
 		goto trigger_cleanup;
 
+	ret = pm_runtime_set_active(dev);
+	if (ret < 0)
+		goto buffer_cleanup;
+
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, MMA8452_AUTO_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
 	if (client->irq) {
 		unsigned long irq_flags;
 
@@ -1715,24 +1746,16 @@ static int mma8452_probe(struct i2c_client *client)
 			dev_info(dev, "invalid irq type, setting default active low\n");
 			irq_flags = IRQF_TRIGGER_LOW;
 		}
-		irq_flags |= IRQF_ONESHOT;
+		irq_flags |= IRQF_ONESHOT | IRQF_SHARED;
 		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
 					   irq_flags, client->name, indio_dev);
 		if (ret)
-			goto buffer_cleanup;
+			goto runtime_suspend;
 	}
 
-	ret = pm_runtime_set_active(dev);
-	if (ret < 0)
-		goto free_irq;
-
-	pm_runtime_enable(dev);
-	pm_runtime_set_autosuspend_delay(dev, MMA8452_AUTO_SUSPEND_DELAY_MS);
-	pm_runtime_use_autosuspend(dev);
-
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto runtime_suspend;
+		goto free_irq;
 
 	ret = mma8452_set_freefall_mode(data, false);
 	if (ret < 0)
@@ -1743,14 +1766,14 @@ static int mma8452_probe(struct i2c_client *client)
 unregister_device:
 	iio_device_unregister(indio_dev);
 
-runtime_suspend:
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
-
 free_irq:
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
 
+runtime_suspend:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+
 buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 
@@ -1771,11 +1794,12 @@ static void mma8452_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
-
 	if (client->irq)
 		free_irq(client->irq, indio_dev);
+	/* No irq will fire beyond this point */
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
 
 	iio_triggered_buffer_cleanup(indio_dev);
 	mma8452_trigger_cleanup(indio_dev);
@@ -1787,29 +1811,67 @@ static void mma8452_remove(struct i2c_client *client)
 #ifdef CONFIG_PM
 static int mma8452_runtime_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int ret;
 
-	scoped_guard(mutex, &data->lock)
-		ret = mma8452_standby(data);
+	mutex_lock(&data->lock);
+
+	ret = mma8452_standby(data);
+	if (ret < 0) {
+		dev_err(dev, "transition to STANDBY mode failed\n");
+		ret = -EAGAIN;
+		goto out_unlock;
+	}
+
+	ret = i2c_smbus_read_byte_data(client, MMA8452_CTRL_REG4);
 	if (ret < 0) {
-		dev_err(dev, "powering off device failed\n");
-		return -EAGAIN;
+		dev_warn(dev, "backing up CTRL_REG4 failed\n");
+		ret = -EAGAIN;
+		goto out_active;
+	} else
+		data->ctrl_reg4 = ret;
+
+	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG4, 0);
+	if (ret) {
+		dev_warn(dev, "disabling interrupt sources (CTRL_REG4) failed\n");
+		ret = -EAGAIN;
+		goto out_active;
 	}
 
+	/*
+	 * Interrupt line should be deasserted now, so we just need ensure any
+	 * mid-flight irq is completed (will return IRQ_NONE due to
+	 * pm_status==0).
+	 */
+	if (client->irq)
+		synchronize_irq(client->irq);
+
 	ret = regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
 	if (ret) {
 		dev_err(dev, "failed to disable regulators\n");
-		return ret;
+		goto out_restore_ctrl_reg4;
 	}
 
+	mutex_unlock(&data->lock);
 	return 0;
+
+out_restore_ctrl_reg4:
+	if (i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG4, data->ctrl_reg4))
+		dev_warn(dev, "restoring CTRL_REG4 failed\n");
+out_active:
+	if (mma8452_active(data))
+		dev_warn(dev, "failed to switch back to ACTIVE mode\n");
+out_unlock:
+	mutex_unlock(&data->lock);
+	return ret;
 }
 
 static int mma8452_runtime_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int ret, sleep_val;
 
@@ -1823,6 +1885,10 @@ static int mma8452_runtime_resume(struct device *dev)
 	if (ret)
 		goto runtime_resume_failed;
 
+	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG4, data->ctrl_reg4);
+	if (ret)
+		goto runtime_resume_failed;
+
 	ret = mma8452_active(data);
 	if (ret < 0)
 		goto runtime_resume_failed;

-- 
2.55.0

