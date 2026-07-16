Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6447130F52B
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163479; cv=none; b=UrKmjv7b20xc8speCQX57oHtSP11BxNrJRNDBS0MgUNV7rEWOWeAmQtSIEGM6cRgE3tI0uVUdcRtQQcLYBODXgwtBfufLL/5lsrxfp8TE317d9nZ/CoOsn7LgW/5esFDDl/CSiS6A+2AK+KLrFIv4cyCU73jBx+/iT3fKppvzto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163479; c=relaxed/simple;
	bh=gBOk2E68OJ0gxWT9Plx7tR/EOmfV5Sbk3Lsy9AsMul0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9T2OT79qsefk2DpBSUzf/uFXFHzqDZqVmHFrgZqCy30DW+XjNeB3vb+KBA5f/QebSvze0Zc0eU3DiNc6mHGjyk6th98F2alz026l8JeEnu9qDKFB6hS/bF965CGuSr4MBb7uIpst2aDoSJROFL9vjQHWlzmakUf5pKBNbgHjZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d7WTi/01; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d7WTi/01"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0Xn7U1226890;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=h7ZNe72Dhcy
	+ayhahn7ACc3UpesI+wzvoXGERBLyKYM=; b=d7WTi/01tpBueOd230m25TBUdoB
	++mD2VmnbY2vMK+pJmD8fAOvpBAz3TWYFENRsvyaLRHUZqOdmfYSVhpO10YMUTpC
	pmR/wg1syuDEYczvptnLDGybDfz58IJ9gjpLkVyP7SMRhzw2g7t71tvfrn5aLC75
	HNAWz9tzeh33sueDsRxc4AgSQRpZYaXDpVWUsGAGNcFFC5qSqEVIOQx5qi59vLQw
	fFzq7VkGTNuakBu3QZShwLHxMGR9prsnnFE6+DAAVG122gpJy9dLzCCIqRJarOpm
	dWIzBXObFfd/LukRem/SR0LUe7S1qTORQdrHuyFylv53yKCIcdwxP1ghj6w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feeg1hbxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:47 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vk2l024336;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 4fekujghv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vjkc024308;
	Thu, 16 Jul 2026 00:57:45 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 66G0vjeJ024305
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:45 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id C452D230A7; Wed, 15 Jul 2026 17:57:45 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 01/22] iio: adc: ltc2471: Remove redundant i2c_master_recv() length check
Date: Wed, 15 Jul 2026 17:57:16 -0700
Message-ID: <20260716005737.254577-2-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX8r2RiVcw2isv
 7h9r4s2PB9TINs6dyX8jRw/xXax0OwIMuK6nkYYgD9alHvvUgXs583rkJMxUNHhBV9tTt1Mngbo
 jAJLipUMWSknw0YYa1DeE9gddoMs0Zdb5nsZVd2h1Q9yu/m1SSCe01F0F78uIMeTTpCiMQw3DRV
 kLLqipEmcAQZTdB1aghAMj80z1sP+Yfc1nu2QD2ySlSD94IKSniPpNelnMZXa5u3X3bc1OOnu6X
 yMw6Sq6U1AXt0aNWthSZ/3FwdK4AsFOkHNJwPHOYlJkXAcx0dUXc8QQNApI7I9qfBsM2Hymm5Ad
 6E81DdPgqJhn98JPrAZLA1B5Ay43v89Pwhw8TLNjaUu2uSFz6grAdPP5OU85BWZiq513BKjYQ7n
 XrdDwZHJcKHMx5PTX+eD4bUz7e3tIOsB/GPenPB2VCQcYLXcCpFM4+QpsY9UT+mzpWlOLJZMoKM
 iCjAPZLLPLSchFJkhQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX/+QVYW2ZHS60
 vh4+HF6Q6mwDBnM/tmWdJXDxAZwzoSMsF1kdbBhLF91+ThRXObYtxPZk5K1/aJqrLKRoIZrCOi+
 RO4WxUnHPDWKmoy5trJKG7WSqGBCmmI=
X-Proofpoint-GUID: d4xaTBs0Sr9DwIyI8vGH7Flgq9dH4CkE
X-Proofpoint-ORIG-GUID: d4xaTBs0Sr9DwIyI8vGH7Flgq9dH4CkE
X-Authority-Analysis: v=2.4 cv=SsOgLvO0 c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=zGAt8_9kMo3YiCZM6tMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_recv() returns either a negative errno or exactly the count
passed in, so the length check after the 'ret < 0' test can never be
true. Drop the dead branch.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/adc/ltc2471.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
index 369af700969f..0223824782de 100644
--- a/drivers/iio/adc/ltc2471.c
+++ b/drivers/iio/adc/ltc2471.c
@@ -35,8 +35,6 @@ static int ltc2471_get_value(struct i2c_client *client)
 	ret = i2c_master_recv(client, (char *)&buf, sizeof(buf));
 	if (ret < 0)
 		return ret;
-	if (ret != sizeof(buf))
-		return -EIO;
 
 	/* MSB first */
 	return be16_to_cpu(buf);
-- 
2.43.0

