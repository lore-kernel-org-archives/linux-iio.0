Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38933BB9EB;
	Thu, 20 Aug 2026 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787209774; cv=none; b=ZlQr85Tkkl9Kol6/XhIoGNGUBtD73Wne0hyqaIPdnVFwzrUzuatJtToWXHnyEFxOymq5ROOXj5bTg2fPk3RNvGTcEwj6Al38wRU3Po0QgecGIXRo5O4GNlROwT+ev0uutZ1zCgm7K9REzgVjXFWbhDHRpjPJzMLi/4eK9dC5ZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787209774; c=relaxed/simple;
	bh=MXKdOZpCM1FPMB1cHTo/QJDSTNOf9pX3eF4RY9JI/uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=deWpsw1JaXvjHkjTsNSPZNvi0gIck7OXKyrwzW9yvUdO3shCzwtSKp80QAfbiB2u5bGIbg0KlDhQDlWZ2k3bb+6z4Wh1SdSiv05nyba1M2kacCSQp/UbHP5HQjyBO9AK/99BBvwREb6vFLxDPZHIqu4QVhbMUC4nF1sIE3RZKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=T8UZQwrX; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="T8UZQwrX"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K74fxE2445763;
	Thu, 20 Aug 2026 03:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3Ndwo
	EndMuJU2g6LD4o+Mb6YaN2eWHZ+1AKTMnboCCY=; b=T8UZQwrX15u0qM99zaXVa
	P+t+vsGzZx6OH1sp/D6L5qFTJEIqcpcOqt9p41pBlhIs//byAriEUzY0xd1nwhVB
	zZUzR2pRSNRp4MCNm7OLOFgHVt8zJfD2yfhwjZ2eGlr4u+ZeeneATMNy6P66P4uo
	3mPy41IxjqaMojjndyS/ba2HF0gP2FKdacSvChSbRTEQGKXXIcIm3Y241wYG6V05
	Nf27w6Ww8xQGpbiwRyBTcLUunK2ATjNv41JGKbJ7gU60a/+n9mHJBQ2MUfxM08C5
	eRzT+4r2y1U4Slex0JpoyDbNdqnCW7lZGgdLtmg3y/A6yM/H2PHTaKoG+HzKsmVZ
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g4yeps9y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 03:08:58 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67K78v5C018801
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 20 Aug 2026 03:08:57 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 20 Aug 2026 03:08:57 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 20 Aug 2026 03:08:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 20 Aug 2026 03:08:57 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.68])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67K78Oka003019;
	Thu, 20 Aug 2026 03:08:48 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 20 Aug 2026 09:08:22 +0200
Subject: [PATCH v9 2/3] dt-bindings: iio: dac: Add AD5529R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260820-ad5529r-driver-v9-2-ba62e0b2a816@analog.com>
References: <20260820-ad5529r-driver-v9-0-ba62e0b2a816@analog.com>
In-Reply-To: <20260820-ad5529r-driver-v9-0-ba62e0b2a816@analog.com>
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
        Kent Gustavsson <kent@minoris.se>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara
	<daire.mcnamara@microchip.com>,
        Paul Walmsley <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>, <linux-riscv@lists.infradead.org>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787209704; l=8983;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=MXKdOZpCM1FPMB1cHTo/QJDSTNOf9pX3eF4RY9JI/uo=;
 b=a6HQJLJ9lRKqMmLJclZI29tKN3NIadsZc0V+8Yxw5JEQ7lcG2hwaw7xyBhlHUmxU1OfQylUu0
 dvVHlcEnSKrCm3faci7eXJsN5KSjdikW6NnztRGD304xVzS7f+InRZQ
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ImBfcdlNjYSuM1ReKO155h680FdCpb2v
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1MCBTYWx0ZWRfXzrKagiBMvHkp
 0rMOPDFZ/C2FPUvdzv3kjyaH1PD9FhCXUX1A2kgxhBZMCMaxKKHr6v8dQzSkiN6MGcppJuKTuP7
 uEt+8FdEhhHSoQBBv8yDSNCu3KYf9tpDhcIeXwxiTKpQiA0D9/xI
X-Authority-Analysis: v=2.4 cv=NLHlPU6g c=1 sm=1 tr=0 ts=6a86a80a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=w-5zq-aVFruw5tgyEi8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1MCBTYWx0ZWRfX9gpUR2m59fhG
 S0999JoE8n4904AL7oZqVAC+h0Pz3Vmn3YCU9tDjOa9hUJHF3knAxu1byjmAcfHjkGnEerA9yEi
 U66F9MW0SqYfG8/ZohhHh6xEOxylQ6D+2SFfKX3zP0BObXqAaUjPgLc6xUnqs0eYD3mkhONfqOF
 6uOnu/Q3ZjWwGBM37ACXbA6vJTZvjI8c97D3dxkscKzChPvvmY1y/DRns09WAyYoPsxNVgbY2z6
 rBsPmDtmNhKZY9U/h8D20vUxt8GtkWJnT/NyYNxPlzab3M4IsI8AjHXhkvve8IWeuWIloNVzc7g
 p+4plasuxSL8++b6diARfp47WtktOOuDem74LWUcOC30pfXeACSVSlP2HocHe5/RfiqPNS4rlIM
 HJ1FV+m0LpfbtXX1Gg4HhbT/U2zkzubpot26HA08fm/ZclLHMuehA0JscrkMc5JGOqK+1ZsEvgL
 d8ZampFacCiFWiGSrJw==
X-Proofpoint-GUID: ImBfcdlNjYSuM1ReKO155h680FdCpb2v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200050

Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
buffered voltage output digital-to-analog converter (DAC) with an
integrated precision reference.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 254 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 261 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
new file mode 100644
index 000000000000..9c390d460e5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
@@ -0,0 +1,254 @@
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
+  vdd-io-supply:
+    description: Digital power supply (1.08V to 1.98V)
+
+  vdd-5v-supply:
+    description: Analog power supply (4.75V to 5.25V)
+
+  vdd-hv0-supply:
+    description:
+      High voltage positive supply (7V to 45V) for channels 0 to 3.
+
+  vdd-hv1-supply:
+    description:
+      High voltage positive supply (7V to 45V) for channels 4 to 7.
+
+  vdd-hv2-supply:
+    description:
+      High voltage positive supply (7V to 45V) for channels 8 to 11.
+
+  vdd-hv3-supply:
+    description:
+      High voltage positive supply (7V to 45V) for channels 12 to 15.
+
+  vss-hv0-supply:
+    description:
+      High voltage negative supply (-22.5V to 0V) for channels 0 to 3.
+
+  vss-hv1-supply:
+    description:
+      High voltage negative supply (-22.5V to 0V) for channels 4 to 7.
+
+  vss-hv2-supply:
+    description:
+      High voltage negative supply (-22.5V to 0V) for channels 8 to 11.
+
+  vss-hv3-supply:
+    description:
+      High voltage negative supply (-22.5V to 0V) for channels 12 to 15.
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
+    default: 0
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
+  - vdd-io-supply
+  - vdd-5v-supply
+  - vdd-hv0-supply
+  - vdd-hv1-supply
+  - vdd-hv2-supply
+  - vdd-hv3-supply
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
+            vdd-io-supply = <&vdd_io_regulator>;
+            vdd-5v-supply = <&vdd_5v_regulator>;
+            vdd-hv0-supply = <&vdd_hv0_regulator>;
+            vdd-hv1-supply = <&vdd_hv1_regulator>;
+            vdd-hv2-supply = <&vdd_hv2_regulator>;
+            vdd-hv3-supply = <&vdd_hv3_regulator>;
+            vss-hv0-supply = <&vss_hv0_regulator>;
+            vss-hv1-supply = <&vss_hv1_regulator>;
+            vss-hv2-supply = <&vss_hv2_regulator>;
+            vss-hv3-supply = <&vss_hv3_regulator>;
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

