Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71263AFB0C;
	Thu,  6 Aug 2026 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045767; cv=none; b=jXcEgX6NG4VtGKKUZzQcQbZHm2gB8Bi/HhK7enU83AN+YoNjtFMDXe3U8eI6Pb9Bf22zOuWof0EKtsogETvEvaxlJH3hwydf9X3tMPNFzU52zxmRwWp2b++NM2du/ZMfl4t+dkrRNlnRRyM7qe0/fB8v5k57qyq4KduCA63bSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045767; c=relaxed/simple;
	bh=HOw79g3ooG6NNzkyYSEvjfgfmCBbxswKnKtrHqLTX78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPQEDsCYkh46ZrHGL/krmmszvyJ4b0WyxcKfUzk7q1plRYJAzMsbsO/aaEXylZ0r4x/yNF884FyHdZ6pLji1H4KO0wMpTcz/UgazscQlqnoJMEOqzUWxryfZtBFDovSga4gqf1Hujvn2IF13wpygbZuMFAeJc3+XwYwBTFga6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CQViigoh; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CQViigoh"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 752B541912;
	Thu, 06 Aug 2026 21:49:14 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0eZVW6ZCSgtJ; Thu,  6 Aug 2026 21:49:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1786045753; bh=HOw79g3ooG6NNzkyYSEvjfgfmCBbxswKnKtrHqLTX78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CQViigoh1Wj77XqViuITPP0uHfgEnK9TNml11c6Ts3lTlvg1xSNhnuAVswN8r0Wgj
	 VsYmzBXJEmCFqZGI1iV9yN2pjaqwNGSL+2RRWakxEToMXP2wiIdvC8S/F5Xf49/GqW
	 /vyXD91CzLpzzW3H6RpHYb8fxVOtXPmkJsp3Ko4EDCWUCURKFME5eTp43vn5bZ9aFO
	 z1QDPdoXuH45RzXQ+jQv+7S6gEvAuxeDs0lxyZLdl0IYW1s2KNF2pHaNVqVVEwxT3i
	 Y6VU1QYzc13+aGGmXWa7R7uHyZVf4TV94NFvUduO8Cqj+DHTJq8BQ4SwdYq7Q2e2AY
	 p65AvPOm0dqkA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 07 Aug 2026 01:18:43 +0530
Subject: [PATCH v4 3/3] arm64: dts: exynos7870-j6lte: add Sharp GP2AP070S
 proximity sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-gp2ap070s-v4-3-74f6a67b6272@disroot.org>
References: <20260807-gp2ap070s-v4-0-74f6a67b6272@disroot.org>
In-Reply-To: <20260807-gp2ap070s-v4-0-74f6a67b6272@disroot.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org

The Sharp GP2AP070S is a proximity sensor, which is connected to a
GPIO-driven I2C line. Define the devicetree node for the sensor.

The sensor requires two voltage supplies, one of which is from the
primary regulator bank of the device, while the other one is controlled
by the GPIO. Add a regulator wrapping over the concerned GPIO so as to
feed it to the sensor node.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts | 55 ++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts b/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts
index de30d0970336..dd493138fed6 100644
--- a/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts
@@ -73,6 +73,35 @@ key-volup {
 		};
 	};
 
+	i2c-proximity {
+		compatible = "i2c-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c_proxm_bus>;
+
+		sda-gpios = <&gpf4 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpf4 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+		i2c-gpio,delay-us = <2>;
+
+		proximity@39 {
+			compatible = "sharp,gp2ap070s";
+			reg = <0x39>;
+			interrupt-parent = <&gpa0>;
+			interrupts = <5 IRQ_TYPE_EDGE_BOTH>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&proxm_irq>;
+
+			vdd-supply = <&vdd_fixed_proxm>;
+			vled-supply = <&vdd_ldo33>;
+
+			proximity-near-level = <500>;
+		};
+	};
+
 	memory@40000000 {
 		device_type = "memory";
 		reg = <0x0 0x40000000 0x3d800000>,
@@ -94,6 +123,16 @@ vdd_fixed_mmc2: regulator-fixed-mmc2 {
 		enable-active-high;
 	};
 
+	/* proximity: vdd */
+	vdd_fixed_proxm: regulator-fixed-proxm {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_fixed_proxm";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		gpio = <&gpd2 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <1>;
@@ -354,13 +393,12 @@ vdd_ldo32: ldo32 {
 				regulator-ramp-delay = <12000>;
 			};
 
+			/* proximity: vled */
 			vdd_ldo33: ldo33 {
 				regulator-name = "vdd_ldo33";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-ramp-delay = <12000>;
-				regulator-boot-on;
-				regulator-always-on;
 			};
 
 			/* touchscreen: vdd */
@@ -556,6 +594,13 @@ pmic_irq: pmic-irq-pins {
 		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR4>;
 	};
 
+	proxm_irq: proxm-irq-pins {
+		samsung,pins = "gpa0-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS5433_PIN_DRV_FAST_SR1>;
+	};
+
 	touch_irq: touch-irq-pins {
 		samsung,pins = "gpa0-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_EINT>;
@@ -579,6 +624,12 @@ bt_enable: bt-enable-pins {
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 	};
 
+	i2c_proxm_bus: i2c-proxm-bus-pins {
+		samsung,pins = "gpf4-3", "gpf4-2";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	wlan_enable: wlan-enable-pins {
 		samsung,pins = "gpd3-6";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;

-- 
2.54.0

