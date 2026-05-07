Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8820421F06;
	Thu,  7 May 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778171355; cv=none; b=eHZSm///mqUN3IqP3n7PIgP9CxsIaH6j0f02iLlHYG+pjLYeD6bJniVDx+TNZ+Xm8wOcfcTgjeED0Dfmlqk2iUeqK06NEchILqOVJGsQJ08i+3BVjQy1S22jSD0InfVvLoRBC5wc4BU1c7yyj/kcX8paUfcYZs0ZjDxok8KYSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778171355; c=relaxed/simple;
	bh=ueWTcbCP/B9UpzVWeDJh++LbwtuYajNeS07+A7yRZQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cuY4rFn0LctLwIhkZFFmIYPADVwBbyba+wmF7jB0OL8Jc0Nr6jbeABk+wIzmadTICh4qPdqh3B4y37WCBBVOxTMw2WGYcOMs1Bf0ZJRCdvhnzEnWDAvbHhVG5jWp/k0hEanL8DlHMjTIQR3w+SJoXyaL0hCuKqvn6oSwiSWfuHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OmGR4AJi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OmGR4AJi"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647F3QjB494531;
	Thu, 7 May 2026 12:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6XyJg
	W5ey5xIilsu5y/zj39GdPDpRWRzuUt4NypnBX8=; b=OmGR4AJi0q2Mbmm/aFj/J
	MKLYoM0IWn2H7pT4t+GrBGkCnM4dE/Xnl7Nhu0li9rzf1Rb4xBkfWITLfKrdOIep
	2OUdlyAuiKPZ8FRXZfNaFs+4j9+gZ4kPbiuWegVzuJoOoQ2q2djLpX5XyRnIROxE
	htnNkCD3+8Tad8qk9RfSmv2xGp9qmS7J1h8jz22FrOKHGQFnVeYLXa1oFz65++hE
	iCspO3k92+d/T2d4DZNe7ndTGoUH0aZGuxxobUA2yK95Jp42BkiVNKFgHXU0AL2k
	qcXQ5d96NdlZlbz3ZcZb2Pqth3DyvjEwdAB+b1WzzXR/6WJW6B2IvLx2NyjSR0VV
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dycmx39b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 12:28:44 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 647GShlX021375
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 May 2026 12:28:43 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 7 May
 2026 12:28:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 7 May 2026 12:28:43 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.4.71])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 647GSMkM030829;
	Thu, 7 May 2026 12:28:36 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 7 May 2026 18:28:09 +0200
Subject: [PATCH 1/3] dt-bindings: iio: dac: Add AD5529R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260507-ad5529r-driver-v1-1-b4460f3cb44f@analog.com>
References: <20260507-ad5529r-driver-v1-0-b4460f3cb44f@analog.com>
In-Reply-To: <20260507-ad5529r-driver-v1-0-b4460f3cb44f@analog.com>
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
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan
 Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778171303; l=4266;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=ueWTcbCP/B9UpzVWeDJh++LbwtuYajNeS07+A7yRZQA=;
 b=VE5dLx/X6YmRqC1BdaIT458LLoeHkb+RdnW+Lu6s4CebWKOygAjvO/sN5tv9pB3exNF7ikc8E
 HlIu5pK+ZO+Dizdn4ACwdu9VWYTtvpkKKFYJtLlRiVkYyptg5fGAjbe
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 8QhhplATCC7hO7ShTF_REsv2qS0z5EDL
X-Authority-Analysis: v=2.4 cv=C6/ZDwP+ c=1 sm=1 tr=0 ts=69fcbdbc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=2822el1E8ZgoiK-DOvAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE2NSBTYWx0ZWRfXyzVpLhkyDRFH
 CbK1celi/O8mGFa100tpZCipq+KXhca0GBx77eQvihUaPHIT0ZgdXZkQc61t7liEjuZOEHB+uBE
 /j6M+WJZKDO9vRzllj6ObthnkSXZpeZafrELgAvlRrLpM365gcisWzBtBglc1r2AoclaWifwqcr
 pgGMGJgU9RpfSrhzobc3SieTiz2A3Vk5dmuRQrsANQeT3CD6q6KcoXxxiTeBhAqYtbe6cROqy7U
 zhNR47smIcP1xH2zRfjHirktftQEiFiybMdMkffbRQo1FcrHcP73t1L5+xnzj+stz92VDEK4t6O
 DdEzFADspRG5NfDgYCZR/WmviFuUxX5GGniE9Lg1xGXhPNgftRUd8cfP+X4qV8RCn7rby8TgEXF
 k3+YA0lm67VoRofg5HneDjvwPle2tPxk2I1hDEvcsaQiDZQEXWpDsNRnTki54+FvRTkzeABUxVD
 HL6Y0JeHG+iaz/qt5Xw==
X-Proofpoint-ORIG-GUID: 8QhhplATCC7hO7ShTF_REsv2qS0z5EDL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070165

Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
buffered voltage output digital-to-analog converter (DAC) with an
integrated precision reference.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 99 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++
 2 files changed, 106 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
new file mode 100644
index 000000000000..ba559dde75fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5529r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5529R 16-Channel 12/16-bit High Voltage DAC
+
+maintainers:
+  - Janani Sunil <janani.sunil@analog.com>
+
+description: |
+  The AD5529R is a 16-channel, 12-bit or 16-bit, high voltage, buffered voltage output
+  digital-to-analog converter (DAC) with an integrated precision reference.
+  The device operates from unipolar and bipolar supplies. It is guaranteed
+  monotonic and has built-in rail-to-rail output buffers that can source or
+  sink up to 25mA.
+
+  Specifications:
+  * 16 independent 12-bit or 16-bit DAC channels
+  * Independently programmable output ranges: 0V to 5V, 0V to 10V, 0V to 20V,
+    0V to 40V, ±5V to ±15V, ±10V to ±20V
+  * 4.096V precision reference, 12ppm/°C maximum
+  * Built-in function generation: Toggle, Sinusoidal Dither, and Ramp waveforms
+  * Multiplexer for output voltage, load current sense and die temperature
+
+  Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad5529r.pdf
+
+properties:
+  compatible:
+    const: adi,ad5529r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 50000000
+
+  spi-cpha:
+    description:
+      SPI clock phase (Optional). The AD5529R supports SPI mode 0 and mode 3.
+
+  spi-cpol:
+    description:
+      SPI clock polarity (Optional). The AD5529R supports SPI mode 0 and mode 3.
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the RESET pin. Active low. When asserted low,
+      performs a power-on reset and initializes the device to its default state.
+
+  vdd-supply:
+    description: Digital power supply (typically 3.3V)
+
+  avdd-supply:
+    description: Analog power supply (typically 5V)
+
+  hvdd-supply:
+    description: High voltage positive supply (up to 40V for output range)
+
+  hvss-supply:
+    description: High voltage negative supply (ground or negative voltage)
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - avdd-supply
+  - hvdd-supply
+  - hvss-supply
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
+            compatible = "adi,ad5529r";
+            reg = <0>;
+            spi-max-frequency = <25000000>;
+
+            vdd-supply = <&vdd_regulator>;
+            avdd-supply = <&avdd_regulator>;
+            hvdd-supply = <&hvdd_regulator>;
+            hvss-supply = <&hvss_regulator>;
+
+            reset-gpios = <&gpio0 87 GPIO_ACTIVE_LOW>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index d6c3c7d22403..320e84765ce6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1507,6 +1507,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
 F:	drivers/iio/adc/ad4851.c
 
+ANALOG DEVICES INC AD5529R DRIVER
+M:	Janani Sunil <janani.sunil@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
+
 ANALOG DEVICES INC AD5706R DRIVER
 M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0

