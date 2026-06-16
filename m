Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C2364E84;
	Tue, 16 Jun 2026 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619341; cv=none; b=mPiKCh6zXZFrunp7XbCv3AgGb7W3FKzhqnuhAe1AuNuhLpr864ccAf4Z5p1m46R4vxb2IVZZ5JPna3r8Z0hrgZ4C19WibGfOaNgWCtZ7KiCOD4RE79Brb8dnj9/HUoWybsTePslkDPiCIy6laOIOkefUFly71cyEaRh3dQwHbKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619341; c=relaxed/simple;
	bh=JkxsaiEvujPkkGUhE4OTVgQ44CsZzip0zlLaYTYsuJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7aNzfwT1Gpu13j9RAWYen47fepbBoYlRNRKlvUSggjf9q8dH7EqeN0S50dE/hvm3Xcqfs7IkzuRuA14mbb3X0DvPFsq9pbK+rGr7ees1hZDBMvpgJjcWFO8MavW/lVVIzF3D0pi72vHhJFfujNgmaGmBffs9IrRwWweuMxdvJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEaxQ/r3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEaxQ/r3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F651C4AF14;
	Tue, 16 Jun 2026 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781619341;
	bh=JkxsaiEvujPkkGUhE4OTVgQ44CsZzip0zlLaYTYsuJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QEaxQ/r36g9itZlBtbPNgzSCY9iglx3rMdMJ5YRX8NJjw3o2m6bRrVr7ODZFVaNT8
	 7hy2aKTFXc6qxZbnHQu2eTjP0MeiFf3KRK8jNVXhHuKGTcNFSzHxeYtEkafW6V9UbB
	 3YUbbWpr1ImnRAWfVqRGsOZcGq1rGVpLNxjCo7wpY2dxggpgI3KHgK9muYWC9gWuXe
	 dWZZxNkFQkYv5WFS4CggZxoqcNm+ffwa607lDsZTqmPyNbwlD8pAjXeuc2GyWwucEk
	 dIJqdgIlSn+Uo4GcXXLVjSu/XS4G2PTnxSeCqVx00yvZ9Mie4fLSG3eIZuBpQkRoqN
	 VdYUFk3PlhLPA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D49CCD98E1;
	Tue, 16 Jun 2026 14:15:41 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 16 Jun 2026 17:15:39 +0300
Subject: [PATCH v3 1/4] dt-bindings: iio: adc: mediatek,mt6359-auxadc: add
 mt6323 PMIC AUXADC
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-mt6323-adc-v3-1-1c27c588185d@protonmail.com>
References: <20260616-mt6323-adc-v3-0-1c27c588185d@protonmail.com>
In-Reply-To: <20260616-mt6323-adc-v3-0-1c27c588185d@protonmail.com>
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
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781619339; l=3348;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=zBFr5LtLYCyJguPmw6s2IdXwml0/Lee5cxHZREaOdjQ=;
 b=oS21kLsovwzKWZleDvs3nzC07PsiH5FMn19eD9UHL+Em2/TVCgrz3C4l7t1FN3Ecxi2YMHpDd
 TodDOuTHdtjCFmYjFwwqIDy9mWOcuzK4YI/N+8pIdFj0vLmxAYgS9bQ
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

The MediaTek mt6323 PMIC includes an AUXADC used for battery voltage,
temperature, and other internal measurements. The IP block is not
register-compatible with mt6359 and should use a separate driver.

Add the devicetree binding documentation and the associated header file
defining the ADC channel constants.

Also change the description to 'MT6350 series and similar' because
the binding already includes more than mt635x series PMICs.

Finally, add the MAINTAINERS entry for the header with ADC constants.

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


