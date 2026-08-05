Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC78405C47;
	Wed,  5 Aug 2026 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923071; cv=none; b=SDSRtCHLu30+Bw+Bqoj94xupebJOJfBpjCrGBiorX6hTEc8LLcoM+zcm8KP0I4uqpP6mjv+1RI634oF1my39PPfWomROY7avycVLa37hzoSqEj4zxego5Upav+9noscetbC6Ct2Tl/+oA3aYN8ebubiSjmLWeFQnLiuQIGw+4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923071; c=relaxed/simple;
	bh=Da/7VMA8TGpZu+ozO/3ZMf0pfbVoEuPkKBwBqgoJ76o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bv8/Ll/AdRzTSI9eBk9RmWHCuSBfk+hXSEXlhiX/bs2BnJNnaqdRX4xH30cO62Umk46iUhsY2aFV8RpefvPCGiP+EKnFSCugBFu8zB5NsMPa1mOye55XeEO95gKIsdcNYeGQTIikARNHQMvXL9iYHmTcMqANzxGELWLMUPZCiqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SbEoHiBs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SbEoHiBs"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758g0Hj055540;
	Wed, 5 Aug 2026 05:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FVqAa
	iec42wGogLkGfvISpE06gkOj+QcTBvsnRVCqBs=; b=SbEoHiBs/Ttg4hd/PcLmm
	FFjYhFWFnqYX45u5d/a+Xd0CccDHZVAdCLGhEE9at6eL6F3OFFrNs7EvOPEavj9d
	V5UknU2qLZYydYZOjZBCZaqJr78Sx2Pss/AKWYOJx4GBvlFNTbQnN3a9fPAGBurp
	3jRazWMgM+vGnQzef+mb5b2SohWqgVYYIPm1jASC2br+56J2qyjCT3KJYMnw5vIW
	ate70LU5oQ1leAJNjVan2Haw71L+WgzIsjgLJiwuDiW4JbF6VjCmW3YS6q8zyWDe
	p5s7ymA/1nGeAXXMFp4liWKiINVibVc9KT8h2diWQy/tW5ZION2L8ElQSNfJdomA
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fue5bncj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 05:44:26 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6759iPeB004991
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Aug 2026 05:44:25 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 5 Aug 2026 05:44:25 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 5 Aug 2026 05:44:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 5 Aug 2026 05:44:25 -0400
Received: from HYB-li3PrmDPxTz.ad.analog.com (HYB-li3PrmDPxTz.ad.analog.com [10.48.65.201])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6759iBgI028984;
	Wed, 5 Aug 2026 05:44:20 -0400
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
Subject: [PATCH 1/3] dt-bindings: iio: adc: lltc,ltc2497: add LTC2499 to title
Date: Wed, 5 Aug 2026 12:41:27 +0300
Message-ID: <20260805094135.11762-2-andrei.stancovici@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805094135.11762-1-andrei.stancovici@analog.com>
References: <20260805094135.11762-1-andrei.stancovici@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfXw9y4GM0Em1mh
 /LjgGF/cpXv9e/2oIR8fWT2iLz+/aQmdBrXLfF9PRDg5/5vJ5iuW/vRNr3jegH4Egdk8oOM/OPT
 sn6URWJlxCOQTM74nyKlT9JPISrC8YM5QuM5YHXFFtcL+08oQZg4
X-Authority-Analysis: v=2.4 cv=bcFbluPB c=1 sm=1 tr=0 ts=6a7305fa cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gEfo2CItAAAA:8 a=gAnH3GRIAAAA:8
 a=EP9JJrKyo648RTWUWkgA:9 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: QuOt6v58gEgNxYcd_PgfjqZLch5AKOKH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NyBTYWx0ZWRfX1J0zXDt9amur
 JRTq4vNW7dKn6L+Rw2rXPcQBcd32a85QFf9HY6zTAnNA0oPa/FB39kUR3+2FOaH7oCmb9dF7Rkf
 giJ9ykdKOPF9HQZbbMD8StWK4dqglqE4icRO3v5PUr6Vqkce70VhOYVfa0PuBd9oSZ+V/C7QxoD
 dRDCUFL1NrJHE6ym1kKQ1PuiHIp9hgsuOzNZsL3LnrI5h8Eg6tnpgr6VQpKtJse3ehOXGK3/8Ll
 fmot9r1WJ3H2qu5hQaiN0aMGO3mxRAQDt2YEXvfI4lG2C/m/0Ru6lzrHRhDlf4GVUsU2DL/pzt3
 8TGiAD60W6twh6EPAZ+G+n1A3xnwQJJvyhAqn+Stg8dlRkkJbvqwqidF6hVGf4ohNhyA8ccX7ak
 pnYBa4orvCtK/XFcltXvSi/96Kl0f8yWneMXkm6gYy78ERZab142RKyx36ojlt6XGFvqtJDZh0d
 rA2+n6M+WxBCuo9kmKg==
X-Proofpoint-GUID: QuOt6v58gEgNxYcd_PgfjqZLch5AKOKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050077

The LTC2499 is already listed in the compatible enum and covered by the
description, but was missing from the binding title. Add it so the title
matches the set of devices the schema documents. No schema or property
change is needed.

Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
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

