Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306EC35CB6C;
	Fri, 27 Mar 2026 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639559; cv=none; b=Dyagk44axwGPOB0HjbDEeDILXU2YkmJuPTYfHlSu4rp0lUzMjaiqJQ2Wy1WrMSWBwt3R9Z477bzoF9+LzaxxuB2G4VlT8v752sv+Vv35nWtk/knIleQzaT1J7DfWlT8RvW/yGTN7rFU2LjBEN4W7pn78C8EqYA4rzlXE7o2piRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639559; c=relaxed/simple;
	bh=xboUAr2giWyp9+lNRDdQ5q0LnlbLQPnBA4Hp6T5HcM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2SoQU5qH0DBIE+NA68mU4ATkvORbbnWxNNgbaMJSxX8AhnUCfixblebZW+9QsTQqRxqlAa0fMaQesLvlC+u/zrDSpwdAzZeyOamPc/7rNi/R5BP+V+T1pyR9Ba2C1Ry9Z0YAVUXHnugv5OGAhNxRMiS4BuymKoiYklX/Sp0W9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: DcLyOvSOQJak2FLy4MX7Fw==
X-CSE-MsgGUID: B2bUeeZTRimxsS3SFt/72Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Mar 2026 04:25:56 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.36])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B42B54015D70;
	Sat, 28 Mar 2026 04:25:51 +0900 (JST)
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
Subject: [PATCH 06/11] dt-bindings: timer: renesas,rz-mtu3: remove TCIU8 interrupt
Date: Fri, 27 Mar 2026 21:24:20 +0200
Message-ID: <20260327192425.438263-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327192425.438263-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260327192425.438263-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on the following pages in the User Manuals, the MTU3 block does
not have a TCIU8 interrupt, only a TCIV8 interrupt, as the row where
TCIU8 should have been is marked as reserved, and the GIC SPI numbers
stop at 212.

 * Page 486, Table 8.2 Interrupt mapping (7/13) in the Renesas RZ/G2UL
   Rev.1.40 User Manual
 * Page 363, Table 8.2 Interrupt Mapping (6/13) in the Renesas RZ/Five
   Rev.1.30 User Manual
 * Page 528, Table 8.2 Interrupt mapping (7/13) in the Renesas RZ/G2L
   and RZ/G2LC Rev.1.50 User Manual
 * Page 540, Table 8.2 Interrupt mapping (7/13) in the Renesas RZ/V2L
   Rev.1.50 User Manual

Remove the TCIU8 interrupt.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 .../devicetree/bindings/timer/renesas,rz-mtu3.yaml         | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
index 3ad10c5b66ba..00cd5cbcf6e9 100644
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

