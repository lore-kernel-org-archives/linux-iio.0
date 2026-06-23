Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D33D34A2;
	Tue, 23 Jun 2026 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212486; cv=none; b=jfShwbIrqq0lEgNJLYWVJMsBF96cHXaGidCSu4ym/uYrSRY9WG1o4Jl2qB7snYWjDpZsovrpV6J/ZG8YIW2XeGlHdIH1N9w+fLnWw1q7KkjR7znG45n2BrkUb7GaQ+ExljsYpluVOu0EvgvRiQvNe3W8aavm5ZyoXQUuZi0FcGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212486; c=relaxed/simple;
	bh=5xYA55UOhzIXToSE5GZpeE9CT0EHf953ZhVrNg1L6YA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmnVJtIYlXLTCoOOMHiRvNNhgUIY4z2usKX7+eZXXAQs58DePiooBJ5EIfM9DUwQnOXpzEVBgapJAPeZS6I7D+665A2RoxdR5YejHbnqNnf6TNDAL8Wf5YVoxqO8MJZ3gzt47sYjSZ74f83x1kxcwQuQVJ0euTh6p5stx3ZKXaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=M87tvq1R; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M87tvq1R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782212485; x=1813748485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5xYA55UOhzIXToSE5GZpeE9CT0EHf953ZhVrNg1L6YA=;
  b=M87tvq1Rx5oIiD77dQj8VwDQfe17f/iM5QcM0V2Cu2GBXVsZle4mTn0v
   vA4yS3M6WFeQy50jl3tnpClwkUgY+GMRHIpy4vEqe1Ya4FCWGalbWW6l7
   PxcCRL9xPz//AVuxuoA94lBP8yqlDA7dk8Yge52v6IFceUWGkhQ6wigBx
   Dutqr9Ib2TKR8GwLPO3wvolkJd+oYpL89QKbLSdWlz+QbxXLszh47/Mkb
   a5PONhvDFV84sOekdFlYj3XhWmHHGddFV6Rm2LB0QOUOwb0zosyCIt3b1
   7kgEpKRHknnQIBkYNicc9uPUKbneZ5mypX8zu9i4QmuLhz6o2pR6gYqfI
   Q==;
X-CSE-ConnectionGUID: XXzLbCr0Sp+ntlP9B1oDNA==
X-CSE-MsgGUID: npBuTH9VSWaISHGHQC1woQ==
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="59540506"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 04:01:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 23 Jun 2026 04:01:24 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 23 Jun 2026 04:01:18 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v2 12/12] ARM: dts: microchip: sama7d65: add thermal zones node
Date: Tue, 23 Jun 2026 16:29:44 +0530
Message-ID: <20260623105944.128840-13-varshini.rajendran@microchip.com>
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

Add thermal zones node with its associated trips and cooling-maps.
It uses CPUFreq as cooling device for temperatures in the interval
[90, 100) degrees Celsius and describe the temperature of 100 degrees
Celsius as critical temperature. System will shut down when reaching
critical temperature.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index 89904397d021..f2140010d337 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -16,6 +16,7 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/mfd/at91-usart.h>
 #include <dt-bindings/nvmem/microchip,sama7g5-otpc.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	model = "Microchip SAMA7D65 family SoC";
@@ -38,6 +39,7 @@ cpu0: cpu@0 {
 			i-cache-size = <0x8000>;	// L1, 32 KB
 			next-level-cache = <&L2>;
 			operating-points-v2 = <&cpu_opp_table>;
+			#cooling-cells = <2>; /* min followed by max */
 
 			L2: l2-cache {
 				compatible = "cache";
@@ -127,6 +129,46 @@ thermal_sensor: thermal-sensor {
 		io-channel-names = "sensor-channel";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&thermal_sensor>;
+
+			trips {
+				cpu_normal: cpu-alert0 {
+					temperature = <90000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				cpu_hot: cpu-alert1 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				cpu_critical: cpu-critical {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_normal>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&cpu_hot>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		ranges;
-- 
2.34.1

