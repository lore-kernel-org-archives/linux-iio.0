Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA548421EFF;
	Thu, 14 May 2026 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770182; cv=none; b=OZP5xFFNxFP6XdqUQPqX/n93Bn+dSoH+0zzYuQj1GqxG6IG9iyXoC7Ax/PePauF+t3oA0woTmkZcXTwr8hiCulVp7qNq1Dipd3+KqEn/P3DEbcbCNinMNpb+4zFb1bI+3nZ/HAjQdZW7K5zfHVKS6YLn8LTIZFCU+3LSmwqGUg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770182; c=relaxed/simple;
	bh=GrgjQLPF6kol8DW0EJqPQG7+YFh6AS5SQjgSO4z0eAY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D/tQzdniDSllaJjKgeX/BD9XQkiqzts/pbKnojDbopg850SfPx3mwzVMgtRjhhys3iPBWBzx0XE3w9ldqZRBUMEibAF4kXagkOHeTmJNIaYurbsHLX8MVSsV1rMt5V/NGxSeUHL5aF5v6DLRQRtomqdxvlBviB8qmFdl+2MrduE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=S2+62LcO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="S2+62LcO"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EDUTkQ1714697;
	Thu, 14 May 2026 10:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=X6wRN
	pgTO9hy2kZY6CC9RzaemtqODAxEXckJ8ygDxQM=; b=S2+62LcOZ+Uq/ttj5q/iJ
	YVhh26+5vUSGx/wEDSP/ibAHDEhosXUrmmUOgxlNFiQdAKSigmo2QywEwCY+5RLL
	jQS7HriQJ8J9bD6I9FkkHP8GiKTfRJ5t6g/wvINpQy53c506dd3nzXxUt70szdYG
	IF9EEbS6BdJbaxde4RujDqNNbdITEDJ2E+j/e7ukeC+WffgukTVb/S1WARm3j3If
	QJi3kNKUfrfOG6BVIeuPpAdSPzrxjgZp/gynxOQ2EftLk6oG8S7Y5JZqAVk+Ad1D
	YCVsHtuqvsAsvHxwkg4YgNC4rmWZaBNdBrR6IUClerbXow8H90tvwJczNkE69qQ3
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e54xgtj53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 10:49:37 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64EEnaF3041761
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 May 2026 10:49:36 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 14 May
 2026 10:49:36 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 14 May 2026 10:49:36 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64EEmjAd014051;
	Thu, 14 May 2026 10:49:29 -0400
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
        Francesco Lavra <flavra@baylibre.com>,
        Liviu Stan <liviu.stan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 6/7] dt-bindings: iio: temperature: Add ADT7604 support to adi,ltc2983
Date: Thu, 14 May 2026 17:46:53 +0300
Message-ID: <20260514144712.64374-7-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514144712.64374-1-liviu.stan@analog.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE1MCBTYWx0ZWRfXwymexMHA94YH
 1X98DQXPEQ1TZT0wqKYBK5HedpF0aOYWdfQsLViz9nHsxsiWftydeNr0NlDuoWRC9obNH2dO1EB
 i2r10wMd3ASyb84Km8VjVZLYXOiTtjPIEQQXmtx5pcYNxXLNgDPWR5VZwNpR1NSicmOAn8I9X1W
 yXZyWez54R/+xNw40zDPcmw6Zzagdb05q0UFB/cyqJ/jIPz06/xg6l35V0Y72BXSHOZyEXraGXh
 6ZAjPH8hkk28hn/q63ZDee7X8YfwsLvL2EZACjYLddYkjQDpD2PxSJILb245JgnQDf5h0inqu4K
 59o8jDLxM1avEGgdh7IwRQR5W/FZSRyxfzyK74UXcP8VoiXLjUCmRV7T534UklcmPMowjS/KUN9
 F7aHmuxaH3vt4siYJoaZk7JM+cYsvUgliLa/UKFCHvp0Mwz4t8BmFAhShyUXDaAaG+nwjRAAzCg
 FBScpXXWNIR+NZuMrNA==
X-Proofpoint-GUID: pQLC7G6DNE5pQ0aKEa_er2evbzThK79p
X-Proofpoint-ORIG-GUID: pQLC7G6DNE5pQ0aKEa_er2evbzThK79p
X-Authority-Analysis: v=2.4 cv=MMFQXsZl c=1 sm=1 tr=0 ts=6a05e101 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=lI58tbVODBnYFgKiwwAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=t30qsMHlJzOsgWiHt2r7:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140150

The ADT7604 shares the same die as the LTC2984. It repurposes the
custom RTD sensor type (18) as a copper trace resistance sensor
and the custom thermistor type (27) as a leak detector, and
removes thermocouple, diode and direct ADC sensor types.

Add adi,adt7604 to the compatible list and introduce two new
sensor node types specific to this device:

- copper-trace@: maps to the custom RTD sensor type (18). Two
variants: sub-ohm (< 1 ohm, adi,copper-trace-sub-ohm boolean,
no custom table and excitation current) and standard (> 1 ohm,
optional adi,custom-rtd table, optional excitation current
defaulting to the datasheet recommended value). Primary output
is resistance in ohms. When a custom table is provided, the
chip also outputs temperature in millidegrees Celsius.

- leak-detector@: maps to the custom thermistor sensor type (27).
Takes an optional adi,custom-leak-detector lookup table encoding
resistance (uOhm) against coverage data. Primary output is
resistance in ohms. When a custom table is provided, the chip
also outputs coverage in percent.

Separate node types are used rather than extending the existing
rtd@ and thermistor@ nodes because adi,custom-rtd and
adi,custom-thermistor are currently required for types 18 and 27,
and several properties (adi,number-of-wires, adi,rtd-curve,
adi,rsense-share) have no meaning for copper trace and would need
to be explicitly forbidden or ignored in the driver.

allOf conditions are added to restrict thermocouple, diode, direct
ADC and active temperature nodes to non-ADT7604 devices, and to
restrict copper-trace and leak-detector nodes to the ADT7604
(some parts only).

Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v2:
- Shortened title to "LTC2983 and similar".
- Converted device description list to bullet list in alphabetical
  order.
- Retained separate copper-trace@ and leak-detector@ node types rather
  than extending rtd@/thermistor@; rationale added to commit message.
- Replaced "ADT7604 only" with "some parts only".

 .../bindings/iio/temperature/adi,ltc2983.yaml | 194 +++++++++++++++++-
 1 file changed, 191 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index a22725f7619b..c63b69bd9504 100644
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
@@ -436,6 +441,115 @@ patternProperties:
     required:
       - adi,custom-temp
 
+  '^copper-trace@':
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
+    description: |
+      Copper trace resistance sensor (some parts only). Two variants exist:
+      sub-ohm (< 1 ohm, no custom table allowed) and standard (> 1 ohm,
+      optional custom table).
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
+            adi,excitation-current-microamp: false
+
+  '^leak-detector@':
+    $ref: '#/$defs/sensor-node'
+    unevaluatedProperties: false
+    description: |
+      Leak detector sensor (some parts only). Outputs resistance in ohms and,
+      when a custom table is provided, a coverage percentage via
+      IIO_COVERAGE_PERCENT (raw/1024 = coverage %).
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
+      - adi,excitation-current-nanoamp
+
   '^rsense@':
     $ref: '#/$defs/sensor-node'
     unevaluatedProperties: false
@@ -477,6 +591,22 @@ allOf:
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
@@ -556,4 +686,62 @@ examples:
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

