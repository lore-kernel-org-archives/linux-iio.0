Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991030F547
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163474; cv=none; b=Efe44/vnKLaXuvp+ORixl/6MUyjdN1przTJt5snmPdUDc8W1bKgkDdHmpO8jytWoKIb4XzJkqHm/9ftotI5R8+wrtct7pVnUm6aVKCcqg2wAfdXhfb+dQ0jFaL10D/IFP2p9rakOTUgIJTrkq43Df+Wa67/YHk1FFbXnn808vzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163474; c=relaxed/simple;
	bh=EGAk2C+JTQr3bexQyRzcU3bvtpEtf8aigWWHn1mNBqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwls/9KC6R2gef7ZpWhFRm+pKXD+vNrDbiJ7rJibqC+qkSn3LiCKOOCB0jkZMySu89v/XRBjsAnjdcEpINM2J4pBrJUQ0ILTrx6l/DJODetIEF5/B7PTrlGesiMZgvoFRsUpoRoQdu6PfO27r0xnMOtyGoUDURHrg/OsgEK1900=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tsa1JVjy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tsa1JVjy"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0Xc3m1242824;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mWp1klE6s5a
	h1ATJksf4BBAXd8FXnwSq8qBFX8wVFdM=; b=Tsa1JVjy1R5ApXwSEeavYyfPO1B
	LXDcxf+RbWI9p/WBTgUcbqVBgbJPBLrKZFFkHTJksHH1OqwCKQm3GGrj/PzybC0P
	i+JraKNKkZEwbVqv02B9lJFe4s5hNCzA5plHxxEDyOSa0W9wvqYNXUy2NWQemWab
	typ4+n4zbYnaUi6oE09/ZhMogGASqvo/EiMdTNTNBr0lvW0NEvSSR77TrgsNqu7H
	XcGp60DtrGaFUbI4wFTsr33MVnRDXHo2EfzNxpREzqiq6ZnmMkZILVlEQTbej2j1
	1Y7a/4f+eRpN/6DkYP7RpEExG7CyEQzqKt+aXUTF4+rGaEi4ckh3c2RAmpQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7nmkbw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:47 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkao018895;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 4fdywfk3eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vkIj018879;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 66G0vkkH018858
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 23E7E23135; Wed, 15 Jul 2026 17:57:46 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 18/22] iio: pressure: abp2030pa: Remove redundant i2c_master_{send,recv}() length checks
Date: Wed, 15 Jul 2026 17:57:33 -0700
Message-ID: <20260716005737.254577-19-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfXzdODihufYfTn
 0kQuZKuBrgP696+JICCgYI01tHKABG6WSj8rJ2O9am61zrPjq8JTyo6KDH5DFiPU099Lv3Fnd9R
 tmUisBb4/KklVIczPzNOixG35BonjZs=
X-Authority-Analysis: v=2.4 cv=cuGrVV4i c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=Bx3w5NfjrIkKNDwUZBcA:9
X-Proofpoint-ORIG-GUID: KSJTKA06N4_XD7MYl0JV9wYAAT0-PXph
X-Proofpoint-GUID: KSJTKA06N4_XD7MYl0JV9wYAAT0-PXph
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX2KbNQ6uZqkje
 K7IV9BiE6/B+6X0/n0/AQRspHQrKZw2F+maISjB2LpuXkAMNBRJNaArrq4kVkKSd9KNAdqd7dCo
 1R3ILDq4uRod8+EaWo3Euz2SWhRtP0uFLHas3ct+gvZaPWiJcIIpOCftg1Qd18/7bz0lFupG42+
 y7QsG5u3UZO4nGG5FGi8aZDXEInQqhmkxHVPzMCXlJKchsdDWWS39bGG6gzBuB1WDfw615cP7uw
 O72HQcyNEMuD8Bc54nwcQFzsIDISLHrqu4yYg+p7ZunzqkOfKRZvgv2yVUKpb6Yqr2dWDzpwuWN
 /SZhdx8q379wVw2tAqDr8dzvX8ASfcGT8MFzouNiVjMS+syS0KMcwk/d8pcnLfkQPqJ0gSgcudA
 f+/6BM6GJQINylC0cnRI3w6FqHHydBu6TZYo1trgDznOePAEpYALHKJRAHlueB4ymsvY6GsC0h9
 SCyX0QJSX+eMCq7JxdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_send() and i2c_master_recv() return either a negative errno
or exactly the count passed in, so a length check after the 'ret < 0'
test can never be true. Drop the dead branches.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/pressure/abp2030pa_i2c.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/pressure/abp2030pa_i2c.c b/drivers/iio/pressure/abp2030pa_i2c.c
index fa4d290cfd3e..bb9c0a1a5888 100644
--- a/drivers/iio/pressure/abp2030pa_i2c.c
+++ b/drivers/iio/pressure/abp2030pa_i2c.c
@@ -24,8 +24,6 @@ static int abp2_i2c_read(struct abp2_data *data, u8 unused, u8 nbytes)
 	ret = i2c_master_recv(client, data->rx_buf, nbytes);
 	if (ret < 0)
 		return ret;
-	if (ret != nbytes)
-		return -EIO;
 
 	return 0;
 }
@@ -42,8 +40,6 @@ static int abp2_i2c_write(struct abp2_data *data, u8 cmd, u8 nbytes)
 	ret = i2c_master_send(client, data->tx_buf, nbytes);
 	if (ret < 0)
 		return ret;
-	if (ret != nbytes)
-		return -EIO;
 
 	return 0;
 }
-- 
2.43.0

