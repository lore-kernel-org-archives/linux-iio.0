Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CE2EEE7E;
	Wed, 19 Aug 2026 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143291; cv=none; b=FGxNr9P2PAOKdVaHki/bnsQwROj/11HAvHOeFxJbknsNGQnKb3x+3FfnHz3X9ChPkuyPgVaN5E+DMrP4Z2G5hNL3Bl40gwtY1qjyNlb1lp2Xewpx8dGqERArLhEE1ba/OJqipBmrvMAzYLirzJQmn5TBS+/DH3TbXe9M4FVzZhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143291; c=relaxed/simple;
	bh=myXQh1iDIpKn5R9LdBkXRvRACG8jMDaWnk1Wh8OpgZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mudPt5tznGMKZOBHHhpmMBbosYgviSBqD4tnPZyhHfIu3+tLe5m+mBqqnPNugicTgICwcvrRwtNm6EVWjdPoz4dwQR7s8AEShblOUBA4M1noLxMVjj1L5zIXLOz+7V4whZ9FEo2wBfRQx2uu4iOsULGn9czzdZEKsmQGqOVHAdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IEX/9+kI; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IEX/9+kI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787143289; x=1818679289;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=myXQh1iDIpKn5R9LdBkXRvRACG8jMDaWnk1Wh8OpgZc=;
  b=IEX/9+kII4A1AxwmtUDESsLZgiAkORTFhNVQ0DPJ6nFOTztu/7Ir64f9
   Mtu3G0B20fuRfo4pI+syU/tlR3G9ATejGWZkyyBAMlEOZTx+CqUFuKbSm
   CdXcC7y7jJhY6CrWqIn8v2TTvXVQqzkKXmt4WcftREk9qztERoG4K/KbS
   2SUOXGrFRTSlaV9FdSrJ3SFEaIoL1pRyhzRa/i6dqhVsSxkDd4+81PU4o
   sJtunkeW4WC12NQDnGusayHofGC+lQet/Jlx8wtlwKCBVg79w4CHlEgSH
   lvTmskdrnivGsuWAu/TGf9JRyHE3r8TaLFw0zVXeIriG1LK86HYP9ndqO
   g==;
X-CSE-ConnectionGUID: e7MM+NI3TZ63TLrJHWrzAQ==
X-CSE-MsgGUID: y8BXwQGfT6ijnG3IWjE/tQ==
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="61462193"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 05:41:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 19 Aug 2026 05:41:28 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 19 Aug 2026 05:41:26 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 19 Aug 2026 15:41:10 +0300
Subject: [PATCH v4 6/9] iio: dac: mcp47feb02: rename command mask define
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260819-mcp47feb02_refactor-v4-6-beb2aa3bfd09@microchip.com>
References: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
In-Reply-To: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787143269; l=1903;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=myXQh1iDIpKn5R9LdBkXRvRACG8jMDaWnk1Wh8OpgZc=;
 b=W1vPxxOE5SV0bVas88xxn+RIAPlPPqFYHFyZ6WGCmB9n3fwKOtEtx49o1lVQwYuEwa9O7DGcG
 5j66jpK40tbCfwiX7wYhEjzimjkelqKqK6bnVsgfzB+l7iw8oQn7e0D
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Use 2 new defines to select the corresponding bits for each channel in VREF
and Power Down registers instead of the initial define without a meaningful
name.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 6f084eb71240b475bf85763139ecfafc006da83d..8ca67c4021a86a6d5034495c1dbb18772ada354b 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -34,8 +34,9 @@
 /* Register addresses must be left shifted with 3 positions in order to append command mask */
 #define MCP47FEB02_DAC0_REG_ADDR			0x00
 #define MCP47FEB02_VREF_REG_ADDR			0x40
+#define MCP47FEB02_GET_VREF_MODE(reg, ch)		(((reg) >> (2 * (ch))) & GENMASK(1, 0))
 #define MCP47FEB02_POWER_DOWN_REG_ADDR			0x48
-#define MCP47FEB02_DAC_CTRL_MASK			GENMASK(1, 0)
+#define MCP47FEB02_GET_POWER_DOWN_MODE(reg, ch)		(((reg) >> (2 * (ch))) & GENMASK(1, 0))
 
 #define MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR		0x50
 #define MCP47FEB02_GAIN_BIT_MASK			BIT(0)
@@ -1026,7 +1027,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 			return ret;
 		data->chdata[i].dac_data = dac_val;
 
-		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
+		data->chdata[i].ref_mode = MCP47FEB02_GET_VREF_MODE(vref_ch, i);
 		data->chdata[i].use_2x_gain = (gain_ch & DAC_GAIN_MASK(i)) ? 1 : 0;
 
 		/*
@@ -1070,7 +1071,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 			break;
 		}
 
-		pd_tmp = (pd_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
+		pd_tmp = MCP47FEB02_GET_POWER_DOWN_MODE(pd_ch, i);
 		data->chdata[i].powerdown_mode = pd_tmp ? (pd_tmp - 1) : pd_tmp;
 		data->chdata[i].powerdown = !!(data->chdata[i].powerdown_mode);
 	}

-- 
2.43.0

