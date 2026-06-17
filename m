Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A22DAFB0;
	Wed, 17 Jun 2026 02:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661817; cv=none; b=OebZbfBi0pFyEEU/u0A0qwPFi+BhpudD9x7vKwZg2jm+iXUAWOci4i7FkmPN4xaOZxnkmp+o2YJ/tHZl3Y8A+o6NXlNGXE1jOfEOoI5mgTr3/MP7qcohlflMzZ9SsYpjx359EQRugOr94/XmdrkOowdcRp1dlYqStkX9pS3whSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661817; c=relaxed/simple;
	bh=LAa5L1nzj9Lm4QkMoa22RXaQfalIsleKN9YqTFrP9h8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8nto5z5kpAX/7aH2k9jaTseZDxvoEAsP8EWEQDTT4vPaDHvOptwy30N4P7LAzsFsEQy3Bs7QV9h5G557ItPv//gx2jFzU4n/ZY8oU5MLVBsg4S1UBxD8yrqGg1SHekFwrLHpyKg1JZyOmL4QL3j6cQczNwmZL98sz7VVabFSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SgCigRJ0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SgCigRJ0"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLWpeM868794;
	Tue, 16 Jun 2026 22:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kD5gH
	DHrRDodEGmztmom1FySarI7uXEJeG+ZzztLC20=; b=SgCigRJ0ULM/OHElEg9KA
	UUiQZRke2P07PP12qdyQa7ZnCscP4MKt50P/QY5/OHzwPUv0V1zIrgmegpDcmS7G
	5WRRRhfg3ZTcS1cxzLwE9eNolIZ6/CjNu+vAYtbtaGz2u6PHIWVMac+/jcRr+Woh
	cu7lzmfw2g5NJAFAk3gv63EszyZACQUFR7Jmavj3qbxas3pPrMPi9MtP3bq/+Yxs
	nJ1sp3KFg0Mms2xqfelO00hT5FUAsEQNrTxKO2AFF2nsyatrblXNw0z72RGeo8XO
	8mExsYLqG7e0LSL0nOvkJZFGRYdHnjKgahNjMHBsIj17+H/Vo7oZCAjJJqL0FaV/
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4euegf0rky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 22:03:31 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 65H23UOm013966
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 16 Jun 2026 22:03:30 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 16 Jun 2026 22:03:30 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 16 Jun 2026 22:03:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 16 Jun 2026 22:03:30 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 65H23Hi4006709;
	Tue, 16 Jun 2026 22:03:19 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <pop.ioan-daniel@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 1/5] dt-bindings: iio: adc: Add ltc2378
Date: Tue, 16 Jun 2026 23:03:11 -0300
Message-ID: <f9e88abdbd23df8039282497a81d3c8698a10665.1781661028.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1781661028.git.marcelo.schmitt@analog.com>
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=SaHHsPRu c=1 sm=1 tr=0 ts=6a320073 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=Ke00WKluzF3GlLJr-2EA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: cZ7lm1xqEIEvt_4VLo_TSHJ_-O_Yya4g
X-Proofpoint-ORIG-GUID: cZ7lm1xqEIEvt_4VLo_TSHJ_-O_Yya4g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDAxNyBTYWx0ZWRfX4WK3ha1lDera
 o43jF0V3Nr9D1xypj9uuccL/kUcsXeFRFjksTMdNj+cPogpkowEwkAcMu2GEj0JiomoFYfnUsTN
 z0TuyaoQTowkJ8UtCcthQkP9/wLo/3N2KUenjBS85NOmEr6j24iPkcCf79KOx3tTD/Ijv8n9IzE
 U8EHHqQMqs+YDOy6CvIhSHOuqCItIGsHgnzUK2EXNzCT6A6aq4qacOClDbq2HfAntlbueMbPafM
 0Nt9f5AdJZhevSkkkG5UfjM7WcTepRsr4Pk8BrUkeEdH6cZuMvq36QbahfebVWLrCokWHe7rYMW
 9qrj6/OUSKrtpynwJd/7lgQrMtZmKDZeYQ0oRCsSsIKenJKJ8OWBh+f9bB4FlWxBBG1nYT7wFgI
 5FTw2gznQrAqA024efyRw5b3aT2QAxeLoYbGl2bSQEgEx2rK7jOyJy1pW5z0xkUgVTlOTaWkHcI
 R4pFxKUpSpeXaUYA9UA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDAxNyBTYWx0ZWRfXzpNmXeAYJ9md
 WZR7z2f6MNhsJ2hDR6ZE3umQilAjFjZyulhIdGzLDlzxHFsBvzAhgsyn2Zj6mRoxnwIBzHNxRTc
 d7VDDvUHtSDX/XJ1XMipy5C8AAfT1lMJBipWptLZ6is9Rqh7dXs8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170017

Document how to describe LTC2378-20 and similar ADCs in device tree.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3:
- Re-added device tree fallback compatibles for LTC2378 chips, now with options
  to provide a single compatible string or a pair of single compatible string
  plus a fallback string to a slower sample rate spec in case a driver for the
  specific part is not found.

 .../bindings/iio/adc/adi,ltc2378.yaml         | 160 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 167 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
new file mode 100644
index 000000000000..7d30a2cade8f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
@@ -0,0 +1,160 @@
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
+              - adi,ltc2338-18 # 1 MSPS
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
+      A 2.5V to 5.1V supply for the reference input (REF).
+
+  cnv-gpios:
+    description:
+      When provided, this property indicates the GPIO that is connected to the
+      CNV pin.
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
+  - ref-supply
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

