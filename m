Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942C2445ACD;
	Wed, 16 Sep 2026 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546210; cv=none; b=akMXJOakMgbDFMaMIg04BRu4kc1Iq7sBV+NTaHVjhx5fKlFowXxB+q34sq6AvhUDnJPKK30sjxu728QK43PJzZ5Qe6BAlCY39MjdDb0lq47Lh0Nt2AjfbLoJJj8eFjoXHzi7HEBbg+sVEtuRyQEDcPyUchME3y5uZsom/MGyE4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546210; c=relaxed/simple;
	bh=sQZ2tGpTauHPI+0PLoJCQ+hcRZAFe66nXYgu/3AYc4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYlCevkFB1OIUTlL4fxBwfOE2Z+OUhintZVSNgg2evWuFw31Oog+KS918wEmmKlMGnSL1cWWsIdARR+GNbMIN2k/dCKbC3zikUjiQVRv5uMXXMjGTti0qVnINVS6gBiKSuckGie/HQOWirP1VxNIoJSpboYURLrv29rL1NXoxmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=M5JiKLIw; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="M5JiKLIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789546176; x=1789805376;
	bh=j6FuajukEYwiuxHrwNHtWrAIldVALc6XiykYytHuv+Q=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=M5JiKLIwtOgDpYND8rP7FpgPq/OoRe2DFfoW2LhW4Xtes1G4K8SAQyNwmGogTfpLO
	 tzeqartJt6LEdSH+dQIPmbyhmny66MS4RexmylWxgZRwp/BroVOyD6s/TYkM1IePVL
	 aHVF1Ugobl+0RXv/68zTWDMHNWc2JHjg6REx+o/PNLCQJjtNe6iClR1fwjnFF/wM+4
	 dSsW/bwKgv+TpcVTtyiJts+63dV5t0xH37sJ2CplUiumOEK3xWaPo0pd8xyuCBLtO8
	 S7A2rbPfp/+6XJsFkhyX/PDixHbCRROgYsN+LKTgesa5Sd9KomM/3KTZbuHGAiDP/3
	 7rwPvMP+cdmFQ==
X-Pm-Submission-Id: 4hlBPV6nhXz1DDX8
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 16 Sep 2026 10:08:04 +0200
Subject: [PATCH v9 08/10] iio: accel: mma8452: Allow open drain interrupt
 pin configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mma8452-open-drain-v9-8-0dd24fa2f3d7@geanix.com>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789546157; l=2386;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=sQZ2tGpTauHPI+0PLoJCQ+hcRZAFe66nXYgu/3AYc4A=;
 b=jRbTUd9M2+qtV61Y3AnomOn1NGcys2d6lCyppW7SkuoGIfWnUlUZw8M8aoOLOK1l/6n2UCPwW
 3kUGsDHq5U7Caot0LeVN8+aRt3f7E3QQVRmKduNVKMMEHF4K3hsAFmk
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

When designing systems sharing the interrupt for mma8452 chips, it is
helpful to be able to configure the irq pin in open-drain mode (default is
push-pull).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 223bef4f7baf..5d44f0066b1e 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -83,6 +83,8 @@
 #define  MMA8452_CTRL_REG2_RST			BIT(6)
 #define  MMA8452_CTRL_REG2_MODS_SHIFT		3
 #define  MMA8452_CTRL_REG2_MODS_MASK		0x1b
+#define MMA8452_CTRL_REG3			0x2c
+#define  MMA8452_CTRL_REG3_PP_OD		BIT(0)
 #define MMA8452_CTRL_REG4			0x2d
 #define MMA8452_CTRL_REG5			0x2e
 #define MMA8452_OFF_X				0x2f
@@ -135,6 +137,7 @@ struct mma8452_data {
 	int sleep_val;
 	u8 ctrl_reg1;
 	u8 data_cfg;
+	bool open_drain;
 };
 
 /**
@@ -662,6 +665,22 @@ static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
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
@@ -1668,6 +1687,11 @@ static int mma8452_probe(struct i2c_client *client)
 			goto disable_regulators;
 	}
 
+	data->open_drain = device_property_read_bool(dev, "drive-open-drain");
+	ret = mma8452_set_interrupt_pin_mode(data);
+	if (ret)
+		goto trigger_cleanup;
+
 	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
 			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
 
@@ -1795,6 +1819,10 @@ static int mma8452_runtime_resume(struct device *dev)
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

