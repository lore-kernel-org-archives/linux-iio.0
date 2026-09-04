Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBFE4AE104;
	Fri,  4 Sep 2026 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531373; cv=none; b=phDxaHk5nqv9WJ4QD/HIdLZihxRxJ033ateXsD7o5ReM40wE7/WnVNJD4WdY2j2VwAT7sXha0RLHLyMj/rHo+l/QB2D6iHofvq8zsohWRjaaI2gsVkdASu8JbDZgh2seZH+/5a+4EctWs8qfVEcza1tpQjaHVhNI4lCLzDM/F3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531373; c=relaxed/simple;
	bh=NAx2svYyrcf/LNH5NrYC45khnXMpNPfX3LsQIv3GYyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lk9fzWbjb4mFegrh3Qp381p9Z02O9GNi2CDYvz6AbvMh7TtiMqg3fv9ACYaBxP/IRlr1HcFq9im0bggmJpdi1rQ3oTzENKZNIF8kMGO95r1X3o5BcQogy/zz/pI4ktfbXiwNsaIBtPBrmEVBAlBN8vYb0dRQLxkrR8rYUTAJjOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=H8Kbg1gb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="H8Kbg1gb"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Dhf7J553680;
	Fri, 4 Sep 2026 10:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pSiR6
	DOx8TIp1b6m6QH0kP8C8giSe1xUatDgLYR/xTc=; b=H8Kbg1gbF/dJENqMf9N5X
	HOvp4P4UyWYjf5SRGfceldyfLbERWS51aoGAN8SvvKieim0eN80OxsuZDn8Kiv2Q
	go4gLnFcQ9d2lNHy3yviTs9JWl+PhnzgkxHE8hEB5wRX2wToxniir5H++bQrvXql
	7DXdpWQw4ND77soH1CS70zF/2Y2sE2jgOMPDIxRLaDa2DdfVsloF0Mo/umd0pqEC
	Ws6bbM4+uItsBtqccK6GU7ybWXi/SWb4OHvQlsCyjR0M4s/aHdtvK/cFh+m8/9ot
	2ChivpxPI8LA8kirLLA/ymb+uZB3KKPK5XwPq2bzqoQjL2zByLbGY6XEPkzqDAmU
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gffk4vh70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:15:30 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 684EFTwe036071
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 10:15:29 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:15:29 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:15:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 10:15:29 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 684EF2d6026210;
	Fri, 4 Sep 2026 10:15:21 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 4 Sep 2026 16:14:54 +0200
Subject: [PATCH v6 02/17] dt-bindings: iio: adc: Add AD7768
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-ad7768-driver-v6-2-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
In-Reply-To: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788531302; l=9115;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=NAx2svYyrcf/LNH5NrYC45khnXMpNPfX3LsQIv3GYyc=;
 b=bKUKEMft8/3h2Q/Vl1BAQR0vGCCrdyrayKjxZtfr16fH0bGPk1DAgVQ5w+GtvLk85FbEwuf9+
 JOmKOuH9Cb7CJWLHSwJa06OvJddWKT4dl66utMpvyMAxNxCkO5ga6aZ
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX6Pi5II3rK7q5
 LQZOVfs8yE5fVoQpe3jjVkbpxNTwmbk7MM3NcQTApa+0DprDUDPTP6s7pgREDppeai+rFODWwqx
 RTFwsZRSxDkKdG8NxT7LMv7bpA0VkgP2sAQQXLiPgH11LM+zaP0jsLouaHVof6Fx2rDdyE/v4n8
 DnUrskGdyPGWcqsdltw0zBoRwyW9ItvlYQXOJQQBLYM2lVfYQjtI5CuNxW563/13k/5J3x94Igu
 iA6+SmHupHFi1urx1kQuLJzREuHNLFz+dKslPflNN/Wnel2Crrfmt5aQurj5CcjJsTo7iqUwmpT
 oIpjy8dEm0/9fQ25m9xNPlUvw3Q9/Ci8qSO67SzG6tZjeQ8WacTr9UpA1y/m0btFhd2kim4r1+c
 q9gp20EL+kpH56liPjs3G5/NYm/PNOMscNOqSA/uHDfQJXdyw0vCrzSTEDcjhJX4s0jbsrrPIg1
 H7YwPvCKih2ma9YjGGA==
X-Authority-Analysis: v=2.4 cv=QI1YgALL c=1 sm=1 tr=0 ts=6a9ad282 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=qd1CiYGdZHjR4DSY3K8A:9 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: Ky4uHcIaDnrTgZJDDMIn0AtKtacs5-O6
X-Proofpoint-ORIG-GUID: Ky4uHcIaDnrTgZJDDMIn0AtKtacs5-O6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX7t67/eyW2pky
 mZGSOqjQCo8vFVP1o184kVJMbTTSBWVfqC/uJySWeBP0JIt4NEYiaOmVvrp9DLfk1YB94z6vOjn
 4lGYIl3jKUu84+mMsSyVJYAWoGNbH+vCh0YMIP4Iw4YB4yJqcLuC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040130

Devicetree Bindings for AD7768-4 (4 channel) and AD7768 (8 channel)
simultaneous sampling ADCs.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7768.yaml    | 270 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 277 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
new file mode 100644
index 000000000000..d8e489fa1f6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
@@ -0,0 +1,270 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7768.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7768 and AD7768-4 ADC
+
+maintainers:
+  - Janani Sunil <janani.sunil@analog.com>
+
+description: |
+  The AD7768 is an 8-channel, 24-bit simultaneous sampling ADC with configurable
+  power and performance modes. The AD7768-4 is a 4-channel version.
+
+  This binding covers SPI mode only (register access via SPI). Pin control mode,
+  where configuration is set via hardware pins rather than SPI registers, is not
+  supported.
+
+  The io-backend represents the high-speed data output interface, consuming the
+  DOUTx data lines, DCLK (data clock), and DRDY (data ready) signals.
+
+  Datasheet at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-ad7768-4.pdf
+
+  HDL reference design:
+    https://github.com/analogdevicesinc/hdl/tree/main/projects/ad7768evb
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7768
+      - adi,ad7768-4
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description:
+      Describes the type of master clock (MCLK) attached to the XTAL1 and
+      XTAL2/MCLK pins. A CMOS clock is supplied on the XTAL2/MCLK pin, a
+      crystal oscillator is connected between the XTAL1 and XTAL2 pins, and an
+      LVDS differential clock is supplied on the XTAL1/XTAL2 pin pair. CMOS and
+      LVDS clocks must operate from 1.15 MHz to 34 MHz. Crystals must operate
+      from 8 MHz to 34 MHz.
+    enum:
+      - mclk
+      - xtal
+      - lvds
+
+  avdd1-supply:
+    description:
+      Analog supply. Its voltage is used to derive the supply-dependent VCM
+      output level, so it must be a regulator that can report its voltage.
+
+  avss-supply:
+    description:
+      Negative analog supply. If omitted, AVSS is assumed to be at system
+      ground.
+
+  avdd2-supply: true
+
+  iovdd-supply: true
+
+  ref1p-supply: true
+
+  ref1n-supply:
+    description:
+      Negative reference input supply for REF1. If omitted, REF1- is assumed
+      to be connected to ground.
+
+  ref2p-supply: true
+
+  ref2n-supply:
+    description:
+      Negative reference input supply for REF2. If omitted, REF2- is assumed
+      to be connected to ground.
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to the active-low RESET pin
+
+  start-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the START pin. An active-low pulse on this pin
+      synchronizes the device to other AD7768 devices. When not used, this
+      pin must be tied to a logic high level through a pull-up resistor.
+      When used, SYNC_OUT must be wired back to SYNC_IN on all devices in
+      the synchronization chain.
+
+  sync-in-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the SYNC_IN pin. Receives the synchronization pulse
+      generated on SYNC_OUT in response to a START pulse. Must be synchronous
+      to the MCLK clock domain. In multi-device or daisy-chained systems,
+      two successive synchronization pulses must be applied to guarantee all
+      ADCs are synchronized.
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+  adi,data-lines-number:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8]
+    description:
+      Number of DOUTx lines used for the high-speed data output interface
+      (distinct from the SPI control interface). AD7768 supports 1, 2, or 8
+      lines; AD7768-4 supports 1 or 4 lines. Defaults to the maximum number
+      of lines for the selected variant if omitted.
+
+  regulators:
+    type: object
+    description: Container for the on-chip VCM regulator.
+    additionalProperties: false
+
+    properties:
+      vcm-output:
+        type: object
+        description:
+          Buffered common-mode voltage output on the VCM pin. Use
+          regulator-always-on when no consumer node references this output.
+          Channel 0 must be present and enabled while VCM is used, since
+          putting channel 0 in standby disables the VCM output.
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+  io-backends:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel@[0-7]$":
+    type: object
+    description:
+      Represents the external channels which are connected to the device.
+      AD7768 supports channels 0-7, AD7768-4 supports channels 0-3.
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 7
+        description: The channel number
+
+      adi,prechargebuf-pos-enable:
+        type: boolean
+        description: Enable positive input precharge buffer
+
+      adi,prechargebuf-neg-enable:
+        type: boolean
+        description: Enable negative input precharge buffer
+
+      adi,refbuf-pos-enable:
+        type: boolean
+        description: Enable positive reference buffer
+
+      adi,refbuf-neg-enable:
+        type: boolean
+        description: Enable negative reference buffer
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - avdd1-supply
+  - avdd2-supply
+  - iovdd-supply
+  - ref1p-supply
+  - ref2p-supply
+  - io-backends
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad7768-4
+    then:
+      properties:
+        adi,data-lines-number:
+          enum: [1, 4]
+      patternProperties:
+        "^channel@[0-3]$":
+          properties:
+            reg:
+              maximum: 3
+        "^channel@[4-7]$": false
+    else:
+      properties:
+        adi,data-lines-number:
+          enum: [1, 2, 8]
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
+        adc@0 {
+            compatible = "adi,ad7768";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+
+            avdd1-supply = <&avdd1_regulator>;
+            avss-supply = <&avss_regulator>;
+            avdd2-supply = <&avdd2_regulator>;
+            iovdd-supply = <&iovdd_regulator>;
+            ref1p-supply = <&ref1p_regulator>;
+            ref1n-supply = <&ref1n_regulator>;
+            ref2p-supply = <&ref2p_regulator>;
+            ref2n-supply = <&ref2n_regulator>;
+            reset-gpios = <&gpio0 86 GPIO_ACTIVE_LOW>;
+
+            clocks = <&ad7768_mclk>;
+            clock-names = "mclk";
+
+            adi,data-lines-number = <8>;
+            gpio-controller;
+            #gpio-cells = <2>;
+
+            io-backends = <&iio_backend>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                adi,prechargebuf-pos-enable;
+                adi,refbuf-pos-enable;
+            };
+
+            channel@1 {
+                reg = <1>;
+                adi,prechargebuf-pos-enable;
+                adi,prechargebuf-neg-enable;
+                adi,refbuf-pos-enable;
+                adi,refbuf-neg-enable;
+            };
+
+            channel@7 {
+                reg = <7>;
+                adi,prechargebuf-pos-enable;
+                adi,refbuf-pos-enable;
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..f05e7f4d364a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1657,6 +1657,13 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
 F:	drivers/iio/adc/ad7768-1.c
 F:	include/dt-bindings/iio/adc/adi,ad7768-1.h
 
+ANALOG DEVICES INC AD7768 DRIVER
+M:	Janani Sunil <janani.sunil@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
+
 ANALOG DEVICES INC AD7780 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 M:	Renato Lui Geh <renatogeh@gmail.com>

-- 
2.43.0

