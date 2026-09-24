Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E46347F791;
	Thu, 24 Sep 2026 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254775; cv=none; b=t0XAuAV+8H6c56oEku7cEkbpEovuqriTFgwWI4/TOLWWr/Mc0pgW2WKYLgryYQQOVnCmf6nq5GKOGGhY1+P70HWbNmydZ+yxhFzVZdFJrIymP3Hf9XjTpw29Rjc8IxkOtV11tQOhk74KoV0iEnkUcQNwtNKBEaH//prmPiWhKB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254775; c=relaxed/simple;
	bh=o/KsqEl3H+5QMgLEPJhIWjfwqb+FH/cffq3so3sqvgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VvD0mIA82kg1Mu7HOjXvhL7AyW9zJ372t6hQLlFN2hNNPcui7ZEgiBa2iV6X3nV1gV8KZPpsproEGXzkQQCod421Z1htEwyqR69LbWsWTDwmLkZuS+YS+XeoJtJ3102hK+b36kkfnaKdukr9j6Iy1k2n0MuDjKfZ/AD59/jb/EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=06KWwfjq; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="06KWwfjq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790254774; x=1821790774;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=o/KsqEl3H+5QMgLEPJhIWjfwqb+FH/cffq3so3sqvgc=;
  b=06KWwfjqwAIrVzHMUJpUBPc3yTvlIDjR6wAOk+xBL7WYCS2C9rkgKlMw
   2XuPL30ZwsC3hPFFHL1hxtpB1Y1xmdttJu+87GV7IqAYrKMQvNDzVcgf9
   9AS5RD8KK2zWEfFfi1lVlMf6TEq88qVKuOd+MWA0KIzeHscah0/dnTsDh
   4sxm/LFgH4rC0GU5z97jw2rve/835tJwXk5o0q2c+J3yJKqDRbD+Y6UXJ
   HNtigrjBO8C9BORebHKGB+QgLzGq/y+f/DrXx0NDgYaJiPbqjmktYM1qP
   mq1hVjYuJf7DZ7KXoIE8JlCmJgXtnSZgGE8q6YmoK8v42yAIEVwnQCf0m
   w==;
X-CSE-ConnectionGUID: EiqD0fL/QCmRZjyCm/pSPQ==
X-CSE-MsgGUID: F/Zc8d7WRnOE6aTTnlk1uw==
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="64097082"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 05:59:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Thu, 24 Sep 2026 05:59:32 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 24 Sep 2026 05:59:29 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Thu, 24 Sep 2026 15:59:20 +0300
Subject: [PATCH v8 2/5] iio: dac: mcp47feb02: protect EEPROM store sequence
 with mutex
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-mcp47feb02_refactor-v8-2-17dc2ce3485e@microchip.com>
References: <20260924-mcp47feb02_refactor-v8-0-17dc2ce3485e@microchip.com>
In-Reply-To: <20260924-mcp47feb02_refactor-v8-0-17dc2ce3485e@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790254762; l=1458;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=o/KsqEl3H+5QMgLEPJhIWjfwqb+FH/cffq3so3sqvgc=;
 b=Qw4KVgfL7IkLpnK2Kmf8LGhtsNLNUqsqTP9CFCa9rwTDMEO383VO4o/d46yAKJV1o50LFkDA6
 atRebzsRs0rDefctCQbhdVCA7XxbKkF/5k0BVlvX8mNDQZ+J24IpsvC
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Move the mutex lock into store_eeprom_store() to prevent race conditions
when reading volatile registers and writing them to the EEPROM.

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Closes: https://lore.kernel.org/all/20260819125128.970911F000E9@smtp.kernel.org/
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 349574bc7489d9e5ac9722c3abbaaab0d2c3350e..8f8a67919cc2ecdb203ad350174bac2be1a307dc 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -440,8 +440,6 @@ static int mcp47feb02_write_to_eeprom(struct mcp47feb02_data *data, unsigned int
 	 * Wait until the currently occurring EEPROM Write Cycle is completed.
 	 * Only serial commands to the volatile memory are allowed.
 	 */
-	guard(mutex)(&data->lock);
-
 	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR,
 				       eewa_val,
 				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
@@ -467,6 +465,8 @@ static ssize_t store_eeprom_store(struct device *dev, struct device_attribute *a
 	if (!state)
 		return len;
 
+	guard(mutex)(&data->lock);
+
 	/*
 	 * Verify DAC Wiper and DAC Configuration are unlocked. If both are disabled,
 	 * writing to EEPROM is available.

-- 
2.43.0

