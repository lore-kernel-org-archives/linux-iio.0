Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E93126C0;
	Wed, 15 Jul 2026 06:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097471; cv=none; b=WKuEmDAebCBlYfeb7jB+IwPgYQtmS/b1qJxb8OCKx28pqPgjzLSD5aK6CC1o4ls3s/kOpw/uS25HcI7a1Lg4+mVVZj93vv25zOHLleDVbznzUhAHVcobZiUsZc4Ul5p7x+ZV00L0sFHHlkHqJUnA/XZ5RMzW9243ySq3yqNnLqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097471; c=relaxed/simple;
	bh=7Jz1WSVvmcGjcHIebzhgIdhD2yC4aJIQbDO7bOIHw0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjRGxR1BqTWLshsFkzuVHTUPeNgVSqJj/N1anGmFFC5DJnJ/KC4aqtjdlBAjhEca4CHxdKq2qIh1oivWDmwOMyxHesexnVu3biiTntpe537ZmJilYpsJ8fxGZxxUNd6XtQSXPPAJ1l0wxfqIQfH+8YvnR77t55IiJZROU9OPmQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=O7gTd4GT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="O7gTd4GT"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3lbgA4138946;
	Wed, 15 Jul 2026 02:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=EdSbU
	fDPBrpALTdmYpMmGgXwPqT6wVa0ZepCwCR5Vtc=; b=O7gTd4GTietCm04BqtxgC
	EGt/y47ChlVtFHO9PldVZRIycGWqC2v0IbwhaOSBW3IG6IhgFmmT2k2Z46KWCxRp
	6nEWZjN7HY3xfIEForoJFpJyNTRGqt1dKJXsBXYl4JiWwNvApDtrj4Bj0VjVJdbd
	KW2NdUr4ME0JWn/5sIHkKQDp1ImnAJmUTtX1CRu2oVBcWeZsW2EM+asw0pJ0sGLy
	P/qO28Y34mcZjAK2GQr47OiY3/NNdWb4QmYatStSalTqJcl8azkEKT7Uuy2yI/sz
	XoIVJMcc+FAWPT6LPqkcjsfBKWfhET6Qa6lLTJ4tJ/OHNnXsedmMptX6E7a5nXZM
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fdtfba9be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 02:37:33 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66F6bWmP032711
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jul 2026 02:37:32 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 15 Jul
 2026 02:37:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 15 Jul 2026 02:37:31 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66F6b9Ab001579;
	Wed, 15 Jul 2026 02:37:24 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Siratul
 Islam <siratul.islam@linux.dev>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stefan Popa
	<stefan.popa@analog.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: add maxim,max40080
Date: Wed, 15 Jul 2026 09:36:16 +0300
Message-ID: <20260715063652.368501-2-stefan.popa@analog.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715063652.368501-1-stefan.popa@analog.com>
References: <20260715063652.368501-1-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA2MSBTYWx0ZWRfX5tMJedpE8V98
 95G/cXKEpIWumpeh71DayWtegmUKnM1VFqd85IKf5Evx6FG1Q9ncsobwrp25fWJ1RFAQmzMQVSi
 1lgc/UoGF0B0SKId8m12u4/iWyH/2E323jT0OBaMjglAOCYC+5BUoqcC4rolz/GEPgwk+vJVWi9
 by3SRY61SpFfpYiBO2eP+Np8PMV2G5NmklVM4txHn1K9atHU3B9SY9SPR+FibnTwykeUC0+91zp
 CAmBqttq97h2paz9CAEzlVXTSyUTK0ZxA4TT2pQNOzyjm/e9hmpy2GMZHoWgISo/OVt7Z+5FO1l
 EGBDpJ/xfqzDNpkI0wUuDrUPDT76feeBLTWcVsLBqalaAn3iC9kpeJsRjqDdvb+oe3zvoF1W0vX
 Eqa51pbunM0GrAm2qyiholZIzZ0RDZhduj1lGj4GFrD7t2JjKcyPizXO/Kne+LXnM7WDRdhnlmF
 xobT69nqueIaP2Tb2qg==
X-Proofpoint-GUID: QauNygdhSh1H2wNVxzTkVZNU0UjlEJiM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA2MSBTYWx0ZWRfX6x7WXDXgcOcZ
 3gA4756GKJ8I7LwG9hq0YBRnbChJ7V+2ctuwDIIpMMrBxOQwbp4PyT4YPu5XaHAB7krQcPaTkQ5
 UitiLWh9Exm1k8TIkUDuA2cdw9ymFPHxIF7l+gV3mkhNzsy6eVK1
X-Proofpoint-ORIG-GUID: QauNygdhSh1H2wNVxzTkVZNU0UjlEJiM
X-Authority-Analysis: v=2.4 cv=Y+HIdBeN c=1 sm=1 tr=0 ts=6a572aad cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=edEkJmESHCq-kgOIXrUA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150061

Add device tree bindings for the Maxim MAX40080 bidirectional
current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../bindings/iio/adc/maxim,max40080.yaml      | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
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
-- 
2.53.0

