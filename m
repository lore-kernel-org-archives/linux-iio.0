Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678134E4331;
	Tue, 29 Sep 2026 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721888; cv=none; b=BXcE6l3xhmFFh49Qqu7l7a2qgQgn41rj4q58PrE5JEB0epdjlTCEW76UxNeIMIfQCVG409A8ZvnU9QrPdpZow2sH0bfqJ4T/AdgYq2SFxeYTyJ2JdELXI0+zD3P4ShlEKJiAARgB0liKPruAOP9LCLtH5reRBUX8KSE3Ft7mB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721888; c=relaxed/simple;
	bh=WYdPML9ZURN2TOcSaQLSC5En8VpduN5Ss1JAlMHwCQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ur7/ULw2/T5rGl1n1wqzvGzjCSU+LbW/12RPRAv0Xa1tC3r/qHRoI6AYux39cbhCWxMPBEVETcYrkKAYzlKPqjp3tCainzd7PP0lRMbxtd1MLpvYqHw/hHyRDmHdNnBB2Mp0gmx4Tr4RUAtRTJFK9MSZ7Z4ablNs8t+B4QmcUlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sOgrw8UW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sOgrw8UW"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TL3Fxb1297570;
	Tue, 29 Sep 2026 18:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vHgg/
	1qZsQSPssIzUgM7L/ZSZDmzONOpZxORDLzdh1I=; b=sOgrw8UW5WIMAQCpTejgq
	RWzzxCeif0vf+Qc2+6+jIz9NKZry1LaDNfrOUCYmngTL1/EMZ99jRfXgwO8nKUuu
	PUvoaSH2kCYIN7o06HT85R1JZuxTCkYyhDbRuFGHtUDP92JiMWgh5Ky7f/45eELG
	EDaZDDxopNPo/LY5mTH+MYGf8wZ+X9wusU5G+YyQTHuDDUpX9OKYOSRM7s54arUS
	sGyDOTKz7wrAWFhxuAAZ79JXr38IITfZH6cvvgvIEWK8tFdtJAgSgabiEVHE7shQ
	G0S10wFzfO5/eXsH1U5AIInAsd8V2wvUEno44N/3ipYD0o8lR/GmTYAW5nWEVXxe
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gyugbrttu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 18:44:42 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68TMifxS041545
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 18:44:41 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 29 Sep 2026 18:44:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 29 Sep 2026 18:44:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 18:44:40 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68TMiRHY008208;
	Tue, 29 Sep 2026 18:44:30 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 08/13] dt-bindings: iio: adc: adi,ad4134: Document SPI connection mode
Date: Tue, 29 Sep 2026 19:44:22 -0300
Message-ID: <12e5af9d96f6c5e800ad860d3cfa6ac8006a22e2.1790719425.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1790719424.git.marcelo.schmitt@analog.com>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX13nx+V1VokBH
 SK9RdVxCDFOgLfatQMish++iudi+jeLFIZfeNLXPsBMQJR/59nObeeWOJW2O2MQsfGP7xM5Hayt
 JWXdgvQxMKGaL/cCGLnnpjlyKVBLXf2uZkFOjrXilq169rrma3rMOODsJVxU1xpZKCaq86G2fb0
 KtkZiuqrI5eFKE08kCf9gjezvVJJ0qSEMLoox5lp4yngqSYF+F4VF5TfsIDE3sT+vz+NpwF94mM
 WGfrpjhkbEuveI9yIG7YdaRJe/9aIJRTODKpC1FxsIm+EQB78Xl2/l67+QQMxRmFSbj18SCNE2W
 MqYvrBu8hmli5adjqWROtG/Ana7Lbq9SVFwWeP3GaUTzMSGJBNQrqGW8ZcdPPeoNTAlggS7N/J9
 AAbUK2CHbANhGHksRZeyd5HyVanPzPnKXXOAR3jsKeIj0FfgtTDrungTd66WIu0zS3FNQcrIRMI
 z74eqe1fsPWZ44acX2w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX+sEr4s80AVsp
 RtW5VEup4xZZzKscD4hFfK3/ENBa3Gj7jB0Wh0YElDQAW82Hmc7F6r4ZO5jBPf5HWfy7KlPbooN
 SLhfF+QrZ6KDXo/FUawVA1DJkbs3l6KwRPl7ae4a2Zo/OcyNYytS
X-Proofpoint-GUID: zVvrUuAKWpLY_frDn6frhyY8J9iazMaY
X-Proofpoint-ORIG-GUID: zVvrUuAKWpLY_frDn6frhyY8J9iazMaY
X-Authority-Analysis: v=2.4 cv=Eexd0/mC c=1 sm=1 tr=0 ts=6abc3f5a cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=DH_SYrm0qA8J76jfPwUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290090

Document how AD4134 chips are connected to the host SPI controller
according to different wiring configurations.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v2 -> v3:
- Adjusted spi-rx-bus-width constraints.

Unfortunately, I missed SPI connection mode properties when introducing AD4134
dt-doc and the device driver defaulted to a no-CS configuration. Due to that,
conventional 4-wire mode can't be made default without leading to a regression.
Still, updating the SPI mode default to 4-wire is a sensible thing to do later
on if acceptable.

 .../bindings/iio/adc/adi,ad4134.yaml          | 51 ++++++++++++++++---
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index ea6d7e026419..0b2a2cbfadae 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
@@ -131,6 +131,26 @@ properties:
     enum: [ free-running, gated ]
     default: gated
 
+  adi,spi-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [ no-cs, 4-wire, one-channel-chain, two-channel-chain ]
+    default: no-cs
+    description: |
+      This property indicates the SPI wiring configuration.
+      * no-cs: The datasheet calls this "minimum I/O mode". In this mode, the CS
+        line is not used (tied to GND).
+      * 4-wire: Specifies a conventional SPI wiring configuration.
+      * one-channel-chain: In this mode, the DOUT0 line of one chip is connected
+        to DOUT2 of the next chip upstream in the chain. Only the data interface
+        of the upmost device in the stream is in direct connection with the
+        digital host.
+      * two-channel-chain: In this mode, the DOUT0 and DOUT1 lines of one chip
+        are respectively connected to DOUT2 and DOUT3 of the next chip upstream
+        in the chain. Only the data interface of the upmost device in the stream
+        is in direct connection with the digital host.
+
+  '#daisy-chained-devices': true
+
 required:
   - compatible
   - reg
@@ -141,13 +161,30 @@ required:
   - clocks
   - clock-names
 
-oneOf:
-  - required:
-      - ldoin-supply
-  - required:
-      - avdd1v8-supply
-      - dvdd1v8-supply
-      - clkvdd-supply
+allOf:
+  - oneOf:
+      - required:
+          - ldoin-supply
+      - required:
+          - avdd1v8-supply
+          - dvdd1v8-supply
+          - clkvdd-supply
+
+  - oneOf:
+      - required: [adi,spi-mode, '#daisy-chained-devices']
+        properties:
+          adi,spi-mode:
+            const: one-channel-chain
+          spi-rx-bus-width:
+            const: 1
+      - required: [adi,spi-mode, '#daisy-chained-devices']
+        properties:
+          adi,spi-mode:
+            const: two-channel-chain
+          spi-rx-bus-width:
+            const: 1, 1
+      - properties:
+          '#daisy-chained-devices': false
 
 unevaluatedProperties: false
 
-- 
2.53.0

