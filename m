Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786393E44E4;
	Wed,  5 Aug 2026 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914528; cv=none; b=USkLhLKf+oo6yDX5fQXS59rLNchQIdyalHJzLuJbOlUDc4zb1loYeI1satJ6xLlySYsrF/kqjZUAwbAz6uz4Fq2TnfzacvbsBcGqXnnHnzqQIDaV46tP8hbCtpapkV+G/v/IsUc70fQDP52xUXQ1oR+rZbcREAB7Ldxx0xCRfzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914528; c=relaxed/simple;
	bh=jUwFaC+0P2yB94Vdg7SyUxp9h/AQ9CKGW28W1R05GZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hjJMVRfGhpAqTfCPP6oVIh7unMBhsbnm5EOfoNJrwnbT6dzMycxCRH3YefidHju2uFx7NdbIY5ntWIbPuf81mXYnxN+hQ8UHOSn4mfh8WFzmtbeMhyOU2b53EC8B3Zu0yvJ9+nKBOsYeFS3vEDsZgg6b619jvJKCA5TbPp/myks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Wnnepv6b; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Wnnepv6b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785914516; x=1786173716;
	bh=KjP9SL4ym3Rv1Klf7P/5VjrGwTQDu+KtLGfPry0z3EU=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Wnnepv6bS9A6q624Vx2d2LqjE5vILNcX6BQ9SvzmMAgfYaWwrvBLjyNUBwhr0rso5
	 lTeuPqiG1zPeelXOGMZ5hnk0mTd1cMQUecZ7JT1jrlysBwNhfNZhpu28pPTHFdtwGj
	 sKnXKrJ5A+cnJSMtPsX+mpm3JS82e8A8E+JP4IiE5LYi+ux9Bx2h5Ur3xVVyvhWEFy
	 8e5nYS9+XkmDTAjxbdqEmIjd8u9ypuZBryAWeHd9/xW+v00pt84Nz1Lqpr7PgrD3BI
	 OT+EFmfc5F9v2bvpSuVBJdVWxl5YX9uRv+VXe4Q+xVOtKVcH+6OXHrhQ5YSGS7pO4c
	 nqMFNpq3hAy8A==
X-Pm-Submission-Id: 4hFMKv4Crvz2Sccj
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 05 Aug 2026 09:21:38 +0200
Subject: [PATCH v3 4/4] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-mma8452-open-drain-v3-4-6149f406a409@geanix.com>
References: <20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com>
In-Reply-To: <20260805-mma8452-open-drain-v3-0-6149f406a409@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785914502; l=3033;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=jUwFaC+0P2yB94Vdg7SyUxp9h/AQ9CKGW28W1R05GZo=;
 b=4avtW0JoCpFdvBheNNutwqprLktQ6LO6TOdE481O/0ljrBzNzH/8KRNs6BlGsc4Blp/wp/5Om
 hHG/mdBdwGKAS9opmliAD+F+duTbJTn5OgXIjWXx1f5xTcWyGktxDFA
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
 drivers/iio/accel/mma8452.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 723ca3d9cb96..fa0915530f95 100644
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
@@ -1667,6 +1686,11 @@ static int mma8452_probe(struct i2c_client *client)
 			goto disable_regulators;
 	}
 
+	data->open_drain = device_property_read_bool(&client->dev, "drive-open-drain");
+	ret = mma8452_set_interrupt_pin_mode(data);
+	if (ret)
+		goto trigger_cleanup;
+
 	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
 			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
 
@@ -1688,7 +1712,7 @@ static int mma8452_probe(struct i2c_client *client)
 		irq_flags = irq_get_trigger_type(client->irq);
 		if (irq_flags == IRQ_TYPE_NONE)
 			irq_flags = IRQF_TRIGGER_LOW;
-		irq_flags |= IRQF_ONESHOT;
+		irq_flags |= IRQF_ONESHOT | IRQF_SHARED;
 		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
 					   irq_flags, client->name, indio_dev);
 		if (ret)
@@ -1806,6 +1830,10 @@ static int mma8452_runtime_resume(struct device *dev)
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

