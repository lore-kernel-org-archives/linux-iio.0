Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C65E2E738A;
	Thu, 28 May 2026 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980627; cv=none; b=fAYXW3VZ9ji2YzdnPInxKvtxqZVW/to2caPI2G1SlBvAh8Z3yvBu1uOvbG51GWNWuWijbUAG4LThaShajMbOQo+42bGPoL2sQPJJ+h1CKd0m29Sd55xPPrmtF/hf7LzOOTrONHbcWMN1yfGdhGQWO747J9X0BNn25JIg7awpPnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980627; c=relaxed/simple;
	bh=Dl8GAxFksQ+N3e4F3L7aJSBPGBi6YY87F8ySbb2Y3Fw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjB0LNo9/vYrnnZgun4NUpTrM+PzQHPzo6MfBIMcrJLo8IBOiZtCHCqgWWzVzaeVnOsFLf1tvD0GPYlamK7JZjdaQ2zg7DYmTmGRiP7yF3pIv5mGfDWUhKqHBowxDOQ1Qi8k6CQowSZUn17tJN3RAZ30D/TVp3i+UZn7ZadAL3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zKsRKYTM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zKsRKYTM"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SEeRs8400759;
	Thu, 28 May 2026 11:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KsELe
	zxbkRYI/DMIPccH+ZQfH9BQpq9CtGDcg0u3g0g=; b=zKsRKYTMtUPfCL4zroWug
	BXytA2YmC0Z6J2W5A3w7Q8hMF+XLrpP4pZ/VgmHfzEjySu2WO3EbrfoEo4h1DPpV
	qwqJ3QyDRflLEEJpSwjKGEt+iTRmWCBMOpdhFVMSZCSdT4DrrU1AoFo9jjNRt1Zi
	p0+L4DSbGfT2rok91F3aLm7TEVgKF64D5rBxMhjtyT08yomAwEiZzp0qA7rcPHFU
	Yu0KMNQSYoeiJVX8ZWDpFXAB/g8W+FXXb+YFu+arG59gXmDwq6znIkVo/0RVhESa
	HbKfJ/hE64xbWHGzq1Xy5fsoThDRJgFdvfrtQA/TcN5h1vpef8d8qxlxv0ZkSaPC
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ee7x1uabf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:03:35 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64SF3YjU008714
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 May 2026 11:03:34 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 28 May 2026 11:03:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 28 May 2026 11:03:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 28 May 2026 11:03:34 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64SF3LFm021386;
	Thu, 28 May 2026 11:03:24 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <pop.ioan-daniel@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: iio: adc: Add ltc2378
Date: Thu, 28 May 2026 12:03:16 -0300
Message-ID: <23971c3bb56d8635abe9cd36fd245412f672772a.1779976379.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1779976379.git.marcelo.schmitt@analog.com>
References: <cover.1779976379.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1MiBTYWx0ZWRfX4CZsuG5TMQok
 rv+kpPdyyVDaMupb2j7z78l8cVoFfEzBZiG1/4THyR0biycxwRE0rMEgQFE6+ysgovgZBn5sxM+
 YP/O5SDnMs4BcH90GdMvHRcGmPIZ8DeidsLNd8COriwRngo1yeMG+ApULvWWwYCcUv4sNqpcYOa
 mwaMz8se9Ajm0/46lsNQApaK/tEWKynR9wZkTaf+K8wAr7cdE15UjzUZFUKldpUT2JRxL4HYkXO
 L1cjcfdtK1MGJpuI4DqMdnDdJAOjgsaomuX9j3EUsMG/mXLz+33H5Y7/js/8Et+i+t0INV6H6pb
 x9kQ29t+p+ewTZeozaK70iGTvDfSgj4fCxPqtrFa3Csk52QqLfJzFm4I1ZGz9yPMisPHaU5BsxQ
 8O0ALF+bVz4YmLJbC6cxFw73exmwIysHlz0+j8kayrmDmB+A8OlP754DsXSjHL8aLf59QwENDjJ
 rhxtysabW/hCVWzovPw==
X-Authority-Analysis: v=2.4 cv=HMbz0Itv c=1 sm=1 tr=0 ts=6a185947 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=lrA4KKAfxSG5QlsXGw4A:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: ULNynLDyMvZF3mwatgeMlCQ1bwXEd_QB
X-Proofpoint-ORIG-GUID: ULNynLDyMvZF3mwatgeMlCQ1bwXEd_QB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280152

Document how to describe LTC2378-20 and similar ADCs in device tree.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2:
- Use unevaluatedProperties:false with spi-peripheral-props.yaml reference/include.
- Use unique compatibles (no fallbacks).

 .../bindings/iio/adc/adi,ltc2378.yaml         | 118 ++++++++++++++++++
 MAINTAINERS                                   |   7 ++
 2 files changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
new file mode 100644
index 000000000000..fdc004049521
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
@@ -0,0 +1,118 @@
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
+    enum:
+      - adi,ltc2338-18
+      - adi,ltc2364-16
+      - adi,ltc2364-18
+      - adi,ltc2367-16
+      - adi,ltc2367-18
+      - adi,ltc2368-16
+      - adi,ltc2368-18
+      - adi,ltc2369-18
+      - adi,ltc2370-16
+      - adi,ltc2376-16
+      - adi,ltc2376-18
+      - adi,ltc2376-20
+      - adi,ltc2377-16
+      - adi,ltc2377-18
+      - adi,ltc2377-20
+      - adi,ltc2378-16
+      - adi,ltc2378-18
+      - adi,ltc2378-20
+      - adi,ltc2379-18
+      - adi,ltc2380-16
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
+            compatible = "adi,ltc2378-20";
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
index 9e9457c7bba6..43c691ba48cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15203,6 +15203,13 @@ S:	Maintained
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

