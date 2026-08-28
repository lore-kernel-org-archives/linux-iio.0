Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3F431B823;
	Fri, 28 Aug 2026 08:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787905953; cv=none; b=kdkRh0m7+qDLoZSjatHaRPgLiuxap+IlUtjkEJEEs1Uj4QDfh+2lGWlnGtRynUUHmPNM7KETVXZRtr75Y1Hegi9Zlq0D8/oOYpJfL/eJFunhfLuALhsM2TZIrMy4335vZuxpvDnmwKGEGvTkFASxkPITBJAAjDdSZbRzTk6FYmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787905953; c=relaxed/simple;
	bh=N/67PVBB6uXLiykMDjP+6dwlPABcykvKDgRBkTLMS00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9C5b3JjyHBE+3UQu1e5E5DvWhmVg2VeL9j59UMcpK8DMnjEz96o28al9nV7mmrbhGBF4fZ5wvSHNhlU7xZHrIY6CEgGEdS+SQdzx8w+ZChV6xDuZXuy/jikKnOKasWE+J2jugfg+wA9YDrTTX3+FNvKlZOwZWYZPLZfUu2v4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1OBf6eAM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1OBf6eAM"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67S66xJM1074046;
	Fri, 28 Aug 2026 04:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XGhY6
	iEt/lOI/pwO2TMHQIq4uZGUxcdu983j/5g7VNE=; b=1OBf6eAM0IF8rr9ldcVDd
	iDPCL6VKgO/I5RrURVRr6dBbzo4rLQprxiOL6G/ieA5K92yikkq5noGFePMcNLGg
	zqmf+VWC9QNvYdQlb2F6vJCtPXcP0HFSdwNcX05uLnDDeX/lQJiwVxDP/oZ9wuLL
	sTzY3/BiRP16Ig4ItEEhIKCcY+CeGnpJ0yEo/B9be3NRYUAMSK40clpTh6h0/Fk/
	Vxl/v8vsM9/5iPRxdWNSRzjvNIoduUbNB+YQ3n/HjQOt7kcoP61qCIQrpgt+ZMr1
	k6uYo2RD+4lkdO9uaq8HoKHD8n7DXwOvPr3k3AG0roNPro2yH3ZhKws+vaxbR0dt
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ga1m11ykv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 04:31:48 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67S8Vkfx060961
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 04:31:47 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 04:31:46 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 04:31:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 04:31:46 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67S8VQ5c029508;
	Fri, 28 Aug 2026 04:31:41 -0400
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
Subject: [PATCH v8 1/2] dt-bindings: iio: adc: add adi,max40080
Date: Fri, 28 Aug 2026 11:31:17 +0300
Message-ID: <20260828083119.54495-2-stefan.popa@analog.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828083119.54495-1-stefan.popa@analog.com>
References: <20260828083119.54495-1-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: sfWGfEba-Ius0goyXeYp_wIp3kjJFnWD
X-Authority-Analysis: v=2.4 cv=NtLhtcdJ c=1 sm=1 tr=0 ts=6a914774 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=Svqhk2N__qMwEp2CcvoA:9
 a=sptkURWiP4Gy88Gu7hUp:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: sfWGfEba-Ius0goyXeYp_wIp3kjJFnWD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA3MiBTYWx0ZWRfX0vCnGvvxt/E5
 BszGivk+u0C7bZsL28An1cZXgOLd4CuIb/ZX8Kp9Bh8vA1Ryap4sZrYdwfLgDvd4smk5fZ495e6
 50rB0HWhIREeKzIfO+pQgKmtnKFhPVGIE8WJhq28Uo+paiwiQJLQXy9/rffroAvkgvbjvLOkJkI
 jD76pnFy4mn2tq+88KQlS8PwXIYEcTRZNUoi1IuuJWdLnv2mJ9i6Ae6iMCS2fXOPq73xKLFGxIH
 uJh0LvJDiVvJHIq12L1ZqN7oNNI+IufBmJz6C94diejDx7XfqeWzZAmWem5L2rmMiOy9QOmeXTa
 I7CIiOWixz+6htXFxE6Ji0GJ2KWhY7jpPOjeB6yCxBHxXmiHI7+Msy05DFs1upgIGGg7RR4FCQV
 RevRn4ldbZkFohY8yTfXfnI25MYl18GAffIwQTyXg3Fo5lYw2ot2UdLfAuNUfZz8NJ2Ctn9K1No
 SwGQDhQkbyTmIpcKqeA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA3MiBTYWx0ZWRfX1Jw8bWOQsTFf
 10HOAG2CwwS2WoeI9YzFPwW1pUG6Q0DQrhZEzriEeTH/Q11BJDpnDukVdbTeoIgAFn+u3qAl4YK
 dwx76Iigjto+8R6bhBM5IPksue7i4rCWyOEKMkZqAN1XM2llJpmw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280072

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

