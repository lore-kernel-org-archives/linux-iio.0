Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C017C471254;
	Wed, 22 Jul 2026 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784706923; cv=none; b=Y1gXgMSv7gLi71zADtrINkLRyLVvEve43fu3T5jpORrm1rK1JTE6TNiJSR/RRG88ZOlSKJWLRk8nN5zqI8oKevX4ei51DNVY1rt6dRV+JUPQPsDRGxv3a1MrZMEXTsMWl940/oUCGn3z/sHrmfLgwZSydLt/TiGsqaRG+PxQh8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784706923; c=relaxed/simple;
	bh=oG+3bqtKndA9C/Io/coIA7Zgga+u4NsdsIbVg0hVUhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=koksr07zxhPWX79gfOtfhLpVNSJ64b065F4mx5HSJHcbI4QJsV90l2bIIO9RddPydZATrN8+W91BEg+XI4fV3vB7PBqX3suraoaB2t/cc677w/PtAYEJJxVGs1GIN1vznUDWQPo59Z+Xp+QiZxvM46RyzXHbm5vVLKZbyPnyjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=QBeTkSy3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="QBeTkSy3"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M53bIE2674609;
	Wed, 22 Jul 2026 03:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tXB+2
	+y9s/E0TDiDMcaoWqFoWuZMgd3OaJERx7IaZ2A=; b=QBeTkSy3yvn5iYiJLKwCD
	IjrLmCxQ/G9Gh8HOq59/f53Mj5MAHb3zeJt7xoaRey45xgrFq0eiYuTY+D+6jdIl
	s/ELk/anz+hNVB3eyJsQKzW7hW+dT55GeLpZ9FjypJXooRzE7e1AMyP2XBXFnRIZ
	FXM1Dgah55weeyfKJ1b8VuziXIy8CMjQWS+NuTKdEqUVPOGvk3WMwFKGuAHr4gSD
	eiNc9T7FyFPGB8d4v3wHMOg/7neyFqUtP67zOXX2judGEO+wITXYpboQmNuQdJHQ
	0bU+vwuOg1gXOV6JdObCdtz1HPZ1z3yXvzp4jFPsQbP4SitokfttIMap2dnbHYIG
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fj6v4mqkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 03:55:03 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66M7t2Jl060625
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Jul 2026 03:55:02 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 22 Jul
 2026 03:55:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 22 Jul 2026 03:55:02 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66M7sK4q006639;
	Wed, 22 Jul 2026 03:54:52 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 22 Jul 2026 09:54:17 +0200
Subject: [PATCH v7 5/7] iio: adc: mcp3911: Add support for spi-device-addr
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260722-ad5529r-driver-v7-5-7781cd74ad75@analog.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
In-Reply-To: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan
 Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown
	<broonie@kernel.org>,
        Marius Cristea <marius.cristea@microchip.com>,
        Marcus
 Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Janani Sunil
	<jan.sun97@gmail.com>, <linux-spi@vger.kernel.org>,
        Kent Gustavsson
	<nedo80@gmail.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784706860; l=1385;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=oG+3bqtKndA9C/Io/coIA7Zgga+u4NsdsIbVg0hVUhk=;
 b=wH/CJYk/2wIRT6A09XWIbUriLwgsi2b432lEjmUlKTrt2esEmnmLCv3HA16QDUClMuP1hiAdW
 T+djKcHrXrkDkti5/hRj5TlTGylCl2nZ/YSy6ft6cWBu1poOjVAveT1
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=DYknbPtW c=1 sm=1 tr=0 ts=6a607757 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=z3SDK59xZFTu6dlpUVoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d1y4T2WcgHyFucUMlAiDRoCb-iezNoZh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MiBTYWx0ZWRfX7sEXas9cfFlV
 lQdZeMaEhzXiu0l/RBkWdPtdiPqFmIDA9XxzVJuiHe213GLeioiwjhpJC6nx4T7B+XigE8ourV5
 LF1J8wuBMuc60urXMopBwYw06TZ0gUw4roI0nZvifpKdX5QDb21a
X-Proofpoint-GUID: d1y4T2WcgHyFucUMlAiDRoCb-iezNoZh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MiBTYWx0ZWRfX2TzilKIhKQP9
 L6cwmX0YWpco/hjaQLsH5C091q50OoJOmfdiaZ7wu0P7V8U2brtUk5q3MeP8EaC+OWU9i5K4WYB
 tgJBhEHtPs0Rf3MhwMICrJpnOXcl5dP4GiwLoDh6l/341xuArAq8J5E0/mAaTpigE8MxzZbSIws
 yNWI5+sCadSs84I22nqlOhO0qBqnovKH/jtZhnCVXSdMkdgmiK0pdJViN0+lW1GCqsuVzNfVkt0
 ZfI6s7QCmuUzhZnSUE1epMgeo6gxXrLPaj92HolHRMSuSK5OKFgRJRoDHD3CuY7ybjpDjiwJubZ
 3jRF1P9qDuOxFMLFHdrrHRemD2h0GC3eJG6pyLZFFpk38MuKNbTGQHUR0qkYGmeXSa2FyAZ0Alj
 zBTrRu3Gmb0XN1VMxh00SVzP7doc9DNdBgn7PH2x6JWSBUuKCyZgyVETkWtcLgL+CuCNSCu2Idy
 eg7E4NH8Y12QKxStYKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220072

Read the generic spi-device-addr property when determining the hardware
device address. Fall back to the deprecated microchip,device-addr
property and then to the historical device-addr property to preserve
compatibility with existing devicetrees.

The device address remains 0 when none of the properties are present.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/mcp3911.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index ddc3721f3f68..3919a326b4db 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -740,10 +740,13 @@ static int mcp3911_probe(struct spi_device *spi)
 	}
 
 	/*
-	 * Fallback to "device-addr" due to historical mismatch between
-	 * dt-bindings and implementation.
+	 * Fall back to the vendor-specific property, then to "device-addr"
+	 * due to a historical mismatch between the binding and implementation.
 	 */
-	ret = device_property_read_u32(dev, "microchip,device-addr", &adc->dev_addr);
+	ret = device_property_read_u32(dev, "spi-device-addr", &adc->dev_addr);
+	if (ret)
+		ret = device_property_read_u32(dev, "microchip,device-addr",
+					       &adc->dev_addr);
 	if (ret)
 		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
 	if (adc->dev_addr > 3) {

-- 
2.43.0

