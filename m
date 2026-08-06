Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192C847D95F;
	Thu,  6 Aug 2026 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030948; cv=none; b=iV3xpZeRvHDSZVGWbg0ZTyBQNLLJuA17YIb3N1H0jR8dMznQJqDo+b5UMSfOWZQBXMoR7kmOfMTXkqZUsYN5ED4wrR9kAVDR6ZVuZ/tAOVU2Dvs8PQRDM7uylfGvckNLYmonhHK5R/m2+dtF5ABctQeXHPbj6+lu1RS7/hzNUa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030948; c=relaxed/simple;
	bh=smRaehSFZ/4fAcMgD1DrTYoviIxwo9Mv3/WwxO4Gbog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XwS89R1ac4XBu9CaolV7aI3Nnq13jAvDi4rI9ByfM/d0XyeA/hXBJxd6WDBOM9J+nLeNQz4e6MM6TX3AJSO7a8wlmeAsaMpr3fvCxH+4+rnmE1x5kSd6XXallyRyHhg6Ti3Fvi3ot0FOqAygL9WKSEBnREP2DUznC0EVIeFe+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=j/QgglpM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="j/QgglpM"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676EqFrO4057001;
	Thu, 6 Aug 2026 11:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kDWgm
	lFmKShVLusXyeZTl3IeuXVQ0ufd5NvZsBKoDGQ=; b=j/QgglpMZJJiZHj7kAblT
	ebABBwKFtkpkB0BR4Te4Vi3YR10Jbv28T+++BrCMd4r1q+a12EWSvi0MbFvBbai8
	OZEeqdgoK0lghvhn+0zlGi5b9Oo+EVj3lH7uZcHtnNabqNdVhLpCEBs8wK2cOqkT
	2XQwNfRxYawIkoBAu+xgyGfDfcG5577j724n3/ZH3m0OjVtxFKExe7EuBD5jAj+2
	gBlqKUavxW4e2mM6VZTJuxbNIDjqhjiQgFHeSpzs5VCFJVM/MvJ4lVU46l6kmb9k
	MvAEBUyfB728hX38o90LQubdCqUMCrtFjACxzKvEq8z5U5TgWU7qcQwLtXU1usoF
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fvp4ttnny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 11:42:06 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 676Fg5Mm007029
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Aug 2026 11:42:05 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 6 Aug 2026 11:42:04 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 6 Aug 2026 11:42:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 6 Aug 2026 11:42:04 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 676FfcgY008127;
	Thu, 6 Aug 2026 11:41:57 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 6 Aug 2026 17:41:20 +0200
Subject: [PATCH v2 1/7] dt-bindings: iio: adc: Add AD7768
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260806-ad7768-driver-v2-1-027ac5e2a641@analog.com>
References: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
In-Reply-To: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
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
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786030898; l=12423;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=smRaehSFZ/4fAcMgD1DrTYoviIxwo9Mv3/WwxO4Gbog=;
 b=RWgm+PKOSptCThI+f8DMvKMzdWWOi7fOZHENHQDn3nz7oydGRgRLks7bXoKAFvGfEKlqITxju
 z4i+cOZJtzWBRimOQ51F8yMW1hUvwV5X4EEHKciMOS4VB4otGOaQVzB
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: x2OwXJTYSC8P4CFd0cgaxpWZWq4iHS0K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMSBTYWx0ZWRfX3Od0tQmTB0Lq
 qnO5b1hqAxot2UgWM9cAr6AGpuPdT9tBXEzSxSZdzdmn3REeahjQeXsBwVUmeC+mF0w+XYBa7As
 BntAaUkWAt1387dhWWWn4xGVJctzF1XiMMc4lSitnrX2QfSI5IhrdevIPCJKzXz/WCYdWAtMStG
 v4PjV++URS6N+myEsLWglpeUY2hq+4P8zvuqx5Opucc/BvI9PqNCWsknjkMVRqV3MtSuku7JTIb
 H9Mzy9sFaaj/+N/TPg2hboMWUqWsLqCH9aW0G8MvYjRL4JeXyWGXSA8BfPMsPvVS600pE5aUTde
 eTXq2R9bosMDnp/vXbzqxOHGW9kqdIFBqvtjBM/B/77QGBu1KxccOk5thT0n2LE6pNi7Pn7t8lK
 fMDCd2FXCTGnTpsU/mVBnGywVy3sW8m/xdRU6TJO8WCd3AXl2+PK4hgjZeN13Qkh1l6ReF9cdzN
 rK1+obbmCiro/Vbd7ag==
X-Authority-Analysis: v=2.4 cv=CIYamxrD c=1 sm=1 tr=0 ts=6a74ab4e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=-5bBmU6Px0lr29W57isA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: x2OwXJTYSC8P4CFd0cgaxpWZWq4iHS0K
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMSBTYWx0ZWRfX3Cz4YeKFJ11Q
 mK2Mk1yX1xKjhxujq2mVKyQxWzPxca1ev3xtg20nD96wsjzUiKslxTmfLjXUVHkVBvBeYwQCHXH
 +oZ26fUo7zWsaF8Jvx2XaB5f/Q/lCptXRnXaAD3Dpd909jM+kWtC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060121

Devicetree Bindings for AD7768-4 (4 channel) and AD7768 (8 channel)
simultaneous sampling ADCs.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7768.yaml    | 343 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 350 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
new file mode 100644
index 000000000000..8688b94c1ec0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
@@ -0,0 +1,343 @@
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
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768.pdf
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
+    description:
+      Master clock (MCLK). Can be supplied as a CMOS clock on the XTAL2/MCLK
+      pin, a crystal oscillator connected between the XTAL1 and XTAL2 pins, or
+      an LVDS differential clock on the XTAL1/XTAL2 pin pair. The clock source
+      is selected by the CLK_SEL hardware pin.
+
+  avdd1-supply:
+    description:
+      Analog supply voltage for the AVDD1A and AVDD1B pins (5V ± 10% with
+      respect to AVSS). Powers the analog front end, reference input, and
+      common-mode output circuitry. Both pins must be tied to the same
+      potential.
+
+  avss-supply:
+    description:
+      Negative analog supply rail for the AVSS1A, AVSS1B, AVSS2A, AVSS2B,
+      and AVSS pins. This rail is referenced to DGND and all AVSS pins must
+      be tied to the same potential. In single-supply operation AVSS is
+      nominally 0V; in split-supply operation it can range from 0V to
+      -2.75V with respect to DGND.
+
+  avdd2-supply:
+    description:
+      Analog supply voltage for the AVDD2A and AVDD2B pins (2V to 5.5V with
+      respect to AVSS). Connects to internal 1.8V analog LDO regulators that
+      power the ADC core. Both pins must be tied to the same potential.
+
+  iovdd-supply:
+    description:
+      Digital supply voltage IOVDD (2.25V to 3.6V with respect to DGND).
+      Sets the logic levels for all interface pins and powers the digital
+      processing core via an internal LDO. For 1.8V operation (1.72V to
+      1.88V), IOVDD must be tied to the DREGCAP pin.
+
+  ref1-supply:
+    description:
+      Differential reference voltage supply for the REF1+/REF1- input pair.
+      REF1+ voltage range is from (AVSS + 1V) to AVDD1; REF1- voltage range
+      is from AVSS to (AVDD1 - 1V). The differential reference voltage range
+      is 1V to |AVDD1 - AVSS|. On the AD7768 this reference is used for
+      channels 0 to 3; on the AD7768-4 for channels 0 and 1.
+
+  ref2-supply:
+    description:
+      Differential reference voltage supply for the REF2+/REF2- input pair.
+      REF2+ voltage range is from (AVSS + 1V) to AVDD1; REF2- voltage range
+      is from AVSS to (AVDD1 - 1V). The differential reference voltage range
+      is 1V to |AVDD1 - AVSS|. On the AD7768 this reference is used for
+      channels 4 to 7; on the AD7768-4 for channels 2 and 3.
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
+  sync-out-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the SYNC_OUT pin. Outputs a synchronization pulse
+      synchronous to MCLK in response to a START pulse or SPI_SYNC command.
+      In single-device configurations this pin must be wired back to SYNC_IN.
+      In multi-device configurations it can be routed to the SYNC_IN pins of
+      all devices in the chain.
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
+    properties:
+      vcm-output:
+        type: object
+        description:
+          The VCM pin provides a buffered common-mode voltage output used to
+          bias the analog inputs. It supports three fixed output levels of
+          1650000 uV, 2500000 uV, and 2140000 uV, as well as a
+          supply-dependent (AVDD1 - AVSS) / 2 output derived from
+          avdd1-supply. Select the voltage by setting regulator-min-microvolt
+          and regulator-max-microvolt to the same value. Use
+          regulator-always-on when no DT consumer node references the VCM
+          output. The VCM circuitry is associated with channel 0. When VCM is
+          used externally, channel@0 must be present and kept enabled because
+          placing channel 0 in standby disables the VCM output.
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+    additionalProperties: false
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
+    description: |
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
+  - avdd1-supply
+  - avss-supply
+  - avdd2-supply
+  - iovdd-supply
+  - ref1-supply
+  - ref2-supply
+  - io-backends
+
+dependencies:
+  gpio-controller:
+    - '#gpio-cells'
+  '#gpio-cells':
+    - gpio-controller
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
+            ref1-supply = <&ref1_regulator>;
+            ref2-supply = <&ref2_regulator>;
+            reset-gpios = <&gpio0 86 GPIO_ACTIVE_LOW>;
+
+            clocks = <&ad7768_mclk>;
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
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@1 {
+            compatible = "adi,ad7768-4";
+            reg = <1>;
+            spi-max-frequency = <1000000>;
+
+            avdd1-supply = <&avdd1_regulator>;
+            avss-supply = <&avss_regulator>;
+            avdd2-supply = <&avdd2_regulator>;
+            iovdd-supply = <&iovdd_regulator>;
+            ref1-supply = <&ref1_regulator>;
+            ref2-supply = <&ref2_regulator>;
+
+            clocks = <&ad7768_mclk>;
+
+            adi,data-lines-number = <4>;
+
+            io-backends = <&iio_backend>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            regulators {
+                vcm-output {
+                    regulator-name = "vcm-output";
+                    regulator-min-microvolt = <2140000>;
+                    regulator-max-microvolt = <2140000>;
+                    regulator-always-on;
+                };
+            };
+
+            channel@0 {
+                reg = <0>;
+                adi,prechargebuf-pos-enable;
+                adi,refbuf-pos-enable;
+            };
+
+            channel@3 {
+                reg = <3>;
+                adi,prechargebuf-pos-enable;
+                adi,refbuf-pos-enable;
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2b1ec46c5919..d667a0411f28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1633,6 +1633,13 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
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

