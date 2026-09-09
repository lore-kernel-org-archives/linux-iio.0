Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CA58F078;
	Wed,  9 Sep 2026 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963543; cv=none; b=l79MFUUSF2fG5AMlGbcPXJgmuN1smDToE+AZ/oOuXtxBJjUcD0ZO+WTxl7988hiGYOZ///HeKRAuisPbbm2VsHObtOK/0R9+eKm1bmfso4jyF/spuFlLnJdqnYn685laB0/WFi+MWUnmOKXb36dPegeUdyqpoEvmbzGmzq3rpnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963543; c=relaxed/simple;
	bh=M7VBk8FIgPIaUB2lPOsLSGOKSeEmxwO9WNXNNKgjIKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ViYfsYuQxzt6FQrjR5sP6gLiDkHS8GC/+FoylViA54afyf/0ig5kvDBEzLXzolgHgB4N/iGY+83bwRuddhfsiyNIgJtxL8aXtdL5QXMPjeHYq61RUBnKBbsw9dO4fXpASVmTuRIxIeKfUyqHzDOM5SWe4HxEPh38Ul/p0yJqPMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TDYh2FvX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TDYh2FvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788963542; x=1820499542;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=M7VBk8FIgPIaUB2lPOsLSGOKSeEmxwO9WNXNNKgjIKc=;
  b=TDYh2FvXCHlxzX8bFQp8yjl+V9z+3JEIN/ozrr4FwU67t2pSvJ6Zn6vb
   RnJMn2JOSarPC1Kl2h/w/oVxzTrmRkl41Ir9+Mopk2P6D7R91zCsjsALl
   fEBh0g8XM2/98e2hXyjrVjNmQJFrkEmGIuLfWCq3RmBEvH1PCRngSXfj1
   8qFV0MsvKgd4pxoPqvKK/bFpfAZ8cN5sQwowJHhDRVjJYi3vaWG1rSRSJ
   ZGgbEndxZgUWMowV8kcfXXy2RwMlLlVAxOeVIbA0jMmDUbAnSSJDsb3Ff
   ZIimYlpej/QVeA3tLAXrdRhGOvpiCBNZIT7eGNiPPJj4EYI17mZ5HixsA
   w==;
X-CSE-ConnectionGUID: minjwViPSTGXzdRrBf5YQg==
X-CSE-MsgGUID: rfK2DfniTb27EOpkFR41XQ==
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="294763994"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2026 07:19:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 9 Sep 2026 07:19:01 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 9 Sep 2026 07:18:58 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 9 Sep 2026 17:18:46 +0300
Subject: [PATCH v5 03/10] iio: dac: mcp47feb02: Return len when disabling
 EEPROM store
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-mcp47feb02_refactor-v5-3-8b67bcab93d1@microchip.com>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
In-Reply-To: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788963530; l=851;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=M7VBk8FIgPIaUB2lPOsLSGOKSeEmxwO9WNXNNKgjIKc=;
 b=Kjg0BbDpOReFT9J9Btd2AqtrBKFdzunjWaE//SVci86Lyqr5FqS0It98wGblVR1DG20i82GoJ
 1PPABC4NeTQDel6CpPbZlZYHoBiRugetnEmtOoSaUip0d8t0jGgs2RP
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

When state is false, return the number of bytes (len) the buffer has
instead of 0 to properly signal that the input buffer was fully consumed,
preventing unnecessary write retries.

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

