Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11773E0745;
	Thu,  9 Jul 2026 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630195; cv=none; b=qpNdrCwLoPMRc7ZSdT9N4Yo1kovYeVOjzuH7a1MSBg+LSBH/k0FPBZbU772mQDFIlnBKmLxnNLxH3eT8VdZD6nlqRhXYonYne0DvHMSMXBAj2ERvUQbr5/t72quSnfLL2A7ZjmN47VtOZpwu4PswMUIkcY+Kt2TAFMNZoGrMDfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630195; c=relaxed/simple;
	bh=+X/7zfTcBWAU6ZfVELLup4rp5pw5itToK77aspYcMJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKy/DB0ZpufE37ykrtI7teXY+31ys//ekllr/61zz006KSEMpY0O2yif6Q4YdTJCy6sZjuRtP/DdIccpkT7vr8EaCijDGjQiqcmxSNmX7xcSoxml2XoW7zJSmAO/iswVL4Mm77xOopjlJTz3GIANmC9mB2Jxz1rBObWBiEsGmbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=etjrsUWO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="etjrsUWO"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HV9mn1719973;
	Thu, 9 Jul 2026 16:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OcqAK
	ndeytZIWMRUa8tzzK3U0BHe1od5GXO+D1ALDsE=; b=etjrsUWOKWQcIU3yepFIF
	12x+sex/U3HYwbSi4yXAzpuOPcvFgmRaS0NjMK3SXCOdRiuy8Y9AwUOUdL0HLWVo
	lM1VDNuAvPsvFsIttWy5v0noVBjnPhUTqHYKnJkvyeSYBpjXBHvMzRNldl11T5Ot
	7qrqSzZ94oJcuSijEJxJAMZNCVRAcQq8h6zR2YcJyAm3A6CX4CxCw2S2D/pHS1aH
	pLdSIiesT6NnR8QHlsd8pZ+M+JPQ/IPB6l+hJmvBXcu/ZAmiDb73C4BN0FWv8ZuM
	kgQQGf6/emnl3uKWEB5CrG4K24R6YLKWWdLEJQ47uX5QeRKayPw50hfVbaPshWCc
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fa4v9ku78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 16:49:49 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 669Knl3J046385
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Jul 2026 16:49:48 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 9 Jul
 2026 16:49:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 9 Jul 2026 16:49:47 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 669KnWJ8003676;
	Thu, 9 Jul 2026 16:49:34 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/4] dt-bindings: iio: adc: Add ltc2378
Date: Thu, 9 Jul 2026 17:49:27 -0300
Message-ID: <1a3259037ac87539490c8e070487703614e41e62.1783629101.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1783629101.git.marcelo.schmitt@analog.com>
References: <cover.1783629101.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDIwNiBTYWx0ZWRfX/30rJwTkU9+F
 zpFfGJd3ukKS0BpmzAolvtONe6eEjlquKKFZiELIk4sgRsSPfS6zqYjT6KEEtsCLdTX8PDKpnPZ
 dJzAyCEdxqdg3oBXSchZ9/+ujjr3w9vJ3FPEr1nVFZ1Qh/6YfUvjCedGnWKSsbZoN2Z7lrJlG/E
 SiUXQcjQliUaq1sFdxBM+P91ThskjTtMkQqjhY6TYJFfkeushcNjUfLIpBFEFBGdXzZDfXKXIFB
 ENYX4cieIQMGlIdHNRCMilXY5R3y4aV45v7KQW95nZ0l+lPS8iqGwtTOI+c+pn+LXIjznh6yCSo
 lAg9QfhbdUn9mvdCkLV10iXmpd9aYlYV5qZLZCr3lfc+gd5gjNeV4fIoaQp2Vs0G7xtroowfRhA
 ux7lk0guW3ePq8cpPCu51pOd9w/UwDGmPEvYNco12zwK/OkwgKlYdj727ddFN6KMhSFk0uZfckC
 lPJLN0uGGUo6LBPIOAQ==
X-Proofpoint-GUID: t2bUIObVDYbibU3yNFxEMFr5FuyU8zIX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDIwNiBTYWx0ZWRfXwt0VizXGLGoh
 2YrxJtt0+QfP/j5R0FuHv0cYuIjSNIvAgAyp6JKj4IbaNXGYtyU811A3QJbJVGQI4PGMujdTW3J
 9FrPsQz/zvAFOBumTlX7qByuoYp/TurWiqDdIzYPjrBx1o325Ucd
X-Proofpoint-ORIG-GUID: t2bUIObVDYbibU3yNFxEMFr5FuyU8zIX
X-Authority-Analysis: v=2.4 cv=R8Ez39RX c=1 sm=1 tr=0 ts=6a50096d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8
 a=VwQbUJbxAAAA:8 a=zHdOwAC9n8DEQaShn0QA:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090206

Document how to describe LTC2378-20 and similar ADCs in device tree.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v5 -> v6:
- Dropped single compatible strings for parts that hava a fall back so dt-schema
  can enforces the fallback compliance.

 .../bindings/iio/adc/adi,ltc2378.yaml         | 170 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
new file mode 100644
index 000000000000..33de1dc4c256
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ltc2378.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTC2378 and similar Analog to Digital Converters
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+
+description: |
+  Analog Devices LTC2378 series of ADCs.
+  Specifications can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/233818fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236416fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236418f.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236716fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236718f.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236816f.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236818f.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236918fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237016fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237616fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237618fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237620fb.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237716fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237718fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237720fb.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237816fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237818fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237820fb.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237918fb.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/238016fb.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      # Single compatible string match.
+      - enum:
+          - adi,ltc2338-18
+          - adi,ltc2364-16
+          - adi,ltc2364-18
+          - adi,ltc2376-16
+          - adi,ltc2376-18
+          - adi,ltc2376-20
+
+      # Low sample rate fallback for 16-bit unipolar sensors.
+      - items:
+          - enum:
+              - adi,ltc2370-16 # 2 MSPS
+              - adi,ltc2368-16 # 1 MSPS
+              - adi,ltc2367-16 # 500 kSPS
+          - const: adi,ltc2364-16 # fallback (250 kSPS)
+
+      # Low sample rate fallback for 18-bit unipolar sensors.
+      - items:
+          - enum:
+              - adi,ltc2369-18 # 1.6 MSPS
+              - adi,ltc2368-18 # 1 MSPS
+              - adi,ltc2367-18 # 500 kSPS
+          - const: adi,ltc2364-18 # fallback (250 kSPS)
+
+      # Low sample rate fallback for 16-bit bipolar sensors.
+      - items:
+          - enum:
+              - adi,ltc2380-16 # 2 MSPS
+              - adi,ltc2378-16 # 1 MSPS
+              - adi,ltc2377-16 # 500 kSPS
+          - const: adi,ltc2376-16 # fallback (250 kSPS)
+
+      # Low sample rate fallback for 18-bit bipolar sensors.
+      - items:
+          - enum:
+              - adi,ltc2379-18 # 1.6 MSPS
+              - adi,ltc2378-18 # 1 MSPS
+              - adi,ltc2377-18 # 500 kSPS
+          - const: adi,ltc2376-18 # fallback (250 kSPS)
+
+      # Low sample rate fallback for 20-bit bipolar sensors.
+      - items:
+          - enum:
+              - adi,ltc2378-20 # 1 MSPS
+              - adi,ltc2377-20 # 500 kSPS
+          - const: adi,ltc2376-20 # fallback (250 kSPS)
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 100000000
+
+  vdd-supply:
+    description: A 2.5V supply that powers the chip (VDD).
+
+  ovdd-supply:
+    description:
+      A 1.71V to 5.25V supply that sets the logic level for digital interface.
+
+  ref-supply:
+    description:
+      Voltage reference input that determines the scale of ADC conversions.
+
+  refin-supply:
+    description:
+      Alternative voltage reference input.
+
+  cnv-gpios:
+    description:
+      When provided, this property indicates the GPIO that is connected to the
+      CNV pin.
+    maxItems: 1
+
+  pwms:
+    description: PWM signal connected to the CNV pin.
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt for signaling the completion of conversion results. The active
+      low signal provided on the BUSY pin asserts when ADC conversions finish.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - ovdd-supply
+
+allOf:
+  # Except for LTC2338, all designs require a voltage reference input
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - adi,ltc2338-18
+    then:
+      required:
+        - ref-supply
+      properties:
+        refin-supply: false
+    else:
+      properties:
+        ref-supply: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@0 {
+            compatible = "adi,ltc2378-20", "adi,ltc2376-20";
+            reg = <0>;
+            spi-max-frequency = <71000000>;
+            vdd-supply = <&supply_2_5V>;
+            ovdd-supply = <&supply_3_3V>;
+            ref-supply = <&supply_5V>;
+            cnv-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH>;
+            interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 2b1ec46c5919..f0ae26699c99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15343,6 +15343,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
 F:	drivers/iio/dac/ltc1660.c
 
+LTC2378 IIO ADC DRIVER
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
+
 LTC2664 IIO DAC DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 M:	Kim Seer Paller <kimseer.paller@analog.com>
-- 
2.53.0

