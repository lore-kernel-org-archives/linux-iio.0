Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF7D3C81B7;
	Thu, 21 May 2026 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381932; cv=none; b=bLXshUwGTM0X/GcOjiForcP5hkuZBXeRndK0uJ2eheQKRdUNRXXFDTCyoHctRlyB0ww82J+HgT2R3apz+kE/NMoLxm6/Flxf6rfRvnaKIquG5d+J8+FW18ExYi1Vtegv6cAIKZTTPs6c30nTNAJOCuqBLWpei27I2FLwC/bO1Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381932; c=relaxed/simple;
	bh=sSdxgZR5BJKGj2mDWMjS5ITgCh5y3HwF3Xy5jRXCmvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/WBH9aSv3edKmnBdX9y3VhdY/Zhr9NKzo42krGq8OD5Le5z4erqngPSrsZDqLksTJH91jeypweVVRUFJwDt7dLTMj2ENlbXXZy1Frc6nz5JK+TrwNc8U7QSJP0LxNfcToEbvQhIAN+GnRZYQPZU6apbsbV3yy9VERFwU290pks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yIJcICUG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yIJcICUG"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LFgYeF602532;
	Thu, 21 May 2026 12:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VYj8z
	vPlf6NWOUubBRpWEGVhI/lxdXlGXS+JKG7AJfM=; b=yIJcICUG0I0Bz/7CCmOn2
	AR1/zW52xZaz/14xIFPGpMmNmTAcKiFeNkiz645SIjLPLom3cnWafGc+6oQb1LA5
	vXhg2+pN23s6TyEKryQaJizxxk2ER9sbfLz0sPsO0iA2X2iVHJzlQ9AbGzcmX+za
	w0vySkPBzFlF9Bm6ZOr2oqN117RptZ9iuwXzPpjp6dIVdI+/KrsWeFz4bJSVUxcj
	LwIeVtaR2/9X0FEh8uIH4ctum321qFXqNbmwaS0uGewdtZ2rdI3wQkXUBmSiaBzD
	1cFEALnxNWNYVVs/xMJ5RbKdrlJGJlZgtwZk0GR7spW4Pb6ZWzqGRYjmhLIBet1V
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e96sry1ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 12:45:28 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LGjRXI000413
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 May 2026 12:45:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 21 May
 2026 12:45:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 12:45:27 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.208])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LGim0r024538;
	Thu, 21 May 2026 12:45:20 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Antoniu
 Miclaus <antoniu.miclaus@analog.com>,
        Liviu Stan <liviu.stan@analog.com>,
        Francesco Lavra <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v3 7/8] dt-bindings: iio: temperature: Add ADT7604 support to adi,ltc2983
Date: Thu, 21 May 2026 19:43:00 +0300
Message-ID: <20260521164323.770626-8-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521164323.770626-1-liviu.stan@analog.com>
References: <20260521164323.770626-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: A9IxZtR7tD1iKPiQ4TiSkKUNZhA_H8bH
X-Proofpoint-GUID: A9IxZtR7tD1iKPiQ4TiSkKUNZhA_H8bH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE2OCBTYWx0ZWRfX4EGfnDfrJGOO
 bm96FYvMKtxNLlmGbqYB9yaEUmzcEAmK93i7AwTokv3I86jBI30LXmtnskLgco0rRmkCCdQEXfA
 VZL2TFfT9bi025GWFlKRcXKAW5IHv2mIfLGheZZlmOONywMfFyGWg8/Z7eUcwq7UUndPnzJv1MW
 1LfheDK28ffa0ch/rlPWIXd/6R8Xpdcpqj7OqgHaiwbuJlZVgoMO2mzA3t9SnTjLxt/FNZHLvmJ
 w5pBrLuQau5CC3cC4IaAlfUHRrDXHofqQSLVYMjwOJs8COyOhXC80OwFZZcC4jlfQCxoiVGC+Ji
 KFwOIZh+JFX1QLs3uv77Th6MVckJFf6ux9BC8zGVrrZmLRY4IA9g+FTeC54I1EWUmyxq3vOOtGt
 jBvuptKn6S8or/BFJ6VSG+xCHWq/KdRmmswRtl2cjGHARBe0qvUrWNMoKwkldXGfa5aVDwxUtnl
 4Viji2otxqI4h7g+lYw==
X-Authority-Analysis: v=2.4 cv=CZs4Irrl c=1 sm=1 tr=0 ts=6a0f36a8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=0NoqbZV6EB-ln6Q-UgwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=t30qsMHlJzOsgWiHt2r7:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210168

The ADT7604 shares the same die as the LTC2984. It repurposes the
custom RTD sensor type (18) as a copper trace resistance sensor
and the custom thermistor type (27) as a leak detector, and
removes thermocouple, diode and direct ADC sensor types.

Add adi,adt7604 to the compatible list and introduce two new
sensor node types specific to this device:

- copper-trace@: maps to the custom RTD sensor type (18). Two
variants: sub-ohm (< 1 ohm, adi,copper-trace-sub-ohm boolean,
no custom table and excitation current) and standard (> 1 ohm,
required adi,custom-copper-trace table, optional excitation current
defaulting to the datasheet recommended value). Primary output
is resistance in ohms. For > 1 ohm copper traces with a custom table,
the chip also outputs temperature in millidegrees Celsius.

- leak-detector@: maps to the custom thermistor sensor type (27).
Takes a required adi,custom-leak-detector lookup table encoding
resistance (uOhm) against coverage data (%). Two outputs:
resistance in ohms and coverage in percent.

Separate node types are used rather than extending the existing
rtd@ and thermistor@ nodes because adi,custom-rtd is required
for sensor type 18, and several properties (adi,number-of-wires,
adi,rtd-curve, adi,rsense-share, adi,single-ended,
adi,current-rotate) have no meaning for the new sensor types, since
the configuration is hardcoded, and would need to be explicitly
forbidden or ignored in the driver.

allOf conditions are added to restrict thermocouple, diode, direct
ADC and active temperature nodes to non-ADT7604 devices, and to
restrict copper-trace and leak-detector nodes to the ADT7604
(some parts only).

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v3:
- Changed the custom leak detector table encoding, users now specify
  plain coverage percentage values (0-100) in the device tree and the
  driver applies the +273.15 C offset internally before writing the
  hardware table
- Changed custom-rtd to custom-copper-trace to better represent the
  copper trace custom table, and made it required for > 1 ohm variants
- Made custom-leak-detector required for leak detector sensors
- Updated commit message to reflect the changes
- Updated leak detector node description
- Updated adi,custom-leak-detector description
- Modified the example leak detector custom table to match the datasheet

 .../bindings/iio/temperature/adi,ltc2983.yaml | 207 +++++++++++++++++-
 1 file changed, 204 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index a22725f7619b..14cfa28809ed 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -4,14 +4,18 @@
 $id: http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices LTC2983, LTC2986, LTM2985 Multi-sensor Temperature system
+title: Analog Devices LTC2983 and similar Multi-sensor Temperature systems
 
 maintainers:
   - Nuno Sá <nuno.sa@analog.com>
 
 description: |
-  Analog Devices LTC2983, LTC2984, LTC2986, LTM2985 Multi-Sensor Digital
-  Temperature Measurement Systems
+  Analog Devices Multi-Sensor Digital Temperature Measurement Systems:
+    - ADT7604
+    - LTC2983
+    - LTC2984
+    - LTC2986
+    - LTM2985
 
   https://www.analog.com/media/en/technical-documentation/data-sheets/2983fc.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/2984fb.pdf
@@ -43,6 +47,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - adi,adt7604
           - adi,ltc2983
           - adi,ltc2986
           - adi,ltm2985
@@ -436,6 +441,121 @@ patternProperties:
     required:
       - adi,custom-temp
 
+  '^copper-trace@':
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
+    description: |
+      Copper trace resistance sensor (some parts only). Two variants exist:
+      sub-ohm (< 1 ohm, no custom table allowed) and standard (> 1 ohm,
+      required custom table).
+
+    properties:
+      reg:
+        minimum: 2
+        maximum: 20
+
+      adi,sensor-type:
+        description: Sensor type for copper trace sensors.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        const: 32
+
+      adi,rsense-handle:
+        description: Associated sense resistor sensor.
+        $ref: /schemas/types.yaml#/definitions/phandle
+
+      adi,copper-trace-sub-ohm:
+        description:
+          Select the sub-ohm (< 1 ohm) copper trace variant. Custom table
+          and excitation current are not allowed in this mode.
+        type: boolean
+
+      adi,excitation-current-microamp:
+        description:
+          Excitation current applied to the copper trace. Not used in
+          sub-ohm mode. The datasheet recommends 1mA for copper trace
+          sensors due to their typically small resistance.
+        enum: [5, 10, 25, 50, 100, 250, 500, 1000]
+        default: 1000
+
+      adi,custom-copper-trace:
+        description:
+          Resistance-to-temperature table for copper trace sensors with
+          resistance > 1 ohm. Required when adi,copper-trace-sub-ohm is not
+          set. See Page 36 of the datasheet.
+        $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        minItems: 3
+        maxItems: 64
+        items:
+          items:
+            - description: Resistance point in uOhms.
+            - description: Temperature point in uK.
+
+    required:
+      - adi,rsense-handle
+
+    allOf:
+      - if:
+          required:
+            - adi,copper-trace-sub-ohm
+        then:
+          properties:
+            adi,custom-copper-trace: false
+            adi,excitation-current-microamp: false
+      - if:
+          not:
+            required:
+              - adi,copper-trace-sub-ohm
+        then:
+          required:
+            - adi,custom-copper-trace
+
+  '^leak-detector@':
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
+    description: |
+      Leak detector sensor (some parts only). Outputs resistance in ohms and
+      a coverage percentage via IIO_COVERAGE (raw/1024 = coverage %).
+
+    properties:
+      reg:
+        minimum: 2
+        maximum: 20
+
+      adi,sensor-type:
+        description: Sensor type for leak detector sensors.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        const: 33
+
+      adi,rsense-handle:
+        description: Associated sense resistor sensor.
+        $ref: /schemas/types.yaml#/definitions/phandle
+
+      adi,excitation-current-nanoamp:
+        description:
+          Excitation current applied to the leak detector. The correct value
+          depends on the electrical characteristics of the liquid being sensed.
+          For example, 10000 (10µA) is recommended for PG25 (see datasheet
+          Table 39).
+        enum: [250, 500, 1000, 5000, 10000, 25000, 50000, 100000, 250000,
+               500000, 1000000]
+
+      adi,custom-leak-detector:
+        description: |
+          Lookup table mapping resistance to coverage percentage. Entries must
+          be in ascending resistance order.
+        $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        minItems: 3
+        maxItems: 64
+        items:
+          items:
+            - description: Resistance point in uOhms.
+            - description: Coverage data percentage (0 to 100).
+
+    required:
+      - adi,rsense-handle
+      - adi,excitation-current-nanoamp
+      - adi,custom-leak-detector
+
   '^rsense@':
     $ref: '#/$defs/sensor-node'
     unevaluatedProperties: false
@@ -477,6 +597,22 @@ allOf:
       patternProperties:
         '^temp@': false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,adt7604
+    then:
+      patternProperties:
+        '^thermocouple@': false
+        '^diode@': false
+        '^adc@': false
+        '^temp@': false
+    else:
+      patternProperties:
+        '^copper-trace@': false
+        '^leak-detector@': false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
@@ -556,4 +692,69 @@ examples:
             };
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temperature-sensor@0 {
+            compatible = "adi,adt7604";
+            reg = <0>;
+            interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+            vdd-supply = <&supply>;
+
+            trace_rsense: rsense@2 {
+                reg = <2>;
+                adi,sensor-type = <29>;
+                adi,rsense-val-milli-ohms = <100000>; // 100 ohm
+            };
+
+            copper-trace@4 {
+                reg = <4>;
+                adi,sensor-type = <32>;
+                adi,rsense-handle = <&trace_rsense>;
+                adi,copper-trace-sub-ohm;
+            };
+
+            r_sense: rsense@12 {
+                reg = <12>;
+                adi,sensor-type = <29>;
+                adi,rsense-val-milli-ohms = <1000000>; // 1 kohm
+            };
+
+            leak-detector@14 {
+                reg = <14>;
+                adi,sensor-type = <33>;
+                adi,rsense-handle = <&r_sense>;
+                adi,excitation-current-nanoamp = <10000>;
+                adi,custom-leak-detector =
+                    /bits/ 64 <          0 100>,
+                    /bits/ 64 <  202020000  99>,
+                    /bits/ 64 <  285710000  70>,
+                    /bits/ 64 <  333330000  60>,
+                    /bits/ 64 <  400000000  50>,
+                    /bits/ 64 <  500000000  40>,
+                    /bits/ 64 <  666670000  30>,
+                    /bits/ 64 < 1000000000  20>,
+                    /bits/ 64 < 2000000000  10>,
+                    /bits/ 64 <1000000000000 0>;
+            };
+
+            rtd@18 {
+                reg = <18>;
+                adi,sensor-type = <12>; // PT100
+                adi,rsense-handle = <&r_sense>;
+                adi,number-of-wires = <2>;
+                adi,rsense-share;
+                adi,excitation-current-microamp = <500>;
+                adi,rtd-curve = <0>;
+            };
+        };
+    };
 ...
-- 
2.43.0

