Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5206E221DAE;
	Thu, 15 Oct 2026 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792027350; cv=none; b=lNmD+8c+/0AaMZwnArpX+rciadUBc3UeGuNqKI+gtDny1vA8XHZXRh97x7FmLUWs89ITSlywe+9QgLjw3t9sB7PogkLAyln7qYLE1wvbpSA75RVpUHAsnNdmVzm/4oZIctT8ZGa8Zzl0a9clex/l9t+csBiZ4pNSjKTgvy27WP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792027350; c=relaxed/simple;
	bh=K4NfAe+yUPNvFDMH857pnYHRNybrVvvb6DPRmvxw97U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwarCyqxPlqKRAHF/2DOoeGdSyx8j7x/R4a3gWmQUR9clr3LGLZfKaC8hxK7qQbAOAgUsLC4Ep5V3Jeg9TQoCHKvlxPK2Gw5WVtkSSOboqZgpn7AO1q1Qtw1IN9vEdzAZvFW9KPGw+DJjpLebtxgi4VnWySQ/whh84yuOo01UV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=qhWOLQAQ; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MkQwxGMO; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="qhWOLQAQ";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MkQwxGMO"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EMI7vF1109413;
	Wed, 14 Oct 2026 21:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=uzykIXiPHLHABlW3EnACbpUro0L43nz2+RcO7UBGicw=; b=qhWOLQA
	QP5Nyj1N2lShpuiMfFQ9U0ak2eAFY0u0uR7IDIxGEGha3zASiuG/0yY74eBgLMXT
	t8Su3RwFKGOPBCvfhBzMhX9C++T8RRZ6JVMXHdxseGA2Qz++iOytdl6QEcEu03bC
	IYFRL/zeRYZ3Ck1GDxnfZNmfeno6ckJgYfvvZ8k4FGYBo+zZuKFeYdlCQNXacK5L
	dMB68FrmAHx2gKahCLlkkZuhnWnTERHoQLMx+usyvCyc0Mcbr/0rGQTKYZWvvWi8
	GbaEZxmlVvvQCVvblwIdKZB6h1ljy8IenmRCHUULL7icP3007FuEu3FsO99jefNz
	3DH2LHJp+mupmCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uzykI
	XiPHLHABlW3EnACbpUro0L43nz2+RcO7UBGicw=; b=MkQwxGMOljcFCOvQfex5F
	+pA45CtdhoJMRPaym70NAF8VWbT+pwRzWgvWQ4tppOyCGOo+hMM5fNEbMgfUuukY
	EpdQVgAKcCwlBILHrdvkHfC9UXbM2F3eyaYi4SBsFquxSCwooNz/Zt+u5m65RN21
	CHh/SQ8evJkGtis6oVmN/2hQKk6QFFg85W3CSt/+lDFOlWbcxwY1flI2a9y3lXZu
	smemiqxQtgS5JOger6BPqfTRW+FHxWhENAYP5N+enyfNU6lsNJL5yfTlVWGk5rQd
	jrD4GLAFk//Tp/ZUymCVWxMlztp3cMALWf42mf2SGLIrytP15oGQHuHobpxP4VjW
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ha0t3f0r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 21:22:25 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69F1MO9F029728
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Oct 2026 21:22:24 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 14 Oct
 2026 21:22:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 14 Oct 2026 21:22:24 -0400
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69F1M7jA003376;
	Wed, 14 Oct 2026 21:22:16 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: iio: temperature: add ADI MAX30210
Date: Thu, 15 Oct 2026 09:21:58 +0800
Message-ID: <20261015012159.44-2-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20261015012159.44-1-johnerasmusmari.geronimo@analog.com>
References: <20261015012159.44-1-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAwNSBTYWx0ZWRfX5p5Fy1NrF5gs
 iEwOUjPj3FIczHNohxJzI/rOXOSv+7aJSO23Hc25qAdE8bXFww0Z93SXVgXF/2srLF27pEoy69P
 QkLZjadJ5RxquMMADzAUeCqP/0oj5DbQR8xY+KAaGZqSby7MFbzGJwc9MALtV7cKGLCKLYO7nQC
 mi5VbQR0lMRlE9kaUerOJR2T5ek64opxWUE2eGLYYxwf8QR6DIWPE8HWh6nyca+0iOGJ0B4QYAP
 WGyykZ+T2eqNLgvUqo35146pO7KvUTx9dfL4/Naz3SeAiK3SCqy1KWk6hF9oV2Lr+xFIoELIDgV
 KR6nO18ZJzDEX+m1eBYKQenyhCVMEhkzdiHjLoCJS5Zj538DjCfxkGl1RmOI+LmslK5yGz424yn
 q6ZI19rXEaGGGgtg52Rijnq+MUEZZTGofgivhuI4u7bna3031/4Ea9cg8UAkR4bjiEZKrFaBti9
 Z9Fdnu4FLAoAFFMVxqw==
X-Proofpoint-GUID: FCMiczqb9rI2sdWLLRwJiAuKfEafpvgR
X-Authority-Analysis: v=2.4 cv=S7RMU4sP c=1 sm=1 tr=0 ts=6ad02ad2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=QjjZ7gzf4fBRbTr3T2gA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: FCMiczqb9rI2sdWLLRwJiAuKfEafpvgR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAwNSBTYWx0ZWRfXzzsSbXx1QI4S
 weOTVSFON/oYwiWHmdKHU8K9/FsR6doE/NeeJNdlESje+h2AfDgBEdjA+VorUQMsOpuScE8+RwA
 wpSuNWWJi1V1rfthKkb8qW6+SsAf8zvasIbo5oNH5DKdOXweaG4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150005

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

