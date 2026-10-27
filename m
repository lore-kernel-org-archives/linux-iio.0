Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108690;
	b=abEsj9g0YiU/X9Ol2K6THiMFvy/uDChbwkldJKRNOxjezTzia/LD46omcBwDIGq3MTeU
	 9NO4OlL/KqtMveeJf/6yyMSLgfQ14jtKxTx2i26to7QuZzq2kBT1+kIuhIN0+2jc2dJDN
	 LJt+PLkA4m6oGSWJVYHX5IMy0632rd2gIedS/HtlITjr8tIzUr+MPF4vlx+4n+MEYkccm
	 5jcBGfJQ5uxCXm/U4olb13vSFIfxJ5rZ6GuJq1RsyE2RcuV6RxBjGk2Mh0QRgwICg6Rlz
	 L1CkmrLhOn8JuC1HxIy2uM9PfrRSm2+NEJj8HYPxHcpvhlgQCsDh7g7Uu+cf5TJ+aVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108690;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7iG2dAXaCmn3nofuG3SiIR/ELKN4rErCeOd4ojR6DRc=;
	b=3K4ha+oaO28ALz12LMQCw1Zb70ekVRaq6nd78XskjRbJJ9jsSSkhCN967oYOInGc6V+0
	 oRQVO0g7/FrpO+GdkqXKixwM9aQZmbFKNHRvM9iUgmCt7nfdmoCa82oDxSMekQHs0kHJd
	 u7yFvM0e6OBTFZay8bKyxnssUAgPo8SBTpyG+3ZoaexQr2a0yWvs54HGWqlju850Fx/Kg
	 EMo7TSGTphmp9555K/ZAdA+n+ModXSVINl15XHWyAKiG+ose8YIyRgMlJ97xnD1t8JfJF
	 V4EKPvC503UCe1zpN6FDrBGeb04XvcSGtwCs6MtQOCdsOUzcMLz5lX9rCnyMK/Oqv4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=VHVTTKQv;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=0sU8x4p8;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DEF606A32F;
	Tue, 27 Oct 2026 13:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1DEF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=VHVTTKQv;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=0sU8x4p8
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RBinTj3119842;
	Tue, 27 Oct 2026 09:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=7iG2dAXaCmn3nofuG3SiIR/ELKN4rErCeOd4ojR6DRc=; b=VHVTTKQ
	vmMrTSenr0qnwCw042wIrzvAWQ1r2odxvqKACw58RXZ68g2EMp6oyTug9sqf5UwZ
	IThtQynAG84G+oEEx49BWWtY0ikcR2uYohx1NaA6qlF27bBMnP7DRbWjoQmNPz5P
	DAWhVJjMi162wedSrPbW0BVnQWjRhHo9xNhX5zXF+8W3nSDFnjxL01gk9+e9VKwm
	zJTpwvczkWiOJtnogynJTauDdM1QXgg0SO5NQsj0hBsTLKN1Gd5CIc5THIx8btrz
	KrkOjdf80LLu4O6EJW70IWEPgBg5Lb4b39YcZjecOD2uatTZxTzincSdIRjHaWTb
	jSS9utTaUyJZI2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7iG2d
	AXaCmn3nofuG3SiIR/ELKN4rErCeOd4ojR6DRc=; b=0sU8x4p84nFIaZO0SsEC/
	W+ZSvBbtNvdLA8uVJRzr3d7r4tDvy2szGOn41sCqeSoZfb//uVPa1b78VLxJEdvg
	sAgHBCuig3m6g5U9e/PUkgOmdeP0iHJtizvdp5gNERHzKOE2PRBBKeqQFWp7k2LC
	AH3F9+u91tQGE/ibXUOXTBwcWrTd7+nII81Pu4J9yJKLOQ6l5qmhvyYUbOk8aWWc
	fnMtQZt+c5jb4mvtFHd4yOcX4rJXSfPxGL4dTx1615iJRxiAt5JkxZacaz6yA22E
	q08Zed6UmFG2E6zwbFAbP3TpUbUNf6+xNNbo3xSdZ9vKl/beICODLajo8t6nufdo
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hjjct3m1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 09:44:41 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69RDieLH039580
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Oct 2026 09:44:40 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 27 Oct
 2026 09:44:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 27 Oct 2026 09:44:39 -0400
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69RDiPUP014649;
	Tue, 27 Oct 2026 09:44:33 -0400
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>,
        Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: adc: add lltc,ltc2387
Date: Tue, 27 Oct 2026 15:44:08 +0200
Message-ID: <20261027134409.76824-2-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027134409.76824-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261027134409.76824-1-Nicolae-daniel.Deaconescu@analog.com>
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
X-Proofpoint-ORIG-GUID: MTSh9iOnxiIK04auZ3ppzhXVjlrcWfu-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX40ud7bwVItcb
 qWhSvE9iLcBRwWvzAXWqAlvDnztme9ctdLXixgZP4B9vppzOrED1fpLNlqfB5p20k5+GC2vQCQt
 TdQHeaCR7lTRZGhqut2TnLMbkwLWxFjj5ovC2n2lwUIQuuh7R5tz7Op1JcpCCANuV5XEvcn0fVa
 BUxsjf8GgbWUFTuwxvMEvvWgkXvLitr75Jx1SKX9v6KciWPfyW7zEWm4Sm/ph7X8F6aZkA12rF5
 3ZotqK21lj/KZMC2dQVbsu3+Q7yrZAlgg5zdc+znYCOakWQfWPV/pjr4JhKuBcXPpLfaoWs1jQH
 CSH/pkB/+EvLyTEeakGcRrS2rlRDpeHUee4wJ62ClgIyLS+et7iRsfE9xG4ODCBz5r6/ktK1bEW
 0ritYzOyO1j9pEYAKRxbKc/GS1rlrT5QFRQ2q0vwJd/+ZyS8JfaFlp1Xck8qoquxDOZqlvrC9ZY
 NOu9GeeGYYfuLJfg5Pg==
X-Proofpoint-GUID: MTSh9iOnxiIK04auZ3ppzhXVjlrcWfu-
X-Authority-Analysis: v=2.4 cv=HtPjiETS c=1 sm=1 tr=0 ts=6ae0aac9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=1yO_MxKN9ett4E4Me8EA:9 a=sptkURWiP4Gy88Gu7hUp:22 a=BmoiQ_kLkyt6usnitrTQ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX7HQ0m9wxcR2H
 ICrXBjjjN8vgnUgBSJVot5plarzLWyPrtGPgzWG4z4jnV/6G6b6jGZ23I2iCYo8cP5NB29VldPa
 CeCcnbi9gBxov7yoeW7dHTZzea2DhJfg4vxgGGTpeR2dO04j6Itu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270054

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Add bindings for the LTC2387-16 and LTC2387-18, 15 Msps SAR ADCs with
an LVDS data interface, and for the ADAQ23875, ADAQ23876 and ADAQ23878
uModule ADCs, which pair an LTC2387 die with a fully differential
amplifier front end.

Conversion start (CNV) and the gated LVDS clock are driven by two PWM
channels. Sample data is captured by an AXI ADC IP core, referenced
through io-backends. adi,use-two-lanes selects two-lane output, and
adi,gain-milli gives the front-end gain: fixed at 2 on the ADAQ23875,
set by pin strapping on the ADAQ23876 and ADAQ23878.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Assisted-by: Claude:claude-opus-5-5
---
 .../bindings/iio/adc/lltc,ltc2387.yaml        | 138 ++++++++++++++++++
 MAINTAINERS                                   |   8 +
 2 files changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml
new file mode 100644
index 000000000000..f912260c8f79
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2022 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/lltc,ltc2387.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linear Technology / Analog Devices LTC2387 ADC
+
+maintainers:
+  - Sergiu Cuciurean <sergiu.cuciurean@analog.com>
+  - Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
+
+description: |
+  The LTC2387-18 is a low noise, high speed, 18-bit 15Msps
+  successive approximation register (SAR) ADC ideally
+  suited for a wide range of applications.
+
+  https://www.analog.com/media/en/technical-documentation/data-sheets/238718fa.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/238716f.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adaq23875
+      - adi,adaq23876
+      - adi,adaq23878
+      - lltc,ltc2387-16
+      - lltc,ltc2387-16-x4
+      - lltc,ltc2387-18
+      - lltc,ltc2387-18-x4
+
+  clocks:
+    description: Sampling clock
+    maxItems: 1
+
+  pwms:
+    maxItems: 2
+    description:
+      PWM signals used to synchronize the sampling procedure
+
+  pwm-names:
+    items:
+      - const: cnv
+      - const: clk_gate
+
+  io-backends:
+    description:
+      The AXI ADC IP block (axi_ltc2387) that captures the LVDS data stream.
+    maxItems: 1
+
+  vref-supply:
+    description:
+      External voltage reference. When absent the device's internal 4.096 V
+      reference is assumed.
+
+  adi,use-two-lanes:
+    description: The device uses two lanes for data transfer
+    type: boolean
+
+  adi,gain-milli:
+    description:
+      Gain of the fully-differential amplifier that the ADAQ2387x modules
+      integrate ahead of the LTC2387 die, expressed as gain * 1000. It is
+      fixed on the ADAQ23875 and set by pin strapping on the ADAQ23876 and
+      ADAQ23878, so it must match the board. The bare ltc2387-* parts have
+      no amplifier.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [370, 730, 870, 1380, 2000, 2250]
+
+required:
+  - compatible
+  - clocks
+  - io-backends
+  - pwms
+  - pwm-names
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - lltc,ltc2387-16
+              - lltc,ltc2387-16-x4
+              - lltc,ltc2387-18
+              - lltc,ltc2387-18-x4
+    then:
+      properties:
+        adi,gain-milli: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,adaq23875
+    then:
+      properties:
+        adi,gain-milli:
+          const: 2000
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adaq23876
+              - adi,adaq23878
+    then:
+      properties:
+        adi,gain-milli:
+          enum: [370, 730, 870, 1380, 2250]
+      required:
+        - adi,gain-milli
+
+additionalProperties: false
+
+examples:
+  - |
+    adc {
+            compatible = "lltc,ltc2387-16";
+            clocks = <&clk 0>;
+            io-backends = <&axi_adc>;
+            pwms = <&pwm 0 0>, <&pwm 1 0>;
+            pwm-names = "cnv", "clk_gate";
+            vref-supply = <&vref>;
+    };
+  - |
+    adc {
+            compatible = "adi,adaq23878";
+            clocks = <&clk 0>;
+            io-backends = <&axi_adc>;
+            pwms = <&pwm 0 0>, <&pwm 1 0>;
+            pwm-names = "cnv", "clk_gate";
+            vref-supply = <&vref>;
+            adi,use-two-lanes;
+            adi,gain-milli = <870>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 52024397dc78..b871d7f25d76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15529,6 +15529,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
 F:	drivers/iio/adc/ltc2378.c
 
+LTC2387 IIO ADC DRIVER
+M:	Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
+M:	Sergiu Cuciurean <sergiu.cuciurean@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml
+
 LTC2664 IIO DAC DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 M:	Kim Seer Paller <kimseer.paller@analog.com>
-- 
2.34.1

