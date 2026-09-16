Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1F466B08
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 08:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546204; cv=none; b=owyX5ViQ+N5FHy67YAoaXLYkasiaQubWHEyY2I1akJhuHLJ5iAYVCb5wa453NHjMdaXmrvCu/J3mjL6DIhAK6tl/x4O92yuPSV79126ENgF1/OB9B09J5GgDmGfA/nZPAVwUXtuREzWaDJJw1N/n2c0ujRuBrSkGz0tyPCuT8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546204; c=relaxed/simple;
	bh=ZcCdFWbXCbKw6AZzkVLcVloq2ZkXVfXAm4HV8iYLbLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VDKjrTL9cnPkni/lPiVOcTqcvL4dB1dU142Pu6HW5Ufjb+t7nMLgWNeAu+CPbuh/6zaGGUt6IRGD7l1ADm1ig4OePnC4TNQYxO4dlMHl+LyyTILis0YWYp+eTZRM08nNyM5OyyEvO9dEVb/yvGq8515Cy34HTCNJ9aSlcrCWFUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=T+AwX3hb; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="T+AwX3hb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789546180; x=1789805380;
	bh=7TJ+lgh8yPqjjUsPbUWBcJTEXOUZviYqc0R0KmfRtvk=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=T+AwX3hbkDx3cJDN5rb7UiBYSqmx2sFq5wVQWjIWxpvhmEInLWLI6+X/O93yfsb8U
	 fDLa2m2rHEXIzNJRL+UgPgM1Fu94ILBQZdGnPAZ9iPkxk7UoXhYO65Plda0jxp/pOP
	 JyUKt1Ub9arRNtlEwqjzbQeQoIk4HF0TeeP02JEsIW76CnxfF+YWqXMrnjT39rCO9n
	 ZQ3RsFXJsT5gLyDSGqj5bFwTaRrSQA49a6pPZQ4seqfrT2NgBkC7iNVNVbbeZUT+Qs
	 Chl5lLdn8aVxhY59+02oYYKy5PlBrmguZ+SheDchzsd/t5jFPFo6U89QuwyK8AcJDu
	 wmCJI4rHJMnJA==
X-Pm-Submission-Id: 4hlBPZ5FvVz1DFG0
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 16 Sep 2026 10:08:06 +0200
Subject: [PATCH v9 10/10] iio: accel: mma8452: Support interrupt sharing
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mma8452-open-drain-v9-10-0dd24fa2f3d7@geanix.com>
References: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
In-Reply-To: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789546157; l=6538;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=ZcCdFWbXCbKw6AZzkVLcVloq2ZkXVfXAm4HV8iYLbLc=;
 b=w+r9MLQODxMmddzYGUSuopJ1PU/C1DL+j0u332m6srH0PoFwPWz2IpIDeUoeq2se8zBPPWBPi
 3F4SeWBlAXAAbpTxhoJN5nP+eeLaRQhdM8yo2a15pITXrSoRYPhMf0H
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
 drivers/iio/accel/mma8452.c | 88 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 5aea6bf3312a..2a980c0c2e03 100644
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
 
@@ -1086,15 +1088,28 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
 	struct mma8452_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
 	irqreturn_t ret = IRQ_NONE;
+	int pm_status;
 	int src;
 
+	pm_status = pm_runtime_get_if_active(dev);
+	if (pm_status == 0)
+		return IRQ_NONE; /* device is powered down */
+
+	/*
+	 * pm_status is now 1 or -EINVAL. If pm_status==1, runtime PM is enabled
+	 * and device is RPM_ACTIVE. If pm_status==-EINVAL, runtime PM is
+	 * disabled (e.g. CONFIG_PM not enabled), and we can/must assume device
+	 * is active.
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
@@ -1120,6 +1135,10 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 		ret = IRQ_HANDLED;
 	}
 
+out_runtime_put:
+	if (pm_status > 0)
+		pm_runtime_put_autosuspend(dev);
+
 	return ret;
 }
 
@@ -1715,7 +1734,7 @@ static int mma8452_probe(struct i2c_client *client)
 			dev_info(dev, "invalid irq type, setting default active low\n");
 			irq_flags = IRQF_TRIGGER_LOW;
 		}
-		irq_flags |= IRQF_ONESHOT;
+		irq_flags |= IRQF_ONESHOT | IRQF_SHARED;
 		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
 					   irq_flags, client->name, indio_dev);
 		if (ret)
@@ -1771,11 +1790,12 @@ static void mma8452_remove(struct i2c_client *client)
 
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
@@ -1787,29 +1807,67 @@ static void mma8452_remove(struct i2c_client *client)
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
 	if (ret < 0) {
-		dev_err(dev, "powering off device failed\n");
-		return -EAGAIN;
+		dev_err(dev, "transition to STANDBY mode failed\n");
+		ret = -EAGAIN;
+		goto out_unlock;
 	}
 
+	ret = i2c_smbus_read_byte_data(client, MMA8452_CTRL_REG4);
+	if (ret < 0) {
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
+	}
+
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
 
@@ -1823,6 +1881,10 @@ static int mma8452_runtime_resume(struct device *dev)
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

