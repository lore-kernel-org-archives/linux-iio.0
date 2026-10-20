Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.31.26.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496163;
	b=wLGN2msEcfdAGIdnXCwHjHs2Ukwka5TbKA/J9Vm5yYEYYBYhpDEkBjmw/hZbZPEgR648
	 aLlgPTAipdQCWnnHaSqKiOt0Af1BeW7irOjTGg7ahcLZhVgPpQMiWcfO9T4uQ4iHb0z87
	 KtVuVFm7Bzz9RWvz8sfGRRTI4FOUyXp1M1pqguTReXI0AUmQU5wkCzsjmf3WGXQ0kHFoY
	 DPiS8l7Y+qeF7eMfH4ZiFGILLYSdIGhKa4Yift8ni2yr0A9KA2BdMEuBjzQcrv0aBPFtL
	 auIz5XZy/jv5LpwdnZdtwuRVvmtwyKEP1NytE0JU23ui84PA3/4FHMPG4nBazeCjLAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496163;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Yc052G9MAc5hsw8GoH+iW9aJ1GEyZIWq0zf2j00RpaU=;
	b=L9m62fbBRqxzFsKGPEo2QXDxiAH3TVo44Yj/wybOh2KQgn25+3fd+dsbsizRvfvtZDP8
	 m4cxAKRPbrmWG9NHhBpeP6ZPlP1PFe7VzkJ3zp6TEyVVPzhyMdHy2qyJmcSGnDUpMTJ1c
	 0c59+E6hQrEzrJ7QsUo6YDoLPpRKbPX0OcaEueheb2RdIqtdZ9XD3xB2oftYwBqhUkAbS
	 yt8fywB6aPo6LFHY85vFiqw3JWWDWQUg/iwrOaUEeW7nFp5MeBqc13bWl9XwyNayf/XVQ
	 71n7loVRCL9WFupSiFQg1N13ujnXOFRx6HIyq2JqGps1DnTiGnZ+l0RI4akL/fhB+Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rudorff.com;
	spf=pass smtp.mailfrom=rudorff.com;
	arc=none smtp.remote-ip=193.31.26.27
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC988606A31D;
	Tue, 20 Oct 2026 11:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC988606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 99427411EB;
	Tue, 20 Oct 2026 13:35:53 +0200 (CEST)
From: Christoph Rudorff <chris@rudorff.com>
Date: Tue, 20 Oct 2026 13:35:40 +0200
Subject: [PATCH v3 3/3] arm64: dts: qcom: msm8916-samsung-j5: Add proximity
 sensor
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-iio-light-gp2ap002-v3-3-b7e0946c9e79@rudorff.com>
References: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com>
In-Reply-To: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Christoph Rudorff <chris@rudorff.com>
X-Mailer: b4 0.16.0

J5 got a gp2ap002 sensor, add it and it's supplies to the device tree

Signed-off-by: Christoph Rudorff <chris@rudorff.com>
---
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts | 52 +++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
index ba8650971d6a..efac29485df8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
@@ -8,6 +8,17 @@ / {
 	model = "Samsung Galaxy J5 (2015)";
 	compatible = "samsung,j5", "qcom,msm8916";
 	chassis-type = "handset";
+
+	reg_leda_proximity: regulator-leda-proximity {
+		compatible = "regulator-fixed";
+		regulator-name = "proximity_leda";
+
+		gpio = <&tlmm 73 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&proximity_ldo_en_default>;
+		pinctrl-names = "default";
+	};
 };
 
 &accelerometer {
@@ -19,6 +30,24 @@ &blsp_i2c5 {
 	status = "disabled";
 };
 
+&i2c_sensors {
+	proximity-sensor@44 {
+		compatible = "sharp,gp2ap002s00f";
+		reg = <0x44>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <113 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&pm8916_l17>;
+		vio-supply = <&pm8916_l5>;
+		leda-supply = <&reg_leda_proximity>;
+
+		sharp,proximity-far-hysteresis = /bits/ 8 <0x2f>;
+		sharp,proximity-close-hysteresis = /bits/ 8 <0x0f>;
+
+		pinctrl-0 = <&proximity_int_default>;
+		pinctrl-names = "default";
+	};
+};
+
 &pm8916_codec {
 	qcom,micbias1-ext-cap;
 };
@@ -30,3 +59,26 @@ &touchscreen {
 &usb_hs_phy {
 	qcom,init-seq = /bits/ 8 <0x1 0x19 0x2 0x0b>;
 };
+
+&pm8916_rpm_regulators {
+	pm8916_l17: l17 {
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <3100000>;
+	};
+};
+
+&tlmm {
+	proximity_ldo_en_default: proximity-ldo-en-default-state {
+		pins = "gpio73";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	proximity_int_default: proximity-int-default-state {
+		pins = "gpio113";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};

-- 
2.39.5

