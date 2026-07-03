Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00FA312815;
	Fri,  3 Jul 2026 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074632; cv=none; b=smom59sImm0FVFfw3rB9prFcT2VOJ6JtTdKH/mZw1FPCM7sQIS0dFlisZhIinFNkiueYjKLZ5u1W0AcJxXp1YFnGZdfm8jh/9+H/f8Th/nM+OporvBTOXQCFAri+bHDrzVay3nK+CNJDgTFwewmamgqUqM3OXAkmHo3BhGt9mtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074632; c=relaxed/simple;
	bh=anaPIvFgqbVPLi4r8MnfyYmKHbGty4k3JC2BXwtE6NQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxH96xjtoldkVfHzLqL9jH1UARcLW/UZaV02nN4QD8TCKhIbYRcVCvSrGF/inqxaoiMJwggP7Ri9PPkT4G6ZhytxLA3icgGLNJgLsrlqOmpxEq/ObrteQUFsAcch7h2BPWyHPzYaReXsa8zDszK8hTdZDsoe9JLhQex3Re48EBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uGTYcqLv; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uGTYcqLv"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635vqZK370717;
	Fri, 3 Jul 2026 06:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Y55E6
	8iecgu3RwCWAfIikvJxMdykb6lMpDZHUfb1GRg=; b=uGTYcqLvZAgX5VTDJs8Z9
	2t7OV1+89WYzwXBpvenjm3hklXZh8GK1VKFd+nfXQChh/xk9QN8y/RTD0wid03lK
	cXxSYn+DcnHPjwSkJ9mQI2x9dmgRGx4Hk5edRwt2t6Vh/L67igvV0iNPFaM83OjL
	KxmiCW7HVUPMJcgiFHoWk5xvXMiArT0R47TSyKa/MV0+8qyac4aylCKzDT5mZP9w
	MsOxPzzcv52gQqPeSjIiDQ8DAEjFK1h7Mol3UKBLwutbpsdXYJSnJ7bFdBAnT0h+
	7029+4hjFX9ShTG6HkUGhxxsZuEpQEW73OSO+BuRHw5nmMo0uPFhbgBsZnRnGwOE
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4f648x9rug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 06:30:26 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 663AUPkU012235
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 06:30:25 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 3 Jul 2026 06:30:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 3 Jul 2026 06:30:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 3 Jul 2026 06:30:25 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 663AU1SL025379;
	Fri, 3 Jul 2026 06:30:18 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH v1 1/2] dt-bindings: iio: adc: add maxim,max40080
Date: Fri, 3 Jul 2026 13:29:31 +0300
Message-ID: <20260703102941.1141341-2-stefan.popa@analog.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703102941.1141341-1-stefan.popa@analog.com>
References: <20260703102941.1141341-1-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: fB9trQbMVi7dR1sfEUgkN_833PLUnE7n
X-Proofpoint-GUID: fB9trQbMVi7dR1sfEUgkN_833PLUnE7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwMSBTYWx0ZWRfX5sZQ2zgf2U7P
 pC0lalQfl/ZWo2TwfIfhU8UbnPxIsKrpvDy3pS30fsqR1z/X89PnNvuRSYo4/lrZToX35Hpp2fr
 JNGXWQckZFh2AWlUttEOVSZbOkZ903nQqAvZrr6eOhsbb3uW7oCh+iiwer7XQ+CEnv9HdbRgnUv
 fiEao/8NGAW7CO5GITd1LyjxYCIImHNdrrU265bl2ekSlcD9LPUbevY4SFlsnJCoDQ/lTxxx+Zv
 dvl1ZnuoDFfpanng8xeRPJkUDR+9fwTCWx5BtZLuh9kfD41YPHM9imIYJ4S8kUIh4VMmU7iMFxb
 2m0sccvPx34dMG5Qy3UGxx3peuoZJDzHmP3XnqHWWVWtFHafr4f6A1dQhVFBRmEeKoy6P6fAr+f
 +lfUg/eITdbVmHqpqs0TgwhGe5XOFXApEGikCTirAWwt59Y5XaeItTZnUSvMbltCdlim6O6N5iw
 V7Fse9L3bN0j9OK92ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwMSBTYWx0ZWRfX3OYCi9rcTfHG
 vzCPQFpjTnpdnbmkz8uD6GjVFn11fESUvDPk9cZtC6t6Lk9rV4M8uyVzRhTDQv9DrVhMPT2+zmm
 1Mhg+PPzIIG/UYrqOfLkEgy8JM5qNFeVnDkbSk4Hnkp09ZUDQmfT
X-Authority-Analysis: v=2.4 cv=Au3eGu9P c=1 sm=1 tr=0 ts=6a478f42 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=edEkJmESHCq-kgOIXrUA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030101

Add device tree bindings for the Maxim MAX40080 bidirectional
current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../bindings/iio/adc/maxim,max40080.yaml      | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
new file mode 100644
index 0000000000000..4cda6cea6022e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
@@ -0,0 +1,55 @@
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
2.51.0

