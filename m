Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EDA592210;
	Wed,  9 Sep 2026 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963555; cv=none; b=iaOKBZ87QKckfS6R+9pMDMY8hvt8mAglCs/IWo+kJSecFEJ/x/wVjgWhL2u+oYEeCBqsWDL5x8mMHWDz97OvYouMwfzwmFrkPYsx4HMPIKPocrbeHA5DfQFqQyNSI0QpThCsbrnimUTynl8P1LS+4lCj2RsRMt5g/AFpPmG+m4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963555; c=relaxed/simple;
	bh=wJZB/qoINM7AVZIhITt6LJmCeHlTSW/dK8UIYfcW38k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ldl0qWCrJfEwW/oaQJBe8rspf1oq/J9muqLwTm6tpQXAwOLGS9E513q+sJ2JJGgy0N4PkN8vFH/Z2YEsI/PYfcgGdaV3O5MUxGBysG4flfUO4iDrWk9eL5+R0BysU6DKRsdsc81Ge2LLvqK7Xdyp9UpXp1PsRjmOc3glr08EHmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zt8wnCu0; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zt8wnCu0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788963554; x=1820499554;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wJZB/qoINM7AVZIhITt6LJmCeHlTSW/dK8UIYfcW38k=;
  b=zt8wnCu0JpBE3G0SMu/2jCFZnCgdHANCEJT1R/CB7goSAKsxrzi9o36+
   WEestlhIibgnLaj0nV6amZ/fQUQhPBNCJ2L8fohKq7Fn7qFTJmlburh3e
   jCjw/weHUxRud0/bvSMkkU0FXh7SQm+jwS4kZtQX9VK5Ln5oZP6heKTS1
   N2g2OJfJjCqDMfzXs0jSYOblUNKxwt9vtXnE99XInwjrInEOlkp5Wg8Jc
   HXFUgs/8udR6Z1kPFFH3hzNwKprOxRHM7QxBurUxYw4Ft0TfJFkEUtql9
   7HksGnj4l+4xVMn/mSJqjgvZGm9auoUsYfvuXOahiLmyySFdIjWll+6RP
   g==;
X-CSE-ConnectionGUID: epht3hxTTaKxRULqNdo26w==
X-CSE-MsgGUID: 3+s6geSoR/KBAbHIDsDtRg==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="294764008"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2026 07:19:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 9 Sep 2026 07:19:12 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 9 Sep 2026 07:19:10 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 9 Sep 2026 17:18:50 +0300
Subject: [PATCH v5 07/10] iio: dac: mcp47feb02: rename command mask define
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-mcp47feb02_refactor-v5-7-8b67bcab93d1@microchip.com>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
In-Reply-To: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788963530; l=1903;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=wJZB/qoINM7AVZIhITt6LJmCeHlTSW/dK8UIYfcW38k=;
 b=xOTS7krn6ZbZISC40RqZiUVsv8BZdpeUZ4Cq40aJCuoP5BAUxvFTUwvtwoq70o2b+EjuTKcF7
 yaMX08HpAHOBiu6Wuj2p0yb3t5/ucJssTDrBbzItDk37/zmPFXalrmB
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
index c054711a55ca01be9e0aba57a2ddbf192406fd47..fb66bd2664a9e6dd938eacc90547403041e258a4 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -33,8 +33,9 @@
 /* Register addresses must be left shifted with 3 positions in order to append command mask */
 #define MCP47FEB02_DAC0_REG_ADDR			0x00
 #define MCP47FEB02_VREF_REG_ADDR			0x40
+#define MCP47FEB02_GET_VREF_MODE(reg, ch)		(((reg) >> (2 * (ch))) & GENMASK(1, 0))
 #define MCP47FEB02_POWER_DOWN_REG_ADDR			0x48
-#define MCP47FEB02_DAC_CTRL_MASK			GENMASK(1, 0)
+#define MCP47FEB02_GET_POWER_DOWN_MODE(reg, ch)		(((reg) >> (2 * (ch))) & GENMASK(1, 0))
 
 #define MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR		0x50
 #define MCP47FEB02_GAIN_BIT_MASK			BIT(0)
@@ -1025,7 +1026,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 			return ret;
 		data->chdata[i].dac_data = dac_val;
 
-		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
+		data->chdata[i].ref_mode = MCP47FEB02_GET_VREF_MODE(vref_ch, i);
 		data->chdata[i].use_2x_gain = (gain_ch & DAC_GAIN_MASK(i)) ? 1 : 0;
 
 		/*
@@ -1069,7 +1070,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 			break;
 		}
 
-		pd_tmp = (pd_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
+		pd_tmp = MCP47FEB02_GET_POWER_DOWN_MODE(pd_ch, i);
 		data->chdata[i].powerdown_mode = pd_tmp ? (pd_tmp - 1) : pd_tmp;
 		data->chdata[i].powerdown = !!(data->chdata[i].powerdown_mode);
 	}

-- 
2.43.0

