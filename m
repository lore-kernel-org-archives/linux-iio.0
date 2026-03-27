Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A5E3750B9;
	Fri, 27 Mar 2026 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639591; cv=none; b=Q8o5ENW3qIVZ2ADq8FbY06noZiY72MJgzVv1wHA5POafYilCMeyiAeHwS+Ja96X0+RRta/NcZ7I+yFIOlnxBjN2NQUJNIWXXXzgQ9lFuw/1yUWEbrTB0QB2ZtBcmtzOeN1bBQlBb8tKW5TDOOWM4QVh7X5qOSO9fTHS+urKzlYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639591; c=relaxed/simple;
	bh=Ot80DxInnW1eLVVpqx2PX5Nm7DsJGE/xGpXm42N7vTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnaN3VA+KGZVL2ToW646F2u2+fSuKTqoRglH5iQu3DOaLCn4KDENi0iDhl4B/kxk9pIk52oJ5LJjIIs7/bGVU3xIdlfS74VPcuGFUplHCO5UCpMj/31nxQMOps4dgVkAi8E9HEOe2bHzmzJ80lEGVQ8voE9bp6u2WdlnF1Q0JXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: ywSHoiNqQrWYgjG7Ei0IjQ==
X-CSE-MsgGUID: h5KLAy1AQl6rkWp7LV4lhQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Mar 2026 04:26:29 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.36])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D17C44014C3F;
	Sat, 28 Mar 2026 04:26:23 +0900 (JST)
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
Subject: [PATCH 11/11] arm64: dts: renesas: r9a09g087: add MTU3 support
Date: Fri, 27 Mar 2026 21:24:25 +0200
Message-ID: <20260327192425.438263-12-cosmin-gabriel.tanislav.xa@renesas.com>
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

The Renesas RZ/N2H (R9A09G087) SoC has an MTU3 block.

Add support for it.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index f697e9698ed3..c64b532f3d23 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -1119,6 +1119,74 @@ gic: interrupt-controller@83000000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
 
+		mtu3: timer@90001200 {
+			compatible = "renesas,r9a09g087-mtu3",
+				     "renesas,rz-mtu3";
+			reg = <0 0x90001200 0 0xb00>;
+			interrupts = <GIC_SPI 420 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 421 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 422 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 423 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 424 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 425 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 426 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 427 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 428 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 429 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 430 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 431 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 432 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 434 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 435 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 436 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 437 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 438 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 439 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 440 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 441 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 442 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 443 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 444 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 445 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 446 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 447 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 450 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 452 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 453 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 454 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 455 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 456 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 457 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 458 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 459 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 460 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 461 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 462 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "tgia0", "tgib0", "tgic0", "tgid0",
+					  "tciv0", "tgie0", "tgif0",
+					  "tgia1", "tgib1", "tciv1", "tciu1",
+					  "tgia2", "tgib2", "tciv2", "tciu2",
+					  "tgia3", "tgib3", "tgic3", "tgid3",
+					  "tciv3",
+					  "tgia4", "tgib4", "tgic4", "tgid4",
+					  "tciv4",
+					  "tgiu5", "tgiv5", "tgiw5",
+					  "tgia6", "tgib6", "tgic6", "tgid6",
+					  "tciv6",
+					  "tgia7", "tgib7", "tgic7", "tgid7",
+					  "tciv7",
+					  "tgia8", "tgib8", "tgic8", "tgid8",
+					  "tciv8";
+			clocks = <&cpg CPG_MOD 200>;
+			power-domains = <&cpg>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		adc0: adc@90014000 {
 			compatible = "renesas,r9a09g087-adc", "renesas,r9a09g077-adc";
 			reg = <0 0x90014000 0 0x400>;
-- 
2.53.0

