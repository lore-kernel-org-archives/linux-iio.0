Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742818;
	b=YDzH40GY0Dsr7Atn8Je3RFDk4we3zMpy8lTvGodm4zQGRoMrhr6NfGfLzgd5E0oOO8y/
	 vdQI4KkLra0ctGtMecb8tOPxHhI0Jvow5SYMI21j6qL5ecS9/bkKhQ18SRax9+RHCCRnj
	 nhVU6PgzCYMFLs83bsbvhTqTLSzp9uupjKVQ/bbghbhA/vzTe4xwgySlO2wquO4cKER9K
	 HIrzvNGzlaJoMrM5u6PZ/jHjtqzq1krTn3zb9PxALi2ZGm+4Bmxy0kkLEPrwwhnrKhPEw
	 RIgLV/9mxTA49bjAM1m/yoU5V8IqONd0oOwetBuk3aV24ZckmqQA+gXpkbLCcVINJCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742818;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=xZ9zLMNgICpiuhAA0acCDo6vlmbVnNtUumbO78GGMNg=;
	b=IaXpMqc6EQPqFOg01aI8MteQTAdthbr0xQSVikMKcgkqgcc/WRn3Ga/6RWZviEJygMb0
	 7ZITdcbnn6iNbg5RJmg7NyhiQAc0wWphobpMEygVN2U+l03/ONZE1Pjld+bppwU6iedMq
	 stwnEZvng1BT0xZjuhf+/ml4UDstmrtzfkDvbM0VKNLuAKr2+VUs4zVMr7ky1PIIpjTYP
	 2+fs46mn/481E9MjPwQpVJwZXGPXASj7JAaA+BWc/HS9iULVv2WuI49Ov4m0U+5Jnew32
	 EgZZGtUepkEPoi4qvQ6bASUQJBLp1n78VwAWUEA4QclaJ/t4y/yE9BHz3VvlhobU/DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RyHzRgUQ;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=D9P73wcO;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F8A606A31B;
	Fri, 23 Oct 2026 08:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32F8A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RyHzRgUQ;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=D9P73wcO
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7Gj2C820689;
	Fri, 23 Oct 2026 04:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=xZ9zLMNgICpiuhAA0acCDo6vlmbVnNtUumbO78GGMNg=; b=RyHzRgU
	QDlpsjf9Jma5hiqXThg7iH84l51aNEU/Gq0OBsQ9aT38qOg7TlMqZFs9BY0rPGUX
	HgU3bSyAF8RC2MURxk1CjHHuDeO2hr49irrNamsFIl5dboRzHwPR6MhsuPkIT4+0
	YpR6yPJYqX+n6OOfzCvq7HWka3sLiTK/1tG0QsT017KhRbLTT/HnsOhU1fkLy5bG
	H2/5Z1O+Q89VWhjAjckwJPL4xT0wNFsJG75NIDHijmY3/bQ+VuDhXUNdb++xd/Js
	9f5VJgXTTnVn7QBrEX3sZj+lLULft0DOJa1Ma/abHnDDOc4si2mhZyHBBat+P1md
	EGEyifo9ueY1z0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xZ9zL
	MNgICpiuhAA0acCDo6vlmbVnNtUumbO78GGMNg=; b=D9P73wcOD6qELKKJspze5
	uugY4iuRLvN2oyLD8M6FgFhS71IKr80RqYsP+4hIwCF1Wp9nUavSfZyFBYrV7I9H
	dFWAAyWxIrKDUcDIIgu/DpIxJTqyd1gtrn1ZRwt/KdvFVpb58gV3aSPS1OL/tYD2
	PGNlIN1NgC/wVFL+3APuP6gArsWC3vJJi6AbBy2vdGHYp9YvcN14QA1rrd3+Q/Q6
	xgVR57PGgx2G9xNCCIK9+aIlq6ABOwTAxBSvOmo5pwOSjbCR9fqEP/lh+Z/oU/V0
	oi4Z6ZDEvVW8j1uyvD7XDmjqAZSUoHsByac4oPyrovCTvIp//gkngq10AmxOAsqF
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hfy3wseet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 04:06:53 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69N86p5W045306
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 04:06:51 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 23 Oct
 2026 04:06:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 04:06:51 -0400
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69N86VIO020871;
	Fri, 23 Oct 2026 04:06:43 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <joshua.crofts1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: temperature: add ADI MAX30210
Date: Fri, 23 Oct 2026 16:06:22 +0800
Message-ID: <20261023080623.1830-2-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20261023080623.1830-1-johnerasmusmari.geronimo@analog.com>
References: <20261023080623.1830-1-johnerasmusmari.geronimo@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX8s2UlOsN6LFj
 2x6RWCAo0bViju46PrLTIrAV7hkgoDrUnMl1YGHFdY5a8F04i+UBKsG3QTE2s/XuCCO7kRSIqvg
 XpXEDKAm9mDEhEkke2IFhZo0PXddlynYJrzyn3s6sjUfOZsLoptp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX9pRBqmtgMOeK
 lYMxsQVVMWdY39VoXvWuU2Pf2wNhYxY5d1h4qnGP7bF3IT8VU3cQ326sD7SZJzwUQYrqdyX52Ps
 ojRne+14jl+lyxixBD5ed7zMLF7hp1oI/wkY3ckz2E/UIMDMhPC22l51assdMLzebwWlzbnogoF
 CdENyK70rAc30auS+VlwPS4AdjYAOE+VZhJQMdLDia62Hjapl9A7Nk6EbGedYltuv1mhilxBT1Y
 t7l/Y2chYXA0jPOWCxY/uZ3FVPLYf45AtNbWoMpIWX1oTqAolcLSvVHd8Fz2l5dLgRZxOUFwkWN
 fS/v7RpSE+1AA14/OTrH2DjebJGs+4IyRda6FFtg1VSG7ITzdnwjebdgQ1fGaiVSbCmSzuUsPue
 o2qpSCrqQsUz9YvR080+zL+Vph1TDx2drkeVU+SoErIu8sr6dm9aR5Sdl9AcLF18NC/cnfqci16
 WBfFI7YJG/47rT2Rpog==
X-Authority-Analysis: v=2.4 cv=fJ+sTpae c=1 sm=1 tr=0 ts=6adb159d cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=8Tyz5C_Vz1RR8MM-A30A:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: kPRaer5KTRzADotCoC26efkASbSHjICl
X-Proofpoint-GUID: kPRaer5KTRzADotCoC26efkASbSHjICl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

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

