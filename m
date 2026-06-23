Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EACC3CD8B0;
	Tue, 23 Jun 2026 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202666; cv=none; b=CxaIeInc6LoyqRKXb1fKH0X0xEJuwE3eqD6uOHdP/qeyqDHH9OjUhfGnsUNBjmiQQOlpX89azQzHZZug/Bzg1V/pNueyY+hmPUXwWPQgjN8cTdivkS9a9rZHtkRwXbo/kbuDY3KawvSlQDbZ3GOAPWG9BgQ01xr9gJTKgeiqW7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202666; c=relaxed/simple;
	bh=Qe81J/cevkK26Dz694jCwpIGKBZxPVMliuJAaoVkKnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujXmL3jInqLJJAD0RfBnjhBMpMQm4OAui/jmqlLJpmO8lVPLsbXJm81nAt7+p5mHfaOGQcj/w5MSalgsLBY8AtKPVts3Ed0V9DoucC0FZuNrdOyAVYjxULDW/TkGyKtnfSIn4MJDl2zRqCgyeZXHicoBg6vZd/7TiF5QQmMhJnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2Mma0xG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2Mma0xG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B52CAC2BCB8;
	Tue, 23 Jun 2026 08:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782202665;
	bh=Qe81J/cevkK26Dz694jCwpIGKBZxPVMliuJAaoVkKnc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=N2Mma0xG4/x51WkhqTZH5lLvQ+oe/ripCPEQwQg2Seik9C0iz/qYmy33yd6tdht+8
	 WPfJ9MWNrJ9kURDCql9TtB93qedO52bjhnT6LEWeNfOETHJV3OtmB4UgAY4eUekiwx
	 ovwdqJsK1XskwxBwxKB5JNLtyKKmEDyAdnrz2r1jCg0DDuH6XOzsh1u/EUupTaI1i1
	 +Ywok10em6yu7bPkUv3lgqtPJjkv89yUBgHBtQX2wpZYHD7N3h+mjxRCssHfrUiXJr
	 Sr6xpLP7vC4usC/hMCjY9bPBxCqBnUaaaI7IDaQT+9DlGbCWGwoN3Zs6E4LInjlvwl
	 naiKS3VaJWWPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8B3CDB470;
	Tue, 23 Jun 2026 08:17:45 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 23 Jun 2026 11:16:13 +0300
Subject: [PATCH v4 1/4] dt-bindings: iio: adc: mediatek,mt6359-auxadc: add
 mt6323 PMIC AUXADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-mt6323-adc-v4-1-299680ad3194@protonmail.com>
References: <20260623-mt6323-adc-v4-0-299680ad3194@protonmail.com>
In-Reply-To: <20260623-mt6323-adc-v4-0-299680ad3194@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>, 
 Roman Vivchar <rva333@protonmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782202663; l=3368;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=vvdf2O746IbyxaPq2mjORL0t/DR/AAd/jRMGrzxWW0o=;
 b=+wWP/AwLD663p4z7QloaoBwNAG0RWg1oRLhgTjjkMF6qOfPPyq9m7pMo9XXQ/SKYKyEj/oFxY
 IaVnkIgI94pDPPzExl3zIZYl+cl/OoqYEBJZx3PXecRRXpBEP+GUhZH
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

The MediaTek mt6323 PMIC includes an AUXADC used for battery voltage,
temperature, and other internal measurements. The IP block is not
register-compatible with mt6359.

Add the devicetree binding documentation and the associated header file
defining the ADC channel constants.

Also change the description to 'MT6350 series and similar' because
the binding already includes more than mt635x series PMICs.

Finally, add the MAINTAINERS entry for the header with ADC constants.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |  3 ++-
 MAINTAINERS                                        |  6 ++++++
 .../dt-bindings/iio/adc/mediatek,mt6323-auxadc.h   | 24 ++++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
index 5d4ab701f51a..852eb7336a5a 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: MediaTek MT6350 series PMIC AUXADC
+title: MediaTek MT6350 series and similar PMIC AUXADC
 
 maintainers:
   - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
@@ -19,6 +19,7 @@ description:
 properties:
   compatible:
     enum:
+      - mediatek,mt6323-auxadc
       - mediatek,mt6357-auxadc
       - mediatek,mt6358-auxadc
       - mediatek,mt6359-auxadc
diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f..2551c8cd9e9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16256,6 +16256,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mmc/mtk-sd.yaml
 F:	drivers/mmc/host/mtk-sd.c
 
+MEDIATEK MT6323 PMIC AUXADC DRIVER
+M:	Roman Vivchar <rva333@protonmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h
+
 MEDIATEK MT6735 CLOCK & RESET DRIVERS
 M:	Yassine Oudjana <y.oudjana@protonmail.com>
 L:	linux-clk@vger.kernel.org
diff --git a/include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h b/include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h
new file mode 100644
index 000000000000..6ee9a9ecffc1
--- /dev/null
+++ b/include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_MEDIATEK_MT6323_AUXADC_H
+#define _DT_BINDINGS_MEDIATEK_MT6323_AUXADC_H
+
+#define MT6323_AUXADC_BATON2		0
+#define MT6323_AUXADC_CH6		1
+#define MT6323_AUXADC_BAT_TEMP		2
+#define MT6323_AUXADC_CHIP_TEMP		3
+#define MT6323_AUXADC_VCDT		4
+#define MT6323_AUXADC_BATON1		5
+#define MT6323_AUXADC_ISENSE		6
+#define MT6323_AUXADC_BATSNS		7
+#define MT6323_AUXADC_ACCDET		8
+#define MT6323_AUXADC_AUDIO0		9
+#define MT6323_AUXADC_AUDIO1		10
+#define MT6323_AUXADC_AUDIO2		11
+#define MT6323_AUXADC_AUDIO3		12
+#define MT6323_AUXADC_AUDIO4		13
+#define MT6323_AUXADC_AUDIO5		14
+#define MT6323_AUXADC_AUDIO6		15
+#define MT6323_AUXADC_AUDIO7		16
+
+#endif

-- 
2.54.0


