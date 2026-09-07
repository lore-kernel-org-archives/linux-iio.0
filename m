Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430EC4FDE76
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792714; cv=none; b=iCXHWwD6x2dzzJcl5NNcFTJ8C3wpDkv1l/b1+KE3BoDTBgj1dOnvjH1qnEzVuY7z29pdrbvXV3qvjHzlykv7avH9j3ssLDqVaeMTx6W1GiL2lMSiQsZRtjkYIGJ/xaf+BQRXLJj5TmPNOJv+vj9LImwF1rF1z5yVgQFhgmq3S8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792714; c=relaxed/simple;
	bh=QS9aYfbmfIv6QXPJQGDYfxAk4etGaeLWslH0rEhE8Pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P59jAFG6HArfyEPGdPcl6IO/Zsp4JJp0CvbHnEexpAyRc4iO3ULIO1dJjk2bkSPdLWAF1haN66NABER6LqNdDhrIREXBoPPMdTyK2GxUYSV/1cizp0Osvn0H3tu7Fujaz7rcMOIdKRNn64TeplrWmVxBkAf4dTzlrmWMbKospyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=MNQUfaEs; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="MNQUfaEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788792693; x=1789051893;
	bh=4liMP45ZTYTUyBGTr1IveZVJzSjGQLRIEvbf+8sOCdo=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=MNQUfaEsBGQD716gLTug8FpXzU8fop1oCeTHjCOugKJbbQHBw5Ge+AvNp+PeEYsMY
	 CTniuCVUPgb+kHI76DvH/Wsf4f0KIQZaQUMzMz0RGrgoI13FXLV6kGx1T+6kp18G+f
	 Fql4uC9lIW1PKXe8jxFg6huagSGb8xlJNarhZa4n5Yqm4bqZ4eKg0U4E3XrOm1Slga
	 7Da6fs9EGHDaBVg2jmyNDRAxDszFdWdtRdGn4vAnVwBmrJ4A+mjkQ/eC+oywdDK7NS
	 OK8D7w/8YUg2bBzaJAD5TRO1MsTmV21SHx2UTeYEkW3kqPT5HL5uKR21JMTicP+gMY
	 dVwvGux7hM/2g==
X-Pm-Submission-Id: 4hdqlR3B9Tz2Sdlq
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 07 Sep 2026 16:51:04 +0200
Subject: [PATCH v8 9/9] iio: accel: mma8452: Support interrupt sharing
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-mma8452-open-drain-v8-9-c17407e22118@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
In-Reply-To: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788792664; l=5437;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=QS9aYfbmfIv6QXPJQGDYfxAk4etGaeLWslH0rEhE8Pk=;
 b=uQ0czhzM4AeHc+l3mB3bOkbv4koIjr56DXos2VurVm7izggA0d13w66I/899DfWDupmTAJ19B
 1/1ra6dQbQoD0RidNoCux2tFd7e9tVmC205Ren8595E2rsXthZ3Agxm
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

With that in place, it is safe to add the IRQF_SHARED flag.

Keep in mind that the device by default is using push-pull for the irq pin,
which might require additional hardware design to allow interrupt sharing.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 67 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index fda29df5d109..e521dca37f76 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -120,6 +120,7 @@
  * @sleep_val:			time in ms to sleep while waiting for drdy
  * @ctrl_reg1:			CTRL_REG1 register shadow value
  * @data_cfg:			DATA_CFG register shadow value
+ * @ctrl_reg4:			CTRL_REG4 register value to restore on resume
  * @open_drain:			true for irq pin in open-drain mode
  */
 struct mma8452_data {
@@ -138,6 +139,7 @@ struct mma8452_data {
 	int sleep_val;
 	u8 ctrl_reg1;
 	u8 data_cfg;
+	u8 ctrl_reg4;
 	bool open_drain;
 };
 
@@ -1083,15 +1085,21 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
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
 	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
 	if (src < 0)
-		return IRQ_NONE;
+		goto out_runtime_put;
 
 	if (!(src & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
-		return IRQ_NONE;
+		goto out_runtime_put;
 
 	if (src & MMA8452_INT_DRDY) {
 		iio_trigger_poll_nested(indio_dev->trig);
@@ -1117,6 +1125,10 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 		ret = IRQ_HANDLED;
 	}
 
+out_runtime_put:
+	if (pm_status > 0)
+		pm_runtime_put_autosuspend(dev);
+
 	return ret;
 }
 
@@ -1712,7 +1724,7 @@ static int mma8452_probe(struct i2c_client *client)
 			dev_info(dev, "invalid irq type, setting default active low\n");
 			irq_flags = IRQF_TRIGGER_LOW;
 		}
-		irq_flags |= IRQF_ONESHOT;
+		irq_flags |= IRQF_ONESHOT | IRQF_SHARED;
 		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
 					   irq_flags, client->name, indio_dev);
 		if (ret)
@@ -1784,29 +1796,62 @@ static void mma8452_remove(struct i2c_client *client)
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
+	guard(mutex)(&data->lock);
+
+	ret = i2c_smbus_read_byte_data(client, MMA8452_CTRL_REG4);
 	if (ret < 0) {
-		dev_err(dev, "powering off device failed\n");
+		dev_warn(dev, "backing up CTRL_REG4 failed\n");
 		return -EAGAIN;
+	} else
+		data->ctrl_reg4 = ret;
+
+	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG4, 0);
+	if (ret) {
+		dev_warn(dev, "disabling interrupt sources (CTRL_REG4) failed\n");
+		return -EAGAIN;
+	}
+
+	ret = mma8452_standby(data);
+	if (ret < 0) {
+		dev_err(dev, "transition to STANDBY mode failed\n");
+		ret = -EAGAIN;
+		goto out_restore_ctrl_reg4;
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
+		goto out_active;
 	}
 
 	return 0;
+
+out_active:
+	if (mma8452_active(data))
+		dev_warn(dev, "failed to switch back to ACTIVE mode\n");
+out_restore_ctrl_reg4:
+	if (i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG4, data->ctrl_reg4))
+		dev_warn(dev, "restoring CTRL_REG4 failed\n");
+	return ret;
 }
 
 static int mma8452_runtime_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int ret, sleep_val;
 
@@ -1820,6 +1865,10 @@ static int mma8452_runtime_resume(struct device *dev)
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

