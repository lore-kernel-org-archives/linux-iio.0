Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7467D3CB569;
	Thu, 16 Jul 2026 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188861; cv=none; b=X6xRLWSU75ECagyAmBd5k2GbEe1kPsyIuYUp5d8pZAOoZd0Ty14kkmCZXaUu4xiCyE0Wu4LbK0LOxaokhJYtk+hlOpewceC0m0NxM9AmLZPQAIL8FltTn1kG8EFHQ1kSzgbMCawKZvqGxAlzr0eJ3pDXuKju3F30t77BC2OeL0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188861; c=relaxed/simple;
	bh=czT1wzM/XI43ur1rVxP8lWM50fznaav9LH5uWEUtvjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=H07mGA3YgF4yRxZk6GICIq61+PoL8nqmI5UZl5OHmsRQvjfrXrCPf0nqegWZ2U1Ntla3qpewr1ommDeovUZGYA3OalHL83SOduQ43MuIQ+dIQQdr8eKykuuqQXFNQFHG/YJBxj3ROy8UZH47dznmWr+TUN4PANIFXqrCAhvGI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=snY3Ejeh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="snY3Ejeh"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7IP2L3187824;
	Thu, 16 Jul 2026 04:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0W2LT
	nn+qHml+SXPPlypcZRRz5WT2Ght+cnM+LG2GKY=; b=snY3EjehzP0TaLPtLGvhO
	Fl1bnILLOW8JggOpj+fp2NRpp2/C4ZsszcZJbgssmNrb/MvMycJCbnyAdMNF4Fyh
	bGB/+TSZEszj851ZeEXqdP0QfjpquusVZ10lIOf6Oxe/k/OOjOcXAn10Fcljxh3w
	LZfrNR7UrZ2Xhr/j7h6tECCFdIyaQ3W73kuIFwmLNwi6ICqUJ0pdxWef9UxiDuQg
	BTaukMUhzIfQfCenOuwu4hir/ZkZHoZbRFYYvxHPYyu3XGK5DLNvVJJEewr0LnYW
	G959mOrDnJJuESHuu4yp27xa8FVjeZDM3bf5V6EumBUopLk5A5i4d+t936Bc7d6c
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fe8a8c9ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 04:00:27 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66G80QLi058502
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 04:00:26 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 16 Jul 2026 04:00:25 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 16 Jul 2026 04:00:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 16 Jul 2026 04:00:25 -0400
Received: from analog.ad.analog.com ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66G7xo78012697;
	Thu, 16 Jul 2026 04:00:15 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Thu, 16 Jul 2026 15:59:26 +0800
Subject: [PATCH 2/3] dt-bindings: iio: dac: add adi,ad5710r.yaml
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260716-iio-ad5710r-upstream-v1-2-e848a4bb701f@analog.com>
References: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
In-Reply-To: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784188790; l=5418;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=czT1wzM/XI43ur1rVxP8lWM50fznaav9LH5uWEUtvjE=;
 b=HXgzmmP613za/rBKyGk6JcanBZDMnBWHSVtDhmKxk60Z5EyknoEo+dGeK6tdoXS7fyFvidkMQ
 8A5ndqcuk/3A+ads2MzIe9W2vipBuZKz9pznedgV/vAPBj3d7hWHO95
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfXxgwlEPn6A7pM
 KX18mAR1r4SJIm9Q/EzhYzZbZ/FCQDcw131DY0pAOg49qKwPHD1Y6msyHz/t8UktKbeIIqH90Mg
 4K9MDPKSIXEVd+qdwEWVnqt1BsDC9nbpfxcrdMmiXNlq9T0yy9UG4C2pTbeUAdvC0Zr7Ht54Thn
 SO/3aEwJOODZaYBO7YnbUt2AgkZnuzYAf1teBugr+yxL/EG7ysogodYE5LzFqM+ltu+0UcI9yvk
 3CSD49iECDfs1tGXWXXI0DMSLSxNvHdZIefNem5xxdQCByZ8eY2F8NG+w4rSYO+5c+Qq+IQvmgf
 E5Hk2g+sU78W3wxJTnE8FgPAAelSyUQxYIFrEI4yU4+/YwbbhX2S4d364t6XHBRKlu9K2LMiS+C
 QPMuYCpDlEDEhCBV3pgTrADrulI4GPT5/tF/dlxVknv2H31kUWiSRU3qdonLtnKS8ueOvfwAmj3
 CVqRr4Pl4jRxS5TUIDA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfX1izWcC2/W328
 qlF5LE6h47VKfYMKsdCm/PwshCqDEvJLlw8dNfvT6vFVPg4sglo/MjxkfccdlKgsN6QD8t4plqK
 u9UuNosJR4xZBso/HUeU+LQAN/NUvBDjQ/VDYLqgx+EIRYdUqfdN
X-Authority-Analysis: v=2.4 cv=R4sz39RX c=1 sm=1 tr=0 ts=6a588f9b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=UDoUUgFuJgqny170jhoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: 7TbcpLeTEzMyhg396x4Fpy40OPG9Dhxx
X-Proofpoint-GUID: 7TbcpLeTEzMyhg396x4Fpy40OPG9Dhxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160081

Add device tree bindings for the Analog Devices AD5710R/AD5711R
8-channel 12-/16-bit Configurable IDAC/VDAC.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 143 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 150 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
new file mode 100644
index 000000000000..17c1bf009242
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
+  configured as a voltage output (0V to VREF or 0V to 2xVREF) or a current
+  output (0mA to 50mA). These devices operate from a single 2.7V to 5.5V
+  supply and are guaranteed monotonic by design.
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
+      the output will range from 0V to 2Vref. If the property is not present,
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
+        items:
+          minimum: 0
+          maximum: 7
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
index 2b1ec46c5919..bc4ae061909e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1555,6 +1555,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
 F:	drivers/iio/dac/ad5706r.c
 
+ANALOG DEVICES INC AD5710R DRIVER
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
+
 ANALOG DEVICES INC AD7091R DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.34.1

