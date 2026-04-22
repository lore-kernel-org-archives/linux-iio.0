Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26BD2DA76C;
	Wed, 22 Apr 2026 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776859028; cv=none; b=DaDmkv3KEueDAATpKo0FMfUsnhKjVrFU3u3gpA/1ewfLxoVpT+xWyiNuEj/Bn86eFGWqVFCU7CcaWpxJJoIWKzTxUAe9vLG6GSjSvblrl6/o3O1iSYTnG1+HEENJ9KWW5/Rg6SjIKeyc5ZVVGB72pTv5hMDtIA2c5jYVv9czoys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776859028; c=relaxed/simple;
	bh=Hb3CUw8MQROEeqK2BSxwMmOlmLrbbi+1eGSjejU2Gfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=TRwvVjB1GAJWvUYCI6StsKmgXfOrVPMMNzSe4fHFS40XCB2Vs5ueq/E3yQ8D5FI5uIeULHHEPuama5Eei326OolCADRJUBHZlZ7UJ+YO3/UcEwG9OJ+gdxwwYwcX6i7TKMWHUoDbUOgkyZIxi7k/qISzv2GZoTsr+FF52Sz9uyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xoZocyB+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xoZocyB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1776859025; x=1808395025;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=Hb3CUw8MQROEeqK2BSxwMmOlmLrbbi+1eGSjejU2Gfo=;
  b=xoZocyB+bMjhrWUdKlO7UkNXkP4bZHIgms0UTNfQ07Wjuo99Fvr2eSjK
   vAAfnAuiRr/8v7D8k5J+AiPC4sPCisUjFsSC2Sw/y0KaNTMnSxd6fslRO
   9fXUP5DS01QiWmt+TtiPSUbwjRmgsWTkQn245utKLL6MfmOCZyHh8l5f+
   q5lQ30UIzHgwDcbXnEH305Tr6n0LJVJ2eiQafLUDkF5Qp+EiaFK3zjg/+
   lEo1p44JEcu+gm7hm76cgfkTqSTIHarmQtjnmoWpv/yYbtcE5A3qFBs5f
   Fu7uRPrtKajn0mp8TDwzkvAJJK/KeSIJfH5jHg9Mq1QdP2hYZzbPXemzP
   Q==;
X-CSE-ConnectionGUID: +YVSb0Q1S2y65/P8aia42g==
X-CSE-MsgGUID: 80srygWZRVe6ojOCAvxmCA==
X-IronPort-AV: E=Sophos;i="6.23,192,1770620400"; 
   d="scan'208";a="223710892"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 04:57:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 22 Apr 2026 04:57:05 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 22 Apr 2026 04:57:02 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Wed, 22 Apr 2026 14:56:59 +0300
Subject: [PATCH v2] dt-bindings: iio: dac: mcp47feb02: Fix I2C address in
 example
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260422-mcp47feb02-fix6-v2-1-4ca4d5cfab07@microchip.com>
X-B4-Tracking: v=1; b=H4sIAIq36GkC/2WNQQ7CIBBFr9LMWgxDkKKr3sN00cLUzoLSgCGap
 ncXG3cu30v++xtkSkwZbs0GiQpnjksFdWrAzcPyIMG+MiipjNTYiuBW3U40SiUmfhkxemOu2lv
 dXiTU1Zqo+qN47yvPnJ8xvY+Dgl/7ayn51yooUAyEVtqJBkTfBXYpupnXs4sB+n3fP74F3N+yA
 AAA
X-Change-ID: 20260417-mcp47feb02-fix6-bd6694d84750
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ariana Lazar
	<ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776859021; l=1341;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=Hb3CUw8MQROEeqK2BSxwMmOlmLrbbi+1eGSjejU2Gfo=;
 b=TzE7OI1f0ywbSxOeOQpT+Op9HlJZQLzJ6/cZyJO2T1mLWTap2vNyqtLct52QrqtHlspr/LcnO
 /yGJd9gRL+5BCQ77aHSQf05tfLZQJlpWzS80sNEmxJG98tAdSvtuNtw
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Change example reg value from 0 to 0x60 in order to use a valid I2C address

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
Changes in v2:
- drop fixes from commit message
- keep just the address fix
- Link to v1: https://lore.kernel.org/r/20260420-mcp47feb02-fix6-v1-1-ae1808fea11d@microchip.com
---
 Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
index d2466aa6bda2106a8b695347a0edf38462294d03..350e80e4dbe05dd10e3c6fb00f74d58c56c54bc8 100644
--- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
@@ -280,9 +280,9 @@ examples:
 
         #address-cells = <1>;
         #size-cells = <0>;
-        dac@0 {
+        dac@60 {
           compatible = "microchip,mcp47feb02";
-          reg = <0>;
+          reg = <0x60>;
           vdd-supply = <&vdac_vdd>;
           vref-supply = <&vref_reg>;
 

---
base-commit: d2a4ec19d2a2e54c23b5180e939994d3da4a6b91
change-id: 20260417-mcp47feb02-fix6-bd6694d84750

Best regards,
-- 
Ariana Lazar <ariana.lazar@microchip.com>

