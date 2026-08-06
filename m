Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815943E2740;
	Thu,  6 Aug 2026 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006135; cv=none; b=Mh1K1s81ReW1+q/7Kli4i9+MHR0HwrRs3/lg3kYeuo178EmOYGh9F/6wezvvP5wv1HXUja9SWyPPjQladYtZLpeIYFWycQOuDAQXLq0jVcqUq7ciL0rKYz/9B2Zf1N5fy0cn0EO5mdYhLcRkJuKmceh+Pj1rknQATnWLPZ+JNMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006135; c=relaxed/simple;
	bh=JkNlRyaOOV3pTgI7mHQS2o4Wmw7D4SylfoNccbioFoY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bd/ZK9ENtHB7vtyZl1JHpyInyetVkf4VDvwzOw9y7mn62ACWzJUvNC3z9JRb70ZiepDwKah/ycmtz9qOhGebsURjUJEzD9k9CAnkcMnkwPw1IdFs56EL/3GOEcKWs7V1gJ5iqIMRJbeDgzZhYwMaZkcMRVwDXeeyVgKGd1x3q0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=p/n+Mcmo; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="p/n+Mcmo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786006133; x=1817542133;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=JkNlRyaOOV3pTgI7mHQS2o4Wmw7D4SylfoNccbioFoY=;
  b=p/n+McmoKDOj+qG0LQD/yLUUwTbB7K8GtGoP1xjM0lTX49EG1Sjw1VUH
   iLJq6cgnvN/si0MAQYZJh9Olj3AAVkC8JJ3/PboXJ29/WZgqAirzaCxPl
   nhHUKEL0M/3uGk0RVgkYYKrT6FzdPRHOMfFdfsHLf5nJUI+1zbTpB1AFu
   45zkfL8QYZg1LLxATn8w+GZQCK9rMdoDPZZTlOg+mSm5KOY8TRbdeQFFe
   8oxk8PkYmu0O+SCqE+6/2eUV4xqIllq+cXAtbNwN5bP8eTsUyRU6dQVp4
   mxwi1Ck7JrtESUNcHVNpC1zBqoAP5sl3U5HjMwnmwd1ioBAWYMSVus96w
   g==;
X-CSE-ConnectionGUID: r1th4OAjSsi+Ep5SuUld9w==
X-CSE-MsgGUID: YJiZZQPITaeclZRP3KznCA==
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="60854124"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 01:48:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 6 Aug 2026 01:48:52 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 6 Aug 2026 01:48:42 -0700
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
Subject: [PATCH v6 13/17] ARM: dts: microchip: sama7d65_curiosity: Enable ADC, DVFS
Date: Thu, 6 Aug 2026 13:10:20 +0530
Message-ID: <20260806074024.531259-14-varshini.rajendran@microchip.com>
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

Enable ADC and DVFS on SAMA7D65 Curiosity board. Configure the necessary
power supply (vddana, vref) for the ADC, and enable cpu-supply for DVFS.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 .../dts/microchip/at91-sama7d65_curiosity.dts | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
index 927c27260b6c..c2d1e5308170 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts
@@ -79,6 +79,14 @@ reg_5v: regulator-5v {
 	};
 };
 
+&adc {
+	vddana-supply = <&vddout25>;
+	vref-supply = <&vddout25>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc_default &pinctrl_adtrg_default>;
+	status = "okay";
+};
+
 &can1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_can1_default>;
@@ -97,6 +105,10 @@ &can3 {
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&vddcpu>;
+};
+
 &dma0 {
 	status = "okay";
 };
@@ -334,6 +346,16 @@ &main_xtal {
 };
 
 &pioa {
+	pinctrl_adc_default: adc-default {
+		pinmux = <PIN_PC5__GPIO>;
+		bias-disable;
+	};
+
+	pinctrl_adtrg_default: adtrg-default {
+		pinmux = <PIN_PB7__ADTRG>;
+		bias-pull-up;
+	};
+
 	pinctrl_can1_default: can1-default {
 		pinmux = <PIN_PD10__CANTX1>,
 			 <PIN_PD11__CANRX1>;
@@ -457,3 +479,8 @@ input@0 {
 &slow_xtal {
 	clock-frequency = <32768>;
 };
+
+&vddout25 {
+	vin-supply = <&vdd_3v3>;
+	status = "okay";
+};
-- 
2.34.1

