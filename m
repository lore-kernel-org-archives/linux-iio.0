Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621C5430CC3;
	Thu, 30 Jul 2026 13:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417524; cv=none; b=qSgqv1jncotPuLPjlLFa2wZlXqsr3WcQ8oFCGJgRG3g9xo5vzXJFEikc8cXsg/EWvRpx2YCC8tokj9NaRZuO1K40VvE2yR3MZ965pp04Tiwd3FSpaEDbX3z0fdGcd6CcT6aczqi1PTnAnxSFfWljHjUKTxH5exu6PxJX+vlqO6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417524; c=relaxed/simple;
	bh=24y+3UdFsQ5wFN5feLpIVst8Gu8wmIUooQ9yuQU5Yk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g95t9xEPACh/E66raeBjEyQKL7P8SM0ZEEbP5K4naB5/k5XI0k872/zoAxnDxxYaTiiprayzJYe9KYXOhg+yYbnRNm7zc8ET2bKIZAIMLxk6Q6qRQfPy78Z9w7/wvJi6UjCFTFwUku4Hv2iILDI1NAyKXqNG3DLYmgj/ZqSwNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=axnYuVaB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="axnYuVaB"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDGoYL672900;
	Thu, 30 Jul 2026 09:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r9UE6
	yFBxz9Q0cLHhNjx12MtLGO5UTjvcHU5Q2cVTUs=; b=axnYuVaBr3UUdVaff3e+E
	DNge+oNA0LFIO9Rs+ki8ERWUairNUq9kep4vc0LwOR/9H29bKsc5x/KYdzL1mDWE
	N6lPJ+m0BL90guI+kXfUE4/vrWWUAhGZuA7hinJHg4VNb5RK4r1sgr68QJ/bciFz
	bTESZNhD6Mj8aD/eX5PVosYeb9ilV1AeDD9T+SSTt9fkyL19c7RIbXebAlp9fyI/
	tqG9KURhk+MX5M9zIS2X64SpSohBP3H8ItYfj+q2//6EybZGdrGGgJwg+1qTR0X9
	z1PBZMZbZCcXyprz5NQyz9WH5eZSjj/99AnJJ7mgpGLCkwzyFMpExuM93pPvFVVI
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fqag4f4hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 09:18:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66UDIHXi022496
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Jul 2026 09:18:17 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 30 Jul 2026 09:18:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 30 Jul 2026 09:18:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 30 Jul 2026 09:18:17 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66UDHtPv008508;
	Thu, 30 Jul 2026 09:18:12 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <linux@roeck-us.net>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dlechner@baylibre.com>,
        <ciprian.hegbeli@analog.com>, <siratul.islam@linux.dev>,
        <u.kleine-koenig@baylibre.com>, <joshua.crofts1@gmail.com>,
        Stefan Popa
	<stefan.popa@analog.com>
Subject: [PATCH v6 1/2] dt-bindings: iio: adc: add adi,max40080
Date: Thu, 30 Jul 2026 16:17:37 +0300
Message-ID: <20260730131738.822405-2-stefan.popa@analog.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730131738.822405-1-stefan.popa@analog.com>
References: <20260730131738.822405-1-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=V/tNF+ni c=1 sm=1 tr=0 ts=6a6b4f1b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=edEkJmESHCq-kgOIXrUA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: vmv_OLrjw3o7hGlzs3k3kiAh2OdEkkgr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMCBTYWx0ZWRfXwbRiZ5u9la8B
 De2SGc6BAkI/OYkESJFkTuTDcHO80lWPqV2JkPmjE8BL8JvVIFD7ZeLJWAZxQiejorIBofjtAQj
 sCd5Y2JfhSOHjLRG6PXB18h10hPzHbBtBCUiy5pqjcCqs+vEbK+XMUT32WGVotgJue4+/UNfMlw
 ufAX8Jxu9dpbrABV3I2jcRM7iFcrMktvGVsCRlRp+6LFQnP1e0eBzSoVLCwvmjw2zl1b//YO5Zt
 WQ62CUeJz8EuSB6f2HVzpViTtX0GAuRZXUz882fcMnM8uWuPHQlVsGHntpXvkcEVps3Sl8jYwku
 5V4ovjY2wurhFtEsX60/k46nFsReEV15qpoDLVSa4O1cXy8MlLzw5n3jLVu6vVolnrNqparRCqX
 g4eo0DduuG/Ax36iF4m5xYfJNSGjVNgEcuiodxjsmVCpG2xRoiHJLLE1mzLq6ASi4mxB0gd+EgU
 XRiL/dlyACOAGxcFIpw==
X-Proofpoint-ORIG-GUID: vmv_OLrjw3o7hGlzs3k3kiAh2OdEkkgr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMCBTYWx0ZWRfXw5+Uu0abiAEw
 48yt2/tz62hp5Wf/TcSV5Q+VRwDTnV1auefRglqnzjYjCO9DmUWCSNRKuPlZhkQLkHoQvAVjp9f
 fpEQuB7+13qpXyLmp5KFtMm0jG39P5B1mnBQmLsyeaXcTVtv6tRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300100

Add device tree bindings for the Analog Devices MAX40080 bidirectional
current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../bindings/iio/adc/adi,max40080.yaml        | 63 +++++++++++++++++++
 MAINTAINERS                                   |  8 +++
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml
new file mode 100644
index 0000000000000..8dddf58e44125
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml
@@ -0,0 +1,63 @@
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
+    https://www.analog.com/en/products/max40080.html
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
+    description: ALERT output for overcurrent/undervoltage threshold events.
+
+  shunt-resistor-micro-ohms:
+    description:
+      Value of the current-sense shunt resistor connected between the IN+ and
+      IN- inputs. Used to scale the reported current.
+
+required:
+  - compatible
+  - reg
+  - shunt-resistor-micro-ohms
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
+            shunt-resistor-micro-ohms = <100000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e087673237636..e1170230c4bb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28893,3 +28893,11 @@ S:	Buried alive in reporters
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 F:	*
 F:	*/
+
+MAXIM MAX40080 CURRENT SENSE AMPLIFIER DRIVER
+M:	Ciprian Hegbeli <ciprian.hegbeli@analog.com>
+M:	Stefan Popa <stefan.popa@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,max40080.yaml
-- 
2.53.0

