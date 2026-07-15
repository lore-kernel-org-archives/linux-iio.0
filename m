Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42533434E56;
	Wed, 15 Jul 2026 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115726; cv=none; b=GcSGQyTcAOPaIw60/Rc5Cp/lxAAEf63r4wjVQXL8jLRnePAMHCmGLmnrTwqp89ZQE4IT6TEvoD/xMuhGs0GUiBtI62oLJ9+0YUoc1njmf/9OvRjLv2gCUqU66WgP4VA/gkj0v44ROMOVNW4azL/joowSFGQMJW4wTCnsip6Wx/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115726; c=relaxed/simple;
	bh=GcaTqK/Pbq3QtOtDwNCr+Q7I70YtSCZlG2i+a+I8Hko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MeY60OgWanHYoxaEAsfdFy7WeGyU5xYYDvDXt/jS/vZxJSQ+D4ryE63VSTL1sRVkUjYwVCv1BNRLSm2FDeS5jicC/6ufVoU8yqeBmxU0xrU63oszvIcguV9umjcuI1znhBcxwgA/5mP0W3qpRfGQ2fU7XgTw+UEDlfGd2NZZZv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FByqSZSK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FByqSZSK"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBaWc2680436;
	Wed, 15 Jul 2026 07:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dyKvn
	UAZzjSM0gd6JMejcihkiV+pzNAaI+oPtDryTUI=; b=FByqSZSK1phDiM60JTPUG
	FA1c56WFCjNbZ0kylE1fvCX9sst6+dbV7DcEkxUoxtVWzj6ZBnFxMLM9tjhCziaC
	D42DL9c1/YCnOAvDCcN/+gnpDSkxCxSA9zVy78ytxN9mhjPR5SwHzad7hG96iBMG
	DdYAawbuHfKIceU8+nBglwP/nfb4LQtLmOIskmKzpHb5lSKd74Etxdsufjxw/6Dc
	Xeiq14ewX5lR3sC1d1H4hgNE8kwJo6yAo/7HcGhsB5FxLfIWUzkGd2R/W4g3s1Co
	WPjAiZfgo0Wqd3ycT3pmIY9bCnyGI1YVo8agS29ZqSGYEvFv0mlTFSkBet93yxuQ
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fe70e0hwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 07:41:44 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66FBfhHW004924
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jul 2026 07:41:43 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 15 Jul 2026 07:41:43 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 15 Jul 2026 07:41:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 15 Jul 2026 07:41:43 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66FBfASt024964;
	Wed, 15 Jul 2026 07:41:36 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 15 Jul 2026 13:41:07 +0200
Subject: [PATCH v6 4/5] dt-bindings: iio: dac: Add AD5529R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260715-ad5529r-driver-v6-4-cfdf8b9f5ee3@analog.com>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
In-Reply-To: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>,
        Marius Cristea <marius.cristea@microchip.com>,
        "Marcus
 Folkesson" <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784115670; l=8062;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=GcaTqK/Pbq3QtOtDwNCr+Q7I70YtSCZlG2i+a+I8Hko=;
 b=LxfKHFDjfxsrLnKP9GVsj/qsI5OGlljyVSjeJHZm2p+XeDqVOieHaJKXIEFWJcRJUCY5cPfcm
 2+fMsw1PEdRB0yWGCJeG5W3yJLA3k0Whgc4oMe1P2xNqi4fFXdFRGhE
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDExNCBTYWx0ZWRfXzKSn9G2in99p
 iuzg6OcEq9iEWer8+JBCFEC0w/zq4xbCrjfEoaU09kAnwra724QoiuupBfoC++V6/R5NWPE2dqT
 AUzU5Ze2AoFLIPTraf6zYyLN8Jg+fhc0c/CIT/nyrFoQ+tVtnqs/8KWFRhiuTGdzrWOhsEkaRdq
 +M9MwVnWUB5d4uXS2AFVPfQ7bYsnAoWna8VZ6ncvKtBi7N3Gm+lNH51UgxDjGiLhPpi5dpmXe2u
 4CARGN/FqN6nZaHm8zvH9XnPJRQEYOgNtRibyPgOxWKBO4AyKHl7tXRpv86DUUpe1fv0V0FPoU8
 zZY7l74mJ4QoJ/xLe4/SMFQhD8cnlXIx9AVZdlfjMLnj9Pz/96CTdxQPejGsfAEZGSokwbW1tnR
 hTHPmf/Pw0VGRf92YKKh7eQOvN1SDg3RZlqBnojasPb2AcjGaeg3BrVcI9DxpDk7R/4txUUlt/S
 yJk4GIPkwatLhAJwhtg==
X-Proofpoint-ORIG-GUID: 1CtsNJmEUNs3H_xj5LIJwD-rp_xbdICZ
X-Authority-Analysis: v=2.4 cv=XsLK/1F9 c=1 sm=1 tr=0 ts=6a5771f9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=fZh2jaQoGc6LPhG7F3gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDExNCBTYWx0ZWRfXyVmiSY2WDzW0
 Rorf3CxE6BJ0fjXxBhFQpQRItc3pUTmtIxQZTs+m1ZaDSI3NW962gV5+x+i0GdG41lHz3nab3W2
 Yq3WpoSxUiv2KlRVnDNViloWaC7ytoja2lHGGxbgZmDfNwaUgyKM
X-Proofpoint-GUID: 1CtsNJmEUNs3H_xj5LIJwD-rp_xbdICZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150114

Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
buffered voltage output digital-to-analog converter (DAC) with an
integrated precision reference.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 224 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 231 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
new file mode 100644
index 000000000000..730206fd6eab
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
@@ -0,0 +1,224 @@
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
+  spi-device-addr:
+    minItems: 1
+    maxItems: 4
+    items:
+      enum: [0, 1, 2, 3]
+    default: [0]
+    description:
+      Hardware address of each device, selected by the ID0 and ID1 pins.
+      Up to four AD5529R devices can share a single SPI chip select.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^channel@([0-9a-f]{1,2})$":
+    $ref: dac.yaml
+    type: object
+    description: Child nodes for individual channel configuration
+
+    properties:
+      reg:
+        description:
+          Flattened channel number across all AD5529R devices sharing the chip
+          select. Within each 16-channel block, the physical channel number is reg % 16.
+        minimum: 0
+        maximum: 63
+
+      output-range-microvolt:
+        description:
+          Output voltage range for this channel as [min, max] in
+          microvolts.
+        oneOf:
+          - items:
+              - const: 0
+                default: 0
+              - enum: [5000000, 10000000, 20000000, 40000000]
+                default: 5000000
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
+            spi-device-addr = <0>;
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
+                output-range-microvolt = <0 5000000>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                output-range-microvolt = <(-10000000) 10000000>;
+            };
+
+            channel@2 {
+                reg = <2>;
+                output-range-microvolt = <0 40000000>;
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

