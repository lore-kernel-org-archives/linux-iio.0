Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1B3F65F6
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 12:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178650; cv=none; b=kATspzIF60QDZIF466rgKjwNkfgT+ADdNpQRYkzKLwnlwUCPV0H6/04/hpcn9HgDv7yvdxfxyKE765VkiBtAZrXmKEb+Vvk8vGXLpAD5MCgyEX2jxkh7F1EjxUxNXSPuzMAO6GkIL/rsKw6xFrjQ5Qq8oNhFL5uD5OksYJ0xLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178650; c=relaxed/simple;
	bh=hZw9obe3nthRbPAPqrrWPrJ8rTI3POsteBLsAliD4Z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHBzsD8UAXlXeKgWBCdbSqN02LS6q8V0GB6U2AptC72KfOP3tcecNdfTaHpfFeuEt6Jo5/bUh8QiwtQ7dFgBfm4T+ZktwHzVCcFWtHK3zeqTM2Sme+DFyQxhQuKfbPGn0dvxlHyIMBc9zkwy3w0zge4wDAy6cSJsH5hlIdB+ERM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=0DvQu0aZ; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="0DvQu0aZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788178643; x=1788437843;
	bh=4LxYhhz3DNXFvpjt11E18Eq/L5WwfIqXKDX+l4mFsfk=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=0DvQu0aZuhWzCSSR2G82ktUqps3NtPEH+pu2g9Ye9X85oTcm5CUBTg+JwIyZzfcep
	 Nxw3xjdmjq7z+Jlazm1p3ulvPsCRQH1tAUnm2oG/4pob7Nxcqms+tzYR1P4dUGyfeR
	 MigHEBbQxOo5xUHBa1VKO0Afxk6qIIrPpnDOvntrgcKEVzmeSX25RU3VuMDiVM4voN
	 H9F5dA0vMJYBBX5vk0dZU9fo0zVjBrN440l53yeCSLU19CuOvaAQQwUlbWIlug0QHW
	 ldAotGwO005NRn0Z9si/+3sFILtJd3RdggCkhldFMj03n4DRbxgQsZGBO0jnhgX/JW
	 xKIv1+DqW73HQ==
X-Pm-Submission-Id: 4hYSfn2s76z1DFFC
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 31 Aug 2026 14:17:08 +0200
Subject: [PATCH v7 5/8] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-mma8452-open-drain-v7-5-22946812c928@geanix.com>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788178627; l=2409;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=hZw9obe3nthRbPAPqrrWPrJ8rTI3POsteBLsAliD4Z8=;
 b=udTDqY6KOS/UBpULb4ZoN8sfYdszDqmAvnExBMUNVOzbmBmK11syFGykfVadKv8anoeQOLQJm
 IrttwtO0pmhA5DqmjFfaZZgjEDFiRel8vi4wQW0YUhWfLPUQm3sSKAV
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
index 936eeb2efb2d..2ba6e2c44cb9 100644
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
 
@@ -1830,6 +1854,10 @@ static int mma8452_runtime_resume(struct device *dev)
 
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

