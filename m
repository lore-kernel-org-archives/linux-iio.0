Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D445908D0;
	Wed,  9 Sep 2026 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963552; cv=none; b=tSlg18vQ/xSLUUD+2g9ielbSO46zVAdUFCDrUHPBmrK/qr9YCG96EiQf+QT9YRP2wHYroTMc/WwVpEI9GMZveOHEh+QN531/iZzOScS98NtlTBfvr2tHCx/cmZN1Yej7RL/zU6Js0LbnEM9q7KiJsstxhEnmJdav7UBpryDWae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963552; c=relaxed/simple;
	bh=oiznMy8aoeU95dffZz7LDvWNXxD0Wybpp4fi4FteqeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=sBgaoEXVsGw2fCnM+CH4nEtDKAvIH33NmM+B6Z4bHN0bUU+Zawzf+lpbxt3Xk8egIA2+Ne/nDf3y3n5SMrLOuLXkkpx3qAZQ0DX6H8/Ryq9nGNIs0TmRkkzK0JQmpH1sKttDxpFeDC4wD3Hea/kt/8AM1kyKO1MY+E1ARtUgyIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Nfie1z5S; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Nfie1z5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788963551; x=1820499551;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=oiznMy8aoeU95dffZz7LDvWNXxD0Wybpp4fi4FteqeQ=;
  b=Nfie1z5SKvJ/BzPax/MKPtEpV53rL77C6BCCO5yaHuyGV3E/jUmQ6Dtg
   tTVeMb8i3tRUrz1vbdABZKuZVeBPE1LIuMlOPBsmI7oitOYtXF691JhpS
   bejyWCtEWdrybCjSq4TtUaRmRBVCgsLmwAvD7EflH667YxOItysa2xc75
   2w27dYy9p18Rv2QIt2KWfpsfOUB/EHRpdkgnzMhkJLry0oS8b+NrJcMsY
   8vVOidAtMjTK8owKdWR0Wifb2zmHtHNV/EF3zWKYadr4K/Kc5kxNrokmT
   7lYCIDBh3HP4I1NDz/a9ij7SLgp5BBxT7+KX0m/4yFMqsV6XB8lXXUqfi
   A==;
X-CSE-ConnectionGUID: F+eHJkAoSLeA7fo8OI0INg==
X-CSE-MsgGUID: ws2lpKp1RXGqn6wgv+ED3g==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="294764005"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2026 07:19:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 9 Sep 2026 07:19:09 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 9 Sep 2026 07:19:07 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 9 Sep 2026 17:18:49 +0300
Subject: [PATCH v5 06/10] iio: dac: mcp47feb02: correct typo from a comment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-mcp47feb02_refactor-v5-6-8b67bcab93d1@microchip.com>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
In-Reply-To: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788963530; l=876;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=oiznMy8aoeU95dffZz7LDvWNXxD0Wybpp4fi4FteqeQ=;
 b=GBq1oC9FqXbIcyIFzQOC/BoEZBranVA+pj0yMQgQAMRKbSn4ZDF7F5Zu/nM8LfYYywOt1QpAj
 5ia9YqYZVgHBp0m9QbBM1nes/EcWRyOZQWpLk3o7bJjjb6PSu6J3zBG
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Typo corrected to 'Register' in the comment regarding defined masks for the
gain register.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 6353aabfe252e322a4f0d0efe20673f7e733a7f2..c054711a55ca01be9e0aba57a2ddbf192406fd47 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -53,7 +53,7 @@
 #define DAC_CTRL_MASK(ch)				(GENMASK(1, 0) << (2 * (ch)))
 #define DAC_CTRL_VAL(ch, val)				((val) << (2 * (ch)))
 
-/* Gain Control and I2C Slave Address Reguster fields */
+/* Gain Control and I2C Slave Address Register fields */
 #define DAC_GAIN_MASK(ch)				(BIT(0) << (8 + (ch)))
 #define DAC_GAIN_VAL(ch, val)				((val) << (8 + (ch)))
 

-- 
2.43.0

