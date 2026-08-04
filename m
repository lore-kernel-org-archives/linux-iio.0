Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659D3546C0;
	Tue,  4 Aug 2026 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843419; cv=none; b=BXiU/vKbAiLq0tSGYm1NlusnYNqo7h1DJFbFy4yU+pnF5UGI91qJZdxzb7PxqJxfTARxPGNDY5WiNSmQBKsTNYa7rUNl4BAKLyTRaEhbOklvSxSTcsN1GKHRrrSsQTHrIwuzQuhpqGrMRjnzYIDCMElckMu+05A3rw7Pl2SDqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843419; c=relaxed/simple;
	bh=XNeG3M4dWAfIsmDBbwjWj2IXhD+Qtz4KOR6R5jwR+jw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Swc9CK8llI8JAFLypprjQ/RHmj11cPZSGbUBaPRYFsYCCvUszaXPCwov75WVAsTgLSDHsY/OSLKXosB1b9MxIPKYgPgKZ1lnpAA7/ai3Oaj7c0+QpigNlOhy/G3POdR+gJxOjDBxRsTUSXitKYeVJMCHNQFpbCXMUrf58lvrV6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OuSGkuKN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OuSGkuKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785843417; x=1817379417;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=XNeG3M4dWAfIsmDBbwjWj2IXhD+Qtz4KOR6R5jwR+jw=;
  b=OuSGkuKNH1sAeVWoJfLdr6t2lQGVZ8PINK9gaRqs9UYDD0QgsyLDbMst
   j5CqJGsnY5QCceuCVcAGozUu/XZwPef1QVAbDqACvmi2W/ehjrZBbc0ef
   W//mspeRvnW/ODeDEZDPOvkNzkwwyJcnPbAATyVlzwxDzv1tIh/xTbrPw
   iyyguo/8AO2FyGgJ6XyCpSkMJBr6wMccBRvhAuUSoAjViPVpbhj0LQ++1
   2H361U1P7eoz7IJPcae31BRgWXbznZ618NON8z/0Edch2ANnfej0ApfLO
   EMfYGFaaEilDf1+ELZCc+YAIae+Di4goZz1owIl4w6/Fc+ZjyB+BPAt7H
   Q==;
X-CSE-ConnectionGUID: 7CuNwgWqRGiaWdZkGYCKTQ==
X-CSE-MsgGUID: sI5zwelDS8SKIypgjElsaA==
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="292994117"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2026 04:36:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 4 Aug 2026 04:36:55 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Aug 2026 04:36:44 -0700
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
Subject: [PATCH v5 17/17] ARM: dts: microchip: sama7d65: add thermal zones node
Date: Tue, 4 Aug 2026 17:03:38 +0530
Message-ID: <20260804113338.261782-18-varshini.rajendran@microchip.com>
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

