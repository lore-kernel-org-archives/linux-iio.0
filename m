Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C104C4338F
	for <linux-iio@archiver.kernel.org>; Mon, 26 Jul 2021 18:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069FB60F58
	for <linux-iio@archiver.kernel.org>; Mon, 26 Jul 2021 18:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhGZRux (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 26 Jul 2021 13:50:53 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:15692 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232176AbhGZRuw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 13:50:52 -0400
X-IronPort-AV: E=Sophos;i="5.84,270,1620658800"; 
   d="scan'208";a="88770566"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 27 Jul 2021 03:31:20 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8373740062BD;
        Tue, 27 Jul 2021 03:31:17 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 3/3] arm64: dts: renesas: r9a07g044: Add ADC node
Date:   Mon, 26 Jul 2021 19:28:50 +0100
Message-Id: <20210726182850.14328-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210726182850.14328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210726182850.14328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add ADC node to R9A07G044 (RZ/G2L) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 9a7489dc70d1..28aafa34d583 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -169,6 +169,48 @@
 			status = "disabled";
 		};
 
+		adc: adc@10059000 {
+			compatible = "renesas,r9a07g044-adc", "renesas,rzg2l-adc";
+			reg = <0 0x10059000 0 0x400>;
+			interrupts = <GIC_SPI 347  IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A07G044_ADC_ADCLK>,
+				 <&cpg CPG_MOD R9A07G044_ADC_PCLK>;
+			clock-names = "adclk", "pclk";
+			resets = <&cpg R9A07G044_ADC_PRESETN>,
+				 <&cpg R9A07G044_ADC_ADRST_N>;
+			reset-names = "presetn", "adrst-n";
+			power-domains = <&cpg>;
+			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			channel@0 {
+				reg = <0>;
+			};
+			channel@1 {
+				reg = <1>;
+			};
+			channel@2 {
+				reg = <2>;
+			};
+			channel@3 {
+				reg = <3>;
+			};
+			channel@4 {
+				reg = <4>;
+			};
+			channel@5 {
+				reg = <5>;
+			};
+			channel@6 {
+				reg = <6>;
+			};
+			channel@7 {
+				reg = <7>;
+			};
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a07g044-cpg";
 			reg = <0 0x11010000 0 0x10000>;
-- 
2.17.1

