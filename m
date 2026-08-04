Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2B352008;
	Tue,  4 Aug 2026 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843396; cv=none; b=MvC41Vxh9ZtIyBpMPONriAd6psds71Cl7CB6IXKCTRKRcGlDBL2FKIvsDP3r3fxqmd06o8A04shllx5U09IqJFLCIAwemZzQDmT7lasYpfIkkZ3lhXSyDZmSHi1hbyyd7ZQ3bBRM+VPqZXchI4AKm7XeTusVI8psfDbUzJE1ES8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843396; c=relaxed/simple;
	bh=ytkQl2qucpM7xa0UdkODTCkBUd467sNXQVdKVB1xcag=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/k05ZDXY4ZfKLghHKSexHj+Kfxv5Q7u/lBLUW3wSWGolpt5/EtnzZGgtrv3LJYDCG7ScelYCTx4RR+xphM3ik5DT/oW8T3/AiqhCReHp3YymRa757e67X6sBdJJVn0QvAPXUwGJ9AJibRGquMGJpmwynGBSSKj5aW9qKIDKuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=konyeQfS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="konyeQfS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785843395; x=1817379395;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ytkQl2qucpM7xa0UdkODTCkBUd467sNXQVdKVB1xcag=;
  b=konyeQfSWd4MNsMXlfoq/t2vfsVRja9FTOJjhf/85od8PW2Az3aTXVeG
   N8fTgK5mDAaExPABxiE47WpfFCpfCxVEh0FoeGTcpr5wys5QNdJdySRiW
   +O2L9vwNk3tL+Myh5yfIV7Ssr93gkWyVH9OexvQESX9mGo1LaZKuG2xCL
   8GVFeevP8bg+lG6O+F1xOVMe6KY1nrzJRS98DMXiHZqApB0qVBGarulA3
   6rw1Mo6UWH9jvKD3TGeWoOhuQBmgvy1uMQMrpmBkkT5Mbm9SMgSONL+Gc
   SmRJJYXmCyh3/4dBi7ojE5ackK4MYs52WJdTn0oj3jVECcM2VTpAEGm73
   w==;
X-CSE-ConnectionGUID: +Eg+lPfRSQmGrmY2j3vnew==
X-CSE-MsgGUID: UOGQzfCSQkGMApPuGdpeaQ==
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="61934900"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:36:34 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Tue, 4 Aug 2026 04:36:34 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Aug 2026 04:36:23 -0700
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
Subject: [PATCH v5 15/17] ARM: dts: microchip: sama7d65: add cells for temperature calibration
Date: Tue, 4 Aug 2026 17:03:36 +0530
Message-ID: <20260804113338.261782-16-varshini.rajendran@microchip.com>
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

Add nvmem-cells for temperature calibration data to the ADC node.
The calibration data is read from the OTPC.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index aac2e22d96cb..a8b18ad0ef7f 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -318,6 +318,8 @@ adc: adc@e1000000 {
 			dmas = <&dma0 AT91_XDMAC_DT_PERID(0)>;
 			dma-names = "rx";
 			#io-channel-cells = <1>;
+			nvmem-cells = <&temperature_calib>;
+			nvmem-cell-names = "temperature_calib";
 			atmel,min-sample-rate-hz = <200000>;
 			atmel,max-sample-rate-hz = <20000000>;
 			atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
-- 
2.34.1

