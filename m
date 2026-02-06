Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F6130BB84;
	Fri,  6 Feb 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770383383; cv=none; b=lggNH1Rvw2Lqs7IMf/tJyFYfPZP/68v1CMhF/UgU2XnebXFVH5yk1q2kwhTte5gBvxgftQG3jbAJHy0m2VuBcxU5mAGQZdvplvGcBMpH22oss4hQny96t6WZ4eKvVHd/FaMW8YBlFINT7PnbBwRvZRKyut12wslwOX+eHHx/UCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770383383; c=relaxed/simple;
	bh=Z5mNn7AvTmoCG28pDrEkCfDA2XeRY7xp3Ekl/udT+YA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUkIET4pV0U+jdmuUVMjN4HaFFBhK/DpdqXpmp8/7aNP4DvvTkvtEmyjaumHMHsleEne7BSQfcTfEdTk4rAeO8qP/5Cfhrnchybp3q7wv0pqFKEkdfwEeX4oTUERmukeCPqJeTRBWZ0M6jOxGqh5WnJeULXE2Koz2ClqUu155So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LTjoK05y; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LTjoK05y"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6169sPVM897409;
	Fri, 6 Feb 2026 08:09:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rpbgI
	haP1kHaPIDD32FtcAl/MxthrLP3kI4/nIiQG2Y=; b=LTjoK05yo+6TVol+Gbomp
	AxHcxsM5xznkZ+9C3vWPoWlIfJJNR/sKhzvAv3RMol/G/09RVnnZ4LXGHy6CnHu0
	jcx8qIpA5ErfY88IroZ/SxFO9wCmjLZ7GTgkbzxKBmWLBllUGjGGZmiGJSAbDPR5
	dRR443sv8/lbpvXosC5gBaDRGbxJJS8WtrRSReteKI69VwvpSUhd+XjzHGb+WBQQ
	CwlB3SOZ9ViwJnDK36qDAqSJeSk6Xz40akr/Gmk5INUyuAFHuayHLSaHbAtNlS4/
	DwEO6D83IA+mNRQJEjV1iMpt2KqN0UnnOAXJmHiWVKX0CTfTPjhxk66077Y5PN+r
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c5e32gjhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 08:09:16 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616D9Fqk038213
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 08:09:15 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 08:09:15 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 08:09:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 08:09:14 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616D91JI024213;
	Fri, 6 Feb 2026 08:09:10 -0500
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
Subject: [PATCH 1/6] dt-bindings: iio: adc: adi,ad4080: add support for AD4082
Date: Fri, 6 Feb 2026 15:08:20 +0200
Message-ID: <9d2672c69c9dc2a6f61805ac5721f2706aa1fc22.1770382796.git.antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: ImOk6pLh057kXd5SciuHFz81rXgnV6N8
X-Proofpoint-ORIG-GUID: ImOk6pLh057kXd5SciuHFz81rXgnV6N8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDA5MyBTYWx0ZWRfX9g1cUwVSSluY
 2NMKJeQzKOF3D1BAw3GbDYU6sYIV0rPFtt876jkTtJzC3WCNIKm8pAzF+7QN7nPN3zVJUkWn9zq
 LsiiEwZ7tDHgll+BEynrbhrVXo1eBU4p4L+9Xwv5+03b40QTLPw7+blYs5iT8dbMDpHqyAGKRez
 TPQEPnwGM/y/fmuQYjvMNinL1KGiXnshbJgE0EC1SMRZby3GmCWVOkDZVNGD6XJkW1nJ06Qd3FX
 ZR4y5AO8YI+81WJRrHT0/+IX+1JwPACrOh7xFoHb1QcOREqhetGuZXrlxMn87LZDQb9BvE4sGgk
 ES+HvUMbUxK831xwNzqB6Kf/iiyjUJ5GuPIfP4PBO+nbMntB6OpvIp66aGdS5YZ/yDWc1Z1F+XS
 wJWaHnlzlAdk/NEh6nQ3wy7D2fY6hw6TYgJZzjqg0/M3yKWVxkDmvUQidNJg1C1t0Gd35JLEZf2
 v4lB3VCP6ienGwHRSBg==
X-Authority-Analysis: v=2.4 cv=NPzYOk6g c=1 sm=1 tr=0 ts=6985e7fc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=31E9SOtKlBnJEF0VI5YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060093

Add device tree binding support for the AD4082 20-bit SAR ADC.
Add adi,ad4082 to the compatible enum.

A fallback compatible string to adi,ad4080 is not appropriate as the
AD4082 has a different LVDS CNV clock count maximum (8 vs 7), requiring
different driver configuration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
index ccd6a0ac1539..eeabf99f9a12 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
@@ -27,6 +27,7 @@ properties:
     enum:
       - adi,ad4080
       - adi,ad4081
+      - adi,ad4082
       - adi,ad4083
       - adi,ad4084
       - adi,ad4086
-- 
2.43.0

