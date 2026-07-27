Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508D9402B97;
	Mon, 27 Jul 2026 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155339; cv=none; b=mDMkHp424m1DOz49BSkzypJlm5Jbo7NaAKTYTT+D3bChHLkmFkeQuKcjGKi+UP4Ywu/wNQcm5Y3xbcItJIIc2+mRKRTOBw5aEdO9wUwQy2EiciCjYAim/rSyTMAnzktZTuoO/mVlmUQMw2EB+mcVO6K0qcZmREKzxB78ZctQ9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155339; c=relaxed/simple;
	bh=hsE5rRxh7bAlqAndFRsVAqeW+FM8vR2AklWBZ8dt6v0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbisgXAXU1/1Vcyzq/v4LzM/4LSo4vjXtmrrRrE9aks5Kf+uSh7+9G8NQHZfuEiynYDIfg5XqODHHsisJuGrrJU9TCXOSoNKrT06/xDQuFwOLX7VN4fZpVox0zo80OEglwiosAwvy/CpWkgl+Hvyd1Eqy1nA8bkMjlPfvuKsS/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rk6d+XrU; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rk6d+XrU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785155340; x=1816691340;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=hsE5rRxh7bAlqAndFRsVAqeW+FM8vR2AklWBZ8dt6v0=;
  b=rk6d+XrUIvWSgtVAt0BqL7qjSHuDLBKu8U31OKK/CXoD1W3Epg/Jv14w
   jcaS1XCBYOKaqITtyKfpbxbS1RE61XexF29PrWvFulIXfae+eJjitGMfm
   k3b99RaVjpGYTys5R201tOhc1Nj+K5q5L1f6s8Fbueiu05NYuECjKfft5
   W5bis5c/lWIvlYMPjd47TM4rIkQlv9eGfUONrEV3EoQ1JYnZfAaroIL6f
   /uRViDgvF8s6HKQ5fWbmXa1T5iOjKA2ulis6EQvSrrFKVhw7SwW6aybSe
   hL+L91rM3P0rMXJrDV6QmfV34iZNMlm+mM+c5VUgiRJjlt9kWwOyoolQS
   Q==;
X-CSE-ConnectionGUID: 45uKajqDTkafrYkPpc0gsQ==
X-CSE-MsgGUID: ile7UvYQSQuVDwLucwA4eA==
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="228368881"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 05:28:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Mon, 27 Jul 2026 05:28:55 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 27 Jul 2026 05:28:47 -0700
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
Subject: [PATCH v4 13/16] ARM: dts: microchip: sama7d65: add otpc node
Date: Mon, 27 Jul 2026 17:56:30 +0530
Message-ID: <20260727122633.117435-14-varshini.rajendran@microchip.com>
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

Add OTPC node along with temperature calibration cell.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index c35f27615bc4..aac2e22d96cb 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/mfd/at91-usart.h>
+#include <dt-bindings/nvmem/microchip,sama7g5-otpc.h>
 
 / {
 	model = "Microchip SAMA7D65 family SoC";
@@ -1111,6 +1112,21 @@ ddr3phy: ddr3phy@e3804000 {
 			reg = <0xe3804000 0x1000>;
 		};
 
+		otpc: efuse@e8c00000 {
+			compatible = "microchip,sama7d65-otpc", "microchip,sama7g5-otpc", "syscon";
+			reg = <0xe8c00000 0x100>;
+
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				temperature_calib: calib@41435354 {
+					reg = <0x41435354 0x2c>;	/* Temp calib data packet TAG */
+				};
+			};
+		};
+
 		gic: interrupt-controller@e8c11000 {
 			compatible = "arm,cortex-a7-gic";
 			reg = <0xe8c11000 0x1000>,
-- 
2.34.1

