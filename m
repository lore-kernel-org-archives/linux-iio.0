Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686723806CA;
	Thu, 13 Aug 2026 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636925; cv=none; b=gon9XLvJTxP2gOqYZN8iQdhZiX8xn4eSQG4Amx/tCuoOFG4qceRFSPIBeOr9U3Rsgmp5UDuu6KqiN007BPNqNnrSOf0CoVySAbek4FRK920Y68hbEFvIzdznm3Y1A9iMJ6b7QZlQpcCYUeHJfNDhSVoUIo9iS8JxRdViPAojqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636925; c=relaxed/simple;
	bh=9P/Ui9coX6B2WsH43QxxvJx9KK7tK3UsqdCycuHn56U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQX3OZHBaw+3dBYBuewizhvHvCv0GzpnVr67vXUKVuymagJerId2lPREkQHXlwUCVlakRTDRhhV0Op+ujiAMUKy8tuFcIEM9MIdPiDn3ldzTpt/Fa4wEqeFiPUMrjVwV1dd3tbE7Zin4mCLNWT9bX4iCX+uCJntC0ldfB8M35T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1XDMR9kw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1XDMR9kw"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFa1dS1854320;
	Thu, 13 Aug 2026 12:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Dzl4F
	QuPte9r621f+Yu3sW7cp103MpoW8Xwq6ZKha7U=; b=1XDMR9kweuVHExRnA0sKK
	dkO4j88IwRBPfvVt3ywHfPDO2tGrRCfSbLc1hMdmx3kwpn+hK+oaMPbG1Ixd6DmQ
	bMcj4j9AETrJVfelEouSGVcqnYpLVDYc0TVjIj5xnHuzY0i4egDhLG07mobEQveQ
	YNOEwxi9VBayEbDaoxQQ5JdcNWQ+Ovbb4noUCSQzc+xErSb6eOIuTMhZBuM4lzXT
	k4s1QKka/vGnCP+WrqA6h7hr8imFLM009/MnIcRdNdRuDZ9QFAuG2Diw0nnmZI3q
	hmWkMskUTQRgmGXUVDaFX1rS1SOIF5Hzpo6nw9qGCJ0XPQG1fCFLWnK2a7PIQUfV
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e1n90cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 12:01:59 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DG1wAq043679
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 12:01:58 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 12:01:57 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 12:01:57 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 12:01:57 -0400
Received: from HYB-li3PrmDPxTz.ad.analog.com (HYB-li3PrmDPxTz.ad.analog.com [10.48.65.165])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DG1hSg011651;
	Thu, 13 Aug 2026 12:01:53 -0400
From: Andrei Stancovici <andrei.stancovici@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Liam Beguin <liambeguin@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Andrei Stancovici <andrei.stancovici@analog.com>
Subject: [PATCH v2 1/3] dt-bindings: iio: adc: lltc,ltc2497: add LTC2499 to title
Date: Thu, 13 Aug 2026 19:01:35 +0300
Message-ID: <20260813160139.70000-2-andrei.stancovici@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813160139.70000-1-andrei.stancovici@analog.com>
References: <20260813160139.70000-1-andrei.stancovici@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDExNSBTYWx0ZWRfX9aTp25l1G53Z
 KSCZQnZNPf9C7TZJeD77VKDQKjJTahVOKakGjQI9+ulp+iMFPP700LzHkqRXh5F46OJRokli7A3
 MtbHd63m9U2/IZIXYRkE8OHXYFdnYPV9g6azjWaWQuLcwNfWkoVosCm5Q1AQZSip/UDp0XHwGc7
 n4YGba/G/7s8Y01hklWKqvmmE0PiHeBmqpjfraCYk2J0RdYSkbXQSIpEREfHGMYBXPm185B7KW9
 LssXVTLtne1KtSsekZMGoQzoJPRdUmg0Vf3hKfFbQOsrBLqatXnBEAPmLVQBCw3lyBrd0/TWyZS
 W0NsxsuopeTrLux6k8ruyNZWGFgGdFhNZrI8jeX6oVxkWPmXQp2RmBZnyRBI3IkM04BWnNudVGG
 yMpgZE/WCcIovbRf9gacNgq3bZVSCEzTzAQxjOlDbiCrCOD+qHX1A7ob1M4EizT0Wq8iX7wbT7C
 TqVt5/AK5PTzIlo3B8g==
X-Proofpoint-ORIG-GUID: jntx3r892Ujr0BVSagcSri3TkN98DsUQ
X-Proofpoint-GUID: jntx3r892Ujr0BVSagcSri3TkN98DsUQ
X-Authority-Analysis: v=2.4 cv=fLoJG5ae c=1 sm=1 tr=0 ts=6a7dea77 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=EP9JJrKyo648RTWUWkgA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDExNSBTYWx0ZWRfX5ohW3ibw8jnp
 hLZJKPUUwGGjVz9unzvUL3goJnRyYvqX6sK8FGjHmdDdHg9zlrAjKTHX0NfWwY2nflWNoODYgCD
 tmX54YnaeN8zVL2UcVjIDJCVOVwWzF0ZjcbvVbfS/TWqcTLijqP/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130115

The LTC2499 is already listed in the compatible enum and covered by the
description, but was missing from the binding title. Add it so the title
matches the set of devices the schema documents. No schema or property
change is needed.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
Changes in v2:
- add Rob Herring's Acked-by tag

 Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index c884b6e03767..8aa1ba0a8728 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/lltc,ltc2497.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Linear Technology / Analog Devices LTC2497 and LTC2309 ADC
+title: Linear Technology / Analog Devices LTC2497, LTC2499 and LTC2309 ADC
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
-- 
2.43.0

