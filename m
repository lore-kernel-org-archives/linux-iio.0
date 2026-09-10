Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF73391E7E;
	Thu, 10 Sep 2026 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789078364; cv=none; b=lQre1hhmiA/bJQcas8gCOEM2tjA/u3AN4BkQEQcA1M8F7OKhaG5jo74g0UU+w+SmiYpkm7ZZeSSfoNBSUWXaByqfzIAAaVhJSCuRsB4J8/DzU0FYbYWU8WylhaxzkpeBM7ToWp/Q+BWcmE+MxwbbHCqxvHH49wvYc0sx2KoYdO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789078364; c=relaxed/simple;
	bh=K4NfAe+yUPNvFDMH857pnYHRNybrVvvb6DPRmvxw97U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kI4di6kSnF74iNwt5wJcYQNSJdwZ52rO3INaZrua+PwpsiqwcX/EZ6FUJhztOLlIN+ULYjVHL7Fz1UD2LsBmdQTHB15z36JPE//NA3TV0pZdDJKORLW/yYQ1r3BI8P0vAisn4kr5qlD7MbJ6bi/NcZ/hJy19E7AbfetkNJTotOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Bai/HysW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Bai/HysW"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALVt2h836959;
	Thu, 10 Sep 2026 18:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uzykI
	XiPHLHABlW3EnACbpUro0L43nz2+RcO7UBGicw=; b=Bai/HysW0cQz23J9Hybnj
	sJQ1z6ugR2r0kEuC7uSCttgS6tkWq24F3FixBT9rNPPhH6KQbDEOCIlgnYGEgq77
	EV15qyfSaySyl4FmDhPXXhFTdzv5oyIB4C4bc+V90qIHKsxLbUbVtC43+ZZ5OX24
	OkEIbRY09Fc6d3uJA5UzXvb+vMtg5pGGEdpVYMWWO2NyRJYhLXKPjUPjqjxPVs3J
	K+tzQzjQLR0PJn3URDOIEUlLbfH/glnHdvsB9iVgMcV1gLTf9K6WVDTYFJ/ygQPU
	xb/FYOVjaSqxjubDqSgVMnSkIqsVpCkBY5JmAvd5BCKl/iZcKyPJqtvMPDyTVFB2
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxcx29h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 18:12:35 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AMCY9x010779
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 18:12:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 10 Sep
 2026 18:12:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 18:12:34 -0400
Received: from JGERONI2-L01.ad.analog.com (MABALA-T01.ad.analog.com [10.117.222.255])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AMCIkO028000;
	Thu, 10 Sep 2026 18:12:27 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: temperature: add ADI MAX30210
Date: Fri, 11 Sep 2026 06:12:16 +0800
Message-ID: <f84dff4406361f180bb85e4187a64e8f9fc21b18.1789032019.git.johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1789032019.git.johnerasmusmari.geronimo@analog.com>
References: <cover.1789032019.git.johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI3OCBTYWx0ZWRfX6vudQdGu201f
 m8cRQYbJsZsttZZeeaSv3MeRUoIXboE6uJD0bGVPK4qCLwY5/stpwM/y8TguhTeeULnXsqOeuT2
 h4RyycrPvzJ0EEtIdDG355+79Y6Yi9UX2a7S+zCL1RBJeRuwAl8c7wFSmTohEq/PMRblfnb8c9O
 tZjd3RkDzAeRS5EHMb7AMRRBtRV1J8KNYBgRs0Bazzr16rdYt9zhU4MMbGw6fMWFYDaqDvjyzNO
 WEVa3aBFkGVRLFX6y+TNkGJ9VC8Q1GCjqpyQyZK+mBx+uq53PNilg5PTQXrPs9FDD/ObRRJD0UN
 huKTmsYAtLSqkM2YIGVKN4WRbLcv5waHZp0zODYq5FApHbodDOEjPB+T8ENFWgPQevoyKBDzUFp
 /lbMLEpo/wqDJ+Jt9F7oqoWK8Pb43dWuXsyzQpfo4hRuoN+pqFP4MVAc6O9JpIMTf/n3Bns6rxI
 EmV6F+3f3TKUotZZxQQ==
X-Authority-Analysis: v=2.4 cv=GoTXaU1C c=1 sm=1 tr=0 ts=6aa32b53 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=QjjZ7gzf4fBRbTr3T2gA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI3OCBTYWx0ZWRfX9wxtXk0wNaqI
 3sZO91/XCbSOBdNv7xsLSlbrsDz5ilXjfWDWVjJwzHNe2/JqNM8vBwKGpvnG1jBhCJGPsaE6Sw6
 upzhc/XT5nSGlNCdaWvikRs12f3MCE36941ToF5i87TU87WrCV80
X-Proofpoint-GUID: KNJMVh8KRdaFAJWU05Dsp21lEz3OdVNU
X-Proofpoint-ORIG-GUID: KNJMVh8KRdaFAJWU05Dsp21lEz3OdVNU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100278

Add device tree binding documentation for the Analog Devices
MAX30210 temperature sensor.

Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
---
 .../iio/temperature/adi,max30210.yaml         | 61 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
new file mode 100644
index 0000000000000..8bfd154bbc438
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2026 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/adi,max30210.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX30210 Temperature Sensor
+
+maintainers:
+  - John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
+
+description: |
+  The MAX30210 is a temperature sensor with an I2C interface.
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
+  vdd-supply: true
+
+  powerdown-gpios:
+    description: GPIO connected to the CVT/PDB pin (active low).
+    maxItems: 1
+
+  interrupts:
+    description: Connected to INT pin. Interrupt triggered on both rising and falling edges.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 396d4e76dccc2..6eb3cf66f431c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1653,6 +1653,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
 F:	drivers/iio/dac/max22007.c
 
+ANALOG DEVICES INC MAX30210 DRIVER
+M:	John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
+
 ANALOG DEVICES INC ADA4250 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.34.1

