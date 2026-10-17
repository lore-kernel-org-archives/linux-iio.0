Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373483BAD9A;
	Sat, 17 Oct 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.31.26.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258099; cv=none; b=StcoNDwhQfM0dU97+BdBikmfkOjbDqmkdw2ksBCFb9eBhKwDa2poSzeKQQCvMd6Q0gmkZ8MQD4/+DXnLb5vBjFN5lSrY2GjeuteVlysGNnqvb+k0PoPd82k6afyaCZcJ/dzuNw5V5ZcAZuCFA1wYMEjBexiyxI27lOHeNPPwZvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258099; c=relaxed/simple;
	bh=ABcq3Lc9i5MMedi2tYiLtwKYFlYVmP0IKvWUNjF3Fpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xhnum5ST6vD8PasasiYNBGh2UPA8/0f5KuIenPHUn3VbGHTNmaHwFrnRIiSlMtFAXerEnMuNx1Y3iIL4gmzEJgtFD2GfTg4T0lR+MU5wK1HWenmyckG1PUJv1EWmsMvFVqy+AN5cIFbnlU7pbn6KkgLndKuOHN96xLYJPnDxUWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com; spf=pass smtp.mailfrom=rudorff.com; arc=none smtp.client-ip=193.31.26.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 1A2A140CFA;
	Sat, 17 Oct 2026 19:28:09 +0200 (CEST)
From: Christoph Rudorff <chris@rudorff.com>
Date: Sat, 17 Oct 2026 19:27:43 +0200
Subject: [PATCH v2 3/3] arm64: dts: qcom: msm8916-samsung-j5: Add proximity
 sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-iio-light-gp2ap002-v2-3-d6879767a446@rudorff.com>
References: <20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com>
In-Reply-To: <20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com>
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
 .../boot/dts/qcom/msm8916-samsung-j5-common.dtsi   | 15 ++++++++++
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts    | 32 ++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index 697f25d51d9d..292e7d8b85a4 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -149,6 +149,14 @@ &pm8916_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 };
 
+&pm8916_rpm_regulators {
+	pm8916_l17: l17 {
+		regulator-name = "proximity_vdd";
+		regulator-min-microvolt = <2850000>;
+		regulator-max-microvolt = <3100000>;
+	};
+};
+
 &sdhc_1 {
 	status = "okay";
 };
@@ -248,6 +256,13 @@ sdc2_cd_default: sdc2-cd-default-state {
 		bias-disable;
 	};
 
+	proximity_int_default: proximity-int-default-state {
+		pins = "gpio113";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	sensors_i2c_default: sensors-i2c-default-state {
 		pins = "gpio31", "gpio32";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
index ba8650971d6a..efd6c0357d53 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
@@ -8,6 +8,14 @@ / {
 	model = "Samsung Galaxy J5 (2015)";
 	compatible = "samsung,j5", "qcom,msm8916";
 	chassis-type = "handset";
+
+	reg_vled_proximity: regulator-vled-proximity {
+		compatible = "regulator-fixed";
+		regulator-name = "proximity_led";
+
+		gpio = <&tlmm 73 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &accelerometer {
@@ -19,6 +27,21 @@ &blsp_i2c5 {
 	status = "disabled";
 };
 
+&i2c_sensors {
+	proximity-sensor@44 {
+		compatible = "sharp,gp2ap002s00f";
+		reg = <0x44>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <113 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&pm8916_l17>;
+		vled-supply = <&reg_vled_proximity>;
+		vio-supply = <&pm8916_l5>;
+
+		sharp,proximity-far-hysteresis = /bits/ 8 <0x2f>;
+		sharp,proximity-close-hysteresis = /bits/ 8 <0x0f>;
+	};
+};
+
 &pm8916_codec {
 	qcom,micbias1-ext-cap;
 };
@@ -30,3 +53,12 @@ &touchscreen {
 &usb_hs_phy {
 	qcom,init-seq = /bits/ 8 <0x1 0x19 0x2 0x0b>;
 };
+
+&tlmm {
+	proximity_ldo_en_default: proximity-ldo-en-default-state {
+		pins = "gpio73";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};

-- 
2.39.5

