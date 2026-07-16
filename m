Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958030E0F8
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163478; cv=none; b=mmGKZZHwoviiiHpGIahfhZaqvZbcB9CB/fm+fYxbz0qgPtS7c94X8Ro6CK8ethZWNIOgaeqcKZvEl39FDIop1B8+CT4GBF0ULqpHixlPjq61ybOwUacWt5vqnaobsWmt5md5jy3g0zTJjVNT4W7nLi1AnAVDXQa1by3H0lCHfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163478; c=relaxed/simple;
	bh=YHY5zRqWYtfTwXIRYa0nfdJIGrrxY8sGGiMKrxkr77Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZOY36jc+MDW+qOM8nI+ETR8XEfTpvkaBHJ4Vd5aVZ6ZjwD+oAc07ud+v4IdPgMZa7Hr3TcXcEqMUIvP9RwL+riQ3zb4X4g7ZA3WA6L/xC+kq0HIFAD5nU79/hwZ1fFMJyM3cZv8vOycVFl3CxpHU07L54lasmKmQQft8COMH74E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=elzNMXeA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="elzNMXeA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0Xu561227087;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mpNfJRYu/7d
	LtgbbAT0TPsfodSusaAXOMrrSGm+ltls=; b=elzNMXeATJziEVc8HIJ1ob4e6+b
	GWfKCD3yDQFqi4nNaG5bbEiroAmPvIPfcApMr+PrtMXjqg68r5IZ9RxkZLHFdHzA
	BYhUALDbnq3P5pgebA7s9tJL7m6rMPlkU4yobzBTex/LQUVgOYai/EYzZ0nbj8eu
	2PN3kWmgmz2Iv/9+pJ/LUj252xRxa07kkgEKMQI9NBkWB4zHvXGvlXdXUKt12KwK
	IKY+geBqhi+izs5DUB0z0WxTiZYSLiIUvw4uaoOE9wRDz1tQTpPvkDD+0/5l36+e
	Rzm6MJedqJMJm3jstAlHX6C9r79MACB7z71CqJr0P4sucjOjjjCMH/G1bAw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feeg1hby1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:47 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkRV022720;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fdvwh4exh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vke3022748;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 66G0vkoL022718
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 1F3B223130; Wed, 15 Jul 2026 17:57:46 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 17/22] iio: potentiometer: ad5110: Remove redundant i2c_master_{send,recv}() length checks
Date: Wed, 15 Jul 2026 17:57:32 -0700
Message-ID: <20260716005737.254577-18-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX8xv/dicD9R2y
 rM96GlmY5TzFXcMjCc/IISuRyXvI61moGd/qok3rplDE9AiT5HViIctfIAlsxDbXx9nCc/CXpYF
 4w5SPZNTxEkgvBNrQZEoMgrR8N+Y3TOPAG1juY0O5vLRIyinhZTNdRn4AJXEjvAeD4U1eGmLuja
 Rf89GiutqA2Ojhcg+x9p6gUdE15wCnOzwNFInK23Q4FKquDTAlt4OX2dYSnBtmejUMyqAfHdIT2
 a1icGDJ6KhTgR5Fnn9gpWr7kmFsvrT44ZHkYuTLM/3dNlE7EkScRE/+AaG3EVoPXFGkyjrI/82C
 Y8TSR6jIpwTmjnjJg4LUHpeLvsA24WeWaJfWJzWYtX28uMC/dlO1ar7U8Y4+j0u9MdejDgoNrtn
 lrDBlpRE+N+R2AmW9NFB3d1RYdwDT24K3yWo9BQzN1XgYPQiXujTAAhs2xPVTEzyxmJsemdPB+s
 AAoelT3TIBVUsf4TaTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfXzEmsVdSfHXT9
 ty/BDzuT4mHQtI9RORP6GMSIuWkGjDPY4sReOTMQtAfn0IdeAr7DLB5kqqOP6qM7BEu4qk2nbYy
 yxQDZ6o3tmhbaJF1+ULmH6rrOaXEzZ0=
X-Proofpoint-GUID: SH1nKGlHYEJ7kVEAMtGVlNWT-ltGnpZL
X-Proofpoint-ORIG-GUID: SH1nKGlHYEJ7kVEAMtGVlNWT-ltGnpZL
X-Authority-Analysis: v=2.4 cv=SsOgLvO0 c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=1JqDLbu2bbfNIjN2rg4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_send_dmasafe() and i2c_master_recv_dmasafe() return either a
negative errno or exactly the count passed in, so a length check after
the 'ret < 0' test can never be true. Drop the dead branches.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/potentiometer/ad5110.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/potentiometer/ad5110.c b/drivers/iio/potentiometer/ad5110.c
index aaf02cc7aeba..0885f972ccea 100644
--- a/drivers/iio/potentiometer/ad5110.c
+++ b/drivers/iio/potentiometer/ad5110.c
@@ -87,20 +87,12 @@ static int ad5110_read(struct ad5110_data *data, u8 cmd, int *val)
 	data->buf[1] = *val;
 
 	ret = i2c_master_send_dmasafe(data->client, data->buf, sizeof(data->buf));
-	if (ret < 0) {
+	if (ret < 0)
 		goto error;
-	} else if (ret != sizeof(data->buf)) {
-		ret = -EIO;
-		goto error;
-	}
 
 	ret = i2c_master_recv_dmasafe(data->client, data->buf, 1);
-	if (ret < 0) {
-		goto error;
-	} else if (ret != 1) {
-		ret = -EIO;
+	if (ret < 0)
 		goto error;
-	}
 
 	*val = data->buf[0];
 	ret = 0;
@@ -119,12 +111,8 @@ static int ad5110_write(struct ad5110_data *data, u8 cmd, u8 val)
 	data->buf[1] = val;
 
 	ret = i2c_master_send_dmasafe(data->client, data->buf, sizeof(data->buf));
-	if (ret < 0) {
-		goto error;
-	} else if (ret != sizeof(data->buf)) {
-		ret = -EIO;
+	if (ret < 0)
 		goto error;
-	}
 
 	ret = 0;
 
-- 
2.43.0

