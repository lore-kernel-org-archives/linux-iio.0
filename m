Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB53E0C73
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646501; cv=none; b=HjlxF9Nk1mloOS49NuHQo+WWHQmtZ2tkEkNVAr7TN+Tyg4AzHlvKB5MwNVKGi8avukp0Oz1bDAvpi4bhJqTTS0yPlpbK5t7Jml0tD3e5k0IAaAU8tK06n/9XoPlwukWebhV1jiXmS9QFrgVCfAOv3ky7Co9cKZed1RFWWxpDsa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646501; c=relaxed/simple;
	bh=HlvxYOWq6eDsSdHI0AwbaTsDYFGxu6nJIE6bkTtBMd8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwN5HRwdE9MG3OF9KRrcULqLfVqP1dZz2O6RN8FKm4Qi+6mNXjB8XYrkJKe4CE/6gmAeh3xRwEAyZMB1QqU0qNsy15VBfqtB0TXjFUhlHtWSs9touHfnaPdZMHz+BRCyanyAncVRvB7nNjisTRZgTcKAtFhNQrUnSVvQq3Ulx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=UsJiW+vR; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="UsJiW+vR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787646487; x=1787905687;
	bh=VIfRiCdbUFiOfSKmsdZ1/h0GA0pxwFydra/kW9OYaWk=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=UsJiW+vRrzVVOfiYkQI+JjJmKzNDEh4aYMVX3UeV1lr9Swx1/T1iIWg+jZKUT5aw3
	 ahzqna/BjEJgJ8ONnSMZJH2njCf79MX4w4MoXF2g3vIHVbj5IbMKBgb3iIy6b+2SZ/
	 eVWjFtR51ouoZ6v5mBHvI9vkPnN5WFd0MBiopoGYAb/OnJUBWgUO1HCKKAvr091oIX
	 KaxL1JqONGG0VF6TuMfYYpcXACJ0Hkb3KANUgfx3fukrYjxB4HO590CrrjUsqMdC/E
	 eR5EDs6T5XrE4nODFN+q4NM05FfClsltNsZA6lDWwhpLxU56FtpJr9DSMM7dlLWqAK
	 ugRmgphvCdn8g==
X-Pm-Submission-Id: 4hTgs105kQz2SdHM
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 25 Aug 2026 10:27:43 +0200
Subject: [PATCH v6 5/9] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-mma8452-open-drain-v6-5-9b252804ee80@geanix.com>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787646470; l=2409;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=HlvxYOWq6eDsSdHI0AwbaTsDYFGxu6nJIE6bkTtBMd8=;
 b=Cn7ACai13Ag76fmaoG54YHHTA/ex1UwS8wQv/+iyc+UXbOXytGw0ESN4nbYHzLums6NGOtXhw
 p7JuL8rEPskBuJrmFvQz5uImOMMVXPpG903XrTi0yUiqomMHJ0mEvD5
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
index 8eb97e6793d6..d1e8eb2a4ad3 100644
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
@@ -1682,6 +1701,11 @@ static int mma8452_probe(struct i2c_client *client)
 			goto disable_regulators;
 	}
 
+	data->open_drain = device_property_read_bool(dev, "drive-open-drain");
+	ret = mma8452_set_interrupt_pin_mode(data);
+	if (ret)
+		goto trigger_cleanup;
+
 	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
 			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
 
@@ -1829,6 +1853,10 @@ static int mma8452_runtime_resume(struct device *dev)
 
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

