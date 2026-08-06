Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ECE41F37D;
	Thu,  6 Aug 2026 08:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006173; cv=none; b=PtQYxTXVx2RhDxg3QbC2xgGRxmz+C5NzxoiwrcMZYCElqmQMLGSqTQrR6/DiTrhmVa2dr/K9nbShAKNussj0ExXcbs1BsxCTgQZPUuF6IRI3okas/P+EoXi24ObMi72vNsTTxvgCM2Ge2Jq4Oicu7Z/Djr2NoDw7hXjBK+wlavg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006173; c=relaxed/simple;
	bh=XNeG3M4dWAfIsmDBbwjWj2IXhD+Qtz4KOR6R5jwR+jw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IH+XjRx+IofyUtS1xkD+OxkjwYpRIFdoTgGBWed+AOf9yVDX6o0VbtvZJAHfPPyZYP/9oR/jFVtedaZDIzEOesDQmdQubpAKHMncdeK8lDy35+WupRrFhq9HFU5o60jXO53o9UjUWK6tLlgSGaGB2pKZZbxLiKNlJcTwlNylTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=H+evpy9l; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="H+evpy9l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786006172; x=1817542172;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=XNeG3M4dWAfIsmDBbwjWj2IXhD+Qtz4KOR6R5jwR+jw=;
  b=H+evpy9lbLfpEMY/AzjKKWSAW7vpH192XAfVwwZxw4UQDsVA2gogMFnJ
   Epd/sz4jbqVw3HugF15BlJBX2Uq5gbwXyctGe+nzma7wEexPWuemFlq51
   qNpPEQjPXKsmx6J5jgg9+Ohq6S53w3szeUlvyS2eN97Fhiv01xIDt3MXb
   Re2C1WrRY3iyfOBamarDdUkLkb9e/JyL/e6P0X5MnfQMaQjTo4jny0cpN
   lgGE8l8cwj1mw0a10Jhkx69/kEqfB/3FSvB6gIgTvptslXzfssGmmegKC
   +p9JyCQtI2ONOz/8K/R3bdIibprYt0O3r7CycDjmHwRCB9/Pj26+tRQg1
   g==;
X-CSE-ConnectionGUID: fSnijaBeTzGVn5jrl+q6+w==
X-CSE-MsgGUID: bF4lcckWRjCECWByfLDleg==
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="62050920"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2026 01:49:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 6 Aug 2026 01:49:30 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 6 Aug 2026 01:49:21 -0700
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
Subject: [PATCH v6 17/17] ARM: dts: microchip: sama7d65: add thermal zones node
Date: Thu, 6 Aug 2026 13:10:24 +0530
Message-ID: <20260806074024.531259-18-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806074024.531259-1-varshini.rajendran@microchip.com>
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add thermal zones node for SAMA7D65 with trip points for passive
cooling and critical shutdown.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index 3aba73983c79..7743f9e8f692 100644
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
@@ -126,6 +128,46 @@ thermal_sensor: thermal-sensor {
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

