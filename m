Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092993469E0;
	Fri, 20 Feb 2026 13:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594593; cv=none; b=JDChB4VBcejftnxMTioJsjmyyNp/0gABJ27O3kl/FASBX1Tibk7RxeXPcCzKnWa2FpWJ2dCiVLfXUR3eOaEDIURgAXqJScYXYYHYc0g6XILVLmiKTA5MFNvPanEd7agScV3PqMG4F26ilQjI8ildf/oQSbRpYM+jAPEAzT8rcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594593; c=relaxed/simple;
	bh=foct5OKeDok1qe1dNeNCczVrN8Lis2PEDnCVKYO5o4M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHqBltyqZwz+w/Y7hLVHRVbD6bcPifpiTKlkNCP+UVWekT+VNjy/jRiNdxPXUJQeOrucHjV1vD0fR4CIIyp3J/Y1A4jFYtBtQjnC5gfNKRei/BlVrS+jJCq/EiOIoJdb4Ibnm9eMQHeQaz6wePQXQNe0ccVPVAyocGdHPOTcleI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=BLg5fvq+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="BLg5fvq+"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K87ElO3823365;
	Fri, 20 Feb 2026 08:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fA6Eq
	kFmXfoSN1LIz/XnDVqOxmrgVKUm3cTGf1y4NcY=; b=BLg5fvq+haC80f9uUduef
	saDnXliEKO6vWgnKF2DZgGlqqDqTt78HdE40QeFObp5XJGqCc4i2EhdpU09uQrFN
	iC7H/YXSSr/lExXKcRJ+e7O4hje79prU2xG6VI3YxyxGChSbSc5vfTM/0ISESfua
	VdsItmN2/Oc4xkQXokeB1ZbB8+ggI0UqClgzpJszJkxxbMvKNFE+ReEB/JKmnAxv
	9pY0KcJijfKe++hFcfzXh7L8zvLTOxPMOMBk+uhmnoTe0OuDuABF/Hlr+DiIS3p7
	fTlvXn9vEndn6ZJrpbhBfV/hLkWiyDCHRmHoxNd9g5qxV0WZOhsAncz+7D72o+Kh
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ce0xvw2xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 08:36:17 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61KDaGGW002403
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 08:36:16 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Feb
 2026 08:36:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 08:36:16 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61KDa2Q3010396;
	Fri, 20 Feb 2026 08:36:10 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] iio: adc: ad7298: remove redundant else after return
Date: Fri, 20 Feb 2026 15:33:30 +0200
Message-ID: <20260220133337.85216-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220133337.85216-1-antoniu.miclaus@analog.com>
References: <20260220133337.85216-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AeK83nXG c=1 sm=1 tr=0 ts=69986351 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=QtorYFZVtfhnzebPKk0A:9
X-Proofpoint-ORIG-GUID: AooEJhRt-3KEtCRtsLPZfSzNffz_8vWv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDExOCBTYWx0ZWRfX0JSubjz9V3Ez
 SK9YJlM8mG/UWp/B17A2iKSDgEsbeoaOce04UsRPHy2YobG9U9UzoHy7Yp9I3lvl1PYlT97uWhY
 XJlB/Xs6R60x71Iy4JnaNgrYtkTVJU3FV3CTYLWSWAGpUDOX5gdNNoZPgYKsH7UP9rT8zW3XTH9
 e+vHFWnD2OMmsgsnrUy47weB/5xG4cIufLCG87HPln2lTeNZJSVyScFFMDcclGijA/ey6r34H+3
 2IXwkqRaHXw7oix7OiEcZ9BZ/2scvS83IeeLeeuNESqQf0+yxF/oyLi2ty6j+dUW6C+T8bGsGkf
 m/B3iQJV0cBA7XWiD2xQvYkCxGP1xN5ivNFIFzgLEmWFimwrl3cpzgK2Vh/HLpgKD2MefzAc4SK
 yx7BgY8QyS83a6fjZLKVr/yulEMeCZOY/f7oxfBCi1nc1r6W67PwLRDB6wLxTrO32LmHwDO5I1C
 c/kmKCmH5erAh3lA/4w==
X-Proofpoint-GUID: AooEJhRt-3KEtCRtsLPZfSzNffz_8vWv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602200118

The else returning the internal reference voltage in
ad7298_get_ref_voltage() is unnecessary since the if block for the
external regulator already returns.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7298.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index 7c0538ea15c8..e775d84da333 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -216,9 +216,9 @@ static int ad7298_get_ref_voltage(struct ad7298_state *st)
 			return vref;
 
 		return vref / 1000;
-	} else {
-		return AD7298_INTREF_mV;
 	}
+
+	return AD7298_INTREF_mV;
 }
 
 static int ad7298_read_raw(struct iio_dev *indio_dev,
-- 
2.43.0

