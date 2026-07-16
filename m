Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44E30C372
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163472; cv=none; b=LiI8CinPJ6rrCAYRP5Mkgz/YLUxbBsbWb321QfYneRBSUVJAWxu53snjJgzSVVtc3uZih/RYo6a/7ZQTEwtw16PikSDC2UKW6VQ6ezczeHurAYV10dq62cfllRdXffuxU5f9pFoPPfpYuephvFqC55mSI6L7Y0SVi9+021bhQMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163472; c=relaxed/simple;
	bh=bS8Bh7KQ+yQ3BkQ5uwWe/KRdlgbMabL/kHvdPwoSvL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=if+kwQmZjM3N+mo6zyBIxC6nTIe14KM4BmB2W/LLfNeO4z3v7UfSuLXFZqIeBU7+HWm/7NUd54CVfvPGjEC1KZ36siyAIJUWWGl6YoWyBX4VdRMQCVgPQ6zF1fk0sejX+snkgy1WjfHmwvCdCb8i1ltYRdo7/3bnsWYhoC1LbvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EoCVVWTb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EoCVVWTb"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0Xbho1305039;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ps+MktlPLqz
	laSRFChD0FA/FxMhODPRJ/KNc6ZU18LE=; b=EoCVVWTbWcLQ9NVaLKY2yAxZvrn
	o1NjFR+Pr7hMQ2m7a/xs1YI88xYEOiyK6EH//xOii9O+c04k8yzDVRtYYatHdgb6
	GIl6bNeA28YVGP8oflMLSKOo9bRWXqpcVvGgroIbKfPnKi7uuzgwI6Jp2Vn+8sB1
	cmKTf9tdKr9HG0rfMMi3rz8YHuRBUf7llJ95OD0VAMIyW3keE0GOIGVfYZGTkYBW
	ZhfdCj5i0MrXUSPGd3cZsbmWMd1AkJPjSjju7n86oQ27fCYZpHj5rX0j68eiJU8T
	c5CSDJj2/msj42ajmFGEOKH9bYX4fWo0aWgDzMVExtwIW42j0b5U6PWhzZw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe855bav8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkmH022741;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fdvwh4ex9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vktm022712;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 66G0vklU022707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 11173230A8; Wed, 15 Jul 2026 17:57:46 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 14/22] iio: dac: mcp4725: Remove redundant i2c_master_{send,recv}() length checks
Date: Wed, 15 Jul 2026 17:57:29 -0700
Message-ID: <20260716005737.254577-15-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-GUID: f58I6sNZUY-hdBzDqAaCjbNVP2o56MT_
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6a582c8a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=-uFUmKq4dWkqj2p0WwUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX1ih9ZOxCeSwd
 fS6C6ZymV7ZFvtqpPtV2R51Dhss2MAM+R3UaLWiiSY53FsjGm+Is7ancs6HvogRSf8chwiqUZqm
 zHtoM9fmVi5URsZ7TvDp3YJ5inD9nTzz86Y9T/J6Mg0xqDpcpmVSNMOyHn+d5I47xRHTFC+Xqzk
 Igiv2AaYxlFMxvKMEoqZmlbExdf6lgQXEsG4p+aB2l2SdCAtw3yFcOIZ0BGZJPQG3ZVWY0QGwOB
 lOlIeN3vyPFr/1RfAXmm8OcOKYNqfauGY35MgPgQDMX7iJemJREjG1Wxxzw4wQUkFK7e8PS2rLM
 eHbt6MPTsNqCRfRimvpmyDCqadqr0uKN5WaRi6PRe1NcL7PGjbZF+IxH59arKjId7kdT8j/FPdq
 q7itnAaIr+vbb5a9b54/eyp6Nx7lcNALVEzJ++3V7FXaestGkvF5kMnVdigZuwk2Bl92Z5ddWfj
 ar20Z83vHiIkj3e9hTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX94szoz938aup
 ch5WO/WZJSsVv4wjtcR6ZV7q4lPxUwBuTLVP9+FmgG0lHAN+LJ321vpldgw9Zt9vi45n1rL6Rad
 C2KyYCqvfnSFnpcpwkbLWcIOz3Ay+9s=
X-Proofpoint-ORIG-GUID: f58I6sNZUY-hdBzDqAaCjbNVP2o56MT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160005

i2c_master_send() and i2c_master_recv() return either a negative errno
or exactly the count passed in, so a length check after the 'ret < 0'
test can never be true. Drop the dead branches.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/dac/mcp4725.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 3fa7acc69aeb..92c1f0ca369c 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -58,8 +58,7 @@ static int mcp4725_suspend(struct device *dev)
 	ret = i2c_master_send(data->client, outbuf, 2);
 	if (ret < 0)
 		return ret;
-	else if (ret != 2)
-		return -EIO;
+
 	return 0;
 }
 
@@ -78,8 +77,7 @@ static int mcp4725_resume(struct device *dev)
 	ret = i2c_master_send(data->client, outbuf, 2);
 	if (ret < 0)
 		return ret;
-	else if (ret != 2)
-		return -EIO;
+
 	return 0;
 }
 static DEFINE_SIMPLE_DEV_PM_OPS(mcp4725_pm_ops, mcp4725_suspend,
@@ -111,8 +109,6 @@ static ssize_t mcp4725_store_eeprom(struct device *dev,
 	ret = i2c_master_send(data->client, inoutbuf, 3);
 	if (ret < 0)
 		return ret;
-	else if (ret != 3)
-		return -EIO;
 
 	/* wait for write complete, takes up to 50ms */
 	while (tries--) {
@@ -120,8 +116,6 @@ static ssize_t mcp4725_store_eeprom(struct device *dev,
 		ret = i2c_master_recv(data->client, inoutbuf, 3);
 		if (ret < 0)
 			return ret;
-		else if (ret != 3)
-			return -EIO;
 
 		if (inoutbuf[0] & 0x80)
 			break;
@@ -291,10 +285,8 @@ static int mcp4725_set_value(struct iio_dev *indio_dev, int val)
 	ret = i2c_master_send(data->client, outbuf, 2);
 	if (ret < 0)
 		return ret;
-	else if (ret != 2)
-		return -EIO;
-	else
-		return 0;
+
+	return 0;
 }
 
 static int mcp4726_set_cfg(struct iio_dev *indio_dev)
@@ -313,10 +305,8 @@ static int mcp4726_set_cfg(struct iio_dev *indio_dev)
 	ret = i2c_master_send(data->client, outbuf, 3);
 	if (ret < 0)
 		return ret;
-	else if (ret != 3)
-		return -EIO;
-	else
-		return 0;
+
+	return 0;
 }
 
 static int mcp4725_read_raw(struct iio_dev *indio_dev,
-- 
2.43.0

