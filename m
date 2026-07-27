Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212153FCB0C;
	Mon, 27 Jul 2026 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155347; cv=none; b=pe8QSKvBBRWSUDmqlCbyFn15Yx2s6mPAlc5J/Pn5kMuu+mC6XYVXq7AWqCeGJyvUzbgg1ZtzEDfSy7nEW7gF/lTLvi6X+PyIE0PQokQw9rEJVMalHqq4t2QmZ9bMt9YkGDmF2yqfONMxR76lqrPetr3xGoXR2vosInVAH5CLvfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155347; c=relaxed/simple;
	bh=ytkQl2qucpM7xa0UdkODTCkBUd467sNXQVdKVB1xcag=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FAQdhaCbFjVpUpKxeeag/sMPfhNIW+PD7gnVDrndWfe6/1fH6tbkAbQDeZwCs6XJB01kDWxAf3qDWM27rKObtl36Isv//SHaAR76LKOv5JYV713t3LPpUE9mZRb2qM2b3C2o6YHtnoeNWHStvR22zAqzwuGi3WR+wMn+AsAcmcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vHpAM6cZ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vHpAM6cZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785155346; x=1816691346;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ytkQl2qucpM7xa0UdkODTCkBUd467sNXQVdKVB1xcag=;
  b=vHpAM6cZaAoER0Cd7WN9M5HUscGZMtSIqU3HFGRUh0Fbsg9dib50Omcu
   rMpqz3fhiGcpBulAIml5TfXaTkvKRECxLqiYizw/2iV7/T+SZH3w0iuxj
   S5YlLGe+2diTlE+yL6SmKEkKbNNIcIno8ZdpFvir2HFbi1Pxx6wi2P7Q8
   iecDO+Y0oadSTHNYtVu8r15/UHr978fscPaPL6ACWoVPHz923qSSG5+py
   2vzsP+M3TaZliAV0x+KyJZZqWYUosO9vWeZz/2RT1/Qds9/tBwbg7ZwQ8
   IHVWEhbGvjEYzjezb5ZNCYQhjjqCq8Zx2HuwbanunDzE+K+zKi2yIpcH5
   A==;
X-CSE-ConnectionGUID: YJO/YPw4Tp+zPf2oQjiV8g==
X-CSE-MsgGUID: BilVs8XgREmChvOdtAfr4w==
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="61530897"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2026 05:29:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 27 Jul 2026 05:29:04 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 27 Jul 2026 05:28:56 -0700
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
Subject: [PATCH v4 14/16] ARM: dts: microchip: sama7d65: add cells for temperature calibration
Date: Mon, 27 Jul 2026 17:56:31 +0530
Message-ID: <20260727122633.117435-15-varshini.rajendran@microchip.com>
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

