Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908F3D3335;
	Tue, 23 Jun 2026 11:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212456; cv=none; b=PgHiOBiTjG7U9oHH+x22oZ5PEhH921B/6XCam0++C1z5jwvi/sHoHQKYJLcBCmuzBiz5A0T2B+LHvcyE/8qLM/cMsM+Kn4O0wN79uOB+pK3uF80hET4dNk8lsiEynzHaVRif7Wxra0nzLHfYZDxkLSkUg9bAZRqoTvnfgal09AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212456; c=relaxed/simple;
	bh=iRxQDJ1b421KSHotpRKX5cuGQo+zqlZSM80SG3VZshg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IX0SVmvEBkCi3poxN+8cRaXndoHGnBcpXx7A11ZZVCM03g3IT5C3rTvUKOSjD9AMWQCHAYV0SPqqTJMwV3XHEFTHrIRj1j10ZvbpUlumriujTmwngsvOV3jgCQ6CrwKxOfGqwMXzSpi2xeZ4zjQPKLq0AYDwLJ0lp2Laxuy8lck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nAkcJDgv; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nAkcJDgv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782212454; x=1813748454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iRxQDJ1b421KSHotpRKX5cuGQo+zqlZSM80SG3VZshg=;
  b=nAkcJDgvRtgu/xOvHkmLKW4nyvnhsTUGL2mvDGRGYk7y1Vj6eLkzceB9
   svhiu1MSxumnCFtrjSw3NGdnWi3Q9gFjy6Y2JZPw2IEcAu+0JkIG2R9HX
   YivBXnzl35zMxPm9VGAahXnsmtjDP32SiCZt2zbu83jOB/LteYdl4/QRY
   HiWMg24q3xS5eSlMiW+T/yzD2Bs6Fp9enImWWEE729Z/oNsgIHror3jPz
   QU53Pua3VkFJoG86VeoXyDvVj8ef2igdEQpxv+YWrC/CRKzXWU/OcOaGH
   6NTreU8mbVQNdhd454TM27b9VuoMgzbpDucJ6RyKvA4wdI9xT4LJkCowD
   w==;
X-CSE-ConnectionGUID: 2SOJZtOGTtC4u8lw/Xl3yg==
X-CSE-MsgGUID: xw/1HFpUQUemVJEpVYwO1Q==
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="226724844"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2026 04:00:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 23 Jun 2026 04:00:53 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 23 Jun 2026 04:00:48 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v2 07/12] ARM: dts: microchip: sama7d65: Add ADC node
Date: Tue, 23 Jun 2026 16:29:39 +0530
Message-ID: <20260623105944.128840-8-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623105944.128840-1-varshini.rajendran@microchip.com>
References: <20260623105944.128840-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add node for the ADC controller in sama7d65 SoC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 29 +++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index 94d49e20dc79..ba775459a816 100644
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
@@ -95,6 +96,16 @@ slow_xtal: clock-slowxtal {
 		};
 	};
 
+	vddout25: fixed-regulator-vddout25 {
+		compatible = "regulator-fixed";
+
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
@@ -296,6 +307,24 @@ can4: can@e0838000 {
 			status = "disabled";
 		};
 
+		adc: adc@e1000000 {
+			compatible = "microchip,sama7d65-adc";
+			reg = <0xe1000000 0x200>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&pmc PMC_TYPE_GCK 25>;
+			assigned-clocks = <&pmc PMC_TYPE_GCK 25>;
+			assigned-clock-rates = <100000000>;
+			clock-names = "adc_clk";
+			dmas = <&dma0 AT91_XDMAC_DT_PERID(0)>;
+			dma-names = "rx";
+			atmel,min-sample-rate-hz = <200000>;
+			atmel,max-sample-rate-hz = <20000000>;
+			atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
+			atmel,startup-time-ms = <4>;
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
+
 		dma2: dma-controller@e1200000 {
 			compatible = "microchip,sama7d65-dma", "microchip,sama7g5-dma";
 			reg = <0xe1200000 0x1000>;
-- 
2.34.1

