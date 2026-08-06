Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA441F7EB;
	Thu,  6 Aug 2026 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006154; cv=none; b=L9No7n7PBGPKH5r20EgbkZcMo/Smje/3dQQQnsLH1TY5p9bmgnjV9erc8p7xMBMbYn8TRAtuE2rEQwvkAJITjdie3vGUwaMYyD10/BQhhSygjsM/gQGHxgg5E+iwh0aH2QaQ5jRoRrj1lzs+wwJThY8Zlhy7xBMayT4QrKtRUqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006154; c=relaxed/simple;
	bh=ytkQl2qucpM7xa0UdkODTCkBUd467sNXQVdKVB1xcag=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V33wFJnB/4xrbrqVN0mCNGzhL7DQQmuvsi8ThzF9m/RGNsBdw6dIw9mBJV0BuAZaYGEb3ua9FbJrmh5r6WQDKgMfVBxV3OgkcCM6OjcQS5E9f/gLdnSIP2An7m4k1XZoqDn5ziKVBsXfqf3YlisvfHb5rZ3/lzj8XOYoMbF8UZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=btFXYNKN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="btFXYNKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786006155; x=1817542155;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ytkQl2qucpM7xa0UdkODTCkBUd467sNXQVdKVB1xcag=;
  b=btFXYNKN//zcy3NjhYIyNdRNguOTvRAwuB5bWNyExTYie+ozErb+5P/E
   tUoM25U+n7QGK00OLhnsSoDdunP2Hqe1PSIs3reEptEaCvdEIvOR5XTdF
   0QYJ1TkxwxF+XQuecdtrf6P5YX1pRJtV/ZmJvXbovsMA+0Ciw9YfIkVsu
   s2dhbf9T3MKTGdrD2sZz+cZQ1rXxEmoCPLhW7bUB9N60o7ofjVgx+zpcx
   DYMWYyeRyvJ5K+TrU6T2+GU+qjkuB4YTT/gM73WZg5CEhsdJ6ZRnsC1j+
   0pdz52sX+70YJ3ffH+ZmL0EepRwthLqerNN2flVS2dp7jGQ/BI/OI3RH5
   g==;
X-CSE-ConnectionGUID: YydEj9LITdaDMnTonKM7Qg==
X-CSE-MsgGUID: NU0hnE9bRCWtZMFFZo4V6Q==
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="71343352"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 01:49:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 6 Aug 2026 01:49:11 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 6 Aug 2026 01:49:02 -0700
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
Subject: [PATCH v6 15/17] ARM: dts: microchip: sama7d65: add cells for temperature calibration
Date: Thu, 6 Aug 2026 13:10:22 +0530
Message-ID: <20260806074024.531259-16-varshini.rajendran@microchip.com>
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

