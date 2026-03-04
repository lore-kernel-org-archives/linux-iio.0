Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26513A6EE1;
	Wed,  4 Mar 2026 12:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772627136; cv=none; b=ETR2phsFSMsOhmSsqqBMr3UdLh3JH1h3ck/g6dDf7/SYbPFRnxeyQoAq9FwnM1PXN4v2/VeCs4hwmWerbnltcy05A39e2IH3wCqdMyUsLuhjuiK62rilcAbKDHOrFkcxiSn2/vDKzC2bhz8VtVPSbj15N7UbcwSFuEmo1miGYOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772627136; c=relaxed/simple;
	bh=RFdv4LO6rg7tXzKh4Ke/DGSzA+L0aGxcJaFQHnAf4sg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebaWipwTj71YkI+NKt5ggmqwZRW2YTCLvF6vykoX6XQEFLqnpH1Vbsq/zi6zH/HQuRuNn8EasKrWacDD0JQoNX3BKSiFNOA6EAiT8oTyPhWHtN0su9gtkTRAYtFbEwe7C4BR94p0h33HVLAf1i1dZC+d8n3XT7gB8jvhM3rEF3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nOngdGDd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nOngdGDd"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 624A7JuP3363772;
	Wed, 4 Mar 2026 07:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=h8Bo3
	Ta1d/I2gR/uK5Cgwkj5fFdkrC8oPNj5yw1eJJg=; b=nOngdGDdq+5ceAhDHBaQY
	rRpH/AKTSKm+rFIjjRztXm6pCpmru2/HA55JU/j/bhDbIVaRw+v3aqDguZG5LZtK
	kQp6zLC0iXqhJbPjyYInzT/BXfbthvtFeCG5KEI9pkcI7tls2VwNHBblhoqT4k35
	OZc6i3N8qzwVRZHiPlbUkhAqCO1VA8YLplKXktgX5E1QZ6t5jh9wHC26swd2j90v
	ttwZxomVS7DJckCjS4AflpBMMCHjZALO1mLWE2+LqkIv+5uLl/hEvXktpi/oAjSu
	ZwlkVRqmsoMF9YA0trkJah+PQY4zJXig/PQ+FRSN84aYg6TVwf0FREo63jAkWT/m
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cpdywsbnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 07:25:30 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 624CPTtX032263
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Mar 2026 07:25:29 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 4 Mar 2026 07:25:28 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 4 Mar 2026 07:25:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Mar 2026 07:25:28 -0500
Received: from JGERONI2-L01.ad.analog.com (JGERONI2-L01.ad.analog.com [10.116.32.144])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 624CPCsC006193;
	Wed, 4 Mar 2026 07:25:20 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: temperature: add ADI MAX30210
Date: Wed, 4 Mar 2026 20:25:08 +0800
Message-ID: <20260304122509.67931-2-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
References: <20260304122509.67931-1-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Mc9hep/f c=1 sm=1 tr=0 ts=69a824ba cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=ZN7WX4KZsEyFn0iOn_oA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: 2WHzWLkij48phXIqzPbW2FbKCy6ciN6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA5OCBTYWx0ZWRfXy2fgFF5yGCTS
 cBAGT1B+VGP8LX08pneah0oDgIWntlKShsbC4wbZKFNd44NsWCKH30zhRcLkqGzWk1oIw5BruBl
 zx8GVtLCqtAk4/cMAyWrrXVB8pYMr23gpFypDjIdCL6KjhnBIJ/gwX0okzKyTM61Eh6qQiyhKIw
 aA0v9HCBB665f5tXCMBVmeMOgnj2f4rIuH4w036Re8r3XGugAGM7ybEkO7qkkOMh2oydOPqi3T+
 78Sz+OkUnC0W64skxovPXdnslu7kc6dPA+Dr6aMEc2Nuc3QQKGpn+RluTK+3u+SJD98VcTfnOa7
 BgnCGyYnNylgiWKo3VT9tXk3PHKQMrQqYSUzVbJC5KKFKfo79nwVF4fWyf5Xgi4f/wQGofasA5t
 0UKlNHiXnlWbR3kxTe0sZDpza0JoWYcjcAvTjxEOd+l9cGF0sfQjDXozceRwpp+2nkzUqjbV3n2
 iL+tdcqatzPia5SdsRQ==
X-Proofpoint-GUID: 2WHzWLkij48phXIqzPbW2FbKCy6ciN6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040098

Add device tree binding documentation for the Analog Devices
MAX30210 temperature sensor.

Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
---
 .../iio/temperature/adi,max30210.yaml         | 62 +++++++++++++++++++
 MAINTAINERS                                   |  7 +++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
new file mode 100644
index 000000000000..66867880a20f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
@@ -0,0 +1,62 @@
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
+  vdd-supply:
+    description: Analog supply voltage input.
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
index 1c75276404df..09345b9f32ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1638,6 +1638,13 @@ W:	https://ez.analog.com/linux-software-drivers
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

