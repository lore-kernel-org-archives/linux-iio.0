Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEABB21D3D2;
	Wed,  1 Apr 2026 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038863; cv=none; b=JfK3zaXWYl+C7DcQ++VYLMToEqW2SqYFS/nqE+ZXX84N1gTRXgGqJJAYTSZBugu0qMPS87/hOAtjIx1pBobkv/Zb8y6AzisICuholahqHLRRLnC1sYZVQ3+tXs/UDMwaZaqAVnZELpVQp2M4JlHIJKHR3grMa/DIOXuKdHTWMaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038863; c=relaxed/simple;
	bh=xmWdwFYRi4d4+BFlus0UsjqsxUrkk5IbVrP0x8oSo9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fBcPh9ryFirWbJRmtYcClk+03yGIxsKZpyZUATULqqOsx9I+JECoPnDQNkM/cU98GlFOZUDZs+1qrwwvr+92f8KXX+5Hq88gE/HPsiIB7v+urHElT5lLfYz1fc1ldIX1+hbeq9k4mm9TR877fOocD+0Bb+5ozecibjUnDq2OrFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AC2HmWKr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AC2HmWKr"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6319Rj3k2772134;
	Wed, 1 Apr 2026 06:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=qiByb
	GrBl7sNdPfUrXWqT2D9nbuOntGl0h1e5V7sMp8=; b=AC2HmWKrsm7X0mV51Zpt/
	71kBqDikgkOpfXBf/pAlVPuGZS7DXRNyO2nu2lhGJ1m4knknJFy5SwwRfkgfD6LO
	OTag4IVt4CQqJykpHuAgPtbmcygHMEs2I1F1fe325Zr8g8ardWSY73xr4+lu5v+4
	EEj2+cbUoSlIBagroYzgcOSDLiXGPwNbcNWj702LiCinPZV4ycJwNtZu0eKIB9l8
	z/MNOEGF4paICKmSK1SDbtTNusKNku/pPoCLQ2eltOkHvfPt30n4URmaG0FlI10d
	WpIXOMnDx26/JorSs/O3zRwKOedwk3PGfC+MmnD66X/biDeElHTFt/iFrZ+Pkwic
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d90rjg5v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 06:20:34 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 631AKXHu058793
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 Apr 2026 06:20:33 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 1 Apr
 2026 06:20:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 1 Apr 2026 06:20:33 -0400
Received: from ATORRENO-L02.ad.analog.com ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 631AKFrd007322;
	Wed, 1 Apr 2026 06:20:26 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Wed, 1 Apr 2026 18:20:03 +0800
Subject: [PATCH v4 1/2] dt-bindings: iio: dac: Add ADI AD5706R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260401-dev_ad5706r-v4-1-a785184a8d53@analog.com>
References: <20260401-dev_ad5706r-v4-0-a785184a8d53@analog.com>
In-Reply-To: <20260401-dev_ad5706r-v4-0-a785184a8d53@analog.com>
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
	<alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775038815; l=4509;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=xmWdwFYRi4d4+BFlus0UsjqsxUrkk5IbVrP0x8oSo9g=;
 b=M64WUMnzu4fBGNd9Zcpgl47oW+SVTJYB6s7cZ3PXHLklATLi0fM3A2JpyF37mjNSzQUxabKl1
 2RX560SUDDUB5qMEIpWecbGGw2GOOVa/b6pYm/9HquIeLDVwfPjNItk
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=SuadKfO0 c=1 sm=1 tr=0 ts=69ccf172 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=9FN7308aedyQPFg8okQA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: 9IOVK-0VzUJiifKFYmZ-BbQN_BHaIWcM
X-Proofpoint-ORIG-GUID: 9IOVK-0VzUJiifKFYmZ-BbQN_BHaIWcM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA5NCBTYWx0ZWRfX9T1FZWKyEDk1
 VwU+5yWDl2S+CPwkA2Z1GJrCPnB/LWf7JgKK+i1RWeRBgWRAiUAp5bbM9fFXudie8WvrJJu/9+f
 G1QcbXEkD6+Bonx/TzCuFHbwakjOL/UypxR1zeJG9cCUzxTFdUioEebl1NibOc6eVylc3HeFmv8
 301OJBzVxqp2Qfa5tr9GXIcO4HeD8VZgwHTmPe/wG6cCOin8PUxaLa+97CiD+Ene1BI8MCRuSoe
 MfEM1tt4bnuzkGd9dvjjirECpabZznKvtzUsGpvOERQgB+kVJBug1gaSxyCn+9rJfVxlRJ6oTrW
 AZpD4B6cDlK1zhimqyUkY9PnGpP1rPrTZYMkbwrjyxIBFBc5pP1lN9q3EA/gpZRfTWugKlUzXPD
 MOeYIhbyf6K296ZdPnkJELI6o2XvxZpivAFHBGT2gFBJp8aO3lAqUkfgJW5D29uQl6Ca9iyVefo
 HTOMONGR1Jy10oLLijQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010094

Add device tree binding documentation for the Analog Devices
AD5706R 4-channel 16-bit current output digital-to-analog converter.

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

---
Changes since v1:
  - Removed clocks, clock-names, pwms, pwm-names, gpio properties
  - Simplified example to use plain SPI bus
---
---
 .../devicetree/bindings/iio/dac/adi,ad5706r.yaml   | 105 +++++++++++++++++++++
 MAINTAINERS                                        |   7 ++
 2 files changed, 112 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..589da8371e98d3377c9ef05015e5299edf98573f
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
+  out-en-gpios:
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
+            out-en-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
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

