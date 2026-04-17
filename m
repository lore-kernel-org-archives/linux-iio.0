Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87753AD530;
	Fri, 17 Apr 2026 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414499; cv=none; b=IgfUbAydQbh6jfkM/aBrrVzIlNdF7T+k3VHAp9I4S7GvjR9ivvOJ1j7MbnKdgiU670BZd08OTB+b26UcypC8loxEeJ95gzIKzipyiShv3bE+POiq3lzPxu02TaMPcIuHsmEYWWu1h5m+7s1XT34lgZQj6KdTa++a/sJ3As5Wo2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414499; c=relaxed/simple;
	bh=vyDntxC0pb5yQ2Tiq9+7uYt7LfP7Wnia+i9RAceOr4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kewhU41rVB8arba2pP/s0F5lYNJMcDw3u6sgpoMqWHktrHenT6MiKTwkz7M48VFgyoLrFsxdkmOO7W1klV5Lz+DELnngR4GR7pLsHpZyAxsckyM+OZJTSnFlAZSXnKOxesVHBJZWl38/59vpHcT9tyvqYO75R41eKIXrrtYXpQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Kp9ldaQy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Kp9ldaQy"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H7Cn191699948;
	Fri, 17 Apr 2026 04:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6j/Ep
	UqCMxoigj8hO5I88dePOXUsGsaMf7qn3ELNMgI=; b=Kp9ldaQyDnO4mfbWvmdua
	c7zdthU4nFnKG9N2N+BsUZW8eug/MxLWb5+t5KxgMqtSp8T1xDHc4vsLik1QE/Jn
	Ml/o/ihXwzGzhc1W7ryFpdhD6bkUU+xaZHvXm9R3MIIx7vezoq5kfEikw4crxarj
	5b8MvTNL8F7/tbGYOIQVUVwOk4c6bY+mzZJeLO5zatA9rcmNnhlbGGHJbG9FBuu2
	MINrJv7+IZ5wunF7op0WBAa4P4vpnPGVUtnsYaFJP2vu6hESMOTjjG4iy5vzfpPQ
	RVM0LN3hfwl456pmsXfVnEnHvgcKrvtyJ7ZpN/8SxjZ8r4m3hx4nX5yr1U+FsMkT
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dk4cm2jjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 04:28:00 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 63H8Rx0Y010677
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Apr 2026 04:27:59 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 17 Apr
 2026 04:27:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 17 Apr 2026 04:27:58 -0400
Received: from ATORRENO-L02.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 63H8Rbib029844;
	Fri, 17 Apr 2026 04:27:50 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Fri, 17 Apr 2026 16:27:15 +0800
Subject: [PATCH v8 1/2] dt-bindings: iio: dac: Add ADI AD5706R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260417-dev_ad5706r-v8-1-ef87dff62b57@analog.com>
References: <20260417-dev_ad5706r-v8-0-ef87dff62b57@analog.com>
In-Reply-To: <20260417-dev_ad5706r-v8-0-ef87dff62b57@analog.com>
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
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexis Czezar Torreno
	<alexisczezar.torreno@analog.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776414457; l=4978;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=vyDntxC0pb5yQ2Tiq9+7uYt7LfP7Wnia+i9RAceOr4E=;
 b=1xHoI1LRhgg+EHxTtTOHycLErfg9C+Kx8qNIm7si/xydBWr9odIHwf6l4ZhWbpsjoR0QSQYSY
 NEjKWmmhmuABHrlob2p+YicDWHOOghtmowEFqbxWgrQ6MT2JZaLfDYL
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=dpDrzVg4 c=1 sm=1 tr=0 ts=69e1ef10 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=9FN7308aedyQPFg8okQA:9
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: fIm3T-ar7H2gvoeL_Rv3s2dC9xRIAowL
X-Proofpoint-GUID: fIm3T-ar7H2gvoeL_Rv3s2dC9xRIAowL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA4NCBTYWx0ZWRfX+JHEak8wLN9R
 G4f3bF078SXgdrR2amP7GWj3BxWUu+a1hZD6aRe0/aTlRZ5I7QAuwcdxpXivL9HtSk5q82CLcv+
 JK9yrWhiyobyN546mt+udHsQ2V8iQfBI53ndp32Tl3jvu0apjfDHgCn7cBmk/7d32rAJMTJonw9
 2OrIojnOizy55npEaD0BOBZVb9IfgyiaHSDQ7RieSXYdtUnzKEYblX33qy5oi8Im6/ULXNMv0u+
 ZLjbJgkc1Oz07xI+58S8e4Y0jZMiZT4885Ef03qJDhVyACDYM5ZqzFQuheh+w3vaHWsves1O4Rz
 zsxsUHTGiaEEn2L8t1ffsGNrmzWlq9xHWqjSkj00Q2vM3yWXzneA+1sMbqFJJ8um53DE7mrJ8ir
 sOVmh+kXjdXNQDwiVQmOfTAJBEB3/8J3fn16PGSYn1RgzMzfOr9nrpNsn/+ZEEMFAGFzplSYnyT
 YAFLXus5FKDjJK1+1/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170084

Add device tree binding documentation for the Analog Devices
AD5706R 4-channel 16-bit current output digital-to-analog converter.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
Changes in v5:
  - Changed out-en-gpios to enable-gpios.

Changes in v4:
  - Reverted pwm and gpio entries
  - Added missing power supply properties
  - Clocks not added back as they were driver specific

Changes in v3:
  - Added allOf and ref to spi-peripheral-props.yaml
  - Changed additionalProperties to unevaluatedProperties
  - Added avdd-supply property and added it to required

Changes in v1:
  - Removed clocks, clock-names, pwms, pwm-names, gpio properties
  - Simplified example to use plain SPI bus
---
---
 .../devicetree/bindings/iio/dac/adi,ad5706r.yaml   | 105 +++++++++++++++++++++
 MAINTAINERS                                        |   7 ++
 2 files changed, 112 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..19cc744a9f0fc35907de8b8bdd9f088676620b54
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5706r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5706R 4-Channel Current Output DAC
+
+maintainers:
+  - Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
+
+description: |
+  The AD5706R is a 4-channel, 16-bit resolution, current output
+  digital-to-analog converter (DAC) with programmable output current
+  ranges (50mA, 150mA, 200mA, 300mA), an integrated 2.5V voltage
+  reference, and load DAC, A/B toggle, and dither functions.
+
+  Datasheet:
+    https://www.analog.com/en/products/ad5706r.html
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5706r
+
+  reg:
+    maxItems: 1
+
+  avdd-supply:
+    description: Analog power supply (2.9V to 3.6V).
+
+  iovdd-supply:
+    description: Logic power supply (1.14V to 1.89V).
+
+  pvdd0-supply:
+    description: Power supply for IDAC0 channel (1.65V to AVDD).
+
+  pvdd1-supply:
+    description: Power supply for IDAC1 channel (1.65V to AVDD).
+
+  pvdd2-supply:
+    description: Power supply for IDAC2 channel (1.65V to AVDD).
+
+  pvdd3-supply:
+    description: Power supply for IDAC3 channel (1.65V to AVDD).
+
+  vref-supply:
+    description:
+      Optional external 2.5V voltage reference. If not provided, the
+      internal 2.5V reference is used.
+
+  pwms:
+    maxItems: 1
+    description:
+      Optional PWM connected to the LDAC/TGP/DCK pin for hardware
+      triggered DAC updates, toggle, or dither clock generation.
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the active low RESET pin. If not provided,
+      software reset is used.
+
+  enable-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the active low OUT_EN pin. Controls whether
+      the current outputs are enabled or in high-Z/ground state.
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - iovdd-supply
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
+            compatible = "adi,ad5706r";
+            reg = <0>;
+            avdd-supply = <&avdd>;
+            iovdd-supply = <&iovdd>;
+            pvdd0-supply = <&pvdd>;
+            pvdd1-supply = <&pvdd>;
+            pvdd2-supply = <&pvdd>;
+            pvdd3-supply = <&pvdd>;
+            vref-supply = <&vref>;
+            spi-max-frequency = <50000000>;
+            pwms = <&pwm0 0 1000000 0>;
+            reset-gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
+            enable-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 1251965d70bdfa990c66966cd77f7ab52ae3385f..17a3d2d45fccb9cd3c93fd35666fb85d17d53cde 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1496,6 +1496,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
 F:	drivers/iio/adc/ad4851.c
 
+ANALOG DEVICES INC AD5706R DRIVER
+M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
+
 ANALOG DEVICES INC AD7091R DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.34.1

