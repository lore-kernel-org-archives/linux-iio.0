Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D4D421233;
	Wed, 19 Aug 2026 08:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127381; cv=none; b=uz15utHRMdRc2RDPJdahQnIs5ja/G4NZHO8zBJnkDwGfshypRBXhJ0Wy5721klFeCmmGmqHBtcMsY1DNJStwiy0FbJTA5/JFdb88j8OUdcmSr+Ru3t3Ma7v69n5HE3se0ZNVVgOcwOI7+7ob4U/86EJ4GcfwvL0tlUg5Kg6wIv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127381; c=relaxed/simple;
	bh=7FBiSGrViYBfg253JXpmcZWNyNFqcljW5o8HQkqXk00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mosmYDRCWASG7DlXfPkOeHrZvU4lJevXS9DrPqdNucrbqnG2aMjtvsNdl5GwcWEAZ95o8+sNkAEWFHGegDGNzy2VE/+1WRod6MjXoykTVcFPoFiWEgFR41+YZjuOwB3wlgnL6NrSNfIPklLZ+jRTaXGs6B8OQm+D58oHkNmrteY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=fH0ZW6/Z; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="fH0ZW6/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787127355; x=1787386555;
	bh=ppP+6k9G9smIUBkAdhOcgQ4QxUe2Cw2pt3Di47DoRaY=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fH0ZW6/ZQdV4u5VXqgT7nrYmZA8bZaVYumRS6LlhiaueYuLFSBDmzly4FP/80x+6s
	 FAhF72hiDB/pWQePshbqusqxgPTttGwH92XyHuVf+f3uODBb9CRC1lMmdeNwyxhCA/
	 KmOVLMeNr+CemtsRK09SqYekkDBN3KYxeesNdcPT5W2rJxwV20j6fG48D5EtttwTn0
	 LxAnGxRS634i4ZqF2AgwkAyDbHATAyJuAA3C9JwGNl0qzJpZghRGV01iQD82sL1wGu
	 iG8SFoxlSEJmunRqO2Gi07h9d/xlC1/T+uokwocvPSYY8kN7DE/ZE/jl+Miw3H+WPZ
	 /jBxSZwEblkyg==
X-Pm-Submission-Id: 4hPzsj5xZnz2ScNq
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 19 Aug 2026 10:15:32 +0200
Subject: [PATCH RESEND v5 5/6] iio: accel: mma8452: Allow open drain
 interrupt pin configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-mma8452-open-drain-v5-5-d8aa590d7c36@geanix.com>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787127340; l=2409;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=7FBiSGrViYBfg253JXpmcZWNyNFqcljW5o8HQkqXk00=;
 b=6JeZgOohBWFcCXlasVNFo3zWzQXjqgxWuBDIOlc8zXfjtmkbq6+jj23lRza3GDT7F6zxVvYVC
 q8ZjS1+at2CApT+bMHxYWrTjTGoG2QuVnwJPoreqXPHiXDwTURLA3p2
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
index 25bb2dd69381..060a6207e52d 100644
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
@@ -120,6 +122,7 @@ struct mma8452_data {
 	u8 ctrl_reg1;
 	u8 data_cfg;
 	bool suspended;
+	bool open_drain;
 };
 
  /**
@@ -648,6 +651,22 @@ static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
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
@@ -1677,6 +1696,11 @@ static int mma8452_probe(struct i2c_client *client)
 			goto disable_regulators;
 	}
 
+	data->open_drain = device_property_read_bool(dev, "drive-open-drain");
+	ret = mma8452_set_interrupt_pin_mode(data);
+	if (ret)
+		goto trigger_cleanup;
+
 	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
 			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
 
@@ -1823,6 +1847,10 @@ static int mma8452_runtime_resume(struct device *dev)
 
 	WRITE_ONCE(data->suspended, false);
 
+	ret = mma8452_set_interrupt_pin_mode(data);
+	if (ret)
+		goto runtime_resume_failed;
+
 	ret = mma8452_active(data);
 	if (ret < 0)
 		goto runtime_resume_failed;

-- 
2.55.0

