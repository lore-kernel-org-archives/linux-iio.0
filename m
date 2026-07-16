Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D63C30D3FE
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163472; cv=none; b=IGDgbCDkO4QzGvMjRjLtLKGWeIvD+/n4E+XKKOi3pVn9u8JAEiKSm/K6l0EHTZiHdqlicWoNmWQhWdZxhhaZM9RNpfn4/tM95fBQuBPXR+O0sjR3KcEb5LCQ3+FwxG7oZRB5s0WZ1y5ZdTfpDrxMC894mF/+uj8adJR0+0MsVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163472; c=relaxed/simple;
	bh=NODLPsYmLxnp+eHbEFPmNQNaWOHr8Qw50TkbrNtuDTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtQLNDWTcgY9cCF/9gk7ZfWfUFq7IsLmML7TDmL2nGbJ70Juo62urvXWFem1kk7z6UaecTXQe9zGTlOXpGthb+eLYdUqCyGW/4qs66B3zjXLcJhZJW5mc7M1kKDgqAXxGmAjsRTnIYtHIrXDRmFhD3/vw2CA68DAbxWEvlDWYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gIoctqk5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIoctqk5"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0Xad0858424;
	Thu, 16 Jul 2026 00:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QnQgtypAB3O
	g9yRZ9R+DrzCnbmmtsZWhDXCpJq42Oi0=; b=gIoctqk5fKQJj9EJt/yaDIBrwzI
	U7WZP1V/N7YTB36MV0Yje6HEVf36stc4Wo0qUSxEKBeXXadTMzsO/wQyeOooKlrQ
	jcw8CRYKrvrtztyZD0eoglLOzv7xEbsZUoM1XSPzuk19q2HK/O81Kei8yQgjVHir
	tJF+Nzzsfe05/bxYLjDQHurW/hty7fR5SVqBtxi/r0lnjo9R8iRh0LkwtwDeaq3x
	iYkI/O4bS0H3MKONV8Cy66B8Wj/p3cYRx4ucYH2ry7vG0PNbpdeaQr9tWCLlK6/6
	z73C0mmamgNb1B0w8sw8/aDCsbuM+SvNQ6qfJ+pvVEDdACa4Eaax034PJbQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fed061xv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vk6i022722;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fdvwh4ewy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vkmE022706;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 66G0vk9a022704
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id E2E47230F8; Wed, 15 Jul 2026 17:57:45 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 07/22] iio: chemical: sgp40: Remove redundant i2c_master_recv() length check
Date: Wed, 15 Jul 2026 17:57:22 -0700
Message-ID: <20260716005737.254577-8-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX/IGdWYiiI99b
 yZak5hmB0dFo9cytvcsiYDMp7k/6fln094rZ5ak25PYO22PAypbHZmKhMfo848VzGRmi6ATJfUC
 0FbcZAnb06UtcrY/ExS9TADfsl0gw1I=
X-Proofpoint-GUID: _eBDHTfPzNY_9mWGNsORFY-LHnrv6lRf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX4bsiMcpTLglz
 i6WmyXCCUZPaJ/gSeiZCkk+tpKYi6ykRT76ObmXmOeUDRgV4qqQb39sIOKtqwdxz1otqlB+k3JB
 L0QLdUQsOCFhIRszbagP/f3c9Jn+nd5VYoz2F40xF14MXKJ4FwVOM/sqrGNmztLZi9Dnhodghbs
 FL8Wo6amXCnLnRX47u8rPHv22ThSZgzHStF97HkZOVu8F0RKNjyZv4dCxiO9Mzw8MEsDefmQphq
 +ODECG0OEJQMTLp3gKL0K0gfK74z1lykVfKCOq/ya4IDzg8/+TWwGIckkc29AzBuSfN3ZPfr7Mf
 154cOQ5eOjzpNG+MxOWtUH9gi3WzfeAgZJhxDvBT/vqGxmleQ2dW8ly9hwIKpLZNKaUvOvN15FJ
 poGfC7DFY01gDiFuoUWKiw6lWrLjxX4mOanbQvdGucZXbkwUQmkle+zkO7iEic2+MkqDgElFpI+
 +V2nb2cHwtSmAdl0jmw==
X-Authority-Analysis: v=2.4 cv=Xb25Co55 c=1 sm=1 tr=0 ts=6a582c8a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=lWJygeKupC8RKWTSBl4A:9
X-Proofpoint-ORIG-GUID: _eBDHTfPzNY_9mWGNsORFY-LHnrv6lRf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_recv() returns either a negative errno or exactly the count
passed in, so the length check after the 'ret < 0' test can never be
true. Drop the dead branch.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/chemical/sgp40.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/chemical/sgp40.c b/drivers/iio/chemical/sgp40.c
index b2b5e32a9eb2..090469e620fd 100644
--- a/drivers/iio/chemical/sgp40.c
+++ b/drivers/iio/chemical/sgp40.c
@@ -196,10 +196,6 @@ static int sgp40_measure_resistance_raw(struct sgp40_data *data, u16 *resistance
 	ret = i2c_master_recv(client, (u8 *)&tgres, sizeof(tgres));
 	if (ret < 0)
 		return ret;
-	if (ret != sizeof(tgres)) {
-		dev_warn(data->dev, "i2c_master_recv ret: %d sizeof: %zu\n", ret, sizeof(tgres));
-		return -EIO;
-	}
 
 	crc = crc8(sgp40_crc8_table, (u8 *)&tgres.res_ticks, 2, SGP40_CRC8_INIT);
 	if (crc != tgres.res_crc) {
-- 
2.43.0

