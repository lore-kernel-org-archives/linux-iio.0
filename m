Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981164;
	b=VF7qUYOpvYBbIg52YfRpd+jz1+/C8XaBfIKj3kmYuOVdJuTS9CLjIqnrxUtOvIW6uGip
	 EBeK9nTjlw+3mhUN23ha/hN0DwjGSeBb9dlRGgy1c6oi0iEpp6CrY2n0nd6Xh8/20W/U5
	 DN2n6nU/bXd5D/uRnr943U7cBOi4rJSgr+2oHQwGOzp3Lhb4oguT3UMOubycpAiHVCDpl
	 e6OyWkiBwM6b7PDbe2YGhbr1uBhKrgB7GvZhhR9FLHyFci1B/bYUC4iOZZnisVH/iaW7C
	 yLhRJMIgNyEvG7aqhOZU3nyf0q7KmmQZcrOixD5EqMnJpDhG8MA74sy9vZ3VJPsOBzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981164;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BHRuBWW2bcdy840EBmFvEHeGo2K5UFvLBzwAv+CAoUs=;
	b=33/X6y5b0sAxr/Vya0ycDBCzdwaiXyfrEtOrkF1PU2u1MenuclN90AvhRyi8yvBlgvuq
	 +k5HfnZiffgOUIG6FRgPgCJUKl4y9wEBWRyxFc5Jkjltty0yGJInB1g65pZWYnaIaobs2
	 2GTwocbAlNa87NoSaLIG7zICOp6SDaft83hWhoCy5Y1H1biJoFWI/Yg+RTiY5OMbKHGl7
	 QQOqwKhhL/b3vaVwXj1g7uAHpJo9JfICHKJGwqRbbJj2vZjHNGlQCWi2GQODPPRAiGeHh
	 KxKcnQ9pN+oYpCUbLl3//sQP7NL4URUNbwhW95tstlMyzkycvvnLaAs0NyWo8/zF8hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RHekB7at;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=CRmhxCgQ;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A7E606A337;
	Fri,  6 Nov 2026 16:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9A7E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RHekB7at;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=CRmhxCgQ
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F49OO833043;
	Fri, 6 Nov 2026 11:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=BHRuBWW2bcdy840EBmFvEHeGo2K5UFvLBzwAv+CAoUs=; b=RHekB7a
	tjEYNbAHujzo7wwT8bMg6zcNa1ZIhf992nLUsQa/w3ccbtXEtyuhS2wFbqkWS+mV
	AIgtTi6bJDw7Y8BMU8MS9kYjEJIWYDX6qsK4kyEjHtIq77zLZWr16tdpnyNVWyeS
	8qAqcjiNf1SCtRMMZPfRosHjV4+lzJKkIupuQ3YQT2d9BqrruBIJvIcc0XrQ6jQC
	zD4TQBQkCGYGE1jPrHaaQliMoz08OUsYLM301gy1tuX0HYVJwKfvie+Lm+YiJ44c
	FlQ9FAds86ksK6emqj0nqgAUkxBDWt4TDhFWiIltsZO8PwIs6QW5WGe7sjZMDm6l
	n2kBCF4zxD7JROw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BHRuB
	WW2bcdy840EBmFvEHeGo2K5UFvLBzwAv+CAoUs=; b=CRmhxCgQnamjguFOLltFg
	E77JFHOaIKrrcFi1E73ayKPBT/yJVynvQJe6H44gdTRBzFzkM5a3nxAuL/zBlZyw
	0lhe/4uD2bG8lP/4wR1sy0j15ZK9l1zgqAri7vye2dN9NkhR/9wGUN9VQ1IFMcEp
	6SfG/H6wF6DHRufR6EiU1jWp3c9ccv94u7dFj9KvZDuWprLjK3PfZ25FwutNwbqw
	2EXRfBWPrFvtpvTY6YmnIz6BO1RPyHPv2RkfT+VPOvc1NzeBb/FbqQKdP0pLeqOr
	qzUj4dYpjgs1dv+ZmS8tO2VOv6DhSwn4HQb2/u4DQGX8yVPRe7ENNNWEgbCOk0HJ
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3q052cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:06:00 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A6G5xgB052503
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 11:05:59 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Nov
 2026 11:05:59 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Nov 2026 11:05:59 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A6G5TDN016340;
	Fri, 6 Nov 2026 11:05:51 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Trevor
 Gamblin <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolae-Daniel
 Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Subject: [PATCH v3 6/7] dt-bindings: iio: adc: add adi,ltc2387
Date: Fri, 6 Nov 2026 18:05:18 +0200
Message-ID: <20261106160529.876251-7-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: B37U-ZSTYBPzH96j3O7XBD7KnkMI06T8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MyBTYWx0ZWRfXxfAuEUBvH7R1
 pfal6kZ8dNeSXhYGzW/8tGR2wE4D516MV9ObvgXsWjGowYlyTXuTzaGBHRqGAXyvR2TiV/XPnah
 5HiHVhu173PvS53ZnN9J+/3bNs3ry/pO/FfrWEDP3YKky/GxGPcx
X-Authority-Analysis: v=2.4 cv=Lt8HWXdc c=1 sm=1 tr=0 ts=6aedfae8 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8
 a=2d1Opr2tUN7HvsTZuCkA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=sptkURWiP4Gy88Gu7hUp:22 a=6HWbV-4b7c7AdzY24d_u:22 a=BmoiQ_kLkyt6usnitrTQ:22
X-Proofpoint-GUID: B37U-ZSTYBPzH96j3O7XBD7KnkMI06T8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MyBTYWx0ZWRfX57Bo0f+6f+Qr
 DyYH5P7/P/JMlwc5myj3wgAH9QcCZHLClU8+1oMF8U+hXJqE05pbDfGgFlK3dyBFnQ049Mpop8b
 J1iJWlH2IH9zo18U7/nSoblKa/PgN63S3mxNqbIPetgt4moTQ86vJCnh/SENgVdvGoZx2EPMO9b
 Yy9vHBT3H/1F3LSPp6QxWzTZvhF+DYfEA1FUgaE3kTf5Eximw8vX2VtZuKDHU3JMfi4ofN6yXJA
 wneIHKVZZNlWwDMvk+XAt544t6+S1FPXSiqr1WY0CcKNo36v8HdzGGhJxE/v+aE4dxFxBWmm+Q9
 mMJXnk9tcZ88PBrg7X/7ZzPeH1IDQrgUdRsyawhQnzx7bDdZpnI505a/U6flSK/PokUmq7K4dq5
 2jF2lx1EldpiqjxVQ8E7bmb2lG5a68AS+KhnySQL4YGADp+0eGVNoXG9+3pE6oIL/0kip2vRTee
 /5fPTHDcGtNz4tHhM/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060063

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Add a binding for the LTC2387-16, LTC2387-18, ADAQ23875, ADAQ23876 and
ADAQ23878. They are single channel differential ADCs, read like the AD762x
and AD796x: two PWMs drive CNV and CLK, and an AXI ADC captures the LVDS
data. A separate binding fits, as few properties of those parts apply:

- Output is double data rate on one or two lanes, selected by the TWOLANES
  pin, described by adi,use-two-lanes.
- No EN pins, no clocks property: the PWM provider reports the clock its
  waveforms derive from. The second PWM is named clk, after the pin it
  drives.
- Supplies are VDD, VDDL and OVDD on the LTC2387, VDD, VIO, VS+ and VS- on
  the ADAQ modules.
- The ADAQ modules have a fully differential amplifier ahead of the ADC.
  Gain is fixed on the ADAQ23875, pin strapped on the ADAQ23876 and
  ADAQ23878, described by adi,gain-milli.

The devicetree describes gain, as the strapping can't be read from the
part. No fallback compatible: a driver for an AD762x or AD796x part would
read these wrongly, as their output is double data rate with other timing
limits.

Add the binding to the maintainers entry of the AD7625 driver.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 .../bindings/iio/adc/adi,ltc2387.yaml         | 169 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2387.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2387.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2387.yaml
new file mode 100644
index 000000000000..f0f1071fd96d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2387.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ltc2387.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTC2387 and ADAQ2387x Analog to Digital Converters
+
+maintainers:
+  - Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
+  - Sergiu Cuciurean <sergiu.cuciurean@analog.com>
+
+description: |
+  Single channel differential 15 MSPS SAR analog to digital converters with an
+  LVDS interface, and the ADAQ uModule data acquisition systems that put a
+  fully differential amplifier in front of the LTC2387 die.
+
+  * https://www.analog.com/en/products/adaq23875.html
+  * https://www.analog.com/en/products/adaq23876.html
+  * https://www.analog.com/en/products/adaq23878.html
+  * https://www.analog.com/en/products/ltc2387-16.html
+  * https://www.analog.com/en/products/ltc2387-18.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adaq23875
+      - adi,adaq23876
+      - adi,adaq23878
+      - adi,ltc2387-16
+      - adi,ltc2387-18
+
+  vdd-supply:
+    description: 5V analog power supply (VDD).
+
+  vddl-supply:
+    description: 2.5V analog power supply (VDDL), LTC2387 parts only.
+
+  ovdd-supply:
+    description: 2.5V output power supply (OVDD), LTC2387 parts only.
+
+  vio-supply:
+    description: 2.5V digital supply (VIO), ADAQ parts only.
+
+  vs-p-supply:
+    description: Amplifier positive supply (VS+), ADAQ parts only.
+
+  vs-n-supply:
+    description:
+      Amplifier negative supply (VS-), ADAQ parts only. Leave it out if VS-
+      is tied to ground.
+
+  ref-supply:
+    description:
+      Voltage regulator for the external reference voltage on REFBUF. If it
+      is not present, the internal reference is used.
+
+  pwms:
+    items:
+      - description: PWM connected to the CNV input on the ADC.
+      - description:
+          PWM that gates the clock connected to the ADC's CLK input, so that
+          it sees the burst of pulses for each conversion.
+
+  pwm-names:
+    items:
+      - const: cnv
+      - const: clk
+
+  io-backends:
+    description:
+      The AXI ADC IP block connected to the DA+/- and DB+/- data lines and
+      the DCO+/- lines of the ADC.
+    maxItems: 1
+
+  adi,use-two-lanes:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Describes whether the TWOLANES pin is set high, selecting two-lane LVDS
+      output, or low, selecting one-lane output (the default).
+
+  adi,gain-milli:
+    description:
+      Gain of the fully-differential amplifier that the ADAQ modules
+      integrate ahead of the LTC2387 die, expressed as gain * 1000. It is
+      set by pin strapping on the ADAQ23876 and ADAQ23878, so it must match
+      the board. Not allowed on the ADAQ23875, whose gain is fixed at 2, or
+      on the LTC2387.
+    $ref: /schemas/types.yaml#/definitions/uint16
+    enum: [370, 730, 870, 1380, 2250]
+
+required:
+  - compatible
+  - pwms
+  - pwm-names
+  - io-backends
+  - vdd-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ltc2387-16
+              - adi,ltc2387-18
+    then:
+      properties:
+        vio-supply: false
+        vs-p-supply: false
+        vs-n-supply: false
+        adi,gain-milli: false
+      required:
+        - vddl-supply
+        - ovdd-supply
+    else:
+      properties:
+        vddl-supply: false
+        ovdd-supply: false
+      required:
+        - vio-supply
+        - vs-p-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,adaq23875
+    then:
+      properties:
+        adi,gain-milli: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adaq23876
+              - adi,adaq23878
+    then:
+      required:
+        - adi,gain-milli
+
+additionalProperties: false
+
+examples:
+  - |
+    adc {
+        compatible = "adi,ltc2387-16";
+        io-backends = <&axi_adc>;
+        ovdd-supply = <&supply_2_5V>;
+        pwms = <&axi_pwm_gen 0 0 0>, <&axi_pwm_gen 1 0 0>;
+        pwm-names = "cnv", "clk";
+        ref-supply = <&supply_4_096V>;
+        vdd-supply = <&supply_5V>;
+        vddl-supply = <&supply_2_5V>;
+    };
+  - |
+    adc {
+        compatible = "adi,adaq23878";
+        io-backends = <&axi_adc>;
+        pwms = <&axi_pwm_gen 0 0 0>, <&axi_pwm_gen 1 0 0>;
+        pwm-names = "cnv", "clk";
+        vdd-supply = <&supply_5V>;
+        vio-supply = <&supply_2_5V>;
+        vs-p-supply = <&supply_5V>;
+        adi,gain-milli = /bits/ 16 <870>;
+        adi,use-two-lanes;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 52024397dc78..9d07f1f47c6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1658,6 +1658,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 W:	http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
+F:	Documentation/devicetree/bindings/iio/adc/adi,ltc2387.yaml
 F:	Documentation/iio/ad7625.rst
 F:	drivers/iio/adc/ad7625.c
 
-- 
2.56.0

