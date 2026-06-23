Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B3E3D5244;
	Tue, 23 Jun 2026 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212468; cv=none; b=IrfqO1S1T4RIRVwA4wKjl7HZBytlHZLENILMJDRZbel7MEG5XNS7+iwA/rqTI+IDtWCD8wZYCnp3csD9My+03IUwQdCxhxegblXD44/xniUTqGq7639luvfN+FHWLLaeSJQ6ECtjhF7mCjWFiCSUuGnxoG1tkX5k6W6VS85sHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212468; c=relaxed/simple;
	bh=kCkIkCkZ+wCnKYcp7lkrWemwFvAzwzkCoeW6zMFBkzc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Myp01OPwxHScKUboWGB5fIV8wfS0IsCcjxvUipARKUy+EsLXQhn0lkAbH6G9z6cOf5tWWvMyMtt6FMFIgQNvlj2yKTfa9/eK8Jo4kceuGU+qYQ9ACWtnTIuwi4Kd9Y6gyBTbacj9hRSMFuJoOLvE2hMhk0xLy1Y+2ZM3gmaEGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NMPMBRRz; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NMPMBRRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782212468; x=1813748468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kCkIkCkZ+wCnKYcp7lkrWemwFvAzwzkCoeW6zMFBkzc=;
  b=NMPMBRRzZ4/DZKfnKAzR8LbON2mwuQ440QMkJeB9phMNehXXLOU9ULhD
   yvFalHNax0eSK8+tsvTd5nFRzFrSK5/mCJl6TZz2WrvVDtRRcOReACKg0
   XGqUzX11WOe8l+xyjB9PUszPhzmxuxNbzQEozgcaIdqHRyFqNZ5SB2fUG
   dhU88HVFtuq/sszquEvCA8Mz1ahrUGG3HfdIEVlY1Wre6vRgzKHquuq3+
   ggtDYDU1nVCvyCwIDd8u63cw4ahQ4aaAiyE7fgWX8gOUBEkEV82ecn+bz
   1eVk3rTcpyzgodcEu0zMXfRVXv7r2GkjRr8+I/swwOy2hVNfFR7A8MUGX
   Q==;
X-CSE-ConnectionGUID: M1Dk4sdfSjKBfdLv3FILiQ==
X-CSE-MsgGUID: gLEfMQIZSlmkqlsd4r9xjw==
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="290925173"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2026 04:01:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 23 Jun 2026 04:01:05 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 23 Jun 2026 04:00:59 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v2 09/12] ARM: dts: microchip: sama7d65: add otpc node
Date: Tue, 23 Jun 2026 16:29:41 +0530
Message-ID: <20260623105944.128840-10-varshini.rajendran@microchip.com>
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

Add OTPC node along with temperature calibration cell.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index ba775459a816..5867fda378b1 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -15,6 +15,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/mfd/at91-usart.h>
+#include <dt-bindings/nvmem/microchip,sama7g5-otpc.h>
 
 / {
 	model = "Microchip SAMA7D65 family SoC";
@@ -1112,6 +1113,21 @@ ddr3phy: ddr3phy@e3804000 {
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

