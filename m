Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880E33C4B79;
	Mon, 27 Jul 2026 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187861; cv=none; b=FwDLbJZFQLo0Bk1whtha93oXn7xl4fhyqxecDYBKv7hLSRVEA2wL7dZQuymxJydgdzVa8siiaX0OOtKIH0PtoshgqsgQjAlGrSU4LS5KRshBkvEC9B+g30tRQktsIkbIXlhUlJB3YjT2wTBttEyDAV+EBEkcdGXM6bjI2F6cNQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187861; c=relaxed/simple;
	bh=W24BQJnxaczwlKm4xnsQkNo18BZ6hkYvA/o95UVr9mc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWE6JwXNMIs2lXf0YaLRA7Hs30QF8TomxvE1LChadd25h9IqcPIsI+5TEPDUUvU2G4IQTSB/SYpRvHj0TTCyeY0UwLlK8n0+EuKHjSc8w8txqGSEFDQB7HGqLgeK0ijYSumy4CdMPjlys7Qz2ePwRjgRfwXg9QzdKsOmnWwIMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=a0zwan5b; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="a0zwan5b"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RIGSXA763132;
	Mon, 27 Jul 2026 17:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VZoj8
	NGqIzqeT3mpbzRSVihIpJ2tJtgnSKr9qP7Ucm4=; b=a0zwan5bj0M7bKDW6RIpu
	IIFVdTElMH0Xa9s1uag6jzeWWUa0h9lHfwhsJDHY4sG7Gcx/ffzD6vpRzSUKP80c
	9Z9aICwo+eHr5Evy9RjLgvEfI12HGgUufGVexX6C/51zTGKg3ouVmVH8G0DGCod3
	d8oz5qkrGKZGTHiLyn/uvSBE+TGAsxxeqMcUUXt9LAuOHZYF2zLegvXEVUZZYTQ/
	AKWUhf95HIpvyrevVhuZP/ELJopSbZW0dRCOmJpdGauUaTjA9IM9y1zgllXNq6Nq
	QZuqX3flU2K726NY2HdJJJmHbHmyZNsXlkf7lRPzYEqqIbbbH7crPGrATYTvmx3N
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fp5f7jbbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:30:54 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66RLUrcK003875
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jul 2026 17:30:53 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 27 Jul 2026 17:30:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 27 Jul 2026 17:30:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 27 Jul 2026 17:30:53 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66RLUeUa017455;
	Mon, 27 Jul 2026 17:30:42 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v9 1/6] dt-bindings: iio: adc: Add ltc2378
Date: Mon, 27 Jul 2026 18:30:35 -0300
Message-ID: <608b2b3eb9ca25fa743cbcf7b6102cdf60a4dd25.1785186980.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1785186980.git.marcelo.schmitt@analog.com>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: GppluG7TMYgC9dVjDz6D2lX4y0kt_lFE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE5MyBTYWx0ZWRfXxgxZj3q8m7ft
 SHPTRSedw6zwXE8uG+YD2sBaOG+5WG5Xz7+YWG5MY3TrDjjmUBfkrZzXKCo5jhyQztrIgTZVNy0
 1Luj3LA7xQyvX5zQIVRsadjxDyZkc3O4AMYNfFxsKhSzqAWQMGyELkBDL8HxUCEsnBO1hbVkTVR
 gVk4jrDKAYn8jYIvzEfp2Iz5S8vvMiN4T7SJRUdCOs6yMZiaJeERLuAhinDnCY1U7IYHE8Y4VtR
 gmwcZWbb+nLcwbPJ44vxCo2ZDFBOqDu2cSe+y14D3s0jyI0836F5qKy5Pyd5DzfefhlenN1Dh4r
 qs6A79CFNkx322eBZhRH3oQHAozBLE296JgIryMhGGr2koz51w3mqbGdbqm6cLAgmxsJh9W8s+8
 qm2qvqa24u9uDD08UsMt5BuXfjDKbwu7GFl42aJd6fyrwZs7QCIggNv7aL5aQp9moPpVnyHldW5
 zy3e1l7KNlfSmq9232Q==
X-Proofpoint-GUID: GppluG7TMYgC9dVjDz6D2lX4y0kt_lFE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE5MyBTYWx0ZWRfX1aKS9kvkq3fO
 U7wXIuC6DX09aHW0wl1JBNxen1EejNSUUAGug2y0TCgP6SUeNWuqNHEvwb4pblKx0R6BlgZVc5r
 ZcTmHw+NFuvei7Cwbq1kJ6nLaveCf4wvl+ZD7oPBwCY7oCl8jrFZ
X-Authority-Analysis: v=2.4 cv=dPSWXuZb c=1 sm=1 tr=0 ts=6a67ce0e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=zHdOwAC9n8DEQaShn0QA:9
 a=sptkURWiP4Gy88Gu7hUp:22 a=IawgGOuG5U0WyFbmm1f5:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270193

Document how to describe LTC2378-20 and similar ADCs in device tree.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v8 -> v9:
No changes in device tree doc.

 .../bindings/iio/adc/adi,ltc2378.yaml         | 170 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
new file mode 100644
index 000000000000..33de1dc4c256
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
@@ -0,0 +1,170 @@
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
+          - adi,ltc2376-16
+          - adi,ltc2376-18
+          - adi,ltc2376-20
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
index 2b1ec46c5919..f0ae26699c99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15343,6 +15343,13 @@ S:	Maintained
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

