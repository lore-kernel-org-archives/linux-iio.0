Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB4474267;
	Thu, 13 Aug 2026 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629479; cv=none; b=aEltXK7td74adRP4wQ7T2z66BO0VXw0N1uxG5UKUgw4BAlXuT66R0KWFieaNxjcuMfz7TbIfNrdDwv+wa0lTkXreE/GzD7UMR7rlT/SPk4NDesmfN1DPqsPloGKhDeVw0mdhxbrez73oq/sXLWnv4wpgkvUnOZULppiFt4kwMzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629479; c=relaxed/simple;
	bh=9dLWNekOW7HQhEmclDiDF6QjCSUcsR4qui0ysyPSuiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DA341yvSAAx5BkNxvVBvq4Wzh/+xWSuqDht0l9j93DYmxhRQcNx9ZgP/LAmArVcTSJztRWjJ1xPpaKK/c6bDZyJyhcL0M+t18Uq3TSJ79x+V87DpvYayCDiOlccM9JRwFCC99fgMyj1w5/PgGiRqywnWvEE0JAe1TrU+sKar0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Bs2monDH; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Bs2monDH"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCdCPo1876657;
	Thu, 13 Aug 2026 09:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TB9tO
	/z5NV0BOnA9GWvBJSKU6yk3k3e4I+lhO8xRQM0=; b=Bs2monDHA8lgmTUPN0f9o
	JqpcrNQNrAXT8DI4Iujf7Cz8mj13OFH7lgbz4GHakr6reXPdKuVKtm/uwjziuNK6
	DYHLEQr3wEWiuF7P6nHjFGRiWOgfWb4sFPIARLnYWS0GIC5wE+eSZ6o9rrUC4wJt
	d77RnFfDNX8qruJ4TJp7NazcANVIE+zwGGaI2wR0ODmhTKHaUBTi257mzywMIhp0
	E3/h6CC0wYRFvjmOPWtyALIZvgWkMFCB3c6PMO+G4f1wVmseb0JZGevgf/+eXR1G
	bc1XkCfuXlmFHelna7oQWuHc29lzG37KsT+L0iU3a3+yA2sbXjXfZ9b8bTMb1pN8
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e4b0daj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:57:46 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DDvjen024606
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 09:57:45 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 13 Aug
 2026 09:57:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 09:57:45 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DDvOwT006802;
	Thu, 13 Aug 2026 09:57:38 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:56:54 +0200
Subject: [PATCH v3 01/14] dt-bindings: iio: adc: Add AD7768
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260813-ad7768-driver-v3-1-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786629444; l=12321;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=9dLWNekOW7HQhEmclDiDF6QjCSUcsR4qui0ysyPSuiw=;
 b=aDrTF1+d4sZStr2H77v3kWRmvIDapkjOZ5FRz50jsC0V2M3VKe/PGGz8qC19iehXP+rpE6wlE
 RQh/PvkiZ6RBIdb+f1ypRRt8pQLzTiLBTdj/xmYpasqZ/CiRLe/Qong
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: G7vZWczCsQNL5Yu7sn_dz0lXysjgzPAD
X-Proofpoint-ORIG-GUID: G7vZWczCsQNL5Yu7sn_dz0lXysjgzPAD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX4QdsAgLbvDvf
 LmNWb81Y+GeREZaZy5F1V583G+w2vQdXafwSsZzmHSe2s/aV91JpdGOJMImSoENl5cld/SznX7j
 ytEm1IO3ij718FvBXVPc2wbLpVXsfSpXeTvAzvlHAJijjCAiOYNt
X-Authority-Analysis: v=2.4 cv=ZZYt8MVA c=1 sm=1 tr=0 ts=6a7dcd5a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=9KVYkBU6uCY3fGsyMq0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX3nZRhvDZDa7+
 sE/a3BLIVgBU7eXiHEMrPtFqeipfRhHIvak5tkLjUtVSU+1FcjpVR8qNHmGw8z8uy/jm28/cnr4
 xUyX2bSza03nQa7Rzo4Ye5umrLcxcMDnVtS/sWt0Yd7teecUfuX8e6ygrWbHMHhbU5oAzOYq0k1
 BKGkVqCnI8SA/i0c+QHovWL5kUMsU7IVeVGjtw8SabUi7sfn5Fz4FZFJNoc6hZ3qO+aj3WW19wG
 Iiqs5oP22uWvcRZ68hnRD0uR6ic8T0I6Nw8gGD1/S/Dbqf8YPMk4D9VAxYCuYlF2avzm95DkpBR
 9xoOFbgwtV0NM0qg/Nwez2m446a+Qwa/8DDEg/RJ9k1qa+0HkN2H2Q+9A3DQBVBp36uyen4AF9X
 bP/3i3peUjzRxg5zdmAkXpECRLZgJesGzf3ajuAcCwkTy3LSTaVD4J3xbJVMXu9pVehnmSbr7kp
 ctOkeXAxf47F9ohKK7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130099

Devicetree Bindings for AD7768-4 (4 channel) and AD7768 (8 channel)
simultaneous sampling ADCs.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7768.yaml    | 338 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 345 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
new file mode 100644
index 000000000000..54241436f47f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
@@ -0,0 +1,338 @@
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
+    additionalProperties: false
+
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

