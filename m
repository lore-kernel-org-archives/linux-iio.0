Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC44944838C;
	Wed, 15 Jul 2026 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118822; cv=none; b=Ce09ghxF99VIptAwbJIotbXxmSzJtBZUjvKoTCwS90y5cweEDsRz7bupI7p+ZgXgAsEzYI9xzBDsNWhr9g8mArEapZEnvBwPA4BotU9mIl+jSLALoZzb3ymjSk8jbGk/aKNt/2ojho3NY1QRrcA+GXRMx82py0VwOAwAUp/lIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118822; c=relaxed/simple;
	bh=GZ42WlxbeFLF6qhAN4EpKIe/o1kfGGnpV7jIs5tFkUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eTccsV0yRdA+fF3HVkKBdVWgwpBi0xOkRKgzs37hHJ6KL3I36DTZClQ0KFOyAXX45nd3DZg6d3oPSJYHzpql4sAo0PZlU/9kANcrI1tGCgaOTjw55t0fyYA76RCP++X9bUhd+CLorQE9MNvtdFa8KuN76JfAT6D2lXBk8zbFnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=qnyb5Yau; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="qnyb5Yau"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1784118818; x=1784378018;
	bh=33+JaZ463/Oh+5RIaI+36lc8QmZ6kMYdVAWpGMBBhcU=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qnyb5Yau1O2mUP0J8sNSakxxJviXMPimXeoc9yqEzAhbQuwSnjph4RShGwO9VS6iY
	 8NCFTMcRQhWCQv5eq5Anncp7+OUUVjL+WvsVDwtsXfkRWAFTfmLcGsEwO7Byb7VoJs
	 Or6rgIEXc9zTY7uuxCaTsEuwK93RA5Uft8iTiV05mHiUBLCX7vTfUo97A6AWgrm2Wt
	 d4nDksoVK9c11SyleuSK8RulCuSIrVjuVbOWm35o2YukLtWYqWUwAL6M/pfFPjceu1
	 WfzQayD8pHhgtja6FFudv3l8SIAOVAR6ETwP2WhEY3ySvjVdb0+QXnkcHxWzkxZIvy
	 BikI6sRiyBZzQ==
X-Pm-Submission-Id: 4h0bFF1v9Mz1DFT1
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 15 Jul 2026 14:33:28 +0200
Subject: [PATCH v2 2/3] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-mma8452-open-drain-v2-2-95be9f5f4795@geanix.com>
References: <20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com>
In-Reply-To: <20260715-mma8452-open-drain-v2-0-95be9f5f4795@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784118811; l=3108;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=GZ42WlxbeFLF6qhAN4EpKIe/o1kfGGnpV7jIs5tFkUM=;
 b=msvthMShB5iobNkPhFBAPfAEpByYzR4K/2bbvqyLNfifiVVzNoi5XXwsVYRj/ceapwfI6cTcP
 QBMxMt3XhvRD4/60wV2WpRobKxxji8Mhc/lc/pxQGVJqVTsTIm2RWF3
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

When sharing interrupt line with other chips, the interrupt pin most
likely needs to be configured in open-drain mode instead of push-pull.

The PP_OD bit in CTRL_REG3 is set when open-drain mode is configured,
allowing sharing the interrupt line with other devices (with same interrupt
polarity).
The IRQF_SHARED flag is added to request_threaded_irq() flags, indicating
that the interrupt line can be shared with other devices.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7d683686dd9d..fdf7364d7fed 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -81,6 +81,8 @@
 #define  MMA8452_CTRL_REG2_RST			BIT(6)
 #define  MMA8452_CTRL_REG2_MODS_SHIFT		3
 #define  MMA8452_CTRL_REG2_MODS_MASK		0x1b
+#define MMA8452_CTRL_REG3			0x2c
+#define  MMA8452_CTRL_REG3_PP_OD		BIT(0)
 #define MMA8452_CTRL_REG4			0x2d
 #define MMA8452_CTRL_REG5			0x2e
 #define MMA8452_OFF_X				0x2f
@@ -108,6 +110,7 @@ struct mma8452_data {
 	struct iio_mount_matrix orientation;
 	u8 ctrl_reg1;
 	u8 data_cfg;
+	bool open_drain;
 	const struct mma_chip_info *chip_info;
 	int sleep_val;
 	struct regulator *vdd_reg;
@@ -646,6 +649,22 @@ static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
 	return mma8452_change_config(data, MMA8452_CTRL_REG2, reg);
 }
 
+static int mma8452_set_interrupt_pin_mode(struct mma8452_data *data)
+{
+	int reg;
+
+	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG3);
+	if (reg < 0)
+		return reg;
+
+	if (data->open_drain)
+		reg |= MMA8452_CTRL_REG3_PP_OD;
+	else
+		reg &= ~MMA8452_CTRL_REG3_PP_OD;
+
+	return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG3, reg);
+}
+
 /* returns >0 if in freefall mode, 0 if not or <0 if an error occurred */
 static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
 {
@@ -1666,6 +1685,11 @@ static int mma8452_probe(struct i2c_client *client)
 			goto disable_regulators;
 	}
 
+	data->open_drain = device_property_read_bool(&client->dev, "drive-open-drain");
+	ret = mma8452_set_interrupt_pin_mode(data);
+	if (ret)
+		goto trigger_cleanup;
+
 	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
 			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
 
@@ -1683,7 +1707,8 @@ static int mma8452_probe(struct i2c_client *client)
 
 	if (client->irq) {
 		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
-					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
+					   (data->open_drain ? IRQF_SHARED : 0),
 					   client->name, indio_dev);
 		if (ret)
 			goto buffer_cleanup;
@@ -1800,6 +1825,10 @@ static int mma8452_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = mma8452_set_interrupt_pin_mode(data);
+	if (ret)
+		goto runtime_resume_failed;
+
 	ret = mma8452_active(data);
 	if (ret < 0)
 		goto runtime_resume_failed;

-- 
2.55.0

