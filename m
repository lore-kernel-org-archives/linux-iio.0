Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77846395254;
	Fri,  8 May 2026 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241404; cv=none; b=mAsNMAqEQFWMDjGbeAYX9NXpQqFMbUsoW+VG1paj/q3Mh9pcnzLr//1Lkab1Kbo5i6sB4cNbYvzWbli8QZmqZ2f7Z2hAbKu/fM0laaqo5bfWSbTQyMZ+zr4mb6QH05Xdqu5I68tsjJ4iLPSA8SjbrngnRdGkvIvGcarmciJyfkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241404; c=relaxed/simple;
	bh=9H5BNeVf9I/101WvuVw3JYEgApgCLJiV97a2V6+vvbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HmqoZvkPrRUNdZsyh3ys3KTxQnb1se5NAQMaJ8SHLyV+RkDcS2x3TdtGoVt6hhm8aioU70Ut7MG0IbPI1I6LNuY8VtLO4AcgmwMuCvVzxhFWfSUlSMQdthpqHkmbxAQnWxlaGnImgVT5ZIcEqiOW1wg6EyJl/wgIbpg3duxnJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hJbESh20; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hJbESh20"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6488eaJP3612946;
	Fri, 8 May 2026 07:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gQXyd
	o9mqSFkLDBpxBoRxLPcC+BlZXmsQTVDLfxww+c=; b=hJbESh20E8I8mQX8o/zTw
	iJHLnbZUVqsGfdL+i4a+KXdYOrZRrT3qtYGqKkiOWgq6zlSNctu0NLM6sbiViwg6
	hmFjp90UDclvlSIiVDNNcypfR0iWkEubB4/9gIJVIO13Gb6OF54Chk+kvpyhcYoo
	t+Yp9RWAl1OWAM/quwEA46y0K1i9PksWB7yAtFGMjBREYH5NIYD6jIXo0Il2r6tj
	/pEcc5Qafuxj43ksXnn7lXfzfHojE/kuCJ+GukT6XxNnD3jCbkISfDupCaLiQsU4
	CjgDCUC6V1fedlYk6fDDGdKpTDpXy+eZWIuoYrUmrz4eSrzSGhs4uuIzQaiKdbmh
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e04pjj6n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 07:56:08 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 648Bu74P041466
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 May 2026 07:56:07 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 8 May 2026 07:56:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 8 May 2026 07:56:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 8 May 2026 07:56:07 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.80])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 648Btmn9001846;
	Fri, 8 May 2026 07:56:03 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 8 May 2026 13:55:47 +0200
Subject: [PATCH v2 1/3] dt-bindings: iio: dac: Add AD5529R
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260508-ad5529r-driver-v2-1-e315441685d7@analog.com>
References: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
In-Reply-To: <20260508-ad5529r-driver-v2-0-e315441685d7@analog.com>
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
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778241348; l=4172;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=9H5BNeVf9I/101WvuVw3JYEgApgCLJiV97a2V6+vvbM=;
 b=RZb6Aj9ShOXRA2snJ78nYNZrkULkHMKBSyft/LUs/fEc0qpTdVopItL8LE8bIMKPN3lpW9qz7
 ulrMLO8PqRhBa07GfzQ5fe+VEH/OFFDehjXiZOI9WF9U8p9ZcKVDzF5
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEyMyBTYWx0ZWRfXxYh03La0mf1b
 u+T+agKVSYcVhBH/f2qgAEPRHp/9ITzcCKseW2M4rTd4YZz/gLf/fhwP9wj+qyplTgKMRGyrW7U
 4D+VNAO0/CeQ7XPmrEISJkw02kjAy363V067i+f6y6E5cW07a+Dov0PffQoqrMzthWAaf8/oWNr
 DZUkX6+rAp/hBsnnu1WM7tx0cPGzydfr4zeds06p/LrjNL4smJf+tzitc6ChNtsCgmf2MYUmI7+
 MnpFznK8lnndn1n/Gaf1EK8dQwy5Y+zDfKPMbePlE+BnXQA9ZzcydnUPvbhgnUlDIKuvbXvPDIw
 lG/agWrqF0mpQukeyaqFWsMbHmgEUJJLx7qxcEI9Uq+kV8P4lVnKrQgbUnIiPmP5KIg4c1faSLk
 s64zkDB8nWtAkst6pYwFI4zBTERXs7bPPjJQNFMSCIYGDGiS+O6RnU1sZSy5fIcy4zxqou/kQs+
 FgC5su7Q9SLg2ZgEdBQ==
X-Proofpoint-ORIG-GUID: NgGzA3i1e2ZhCNiCOy4CPRr_VfecAE2T
X-Proofpoint-GUID: NgGzA3i1e2ZhCNiCOy4CPRr_VfecAE2T
X-Authority-Analysis: v=2.4 cv=Fss1OWrq c=1 sm=1 tr=0 ts=69fdcf58 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=2822el1E8ZgoiK-DOvAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080123

Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
buffered voltage output digital-to-analog converter (DAC) with an
integrated precision reference.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5529r.yaml   | 96 ++++++++++++++++++++++
 MAINTAINERS                                        |  7 ++
 2 files changed, 103 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
new file mode 100644
index 000000000000..f531b4865b01
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
@@ -0,0 +1,96 @@
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
+    0V to 40V, ±5V, ±10V, ±15V, and ±20V
+  * The device supports SPI communication with Mode 0 and Mode 3.
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
+dependencies:
+  spi-cpha: [ spi-cpol ]
+  spi-cpol: [ spi-cpha ]
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

