Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840403ACEFF;
	Wed,  1 Jul 2026 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888099; cv=none; b=dYDGj9tUIxT8wLWp3B6EMRdO/uCKHv9rpxH4OtyFx3RHqUyoaOrkDI9p07n5SSFhBPkJc+uhY2nKkbCGy86U/4RWPOh2BW8tyIgQCT7k7lhoz7Amwqyzc18MsSqz6N7TsOmvzNmPQPfvPyDFP37dcbqvtV6fh0jXX1jH6+5yXdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888099; c=relaxed/simple;
	bh=uIS4dvG5rtesQR/00rZIroGZMSw1FE+fdh4mhV5pyz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uY3SRAxUYPIfTnn7HK/zc7kuC8lYqnpFCFOvlISbOJ3zwMdWJuBDSvALIZfwFyRnVfCbo2pN2QpI8WlM1dQIS5HDkNfMlHvQFWBi8IqoBGuxxTs316GRU56WzJGfpbjmugBbVk7F2awT9SnbmOztv+x8F4i3YTd8traqWsPF4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CJttXjRT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CJttXjRT"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6612vtDr2558082;
	Wed, 1 Jul 2026 02:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZBQln
	lyrxF8EB1d/K5Qe7zQW2cvORyRuXCg+r5YMeTg=; b=CJttXjRTvgjWMf2Lh+yDr
	4m/vArYV4KlvE3IVeHplEs5EdgmRgtYGBd1lIqEW57LPdmylx25uVMwoSzgxJV07
	/lXk7QcQnP08DM4FKjxnXjosgcCpHbA+RoIG5JzGzuPBlXm2UZQwHLX3jRyWqeOc
	r1QdQswVhTpijbPwJGloiFpKKEtuahSvokFuLW61izS2eb8TsTD+3/TunijwdqOZ
	nGD3E3VXsIbiuohOx+uGnuuV9NYaYiYfWE1uIfXXhL4e1TJInM7SKdv9OYnl+fvf
	AwIMV4ScYiVBSQ8wf6ULOU3144KGmqneoOYh2ceAWxNXi2EaPzrXzsbghai11qYv
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f48ehdy09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 02:41:19 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6616fHq1061216
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 Jul 2026 02:41:17 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 1 Jul 2026 02:41:17 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 1 Jul 2026 02:41:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 1 Jul 2026 02:41:17 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.62] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6616etNA002283;
	Wed, 1 Jul 2026 02:41:10 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 1 Jul 2026 08:40:40 +0200
Subject: [PATCH v5 2/3] dt-bindings: iio: dac: Add AD5529R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260701-ad5529r-driver-v5-2-ed087900e642@analog.com>
References: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
In-Reply-To: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
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
	<broonie@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Janani Sunil
	<janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782888055; l=7944;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=uIS4dvG5rtesQR/00rZIroGZMSw1FE+fdh4mhV5pyz8=;
 b=yTYBLTsmcinbbMxeuQiI+AYrHn6dM4AthbqiKY2z+BC0scUlEfqLagtLdEoyNR9xQraBbCxNm
 LKyg9AT7zmxD2Y2OZUJCzDyqZSibpERMc54Mlpr9hETT4WEKH0SfC74
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: gbEtRl309wyAzRz72Otp6Qk1LY_y8Og1
X-Authority-Analysis: v=2.4 cv=O/sJeh9W c=1 sm=1 tr=0 ts=6a44b68f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=fZh2jaQoGc6LPhG7F3gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: gbEtRl309wyAzRz72Otp6Qk1LY_y8Og1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2NyBTYWx0ZWRfX4vrsiSx4MbnY
 ljmt7gxjZi61lVv4Ar66hvG8zQWeU5xzzJS/Jy5Rh4w9SUOy5XJvVUASA7ZKPmXq3rBABX2t+LM
 wEBOqEme24BOI3+/GpdYIxJlKRAj8YPJ3VqZsenw01lfu/JD/wJ/D7hy+D2/pHb2TZr6rkjt7eG
 P//RJ/GvDMKOoQHLE3DP87vmboNUNBaQcSwwJT/NvDKFd72CpIqGVzpXaTDrLRh/VBQb/8hYr8m
 k2fBZA2hIhWavrXxI7y8ZrQUwhPADrwRQdAy1w2cGt2SMP4ykSN85bO+EWUeL9eYCANTl8DLZoV
 6EhrbHJSCRLDkjkjaCj6INJij1Oe6jPxLEWg4io9znSOHYbVqrej/9FRfz//bp+dCw/88bGM4Qm
 K8QvaR8FIQ07fQxUnzPgRw37yYeRKnHIo3lqx/If7QFr0jOVMletHGcCnnqfQN569J2tUkfBaJA
 jIZaoFEbdgjtU/dbyYQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2NyBTYWx0ZWRfXwS+76qIzb29W
 3IW0AGeYBdvms6xgXw/fqx8u7d3ToSW3oNm/CFeCDb75fybgIMISD2sLywWpW/3y2Nm1MYHjXnY
 rrcojzXDH6AuzbEdEiMlJuwHnKCv6MDz4+3VHOfsFigBD46xy49k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010067

Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
buffered voltage output digital-to-analog converter (DAC) with an
integrated precision reference.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 216 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 223 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
new file mode 100644
index 000000000000..97075b1c919d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
@@ -0,0 +1,216 @@
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
+  "^channel@([0-9a-f]{1,2})$":
+    type: object
+    description: Child nodes for individual channel configuration
+
+    properties:
+      reg:
+        description: Channel number.
+        minimum: 0
+        maximum: 63
+
+      spi,device-addr:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3]
+        description:
+          Device address selected by the ID0 and ID1 pins. Up to four AD5529R
+          devices can share a single SPI chip select; each device responds only
+          to transfers whose address bits [13:12] match its configured address.
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

