Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4E334681;
	Tue,  7 Apr 2026 03:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775533231; cv=none; b=BQzL0n0zGsfhVlFKwjYVFbJS+HHe1OAogZn21mm1wf1TXSUC5HXiTlpo+uR1+Xitu1T5s+s6XxOAIx7ttiXwjPkAUn0EJD8tDE5/5VX3IBp3UhYU++ZCSmca+P8oGP1BNStTQ7fbNRBszfHvj9bdtZ/OxHWIXrTlnMwc+CXrTkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775533231; c=relaxed/simple;
	bh=Lg8jxJi++f9yp516M13U17ta1iCLz+GJBQ3gPn5I/r8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nBHelc/NlaEhlyTWEE5RrKwe014v3ojxTykb9WB34KcIpP4ZrkdemCXkKQgA1+SnlSn8rzU6c/k7ZK2bISXoQwcQJLohzLMdvUNfoeGI9rL3O3N16sXw0yvPULw+byAMMHOualvTtD36G9Jf4sKYSW6l/IGnCSsoeNTNEyC5zvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GJmC1RP/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GJmC1RP/"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LSSim2829277;
	Mon, 6 Apr 2026 23:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tlG8A
	aSx3SgyBMWNTocFF2e5p8HRyVYCgswR2WS96+w=; b=GJmC1RP/BO0I0EBW+S9eR
	mQUyz7j7s6K5hdUqyBt7KJ5C/IYnKn2GvvJBpWhgnqaXAUW7Rk5hXiCncp5LaEYR
	E0zfpBIlTkXvs2lmxgXrewMg8QFSlN8CuawWjHM6D1UgCwlJyWqTR73LPf7m+ERb
	N74nujHGVsEEF9bREyhs3P4qYaDi3Hhpu3hc0gw0s4CySZwwOviGe2jePIfyYR0F
	1mnJ81UUaQS+1zvzmMxs4NseBJ2CULWJwfZIwgORpzxRdMwTTZVOz3CvjFYISkja
	FVrdR1VaVJgBqo4DL4tv4uXEad4X6TWBT/7eLZ3bQU9Ao5axwlVibYie0TEYCmc1
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dcmscs0mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 23:40:13 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6373eCgd018040
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 6 Apr 2026 23:40:12 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 6 Apr 2026 23:40:12 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 6 Apr 2026 23:40:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 6 Apr 2026 23:40:11 -0400
Received: from ATORRENO-L02.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6373dsE4012886;
	Mon, 6 Apr 2026 23:40:05 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Tue, 7 Apr 2026 11:39:44 +0800
Subject: [PATCH v5 1/2] dt-bindings: iio: dac: Add ADI AD5706R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260407-dev_ad5706r-v5-1-a4c7737b6ae9@analog.com>
References: <20260407-dev_ad5706r-v5-0-a4c7737b6ae9@analog.com>
In-Reply-To: <20260407-dev_ad5706r-v5-0-a4c7737b6ae9@analog.com>
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
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexis Czezar Torreno
	<alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775533194; l=4907;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=Lg8jxJi++f9yp516M13U17ta1iCLz+GJBQ3gPn5I/r8=;
 b=K7X7QdITG2lFLGPU849C0ZkR56qbNAxOOTbv+o6HekWO/s79a2Aj7MwHS131fa2pBP1qyL9H1
 gZFEjmzMCkqAl2knzbMfWHiQD++UqMqm238Q6+qU+w2JnD0NMMdu/Pm
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: AKiqLd6tOP-imx0fDnrTfMJJybsZt4HX
X-Proofpoint-ORIG-GUID: AKiqLd6tOP-imx0fDnrTfMJJybsZt4HX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDAzMSBTYWx0ZWRfX0I16Z9Iq7JuR
 iJbUS+GSaPkcMg4XUt1MftvLWrBQT/eNapHcXoGo6750//pcEAJh5AHG+u31wwqvklrpE1A2s1z
 /RXDHU+KQvrK9WnIvkIWQY8h+ybb4kNaq+lo/6ZGmz0WYqh9T3ELHNRg4hiiCvCFdaUHJZwY/97
 RE/SFH9ycnHCFRyPOTm3OgCCaQ08/ORhYHTmUxC/EABvIpAYotxFEGJLP/lsdaX+Zlo6y9tJrp8
 X+fix3/mfPK+LxJUqQQzYhldWS3cAc35eEv+VZXLHBLUtI3kuUleIfiFkeS5zFPeAf3MFWr5tIG
 gv5kz2k7CUK69kPeFQkU4qdBgrKPxdc6v1i9PCMG6UyMtm3FWhEsjR8zV1gyK9fKwJPXeVmfgsq
 JJm3PbAm3dHZ8DnI2Bdam3RZs+bKhi8ZvPGC2FgAJZm/7weFky09IywxIbPrLYI3oRpdmH0i7pa
 0VOKqpTZeBF7ioQenLw==
X-Authority-Analysis: v=2.4 cv=E/n9Y6dl c=1 sm=1 tr=0 ts=69d47c9d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=9FN7308aedyQPFg8okQA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_01,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070031

Add device tree binding documentation for the Analog Devices
AD5706R 4-channel 16-bit current output digital-to-analog converter.

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

