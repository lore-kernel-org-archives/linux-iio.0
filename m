Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419CE3DBD4A;
	Fri, 10 Apr 2026 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839024; cv=none; b=Wy/eLJ/iAes8WosVAWcmtir/vHitUdnUctjLoSkLt9IZwz8pBniHWz8NNxX9WKHnXhgmKt25AviO7V6HvM+A5ScRinXMnAqGiSHlHjrqPzfpPKsVhZqgBWrjY7UTyyPEfWcIO5/iIXrp//HVQte0LvXlk4aeIMtqQyy+2h2mPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839024; c=relaxed/simple;
	bh=lND7+Ko6/xSjPeJmVQs1K896n6GjQ6xaIs0nD+9LWlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNjRol6eQZf2VPIdk6U77retfu2VBj3svzVl3Xzcgg9ixH38VES1hf4KbEzpep9ZHFHzvAehXVvUvqy4P7pHEISpwvof8HkaD7qilytnafasMAdt6cBAaNLRWNvlM4ash++MwcJZCEOfHs5G/Skjq8Jn56TSTOlLQbLNX+G4VFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: 6d0yxHSNTaO5FT4CTGfDKg==
X-CSE-MsgGUID: su6gJoTAS9KNgLzbUyo4Kg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Apr 2026 01:37:01 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.85])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9E978400CD4C;
	Sat, 11 Apr 2026 01:36:56 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 06/10] dt-bindings: timer: renesas,rz-mtu3: remove TCIU8 interrupt
Date: Fri, 10 Apr 2026 19:35:26 +0300
Message-ID: <20260410163530.383818-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410163530.383818-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260410163530.383818-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TCIU8 interrupt used to be documented in earlier revisions of the
user manuals, but has since been removed. The corresponding entry is now
marked as reserved in the interrupt mapping tables of all supported
SoCs.

 * Page 486, Table 8.2 Interrupt mapping (7/13) in the Renesas RZ/G2UL
   Rev.1.40 User Manual
 * Page 363, Table 8.2 Interrupt Mapping (6/13) in the Renesas RZ/Five
   Rev.1.30 User Manual
 * Page 528, Table 8.2 Interrupt mapping (7/13) in the Renesas RZ/G2L
   and RZ/G2LC Rev.1.50 User Manual
 * Page 540, Table 8.2 Interrupt mapping (7/13) in the Renesas RZ/V2L
   Rev.1.50 User Manual

Remove the TCIU8 interrupt.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * reword to mention that TCIU8 used to exist

 .../devicetree/bindings/timer/renesas,rz-mtu3.yaml         | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
index 3ad10c5b66ba5..00cd5cbcf6e9b 100644
--- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
@@ -162,7 +162,6 @@ properties:
       - description: MTU8.TGRC input capture/compare match
       - description: MTU8.TGRD input capture/compare match
       - description: MTU8.TCNT overflow
-      - description: MTU8.TCNT underflow
 
   interrupt-names:
     items:
@@ -209,7 +208,6 @@ properties:
       - const: tgic8
       - const: tgid8
       - const: tciv8
-      - const: tciu8
 
   clocks:
     maxItems: 1
@@ -287,8 +285,7 @@ examples:
                    <GIC_SPI 209 IRQ_TYPE_EDGE_RISING>,
                    <GIC_SPI 210 IRQ_TYPE_EDGE_RISING>,
                    <GIC_SPI 211 IRQ_TYPE_EDGE_RISING>,
-                   <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>,
-                   <GIC_SPI 213 IRQ_TYPE_EDGE_RISING>;
+                   <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>;
       interrupt-names = "tgia0", "tgib0", "tgic0", "tgid0", "tciv0", "tgie0",
                         "tgif0",
                         "tgia1", "tgib1", "tciv1", "tciu1",
@@ -298,7 +295,7 @@ examples:
                         "tgiu5", "tgiv5", "tgiw5",
                         "tgia6", "tgib6", "tgic6", "tgid6", "tciv6",
                         "tgia7", "tgib7", "tgic7", "tgid7", "tciv7",
-                        "tgia8", "tgib8", "tgic8", "tgid8", "tciv8", "tciu8";
+                        "tgia8", "tgib8", "tgic8", "tgid8", "tciv8";
       clocks = <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
       power-domains = <&cpg>;
       resets = <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
-- 
2.53.0
