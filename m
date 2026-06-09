Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA133431F8;
	Tue,  9 Jun 2026 15:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017291; cv=none; b=eTz/4/Z4Y7kbTo6IVtncszf1B659II1Cm+ocQX8DQ7L1seg44yWXWrPdBUuhLcdp7H4hZqbgBM6f++LUwcd+wlnX/zPuS6F0aopSDJLvM5u9d+khNoii/7aTnb5ZCfivztrmwQSDe273p5x2XfGCZx/2+J0BiumbbSB2/bo0oYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017291; c=relaxed/simple;
	bh=62K/6cKULbZb4J6hsXDEvw+CP07CrMSong2q3E1Dpdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=poQQU+6267KNfpe5+6S6E5sUXUgxCEcq1aw482rwKDVFKGh1in54Ks0kNjJZENYyoJBStP6PEUpduiJ1IBtWMcNzIk+MbsTdeMbOLaFh0MKtVbHc7QUkdsldOA5MuFb7AAC5chXkrRmhJ9tXUQL7fcYy0YFcGPs5YCRzXwdD+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=R1H9UI9D; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="R1H9UI9D"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659CndYa1026651;
	Tue, 9 Jun 2026 11:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cjsph
	s/3NvURu8liNvau2shy37ykBA+CVveVUOMIrzM=; b=R1H9UI9Di1h/pYwSdbfY4
	L8rNxtoawG/hSMu3kim2BIIPTed4u7NyZPtisDuGIfHT8P0cEPpGFBWmY813X/fh
	HdbYIrY/Eg51UvlLvLFRgjcTnywgqWqpjhXM8Pxl//8KGO+IVTQiZOHkoiqW3BdS
	msmn2YL5N7y0XHLz2eDNhgo4SgPo3gQSrb6BG0ZFaNQJXmcbqj37cJ1KwRZV0bqC
	NLd8NzaY7cSC72FZBeLg0ht0sLV3Gk1EMeB0Pd6hE7aRA/bFOejbsHbNNLNyCAgg
	C7ZetfnJhaJWz2h2uB9lt0N977Ds6hMyzUTy1WrKdO2XI8zWvksUh2JdpIuaf1cV
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4enstm63c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 11:00:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 659F0uF9007415
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jun 2026 11:00:56 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 9 Jun
 2026 11:00:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 9 Jun 2026 11:00:52 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 659F0au2031316;
	Tue, 9 Jun 2026 11:00:49 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Tue, 9 Jun 2026 17:00:20 +0200
Subject: [PATCH v4 1/2] dt-bindings: iio: dac: Add AD5529R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260609-ad5529r-driver-v4-1-2e4c02234a1a@analog.com>
References: <20260609-ad5529r-driver-v4-0-2e4c02234a1a@analog.com>
In-Reply-To: <20260609-ad5529r-driver-v4-0-2e4c02234a1a@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan
 Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781017235; l=7559;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=62K/6cKULbZb4J6hsXDEvw+CP07CrMSong2q3E1Dpdo=;
 b=wF2lkxbhj/sWtlWXRLmDCBakx0s0QRK1kuiyYoMKuo08Xc+CppXLai5lHNPp0i40neyyx3q45
 1x1R7PwwMXeDQjFr1xbJVX6nslnJ3qVJi3MfjZLzd6mMn/Z+/gSkRB8
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0MiBTYWx0ZWRfX9MPPM3SzEOrn
 PtGddXSOInZyw9BfbkD0B39ENI1q7Jkiw/ucx57Ikm5ITgIbJMjuMQV3Ejdos80hQWYSsaQgbT/
 OUFaliEYYDYAtamGE3N9QPxbkXLqW+DoRlAi/JYnPAZU1G/sOomNoC/A/82lkoDvGhSEh+CjpwG
 Oy+x4yHNW9Rl50gsOhJrM+xDr7jhJSbsX6Ars36RHr7p2Tg7jV5WdkuICit07Yug8uvsQApWou/
 gC9ZSXe7iV9xTadFbOEHSisS9h3U1l0EOPXE4VwS71TZXxI8v2qIhsCq/nRTIRH7ihEChwpZcwG
 KE01hvWsOfKm6TdhI8a6+I7QnVjFDu38jkh8hkifRIQkhVJ39IvABEqw86f7UgTN419up7JeVMK
 5/Tz41f0RLbhiEsp4XJyYfb1sVCuCFSMlESQRtLMNV5olzGOeuFKBzgvy+/hzbCYZVTw5TO/9no
 +OmZt6Bdk5jH9+t3kvA==
X-Proofpoint-GUID: flhoFuoAQVbls4m7fLRhdeUYr0RNfERy
X-Proofpoint-ORIG-GUID: flhoFuoAQVbls4m7fLRhdeUYr0RNfERy
X-Authority-Analysis: v=2.4 cv=T/C8ifKQ c=1 sm=1 tr=0 ts=6a282aa9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=fZh2jaQoGc6LPhG7F3gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090142

Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
buffered voltage output digital-to-analog converter (DAC) with an
integrated precision reference.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 208 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 215 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
new file mode 100644
index 000000000000..cc994f439be5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
@@ -0,0 +1,208 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5529r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5529R 16-Channel 12/16-bit High Voltage DAC
+
+maintainers:
+  - Janani Sunil <janani.sunil@analog.com>
+
+description: |
+  The AD5529R is a 16-channel, 12-bit or 16-bit, high voltage, buffered voltage
+  output digital-to-analog converter (DAC) with an integrated precision reference.
+  The device operates from unipolar and bipolar supplies. It is guaranteed
+  monotonic and has built-in rail-to-rail output buffers that can source or
+  sink up to 25mA.
+
+  Specifications:
+  * 16 independent 12-bit or 16-bit DAC channels
+  * Independently programmable output ranges: 0V to 5V, 0V to 10V, 0V to 20V,
+    0V to 40V, ±5V, ±10V, ±15V, and ±20V
+  * The device supports SPI communication with Mode 0 and Mode 3.
+  * 4.096V precision reference, 12ppm/°C maximum
+  * Built-in function generation: Toggle, Sinusoidal Dither, and Ramp waveforms
+  * Multiplexer for output voltage, load current sense and die temperature
+
+  Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad5529r.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5529r-16   # 16-bit variant
+      - adi,ad5529r-12   # 12-bit variant
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 25000000
+    description:
+      Maximum SPI frequency. The device supports SPI Mode 0 and Mode 3.
+      Read operations are limited to 25MHz maximum.
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the RESET pin. Active low. When asserted low,
+      performs a power-on reset and initializes the device to its default state.
+
+  clear-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the CLEAR pin. Active low. When asserted low,
+      clears all DAC data registers without affecting configuration settings.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Interrupt connected to the ALARM pin. Active low interrupt output
+      for overtemperature conditions, SPI CRC errors, and function completion.
+
+  pwms:
+    minItems: 1
+    maxItems: 4
+    description:
+      PWM signals connected to the TG0-TG3 toggle pins. Pulsing these pins
+      based on trigger edge settings allows selected DACs to be updated
+      synchronously for digital function generation.
+
+  pwm-names:
+    minItems: 1
+    maxItems: 4
+    items:
+      enum: [ tg0, tg1, tg2, tg3 ]
+
+  io-channels:
+    maxItems: 1
+    description:
+      ADC channel connected to the MUXOUT pin for monitoring output voltage,
+      load current sense, and die temperature.
+
+  io-channel-names:
+    const: muxout
+
+  vdd-supply:
+    description: Digital power supply (1.08V to 1.98V)
+
+  avdd-supply:
+    description: Analog power supply (4.75V to 5.25V)
+
+  hvdd-supply:
+    description:
+      High voltage positive supply (7V to 45V). Supply voltage should be chosen
+      based on configured output ranges (see datasheet Table 9).
+
+  hvss-supply:
+    description:
+      High voltage negative supply (-22.5V to 0V). Required only when using
+      bipolar output ranges (±5V, ±10V, ±15V, ±20V). Supply voltage should be
+      chosen based on configured output ranges (see datasheet Table 9).
+
+  vref-supply:
+    description:
+      External voltage reference supply (4.056V to 4.136V, typically 4.096V).
+      When specified, the device uses external reference mode and the VREF pin
+      becomes an input. The device uses the internal 4.096V precision reference
+      otherwise.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^channel@([0-9a-f])$":
+    type: object
+    description: Child nodes for individual channel configuration
+
+    properties:
+      reg:
+        description: Channel number.
+        minimum: 0
+        maximum: 15
+
+      adi,output-range-microvolt:
+        description: |
+          Output voltage range for this channel as [min, max] in microvolts.
+          If not specified, defaults to 0V to 5V range.
+        oneOf:
+          - items:
+              - const: 0
+              - enum: [5000000, 10000000, 20000000, 40000000]
+          - items:
+              - const: -5000000
+              - const: 5000000
+          - items:
+              - const: -10000000
+              - const: 10000000
+          - items:
+              - const: -15000000
+              - const: 15000000
+          - items:
+              - const: -20000000
+              - const: 20000000
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - avdd-supply
+  - hvdd-supply
+
+dependencies:
+  spi-cpha: [ spi-cpol ]
+  spi-cpol: [ spi-cpha ]
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad5529r-16";
+            reg = <0>;
+            spi-max-frequency = <25000000>;
+
+            vdd-supply = <&vdd_regulator>;
+            avdd-supply = <&avdd_regulator>;
+            hvdd-supply = <&hvdd_regulator>;
+            hvss-supply = <&hvss_regulator>;
+
+            reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                adi,output-range-microvolt = <0 5000000>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                adi,output-range-microvolt = <(-10000000) 10000000>;
+            };
+
+            channel@2 {
+                reg = <2>;
+                adi,output-range-microvolt = <0 40000000>;
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d6c3c7d22403..320e84765ce6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1507,6 +1507,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
 F:	drivers/iio/adc/ad4851.c
 
+ANALOG DEVICES INC AD5529R DRIVER
+M:	Janani Sunil <janani.sunil@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
+
 ANALOG DEVICES INC AD5706R DRIVER
 M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0

