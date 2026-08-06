Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFA441E6D5;
	Thu,  6 Aug 2026 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006163; cv=none; b=lZnpvfqotbjGsy6bVYOeQGHtnNgU5KavXLN4I4S1rrFh+F73pKgupecPq87mU7V954Q7RGwVMoYHTalVpA7E4BRQnEeYNAZFy4Jypx5OMOeipncz2ctYrdIrCwqsBNgUZf+5ALevSp8v6NuJZH4M7I5wP+bkVC22aeRKZvTxQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006163; c=relaxed/simple;
	bh=vtCrC8enOD/kvPEdYL79acFvpqmjSRWeBQpWufU1kl0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfBbYJYgECrMHjjqQoqEFfRnaJkZ3TOqGRk0Zoy7mgKPctmCw6Bg0iNzTpWuJ3XsHs2SYn7uFQ4Lma5aaSZ59Xew9yyqAQZMpsNKIMJi5rEZ7ARyUJJLOqOXActDRy6sp5vNZz0jx0UdCJQcUHNIWeIEu4XaLv20kmxe/drf1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=C0bIICRr; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="C0bIICRr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786006165; x=1817542165;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=vtCrC8enOD/kvPEdYL79acFvpqmjSRWeBQpWufU1kl0=;
  b=C0bIICRrod/HZUO1VZvlWp2axIPkv0M+8FJi4P7dP6Yxt6oVImLEK3De
   znWscKeN+cqqN+C5up7fr5x1oTF7f4gq32LU4Nv+M7FIi3jFri13e3L15
   iEiFDSO7HYmYhcSVhkIEptsUReef1JqfdK8epir86nSCCLDDF3uUIuqZM
   kTAHpfsDZXzMIHQT57HqaBSInZ9/t+xht35GZ1qQwUEoI6YogWWb1oGBm
   PUe9a22InrOX2zvG1AapZQ+C/9MfMCEzK6CIu0Zn3jEtEdq70v358Y9Ux
   DOM0Otdrsm+qbthTkmv+b7sQgF3Xq9FIPqubb0f3QQGt057fRVogFLPES
   w==;
X-CSE-ConnectionGUID: Zv2G35yLQiGdI6PdOlli4A==
X-CSE-MsgGUID: mP/+BNZIRL6isoA00PCAnQ==
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="71343361"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Aug 2026 01:49:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 6 Aug 2026 01:49:20 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 6 Aug 2026 01:49:11 -0700
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
Subject: [PATCH v6 16/17] ARM: dts: microchip: sama7d65: add temperature sensor
Date: Thu, 6 Aug 2026 13:10:23 +0530
Message-ID: <20260806074024.531259-17-varshini.rajendran@microchip.com>
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

Add the generic-adc-thermal temperature sensor node for SAMA7D65.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index a8b18ad0ef7f..3aba73983c79 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -119,6 +119,13 @@ pmu {
 		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	thermal_sensor: thermal-sensor {
+		compatible = "generic-adc-thermal";
+		#thermal-sensor-cells = <0>;
+		io-channels = <&adc AT91_SAMA7G5_ADC_TEMP_CHANNEL>;
+		io-channel-names = "sensor-channel";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		ranges;
-- 
2.34.1

