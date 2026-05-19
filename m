Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B07128000F;
	Tue, 19 May 2026 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205451; cv=none; b=Ge3sU7t3rxXnfD6MnQlJ/JEwctqtLgCwEqfXA0a36TcUHFUekglEN44x9HJBn+i7auEq7VHxN7CZ3V6bCOnKqM7f/CQzwulwbgyCQ9R1X147fZz8dZ5iWrVsTiwYzAF/pjgWXW8GowxvAUwvTu2cELvBD7Be/aQ2pFdo5C6IHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205451; c=relaxed/simple;
	bh=vKUtYSQbL36jzFEaMLERB1nNc4Tf4GIyO8/yxNj+gXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hA5BSxBhnFjRbWk73Ilzmg+npY2I4ikjIuLVIIVYRTU6G38iUdC7TEPu1jHX+06Eup8O9O607GJM2J1+7CdzzSTazd7ytXeZCApu05pqqFKDaEhAhGYjei1lJj/EaxCGi8QSidGOXz48IQkpUIewUJ9HAXgCBVXZmRvdD/SDYpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=avV4Ku3T; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="avV4Ku3T"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JEgY75676084;
	Tue, 19 May 2026 11:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+SHG0
	+AIKKbu3Gq7csIchUiwxI+Yo3y3g5ODYOj4xaw=; b=avV4Ku3T4NppTMbwEpyqS
	F1XEqXdjtRG5FP91OJN3mJVpP1cn0q/onNL2hz8+9QJfhq0hQWoal1Tnjtankouz
	3x7PNZ3Wd6GWXH8QKIzJ78Gp8Rv2u8ezLmri5rAUsLrVv0Z4IuaUagP5Asiy8rAZ
	HQAr0WjwyeICYXMWgp0kAXO7hAXo/OQFq+UJOV5EBMMFHw4Ca4R6UWtqzYIB6wrJ
	5lLmcx3p3q7Pgk4jS7Teyf21mLKUyhpMDkVDvIwllul8h7SgYjBiY8Yx2U0w4IjV
	V8iiBJYvVcJwEsVCB7wTn5zoS87avdDXT9SsQxbvoHcA4yV2WeXymEQKXYyi4fYI
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e79we17f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 11:43:38 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64JFhbfn019218
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 19 May 2026 11:43:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 19 May
 2026 11:43:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 19 May 2026 11:43:37 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.80])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64JFhKZ5024062;
	Tue, 19 May 2026 11:43:32 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Tue, 19 May 2026 17:42:58 +0200
Subject: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260519-ad5529r-driver-v3-1-267c0731aa68@analog.com>
References: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
In-Reply-To: <20260519-ad5529r-driver-v3-0-267c0731aa68@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779205400; l=8021;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=vKUtYSQbL36jzFEaMLERB1nNc4Tf4GIyO8/yxNj+gXg=;
 b=DTfFiaX8MMPqp0LpEaTFYuUSKpDskjfy3Q1okYezPZXfdbIzS8/P6E1q0Jt06TPW7e96G/4KO
 u7sgDL7sCRpBxXkGbKX52QHUcsHMirfDxKXqEcs6W9XqSd/4zu99Spm
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: wADrZLdzHRhgbE5o-GyFa24xkIR1SY9Y
X-Authority-Analysis: v=2.4 cv=HKbz0Itv c=1 sm=1 tr=0 ts=6a0c852a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=fZh2jaQoGc6LPhG7F3gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: wADrZLdzHRhgbE5o-GyFa24xkIR1SY9Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE1NiBTYWx0ZWRfXyu/+NlmCQxKF
 rotoGK/lxTGgR1SpkOPR2fS14bxbBclEdMNj6blMdaPxVjFG1d9i3epPIYNvsBV2sE5cnGrm/sv
 ym+q+JdQpZWlHL244T2SDhqno+17hVgwXQm+9vHOXvS15vJH6/1A36NXDt3NMGjOxq88cG7nf3n
 uS87vOB7b/UHoSg6URtTBqR1OWZd6z72H/fLad6pCv28Qa0zl7qzYzsFNg9MJ/oUNRqqX7JtQmv
 B1Ulb1OAak0mxpsp44U5v2AnCh5vGhiwADnWmWzrqVvPy3PdRhxAQXZaPK8y7j4+aZ5zDLbIYgs
 8zepFzvcpiAliiQgqVFZVoRjGVN7hQYzeK2PBXHqiRwY7QcvQsla1tPwhNDp7H4fazBi6vrqxyU
 ACnIb9lloKz5L8yV+NA83jnPKABbZXVLXZZrEsQpxOTr2GLGa3zotLaNKF4PT3WtBLJyuTCLRmu
 GxQr2vwR2fCkKB1VftA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190156

Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
buffered voltage output digital-to-analog converter (DAC) with an
integrated precision reference.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 217 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 224 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
new file mode 100644
index 000000000000..eb66f6ca063d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
@@ -0,0 +1,217 @@
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
+  The AD5529R is a 16-channel, 12-bit or 16-bit, high voltage, buffered voltage output
+  digital-to-analog converter (DAC) with an integrated precision reference.
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
+  tg0-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the TG0 toggle pin. Pulsing this pin allows all
+      selected DACs to be updated synchronously for coordinated output changes.
+
+  tg1-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the TG1 toggle pin. Pulsing this pin allows all
+      selected DACs to be updated synchronously for coordinated output changes.
+
+  tg2-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the TG2 toggle pin. Pulsing this pin allows all
+      selected DACs to be updated synchronously for coordinated output changes.
+
+  tg3-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the TG3 toggle pin. Pulsing this pin allows all
+      selected DACs to be updated synchronously for coordinated output changes.
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
+      High voltage negative supply (-22.5V to 0V). Required only when using bipolar
+      output ranges (±5V, ±10V, ±15V, ±20V). Supply voltage should be
+      chosen based on configured output ranges (see datasheet Table 9).
+
+  vref-supply:
+    description:
+      External voltage reference supply (4.056V to 4.136V, typically 4.096V).
+      When specified, the device uses external reference mode and the VREF pin becomes an
+      input. The device uses the internal 4.096V precision reference otherwise.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^channel@([0-9]|1[0-5])$":
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

