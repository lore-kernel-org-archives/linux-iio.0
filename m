Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E456837882E;
	Tue, 18 Aug 2026 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063435; cv=none; b=LD7X1WPhzp/Ex4bbW8Qmknqyqq71NxbNKa5MnqndpxPLXnKMmvmn3Hi9eUBENknhdOX1dyE/saihApnJoTrrdTI5CWu1QBUqMLlxm1+Mf3tqPKu/oh9bUNIFOQM2mpan0PmJynL/GGFpvDI6dccig5zMhxb5eLCUbK20838B8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063435; c=relaxed/simple;
	bh=OEDTheWwHAMV5h6e8q1Io2U8jVFQMucC02eas7jS+bA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2u16eR5qmYFw3ToxwC38YmXr/1wzNxWyQD+ATm4bvnCjTpH1rM30qzk1NI0gJqJ8LM1k5Cbf6A2krhNtEDUQEBmavnnyJC2u/ZYMCebOeLP8vsKE6J9RTTCtqTSS4dlOqMm5f5YYsoHO48j2oizqdwYaF+4K/JNrCl7M+isVxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zNGY89pC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zNGY89pC"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IDuGrU3121321;
	Tue, 18 Aug 2026 10:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XvhJk
	JO5kA2wKTCrjbJC3vVu3eoMVx9zG/wFUBePGAo=; b=zNGY89pC4NWCCBEbke+fO
	gXGP9skXmtm3zwWnf9ZfSMv5CSTiaMlFPmfzbWJZ4PbGbzqTe2JHjRGf/dv34jWA
	MTTA9C6WdfTKlXw97im6lr6IVs87tMTHmzEZ8hXtvjHdHeGBWYOFwnWXxjfpCalX
	kEbg3WGhZB48bn2/ogOzregQewGd8XN+qVP7m8Ku0dOW/PqehbXpW1dskwUESbbO
	7QdgOV6JQKvfKCogtyBEnDrOvJX5bbO68e8mnwWN1fKWxDeiKH9MpztPxncicIqB
	rIMYNO5/oz7PVP1tIAkU8uQ5+uWJCz3PArXMl3meVbTMHidEJ0PVl7xepnJYixA9
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g4nr21aj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 10:29:55 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67IETsYA035931
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Aug 2026 10:29:54 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 18 Aug 2026 10:29:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 18 Aug 2026 10:29:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 18 Aug 2026 10:29:54 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67IETZOv015349;
	Tue, 18 Aug 2026 10:29:47 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andy@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
        <siratul.islam@linux.dev>, <u.kleine-koenig@baylibre.com>,
        <linux@roeck-us.net>, <joshua.crofts1@gmail.com>,
        <ciprian.hegbeli@analog.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v7 1/2] dt-bindings: iio: adc: add adi,max40080
Date: Tue, 18 Aug 2026 17:29:27 +0300
Message-ID: <20260818142928.8244-2-stefan.popa@analog.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818142928.8244-1-stefan.popa@analog.com>
References: <20260818142928.8244-1-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX0tnmJ60M9y1h
 PaY3OInEsQC8/VV9KO3OG0xDzflT0S6VMV3P/bnzElTIs2pUajiibSTD0Mq3uNol2Wdhljlw7bC
 m0iNnNbMbBd9RfahWVw7d4XoCu6AB10HLxo1p8YQ+oVo90OsxSc6C8bit+7BsOK0aQW4d3vzAH9
 7AFyIda1sG5SpRsN9L/HftJGtf4C9pS01jOYeruMcgCZg9NAQPAQ+kV25C1/5b478n0HIRm9aw4
 UKRmO+O0fu345hPQNeAtr89fq4t9yy/s/7qBOnyTS3rz2k6I1C1eUUcBnVxDFOkBBGhwvO5DG+C
 5eRqLr40YkwvQ6yRqnPvxqvkm+k8vZsYrjlUKLQhtF/n6YdxZfEEiEPGPbnokfylunVJTE2k24T
 Gr6F+PFcgFc7uJ0OneKcDZZGOAhD/58Rvmf61PXA9naKTHjr3xKJt+CPzvUFTvSOlkaWGImN0BE
 N+j4vJXT5DBr3a17cPA==
X-Proofpoint-GUID: XDTi_CGp_S5907oyfL_XqybH5H6-3Z57
X-Authority-Analysis: v=2.4 cv=B7CJFutM c=1 sm=1 tr=0 ts=6a846c63 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=P-IC7800AAAA:8 a=Svqhk2N__qMwEp2CcvoA:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXwhaClbzwc6k7
 UcV4dskGsK5Eo7+vdP6vkAYhSTc3HAQ6J9CHTl0tesGZ5CaVS13OVzty37/gWpVOpq4xHI2vRNR
 RP+pSpNLtP5oMgpUufwAXMiJiSc2esdYebYHL8eYZh19aic2E3ts
X-Proofpoint-ORIG-GUID: XDTi_CGp_S5907oyfL_XqybH5H6-3Z57
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

Add device tree bindings for the Analog Devices MAX40080 bidirectional
current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../bindings/iio/adc/adi,max40080.yaml        | 65 +++++++++++++++++++
 MAINTAINERS                                   |  8 +++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml
new file mode 100644
index 0000000000000..b0ec9159a2939
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,max40080.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX40080 bidirectional current-sense amplifier
+
+maintainers:
+  - Ciprian Hegbeli <ciprian.hegbeli@analog.com>
+  - Stefan Popa <stefan.popa@analog.com>
+
+description: |
+  The MAX40080 is a high-precision, bidirectional current-sense amplifier with
+  an integrated 12-bit ADC and an I2C/SMBus interface. It measures the voltage
+  across an external shunt resistor and the input bus voltage, and stores the
+  results in an internal FIFO.
+
+  Datasheet:
+    https://www.analog.com/max40080
+
+properties:
+  compatible:
+    const: adi,max40080
+
+  reg:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+  vdd-supply:
+    description: Power supply for the device.
+
+  interrupts:
+    maxItems: 1
+    description: ALERT_ output for overcurrent/undervoltage threshold events.
+
+  shunt-resistor-micro-ohms:
+    description:
+      Value of the current-sense shunt resistor connected between the RS+ and
+      RS- inputs. Used to scale the reported current.
+
+required:
+  - compatible
+  - reg
+  - shunt-resistor-micro-ohms
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@20 {
+            compatible = "adi,max40080";
+            reg = <0x20>;
+            #io-channel-cells = <1>;
+            vdd-supply = <&vdd>;
+            shunt-resistor-micro-ohms = <100000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e087673237636..c1e5afa42de2e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15513,6 +15513,14 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	drivers/iio/temperature/max30208.c
 
+MAXIM MAX40080 CURRENT SENSE AMPLIFIER DRIVER
+M:	Ciprian Hegbeli <ciprian.hegbeli@analog.com>
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml
+
 MAXIM MAX7360 KEYPAD LED MFD DRIVER
 M:	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
 S:	Maintained
-- 
2.53.0

