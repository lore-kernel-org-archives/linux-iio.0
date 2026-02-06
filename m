Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95AC3D3488;
	Fri,  6 Feb 2026 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383384; cv=none; b=dRX59Kpp+FR93oRIiGCHMWmCeIjRQb9CYC+65Noo5bzS1JCw0ejPbpchn5gspl7yiwlryoZICZbF/8kffGprAfpMdHzEyXxRxQtN2ZG+OgjwPDqdspCAWluwQfcxQ2jEZx+CLop2pcp/t4Yrh6c5V/sYXCbxCJlTYn88WFO29iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383384; c=relaxed/simple;
	bh=ijfcvKeXB5QZzbAUW+QHPZrOxJEQNDIH3vxruHJBl+o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZMQ+cvx/6eWU1NcWIcBTiNJv2L+YlJjlZhChirBJaP4bmosaJIDFYKkDMw9sMbKOucaDJasjNszvRT6ZEl/fLa1o3zXnRSEPYHPDmRPd2FWmVoBuTDT0vC+AjhoAEkU/Cnlvrqo350YRvI1Sh5uT9UKyxsusJ+Hrg5+7qtZ4c2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VGdikLL8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VGdikLL8"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6167xN5J2059991;
	Fri, 6 Feb 2026 08:09:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jYBS9
	eNSVqXuW74eRUuWVmJ4WV0TMNKic0lPpXikW1Q=; b=VGdikLL8/31wgX6ABGqaD
	BHleI3S8oe5hHbJthoXe8v9jFkXVowS4nn9uduYD/1oyXYqPjE7LpDtnj7b36tjb
	UY0SoDVUIXQ6d9qkXlraj62H/vjz/nIaQv2kyvTRPAwtCe7Al24uIPfkI5ysXh+F
	jtTbJ6dPAeoUVTe0w7LaElrQZlE0yBdyDyjzcRXHbu2Ao7tLf90MZJfajcs0XZWK
	C82LJFbmsY79p34jVr648lTE+VOl11soFAlcY20gniahStRx+Cn/5SLYOm6AXZYM
	vIn6p0VkkvOC/c/+2nRMCW8FtPQ6DHNPS8X6sXw/oVLPP95w3lj4YeqVvZ3hQTJI
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c4ygqut9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 08:09:21 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616D9JGM038222
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 08:09:20 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Feb
 2026 08:09:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 08:09:19 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616D91JK024213;
	Fri, 6 Feb 2026 08:09:15 -0500
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
Subject: [PATCH 3/6] dt-bindings: iio: adc: adi,ad4080: add support for AD4085
Date: Fri, 6 Feb 2026 15:08:22 +0200
Message-ID: <e1ef83150eea89864d4bad8d9b43e60503fc5f14.1770382796.git.antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: D1d5-SDs0c1z4gZ8WVwHS_8Fnv-ZteXT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA5MyBTYWx0ZWRfX6FMg/KiUppZp
 0QisCGTJTLU4WVhwI/vG9sIRcvMcGPxIa4cRrJNF0FQIAA8NYMwjyFt+LeYiy5quqaW6HhZO0ni
 u3yoBJ4F98m4S/nWQQGu6Irm7b9p2AQFnEL73dQgbZK2aAHQe41i2aFqt1h0m/NZBXO9wWoN45E
 XjKqIMH4s2vf+UlUCtBGwvDYMTcNg6hIiS5W7HjtMG6S6D4qCXVzlpBg3oZLKD7BgdttZs07BJ6
 xR4jW+b2Ncj7vk7NruYBrTUOnc5gkfsiXmIm3NZIbeRZ0PEjWDuZbDWiE91MR/qopMWREdLemXq
 xBJSVi1bMWx9kLAN7xms89CatoZGEcNzuQmBUkOzGkjcjR/TK1M1A2YewwlZO+JX1FPUirBkxPF
 BX9xZldR8vgZY9O3LTkCtyFpok1/wQS4zsn13nuUV9dDIfrilcifgWxsSVgpPj3JdC5orYvVVfT
 ipKwCz+93RPEYr29AJw==
X-Proofpoint-ORIG-GUID: D1d5-SDs0c1z4gZ8WVwHS_8Fnv-ZteXT
X-Authority-Analysis: v=2.4 cv=CLUnnBrD c=1 sm=1 tr=0 ts=6985e801 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=g0LtDnNlmyec7r2dGFAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602060093

Add device tree binding support for the AD4085 16-bit SAR ADC.
Add adi,ad4085 to the compatible enum.

A fallback compatible string to adi,ad4080 is not appropriate as the
AD4085 has a different LVDS CNV clock count maximum (8 vs 7), requiring
different driver configuration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index eeabf99f9a12..106267aee195 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -30,6 +30,7 @@ properties:
       - adi,ad4082
       - adi,ad4083
       - adi,ad4084
+      - adi,ad4085
       - adi,ad4086
       - adi,ad4087
 
-- 
2.43.0

