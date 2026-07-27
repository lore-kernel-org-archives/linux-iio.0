Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD03403E82;
	Mon, 27 Jul 2026 12:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155319; cv=none; b=J9N+xxp4Chq6noClgprrx9vo1nlMEmfeUrC1veStAvYChNfOwlyBDBobM3tW4fJrlrVbuapADVoX099CgOUlpSaq4vn1YVgQ6h+9nD0qEDGdXuvY473DvByaR0TcRQbtQ84mlFD37qsyBBdPO9hE7Q6vFQqvHFyc1mTrzEV9cMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155319; c=relaxed/simple;
	bh=/eM8hz28shrnbpDK7y2SGL0KHfDbbCGmq4bnAalgeqk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuVQpPnd0jxCYTf06meA4Afi9eGZImDv4iWkgcs8lzDtmPc1ugOItIrQJhmIVzV/MFICPI2gsuHvzsRL1VcBdOGBpTg7yFWfwXY2kr5cAmwXo+0dw7Vk29ehQ91uO2Ct1KUw9R/gzq8+mwGOk4Cjcc1q3LCZ2Cw9oi2tF2+L0uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HMNabFW5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HMNabFW5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785155321; x=1816691321;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/eM8hz28shrnbpDK7y2SGL0KHfDbbCGmq4bnAalgeqk=;
  b=HMNabFW5EwWmIFqJjao3ezkLVktI4cpWRzkhu284dVvIf/vA/pHZkV1P
   F9q9DjmOEhVUGuGWrN6AqP46TQEAKRBVp3BlCvAxmcxm+039B98UdDMI6
   fdFMOAT97m4Oy7/koxvmOS4GzMvSJSLfsq6V1Oz3qBYiveXj3EMhBpLQZ
   80qVBRJoz2ZwpphfCCmUeTvGcFlGZQ/Ox/0Ag6XeBV81claR5h98LgofJ
   2uINNQR5PPtY4TlGAOc0sBcsoZhcOndQUlsZXXKhzn3rkrAEApVqA3q8W
   feN9W8Eeum+HPDqzjOm5X35Tw9rt6rIA0mnOZ5MT1rBu5T69zptN9Kc1f
   A==;
X-CSE-ConnectionGUID: h8QrLHouR+KI+z6Q+ttd3g==
X-CSE-MsgGUID: UCvsSnV0TLmCnbPwSyNrLA==
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="61219970"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 05:28:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Mon, 27 Jul 2026 05:28:35 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 27 Jul 2026 05:28:26 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
	<Jonathan.Santos@analog.com>, <jorge.marques@analog.com>,
	<joshua.crofts1@gmail.com>, <jishnu.prakash@oss.qualcomm.com>,
	<antoniu.miclaus@analog.com>, <varshini.rajendran@microchip.com>,
	<mazziesaccount@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 11/16] ARM: dts: microchip: sama7d65: Add ADC node
Date: Mon, 27 Jul 2026 17:56:28 +0530
Message-ID: <20260727122633.117435-12-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727122633.117435-1-varshini.rajendran@microchip.com>
References: <20260727122633.117435-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add node for the ADC controller in sama7d65 SoC. Add the vddout25 fixed
regulator node which provides the 2.5V reference voltage for the ADC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index dfac17e34e65..c35f27615bc4 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/at91.h>
 #include <dt-bindings/dma/at91.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/mfd/at91-usart.h>
@@ -95,6 +96,15 @@ slow_xtal: clock-slowxtal {
 		};
 	};
 
+	vddout25: fixed-regulator-vddout25 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDOUT25";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		regulator-boot-on;
+		status = "disabled";
+	};
+
 	ns_sram: sram@100000 {
 		compatible = "mmio-sram";
 		reg = <0x100000 0x20000>;
@@ -296,6 +306,24 @@ can4: can@e0838000 {
 			status = "disabled";
 		};
 
+		adc: adc@e1000000 {
+			compatible = "microchip,sama7d65-adc";
+			reg = <0xe1000000 0x200>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_GCK 25>;
+			clock-names = "adc_clk";
+			assigned-clocks = <&pmc PMC_TYPE_GCK 25>;
+			assigned-clock-rates = <100000000>;
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(0)>;
+			dma-names = "rx";
+			#io-channel-cells = <1>;
+			atmel,min-sample-rate-hz = <200000>;
+			atmel,max-sample-rate-hz = <20000000>;
+			atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
+			atmel,startup-time-ms = <4>;
+			status = "disabled";
+		};
+
 		dma2: dma-controller@e1200000 {
 			compatible = "microchip,sama7d65-dma", "microchip,sama7g5-dma";
 			reg = <0xe1200000 0x1000>;
-- 
2.34.1

