Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588C381EBE;
	Mon, 13 Jul 2026 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944189; cv=none; b=NIxpMwjS/nGYUA3+dH3HxEO6APD1/1iJi7VAYrDK/eUOjJq7m4aIfnrvX9rHJOGjvvKBekmjNhWpUwYH8Rp0VYeVIgXeFfJElD+C7LePuE5jVCtVPi6221wlhpRxzZBC1bcXrNmml7Ce5NMHJhSMfjB28n4FzD6FbGpA6jliarQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944189; c=relaxed/simple;
	bh=c5ubvh6jPLUECqyZfN/IfIWDc29ZiV9NbwpW8dK98n0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gc1nGigEV9zBEOYPq0UuX1r+Rw6l+yXH83vT3AyY5J9cZ1KYove3dWh6Y3Enje64iY/rBDtgtsrNYuGBisPPALzSEwrfOpRB49nqPdrUpLsQg7ItnBh65tvfABWGQmqEiCai8/JfCSNaehWKmgDbSFwyWWevU9ZdWHIXct5gvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lwiP3jrl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lwiP3jrl"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DAETOk3315850;
	Mon, 13 Jul 2026 08:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6PhwX
	YPY2FsQ6/OMwC5G7wWVbpIgQGO0fpTerN3F/Ug=; b=lwiP3jrlmQD8FZK3pcuuc
	MD9whMa64CW8lIGoFrTBzSw1prOGlz3qjGgmkhj7gQm59vHZ09qhd5i2HAyvlzs6
	jZA5m8Nyddb7D7dXajxLChVmJHw2uHo3m0QRMSehmXSoHPD1UObU+IMw7ZgOHje0
	88MRkM6LHfgE3fvTx6juPZBdTUZPmDDsb8RBXD3otRa4f2pKIAu2kDrukcY6ydBR
	4HOKh43au/LNeZAKKlyWepyD7KD4gEPDMMhorC9W53djGKJII83z42cle+BMdhHS
	ZptT94195gLpwnlMe5o+5L6HB/PLjaalB9PJ7ygxQ/gYZfUnr+Q9XUvkqPqwkMzi
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fcx3a8b24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:03:01 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66DC30EH014416
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 08:03:00 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Jul 2026 08:03:00 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 13 Jul 2026 08:02:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 13 Jul 2026 08:02:59 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66DC2aSg024385;
	Mon, 13 Jul 2026 08:02:53 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Siratul
 Islam" <siratul.islam@linux.dev>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stefan Popa
	<stefan.popa@analog.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: add maxim,max40080
Date: Mon, 13 Jul 2026 15:02:25 +0300
Message-ID: <20260713120226.90303-2-stefan.popa@analog.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713120226.90303-1-stefan.popa@analog.com>
References: <20260703102941.1141341-1-stefan.popa@analog.com>
 <20260713120226.90303-1-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfXwX704tZnlmE5
 ZfgZQf3d6uXwlLH0Gy7uA2W7RbQNdo9J2r6m7CsrVSBhJ0Yb6yUOUGZokxr1APjpQIVNhELdej3
 HoLno72kkuqCJzP5YB7UF7h3lxoq6VTQNMwS1WzaSwk8/X28KxBv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNSBTYWx0ZWRfX+JCJiCnNrxAh
 2+aiymGkmR1pjQj3aLLLo3PEkS/+CptCySiNCbS/2FKu7xoai7Z+dcDQ1eCq8HeH8BwkR/cXKOZ
 JfzTltP1xbYoySLZWz6yKlUWfrggy+4nrtas/ntDJWQFCp15Mh3Bjm322OJ6nIjQqveWKMYXsPu
 z3Gyk9/xnG3UPRRWpPvFu0JogHxYKYx02ZNbKAeeP9ZQQHChIX2SD90hIZ9LClESn/aMoLuIU3M
 yfaERBWWugSp6vsF50Tvj9bgw2yARkNchF+MrKkZIzlG3tl5UfVrlexx77mo2RDbPY04Au1fMBA
 JlKiJkTLughdtOgEYmdLJrdwp86fltiLxFiayV2aUorKCPGmDqSEJa80EGq3S9RD0GGn+lI7OyJ
 IHsYrOrg3hYNuyXfa97wH2LT6O/7Ohw3F5092r5CRmNWXDkeqj8eml62qV3HP/vmcB7chkAanIP
 hoT4adaS9YJoCcbshhg==
X-Authority-Analysis: v=2.4 cv=J8CaKgnS c=1 sm=1 tr=0 ts=6a54d3f5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=edEkJmESHCq-kgOIXrUA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: EtdhPM6Yfou-aHdqNpwOg41RHdY8pFby
X-Proofpoint-ORIG-GUID: EtdhPM6Yfou-aHdqNpwOg41RHdY8pFby
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130125

Add device tree bindings for the Maxim MAX40080 bidirectional
current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../bindings/iio/adc/maxim,max40080.yaml      | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
new file mode 100644
index 0000000000000..8a57075a7d273
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
@@ -0,0 +1,62 @@
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

