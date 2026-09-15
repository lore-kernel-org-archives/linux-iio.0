Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01937353A6E;
	Tue, 15 Sep 2026 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499712; cv=none; b=GqOtWBxbcuI+kfVLsL1xe9j1UZ4lIlH76MUI2x5fl37MtfHDI7iXhJBBM/ybTAL0Hs/0A6zyq1xVvRX0rbln31AoNPQp6hUXqMm6FBXmiTlmf+7U7fWWffT+CHszHNlpl0SU6exSaPp1y0+5g2nph4eFQw9Jr3h0EHSThPWwu0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499712; c=relaxed/simple;
	bh=NU/MenHxcJwemjm1O7pbI9Uj+Vju8j9XKmT77bI0/4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b78TqbdPEiYM9OZiq6FJh6TzDzKD7VsGFrdd9CyWHeC7/O5zk7Gi0tOo0odLGKcNCAWd4ZFeXUG86qtBf5JJ2HTXmSuZ+xMJKRkfFKc7vfcIapUJIfTVhVMIf4sncJa00A4vdxxzcdvGfbQg0bl6AJG7iOvcYeaoFTqJMqsdHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mDF7t5/D; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mDF7t5/D"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FIsZ5Q1279593;
	Tue, 15 Sep 2026 15:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uB4eb
	wjCLTAZvvq6/WgpbrMgxI0+Zk8/oPZ6JNNmqeM=; b=mDF7t5/DET7tpbG05Rx0p
	BvQ8WzTKu10MgGYYXmBDJ5I5wnhzGFAVnbpF/kgyGj7r66S1i015VO2Saz6lvmLn
	GDu3gj8OvzHHbEP9i1+Hq/xEhL0Q1telG5JCipN176bDKjUTz4LykQUQdGNngNKZ
	Iy+gZAHsm1eV1DGtZ0gj2RWOGnuR2swl1a0cKqvXNTdiyi0SNvRs6NtcRIOSFJWy
	4dHRXqskd8TqwKS3IPZz/+YsOrO8gAA2O0CNSxyZup2kPZUKiLyxFtDADdlYWa7A
	lwkBMTBhQo9DnelDU4EQFesRAUXnC7KtOxLDF1r0yMKHSv89SdHYMThLJbRA5Ine
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq98c0ua3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:15:05 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJF4Rf019402
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:15:04 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:15:04 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:15:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:15:04 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJEoi5028165;
	Tue, 15 Sep 2026 15:14:52 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 09/15] dt-bindings: iio: adc: adi,ad4134: Document SPI connection mode
Date: Tue, 15 Sep 2026 16:14:44 -0300
Message-ID: <304d10f12a3418fbd5598160609a6eda09ed4100.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX/mafaqfYiXTS
 qKF2zY+JAzvkWAyjAAYyrZ2jwGc2UgTdhYh/ILVkyotepIi7qsq8IiL3aHyXjOo550xHKQpX2KU
 9jLHlAG16xvfGP7ymy0B7duxI7aHfhPqGuqV2erAy76KY8bZ1ZMi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX9ERV3YZPrfyj
 pGqFBwzZFV6rJlMzeMj87QY7qvEpW+VBDXFCgzIxuDhoElaHJ4ltCSgzvAqY7v738MXagxuLMn8
 KecNMhBino7q3NVG6FjxYO0Cvl5hVFissm5Ge+7R4FyeXph8fO1Lr8WgSwLkrJfzjkIj+G8RfA7
 Sbo5tqXltGod+wt5h7f+Wq1OntEsXSouz1Hzi55pNVhvcOEaVgEMfGufnXaVrV0OPWZV9pL6rOy
 0FecjXhUsPZFE2WWhKCp0xhc5eoY+LmGC1eSAUdvx0xidwXn8MUk8UYJnZLAQjkfOua2aSVONvY
 LKDpTQAwqCWQD2OoD5vAvZksPogO3uyQ0q0pAicpVymfGIlQFLfMUXoZsNlyrNuI46b/Tb1cwiv
 +gsgjd1oCEI77GNriU2KfzkS/Z//yiw4X/VVXQSeFqdX9PCKXAD1M5win8L85L1HcjJ1bOJzm/P
 MbcILTIlaimhjL9PNvA==
X-Proofpoint-GUID: 3LPx4E3B7i3QZpR2ciRbC-UQssDuPhfh
X-Proofpoint-ORIG-GUID: 3LPx4E3B7i3QZpR2ciRbC-UQssDuPhfh
X-Authority-Analysis: v=2.4 cv=KKvPn1Fo c=1 sm=1 tr=0 ts=6aa99939 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=GM_lWPo1lvwkKjjvybcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150280

Document how AD4134 chips are connected to the host SPI controller
according to different wiring configurations.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2:
- Set default for adi,spi-mode property.
- Added '#daisy-chained-devices' property.
- Documented constraints for adi,spi-mode + #daisy-chained-devices combinations.

 .../bindings/iio/adc/adi,ad4134.yaml          | 51 ++++++++++++++++---
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
index ea6d7e026419..012e09decf7a 100644
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
+            const: <1>
+      - required: [adi,spi-mode, '#daisy-chained-devices']
+        properties:
+          adi,spi-mode:
+            const: two-channel-chain
+          spi-rx-bus-width:
+            const: <1>, <1>
+      - properties:
+          '#daisy-chained-devices': false
 
 unevaluatedProperties: false
 
-- 
2.53.0

