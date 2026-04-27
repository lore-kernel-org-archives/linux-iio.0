Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5349D3C13E0;
	Mon, 27 Apr 2026 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296585; cv=none; b=ZmkB4+RNVkiY+yK7/wXkz+zcf2kdMzXN5jNGLqbZkSaZu+bUFECOy5exrJ4nA/6vh82pNZOrDJt1PINkxRWvl+gsNBHrCm2HVHYH1MOA0NlxmqRDhQPlp7sfI7MUu9SfHP/OhPsN0dfwKODmGY7okV0v3XmJvgDrz58m7ox4sYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296585; c=relaxed/simple;
	bh=PdBrsgJdcLju2lLvXCoi6TJZsaQTyNj1nP/ou78n1Cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aO+h0DR8LKNXngoOuiTdX9DiKKCLwqlOBD1oT5Tljzu2+cwMzajkl0RJMzLfrb2up3isxTItE2oS5j/kj/R5jICyAJclEX9gpaE8hpK97uZ0uuSuK9EWl6rsaWjx4QelmDLnZhVeIwPzLp5qrtDSdgoOfJQK6CMYPxJoJ5F9cLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qqnLEez+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qqnLEez+"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R9RbZ91695789;
	Mon, 27 Apr 2026 09:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RSQpY
	Q5tcAvcqRQ55nHBeU6W1uwDFPtIrN7AeXkVOSk=; b=qqnLEez+3hfje4ci0rNQp
	+7sEcnSsReIEtS1QgLYo8+TObU/K8UD0iCvWZRah2O1dkKV9oi30bkxwJmaR7v6e
	+cCKehPVVdprKp8rZa0Uo5EjhCfZlulyxrDhYWbzakmhvKqDSjcFOVJIRurp9UzX
	DhwOVLRX+5F7NjR6yh+5fh1cii9gaDE+ZjueZrQ7jRNHsPtFW3PbfnrkotP/VfX9
	5JyX9aT2ytBG9VeQHildzjaLHwpSdykPbkkq9jkeRpk3O/34TAuw7qhqstvm5FbU
	i5jx69TnCZ/zVuDLBzC0X9Nlm+FNzGQJV828Bl1o1Ak3c/isn6PjjHtanf61X9qP
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4drth2efym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 09:29:27 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 63RDTQbI003143
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Apr 2026 09:29:26 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 27 Apr
 2026 09:29:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 27 Apr 2026 09:29:26 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.107])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 63RDT8SR028079;
	Mon, 27 Apr 2026 09:29:21 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Liviu Stan <liviu.stan@analog.com>
Subject: [PATCH 1/2] dt-bindings: iio: temperature: Add ADT7604 support to adi,ltc2983
Date: Mon, 27 Apr 2026 16:25:07 +0300
Message-ID: <20260427132526.272716-2-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427132526.272716-1-liviu.stan@analog.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0NCBTYWx0ZWRfX9F/KfmoU2Qxn
 Y7kudP0T+ipGfZDoh6u58nwwdl0jrd13jAs7qfnBSRPBvJTBZNYJrBSwtDC3aNXSXpF8ZEMV8an
 +x3PksVzuSuthh5IsQDipK8w8twOjJqNSppjwhCnCAEm4oFud5EFqTDavAvMr0oEEn820dfk+Nr
 w2VbDTJ4wXckl6rl591u8lZ4g3uoS2CtyLXpjNukoVv1s8v8X9BVCw7i6/2vRnQeMUn+kQjdbAs
 MeP2isLFHfWnNkIZ3JLyKEr1JCNfXOXcVPgfIKrd/5kui8GnbmcwjQvs9Y3Qy81TKXnnibmQdOS
 0i4/qorqjKm8N8fN8Ri9Y38ZcVxAogDjpgMtIsUr8ZTxTT32B7TkArniTULU1w8Se9zV/A5tMbP
 3X968yRNH/zxhaDKbjIY9AyRy3UNI+Ry8zPXNH8xI8CAr5kF6AlstneRovbodUY/WBkzasYVO2m
 6V/M3QX7YI6OZtkz4zw==
X-Proofpoint-GUID: 1MuF8UpZWatRs3GWDU98O607I9U81jh3
X-Proofpoint-ORIG-GUID: 1MuF8UpZWatRs3GWDU98O607I9U81jh3
X-Authority-Analysis: v=2.4 cv=Rsb16imK c=1 sm=1 tr=0 ts=69ef64b7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=QD8gAf2Tu3Ybv1wFcsUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 adultscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270144

The ADT7604 shares the same die as the LTC2984. It repurposes the
custom RTD sensor type (18) as a copper trace resistance sensor
and the custom thermistor type (27) as a leak detector, and
removes thermocouple, diode and direct ADC sensor types.

Add adi,adt7604 to the compatible list and introduce two new
sensor node types specific to this device:

- copper-trace@: maps to the custom RTD sensor type (18). Two
  variants: sub-ohm (< 1 ohm, adi,copper-trace-sub-ohm boolean,
  no custom table) and standard (> 1 ohm, optional adi,custom-rtd
  table). Primary output is resistance in mOhm.

- leak-detector@: maps to the custom thermistor sensor type (27).
  Takes an optional adi,custom-leak-detector lookup table encoding
  resistance (uOhm) against coverage data (P + 273.15 in uK).
  Primary output is resistance in Ohm; when a table is provided,
  IIO_TEMP reports coverage percentage (raw / 1024).

allOf conditions are added to restrict thermocouple, diode, direct
ADC and active temperature nodes to non-ADT7604 devices, and to
restrict copper-trace and leak-detector nodes to the ADT7604.

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
 .../bindings/iio/temperature/adi,ltc2983.yaml | 170 +++++++++++++++++-
 1 file changed, 167 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index a22725f7619b..e777b37d588d 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Analog Devices LTC2983, LTC2986, LTM2985 Multi-sensor Temperature system
+title: Analog Devices LTC2983, LTC2986, LTM2985, ADT7604 Multi-sensor Temperature system
 
 maintainers:
   - Nuno Sá <nuno.sa@analog.com>
 
 description: |
-  Analog Devices LTC2983, LTC2984, LTC2986, LTM2985 Multi-Sensor Digital
-  Temperature Measurement Systems
+  Analog Devices LTC2983, LTC2984, LTC2986, LTM2985, ADT7604 Multi-Sensor
+  Digital Temperature Measurement Systems
 
   https://www.analog.com/media/en/technical-documentation/data-sheets/2983fc.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/2984fb.pdf
@@ -43,6 +43,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - adi,adt7604
           - adi,ltc2983
           - adi,ltc2986
           - adi,ltm2985
@@ -436,6 +437,96 @@ patternProperties:
     required:
       - adi,custom-temp
 
+  '^copper-trace@':
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
+    description: |
+      Copper trace resistance sensor (ADT7604 only). Uses the custom RTD
+      sensor type (18). Two variants exist: sub-ohm (< 1 ohm, no custom
+      table allowed) and standard (> 1 ohm, optional custom table).
+
+    properties:
+      reg:
+        minimum: 2
+        maximum: 20
+
+      adi,sensor-type:
+        description: Sensor type for copper trace sensors.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        const: 18
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
+      adi,custom-rtd:
+        description:
+          Optional resistance-to-temperature table for copper trace sensors
+          with resistance > 1 ohm. See Page 62 of the datasheet.
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
+            adi,custom-rtd: false
+
+  '^leak-detector@':
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
+    description: |
+      Leak detector sensor (ADT7604 only). Uses the custom thermistor sensor
+      type (27). Outputs resistance in ohms and, when a custom table is
+      provided, a coverage percentage via IIO_TEMP (raw/1024 = coverage %).
+
+    properties:
+      reg:
+        minimum: 2
+        maximum: 20
+
+      adi,sensor-type:
+        description: Sensor type for leak detector sensors.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        const: 27
+
+      adi,rsense-handle:
+        description: Associated sense resistor sensor.
+        $ref: /schemas/types.yaml#/definitions/phandle
+
+      adi,custom-leak-detector:
+        description: |
+          Lookup table mapping resistance to coverage data. Entries must be
+          in ascending resistance order. The coverage data field encodes the
+          coverage percentage P as (P + 273.15) expressed in uK, i.e.
+          (P * 1000000 + 273150000).
+        $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        minItems: 3
+        maxItems: 64
+        items:
+          items:
+            - description: Resistance point in uOhms.
+            - description: Coverage data point (P + 273150000) in uK.
+
+    required:
+      - adi,rsense-handle
+
   '^rsense@':
     $ref: '#/$defs/sensor-node'
     unevaluatedProperties: false
@@ -477,6 +568,22 @@ allOf:
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
@@ -556,4 +663,61 @@ examples:
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
+                adi,sensor-type = <18>;
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
+                adi,sensor-type = <27>;
+                adi,rsense-handle = <&r_sense>;
+                adi,custom-leak-detector =
+                    /bits/ 64 <          0 373150000>,
+                    /bits/ 64 <  202020000 372150000>,
+                    /bits/ 64 < 1000000000 293150000>;
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

