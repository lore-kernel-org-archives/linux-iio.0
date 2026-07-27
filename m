Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D440D59A;
	Mon, 27 Jul 2026 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155356; cv=none; b=IviCHafBnU94MQnE/v+KeslD43kAKWmyCmouvUPsqtKvVVqQ4LR3HAR5Zu7UZgEcl4YnRMr6JTalabj/uWcNnW1HSqgIGDzL1t84WcPzBgD5e7d0iWN5+OBmpoYjA12EAd83es1rwj7KCQI8ePbhV8hp1YIijMwdmsqG1J7D0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155356; c=relaxed/simple;
	bh=vtCrC8enOD/kvPEdYL79acFvpqmjSRWeBQpWufU1kl0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jj7Rh/yzSRjDcnJbvJnAJE3cW/SlHtImq6d48eopzEAOV8xXWeeZAiYTz8QeEZ/4O2Hc2JH9pTkaSgCS+KyyPNqJyHYSp4lazkzKMds5JdvItOHYbO3BiwpRyu5ikA4NmJC2apT8C9erw15avMmdqNbMmrBGEq/0+TgF/QhRDZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JNHs8hP2; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JNHs8hP2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785155357; x=1816691357;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=vtCrC8enOD/kvPEdYL79acFvpqmjSRWeBQpWufU1kl0=;
  b=JNHs8hP2k3Ltw/92E+8i3ZQeLdPGNnHudlFnbJ6ggojknvzdWgR9Uatx
   XGzDA1ED5+/qgXwb3kjEiXYbN5DrIzwH9ubNtgTahsScYy0nhRrCIGCvN
   NLHTnPuuVj6HllbXOtaDuIVYoXqlUWl8Ys+RjGQYWuscZ+yf3R4ZFLTiT
   6ePUbQx+dTmVKIUjFTr7i8m/RoGqe6/zp2UtIhy+C1PFJpkgHQTKkkApC
   XbVT4qi/vI0/7nEl0VXjAprZUNcmXKcub7Udw3WHb4pedUvfW+Xcbih/G
   Fnd/WH1+mMsMSmq1emwLMX2SxhJgjXMXcoKN2tH35/qh2SdD9SYqHOoga
   g==;
X-CSE-ConnectionGUID: tgQMX+RdR4erh704iPaRMw==
X-CSE-MsgGUID: kJB6D7mXR2mzcLuEluaOfA==
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="228368889"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2026 05:29:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 27 Jul 2026 05:29:13 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 27 Jul 2026 05:29:05 -0700
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
Subject: [PATCH v4 15/16] ARM: dts: microchip: sama7d65: add temperature sensor
Date: Mon, 27 Jul 2026 17:56:32 +0530
Message-ID: <20260727122633.117435-16-varshini.rajendran@microchip.com>
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

