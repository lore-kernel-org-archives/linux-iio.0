Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB473D6473;
	Fri,  6 Feb 2026 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383386; cv=none; b=LnDGRCs219WfCGjp9OwzS1BxhYXvEM8o6E8Ds98Cpg7XOeZF3IXwC9TIVcZDnOuqSlwX+8ISpUarxvNTUoW+phxdPHQ8KgPl3YUeQkS5Vi7b6RBXLOr7SjRf3MKpxRinEF7jvrpVG9AfHP7CycSzypPjQG9vUqezHYnpvp8kaI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383386; c=relaxed/simple;
	bh=irhtSZvEDa6DxwadZdqCIOZeGVsViOap/wGi7DeX/ko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLcGQl1QcZtT+tVFOZHCsef7NmmGD1pcDe+hg8bBIX4069yfzvi+IkIx18vJNerVci8GOCJTqod8mz8YRBiVdt8bi6S/sYzvawecTazjOdC/WXlS02AxOTsVWWOnHIXaWFCR8+tVQPEgZeXhrHdypbRnh1bMAHq7k7BLO2hlueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=G4p0UmzP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="G4p0UmzP"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616AIhA12328489;
	Fri, 6 Feb 2026 08:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bNDDK
	B+yilHaZ9QE/j2GwKOp4J6HWEwkXLeoGXUTgYw=; b=G4p0UmzP/4Z5kNRcVPR5R
	UnTS+KN+0fuo3YpS3KNSitWMQLJqAz9DxOsdotDpVZRrul9a7wYyr2L2zZb66Ujh
	iJxLsF3a/d+sKg7NQfAjdX3/4cFdvb1hD+y1548nC7BR9hef+jpbnszlrK9NV/2g
	9odSjwhj3EzFoc5BFV6Hsp6w6mxZH55Cr53K31xvAnubmIHkhhHclMC0vUaY4xGj
	2L0BLpvsA6sDt0X1qQpRowhdZc5sGR7lKB79Q85aXb7I0xZdXcU6vTnFlHDeGhi0
	2r02b6JxmQH1a6+RoSxAi4K5AFKbKRr+uwQIy6WkewyE5lahrZnTe/8o+IzzXEJD
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c58721sgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 08:09:27 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616D9Qtq038237
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 08:09:26 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Feb
 2026 08:09:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 08:09:26 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616D91JM024213;
	Fri, 6 Feb 2026 08:09:20 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] dt-bindings: iio: adc: adi,ad4080: add support for AD4088
Date: Fri, 6 Feb 2026 15:08:24 +0200
Message-ID: <e54e91756662ea44b4f86d4be97743ee40df3f56.1770382796.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770382796.git.antoniu.miclaus@analog.com>
References: <cover.1770382796.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 52u2Ya5KV19D3UncRPfznP-xsQ_66vbO
X-Proofpoint-GUID: 52u2Ya5KV19D3UncRPfznP-xsQ_66vbO
X-Authority-Analysis: v=2.4 cv=eqzSD4pX c=1 sm=1 tr=0 ts=6985e807 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=r1IkbUOa5G3b9l8KIE8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA5MyBTYWx0ZWRfX3jbOllYUFhFt
 OMETIsagH3QpUMNM2aN3d3ME/HIXv8V9aodLRuzE1Cr2GiaAUdaN1IkYBJpXfUIH+Wy4/GS1rAH
 me7Huztb+pld3MRp6tIJkxgHxE8INP5O4Er05FwfZQ+DVGxg4/i94ati+ItZrxH8c1o5jovUBQc
 TEu7efBJ6Dxtgs6UiVNUpLJLYQ/5HOdDoRaapaJCabHU894L38i80XPUj8BV8FEiO3qyflAHLmU
 ZWpyyUXGEneHySX4JiNrcDfbXJaHg886BQa3E1QOv0Kvb2Wo4drDyAm5bguIjvwJGT9rK8weNok
 LbnVVVcp65dg8jNlsAy2Fproi71Qo2rjveaDI65R0Jzr62TyC8owu2LWgBTf/+3UiuonqFA2llt
 Oq9S5/p7c5x1IXNlHNtatNwaTaa2Xoq8bI56CXiAGR2M3vV1HB0WtJ2lrcQcxrOK4FgwJzCqkAZ
 g+W3s1P4qwX5WJxSL9A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060093

Add device tree binding support for the AD4088 14-bit SAR ADC.
Add adi,ad4088 to the compatible enum.

A fallback compatible string to adi,ad4080 is not appropriate as the
AD4088 has a different LVDS CNV clock count maximum (8 vs 7), requiring
different driver configuration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index 106267aee195..79df2696ef24 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -33,6 +33,7 @@ properties:
       - adi,ad4085
       - adi,ad4086
       - adi,ad4087
+      - adi,ad4088
 
   reg:
     maxItems: 1
-- 
2.43.0

