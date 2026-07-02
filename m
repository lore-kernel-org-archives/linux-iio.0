Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBCC433E7E;
	Thu,  2 Jul 2026 21:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028734; cv=none; b=DwZF37usYK0pKAMTT0mKZR+nc2NDIvu2/q1cobhs/LJWQyM/pKvNeQY/tgSBK+IC8+tyBuUoctfL+8motMV7lQE0SPVlOvXmFPYaDV5T3VMS0Vswj9I68LUJtnVOhIT2afnWfQLw4QGNflUhupv/wy4gZ4/2KnQTIU7+3UogNEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028734; c=relaxed/simple;
	bh=qxHcAieACZSxTscqcSehN4bGW8sBYyWLQhPD1luPsdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOtyeXebQZZ9SEmLs6MSpeWKJulnUQw+NtR3iV2ZsQsl40AH0uDDkS7adXTlFuYVjDRQWg8KJw5DNEqlCeZe5r9sY6PtpS51jflif6Vn0VEVAHBr3qTBYlrsXcaI8/fDMvdmmS+B+ynv6j9qmM8hYWcWBgxNehNlYNKnK8Hod7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fJ6ZtTCG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fJ6ZtTCG"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662IrSRK3096240;
	Thu, 2 Jul 2026 17:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aFFrD
	g62EY6NoNVM0n2Wzy8OD6RxDFFoeR96wvW9t5U=; b=fJ6ZtTCGAlXTrvTftjt7z
	FsTszfRQUtnLw4gPWuKOMZd32SYQsbz4oRXbfvrcrsaxG6G+nxGROUjiEoVKnn/o
	T1QGANgL/PKAgs5c/qssRUlVWaiHuGL4z9VJGxlpZWhFwtE3X6pG71qyKgSKEemk
	/pqwXo0azevQtVeeKvtsR1vDvZZYBa1uLEsgCwsNdJ+CD6epI+ztisSx+EVoq2wV
	No3jrArEFd17l9IefmPqK8+DFMgTpXs3HOGeIPPzaK1r4vytjU9zPaXy6mwjex1U
	rQ1sGJPjD+QGZ+1lvWLYHD8qPHlMu4dFIynCuWnvl7pH5lk8wd/9b47gIPhuewDq
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4f5gd2cevu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 17:45:28 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 662LjRDa051759
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 Jul 2026 17:45:27 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 2 Jul 2026 17:45:27 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 2 Jul 2026 17:45:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 2 Jul 2026 17:45:27 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 662LjCtT007741;
	Thu, 2 Jul 2026 17:45:14 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/4] dt-bindings: iio: adc: Add ltc2378
Date: Thu, 2 Jul 2026 18:45:06 -0300
Message-ID: <fa15b8fe33541fa2e8c7a3f124b2482872fdcf26.1783028033.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1783028033.git.marcelo.schmitt@analog.com>
References: <cover.1783028033.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: nRMJje2Vfa2Mdw7YpA7apZ3hFRuQDD8U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDIyNyBTYWx0ZWRfXyyMsd1cVU/Mp
 sLtLoUPxy2w8wQFJp8ghh212LZw5bSihH0FiNNcQjcFjtwzJ9dWoUFifkNWpYeySmgrG6ubHq/Y
 qqnIaP/ZJxujecHIbj0ERw7acew0pdg0oWvCAR9Ad126x3Uqgl/XYF4ow47JZ+UxLQDc8Cb/lQ9
 12cPVi5YIO1mI3eHLWhx1NvoWmLcArKewvNYo3acyntHhFHX4Anpegugjn1ejY53QWmUZZVvEHO
 GVbNExswDHxbfkjhVP9KLD7iqLtIzbxio9Xdn02UmvUFa1Jy0JgKA/79xMG0t6+1kSsKbGUgV/G
 ssDZ9j1qLH1YwfU+QbCIaMYDb/iB9TA9CpLFNGL9ZvN9tXHKxxaQ31QCsp+5m70TcNtUk8I6DJ7
 i8h6zsOpKZDwg14m4+e6OVSDt+/FluAPdrcDI4aWfmDvKva0gP07uRzeMJy86lg34oOV6a/YNeM
 XvavWvBISSX0W9gtdoQ==
X-Authority-Analysis: v=2.4 cv=D7B37PRj c=1 sm=1 tr=0 ts=6a46dbf8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8
 a=VwQbUJbxAAAA:8 a=zHdOwAC9n8DEQaShn0QA:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: nRMJje2Vfa2Mdw7YpA7apZ3hFRuQDD8U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDIyNyBTYWx0ZWRfXyI1TB3hLpnqF
 jpVVcjXuBptb08CwykDPP3ibH+b+JKg6AmwnOMoVW1v41NwDMXrgKl90s9SjntN20DH9sbSGjmA
 XyAKh5k128mFEDGFdVG2oM8Qu1FnOh7jscCK1R3QSvBtungeA9E1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020227

Document how to describe LTC2378-20 and similar ADCs in device tree.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v4 -> v5:
- LTC2338 is slightly different from LTC2378 and, because of that, software
  can't really handle those the same way. No longer specify fallback for LTC2338.

 .../bindings/iio/adc/adi,ltc2378.yaml         | 184 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 191 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
new file mode 100644
index 000000000000..44ab4f1f7fa5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
@@ -0,0 +1,184 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ltc2378.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTC2378 and similar Analog to Digital Converters
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+
+description: |
+  Analog Devices LTC2378 series of ADCs.
+  Specifications can be found at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/233818fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236416fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236418f.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236716fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236718f.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236816f.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236818f.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/236918fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237016fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237616fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237618fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237620fb.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237716fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237718fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237720fb.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237816fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237818fa.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237820fb.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/237918fb.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/238016fb.pdf
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      # Single compatible string match.
+      - enum:
+          - adi,ltc2338-18
+          - adi,ltc2364-16
+          - adi,ltc2364-18
+          - adi,ltc2367-16
+          - adi,ltc2367-18
+          - adi,ltc2368-16
+          - adi,ltc2368-18
+          - adi,ltc2369-18
+          - adi,ltc2370-16
+          - adi,ltc2376-16
+          - adi,ltc2376-18
+          - adi,ltc2376-20
+          - adi,ltc2377-16
+          - adi,ltc2377-18
+          - adi,ltc2377-20
+          - adi,ltc2378-16
+          - adi,ltc2378-18
+          - adi,ltc2378-20
+          - adi,ltc2379-18
+          - adi,ltc2380-16
+
+      # Low sample rate fallback for 16-bit unipolar sensors.
+      - items:
+          - enum:
+              - adi,ltc2370-16 # 2 MSPS
+              - adi,ltc2368-16 # 1 MSPS
+              - adi,ltc2367-16 # 500 kSPS
+          - const: adi,ltc2364-16 # fallback (250 kSPS)
+
+      # Low sample rate fallback for 18-bit unipolar sensors.
+      - items:
+          - enum:
+              - adi,ltc2369-18 # 1.6 MSPS
+              - adi,ltc2368-18 # 1 MSPS
+              - adi,ltc2367-18 # 500 kSPS
+          - const: adi,ltc2364-18 # fallback (250 kSPS)
+
+      # Low sample rate fallback for 16-bit bipolar sensors.
+      - items:
+          - enum:
+              - adi,ltc2380-16 # 2 MSPS
+              - adi,ltc2378-16 # 1 MSPS
+              - adi,ltc2377-16 # 500 kSPS
+          - const: adi,ltc2376-16 # fallback (250 kSPS)
+
+      # Low sample rate fallback for 18-bit bipolar sensors.
+      - items:
+          - enum:
+              - adi,ltc2379-18 # 1.6 MSPS
+              - adi,ltc2378-18 # 1 MSPS
+              - adi,ltc2377-18 # 500 kSPS
+          - const: adi,ltc2376-18 # fallback (250 kSPS)
+
+      # Low sample rate fallback for 20-bit bipolar sensors.
+      - items:
+          - enum:
+              - adi,ltc2378-20 # 1 MSPS
+              - adi,ltc2377-20 # 500 kSPS
+          - const: adi,ltc2376-20 # fallback (250 kSPS)
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 100000000
+
+  vdd-supply:
+    description: A 2.5V supply that powers the chip (VDD).
+
+  ovdd-supply:
+    description:
+      A 1.71V to 5.25V supply that sets the logic level for digital interface.
+
+  ref-supply:
+    description:
+      Voltage reference input that determines the scale of ADC conversions.
+
+  refin-supply:
+    description:
+      Alternative voltage reference input.
+
+  cnv-gpios:
+    description:
+      When provided, this property indicates the GPIO that is connected to the
+      CNV pin.
+    maxItems: 1
+
+  pwms:
+    description: PWM signal connected to the CNV pin.
+    maxItems: 1
+
+  interrupts:
+    description:
+      Interrupt for signaling the completion of conversion results. The active
+      low signal provided on the BUSY pin asserts when ADC conversions finish.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - ovdd-supply
+
+allOf:
+  # Except for LTC2338, all designs require a voltage reference input
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - adi,ltc2338-18
+    then:
+      required:
+        - ref-supply
+      properties:
+        refin-supply: false
+    else:
+      properties:
+        ref-supply: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@0 {
+            compatible = "adi,ltc2378-20", "adi,ltc2376-20";
+            reg = <0>;
+            spi-max-frequency = <71000000>;
+            vdd-supply = <&supply_2_5V>;
+            ovdd-supply = <&supply_3_3V>;
+            ref-supply = <&supply_5V>;
+            cnv-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH>;
+            interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b051eccafa60..205acb4b0789 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15220,6 +15220,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
 F:	drivers/iio/dac/ltc1660.c
 
+LTC2378 IIO ADC DRIVER
+M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
+
 LTC2664 IIO DAC DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
 M:	Kim Seer Paller <kimseer.paller@analog.com>
-- 
2.53.0

