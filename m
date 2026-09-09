Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4858F068;
	Wed,  9 Sep 2026 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963541; cv=none; b=Dvy3tZUR6pH/BQXd/PU1Sp8/qZgE3pW9ZV52QcH69gdFFsJw9E6CDlmWQ26rEA4i+oqn+XD8NJFhnKRcTgVhWiKKRoTcJxT+2Xz3zGxgPkGP7CUUPnqzoPehEsMeW596vDP0Yyo4nsh4Egawk979ho0twFKRbkn7Xaf5BkKBoOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963541; c=relaxed/simple;
	bh=dhaukSEkzUciDMy5eVXi8NEag21yuue0hUkXjr4iBwM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=es3BuZTJ7lUsUOieigmAtFllDiDcUjp9SvdVx3rzkeWZ2betdaMkGRltFIPtNXjS+fLPmH5cm2YREUWycyJg4WnOLCcbi3XqG8hnJFfYJMBhi1EWRW3rx7fzmHwZAe2FjrvnDZMXKy6mLCa2Sh315iatpPlrlAZ3TVO8vaXyUfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=n+ZQWUOo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="n+ZQWUOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788963540; x=1820499540;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=dhaukSEkzUciDMy5eVXi8NEag21yuue0hUkXjr4iBwM=;
  b=n+ZQWUOosIQxp/cYFOGLFcEk1Cyzvmz2W/2OyJGmgOBFkR4ajhmrTBqb
   XaAngTaYt8y7Dcfl5yop0E/GiBBjBRXjXoBJR1EUm2Q0ofO7gfZfcM6qA
   pSlxWIQwS1I5dY5GSJphLe4HY4WbK7Ws4wcbHrLTsrraY+t0u7ViAKNSj
   1vIfmzwkaEppR3DvXH5Syddjds2jf2Lds+xGKYbhBatFMB1j0FffftWml
   IFHYOv4l9LLqr/nxr1t9QROQSf0iB6GVJuDNL32svcfmsNBcIwWraUQXW
   E6y8DhVFj7Mvt+FQd4z/0PjEmHQGYbUfbwUcE6ckzls7GPmcU1jYjR3FC
   w==;
X-CSE-ConnectionGUID: SLSng6IkRR+aZgTLG4vWZA==
X-CSE-MsgGUID: 8KZu/BY1TfK05H5gto/vGw==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="294763991"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2026 07:18:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 9 Sep 2026 07:18:58 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 9 Sep 2026 07:18:56 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 9 Sep 2026 17:18:45 +0300
Subject: [PATCH v5 02/10] iio: dac: mcp47feb02: Fix gain field
 initialization for active channels
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-mcp47feb02_refactor-v5-2-8b67bcab93d1@microchip.com>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
In-Reply-To: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788963530; l=1709;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=dhaukSEkzUciDMy5eVXi8NEag21yuue0hUkXjr4iBwM=;
 b=fYRKNREgoOR6K17sWYV7wMT3VOdGw58VYC7x1GSg3299SMYV8/f6tXBiQ46+KJEJ22Io/ttMs
 mtyaVkN8ZylAj+JehJxoBoEqWIGle9/vMqZ3vuo5Zhu57f4DcNhsP25
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

As per MCP47FXBX48 Datasheet, in the format of the Gain Control and System
Status Register each DAC channel has one bit to control its gain,
starting at bit 8, while bits 0-7 contain status or unimplemented bits.

The previous formula didn't initialize correctly all channels, being
replaced by the already defined macro used in write operations where needed
in the rest of the driver implementation. DAC_GAIN_MASK(i) extracts the
gain control bit for each active channel correctly ine one step.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 7502959d98eab27941d58b6b961e6e3dee4222e6..bf78618ac2c896b94e494a1ce76ef5b3e520f482 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -1017,7 +1017,6 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 	if (ret)
 		return ret;
 
-	gain_ch = gain_ch & MCP47FEB02_GAIN_BITS_MASK;
 	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
 		struct device *dev = regmap_get_device(data->regmap);
 		unsigned int pd_tmp, dac_val;
@@ -1028,7 +1027,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 		data->chdata[i].dac_data = dac_val;
 
 		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
-		data->chdata[i].use_2x_gain = (gain_ch >> i)  & MCP47FEB02_GAIN_BIT_MASK;
+		data->chdata[i].use_2x_gain = (gain_ch & DAC_GAIN_MASK(i)) ? 1 : 0;
 
 		/*
 		 * Inform the user that the current voltage reference read from the volatile

-- 
2.43.0

