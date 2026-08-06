Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790AA31E845;
	Thu,  6 Aug 2026 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006144; cv=none; b=swHr9AMPKy5v8hmJjeHhr/UhY+1lep52Xq4x/gBgZ/xqsyMPr+VjnfV5ZJByTy1dt594KwW1tabo8gznpkiuCgGF9duPJBDG3HU+iezVO2py7ERDD4JX2IKdUHK4b/co6uF1bD58gs4DQ1zJcPckkFpR7uEnMevi+RoeM1zRHHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006144; c=relaxed/simple;
	bh=hsE5rRxh7bAlqAndFRsVAqeW+FM8vR2AklWBZ8dt6v0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zr80VxhrCVuN5gQahONVa8PnpixihsO5weHV1081YotsoZsms3VnUg1bpM3x57ny7Afrb9UsKgbY1NklrMg1HB4Plh8SOJ8f0kNN6gz3iGP4UnISi9e7R/+XxUU03OuycxZMmpRM3FyL3I8w0jhL552xNermnh1LcsMZVl5niHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PoNC+ViX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PoNC+ViX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786006146; x=1817542146;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=hsE5rRxh7bAlqAndFRsVAqeW+FM8vR2AklWBZ8dt6v0=;
  b=PoNC+ViXYIDRBMr6j+jEH3XuHjOCoecgiS0bov1Fx/nvX8YQ0/mMMZaW
   A0K1zLfB6Dwk6ohPEbAPzzQMhDN/AjhfUgyilHo059Zc3pEDf2Qd11YEr
   fQCYP3BC6EkbxhM+5lmIUUlXM4ZdMOHLM6hC1c8bmONPNrX4sHGsw9BO5
   qLKrixsR0HDAWKF2KIg+xnsG+m/cuJnzGJiDMnpYVz6gmjtkEOZATDlPi
   dax3qqZdIdZ1aypfbHL7jhDl0COiZgP7WYcbxVkf1zX78J4DAqCTJoPo5
   gVObzEYEMDBjElz9wTab3NITUONjEMZnyimLAqY77iIVvhnESsq665Z4l
   Q==;
X-CSE-ConnectionGUID: ENZSoASLQWeZsm6byR7nEQ==
X-CSE-MsgGUID: vFO1HFdfQ/S+/l3RprNI5g==
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="71343347"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2026 01:49:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 6 Aug 2026 01:49:01 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 6 Aug 2026 01:48:52 -0700
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
Subject: [PATCH v6 14/17] ARM: dts: microchip: sama7d65: add otpc node
Date: Thu, 6 Aug 2026 13:10:21 +0530
Message-ID: <20260806074024.531259-15-varshini.rajendran@microchip.com>
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

