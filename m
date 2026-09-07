Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5703BB113;
	Mon,  7 Sep 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792703; cv=none; b=dxC2zMyuE45I2vbifHYCsS8O9hKkWGAFVUi1z81DOhE1WSGftN7QkbYQ4X/B/ALDhoOJo5A/1IbS5B2L0uXbrF26LO0VFLBfvnLu+ZFa7nbkrhulC1Trmz+FAkxkc/p/3aGabFAh4YTPsRa+hPQD4BJtd0VLROr8V9r6FWxkRXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792703; c=relaxed/simple;
	bh=VU3Y10yCGpg+zmCnQaJJEMBjTuK+919XG+6NtyAbZeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BlZBZZ7oypx7TlNks8eSXuPHyCpsmVX5eFzV2Ii14DXi9GYjJEF+5HUAG13R/KZkjDPsiI8vHiVLYvCL69ZLERVrChsEEPFq+MaAE4N4qjrbd7OXgX0vZEsytF71vQXWxljSM4eKIr8Y3ElloA93QAAKr/5gEeHa//R1Ypa2wCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=SQbL6SqH; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="SQbL6SqH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788792687; x=1789051887;
	bh=maq+KPOCXrwfeg6YIPsRpiDqdaJtrTEPMyZmADR5n9c=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SQbL6SqHnsEGXYUxPSv47LWDNxpTWsRWBS3yVtT2U1AHjoNL2O+1yzQpigHFlLYr3
	 dW7i+vW77hJUey+ryf7KZquoEGNcS9gmdmBvX+oHCsy2l9GZZt8l45qXSyWyUhbbPM
	 bKyULaxggNDGFYveZi3HWjN3uQrvWMVl21wEBBqFckehFpcTCtRXEYaTtC1M3G+ftG
	 BLLzPRgeAQjO6CeWJ2w9aeYnsetvSwnsdOM1Tj6xHKGwSKLRADwFPLpU+WerngeSlr
	 jVTFvOv1jRzp4wJKoJoqAa416gXhaAQ8Mv8Yl7q4CzxY8Z5Gaupm2iDuQx8SDXYZee
	 UJlcw6yTMN+og==
X-Pm-Submission-Id: 4hdqlK5pqGz2SdlZ
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 07 Sep 2026 16:51:02 +0200
Subject: [PATCH v8 7/9] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-mma8452-open-drain-v8-7-c17407e22118@geanix.com>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788792664; l=2386;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=VU3Y10yCGpg+zmCnQaJJEMBjTuK+919XG+6NtyAbZeI=;
 b=qv6D1H2+8t+2Y+HtkWC9jUTUIASbgY9eqHTNvs80GASGBFEeIz2dtK3pVpb90UPNkxqahs+bD
 EoJjiemI+MzAJsy8dhED3zrXlk1CeTh+capASTiT+ukJqcF054+AoSI
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
index 2c1b97b77bc1..b5ab85a86e72 100644
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
@@ -136,6 +138,7 @@ struct mma8452_data {
 	int sleep_val;
 	u8 ctrl_reg1;
 	u8 data_cfg;
+	bool open_drain;
 };
 
 /**
@@ -659,6 +662,22 @@ static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
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
@@ -1665,6 +1684,11 @@ static int mma8452_probe(struct i2c_client *client)
 			goto disable_regulators;
 	}
 
+	data->open_drain = device_property_read_bool(dev, "drive-open-drain");
+	ret = mma8452_set_interrupt_pin_mode(data);
+	if (ret)
+		goto trigger_cleanup;
+
 	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
 			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
 
@@ -1792,6 +1816,10 @@ static int mma8452_runtime_resume(struct device *dev)
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

