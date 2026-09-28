Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A9546AA88;
	Mon, 28 Sep 2026 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593042; cv=none; b=nAsfG3kYsG7a9XKZIe+oH36riBTqtxXpWO0rb15EeY2DdMEzKYfiOB9VM1nBtqf1lWX5m33Uiax4DYSNsAR4Q4NrTIz3f/FO36Sib2ZeWm1xoaHFmLZjI2jovSFoUGKZl0L2X/ytXC/CMjbPZ+d4RAuNfOVEBVP/YpNzvR3K7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593042; c=relaxed/simple;
	bh=VxSEbd7KP8dxPPxhBn7tinYwwNmag6xyUaOMY/HIN2I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uB6bRcpFouzo9muh8CVLL6XWztb5kWYkQfXai1i6PrZIvMxU7Lzj4Y7BOzp4wrE2sDsQsTx8bHUjHNof3pdi1/sK0Jm3mjIyX28MuRkizAXI90iwgmKcasAEieHiG4OlSHj82qGslGeI35r62nodg2ofch+MpYhOB6/vUB17aPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sswrb8tU; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sswrb8tU"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9HNd22986202;
	Mon, 28 Sep 2026 06:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=70To6
	SnTEyVLYz+UD/8MKiOUsiTpVetWwpPZVAIj2Eo=; b=sswrb8tUi9Zj95rk3AdId
	U6M6dIg2dlDmtdBsDZ9zmljKPOnMYP0ADx8wPrw26Gj9Ucr/39XLwj+gBdpt2pH2
	u09zDvltYsreZQerdBdfEbASo7H8Y7UNASrPM3+FWkEr/m8lW5+oyIJ4mXjHvOWi
	zMTJP7dZMqNCgT39vrt/uGJ7ttR6rSUwychaCphqRuLVGkzumVjkGjhE6lhar3PZ
	mcE5BEVkvcJfyDWUL5OctByFgbTMJkv6G5yIFFXY1DaNsbfS1DF31io2d5tDgq3N
	Waggsm1JFjrdvkHfQ7XSXuiKOlZ8Pitr06rK+xxX2y1EZUEBRL0/smN0KLT8bRQA
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gxay1srvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 06:57:17 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68SAvGEU022850
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 28 Sep 2026 06:57:16 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 28 Sep 2026 06:57:16 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 28 Sep 2026 06:57:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 28 Sep 2026 06:57:16 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68SAv0fF015531;
	Mon, 28 Sep 2026 06:57:08 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: iio: adc: ad4080: add AD4886 support
Date: Mon, 28 Sep 2026 13:48:05 +0300
Message-ID: <20260928104806.9330-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928104806.9330-1-antoniu.miclaus@analog.com>
References: <20260928104806.9330-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MyBTYWx0ZWRfX4bPM/ViBRfI2
 95qTjnfWBEBytn0kLOQUekNXEQuIKN8DuYdy6NWosvYEk6a3Kvzzb0MDnJYUTz68AjWriWnmHGE
 In5ZhEooI+vUaVVkZlFngYfS5mW4hzF4p6f3Ao1bnWzm6YgiDZk06qMj0dFfIjoQpBOMeQdWyuu
 NEYdcPI+YoMc5R5i2stzvdkeT2mj8wS5+LDYV1HlXH20HsU7ZNC+pBCZaWxOykPTJo597PlYk5N
 sRdkhltkueAajblSW6HWZ6VCZPTJ+oBIpBS9AJ3d4EMP/X7ywtfKSviroDACgRPZ2nvsdmp76bt
 +XKdBFN6G+q1p+WIH5epo/ZglR60669MS6IKWpBZO9/DRtw/Qf+SyUoPC9kWX1cS0vsjWLzZ/IW
 z9s1AHF1I2DU/0pprTURgQYtcgCecCWUs/5jKdEl98r8AmVHMkMaSth9ITVINHgoE1p8tin4B9g
 WNtQOGR4WB9vS7uN4og==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MyBTYWx0ZWRfX9wTx89kvzewo
 W8+qIrrnO1YuMjKUWMXWkFu4hhg/WilKHMe/z72uC0Y+2vaP9OVC2spPeUG/hiDLC4ttgOzHDe+
 w/kz01RYFi7aiJygrtJn8/jaubq/Zp2Mk7k+hlUyT9rOagWE6wzy
X-Proofpoint-GUID: 4d14JqP_4TmaOk1HpX6iIjtyi7AjGBCm
X-Proofpoint-ORIG-GUID: 4d14JqP_4TmaOk1HpX6iIjtyi7AjGBCm
X-Authority-Analysis: v=2.4 cv=Bd9NQbt2 c=1 sm=1 tr=0 ts=6aba480d cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=ZbSE0ZB-LwKlTpLeKqUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280043

Add AD4886 compatible string to the AD4080 devicetree binding.

The AD4886 is a dual-channel, 14-bit, 40 MSPS SAR ADC, sharing the same
register map and interface as the AD4080 family. Like the AD4885, it
requires two SPI chip selects and two io-backends for its independent
ADC channels. The AD4886 is the dual-channel variant of the AD4086 and
differs from the AD4885 in its resolution and LVDS conversion clock
count, which requires distinct chip configuration in the driver,
precluding a fallback compatible.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index c8ac92e6f8e1..e93128ad107e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -42,6 +42,7 @@ properties:
       - adi,ad4883
       - adi,ad4884
       - adi,ad4885
+      - adi,ad4886
 
   reg:
     minItems: 1
@@ -107,6 +108,7 @@ allOf:
               - adi,ad4883
               - adi,ad4884
               - adi,ad4885
+              - adi,ad4886
     then:
       properties:
         reg:
-- 
2.43.0

