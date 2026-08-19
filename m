Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9A2E62B4;
	Wed, 19 Aug 2026 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143282; cv=none; b=R2AYhGpnI0TsB6aejW6rZ9I8Lbaw7ZlrgAs6krFszqNsiB959QXL635ye8gd90G8ZqVV2G6JL024yd7oe2Is6Kyd5+dAIIbzc5T3La58D9oDShZSJkh+F3ZLshBMR/mqEKwy4HxgSrZJPYlIdz2bGkq4cKan8cgOMdRuqcboZAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143282; c=relaxed/simple;
	bh=0kfQCrAJAnt1AGSQBDQb2mzczFIyr/6cg3aznhPRdjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Bc2Nnzas0F1hoNV+ur4E+IlZ7cgW/slh0k2OPaCpPfMUizcjIts2wsuCTtKpPf5+h8MqrgK4plufRvloh8uSjPs4HH3XF7WUb73LB9jRoI0jJDBmJhFtAbQH0SxR0pjbYBtgDzWKGTgZbGVWfLyx12UGiZuiwg+o465sSA8hs0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=J6qZvlIE; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="J6qZvlIE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787143280; x=1818679280;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=0kfQCrAJAnt1AGSQBDQb2mzczFIyr/6cg3aznhPRdjQ=;
  b=J6qZvlIEQWg3Yb6ZBpS+QMG1kgqkgqJBGIXbVLMz07PobDWO9P+xyInO
   04Vqu6Gj14SA4r0BAjQbIJnFRC7dV1TsrDnvIVd73Acp4gXFn1Ov6vpSg
   EU4O6RUjE7DWwB1PSaqrRyyWM6pykJ6Gns5fwdd7R73c0pguthIOEZtkq
   VFjpfuCw4SghvP8BjTI6ekGuT4N9RFERqygLxVLVXu97pNx2pmUTpAGL+
   7ocClNrWHWi3ZvjHVkef5x8DdL/mb9xP+C2GHTLR8rJgbqFLCqX/29Z1z
   JylKuTbcI1RH9n/uv+K+YUlEkyrlQfJfWoPoShBgliaW+7JTEBVhh5iUB
   A==;
X-CSE-ConnectionGUID: 9zn0HIDgQ2S1wuNd99srCg==
X-CSE-MsgGUID: qv+VOYEmQw2vYyrhTtVhHQ==
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="61462183"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 05:41:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 19 Aug 2026 05:41:15 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 19 Aug 2026 05:41:12 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 19 Aug 2026 15:41:05 +0300
Subject: [PATCH v4 1/9] iio: dac: mcp47feb02: initialize dac_data field in
 channel data struct at probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260819-mcp47feb02_refactor-v4-1-beb2aa3bfd09@microchip.com>
References: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
In-Reply-To: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787143269; l=1156;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=0kfQCrAJAnt1AGSQBDQb2mzczFIyr/6cg3aznhPRdjQ=;
 b=VFvZJyhRr9Zvmz1JiOq3KvEY/Cn/iagqyE+8QTpzk19UzupGbuZ95L8LCbnkgiSZXeByx8hx8
 cVQowOFkcUtBleQOgWmSUBFtNCDKbdPcHewmWehqgp8qES61lVnvOAJ
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Read DAC value register to initialize corresponding field in channel_data
struct when the module is inserted.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index a823c2a673a26d70e5829cb587034da435af0451..7502959d98eab27941d58b6b961e6e3dee4222e6 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -1020,7 +1020,12 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
 	gain_ch = gain_ch & MCP47FEB02_GAIN_BITS_MASK;
 	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
 		struct device *dev = regmap_get_device(data->regmap);
-		unsigned int pd_tmp;
+		unsigned int pd_tmp, dac_val;
+
+		ret = regmap_read(data->regmap, REG_ADDR(i), &dac_val);
+		if (ret)
+			return ret;
+		data->chdata[i].dac_data = dac_val;
 
 		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
 		data->chdata[i].use_2x_gain = (gain_ch >> i)  & MCP47FEB02_GAIN_BIT_MASK;

-- 
2.43.0

