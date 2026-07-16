Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6439F30F526
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163479; cv=none; b=hQSS7fVRB+n/6kEIOuV3LHJTN44s6bjifm1N8+XCknNkjahKm+fcs1HHx7zvIUGbshEjpvXv5PdOtgAASICEyXIg7DPJf8ea3oHe22+6/NbLH7+tF9P1Dpk92dvsT6lOa0SEyeNndctZkLASaSYVs6tE9TF+a86AlYIsf0wbagQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163479; c=relaxed/simple;
	bh=PesxukoMBEFStI+h97bFm1qIPo6esBf/1HJ6uljW+ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kC4U4IkSraOoMhw1NndoUO91ZLZ8hMKgMOWtTTYmc8THsY3rDj0qsc6eg9HrR+cQlN8aQ4YHRp8xuR/sziVZe2J7Rx0PCfnE3gyC7MOAUafc+2/pMImbOcrxTcDCSbgODLzWiOmSZms2Qk6EwrQvTgmX8997SqfB8n8+o9dVnOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jwNV3yio; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jwNV3yio"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0XoDC1226922;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HAPF0Kj2niZ
	SZbGNUVQgmiUT9cJBGx7uY7N++Xr25QM=; b=jwNV3yioYo0U2rIFhXEEvvBTkZ3
	nc4SPkqW1TNxjYDgoEusakyONpuk5equwuYkaNKX2OMr1Xal827k1z9duSC6lIeV
	czIn4l3d9tW5LBVdenSeu964wSGlLNdcOEIKATRytA3TFFDBRydOmhv3/7F1wnig
	qq6TKFX22S3cCE34wdu3m4uP97cUQpuilkb8lNNq0ghZIC76h136dal/bxqy9UZk
	FR2BhWYsp27mg06SNJGTkObkLtYyLwI80MAiaYjMa2ODffYHJKyonLQm13AZLXsD
	GAnF3ttQ/vWjJ0eux0+Zj6261PRsMENNXFN+HyGk0NSlWU7i9NDjkKIZ1dg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feeg1hbxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:47 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkBE018880;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 4fdywfk3ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vkY3018852;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 66G0vkCw018845
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id F1B0C2311D; Wed, 15 Jul 2026 17:57:45 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 10/22] iio: dac: ad5696: Remove redundant i2c_master_send() length check
Date: Wed, 15 Jul 2026 17:57:25 -0700
Message-ID: <20260716005737.254577-11-jonathan.cameron@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
References: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfXwaqeaY0NQBXX
 FqlQzMQWmps3+I9O91GzaSw0RchokInKeadF2UUb8SZ9ZYSs+edWaM+1FrT7q0YEKI7ADXPYCzw
 0x+8XYtrLrgaulZb221RGxdrjjgNYnBQBuoOshG5vVaehxsF0HU3fNxCh+knbjNUx2r9nFr9QGC
 dPG2/5jfq3yRFzpUa0xwTkXUQ65/4fnTsXC7wgCKBHgXY+G37vmGglbsqSWDK+JObEYAeb67qdP
 X2mPPq9Xo3dfMahH9UfgX5jx6VmWVqbT4nZPxE2rIqb6zoOkPK/MNCf/lKB0TDlAABmAXTuPqjF
 rzGO4V3eEWZr+J3Wsp75rkWQf0/ucnyNfX7CV4UclKB7uwhYyJC28zme7lt5+vYk8AJagMF5jay
 YWRwZL7+sKBJQMduQd1FQcdWVvH1l8UWFBf2xPM0DFpbaZcsP+EU4AhSvKXcu8kNlnQqJEzkmA2
 V5gpQuDhX7L1f9tGvcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX7S4MYOPICH5G
 AzyjOGJ3I2ukYSYNCGgV6laueU6HGvW8cxlxkpyPvxgAIDhJm32ck65MKgNeZStXlxoK1v6rTft
 Qg5Qol82c9/rFfi7UPmUZx3IN8Eejns=
X-Proofpoint-GUID: Kxs4J_KXxiezzCTYcvli_hAUS7LZ0ZVT
X-Proofpoint-ORIG-GUID: Kxs4J_KXxiezzCTYcvli_hAUS7LZ0ZVT
X-Authority-Analysis: v=2.4 cv=SsOgLvO0 c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=r0dgtAz1XB34ppFZNlAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_send() returns either a negative errno or exactly the count
passed in, so the length check after the 'ret < 0' test can never be
true. Drop the dead branch.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/dac/ad5696-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index d49946adbde3..95b4956f9376 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -58,7 +58,7 @@ static int ad5686_i2c_write(struct ad5686_state *st,
 	if (ret < 0)
 		return ret;
 
-	return (ret != 3) ? -EIO : 0;
+	return 0;
 }
 
 static const struct ad5686_bus_ops ad5686_i2c_ops = {
-- 
2.43.0

