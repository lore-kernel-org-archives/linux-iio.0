Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D8150C2BF;
	Wed, 16 Sep 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568376; cv=none; b=ImEzWXF5/bAI0E7oSwzW7q7bihmH8jXDGJgfAFSkhZPoMMFmpnaeDPq6iov6tnn2vL2zg5pSJdqTXimGRn76j32aJ5Xu1aUJuPUlmrr3+SYD8lGU5qgic/9D6mZ66Vyotg3K7iPcpkfwT7PCOB2DpE9SIMHjsqJ+jgDLgfIKhEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568376; c=relaxed/simple;
	bh=ox3TW9dR7HuYXesFtQTlhj0f6iwz5LSaxwwsKpTLehg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lmzLEqy+hABpBLbyY4odHtjKF7hZufzVjNMBp4FSjJ01V40OscY46xGOw//nkTVcgxcNNGNxHhDGUOBf4M6ixlp6bRsGySdnfPKIPNEvM758soGDNE1ia7cddGSGIHEr3eaChcxbmSR2QKDn1M705LvGLuBh94ZzAzCd+k8INiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HW7Qfzj1; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HW7Qfzj1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789568375; x=1821104375;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ox3TW9dR7HuYXesFtQTlhj0f6iwz5LSaxwwsKpTLehg=;
  b=HW7Qfzj1UC+cbSWryOd+pJ+Nku6IdPF9DPPmR3eDl24NmSKZntizzoyL
   xJSBPCnkrI9mHfnBm7lmmBNn5u2bM4S+2f9PsZASt5jDMh0qzpGriCVqS
   AIMzDXZGfjg3YSXeEkU/tMiXWdYx8r4D+Q8DBF4b0MQbh6xAM++3cfHED
   Hk/4AYQATjsH4NPMP4O5uiok+sh58X6XUyjsQpf5X+0bEAFi9pSN6vMSl
   dEVmjUbTSjXrpLdDgcwih3OeeBA9JWqdEiit1+QjB25/PLsevAGaAiilc
   7ldahV3Az43kq52qAe+BNMANvaaoPCqsv5VhUf5LITcttInHCmOMo9QZ4
   w==;
X-CSE-ConnectionGUID: iP8P1HvzS8KO9TYqKEpMVw==
X-CSE-MsgGUID: GpM6SGO9Qpyt1xp3Sdb3Wg==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="295112904"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2026 07:19:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 16 Sep 2026 07:19:22 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 16 Sep 2026 07:19:19 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 16 Sep 2026 17:16:34 +0300
Subject: [PATCH v6 08/11] iio: dac: mcp47feb02: rename channel mask and
 value macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-mcp47feb02_refactor-v6-8-285464651f89@microchip.com>
References: <20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com>
In-Reply-To: <20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568335; l=3928;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=ox3TW9dR7HuYXesFtQTlhj0f6iwz5LSaxwwsKpTLehg=;
 b=3ZlN8SjILKhqc81fLtCWvw/nlLLT28IIEWQ/GZhfpesZyW16RuG75NRrkT1td4An9i4klYIic
 SX+A9KJtIQACfeQBJuUHx1mYWD9d6Q3k6bjI8MCksCGKB8YVS1TCUIo
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Rename generic DAC_CTRL_MASK/VAL macros to MCP47FEB02_VREF_PD_MASK/VAL
in order to clearly indicate for which control registers these channel
masks are suitable.

Reported-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/all/20260528125140.16a8f173@jic23-huawei/
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 8dac4e2fb74fe4563324343ce215af3389129130..5c09ca25a75e0ecb2bfc5a2d5e62e5f7d3156810 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -49,8 +49,8 @@
 #define MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK		GENMASK(7, 0)
 
 /* Voltage reference, Power-Down control register and DAC Wiperlock status register fields */
-#define DAC_CTRL_MASK(ch)				(GENMASK(1, 0) << (2 * (ch)))
-#define DAC_CTRL_VAL(ch, val)				((val) << (2 * (ch)))
+#define MCP47FEB02_VREF_PD_MASK(ch)			(GENMASK(1, 0) << (2 * (ch)))
+#define MCP47FEB02_VREF_PD_VAL(ch, val)			((val) << (2 * (ch)))
 
 /* Gain Control and I2C Slave Address Register fields */
 #define DAC_GAIN_MASK(ch)				(BIT(0) << (8 + (ch)))
@@ -555,7 +555,8 @@ static int mcp47feb02_suspend(struct device *dev)
 		data->chdata[ch].powerdown = true;
 		pd_mode = data->chdata[ch].powerdown_mode + 1;
 		ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
-					 DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, pd_mode));
+					 MCP47FEB02_VREF_PD_MASK(ch),
+					 MCP47FEB02_VREF_PD_VAL(ch, pd_mode));
 		if (ret)
 			return ret;
 
@@ -587,7 +588,8 @@ static int mcp47feb02_resume(struct device *dev)
 			return ret;
 
 		ret = regmap_update_bits(data->regmap, MCP47FEB02_VREF_REG_ADDR,
-					 DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, pd_mode));
+					 MCP47FEB02_VREF_PD_MASK(ch),
+					 MCP47FEB02_VREF_PD_VAL(ch, pd_mode));
 		if (ret)
 			return ret;
 
@@ -598,8 +600,8 @@ static int mcp47feb02_resume(struct device *dev)
 			return ret;
 
 		ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
-					 DAC_CTRL_MASK(ch),
-					 DAC_CTRL_VAL(ch, MCP47FEB02_NORMAL_OPERATION));
+					 MCP47FEB02_VREF_PD_MASK(ch),
+					 MCP47FEB02_VREF_PD_VAL(ch, MCP47FEB02_NORMAL_OPERATION));
 		if (ret)
 			return ret;
 	}
@@ -656,7 +658,8 @@ static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, uintptr_t p
 	 */
 	tmp_pd_mode = state ? (data->chdata[reg].powerdown_mode + 1) : MCP47FEB02_NORMAL_OPERATION;
 	ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
-				 DAC_CTRL_MASK(reg), DAC_CTRL_VAL(reg, tmp_pd_mode));
+				 MCP47FEB02_VREF_PD_MASK(reg),
+				 MCP47FEB02_VREF_PD_VAL(reg, tmp_pd_mode));
 	if (ret)
 		return ret;
 
@@ -822,7 +825,7 @@ static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
 	}
 
 	ret = regmap_update_bits(data->regmap, MCP47FEB02_VREF_REG_ADDR,
-				 DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, tmp_val));
+				 MCP47FEB02_VREF_PD_MASK(ch), MCP47FEB02_VREF_PD_VAL(ch, tmp_val));
 	if (ret)
 		return ret;
 
@@ -1027,7 +1030,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 			return ret;
 		data->chdata[i].dac_data = dac_val;
 
-		data->chdata[i].ref_mode = field_get(DAC_CTRL_MASK(i), vref_ch);
+		data->chdata[i].ref_mode = field_get(MCP47FEB02_VREF_PD_MASK(i), vref_ch);
 		data->chdata[i].use_2x_gain = field_get(DAC_GAIN_MASK(i), gain_ch);
 
 		/*
@@ -1071,7 +1074,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 			break;
 		}
 
-		pd_tmp = field_get(DAC_CTRL_MASK(i), pd_ch);
+		pd_tmp = field_get(MCP47FEB02_VREF_PD_MASK(i), pd_ch);
 		data->chdata[i].powerdown_mode = pd_tmp ? (pd_tmp - 1) : pd_tmp;
 		data->chdata[i].powerdown = !!(data->chdata[i].powerdown_mode);
 	}

-- 
2.43.0

