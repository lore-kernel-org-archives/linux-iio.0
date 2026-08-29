Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D86E3644BE;
	Sat, 29 Aug 2026 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787983207; cv=none; b=knmnZShQIR7l8WKW5apcS/zgP5WuW71JQ5LLEKwaLDbG2oekTWFfdP200Xtu3yWMiqL/IoWHTQY1Ho5mlEEFX8PK4Z70fzBGdMX1IX4MBGZkTrwroior6VrQ0OJXFRUOvqXCIjgewkFDT4PnqQVplzUpNZmEZGOLPMq6UgJI+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787983207; c=relaxed/simple;
	bh=o0n+H99rNdGQZezq3ImTz2Sm5yP6JM9yLDjgy4EyCAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eHhzhH/B/p4y4eBx40Fngq2zOW6IucKA9pUt9EPhsTqBkkcbtxF0w+P3oFNXaheTQVhfmvrTS4Y9geWiW0rrzzsx/zql8LwIM7xWprFnutqs69IspCuHIGNUj712W8s0CAXLDXUrbI/3J7zAZOXL/J4DsIuAam2Q4eotvE3Bido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yubmwdli; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yubmwdli"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67T5ABNp3386055;
	Sat, 29 Aug 2026 02:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=w3s1t
	q7Pw/Y5mEh8LkB855CO618voyktV3ZfblAQzp4=; b=yubmwdliE1QBJTTmvcV+a
	gfX8pi8G12etZlTMh5k8G4mjXz1lxSKyAjZ2rtVhVZh4c2W8yk1CRiADSrGt9Z6G
	/cpcBYQP+nucBp/BEq3d8taa45zYPLjzYOjrHToVDiWkQXe5pHNGrn76nkWvnb/F
	HJIp3aVLySb8zVngQ3Z2EsnkmBMzbuNKl7AsJ5ZD0PRSOQ+twnCzw8gPbOLlAJOb
	lMxjSWdiUsh4dYiQ4qfgKfa0P5whxNHSRGTCqYkzpwg6fjwNMwnulutOe252S0/u
	GARv/HQUM4abTRhgi3x4nz4pnd27XWBKK618eRjcywYemO43JNk2iQ3HWorv7+gC
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbqmh8cmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Aug 2026 02:00:00 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67T5xweN035570
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 29 Aug 2026 01:59:58 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Sat, 29 Aug
 2026 01:59:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 29 Aug 2026 01:59:58 -0400
Received: from [10.0.2.15] ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67T5xYjB027223;
	Sat, 29 Aug 2026 01:59:51 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Sat, 29 Aug 2026 13:59:21 +0800
Subject: [PATCH v4 2/4] dt-bindings: iio: dac: add adi,ad5710r.yaml
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260829-iio-ad5710r-upstream-v4-2-8af3121c7d21@analog.com>
References: <20260829-iio-ad5710r-upstream-v4-0-8af3121c7d21@analog.com>
In-Reply-To: <20260829-iio-ad5710r-upstream-v4-0-8af3121c7d21@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp
 Zabel <p.zabel@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787983175; l=5185;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=o0n+H99rNdGQZezq3ImTz2Sm5yP6JM9yLDjgy4EyCAY=;
 b=PanQMhl3eOS7fG0zTZpHBBQDhcsEOyIytcfDSwqL4qsDAYLzo2Pq9gj7yw4REN/BuzPeqOpgJ
 OhzAY6+z+vnDDZuvaWM9unRpb0yll+4M/4NWZE1bdPRvZbDcCUYRMng
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Yf+NIQRf c=1 sm=1 tr=0 ts=6a927560 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=UDoUUgFuJgqny170jhoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: R9LMKR56MPdSDhb_6w1U1TUcokJthZ3r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI5MDA0OSBTYWx0ZWRfXw7Mfrk4ucOJv
 5DvQ67TOvsnxqk2ep/DMnlHK9kzspwS6Syiwl6KNB5E/sk9H3cGqayFob17CGhVSjvygRB1anGz
 2K+hWArDDKnXSYb3Ha8XtgLgy2YvXWJMIykzC3McXE+/IjVvqJhTdh3CZptRJaGU+1G3WPSpGlS
 tlUHXLFw6/E/3+eavQR4M6LwIXYxNxeMf3nhawP/Ww8c0XyZrhx6f3pD0q+2BhijqKOOr4VfCLC
 4O6n0utDTd1ALDIxfdlQJZYUDpK7uizWKn6DLu7gs1+AMzDTSbar4W5NALmRpuH2A3vo6e9HXYt
 FJB/2ksxysJMEq1VncxSxrvt2nkdE1Gu2aKTCoKnl12c08rKMNQIJJvwkJx8NXX9pmKqD6R4YPE
 Xxfn3M3NIhDFDL9vKXUy7Po2PKKjcoH3zhgapXSKOkGu9AcpHquin/hJf+A4XwOTRGjFA1jxVnL
 ZR+M1sSFpgHaTlPShSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI5MDA0OSBTYWx0ZWRfXy0ISqavxTh09
 jT102bkD6YcqZ3pw+zVERJKVFTeWz5rbQ3oJomjL+ycP5Ye5aLpo8g77qpeCN/1MBOsGt+cK0k8
 POjVrpgT3PZDe5bjyPrKspy17g0NhSxZ6AbEOM4ZKbTEoKhQq+U4
X-Proofpoint-ORIG-GUID: R9LMKR56MPdSDhb_6w1U1TUcokJthZ3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-29_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608290049

Add device tree bindings for the Analog Devices AD5710R/AD5711R
8-channel 12-/16-bit Configurable IDAC/VDAC.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 143 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 144 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
new file mode 100644
index 000000000000..259866ca87cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5710r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5710R/AD5711R 8-channel 12-/16-bit Configurable IDAC/VDAC
+
+maintainers:
+  - Kim Seer Paller <kimseer.paller@analog.com>
+
+description: |
+  The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
+  configurable current/voltage output digital-to-analog converters (DACs) with
+  an on-chip 2.5V, 3ppm/°C reference. Each channel can be independently
+  configured as a voltage output (0V to VREF or 0V to 2 x VREF) or a current
+  output (0mA to 50mA). These devices operate from a single 2.7V to 5.5V
+  supply and are guaranteed monotonic by design.
+
+  Datasheet can be found here:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5711r-ad5710r.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5710r
+      - adi,ad5711r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  vdd-supply:
+    description: Power Supply Input.
+
+  iovdd-supply:
+    description: Digital Power Supply Input.
+
+  io-channels:
+    description:
+      ADC channel used to monitor internal die temperature, output voltages, and
+      current of a selected channel via the MUXOUT pin.
+    maxItems: 1
+
+  ref-supply:
+    description:
+      Reference Input/Output. The voltage at the REF pin sets the full-scale
+      range of all channels. If not provided the internal reference is used and
+      also provided on the VREF pin.
+
+  reset-gpios:
+    description:
+      Active low signal that is falling edge sensitive. When it is deasserted,
+      the digital core initialization is performed and all DAC registers except
+      the Interface Configuration A register are reset to their default values.
+    maxItems: 1
+
+  ldac-gpios:
+    description:
+      LDAC pin to be used as a hardware trigger to update the DAC channels. If
+      not present, the DAC channels are updated by Software LDAC.
+    maxItems: 1
+
+  adi,range-double:
+    description:
+      Configure the output range for all channels. If the property is present,
+      the output will range from 0V to 2 x Vref. If the property is not present,
+      the output will range from 0V to Vref.
+    type: boolean
+
+patternProperties:
+  "^channel@[0-7]$":
+    $ref: /schemas/iio/dac/dac.yaml#
+    type: object
+    description:
+      Represents the external channels which are connected to the DAC.
+
+    properties:
+      reg:
+        description: Channel number
+        minimum: 0
+        maximum: 7
+
+      adi,ch-func:
+        description:
+          Channel output type. Use CH_FUNC_VOLTAGE_OUTPUT for voltage
+          output or CH_FUNC_CURRENT_OUTPUT for current output.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [1, 2]
+
+    required:
+      - reg
+      - adi,ch-func
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - iovdd-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/iio/addac/adi,ad74413r.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dac@0 {
+            compatible = "adi,ad5710r";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            vdd-supply = <&vdd>;
+            iovdd-supply = <&iovdd>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                adi,ch-func = <CH_FUNC_VOLTAGE_OUTPUT>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                adi,ch-func = <CH_FUNC_CURRENT_OUTPUT>;
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3f5e7b2f524d..ec0f3812199c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1468,6 +1468,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
 F:	drivers/iio/dac/ad3530r.c
 
 ANALOG DEVICES INC AD3552R DRIVER

-- 
2.34.1

