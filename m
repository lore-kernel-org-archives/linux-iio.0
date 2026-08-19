Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885D30676C;
	Wed, 19 Aug 2026 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143283; cv=none; b=oOYz/pFjSZojY7HHKKLwoPPIpdTGyTpVFK8uI5t+QXft8JreW1CtXnaFba1qh6tiHHY7ghUxFqnDEFHaqMG0+1hUevV5yy2G9In5wYdOR6VSE3XvcAINS4j837dzQdbOaf7DttAIXCYY22MXDbL/sw/DOARnqsicwlMyUeRQ2Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143283; c=relaxed/simple;
	bh=wSyrSm1qTZF23G+IEE24scv/amKr0POTAbYk6U6GlSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=miRCU91R+ellP7JuPscSAG+fwWnGsOwBpBcrYyCeHvMV6ZbbRontIRzHVX6L9G/EhHsdFWUQh2xatmbs1SKLd/zXg54fOJhW+iVp9wB/nr3mnR4Gdr1f65iiIttwm0Eoy5uXtOTURupdYa5QZvMZkvhGbl0HqXOukbKNLEaCyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Buwid/QW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Buwid/QW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787143281; x=1818679281;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wSyrSm1qTZF23G+IEE24scv/amKr0POTAbYk6U6GlSg=;
  b=Buwid/QWYCXOtJW8yTWn00jnFXNZkxNlBWa8H7wr99YYZ+GRPdfYGMmt
   erW7+ew8rav8mAaAX5rSg8pzAfvyqCsu4zMOtjBoyUx7sbGhPTRJTKZp9
   T9BdozJvHAmyyjFVP5mfeQaEgnaXVsk5+AJ//fhWQItZ0J/OuwqkoIih0
   c2K5U5s5pnYfQisg+MxgEsTJg4qS32aZaXNoI75aRqRTGic4cAC+1NxtT
   FXNC7nI3Xdlmr1waIWFQlbxevf/LPDrWbVGjiDyeMV1CnZlfcJWlg2ICE
   8k5zyYD3XHjEQX1qTMhVrOf/iMddusPhpQsd88T325IITPz8RTmxKoAvj
   g==;
X-CSE-ConnectionGUID: Ic+YMBa3RsqlUV9fZ2+kYQ==
X-CSE-MsgGUID: SwgsmHUCR32eiw1sKIjcbQ==
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="62676114"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 05:41:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 19 Aug 2026 05:41:20 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 19 Aug 2026 05:41:18 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 19 Aug 2026 15:41:07 +0300
Subject: [PATCH v4 3/9] iio: dac: mcp47feb02: correct false state case in
 store_eeprom_store
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260819-mcp47feb02_refactor-v4-3-beb2aa3bfd09@microchip.com>
References: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
In-Reply-To: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787143269; l=722;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=wSyrSm1qTZF23G+IEE24scv/amKr0POTAbYk6U6GlSg=;
 b=VJlcvoP5f0f6R/1rEuqwnbRhv1VT1iAEREvxL6LcNL1v48srtOtfuyKCCusBDDbsgiUmvNUXF
 kNU+ar+Uf1zCkbkmQuzZ2llYalk9kxGlvEryO0yQ+i49UIJNyo0SRkk
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Return len also when the state is false instead of 0.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index bf78618ac2c896b94e494a1ce76ef5b3e520f482..2ee981393aa1a2dc0bf65d25ab937132fe2e7bf1 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -469,7 +469,7 @@ static ssize_t store_eeprom_store(struct device *dev, struct device_attribute *a
 		return ret;
 
 	if (!state)
-		return 0;
+		return len;
 
 	/*
 	 * Verify DAC Wiper and DAC Configuration are unlocked. If both are disabled,

-- 
2.43.0

