Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025C03624DB;
	Fri, 28 Aug 2026 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931073; cv=none; b=b/hiPQtstiDPSXkMYuK0J9xbujIz0SLwTsHXp+dpP/2ifEWlWAL1j3o5WMTIXtxK3VcEeeoaSDVI8FfLYk9u6Krg9JhSe+ZlISK1UggdBLQN4ksuGkwY2HaV2LwNolsaWq1WrBtOXlrrBR9d5rSR7f3cxbPdv0YRuBz43sxgL4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931073; c=relaxed/simple;
	bh=IYxqWqcIKBD/4/W2zWMkvdA/5Lw57wyr4J7+mxhr5aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=D/khpOseW8U+jslAUF+5ifNCCj9LSP9njS5LJhZzlffRID5CQ3+Kt5/lKiAbe/CrWXtyRm2cXOaS9dAcBNkkhqfdtIgKZVZ10/dF7sQ3G1Gc2vldOqC310bvX9UnXhNpewi/uj9Id+r2fMTiHEwX76ojmMScNasUp5j93DauTNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=S/90ueva; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="S/90ueva"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDVeiO1142216;
	Fri, 28 Aug 2026 11:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=EnxYG
	+XsohKyk238KA4Fjcn6QhIu6UmOnt91Az2XIXA=; b=S/90uevaTdCiblV3uy0/o
	bboTW9NgyIVakxadyqq072u17fHhoS1Uzq/MYyBBWs6XQvwohrw+PNEr+weTteYJ
	9tX6axszY5q01X8SHribA3v4KaKXspxWhqZcvmVAaSkdhYYIlXB8D5HaClsaFgcV
	ZjdvFJIOXAI4sbX3Hzy04pmS+8iQa3d4d2FSxYbUYLZ5EDOPiluTHpbMS9I2r0Gi
	GFxy2y0cxBdkxY1JT3VZ02K59O7P3Tk5bEx5oCDXaqXZXSQcHL7/uiZGU9dpPs1r
	Uze9lqwppsipOTzIq3IkkDvbXCjyYJvuFPRXVsN0A7hdgH4TE7lLvXLcouBodjjD
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gaj3cqj4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:02 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFV1EQ012890
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 28 Aug
 2026 11:31:00 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:00 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3h031424;
	Fri, 28 Aug 2026 11:30:54 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:25 +0200
Subject: [PATCH v5 02/20] dt-bindings: iio: adc: Add AD7768
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-2-e33ca6f841a2@analog.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=9115;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=IYxqWqcIKBD/4/W2zWMkvdA/5Lw57wyr4J7+mxhr5aA=;
 b=MRVZ3hMG5VMyKB9Oq8tOvFoYuLlFumiN15IKVKcpm/R9bLDY34HcFx2lsqxGBDbHFnOWD0mYF
 BGqpUTNNJyVCjSyhNoNDMhDSKxpv5pC+Beoq+dn0bydEDKivlOHnaAt
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: J908MJYqlY1YOHHO9y1sde-iq3tZk31J
X-Authority-Analysis: v=2.4 cv=erHvCIpX c=1 sm=1 tr=0 ts=6a91a9b6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=qd1CiYGdZHjR4DSY3K8A:9 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: J908MJYqlY1YOHHO9y1sde-iq3tZk31J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX5NNFjGLYmvqN
 V2BqAZdNziqKpPAO4z9GGadu24pJE5REe4T16WjIESNVo7gbyZ/pTo62gtR/fK/nQsO5gw4lf0R
 BBdZKD0Bh93p/Zhl/nQPFrgnMAGpR/ODVO+KvWrIK1uqN6Tju0utfmaZKYuWnmmFX3Cot+jmFy2
 2ZE0vwSDISPo2Zm0yA29X5kBaV4Vy0fE2iXaer9zbMDDOOEvJzmEZ4NOUX6LMY1X6l8S/YSg+jT
 Ow+9XgtYf43q92/3Hj0GEDmyhxmmkkz3hfIWJagUrqDdH+8t61HTbGExKEHB+0PUWhSZMoZTsSc
 jLU1/880W3b3frbPpZ04ptzjErNaTEB1P/vVaKRKtRikTaRu9aBrVN6MbyY382Ufi7yqlwc8jbP
 55xezFDAlKqRznC9nhHn7nkjbADvusW9GoMQRARNce+Sked284GuWMCbT7mJxS3fnqwz4BUoiwJ
 h8BVeO7jgFVTWgXc/HQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX5uXw4/UFZ2gR
 PDZYl6YD+mo8JTdc1lj7UgEFxlPgEIwmjeLgf7TsZV4NYZ9j/oqOyyreJibxlB35nJcK4NeZ/Ij
 6MysPiUX0c+MhQe3YMh85dbFF+ejxuUchIOem4mw/THl9g/BHDJj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

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

