Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE54B7A3E;
	Fri, 18 Sep 2026 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722487; cv=none; b=iXpiUCiWwRmo4pTuoO3mnVq8BZk7hII13okPrbFRMfHgGDLJObXOgBNWwLK60JCdHpXNuMQRlrwQgj87BEInaP1FbPTeUhMBCZszFIe2xrTORemXNHTpwR8jolil7hI1MliGJOxnb4iQyLdGFdNnTO6iko7FIGUwObb1/WDEyzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722487; c=relaxed/simple;
	bh=R9c7M1KPe6wv8k9h1ibYF3FWsvL/EGbNmD/Wr0eut48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y/RJiBrMOFaNo/nN14s5SnQVsj9SlJL/e6XIR14Cl4egb4HoCjzcV66bZiyDLplGBfAKIsSSbbCL07pM9YgjaPxIG/IhzimqfaWv7+GxRUkslSFc0sPWq/CxcAPo73lXr0kOa9rvp1ugH/cksoXPyw1q/hSFTroZPC9BYdS3CGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ACOQUV0k; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ACOQUV0k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789722486; x=1821258486;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=R9c7M1KPe6wv8k9h1ibYF3FWsvL/EGbNmD/Wr0eut48=;
  b=ACOQUV0kTJyzCs7K/QUFf0cqh4O9nnzo8GpL2EFH4rVIWvIzqMW57AiQ
   4EESiTA/IE5XX3GU97mvjjI+QpoRxVDEXEbkYVGHYk4UOYP9g25q9ksqW
   vt4aYNB4xhrkf1+L58UohtVbl+CjSI3zgtwY4gnxDjRi0UhkiAbUmkMfL
   HWAcbXm0aFtTuV+gBgqJqz0js/BpAOF3pjyWuV3gUpAQ70/UcO7ZtDeiI
   eaZiAAn+Pi+3YOmvMm9Ck2XgTFmJYvF/+7NaKehG+Ug0bAS1skfpiIRwZ
   xUvBrQ9zM4WR7exs1+VVQr1FOz96kgQzbA7aFBJ6qKYgp8FGCqhlAomQY
   A==;
X-CSE-ConnectionGUID: pWIzL0rTRJS4c0xcbqlj5A==
X-CSE-MsgGUID: 1MQP5IorTCCtUfkQmstIaw==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="63800320"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 02:08:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 18 Sep 2026 02:08:05 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 18 Sep 2026 02:08:02 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Fri, 18 Sep 2026 12:06:34 +0300
Subject: [PATCH v7 08/11] iio: dac: mcp47feb02: use field_prep() instead of
 custom dynamic macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-mcp47feb02_refactor-v7-8-82ca794eafe2@microchip.com>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
In-Reply-To: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789722457; l=6018;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=R9c7M1KPe6wv8k9h1ibYF3FWsvL/EGbNmD/Wr0eut48=;
 b=gBvhyHA+cR9yzyLw4GDZ70oiA39rDF9NO4zs1V3CSgMvyVRC89eruJt0RwUQZsvZUACdXE048
 l+4s7IzDAcMBDwS7P7ShSob/+gPX53n33kmPIQ/vCqUVrOCrC911WhX
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Replace manual bit operations which select channel corresponding bits
from a control register for each write to regmap operation using
regmap_update_bits(). This approach matches the use of field_get() in
probe() and improves code readability.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/all/20260917015334.1f43bd02@jic23-hlaptop/
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 8019d398fbbbc866303ed7e9280f30acef4d6cc7..7312c2c96141e417726fc97954d8cb1fafefe3e9 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -48,12 +48,10 @@
 #define MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK		GENMASK(7, 0)
 
 /* Voltage reference, Power-Down control register and DAC Wiperlock status register fields */
-#define DAC_CTRL_MASK(ch)				(GENMASK(1, 0) << (2 * (ch)))
-#define DAC_CTRL_VAL(ch, val)				((val) << (2 * (ch)))
+#define MCP47FEB02_VREF_PD_MASK(ch)			(GENMASK(1, 0) << (2 * (ch)))
 
 /* Gain Control and I2C Slave Address Register fields */
 #define DAC_GAIN_MASK(ch)				(BIT(0) << (8 + (ch)))
-#define DAC_GAIN_VAL(ch, val)				((val) << (8 + (ch)))
 
 #define REG_ADDR(reg)					((reg) << 3)
 #define NV_REG_ADDR(reg)				((NV_DAC_ADDR_OFFSET + (reg)) << 3)
@@ -550,11 +548,13 @@ static int mcp47feb02_suspend(struct device *dev)
 
 	for_each_set_bit(ch, &data->active_channels_mask, data->phys_channels) {
 		u8 pd_mode;
+		u32 mask;
 
 		data->chdata[ch].powerdown = true;
 		pd_mode = data->chdata[ch].powerdown_mode + 1;
+		mask = MCP47FEB02_VREF_PD_MASK(ch);
 		ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
-					 DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, pd_mode));
+					 mask, field_prep(mask, pd_mode));
 		if (ret)
 			return ret;
 
@@ -576,6 +576,7 @@ static int mcp47feb02_resume(struct device *dev)
 
 	for_each_set_bit(ch, &data->active_channels_mask, data->phys_channels) {
 		u8 pd_mode;
+		u32 mask;
 		int ret;
 
 		data->chdata[ch].powerdown = false;
@@ -585,20 +586,21 @@ static int mcp47feb02_resume(struct device *dev)
 		if (ret)
 			return ret;
 
+		mask =  MCP47FEB02_VREF_PD_MASK(ch);
 		ret = regmap_update_bits(data->regmap, MCP47FEB02_VREF_REG_ADDR,
-					 DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, pd_mode));
+					 mask, field_prep(mask, pd_mode));
 		if (ret)
 			return ret;
 
+		mask = DAC_GAIN_MASK(ch);
 		ret = regmap_update_bits(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR,
-					 DAC_GAIN_MASK(ch),
-					 DAC_GAIN_VAL(ch, data->chdata[ch].use_2x_gain));
+					 mask, field_prep(mask, data->chdata[ch].use_2x_gain));
 		if (ret)
 			return ret;
 
+		mask = MCP47FEB02_VREF_PD_MASK(ch);
 		ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
-					 DAC_CTRL_MASK(ch),
-					 DAC_CTRL_VAL(ch, MCP47FEB02_NORMAL_OPERATION));
+					 mask, field_prep(mask, MCP47FEB02_NORMAL_OPERATION));
 		if (ret)
 			return ret;
 	}
@@ -641,6 +643,7 @@ static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, uintptr_t p
 	u32 reg = ch->address;
 	u8 tmp_pd_mode;
 	bool state;
+	u32 mask;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -654,8 +657,9 @@ static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, uintptr_t p
 	 * requires writing normal operation mode (0) to the channel-specific register bits.
 	 */
 	tmp_pd_mode = state ? (data->chdata[reg].powerdown_mode + 1) : MCP47FEB02_NORMAL_OPERATION;
+	mask = MCP47FEB02_VREF_PD_MASK(reg);
 	ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
-				 DAC_CTRL_MASK(reg), DAC_CTRL_VAL(reg, tmp_pd_mode));
+				 mask, field_prep(mask, tmp_pd_mode));
 	if (ret)
 		return ret;
 
@@ -799,6 +803,7 @@ static int mcp47feb02_check_scale(struct mcp47feb02_data *data, int val, int val
 static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
 {
 	int tmp_val, ret;
+	u32 mask;
 
 	if (scale == MCP47FEB02_SCALE_VDD) {
 		tmp_val = MCP47FEB02_VREF_VDD;
@@ -820,8 +825,9 @@ static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
 		tmp_val = MCP47FEB02_INTERNAL_BAND_GAP;
 	}
 
+	mask = MCP47FEB02_VREF_PD_MASK(ch);
 	ret = regmap_update_bits(data->regmap, MCP47FEB02_VREF_REG_ADDR,
-				 DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, tmp_val));
+				 mask, field_prep(mask, tmp_val));
 	if (ret)
 		return ret;
 
@@ -844,6 +850,7 @@ static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
 static int mcp47feb02_set_scale(struct mcp47feb02_data *data, int ch, int scale)
 {
 	int tmp_val, ret;
+	u32 mask;
 
 	ret = mcp47feb02_ch_scale(data, ch, scale);
 	if (ret)
@@ -854,8 +861,9 @@ static int mcp47feb02_set_scale(struct mcp47feb02_data *data, int ch, int scale)
 	else
 		tmp_val = MCP47FEB02_GAIN_BIT_X1;
 
+	mask = DAC_GAIN_MASK(ch);
 	ret = regmap_update_bits(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR,
-				 DAC_GAIN_MASK(ch), DAC_GAIN_VAL(ch, tmp_val));
+				 mask, field_prep(mask, tmp_val));
 	if (ret)
 		return ret;
 
@@ -1026,7 +1034,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 			return ret;
 		data->chdata[i].dac_data = dac_val;
 
-		data->chdata[i].ref_mode = field_get(DAC_CTRL_MASK(i), vref_ch);
+		data->chdata[i].ref_mode = field_get(MCP47FEB02_VREF_PD_MASK(i), vref_ch);
 		data->chdata[i].use_2x_gain = field_get(DAC_GAIN_MASK(i), gain_ch);
 
 		/*
@@ -1070,7 +1078,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 			break;
 		}
 
-		pd_tmp = field_get(DAC_CTRL_MASK(i), pd_ch);
+		pd_tmp = field_get(MCP47FEB02_VREF_PD_MASK(i), pd_ch);
 		data->chdata[i].powerdown_mode = pd_tmp ? (pd_tmp - 1) : pd_tmp;
 		data->chdata[i].powerdown = !!(data->chdata[i].powerdown_mode);
 	}

-- 
2.43.0

