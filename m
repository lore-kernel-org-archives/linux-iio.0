Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62447277D;
	Thu, 26 Feb 2026 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123516; cv=none; b=mIuzlpSBVScRH+GYhpBTiIz/s38yegRjUw20TzPmOcUvE4kY6QCcmaE6mav8MmZAAeUDxgafzj5IDcsVe5UJCjVy00rmmFysVMatLwU/Oh7yOHPXrRz9pZogvmtrZ4Y+RZEe6UfwU/t6l6Khg/k1pBWm3Y4Ode2bgR2oBBiNpP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123516; c=relaxed/simple;
	bh=UUa96X2mDxPiOSeWvKBlopUXmKj6Ocv3XPjJ+STT2Zc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLwwYAitmLv85noewoIL1JKlyGKx7klAgihAxrKKb2jTLAf3XEwW+GgeTzCCgFsInKAUy9v/STXpJc0y3lJRdfmHkSNMsiWdbhnVRRTZR8QNlc0Wci47TSJOwT/FPPxp+/XLAk3yMxEb+tHhBwdSIEhUW+Vo1Cxtq8/nXGFwu1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YscOnbPE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YscOnbPE"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QBnHfX1380254;
	Thu, 26 Feb 2026 11:31:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aj5EY
	wwmlbSuh1okPCh6f69agEjWANkhCYBrGBwCReg=; b=YscOnbPE6HaiIHFL1DWqo
	erxheNfhotGhKMH/M1NyrfldfZvk76SJHehqVVT+6pPyFDp3O7JRRSCevXrGVW63
	62dagOBK0s/hETeE/TfF1KvQf+/kpM6A8Tv592IziigsmceK+km2hvj+hfuIISbN
	nyv7lcyXUl2nFMjZEQJytuvmjPcv5g5K1LnkuI9fMg+qjHVB0zDHnoZO17045tEi
	1s3i6gy5ZFTktJGtA/C9RShJ+7BCasiQjXzQUtOxI24baEJGq2b0AMnlyl5s6/Lq
	szGi+czLy4ov3XHzWupmunQqCbLa+d8i+rGbptLIKCCQfTnojUcdbKf+U/ILaGsp
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cja98knyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 11:31:33 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61QGVWmv056498
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Feb 2026 11:31:32 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 26 Feb
 2026 11:31:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 26 Feb 2026 11:31:32 -0500
Received: from JGERONI2-L01.ad.analog.com (JGERONI2-L01.ad.analog.com [10.116.32.144])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61QGUkMo008067;
	Thu, 26 Feb 2026 11:31:21 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lars-Peter
 Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: temperature: add ADI MAX30210
Date: Fri, 27 Feb 2026 00:30:40 +0800
Message-ID: <20260226163041.169786-2-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226163041.169786-1-johnerasmusmari.geronimo@analog.com>
References: <20260226163041.169786-1-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE0OSBTYWx0ZWRfX2Jx+s5TLmqm6
 U8RrsaN8z8Mr80CZKPO1Kw/PzsLHQ2KDTbuycX45bIUszgvnhMM5/tYOfQ8EH00kRcdk0Q6+0aB
 fXp8lJ1uHBNh10SwjsN4723U66oMOd0EUyrU49pKXAXklG8/zghyEWnLrJdjYMC0haGxp2e9FTF
 p4/R4UYObl4JeG930OIvqIv1vF7Es30T8ybyoqZWdBQXppWamX2Tmsb5Xzmc2QBkirkVMPACym0
 U/6+gcdMIE+iTMNIINzF5r5vWQQOkld0OHxLfr7nSTaZH5Gjqi1gMBcBjSn/Ab7U14klkfaehNY
 kjh5zWdDblvlJ+1Y5DGxrPeqXr+ImMYSS4/9Amr9BN5XMsEKVjzmugifv73kh+vYUEzKKPGYz5w
 i64LopHWfrqauxHrwDUfizfz0TCL0xLhaCy/iWe23iheMCinIZg4kdeq3pgwfzW4xcML3qSe85e
 Prmq+HvoG/R8hP4rXSA==
X-Authority-Analysis: v=2.4 cv=a+A9NESF c=1 sm=1 tr=0 ts=69a07565 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=QjjZ7gzf4fBRbTr3T2gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: FLezrUhqCjfgVp9dTXHhc-aRIAYMw4-c
X-Proofpoint-GUID: FLezrUhqCjfgVp9dTXHhc-aRIAYMw4-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260149

Add device tree binding documentation for the Analog Devices
MAX30210 temperature sensor.

Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
---
 .../iio/temperature/adi,max30210.yaml         | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
new file mode 100644
index 000000000000..80aeae23e0a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2026 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/adi,max30210.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX30210 Low-Power I2C Digital Temperature Sensor
+
+maintainers:
+  - John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
+
+description: |
+  The MAX30210 operates from 1.7V to 2.0V supply voltage, and is a low-power,
+  high-accuracy digital temperature sensor with ±0.1°C accuracy from +20°C to
+  +50°C and ±0.15°C accuracy from -20°C to +85°C.
+  https://www.analog.com/media/en/technical-documentation/data-sheets/max30210.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,max30210
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: |
+      Analog Supply Voltage Input. Must have values in the interval (1.7V; 5.5V)
+      in order for the device to function correctly.
+
+  powerdown-gpios:
+    description: |
+      GPIO spec for CVT/PDB pin. Should be configured with GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  interrupts:
+    description: |
+      Connected to INT pin. Should be configured with type IRQ_TYPE_EDGE_BOTH.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - powerdown-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/pwm/pwm.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        status = "okay";
+
+        temperature-sensor@40 {
+            compatible = "adi,max30210";
+            reg = <0x40>;
+            vdd-supply = <&vdd>;
+            powerdown-gpios = <&gpio 12 GPIO_ACTIVE_LOW>;
+
+            interrupt-parent = <&gpio>;
+            interrupts = <17 IRQ_TYPE_EDGE_BOTH>;
+        };
+    };
+...
-- 
2.34.1

