Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6963DDDB8;
	Tue, 25 Aug 2026 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646500; cv=none; b=d+BUP9feU5DWkl5fwQAAV0/MHOboHe6tMcjaDAht0524rZ6Sfc6M3dNFK4MvPtlxamis3KS9LW4G2PMRIm+2qxGMVGzDOXvNm4zVTeeum+5qALZTGOxCe7tfxCy7ZLWTIOZvP1yo8z5R2sN/BXFpO+P/VsrS0V6hPqVjFyvgsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646500; c=relaxed/simple;
	bh=yRgVg8kdyjJHkMUb35ShRoAw17aDHC3xvQwJhwTA9xY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E4ypCjuwMlGySw1mDvf2PMNuANyb9UmrTElh+EubftzyZIo8dOaDR8fqribp/XYdmKZfgMgSHzzgnKM0pWMjwZ79V5LQOuPZ6IVaUNOCrlwV5qp10eU4EckLKv4UasJTpZlx9lmCxpkvqlaT02WehSOFQ4iSgK3LHIn5nU0t06Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Z7IVdOCL; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Z7IVdOCL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787646485; x=1787905685;
	bh=YjaPdxyYrTLXVHyfD40d9EwncEOPh7AQsvCv5CpeVQM=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Z7IVdOCLDWNqYcWygDiJteDIjj3YQ0hds+CpxTmvW1YOCBFkvp4PfaH6czAM/91wj
	 wtvS1oYrd9a+V3ORhWCzGrtDKY6CrSvyD2W/TzdA6mMEOOuEZAlGHDSO3IprtZmssP
	 nix/tMmpRI4gsSPD6dao2JnSH4sCs0WlbMieH3dzHSPOQzD/TEbGTNliqiGdarFPGU
	 S3TuU60Z9S7A2POBj3cgwUP6s+c/8Sa4/0XcI/8vyAEsbsnyRWeLA/Mal6F9lDWk20
	 iaf7CIlnSAytclTGh0g20VjF76woswNYf8VCUnI/YIxfFkZKgNNc36TdTePhJQOUIg
	 MIf/f8E0xAfdA==
X-Pm-Submission-Id: 4hTgrz6JRpz1DFFp
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 25 Aug 2026 10:27:42 +0200
Subject: [PATCH v6 4/9] iio: accel: mma8452: Support interrupt sharing
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-mma8452-open-drain-v6-4-9b252804ee80@geanix.com>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787646470; l=3229;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=yRgVg8kdyjJHkMUb35ShRoAw17aDHC3xvQwJhwTA9xY=;
 b=zczf2KIuo+LycLwc2vhNcznJzVqCJ+7p/hiJRzmhQYZjCB9hzON3tOF/WX6L58eKNFMpIp3RO
 aCmm811hUnMBApRq0an5vptQHKVCKJvSgWAcVTScHUepfzFuHNImZMH
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
 drivers/iio/accel/mma8452.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 1fb43c5b0b72..8eb97e6793d6 100644
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
@@ -1774,6 +1789,10 @@ static int mma8452_runtime_suspend(struct device *dev)
 		return -EAGAIN;
 	}
 
+	WRITE_ONCE(data->suspended, true);
+
+	synchronize_irq(client->irq);
+
 	ret = regulator_disable(data->vddio_reg);
 	if (ret) {
 		dev_err(dev, "failed to disable VDDIO regulator\n");
@@ -1808,6 +1827,8 @@ static int mma8452_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	WRITE_ONCE(data->suspended, false);
+
 	ret = mma8452_active(data);
 	if (ret < 0)
 		goto runtime_resume_failed;
@@ -1822,6 +1843,7 @@ static int mma8452_runtime_resume(struct device *dev)
 	return 0;
 
 runtime_resume_failed:
+	WRITE_ONCE(data->suspended, true);
 	regulator_disable(data->vddio_reg);
 	regulator_disable(data->vdd_reg);
 

-- 
2.55.0

