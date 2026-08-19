Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A22DA74C;
	Wed, 19 Aug 2026 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143280; cv=none; b=IyZigDvVwg9ZAY9GVKAEcDcZS+fddDgGftk5APyRgB9ev0ZCQdg0JQBPM7rlk8yDvfAY2oLC/WFoEwDm3x7/LNa4bVN1o7Pq2Y8Ce0XjWIUPzRrUR5xn+03+VNNoqCsxhqZ2xFYde27PKHrjwhytIofco0NI4/hQHzbSApIX7hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143280; c=relaxed/simple;
	bh=s7Pd3ibmbenbGpv6jMS5wEIN6apeaPZlFOw7/5U9qmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=omlwnJtBgsZo7ped8rk8KU/J/bjKNUS+rbvKh2kumfoxaCtdxFsfA2GfssGuwQJkuL/PpA54gQjlJmPx0FCrt9QYPJy9Dy+FnwZPPEKYK71mwHRlgJDNADQQ0/jdvgoL0eE5qUEBZJQV0eLrgoF8uqPyDP7u9FsdHfxW/DGO2cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fIaSgoPQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fIaSgoPQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787143278; x=1818679278;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=s7Pd3ibmbenbGpv6jMS5wEIN6apeaPZlFOw7/5U9qmE=;
  b=fIaSgoPQoe59wxr3tvje6fp7Jk6AqwGn5fScM7fyihU81gh8wY4WjLSi
   DqyYeXSp0u2HLY2prcWW1edal39yjxjDSx6AVG/94ug6rHEt6G7s3Nzeu
   4rPwWslbiOkexNvIo+IvqCZbleNSS5/Irx1HCmA4IoE3FHveTHml4fA8t
   CK6fZRz6F2g7Dr3ZF8bocRoH/tRz8U5tssSN+wNRDAuBQTVje/FUBeO6Y
   27Ia5aVd4HEHflVfKRNq9Q+uVuqmoi31PV2VzrrWtUuEa81YkRVDp7Ux0
   02030wA0+ZJX7P1HqI49dZgOZtAcxWziXJTL2jyjvwWKdavdyDp5vXdMb
   A==;
X-CSE-ConnectionGUID: R1m1VVRUQdeJ49iLI+a77w==
X-CSE-MsgGUID: A0D0Pt+SSf2yJ9mcn3eq5Q==
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="229490025"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 05:41:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 19 Aug 2026 05:41:17 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 19 Aug 2026 05:41:15 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 19 Aug 2026 15:41:06 +0300
Subject: [PATCH v4 2/9] iio: dac: mcp47feb02: correct gain bitshift at
 probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260819-mcp47feb02_refactor-v4-2-beb2aa3bfd09@microchip.com>
References: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
In-Reply-To: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787143269; l=1321;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=s7Pd3ibmbenbGpv6jMS5wEIN6apeaPZlFOw7/5U9qmE=;
 b=tCjxqZAHvX0lTfSbxZlUcgGQz9vCF7hyk2sd56hcNw2vWNFZxSQy30NF2+9P0hh5j6dus8w/i
 vmOyiVT/ji0CdgL6tVqPvotoOOFqqBHa+mjIwDd66XcjMy5cqXwu8wA
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Correct the formula for initializing gain struct field for each channel
with the correct bits from Gain Register.

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

