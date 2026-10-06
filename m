Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5B395AC0;
	Tue,  6 Oct 2026 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310721; cv=none; b=aVpbibBUmtNEJouaK8X7h2xahZ4jq7xOeuTfSex7p65SFBC1CcHAXAD7BRQJ/cxxRuuGmnuDekT35V2a428HDAb/4EtTShKmoEaDig3jqZPFF/LWMu95k4RS4xu8ieGBN0NTWT10NNmenva3K3EjT0DJrXlgPeipVuwJkwgQgdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310721; c=relaxed/simple;
	bh=G5B53+VcKQJnmEPxUkuXJvDLC2mOCLpjCcM/qcz3+N0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgSZAm9oMDlxkA7eGLS+z0NCGImfcQem/chZPjoxxLGlgSpxGpd3PHH6T3jr9jrZUCorlhnYhOGRE5LfjbQqZ7VFFK79fXAiBd2R+OdmLMUDShJp3nHtE/b4grtBAgCnAtQ7hCEesPbrA4l4CO9JN8w2C/SEzjkj/WX/dritghA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=oeHwJfqD; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Eafv9DYh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="oeHwJfqD";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Eafv9DYh"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696HhkPo2853358;
	Tue, 6 Oct 2026 14:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Y+DnL6OHiRb3tKY4vKhSBPLa+Uo3E9MTjKSpCJgCinY=; b=oeHwJfq
	D0cigvWOtgCImDcDtMV/ik2nh33BlU6rtwsH6Z/g2Uhg0UeTiGh9bkOHGiarlgko
	Jp42ThY+xQmCujqypl4X5b7jDl2i6OCajabhScF+aqn6wRwwCu03NQmrknWWD489
	mpk3Vbdv+Jo0j23sYZFlXRDJT/JiKuXE8SFWMY2+t2rn5Q7jSShdF0CIAis3iPOZ
	KMknAqi4tqD93/W6r6FZ5qvHbY12gZyJgPjadYNFus25ZKyihv2C+JYRjHW4xlIg
	PTOFs8FWs5lIdBdyWxVzO32pgnM/bCYC/CYiHf9nxTLTV4bg+SQhkIPCJZ9Jt7ve
	5qixaO6n1qorFUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Y+DnL
	6OHiRb3tKY4vKhSBPLa+Uo3E9MTjKSpCJgCinY=; b=Eafv9DYhfA7cOJIPbKG3a
	1ENRu1PTj5CDwdczIUp/HvDK8H46+WuodkM3kHYxdVqAX4nomJL5pgSwF6vxacD3
	Guce1To+ItDpYQKQk8Te4aUSZpMTAjxKYYVIJQH0KfAriAkri3Y0FPR9wHT7NOG0
	dmznJbBc0H2G7Md17wdoGB9K9LPNjeGAoYvGupkOepHAxExpow32nfyjX2QKpEHW
	rBkGsFm917iFPsCgg0Nf+LDIpoAOWfIgxJkWvv17bN1AIGV6ujHGlfVoGTA3tnbS
	jYGhAIkPWgkIKRenhrAo6vWT6YOI9+Iz2ay7E5ngEYz84mtikmq940b11MbH4e5+
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h4j2exu3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:18:35 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 696IIYIt021706
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 14:18:34 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 6 Oct
 2026 14:18:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 6 Oct 2026 14:18:34 -0400
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 696IIKj2001022;
	Tue, 6 Oct 2026 14:18:22 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 08/13] dt-bindings: iio: adc: adi,ad4134: Document SPI connection mode
Date: Tue, 6 Oct 2026 15:18:15 -0300
Message-ID: <6afeb3fcb39f73edde5f39f6f37a1ecea5523319.1791309733.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: fEpXT-rBH2tAvTsFIxfYvQm_c-XvQQoH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX8LxsmPoViYRL
 j25RMcE6Y9Sr+MGu6EwJy4qzOwqzBgKzHakJhOwJepaDU5hgRNBQns9DpGfQdjyfZv1SUz5F2UV
 o9DuJKpKXMUeeWU1MENu/4IBs1fOAcVPXq/+eFgqpYASaeCG9WZOwAJx0uJNm5TMZXZ+AGj+BdH
 yOVtZeuEFowlzGf0AKA2ih/z5Oc4shDb8WZtDomA5+YTkiWl18shd9sd1LpHmAZHXTK21XLOLpN
 lD3JJZzjpbojGElAiyPQ4O/Kxm8c8Dwn6/KCeKEVn7qL9PumrzCbXVcgFtIV67IhJ/f1kxMOl45
 Tt/u/+uqSVdPY90C2wa9kulma2dQ2mBMD/gRAYBajl5mEIWqqw0z3Sqzdg6+kIujzeAmObpPH6c
 uGawy7IOIh1VsYPZbyAhXm68Ti9E1iS1WTMTWtarXc2aSIshlx/HBhr7DfXw9r9bM8VDUFFbJg+
 OH/30ct6svABGzvEXIg==
X-Authority-Analysis: v=2.4 cv=JvtkP84C c=1 sm=1 tr=0 ts=6ac53b7b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=QDE-kpzY17d1dOg3eH8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfXxQtd6WD/8Jb6
 jG+7pG0A78lnujFHUJDt3dM/mdUK5qTOepxCcVeVkuaq2l6LSWHURA9DpFyOhWJh3NVOvifNAzb
 pBSIDEiclyn0znnLv9P+ISZsQUTztmuCS2gXDsizZt2mLlZlBgG5
X-Proofpoint-GUID: fEpXT-rBH2tAvTsFIxfYvQm_c-XvQQoH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060072

Document how AD4134 chips are connected to the host SPI controller
according to different wiring configurations.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v3 -> v4:
- Properly specified vendor custom property, avoiding 'too few spaces after comma' warn.
- Correctly restrained the value/number of spi-rx-bus-width lanes for
  two-channel-chain use case.
- Improved the constraint to also prevent specifying one-channel-chain or
  two-channel-chain without #daisy-chained-devices.

 .../bindings/iio/adc/adi,ad4134.yaml          | 57 ++++++++++++++++---
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index ea6d7e026419..970e7adb2405 100644
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
@@ -141,13 +161,36 @@ required:
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
+      - required: ['adi,spi-mode', '#daisy-chained-devices']
+        properties:
+          adi,spi-mode:
+            const: one-channel-chain
+          spi-rx-bus-width:
+            const: 1
+      - required: ['adi,spi-mode', '#daisy-chained-devices']
+        properties:
+          adi,spi-mode:
+            const: two-channel-chain
+          spi-rx-bus-width:
+            items:
+              - const: 1
+              - const: 1
+      - properties:
+          '#daisy-chained-devices': false
+          adi,spi-mode:
+            enum:
+              - no-cs
+              - 4-wire
 
 unevaluatedProperties: false
 
-- 
2.53.0

