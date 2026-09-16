Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E64503BF4;
	Wed, 16 Sep 2026 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568383; cv=none; b=gNVppUm1z4Vr4wdQOxfi44mqZpxRfH70hB2eYzNF/hoEwcDy6kC4STN1n7Lt4asnK4s7BKcXzmxZClSM6UyH7D3vLvhr4aviOVuNXLCW/Z28Mh1NsTrNbTdfdGZskEeP+mWQEh/43zAYmZjZ/dudiq8jPDq4yXqbrNDfXf4gHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568383; c=relaxed/simple;
	bh=Sw1zqZvbLm0kZi6yuHbFjMrsBWYZAkfQUPrgGT+a98c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=W3khDrQ90eSLS+ARJ39yPe6D32y97EWpMe99dMTG0kvT60ZPrwS10z+Cnd3qlr76fB83cVuAmjxnICdhcLWNgRPO5/OYE9EdeW8UGt0iHSvgMn8T6Y6NZVah5tK0LEvXfAwT65knxTvx6rf7nd4/DkYwRLtTe4IO0ujDKnG1Fqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oURNRpw7; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oURNRpw7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789568382; x=1821104382;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Sw1zqZvbLm0kZi6yuHbFjMrsBWYZAkfQUPrgGT+a98c=;
  b=oURNRpw72EIeOrArM25qEeyl4nKv/KV96Z14zHDrrYsCkd4eK+GJiCZI
   KSy7XNr9CrzQxL5HJz4g7YbQRT4M6OxsjOsS/HsS9n58WyjcYG3LDhDkZ
   UWvEcw7eGncT4C+HnSS9pPo5IoSrGNsci1BAl+ZI1yb7bxeGq6lSgR209
   FuUHl27RsUEScPkpxRVxwlIsqwh49RK5BjC0GUDudQGLkK28I1LRtS3x2
   JTGeT01Ow9y8EFSSgDlPfHzI3VPjdbwYIzx8iiR3czn4YazKHNgtmsW9a
   usUsJamrDigkZuyqjkLmoNE9TZ3cE/kRti3S3yzRajNX/GYEwH3gqiBT8
   Q==;
X-CSE-ConnectionGUID: 8t6vyIQuRfWtCTVJFMoV+Q==
X-CSE-MsgGUID: NaZ5rvWuSdmJyG9pPnaSIw==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="64005076"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 07:19:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Wed, 16 Sep 2026 07:19:19 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 16 Sep 2026 07:19:16 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 16 Sep 2026 17:16:33 +0300
Subject: [PATCH v6 07/11] iio: dac: mcp47feb02: correct typo from a comment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-mcp47feb02_refactor-v6-7-285464651f89@microchip.com>
References: <20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com>
In-Reply-To: <20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789568335; l=1004;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=Sw1zqZvbLm0kZi6yuHbFjMrsBWYZAkfQUPrgGT+a98c=;
 b=wxAKFlx8xbVfTv2sK2uhA/SxBvmGPF6C5krjPOGidbms3DcYOcmuRTiXoMZX/qtxOJ585VV2E
 pEBpu03ou0uCWrfknxdiQf8duY2zy7M2WE+5UzxnOtDocZ+8h+60A1J
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Typo corrected to 'Register' in the comment regarding defined masks for the
gain register.

Reported-by: Joshua Crofts <joshua.crofts1@gmail.com>
Link: https://lore.kernel.org/all/20260723231859.03f92ce6@systembl0wer/
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 67bf8d9d9835095263b2ca6b710acca60612354a..8dac4e2fb74fe4563324343ce215af3389129130 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -52,7 +52,7 @@
 #define DAC_CTRL_MASK(ch)				(GENMASK(1, 0) << (2 * (ch)))
 #define DAC_CTRL_VAL(ch, val)				((val) << (2 * (ch)))
 
-/* Gain Control and I2C Slave Address Reguster fields */
+/* Gain Control and I2C Slave Address Register fields */
 #define DAC_GAIN_MASK(ch)				(BIT(0) << (8 + (ch)))
 #define DAC_GAIN_VAL(ch, val)				((val) << (8 + (ch)))
 

-- 
2.43.0

