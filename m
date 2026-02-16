Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6956431618E;
	Mon, 16 Feb 2026 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254724; cv=none; b=o1HF5y4Um5Ij2nWx3jZfgkQOTG8vEve0NF2v4DmUk7IU5DowU4uhrkE8xDffgM6nvewhzHXzipehfpYGyl9aQY/yrVWkEOpg4/jfG/PP1V5PM++bKtLjbdJN7qKwRBNw6cgJQj2ChyXHzOSsQuYzuUoIwR8PSqS2/ZB/d7M+8oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254724; c=relaxed/simple;
	bh=Rs2RsRzCEUsNSPjveQYX8SMZqiaHcgQqLX/mVn2sAno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVFHvotsR8fvWi8nCOVJyC8eJmYbwqFSUG9Dt+Ro7Zll/uQgQN6EqANZkdB/x7eXJLPmIfHU5aw+0K4KexB/Q8qeF7Y4H95RFDE7l6+3SFTb6VrfIV9NIEsN5JdewUJHSKmXfOs2w/IPcgTmCMKYPYjLS+I3lEwf4rXtoI9uvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SnDdhEQ+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SnDdhEQ+"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GA8oI33758210;
	Mon, 16 Feb 2026 10:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XE3L+
	ARvWJpG52M6JRyudID7XngcHcscykkHGC28CsA=; b=SnDdhEQ+L63iJwqyrtPgM
	hhMgVmDyyYAnrpLYoycPIdaJtztAlZxreg+wmQAjli9OnQnhpRo8fN9dDl9KXfcl
	EwF3lHKac/5rwSWYHCb1ffNIeuLihgoNxkKCZP9Za27HB5WPfbvDRbrR2OBO52Bg
	c9l6eEDKFj8/6eAi5QwsBe1fmTuOiXq/mEbfQNNHGvNL3tR4hlGdXJIQ0P/BC8fF
	x7eHeJ89tBLKaSIbfAJmPiaKSUdEC8yVahfwniOmUSIarbpxXfl2biaBAv/MVZ2t
	kwdWsXezNoKsmTn7Vp4g2BLtet5RuVHX+Nk1R5UP7mG6wIH1l50MIV5zuUM+i7la
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4capu4fcf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 10:11:47 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61GFBkNC021595
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Feb 2026 10:11:46 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 16 Feb
 2026 10:11:46 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Feb 2026 10:11:46 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61GFBT9C017396;
	Mon, 16 Feb 2026 10:11:38 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: adi,ad4080: add support for AD4082, AD4085 and AD4088
Date: Mon, 16 Feb 2026 17:11:10 +0200
Message-ID: <20260216151112.139359-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216151112.139359-1-antoniu.miclaus@analog.com>
References: <20260216151112.139359-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyOSBTYWx0ZWRfX1LVoXNlaJg71
 xG1FFNNrRLBJVODgwLs4oEeNQlgQSFm+Ki85A4cC5zSqH11j+mR/Y+3Q9+mkKUR4Z0G0z0RswzH
 hVAtenxoADPW36S/DrxOazlqGGEdx1NAt75fCJm936zGfFeghzzltEtWnHD/2HA6U5Ax+U0ZE6p
 eXj3SKXzoKV+f3Nf2SyYuUbRL4r/+nAsUhiYabiL+XyW/8Od08JNdX7RJ1m36zHUZZWlnvWo9u5
 Sum4S3QpVvHzApYpVuW9NdFw1ObG2FAkms1EHbFmuc6FyhOCRiPAuFFS9/V9I6Gje9mZb8QzUXD
 nSVphu2sWTFn71KJTTQ83LUTVH6KVHGOe219fY6MSltVHyeAlGpncnlYWs+bGJxGCBrIBJF2Yvp
 nZ6Q3hJzQhqph3MxQsEAeRWE1nqrSBQi5j4/w6BzY6ke9IOLIBUzN5qXfgMt+hsSsxnUhgK9zlB
 4HWhXwKl21n56O5PeFA==
X-Proofpoint-ORIG-GUID: EYVmBDzIczlfaLrwE1OeZ42FC_w-I4V4
X-Proofpoint-GUID: EYVmBDzIczlfaLrwE1OeZ42FC_w-I4V4
X-Authority-Analysis: v=2.4 cv=EZnFgfmC c=1 sm=1 tr=0 ts=699333b3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=9oEBI_weD3nlnaIwBo4A:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160129

Add device tree binding support for AD4082, AD4085 and AD4088 SAR ADCs.
Add adi,ad4082, adi,ad4085 and adi,ad4088 to the compatible enum.

A fallback compatible string is not appropriate for these devices as they
differ in LVDS CNV clock count maximum from their base variants:
  - AD4082 (20-bit) vs AD4080: lvds_cnv_clk_cnt_max 8 vs 7
  - AD4085 (16-bit) vs AD4084: lvds_cnv_clk_cnt_max 8 vs 2
  - AD4088 (14-bit) vs AD4087: lvds_cnv_clk_cnt_max 8 vs 1

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v3:
  - Merged individual per-device dt-bindings patches into a single
    patch adding AD4082, AD4085 and AD4088.
  - Collected Acked-by tag.

 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index ccd6a0ac1539..79df2696ef24 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -27,10 +27,13 @@ properties:
     enum:
       - adi,ad4080
       - adi,ad4081
+      - adi,ad4082
       - adi,ad4083
       - adi,ad4084
+      - adi,ad4085
       - adi,ad4086
       - adi,ad4087
+      - adi,ad4088
 
   reg:
     maxItems: 1
-- 
2.43.0

