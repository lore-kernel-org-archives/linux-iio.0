Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.31.26.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797361;
	b=EbyU/5xutmPTUrRQQrQAnMzwbLHJKvoaAMdmIO17hVKt7Q6m4MDFvbNfLNEJLrMJsmI4
	 NOV1G1UcO8UEamtujn3RIrz6QD/4dOqCxws0xYwW1nZoYahzntq7ffAiRZwcm234xMQxk
	 IO33W50qQPmSbCJFHgKHE2mjiqJMM3YnBjTPwHMb8gkQQaIAzHNCmhHzq03HlTnTq3uEB
	 haWSpSERP8S947dYXZZrEdc5RWZnWFdmIzxT4VvuDGR7VbVlKNeiplVs4bUYw7bCRvWkZ
	 eWt8WAZ6OpFFnB5q4sr4d25k7+w+UbUtGuqoC8G9Mw5qN00PR+9DGLw1xrkjpJMYYBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797361;
	h=DMARC-Filter:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=2hcbQcGGYeS/AUC3MwLStrI1BgNbBKd2Pm79DkoNC6I=;
	b=CY7D/tN0vmhWOqqVBrvdvJVSmursfnX3CwzUL+ju7tgZ8ktsh/TDkl5AOcJwLTNLoIE2
	 HozrcYw+2h6bBhVdvjbYBxHdrE9cmpZJ5n9Unrm6ThbBQM4KHN7ufPWb/KmI5picp05pr
	 F6NZ7UZdrZCWlWuCk/mc+V8tfLpWFjjGYp/yTxWnGIEgNpOneydqSCkNoELuenK6FVw1p
	 LodUXLHOfwwo3wn1Ak8hFMc3aeKf9BzvybTo7rBfVhQvTlQZ3RjM+czp4Qip8kOIJYnjm
	 Syg2fnTDUOf60i8DhFbS0huKhTpSa+f9m0i7ban9ZJOmlAlAoFv+k5S5te3TmF4fdBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rudorff.com;
	spf=pass smtp.mailfrom=rudorff.com;
	arc=none smtp.remote-ip=193.31.26.27
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3B5606D825;
	Wed,  4 Nov 2026 13:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D3B5606D825
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 5007640CBF;
	Wed,  4 Nov 2026 14:02:39 +0100 (CET)
From: Christoph Rudorff <chris@rudorff.com>
Date: Wed, 04 Nov 2026 14:02:29 +0100
Subject: [PATCH v4 3/3] arm64: dts: qcom: msm8916-samsung-j5: Add proximity
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
Message-Id: <20261104-iio-light-gp2ap002-v4-3-fa1cbaad2ce5@rudorff.com>
References: <20261104-iio-light-gp2ap002-v4-0-fa1cbaad2ce5@rudorff.com>
In-Reply-To: <20261104-iio-light-gp2ap002-v4-0-fa1cbaad2ce5@rudorff.com>
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

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Christoph Rudorff <chris@rudorff.com>

v4: moved declarations from j5-common to j5
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

