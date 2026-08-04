Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F0E361973;
	Tue,  4 Aug 2026 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843406; cv=none; b=OkNX9/eIOGh9d9up5BuV3TJfoPsWRFPGEIjWJ6uJdOlwY97AJOqpbv/JssalJf4tUYkD5Ay1cdcVSufUMoAJ3aZPx0NEcEYH7rI1sWAQRk3a3nj3oYPPt0ccb6SbegvcYWxjw4g7ZxCHsCTj1v92dE8JkNCECR70FcgTJiwCuX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843406; c=relaxed/simple;
	bh=vtCrC8enOD/kvPEdYL79acFvpqmjSRWeBQpWufU1kl0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNCIOL0sNrJhHxIcZMVjG/PpNkPWIOg1X8N1wENsI84jIuKbVK5KkCeqHnfPPdwDSvJPqfIo8uSk+SosAyPKOqZ0bxW59LTzsy4SE8Lx8nVWey0Ts7nNiQIdOmGulXjSadg6lwDVrYTufxRKZzqY4hIWa++9n30gVVISyFWDwyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OWaPPPSA; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OWaPPPSA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785843405; x=1817379405;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=vtCrC8enOD/kvPEdYL79acFvpqmjSRWeBQpWufU1kl0=;
  b=OWaPPPSAvph3cwejIteQ2ZsiJxlI7rPJx9x28edWgWgAZC5W5uXV95jJ
   h2O9ecEN3TKFzXwqOairYZG1S0ScTaykUgzhZPgLImIXffilyn+V5c4TZ
   M/2J58BdBqJUMDt96YZrlGFHE8N5kBq8kQaq5r0j+F58XndmVtmvFWagH
   aX1tTLhZXgEozDdeLGVsgx5PgFaBac7yT8KxdHSGQ6PD+ghmy5ott/0F5
   hPbOL8SmCCRiC80c62xguIKptbuLDlIKISpmJ2BNQi+UJPiNmYeAnHdw2
   5dtunV5/lbQm30Or5CJ8s5t03pqZc/PJUlxoqTQGDn2SHufXQSbKZ8BDF
   g==;
X-CSE-ConnectionGUID: +VjAUZOYScqI5j9vtqf4vQ==
X-CSE-MsgGUID: qSZIpBD+Sy6rmPK33j1hQw==
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="61934905"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2026 04:36:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 4 Aug 2026 04:36:44 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Aug 2026 04:36:34 -0700
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
Subject: [PATCH v5 16/17] ARM: dts: microchip: sama7d65: add temperature sensor
Date: Tue, 4 Aug 2026 17:03:37 +0530
Message-ID: <20260804113338.261782-17-varshini.rajendran@microchip.com>
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

