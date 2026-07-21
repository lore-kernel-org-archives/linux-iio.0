Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F403BFAE2;
	Tue, 21 Jul 2026 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784623676; cv=none; b=IqcFmkALg3g4n183wOgjWSrThh31tCQIaU3TmALnn3APn4z72JHiIdx0HlRSat1MtG8V7rkTFIWVij35QtTJBgfRmL1sgJa2Qzr2DtKDgBkgtI/PXnywOd/ZTyJ4Yrs4drbSsDmVGwMPzxhQ3AoDm+HIAGnZ4uuSt/G3WTCSNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784623676; c=relaxed/simple;
	bh=R01Bt7pkF+YHSW2KmhLTLhZRGlUKWU7KjMYL5LLq9jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qnROW6lfEclevmLQqSsUwLRRwWc4iuY9qV+Ix+dshY0haVpXF/oI+yw/v0kxRlqpdRaak51JxpCefXwH1fOXf/WD3T/S5kOK5IFE7MU2W4rOmY/DxaVtUNnBdlz5p3rHDK74d15IrrSK248WV7zSJAx7bXpLUhBvyBc9Y+IwdhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KoC9Vd28; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KoC9Vd28"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L58Dmg3311030;
	Tue, 21 Jul 2026 04:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uglN/
	GTa9fNvRh1JQZeVPJwgpHvHYB6EHkEjSIlR0So=; b=KoC9Vd28xB+Jo9qrp+g9o
	4HI+7o+c5j6ixN02/+R4eH3KQdeiH94RlpS7T4LJi3QcksEXb2YyzplCVB+5SmvT
	TZsD9wFxEpu5HC5JWhG43R5f+TK2XQWI1+M3OdGmDC7rBd1HSBcl0+Fu0qOVTeNh
	810ivcJ4gzGnntk78JRDjk8RIaT4U2GL2I55rXmzRktcz1FRReNzu5pY6FLTTms6
	e4dQ78vny83tIBMHrjLiV+buQ23XEyKnE/RdX0WbwJOtDYUY4OSomVtIDEHHgc1d
	+blb+L4pNtnOVDBMU0kfPx8Y0GMoHemf3QbCdJojxBU3oLleKdOyMdYuP7HPO/Xr
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fg3ay30yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 04:47:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66L8lnx5000827
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 04:47:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 21 Jul
 2026 04:47:49 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 21 Jul 2026 04:47:48 -0400
Received: from 10.33.20.150 ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66L8lNHW015326;
	Tue, 21 Jul 2026 04:47:40 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Tue, 21 Jul 2026 16:47:11 +0800
Subject: [PATCH v2 2/4] dt-bindings: iio: dac: add adi,ad5710r.yaml
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260721-iio-ad5710r-upstream-v2-2-324949dc72da@analog.com>
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
In-Reply-To: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784623644; l=5198;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=R01Bt7pkF+YHSW2KmhLTLhZRGlUKWU7KjMYL5LLq9jk=;
 b=ESp1bb2UT64Anvoj1AgImV6JdxVZh9Id1dlk54/62nYKco+3779dJNOboX8Kmxhi3QZ31HEp5
 d5kt/MxHTA0AhHt7cTU19GV2LS5lmi2ekfc4HeKtaRRYGn65H2dlogQ
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA5MiBTYWx0ZWRfX5TqLEscMM5sU
 /yIyMGiI+BniyhC0xreup9D5q8YzA92Qrxa4mPr+YwqEl7665TW9eCOXWIZXo5HnHLMXEGghq1O
 eOkxSmhoZeiYq6ex0bLGNGvg4t2fxgzJqNTvSH8cV7Tm8HJmW+eHxvRoiNsJsd2n+GPL2IjDTR0
 JJnFYYEmHJiLIgaa7hMOMgvp8G6byT7GxQk1EK4dqraob3ah9CD93fud+oVIKtnqYFd/typK5GM
 QHylTDNpHikCwlunjb5qaH7yUxBvbCS+6PthoBmzKNqq0Z8PO5mMxxd3QOzhIliOKHJv55UUnRc
 sytBPpCyyr7DnM3ZZf3qtTb+TIIvordm0ixcD/EthWRfva8T+J7FOCmhlVUTc+7bKnwIRkZqXMS
 Ri2WzVzA4dkCPp/MwhOf+m6+edPqGdggFAFDN73qyR2FrZq1bgGnaAW0Y0iEy2uBfocYpe7RuWr
 ZxCg0KmSsq47oM8hRDA==
X-Authority-Analysis: v=2.4 cv=evjvCIpX c=1 sm=1 tr=0 ts=6a5f3236 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=UDoUUgFuJgqny170jhoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: aDbJ04p4Z-6_Ik1UUEu7Ejx5zPZ5Y6kI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA5MiBTYWx0ZWRfX7G+ieqEW0W4/
 Fq8rGMVaeEq6S+06iFC7h/hQHhBZOR1LP3FZvpMZbJZRTIMRMgVDNY+gzX35fjy1ynxhemmQ9d2
 Djfg9KxZUPVT6aV0z9Vfe6CM+uoK/ISk3zh2bsow9aIKFdrZnya+
X-Proofpoint-ORIG-GUID: aDbJ04p4Z-6_Ik1UUEu7Ejx5zPZ5Y6kI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210092

Add device tree bindings for the Analog Devices AD5710R/AD5711R
8-channel 12-/16-bit Configurable IDAC/VDAC.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 143 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 144 insertions(+)

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
index 7077ed7c9efe..f207125383f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1444,6 +1444,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
 F:	drivers/iio/dac/ad3530r.c
 
 ANALOG DEVICES INC AD3552R DRIVER

-- 
2.34.1

