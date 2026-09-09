Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F9558F064;
	Wed,  9 Sep 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963538; cv=none; b=tS7Q/sgBdcZc4hgEcGPXEL9Ne1H5flPMAzmhjfyreoSjgKONFZsbOHuOztCxFWvpIb6PljD2dSSYh988WGHDF5mDCKOX6kay3Tu3BftLIxZlaZxMNBlXU8KXSlI2l/vLpwFOqVuoeX3lsYGRbSIZjr/Kqmbgo3Pgm5tTU6zkwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963538; c=relaxed/simple;
	bh=eDY/84fI9eAZWaZK0CBpq5Ugke+3c7uiIu2GomKkXNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=o24Sb6C5m7g+QPZAwKzn/KLLGpn+AJUMyiDr0o5RDXpQCBUnl+ZE0NXpFAgukK1l9ytdX2tTIxmqwX0V6uQKC+BgKvLdpEywD63D6TLNkiCy9gKls4zXtctdsnxPdukEj0YB2sMPKR3xkRDMOlndqjaOIJcDREvKC+/8GPXc+yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Tl4muBXN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Tl4muBXN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788963536; x=1820499536;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=eDY/84fI9eAZWaZK0CBpq5Ugke+3c7uiIu2GomKkXNY=;
  b=Tl4muBXN+KwvwcxMSHY/m07KibhYRpkmlvnXZti4sdeQ3zlq8INV9PJU
   yUz1SOUCo8odplwOG4j7LnluIPfIjKeH8hCnvDD9VLDJXXHhpbgbG3WD7
   LT3Y1slDUDwxwF4XuVk75f/v/Ti7odKav6Yrd2DrI2VlSaJKoQXj45QEJ
   rK+/1x5P8+zCd4It+3twRpUeEeYScaPBRIpttUsWNiN0+ZUdnAWvuK7fa
   i5XbH3VEmxtTjJ0+nWbEAtW9qNNrhBg4Ydwzn++PqGOsx2Dnlr7fA+j3G
   waPaMgu3tyFvMWjwKaBb8rPVfnR6Bn2CQNQ22qF3BUPR1G0OwU++esItH
   g==;
X-CSE-ConnectionGUID: TO8dTwVXQf6DsVxWun5fMg==
X-CSE-MsgGUID: vW5HHvqATk6Ndqse01TJtg==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="73313016"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2026 07:18:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 9 Sep 2026 07:18:55 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 9 Sep 2026 07:18:53 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 9 Sep 2026 17:18:44 +0300
Subject: [PATCH v5 01/10] iio: dac: mcp47feb02: initialize dac_data field
 in channel data struct at probe
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-mcp47feb02_refactor-v5-1-8b67bcab93d1@microchip.com>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
In-Reply-To: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788963530; l=1234;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=eDY/84fI9eAZWaZK0CBpq5Ugke+3c7uiIu2GomKkXNY=;
 b=e3nfkzO5LxVkhU1DChWZlpm+BL7PbC9z3MY2JPbYH4uXIsP/w/SYJ0dx+x2mT79pn+7a034cS
 j0i72xq6BCPDQonYlcP+OZ/IQqBpJXsWUXJzLu2BmsAAUJyw9jCl6HJ
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Prevent operations which use cache from overwriting default hardware values
with zeros by reading active DAC registers during probe to correctly
initialize the channel struct DAC values.

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

