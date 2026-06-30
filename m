Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FA038C407;
	Tue, 30 Jun 2026 09:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812312; cv=none; b=keYmItzJda3ZfYDWVajmnhhEObFG8n7bL/61WA7DKL1h4Q7IH4RxNqQMeGz5GJigFEDynI/ajhc3ThdYGF4jQqT6xvzidq3zmAK8SAQ98PWJKpCbpgVclWCuDWjVd3J0NVx2cRFQdwGsYX49dKgSX8b5thVB/OQ4VcDZNC4Yvqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812312; c=relaxed/simple;
	bh=+JAI97nnRrQjRgPPWdsBYZeYFHJ400kcB7mRR/guJPY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HUOjNZKXG60fXr3O7s4CPgraDvcTjRyvreLW1wIsYUaVu9iudGUn9kFWPm/uhaBTS66ga6geCcAuhc2U9r0jTfRyr4I+9BeymTOUhnxoXTGVY0uQhDHpS+pb6SgxjFrIxMLa9inULOB+HCCKn6xJ6CRmEEhD1QY9WV+b2S3ZffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sP9kVJxJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sP9kVJxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782812311; x=1814348311;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+JAI97nnRrQjRgPPWdsBYZeYFHJ400kcB7mRR/guJPY=;
  b=sP9kVJxJ8fcK76W5ZVrWriWoWyrWsdu55jlyd+gV7HlVhWWSPhJxCQzp
   68v67lhKPzRGRWgx9bJpHlWUgSY2+z/46//eLy691ie6dBGvCPVDeNYVK
   Lc7p9HzXpLhor5q9gTQn0LpLOHRUhKIqaRnUvbj5oduDiKd4b/E5OpZxu
   zw28783VOuzZcJgo2MxFbyR/QsbpAdvMV3hXnsM/NLqmS15S3z7wT/4gH
   bNxlFuB6nnnuDkKxikwmvnQ7UNdcK99SbYxtaRtJhth1ztwyyZoKCYVjR
   mrRf7gOo88T3Wer6Z5PQkka+8RzyuLWhE5MzmeRi3YX8VDQETUyMbidQr
   Q==;
X-CSE-ConnectionGUID: DUuy9YIyS4m07SSKsCxMVQ==
X-CSE-MsgGUID: FbaOAge8Qref46MdaSyAmg==
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="59032722"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 02:38:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Tue, 30 Jun 2026 02:38:30 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 30 Jun 2026 02:38:21 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <jorge.marques@analog.com>,
	<mazziesaccount@gmail.com>, <Jonathan.Santos@analog.com>,
	<jishnu.prakash@oss.qualcomm.com>, <antoniu.miclaus@analog.com>,
	<duje@dujemihanovic.xyz>, <varshini.rajendran@microchip.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 12/13] ARM: dts: microchip: sama7d65: add temperature sensor
Date: Tue, 30 Jun 2026 15:06:02 +0530
Message-ID: <20260630093603.38663-13-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630093603.38663-1-varshini.rajendran@microchip.com>
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
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

