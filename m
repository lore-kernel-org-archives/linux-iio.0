Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087540;
	b=n0DTwh+5RZxK2wIBZ8oMCj8RbxtsIxJWqy99SIVsMSTorvDebywvk/+XzjF4I5rXMGgg
	 G34x+8YBNrBAFPBfOuEQXPrzeAAPyIdiL1oeQK+m8GIgc2quT2EwUSB/75dmHDsSZEZer
	 oGbUS9zb4aDREdhiltGhuiVIs0yzm4+dwjN6SWs3hQARBcsoZ1IfXicUoC6TYfQmC8j6C
	 lL2yvU80pyzDuoi19f0Loc1XRkbM1O4NXCxLNPi1YcXCb3YlScfSmhzjbDTblGhM0KV57
	 uqQn+8EdILUYcYUL+ySbm0IuxlwxfRFJ+sc2tNk46eLYRpfjvRGjM4aerM6cytZPQVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087540;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gg+AduOVmWOnk4+qja6kfTPGFmEhfo4QXNFKNGyitYU=;
	b=Ugn//4VjyIwrzL3wuM/riyI+RRM5ehhjK6LwOkd608+p3KHL+1a7yAFG9WczdApA7jFl
	 9tj0s2VT1cNi+acNiW6B1J1oawLrFeggUiEXVVlh/94vu4hpv7bkD07YpIM+0QkMAvt0N
	 d7UcH3cci3FYT9gko92IWfWuy9mlf52udOWoJh/UaR3uzQgMgbShg1Ow29FUjirA63PDP
	 +U/D5HO/1fWYadT/jAd4I1kiXKH2UoWM11nt0+PAv/bvOuyT0u0Sp8rd7EhX9lKoBOkwT
	 AxtTF8nFXf92ORXlPLA6pnWBuIY1BwiekWSPUfApJVxUOy8lxg1XdbvkM3z8OHK+S0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pkuFCvY3;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ZbuX+FZU;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726C60A2618;
	Thu, 19 Nov 2026 11:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8726C60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pkuFCvY3;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=ZbuX+FZU
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJB0paH3806149;
	Thu, 19 Nov 2026 06:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=gg+AduOVmWOnk4+qja6kfTPGFmEhfo4QXNFKNGyitYU=; b=pkuFCvY
	32D+qf2HiFV5VZiZgg+fbtS8vrWoum76c+956i+HBpAPvPyPcmotovxHBmE6ireS
	9jBROrcItn9jNIdQKW//Ax8ya/uWTbTsjusXfldQOyd60xbCCZl3W9c4UBjUx9nm
	tKcMTgE2LU+lrR+KdOZIy4OPFDTRCZYKZvb6YA3rMVVhIRr5Wc5SKx+/57OzSWbw
	2UULzEL3HUyKq11Ai46I1pX0nrOyS1g56wyEU5akRit0lJkD2V8TTxfikJ3nfHm7
	eR/eG4oy6OwR+gZtPnUCqd3b3gFf7ggE4ji+RgpUkYpJvwNy6NuN0uDwMvsmbeb5
	luN3UazwK1EYStQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gg+Ad
	uOVmWOnk4+qja6kfTPGFmEhfo4QXNFKNGyitYU=; b=ZbuX+FZU8wFbWq0pLsgaw
	8vFn3lKS0NKAe5EtQ0flMqGY99fXvCENe0Pp5FJeQtDs6jrg0LZxw2o8gianXghI
	URTJ0b2o4wB+HQ14XDZFMWLfm8ynFZsbPR8ubTFJP0QCEWji2xBqMuQ5bISRwVdF
	Ks+IT9ygKXUOS5sxXhMotW+8nlbzXgyUiX2bq25dRpaHoiX3jiBMcPfSL6AbP6Qs
	Enfe8V5qmMNKKukEx4uKlGiW8e4tLL5zfaF2XHzbbcIToanhOjESXTvCayQUpvgY
	JUs7oy9UUbNTNSoV7VKMYd6dJCtv5KVKiC6d3x5buMaUdw+TEabWyn4Nk3CmA/Nz
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j1n89uhcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:25:22 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6AJBPLuD023287
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Nov 2026 06:25:21 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 06:25:21 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 06:25:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Thu, 19 Nov 2026 06:25:20 -0500
Received: from arch ([10.135.2.95])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AJBOocM010881;
	Thu, 19 Nov 2026 06:25:13 -0500
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
        "Trevor
 Gamblin" <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Nicolae-Daniel
 Deaconescu" <Nicolae-daniel.Deaconescu@analog.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v4 5/6] dt-bindings: iio: adc: add adi,ltc2387
Date: Thu, 19 Nov 2026 13:24:19 +0200
Message-ID: <20261119112437.197306-6-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
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
X-Proofpoint-ORIG-GUID: yseS6PRm6ld75OHxKcY8s2rduOWWOMf8
X-Proofpoint-GUID: yseS6PRm6ld75OHxKcY8s2rduOWWOMf8
X-Authority-Analysis: v=2.4 cv=B9YsQ+tM c=1 sm=1 tr=0 ts=6afedca2 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8
 a=XYAwZIGsAAAA:8 a=XLhN1fW7AVkGaeAMf-sA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=sptkURWiP4Gy88Gu7hUp:22 a=6HWbV-4b7c7AdzY24d_u:22 a=E8ToXWR_bxluHZ7gmE-Z:22
 a=BmoiQ_kLkyt6usnitrTQ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX9y3c2g4+k7yj
 OYvK+7kdrqfmFyt4CA8htphjedNWPl57kIF22zCLYEVFin9evA2ZT/DbHitns78WHOjsIhY3n1n
 7v4V/w1IFiKm2O/uk+dnS2UqtFFn4kYqYi4ZQ/rFysa9lrUKgg9YpnMYzWfThfSryJyTqno8mEP
 H01rVars7RkKUje3WaTMs7CIedaRDO6CRJGVmmNIrJQmRjY42Gq1syRKnodvxPNL3z1eC8JnHue
 mXG1jNMwKHR4M+tfxBQVtN8SpBYaOLjb4Bv/A0t969QfqrxyfpsmaeiAqcAq+r4Bk9W4D+oO/dM
 5NoRsjpKXmDz+GKojEtXUam536IFMXMPYclNdKvClqgXmOUju+8UpLyxhQJVegFs8ySJb/ribp/
 ONXKOJ7hvMBHGsJJOM54uxCor8Oq47fPN46hADsNW3LEd/NdrawaAkg7zuFKfb6s8q0LB5ka7Ol
 6tl3M9T6Awyt+bToRmQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX2UPIvKrEJvIX
 VG63eOw7w3Qhyer4F3F+qnnUoClVBo+BUyIKjMh5m540YMjGYvJ+xAK9ehvSTcsSBv2rXlLTZp8
 9/s3J5pxFOC9yeV5TEWRYE0oHDM6BQ3TbYA375TpegTubkHcCNMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 adultscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190045

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Add a binding for the LTC2387-16, LTC2387-18, ADAQ23875, ADAQ23876 and
ADAQ23878, single channel differential ADCs that are read like the AD762x
and AD796x: two PWMs drive CNV and CLK and an AXI ADC captures the LVDS
data.

They get their own binding because few properties carry over. Output is
double data rate on one or two lanes, there are no EN pins, and the PWM
provider reports the clock rate. The ADAQ modules add an amplifier ahead
of the ADC, whose gain the devicetree has to describe as strapping can't be
read from the part. There is no fallback compatible, as a driver for an
AD762x or AD796x part would read these wrongly.

Add the binding to the maintainers entry of the AD7625 driver.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iio/adc/adi,ltc2387.yaml         | 169 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2387.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2387.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2387.yaml
new file mode 100644
index 000000000000..2441446c10a0
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
+    $ref: /schemas/types.yaml#/definitions/uint16
+    description:
+      Gain of the fully-differential amplifier that the ADAQ modules
+      integrate ahead of the LTC2387 die, expressed as gain * 1000. It is
+      set by pin strapping on the ADAQ23876 and ADAQ23878, so it must match
+      the board. Not allowed on the ADAQ23875, whose gain is fixed at 2, or
+      on the LTC2387.
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

