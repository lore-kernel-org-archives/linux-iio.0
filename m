Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575317;
	b=tnyNUtLUGtboMcbkprSxrk8R056JhGrqnlk6g09Z7GwGe7ZnkkhXI7gV7vmeK1qwpC+M
	 /2f1RImmHxQZ8OrPcm1iZbdbbbyLEZauPnJaHm5C7ZkNN27QmDpyO6P5+1wnR5HYgh9WW
	 /btUyCcNAO0TXBvlNsCHOzR9l910fZoqhm74xRRboJMrhpncbIm3I8sZnJ8tXTvgVOriZ
	 AI2imT/btt8+zps0RbYozVQnfmAhcvWJsbeMqhoIsPfTeUgdZU2kDMWp04BpHR3CYniaq
	 efiZ1HJ1+JLZe+1cv6VnT2J1ZcbBy68nzuDYXr6X0myklR23vNz0fR2p4IQP2j7tH2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575317;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jnXxOU+8/Oow4DyN3zU6tbCAy+tVMaJuheJSSmN6sKs=;
	b=x4yGqZmpdua/dIj8hXWb6QSb+xJ3ZSyP/HM3DHTWVHg+yiQUTQoGJnQeZxXZBICu3kVl
	 HyNW8pEusuj+225gcz1BNRZTnnO7tno8QIkVw+AQG24kJugyFE48FflJF7+YijVCJztl6
	 fx/D2vmmvZv3855ss6tY5G1S3gMcF2iRW9jYOAIsJaSHdTtvCU0UvXeXW98eBuFZHke5Y
	 ZGOq0/pts8tQiMzI8seG6n/lE9cMYgqjdLYgtHvtwubfyX19+MbdykcXWDk9kQ423bFpH
	 TW0sZ3ys0NSFQAdtt6A7hjAAnCKdXuvm07sd8S3NAgAwBfRhsZyl2HG/tvYxZhiymSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=VdrACnnL;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jv6rMqUq;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C69606A31E;
	Wed, 25 Nov 2026 02:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67C69606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=VdrACnnL;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jv6rMqUq
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP29hMD845131;
	Tue, 24 Nov 2026 21:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=jnXxOU+8/Oow4DyN3zU6tbCAy+tVMaJuheJSSmN6sKs=; b=VdrACnn
	LMfHTjoB8Vzcu6l8rJ93az5OQt412bR/vqApTWggxc5kDBSeA5IVA2wMwz6dpQR+
	veqJZAP/vZTs1P5d5X7Co8476DOCUTZvWn6b45k8Mie+sXLTwON29niu4syF1ahr
	psApN8EyZ45caIcScYw4cLX8qIIo3dY0QCpLMPMp7m9u7aqPTVyx16qi1Js/uLlV
	G5g/r5u6+PZJ3lXWWOhBeJaexvb7Z3RMP1NIKYMYUocO7PBtAw9At6Q2GTSQirZG
	Tao0Er9R4eZEKJB84yADDYCxWVS0ZLUeSbtnshwVEh3Hfc5HEVObhptbGER3HKP1
	R/UXrIfT1HoljEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jnXxO
	U+8/Oow4DyN3zU6tbCAy+tVMaJuheJSSmN6sKs=; b=jv6rMqUquZgUonXcIi9O8
	aJQVzhFfcTP0QagpdBtf2zFEVZ1vODTQ+io8p80Vi0pycY5A8Q2nReaPhqSJ2Q/5
	iy/7/0pIZKyecYVIV2kVXWE230+3y8C14hi0IpgdAD93mpy9FFE/kNFgOIqE/Gaw
	2/zGp1xp4LLiU/2/KCCKMyg90Bls2ZxoeSB4DxXidTXLWPowQliOVzjCGKxoOife
	ywEuYO8QIHsratOn+i6yv39GqkeZ68lByCRxuNPHMzS1k4dSZzhA/nhg71AkCr8G
	fJLKQh7qHuEgViCnxSzNLfN/0feY26IK7DDWItiHfgxXhsvkgp4B1YE4SoJBuvLl
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j5db6bbv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 21:55:05 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6AP2t451011686
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Nov 2026 21:55:04 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 24 Nov 2026 21:55:04 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 24 Nov 2026 21:55:03 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 24 Nov 2026 21:55:03 -0500
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AP2sYQH016116;
	Tue, 24 Nov 2026 21:54:54 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <joshua.crofts1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v7 1/2] dt-bindings: iio: temperature: add ADI MAX30210
Date: Wed, 25 Nov 2026 10:54:24 +0800
Message-ID: <20261125025425.1176-2-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
In-Reply-To: <20261125025425.1176-1-johnerasmusmari.geronimo@analog.com>
References: <20261125025425.1176-1-johnerasmusmari.geronimo@analog.com>
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
X-Proofpoint-GUID: ONHPTGjxrGjCMfM03REnWMaVozoLEPhd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAxMSBTYWx0ZWRfX9x2+Gw6m93b5
 svgd3CKxM8x8Y2twEwwZBD9+3ZI0uy1RXfl4nTEVAqVfaF6Q50FLyEv4GhsOBlbRxQGplVVFBj4
 cKhC/ckxBnBquroj/dAqO4P/0AujQRL8vMLo3ME7PAO1TLgx8AOGgQoWo7GWW3AGQ8pCoVsW0Qi
 Vr483F+3JW+iWX4svTwBQWeP9AD0nPxoLbKB0vMEsbREobqD+4ri8B2+wcv+6RZzJCN20yfHNZr
 5LYVMB92DDm1Ds8K9Jh1rzjzrmfk9yH0FlVtPliuw89zAlwZV8eYq1lXQoE+3xIrG7DslCP/KDz
 1hr2h8Pdqr024wrigX/Qa0vCIGwLdhl3Kj8Wld56RutaJThMfj3/kLVgBCGgsVYiGQ3uvD5BbvO
 AVxH1+WC5VmGTuk3pQC0e0RDqarBVKplKplCiqA6WlGomKsoZU/aVTR+uAO7L6PVw70mTWVTGk3
 luYWEPO0rq6/krL1jBA==
X-Proofpoint-ORIG-GUID: ONHPTGjxrGjCMfM03REnWMaVozoLEPhd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAxMSBTYWx0ZWRfX8Zu9Alm/bvj4
 NvNpw/g+evfKGuM1YjLPK8PN1O+HS1slFvtrmPPaPK4akziLrnNmNh+gJHMd/nHfkO9yXE/DcH5
 /0aZGGyGkAt4YGRU7oDZ4/kHgQ2QU1XVQOwEsVknJqoj4FP1QVa3
X-Authority-Analysis: v=2.4 cv=H99OUOYi c=1 sm=1 tr=0 ts=6b064e09 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=8Tyz5C_Vz1RR8MM-A30A:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250011

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
index 02015eaec312d..d00ecbdd21e7c 100644
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

