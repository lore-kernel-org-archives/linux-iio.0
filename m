Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276924;
	b=ZvPCP5g3ChUBqSmG5MSrH3KmMZV7g/Nos/IoUtgBS+DVmQhNibPGIYLETFTBzBvaxttK
	 Z8oxEce44rIl0donM063YT9Y3vEPYklOrj8/8G6poc1lVLCL+7JVxPBb1MJCAXjVskA93
	 C78wIzQCCkMsl4SW6plx1vy8QJK6mz6Wg5pnK6rtAa/Em5Bbs78/WVTVIY1ZzF5vadv1j
	 ZYZ/xIuXh1Z/o8ME6XmZnBABU0YvqoXDQ19KXg1xp4fZLIqZ61LxK5iqdZ7P44ecOKi6u
	 am5iS3BUNEk2knZ96MKDoeTCnNsUcZSu8C2Pw8Uj8y2ErkC9UzO2s1t1qz+aJbp1RXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276924;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=B1b5L3SSHXE6fNhcgsaO4Hc+U71TpybJ5OywHRvOXXo=;
	b=QdzwVNJ6hpqvVbYjZdWzHd9omAeSZVTZXE1gReBhRhUmgb1OwRr32tfbk0snj2OF89ZR
	 wJhX5RHTe6Gr/DfBBk650B4ZQ8sTvuV5HiB7CTo3fq3YhMdrNWcSoZzJnTUQ0TlNfNJkE
	 N56Wp1LZRkZg+1ZHDU3792o2sWMcw9c+juUd0jxOOCj1IgZwnsDu+bsgK2TgB1TO5cLrH
	 Put/SnKZvTynMeTlI/WDMQbE5TM7Zu75lBXIgnE6wB1tbAiPMF2hFU05mrqda0DqAlnXk
	 QNak1eT1Vlx8xE9DZqvaqmcR0gf8Hpym7NDpBwOoFo2IWB0AHOFNvH00aZ+uz4XFIyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ZEjZoRMp;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=JsD8jvpW;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DB2606A321;
	Tue, 10 Nov 2026 02:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44DB2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ZEjZoRMp;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=JsD8jvpW
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA0kjmp2799632;
	Mon, 9 Nov 2026 21:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=B1b5L3SSHXE6fNhcgsaO4Hc+U71TpybJ5OywHRvOXXo=; b=ZEjZoRM
	pS2ml0JzHJPkkvpByCG9R+8VeIdBLKwrD9wEGFyQdPuhuzg0Zbi3l8Euoc4KCevJ
	jvnr795BHV+oOR/3VfiGhha1lTYWRdCJl0Rv7uJLswUuWEzLwmJkzm6Zqc0YQmt0
	eARWKUvLAGgaWITAuIBjIyZtLoHSxY35FihHCDIkqHKLabONTEP1ykTlsuRUv15h
	++qI4eMpEud7Kys6e0YYD9Ld2nCqrrdmBYWS92XeyWfpYP3r0FVIVnK5qtovRRWu
	wvLqqH5sZL7WDn+zKbAaKTNq8zKRvrEZNDcefsNxf00iFIdfHQDugBZE7VqwFM95
	3yySOWGuxjHJikA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=B1b5L
	3SSHXE6fNhcgsaO4Hc+U71TpybJ5OywHRvOXXo=; b=JsD8jvpWnsCHvVrUS7BbP
	jdcAtkjQVpGDjK48oeO+ui7Uf0+Bk9l1PWd0ePP4s7BpPO+OvooXCoNmvuGXIlqJ
	yJQZQryBEfSfJMPjqzQUX/cK5Slel+CS73xownBsXhXV4o2hdU2LqXnM4NkXtRwF
	Y80EItMWOta9EfYz5adsNXnc0omsX1xG8tf+ZNAF/BadXU1hmWuFhmvkOR7EqUVH
	cU0BiRhAuPxsw55zrrCqNQ2xY7mpcKzwXMDUxfZ+eaCUiWCfcUi3lph6tnQTa4uV
	3lBAa93w+chqUQL+2OPM6MNg3g87i735jDL7CJFUsZjDZ+HCgndPScKdo0K7UBix
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hugta4056-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 21:15:17 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6AA2FGTE027152
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 21:15:16 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Nov 2026 21:15:16 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 9 Nov 2026 21:15:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 21:15:11 -0500
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AA2EovW016346;
	Mon, 9 Nov 2026 21:15:02 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <joshua.crofts1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 1/2] dt-bindings: iio: temperature: add ADI MAX30210
Date: Tue, 10 Nov 2026 10:14:41 +0800
Message-ID: <20261110021442.410-2-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20261110021442.410-1-johnerasmusmari.geronimo@analog.com>
References: <20261110021442.410-1-johnerasmusmari.geronimo@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAwOCBTYWx0ZWRfX+KF6YF/hzyDx
 MFRfKzBbsl8TyMmSlhIPYe4ZtMWHlNYejDpctgd7dTg9q1/zj9QyXz3wY95qTdVbZYsQ19FZ2D/
 1jOB+34IXgpzVx0E769pdhkFgeNSC1gZZxPItecN/5H6koi2xHX5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAwOCBTYWx0ZWRfXwd6pRSQRBaKo
 roo1Kdm3soK6v+uCb5n8o3VaFj+5ZCBisJgFGbLO+VjPhZC0weGUyWGGhILtQSVIuupwLAtvHdZ
 NIEcWmNnH2771ShQOY9/oYv8T2iafPys+zRstoE63JC+fFoBteQj4CyHCY5JVul3JVkN1clD1am
 wJq8LWvRq8LMqk0CalQPVQaBB8nN1WxO2X9Sqlap1oXB9gbD1Fi5G4oLMeu6gG9fNchZUNGHBWp
 QUUotCOsiaFXMZ3iwZkdeOwI6txwtU9E3pZIu5L5iJ0qR/lEzrz4JcMpQEs/TaiDDb/nvNFai+F
 D1MqauKqorto7eGn4GRynPpbzvba7K26d7yV/eBjs9pV6+YpInqhjYbTYkGbXHZrPLEA95si82v
 igRciBOPDe1Now6z8xMp0ETy09zDoTxRSwA3Xl6BIL0lxJwnyEFJfyGDibZi61ui71RTawEy7Bb
 no5q9WliA2/tCSSn81Q==
X-Proofpoint-ORIG-GUID: 285XVMWPpMP4Bg8iHiXNUdzWXZ0B1NVi
X-Authority-Analysis: v=2.4 cv=UP5Ijyfy c=1 sm=1 tr=0 ts=6af27e35 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=8Tyz5C_Vz1RR8MM-A30A:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: 285XVMWPpMP4Bg8iHiXNUdzWXZ0B1NVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100008

Add device tree binding documentation for the Analog Devices
MAX30210 temperature sensor.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max30210.pdf
Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
index 0017755f593bc..87e455b592461 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1786,6 +1786,13 @@ W:	https://ez.analog.com/linux-software-drivers
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

