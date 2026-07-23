Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E928506C;
	Thu, 23 Jul 2026 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789487; cv=none; b=J3Y99qhayb+Py4siJaGSyBGYPkzi8LNdRgJIRyeMbr7o98c477erhJAwurFFzlLIM++2/CEorS6G3EvNqmYeEUuY6IqheYatOSqFky7hA1UoIx480pCEg83+lBymiK1jC7t2VnT/2c0ig56lJ/HnAbYdVj3xhyifjinPwXqn9dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789487; c=relaxed/simple;
	bh=w9o+Dfzes+5+WoxJV9G2181GE8t3zr7cNWqsYrOXRas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ID2cRIlmOAfgTsFyaytz/FMi2t6god8vHRT7RTV1Wtx39P82NjncFuIYpNxOutRKMMSDtozccPXWHoiTGc7cLyuaGDQURr4K4a1e9EXAjWMoir0Vv3GCK4RyI62aHtxBeVBFplT6KpAkAz4SblujSwVhqiNra3DY7ZmPaRLML9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gW52V7zN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gW52V7zN"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N50S4c868572;
	Thu, 23 Jul 2026 02:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bideo
	JQF42LRywM1FfRKUyFOSjFyEP9S42oLwPh1s5M=; b=gW52V7zNpDhg4xoe1Arr2
	Bak4mRwIjmQ/PBKbEnHMvpEfCwwhyoUnDPc8NGfUkcYw5yltnzEHwAHau/Jq2nqL
	VGSCGFbguqxXupXeilh19Mp0dXUDmf6lh6c5u7awGDRxQu62wXDN7a6f9PBYpucU
	IdZlI4X/81Qe2LzfQq8GgrgXorfwxPDTm5TOD6YCTip/WZuYRzsnUzIcl9pvN386
	N4nDotQqDw9+Vdjl2aNdZ2yrK7Q49usLrtZcsYMlHyk9d130H035yh8wOvYxjgJd
	JNsB1Xi91t1Xbrsz5AiWxs1Cic/D0MQnic9AJNCKjS41v0+KHCzrC3yLofj5APNU
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fj6vr1m6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 02:51:06 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66N6p5Uc039204
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 02:51:05 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 23 Jul 2026 02:51:05 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 23 Jul 2026 02:51:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 23 Jul 2026 02:51:04 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66N6olKx030342;
	Thu, 23 Jul 2026 02:50:57 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jic23@kernel.org>, <andy@kernel.org>,
        <nuno.sa@analog.com>, <linux@roeck-us.net>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <dlechner@baylibre.com>,
        <ciprian.hegbeli@analog.com>, <siratul.islam@linux.dev>,
        <u.kleine-koenig@baylibre.com>, Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: add maxim,max40080
Date: Thu, 23 Jul 2026 09:50:35 +0300
Message-ID: <20260723065036.2683075-2-stefan.popa@analog.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723065036.2683075-1-stefan.popa@analog.com>
References: <20260723065036.2683075-1-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Pgs0uuk8PEX03SHL99ow6xtQgLmNrRSY
X-Proofpoint-ORIG-GUID: Pgs0uuk8PEX03SHL99ow6xtQgLmNrRSY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA2NyBTYWx0ZWRfX4PL6hryqX+yw
 4vJVnH7CmkBKcjubQjNws6KK93J2JoZSQ0ZeqJpf9+v/gcAe3+dFwBlYuRywtYRawwMWI3K2Vyr
 LFpySKdWfcjysStsko5TO6eu8gPIG0VF6qb6cG3q44Hmyopk+4hm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA2NyBTYWx0ZWRfXySXkMsx5X+/q
 zUk8LGl61HwNncLVtmNb4Lvkc9es4yg6TbbK0813Ratv7Goy8oJIffkcR1k7L7W0IDMCEXukxqE
 m8TxxRqMiAp+pZUWt/wXSlgsglLG7ZmrXwc2DwJB0dnl8O9C664ipFJan6/fZKXK8P983Giu4fB
 W8cSQzQVYOrJ08eVl6ErllzZQZmlziw5Q7FG8uKwcPPSbOAQGszzqg58ZZOj48QiS+r+Mhh+cQi
 vbFjehFtVBUCJ5ZGmTFLgyjixt/j7HXe1UnU3LrAyyx/l3KVPt2KGIlyzkC5WMG4iVoDZD1BeCy
 ut0P+2EQ9vJ3aqiJoWipuGZvhmP7CNiAZBvhX9Sx/yaBoT/epYixg5u1sLYbcTmEOA7/PpdSOwa
 pDP0objne6yzqimKOL1hGTBo+YfHQ2TfaoV4HOmN1N7vqYKhSSq6Np9k3bfh/KmU1zVQEeJTB7q
 1E5Iv/ugayCBKznpx1w==
X-Authority-Analysis: v=2.4 cv=WIpPmHsR c=1 sm=1 tr=0 ts=6a61b9da cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=edEkJmESHCq-kgOIXrUA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230067

Add device tree bindings for the Maxim MAX40080 bidirectional
current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../bindings/iio/adc/maxim,max40080.yaml      | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
new file mode 100644
index 0000000000000..170bf4eff8706
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
@@ -0,0 +1,56 @@
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
+    https://www.analog.com/en/products/max40080.html
+
+properties:
+  compatible:
+    const: maxim,max40080
+
+  reg:
+    maxItems: 1
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
+            compatible = "maxim,max40080";
+            reg = <0x20>;
+            #io-channel-cells = <1>;
+            shunt-resistor-micro-ohms = <100000>;
+        };
+    };
-- 
2.53.0

