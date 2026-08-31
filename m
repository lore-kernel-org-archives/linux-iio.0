Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B5E3F7874;
	Mon, 31 Aug 2026 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178656; cv=none; b=Twwxq3xu4k7C2+WTC9c/e1cGC4H72NMGhL3tLVwOoOm02E3RwOAshNMMw8attgZFnS0Lyve47a7AUgXx4xXO0f/lZQd5aUl6fNAPmoKFuwtDt3ubzjmumEkdIRVdmlRpoBhGomKljXNCkli4H/Is1n+EsDFCFgvdkSSAp1dub1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178656; c=relaxed/simple;
	bh=ivalV7xq+83SDttgt0KkvrBI4czA06wqbS9+xpHL4fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=To7YGn9RVlx4T8tViAh4CDJDabjI8OUgBP6OTqSpC0YWelbVBaZDo6/bxYDdk482bKGD+SQuzXbacj6Jtfn9jh00OWPyNVt3c82HM1+58/HNt6iZG5teTAZ1IRiRtwYsIZeCBfpOIpPUt4eKdbD69C1OMWBviy52XP0vUGHt19s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=4h7SxkQe; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="4h7SxkQe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788178640; x=1788437840;
	bh=xsC7Az1eah/Es1xBr145VpfMxqMnIU2ojUqM4i1S/nw=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=4h7SxkQemJGdgQ/sofYHy4IanrQxB0oUdHp91Z/XTy3WFTN4xPhz9jJEGKWrL4C/u
	 6zayp3iE7XFPmUfHfIs8SE/vOkn7rTCI22QC8WgQbmaoS7tIi2+EtgypevIrjFmT8B
	 dqKqXXW5nQx+jgA5Ol4p70wzHPpIU4L2yuut6FVdKISuucBv0/Rpo+gIK09HXEfQiu
	 D/Wrq3xLjgbhyKIJZljtoc8t6gj3ddR3eJNGegH8DVwngnOieaPvHF4T48IgVU5HJs
	 QmtNioOU6ClnPrFwdv/Cf7xqrxRm5lw26q5mr510YOlg9h2jPbEGESP+kWzla+oPlE
	 Kjwq14Ma1CRTA==
X-Pm-Submission-Id: 4hYSfl2tX3z1DFFv
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 31 Aug 2026 14:17:07 +0200
Subject: [PATCH v7 4/8] iio: accel: mma8452: Support interrupt sharing
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-mma8452-open-drain-v7-4-22946812c928@geanix.com>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788178627; l=3637;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=ivalV7xq+83SDttgt0KkvrBI4czA06wqbS9+xpHL4fs=;
 b=SFfEKEnJ48ryblHmnrm/FIf68jf6KoCrk8LnvdUiHLsXnZ40ytuGwDQveX5IhL82ZOUVBBBrU
 KOnOucUkVYECatqzfcchMcxyLC72C4OSg1jDmLWgl+dcZ8jGeegTsHJ
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Adding handling of rutnime PM suspension in the interrupt handler allows
sharing interrupt with other devices.

Keep in mind that the device by default is using push-pull for the irq pin,
which might require additional hardware design to allow interrupt sharing.

The suspended flag is added together with synchronize_irq() in order to
protect against race conditions when doing runtime suspend and device
removal. This way we ensure that interrupt handler does not try to access
the device while regulators are disabled.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 1fb43c5b0b72..936eeb2efb2d 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -119,6 +119,7 @@ struct mma8452_data {
 	int sleep_val;
 	u8 ctrl_reg1;
 	u8 data_cfg;
+	bool suspended;
 };
 
  /**
@@ -1056,14 +1057,24 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 	struct iio_dev *indio_dev = p;
 	struct mma8452_data *data = iio_priv(indio_dev);
 	irqreturn_t ret = IRQ_NONE;
+	int pm_status;
 	int src;
 
+	pm_status = pm_runtime_get_if_active(&data->client->dev);
+	if (pm_status == 0)
+		return IRQ_NONE; /* device is powered down */
+	if (READ_ONCE(data->suspended)) {
+		/* device is being removed */
+		ret = IRQ_NONE;
+		goto out_runtime_put;
+	}
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
@@ -1089,6 +1100,10 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 		ret = IRQ_HANDLED;
 	}
 
+out_runtime_put:
+	if (pm_status > 0)
+		pm_runtime_put_autosuspend(&data->client->dev);
+
 	return ret;
 }
 
@@ -1690,7 +1705,7 @@ static int mma8452_probe(struct i2c_client *client)
 			dev_info(dev, "invalid irq type, setting default active low\n");
 			irq_flags = IRQF_TRIGGER_LOW;
 		}
-		irq_flags |= IRQF_ONESHOT;
+		irq_flags |= IRQF_ONESHOT | IRQF_SHARED;
 		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
 					   irq_flags, client->name, indio_dev);
 		if (ret)
@@ -1762,7 +1777,8 @@ static void mma8452_remove(struct i2c_client *client)
 #ifdef CONFIG_PM
 static int mma8452_runtime_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct i2c_client *client = to_i2c_client(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct mma8452_data *data = iio_priv(indio_dev);
 	int ret;
 
@@ -1774,6 +1790,10 @@ static int mma8452_runtime_suspend(struct device *dev)
 		return -EAGAIN;
 	}
 
+	WRITE_ONCE(data->suspended, true);
+
+	synchronize_irq(client->irq);
+
 	ret = regulator_disable(data->vddio_reg);
 	if (ret) {
 		dev_err(dev, "failed to disable VDDIO regulator\n");
@@ -1808,6 +1828,8 @@ static int mma8452_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	WRITE_ONCE(data->suspended, false);
+
 	ret = mma8452_active(data);
 	if (ret < 0)
 		goto runtime_resume_failed;
@@ -1822,6 +1844,7 @@ static int mma8452_runtime_resume(struct device *dev)
 	return 0;
 
 runtime_resume_failed:
+	WRITE_ONCE(data->suspended, true);
 	regulator_disable(data->vddio_reg);
 	regulator_disable(data->vdd_reg);
 

-- 
2.55.0

