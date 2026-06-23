Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5D23D34A2;
	Tue, 23 Jun 2026 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212480; cv=none; b=GU+++HPqV9aodvJp5g1y0V6ElxdorzoXCo+zGHhG5OJ1gYqX1G4+4wVLNvuqHagZgfQRePMutP/sURSwyJUHzHYTkxXaCJh+tFz7JgRObOxoe8qWsT/YI1RohgGWUC0A84qc05CvsY5zycQs7CwAlSHaMUC4FHvpv0Ic9j/kzSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212480; c=relaxed/simple;
	bh=+JAI97nnRrQjRgPPWdsBYZeYFHJ400kcB7mRR/guJPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mA7RQxHKVkY3M+kUMJBisolI388JCl339UXQO3pgO1pZsGxWYivgzmivclXadgnFoX/glQGDUG1wtwsSslkvApX5otm7avTuoB9m/Y5K3NjNB7pLCxtp9MKKRwytlO8v/+BQqbvbKpebtWtUXJJuP8aHheaxzUaXtCEjbr9fsgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=r/kpbgR8; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="r/kpbgR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782212481; x=1813748481;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+JAI97nnRrQjRgPPWdsBYZeYFHJ400kcB7mRR/guJPY=;
  b=r/kpbgR8EVNqMcvr3jrHN1ScmDd7B0L2KxY0pt9UVg7Z8kshvyxt+h5h
   +AIKHb+Fe8HRBWIYOSnCxjuFR1DqOGzBqqubXSqmphNrzIyE5NlLFVZD8
   fuYrAryKehB/azgBCATits8c+VWbpzDJUDqcVXRpI8ylekRdwYKcinlxl
   tQ4/EG6NPOkVhHucO2XCzcrWkCZQjqMH7n0WKEnsRv6WDsBH4JjtIE4ok
   V0bQlacsjDt7tgk5LoCpbecneoGS5k7Ep1gTn+MgHTTTJSEifF6PVcjJM
   w5ON5lMgKxmr8NEGcVi6F1k4ZSolkLjGvwAPjAlKWrDbrxKQS1q4kYQhE
   A==;
X-CSE-ConnectionGUID: usxxDGGoRJ+XLJIw7RLHWw==
X-CSE-MsgGUID: LgacvhhTSr+iNp0Tg60SaQ==
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="290925182"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 04:01:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 23 Jun 2026 04:01:18 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 23 Jun 2026 04:01:12 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v2 11/12] ARM: dts: microchip: sama7d65: add temperature sensor
Date: Tue, 23 Jun 2026 16:29:43 +0530
Message-ID: <20260623105944.128840-12-varshini.rajendran@microchip.com>
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

Add temperature sensor node.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index c336f863406d..89904397d021 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -120,6 +120,13 @@ pmu {
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

