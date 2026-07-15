Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F5D448D03;
	Wed, 15 Jul 2026 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115725; cv=none; b=Ji/QnOy44SCQbsA5AI5aOPCDQJpXFmrPIHCx+pdb1eeMSG7GQv0/4lWcChRcvrBCBVcatU7MuEYzXT8R6igmhSiphF+gJ6HabN0nJ3aETtHkgYiWXyRDowADQwBAC9hOi2myWKRYfTBFrLNPJ1+FWfgFV7VJx8ug4bfueuxqlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115725; c=relaxed/simple;
	bh=21OJd7m2egWDVGrGbW/ZtbwclJwnKRyz6WrrkqTffk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=q6lvKPfYO7baIW1HUURAkDuE+d75ykcOCsI6S17Ce1kneRNmUCJd3Eu36Fi2H7qoPbkWqEoKDjF7vQJCENoBLH9/cq5thPGxzFwk60cMiuKozGaE1DCLacB1MRNQchtpkp2aJ35K5eBI25J81ebDv9VH7CpqzeffEl1ku6N+RQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ti9umuQ/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ti9umuQ/"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBZiNr874876;
	Wed, 15 Jul 2026 07:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=twPuT
	N86UO5XovlX18irC14nN3OHnXtDsxjEQaT48fk=; b=ti9umuQ/JNEpYlWNKIj2C
	LYi7mmw1wcnTzgO/72BRnXD04GHkspvL+sHPuMBagdne4KQ3Rilb3ZWY/mwJOWsq
	mfIefzjBS5V7R0Jm19CAqrhFhCocATaTJZN6BKaEQ37VfvnteiYBl+h2z7HqrWtY
	/fWjJGaAE5v2tGhpsz+OTrUcGiieqk4aPRLrVmnA1xkHgMEW9q/yYhH8hVGYzZf5
	IHcEWNjeeXuB/CwOZic0vDirx+scReAiNS/zu/OTG9Z7V5KoaNDiBshiH0hjNCoe
	A4Cf9qGQi6VD9FNYjHy7IVEFLIcrzAGNiC9rRGm83W6tCe51Y9EnDtLRMD8h4s8Z
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fe8a88845-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 07:41:41 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66FBfeDe004902
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jul 2026 07:41:40 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 15 Jul 2026 07:41:40 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 15 Jul 2026 07:41:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 15 Jul 2026 07:41:38 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.54])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66FBfASr024964;
	Wed, 15 Jul 2026 07:41:29 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 15 Jul 2026 13:41:05 +0200
Subject: [PATCH v6 2/5] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260715-ad5529r-driver-v6-2-cfdf8b9f5ee3@analog.com>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
In-Reply-To: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>,
        Marius Cristea <marius.cristea@microchip.com>,
        "Marcus
 Folkesson" <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784115670; l=1698;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=21OJd7m2egWDVGrGbW/ZtbwclJwnKRyz6WrrkqTffk4=;
 b=GbDT4zivmoReHlqy9eOVRGUfmruQ4LexRQW/nc4XHiWv0pJKKtDTBUlefVP5hxhR5rC6e4T7y
 xzV/Bge1dZUBmJNWzXcOzhKW//m27WGB8J6G1Fi++F8q0N5OTNOTPWY
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDExNSBTYWx0ZWRfXx4CiunAPUsMN
 nHUWr7FE/pCCyj3JvpqPOn5Prm9HLezqlkW+X9yXytpAfKGbP5+ngCKXr/Qzf9aROTpAb8cxHaU
 L27kKSyASrXb9VarPjyTGWYFSklUFQYBH+FtUc366WUf4D+ntKbjrLrBXc2ujYWtoMi3AE1E8kE
 SUgYOPtSCbYWxUhWbyE0wPJRcfuM2XY2Zn8sWhO0RQLNE4VdLhzNBJjiwyQaKuyzipVJpsYPUPY
 a9Dd2KCIC5IkH6z6lJYQSA+SYBe8BHmlsoP5Ema1FZsrQo5ZtB58nFs5RP1S5sgDP8U+vq9r6uZ
 H39xAr4jD9UwBrVOAm7cIzZmHArJUA1+QOHL5fIUapZopRFxiEM3wYzIfd5a5UoS0yjidRp4s8S
 x2yNaSJPlSo+BO9KWw8ZwUR1BurKvARTlpa1TjpWsvHx2alrDVximDfg9aftc/W7zukJuPTOh8Q
 A3M6/oq1ySDb7VgQhFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDExNSBTYWx0ZWRfXzkXIaUIyJdgT
 8QdVRC7RWRSavzLFH7R/kZC3GtHf7o70QP7kbVvI2fYveL89JVeQeDMeGbVjbfecgQgvNCwNila
 Op2LRP4JgmXPTykB6MhJhTxiJtvYOFotZmjg7vxgIvY6wonk+Kim
X-Authority-Analysis: v=2.4 cv=R4sz39RX c=1 sm=1 tr=0 ts=6a5771f5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=x4a6AN7Hyicx1yu3BJYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: oWXlvGnF1D_Ak67dhXWjNDXJ-LBNQ-vo
X-Proofpoint-GUID: oWXlvGnF1D_Ak67dhXWjNDXJ-LBNQ-vo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150115

Add the generic spi-device-addr property to the binding and deprecate
the existing vendor specific microchip,hw-device-address property.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
index 675319276197..02bb198e9fa7 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
@@ -80,6 +80,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
     maximum: 3
+    deprecated: true
     description:
       The address is set on a per-device basis by fuses in the factory,
       configured on request. If not requested, the fuses are set for 0x1.
@@ -91,6 +92,11 @@ properties:
       clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
       which is first one on the wire).
 
+  spi-device-addr:
+    maxItems: 1
+    items:
+      enum: [0, 1, 2, 3]
+
   "#io-channel-cells":
     const: 1
 
@@ -123,7 +129,6 @@ dependencies:
 required:
   - compatible
   - reg
-  - microchip,hw-device-address
   - spi-max-frequency
 
 allOf:
@@ -159,7 +164,7 @@ examples:
             spi-cpha;
             spi-cpol;
             spi-max-frequency = <10000000>;
-            microchip,hw-device-address = <1>;
+            spi-device-addr = <1>;
 
             #address-cells = <1>;
             #size-cells = <0>;

-- 
2.43.0

