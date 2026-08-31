Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54B252B1C6;
	Mon, 31 Aug 2026 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183880; cv=none; b=EYlrPdCpPlzc7N1RvqHS5HRn1Se+IeDbaMutaUFk0KQaSM0v4HMEynBfYFtXWz3wwlfOQMUrBcXDX5cHA3CdL+D+Lls09ktT5VyBvzY9h8sF76RBzG9f2r8L5EHACKpWDyXTGWYuVGr3V9I3weATtF5o3prdgTLWyQQ9dE6w+yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183880; c=relaxed/simple;
	bh=N/67PVBB6uXLiykMDjP+6dwlPABcykvKDgRBkTLMS00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kKrTMlL4PjmqxZ6q3PR5uRXIPRGCHEaw2pa+vTNcaJTfSU13xTzOJchC2e8VEfj2K3l3C7/zFIBQHPAhFRRDLSvtbMfiX2x+DQWCGBATtTXPqhRK7XQh4Fd9/xypMQ6dFzuA4yG/ObyvPBDE0VjqS9YEqzLYndwQEW0UXra00oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=I3MfbsXf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="I3MfbsXf"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBCktl995252;
	Mon, 31 Aug 2026 09:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XGhY6
	iEt/lOI/pwO2TMHQIq4uZGUxcdu983j/5g7VNE=; b=I3MfbsXfSLagKN5RBcC69
	jkbfdAk+8NH5N8cnWdWMIpu8HjZj1ZXMBDBK5a+3i0pIn8xWRVtRZLF6vivE/ZD9
	K+D6RY/bCPDYk+ppwp/7EgrWPtvciNWIfz7uC7fhe4TIq45s4BrzJQDRbgaFNy6z
	oWCA643C8QhhO6V3QqB1i024W7RIK1m7TFordw6mbLnomGsDnjBcW71UasHQNAw1
	KDZvb9EJGYPV3qwnRMc016BpNV2R1ni8ipbD09mELagcEbdyvavS6hY6MGuCbtg+
	4HwPnavMqnHQ5d9KwcYDDJ5QIlWXE1HSLiG3l/S4ZwEGxT0WsYJ/l+DEMO6ng0N2
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbvb2qnpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 09:44:04 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67VDi3Qc054515
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 09:44:03 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 31 Aug
 2026 09:44:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 31 Aug 2026 09:44:03 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67VDhglN004987;
	Mon, 31 Aug 2026 09:43:57 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andy@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
        <siratul.islam@linux.dev>, <u.kleine-koenig@baylibre.com>,
        <linux@roeck-us.net>, <joshua.crofts1@gmail.com>,
        <ciprian.hegbeli@analog.com>, <krzysztof.kozlowski@oss.qualcomm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stefan Popa
	<stefan.popa@analog.com>
Subject: [PATCH v9 1/2] dt-bindings: iio: adc: add adi,max40080
Date: Mon, 31 Aug 2026 16:43:33 +0300
Message-ID: <20260831134334.196359-2-stefan.popa@analog.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831134334.196359-1-stefan.popa@analog.com>
References: <20260831134334.196359-1-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDExOSBTYWx0ZWRfX1O8y684Sfh4D
 suFDVOMG/c2sZ4uot4USmGxnolMYz4tOVisZMl0i+m366AO9UeYNNpqYtK8w6tpeiIT87vDOhJC
 AG/sKyW+XbyMAZX5mvpw5okD+MiAZOhMWjTmSPvS0DbVbrVXDLVO
X-Authority-Analysis: v=2.4 cv=QopuG1yd c=1 sm=1 tr=0 ts=6a958524 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=Svqhk2N__qMwEp2CcvoA:9
 a=sptkURWiP4Gy88Gu7hUp:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDExOSBTYWx0ZWRfX0Jq/CGks8d7u
 JVzjgu38djsRLtj+QLXa3Q9M/Olcjkg2TPOONxBm8m9H+gzenkJI3oJpy4w+JrP6lEPz90cCBU/
 ShMyR1/NBGVuZXEJjycw3WvYh24PG4hQntnuOZSRkzOAtWEHaLrxpaHaR6nf1NRUKqdXsPHVyoP
 eml3XIoFCdcgMhAzDO0KAeXhH4FcoR1D2r2Dt4oNhCZHo0h9rqNegYgGfvg8NfTVkiR9F1kIYxS
 9GBAbZczZmlW0Kxfd/UpAiRIcMqql9qzb4+/CEZOquU6zlSZeHAuP8SwlQnSyDYTkJZlSnT2v4v
 eIOVsPaa8eowjyWHaMA6msiv1JupmHdvTUn4ykSNmWeggG3y1di4rjMQlHoAIc+mT2tiSha3Hcn
 iJ1lwY6W/i122V8kZsgvMSaiSQ8uQGRpXorjtQXAb//PaC3i+Ogj0uiJc+28tgrG1nlQxqEiBeQ
 pijGgqO5B74d0+iIgwA==
X-Proofpoint-GUID: OdXQmkMG4Hwv7kWz6_EDMW630CLBt6Xt
X-Proofpoint-ORIG-GUID: OdXQmkMG4Hwv7kWz6_EDMW630CLBt6Xt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310119

Add device tree bindings for the Analog Devices MAX40080 bidirectional
current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

