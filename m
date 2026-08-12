Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B1D436BFE
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545077; cv=none; b=k6m/c7xLDBgqniy8nuAEmLmV6MaZXoWs+ICl6Gr5HiVoEJgOVkBP3pGwVRd3Ps7+2J2NstwqGs7dwNb9ZtXnlxIWiaePefp17ADdpTAByeWAmmOhePabzqlgpX3b8bC2D5sGGzYjQ/WKg4XDMjRyQ4gYPlKd7PCG1X6fljkUVDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545077; c=relaxed/simple;
	bh=XAB19KdSyMK9mt+Rw2Vp72Vjf2WnClhTTZqjRvwz4C0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bDiFsG3k+wovxjNvjBwBNnkctDRuOsVzazHlt9IZnzuGldmoIgF6u+3IkjIaTuXMXXjnWmO9vV98ovKJqZCz8RBvUN3bAemZqrcgUOBbuaWlfYcTM1+/sF4cg67rsQibxrd0sQCV939z7y+/3JNCqCHLX8jB0tVYwwvKC9hdl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=SqS84QYj; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="SqS84QYj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786545058; x=1786804258;
	bh=QtCx8kB4Mb3iMCCv5WhZU671IVumwe5Ul6ivPOF137Q=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SqS84QYj7RfOGuQYWhwPmumdRbqQ4bjc7QWNHiR0dLjrgPH7woK1J1WTwb7K7lPAh
	 75RivjZvIkXgDtl4NWjMANc5LUcKt/04PKPqt8bFBB+E4tsLDRcY9L7wknR2EBMwIF
	 oGjh0TWZu2yq90RoYiKvLNY17z75goSmhQTTJgXpFW7LB9Yt/zlliQkyQtpyrIUFKA
	 bzgbgAlM/BmOMacnu1WXUjoE2wjgYSeGAkWlxwvOOttwk+Oe/Lr6QnBHRjLeA9PqAp
	 LgF9ANtr+LguagehgraGEdmTeXMMQX6PC8yULsmGYobuELm4wgc/gjethtZDuZjkhH
	 /vMl577AiNS3w==
X-Pm-Submission-Id: 4hKrWh3vcvz2Sd3M
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 12 Aug 2026 16:30:36 +0200
Subject: [PATCH v4 5/6] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-mma8452-open-drain-v4-5-bfca15d02b59@geanix.com>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786545039; l=2387;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=XAB19KdSyMK9mt+Rw2Vp72Vjf2WnClhTTZqjRvwz4C0=;
 b=eK4jpnBI5+okCdCApB12SWhUorIDm+PahZpu/J8VdFBlBNxEa8qSslkWS3wvKKVy7Hdn2NIVB
 vcRgmt/JhjmDV9lGYJJ5iqMDgi62WM6F69KRZnuhGXOIN+jIsEkKvMs
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
index 106cdd904dbf..7992f9e38818 100644
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
@@ -119,6 +121,7 @@ struct mma8452_data {
 	int sleep_val;
 	u8 ctrl_reg1;
 	u8 data_cfg;
+	bool open_drain;
 };
 
  /**
@@ -647,6 +650,22 @@ static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
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
@@ -1676,6 +1695,11 @@ static int mma8452_probe(struct i2c_client *client)
 			goto disable_regulators;
 	}
 
+	data->open_drain = device_property_read_bool(dev, "drive-open-drain");
+	ret = mma8452_set_interrupt_pin_mode(data);
+	if (ret)
+		goto trigger_cleanup;
+
 	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
 			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
 
@@ -1817,6 +1841,10 @@ static int mma8452_runtime_resume(struct device *dev)
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

