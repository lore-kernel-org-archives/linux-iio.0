Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16EB309DDB;
	Fri, 17 Jul 2026 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784291990; cv=none; b=KaB2/aZeFgvYStvjMdr53RQN+oW09rtKPuEiIJEca7PbSMSHINKtqjAx+6KsZ65lu8lSX0/dS/4fqegRYHORDYkHdZOUsMHbK4qFqwm4cUBRSxVO6/aprGEbHxqKI2mnKkdEYaUuskHEcuDK3QKCjivyvUQ6BSKUc/THET5Of24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784291990; c=relaxed/simple;
	bh=lv+zKXn6nF/jFwWO1szVvShR7WcEuNTjhuTAo7RN65E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+vKw8SYGwIqm2cYi1ZMDHsQKpcpLszCH1oExP+W16VliRGb3qN4zdqPmEget1zX1l1Lf51qTAjSi20dkUxI6zbhsSLZjcjZ9rXO6rnFYbbTJmW5sn0IfcpAMunwIKEmk282Umjl38FeToJtEsuRyGPvLXdtEqfrOaRkJUGOfIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jg9iTrzd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jg9iTrzd"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCOIYM2293944;
	Fri, 17 Jul 2026 08:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LKiKW
	mv/HHx8B+Ia6O/yNpX0QdvMgEodIJOldKl67EU=; b=jg9iTrzdnxbL/4oYDbXrM
	5hX9sB5kCzB1EOWFTPvyWT/hZn0bvPuLyFd7+j3mbyJ91y6buZ7kN2O/U5GmI6oD
	YiJ8PZOddZOpjPGWHtiamjD0YwBX+eGjtrL+vFIsGHffXEvZyB1yMTig/bmNR4YC
	zP79zFE1D3w84lPYMsq8Fs32/GYFbfhXzhOzqQWuijr+Cvk2xjbvk+PXic8lt6+O
	Qk0D8QvNQk9h6e5y8w8/pyOE1K55robYvL1zRsJpR3M1R0oQCRp6FopT+ZkfcCxU
	WuR5YKnyYxrZtIPsGo427xqbRGCEUldkFqLHX8FQXj6Cs3VcLrWkDd8O/3Mldam/
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fe85x23aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 08:39:23 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66HCdMtt041796
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Jul 2026 08:39:22 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 17 Jul
 2026 08:39:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 17 Jul 2026 08:39:22 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66HCd3wA014702;
	Fri, 17 Jul 2026 08:39:17 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <nuno.sa@analog.com>, <devicetree@vger.kernel.org>,
        Stefan Popa
	<stefan.popa@analog.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: add maxim,max40080
Date: Fri, 17 Jul 2026 15:38:48 +0300
Message-ID: <20260717123852.1140893-2-stefan.popa@analog.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717123852.1140893-1-stefan.popa@analog.com>
References: <20260717123852.1140893-1-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=aLnAb79m c=1 sm=1 tr=0 ts=6a5a227b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=P-IC7800AAAA:8 a=Svqhk2N__qMwEp2CcvoA:9 a=sptkURWiP4Gy88Gu7hUp:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEyOCBTYWx0ZWRfX4kA0ksafiJrO
 cXTIaHrsFJVQcGxpzYKTcv06oEQFk4/pgODhYHzOFRjkCYHetOIx3Up8TmskEIhxWutli6PWSRh
 zvGsFPdDn8BQMKFX7ro5qeu2qzkWj3nIfxR+yvz7wkLThkVoAt4YUIwtZoVtFCMMGo9ON7PtGOV
 w1QlG0+dw2lwM6Ec9O2pfZEJJ0b7dGV2u8I2NazeCxbQgUYwYYS/zm29lwQig+m9KwGDL5WllSL
 nIFyi7vdURTITwE+PkI+shgMaN9I2fCK+E7t1JM9uHf09KA7Be+CX4LrlaEYW2uUxT/I+pUnrt2
 Ni7ZQ3in79wTxEGWPv2kdG+U7ojiEYFeTydfE2INNkwL8/Yi4+yv7WV9oP69b0Dr7Ukr+kyr/K0
 eNbP8eu72MU4m1vPWqgRtmOwPU1FudYcYe/JDsRvBtBjLKg1Q5L3WJrG8jNe2MNojZ2o1ravp54
 uI4LkcrTNVRCdwGJIyw==
X-Proofpoint-GUID: bO-vlsSzEMwWfo0-yI-xCk87rM3tH3-x
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEyOCBTYWx0ZWRfX8PoM37M9ywI0
 wZB1CjCBvrk8RNT5/YRdAvp1Gs1IuirqOBtDRp1RnyyYAjxRE0qxYn92dSkX/Jpie3cN2xUXcKJ
 uOriK9z81urb7vZfB7DYLquGbVIzkVdrtAgXyzAbyK3jvxDBbZkh
X-Proofpoint-ORIG-GUID: bO-vlsSzEMwWfo0-yI-xCk87rM3tH3-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170128

Add device tree bindings for the Maxim MAX40080 bidirectional
current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../bindings/iio/adc/maxim,max40080.yaml      | 64 +++++++++++++++++++
 MAINTAINERS                                   |  8 +++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
new file mode 100644
index 0000000000000..3b367071b5d3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max40080.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX40080 bidirectional current-sense amplifier
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
+    https://www.analog.com/media/en/technical-documentation/data-sheets/MAX40080.pdf
+
+properties:
+  compatible:
+    const: maxim,max40080
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Power supply for the device.
+
+  interrupts:
+    maxItems: 1
+    description: ALERT output for overcurrent/undervoltage threshold events.
+
+  "#io-channel-cells":
+    const: 1
+
+  shunt-resistor-micro-ohms:
+    description:
+      Value of the current-sense shunt resistor connected between the IN+ and
+      IN- inputs. Used to scale the reported current.
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@20 {
+            compatible = "maxim,max40080";
+            reg = <0x20>;
+            vdd-supply = <&vdd_3v3>;
+            #io-channel-cells = <1>;
+            shunt-resistor-micro-ohms = <100000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e087673237636..9aa1bc9a65ac5 100644
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
+F:	Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
+
 MAXIM MAX7360 KEYPAD LED MFD DRIVER
 M:	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
 S:	Maintained
-- 
2.53.0

