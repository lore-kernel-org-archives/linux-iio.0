Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7268E356777;
	Tue,  4 Aug 2026 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843364; cv=none; b=DgerwQpUE4qlQZmN6KeFM3dKjWP6sC7DhfapSBrrk/lNFW2il487wLb+pcoR5qY2CrEWJNQUklEjAdpU4r1C+dN6uCjh1otqPP8VMGUVft00vyogzVyt5L+EYWmjYtYOasLhw/ssHPKIkgjwNvy6WMRsldd6LBBiCJjS1vX4E9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843364; c=relaxed/simple;
	bh=/eM8hz28shrnbpDK7y2SGL0KHfDbbCGmq4bnAalgeqk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEKrlte4QyHm4oH/HT56F3lUQ+FQuN22+eZ/zYI3MbNw7HEu+L5J/SPDfJBQ+jRvI+RxUoIthxtodnwsvj9pjIpVqonWJtVfo7q1o9Ip0f0/iRakrmQBxhCVwcZOYPJsN7ywA2EdksrO4KoFwfaKWZ8ArQDHpdezgBBsRdWHBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NqWNUR05; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NqWNUR05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785843364; x=1817379364;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/eM8hz28shrnbpDK7y2SGL0KHfDbbCGmq4bnAalgeqk=;
  b=NqWNUR05CT+lBMRmBHWoG9HKn9zNyh5bnuD1x/hq+JORACZaZ6G7h4df
   AmJO9Nnl605BV/8ouMb2/kkvVbiq5IDFHfHxTwIQcX5XzjIcbgmHxcJou
   orDaWys84JvIdWu+I/r5+O6eRMbUdgAVF3Y0cszDNEetj008qSip3j+FH
   4Ho5wd7sDN6e+zNjdygC3RB3mmNXamfsjQTAGStrXw9t8FK6CKZ86Ls45
   h2+keEqM7dkk7nE+xi1U3qb5yjy4/XdA6CpGaQqxqWPqyFuJlEuoTeVMY
   XFNw+/Be+fZidDxTwtHEHx9gKpNN3ZtG9Es4upzwEKDZL0sF80slmExEd
   w==;
X-CSE-ConnectionGUID: WvKHNvQfTtu0hBfcKdDUYg==
X-CSE-MsgGUID: kYvugFlAShaxMDxIT/dauw==
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="292994092"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2026 04:36:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 4 Aug 2026 04:36:01 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Aug 2026 04:35:51 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
	<joshua.crofts1@gmail.com>, <jorge.marques@analog.com>,
	<Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
	<antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
	<mazziesaccount@gmail.com>, <varshini.rajendran@microchip.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 12/17] ARM: dts: microchip: sama7d65: Add ADC node
Date: Tue, 4 Aug 2026 17:03:33 +0530
Message-ID: <20260804113338.261782-13-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804113338.261782-1-varshini.rajendran@microchip.com>
References: <20260804113338.261782-1-varshini.rajendran@microchip.com>
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

