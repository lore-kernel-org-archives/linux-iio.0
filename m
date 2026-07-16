Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A46306D3F
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163472; cv=none; b=WVFmQpB8otA434DFkKfRnNzqqR/IYwn5LOGZpGHloeO6IrFdRi1Zqxl90UFMYXzIxI8xkQCNfVx6WQD6SpSEpyrxyN/6xT0mzNWUwl3wotz/IsrlDqnbMAelIdK+1VBNA9/gmBhTSQISJFEPhCpq7JAll8Z5s32Ci4BBImebYsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163472; c=relaxed/simple;
	bh=uC/zC7SWCl7ufSTR8qx/cmlIwLSG8GvmcCwpKLaIshk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZKYL3zR2AelIMJ+iuJh0gCZK/RKSsgzT8+EQ2y3two0WVTU1/+4uT1/UdkvcqURR+PecibuDPhySwjEsUsQRTFjR+sj7wY0GvK9koM93xtZqJQwD92D/TCLIjnVUxuG1uL+45BbRaa3FZfDK/Y9gZ46Bch5w4acIWuV+s40wXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HMooNJ+H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HMooNJ+H"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0XpCl967878;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/iHw4dtXxlD
	zyIh9Sh1JZB5cw31aeN6VthdCWtv2mHY=; b=HMooNJ+HbYudSWrscbav+eu3o6f
	Vdsn2ZHXe0jb/gEQU2r2WIYD5NUaOiXnYCwobxuv+GZFVZQezrSE9aaEaQ5SwEmT
	iHsFy20K+YPxU9KobtTHIYytCme/etpsURvsCNDwdvFw516KBxcjfHGNJ2HsuVRJ
	f1jL00KXjY9ob6xMhZMnGjGLZ/uKK1I4PB85A8sZsJ64D0/XxBnuXaUgF6LlxXUl
	28nc4ks9mGc/UgNnhg8zj/T+U0zYLLiLmgjJMXZmUVvUg9GXagDgKn8GzAp88U7u
	WNwuw+os6jHE04S1d7nyALVUwC0FFt4plrW1dHbny5YC0eUGh8cr7L0LRwg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7kabfj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:47 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0sqSV026716;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 4fdygh38nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vkbV029798;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 66G0vk4D029768
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 1A98A230BA; Wed, 15 Jul 2026 17:57:46 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 16/22] iio: light: lv0104cs: Remove redundant i2c_master_{send,recv}() length checks
Date: Wed, 15 Jul 2026 17:57:31 -0700
Message-ID: <20260716005737.254577-17-jonathan.cameron@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=TMF1jVla c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=CJ4IpasinfamSNNyGYsA:9
X-Proofpoint-GUID: XVQcTc7ekVzZbywovVmT3wqhe5aNDfaN
X-Proofpoint-ORIG-GUID: XVQcTc7ekVzZbywovVmT3wqhe5aNDfaN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfXxvj3H7MAxU8Z
 PtFud5keJGN/njddXBo+z6pjQWzxC96o3IVN7n+suOwpWTmgwEj4YvDA6J0Qnyx4lZAwc1IhylZ
 Veli49DN7xG6JJEC0ABHe6v+Sbca9yk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX81/vYiRb2JoN
 EMh1fERsOVd+PjNt3JeWHAVbxyrDDBpJYUfjaUoCkA/+z3ax3qPnUEPm7j2FGaYw3JMbR7gDaw6
 w6PcuSfd3dgOFflr8xjO0qsuzfgzzXaJaeGlDg4JBCa9I51dfSxuGoVBwbm0WBn669vpe3UzPQZ
 n7peuGnREHq0xVhsiCCwMDmDi4zerMYkpvgPU6LT/s27+YT5K3yQkxNmbwVJh+n6A6dkK1R82m8
 zdHM9MHKDh/OnX8Wm+yIANRqplLMBChoJJ82LRRWgkFe5UAROenFyVOyRXSTABvK+ttbdtdG2iM
 wi5gS9nv89HGUZmH5W1wu+J9OiTjUHfeEE1V406oHT+TfKqfsY1cPj/LNU75ygnikpbRJq6do16
 GDtWejAr4BaNp+ZNjSxrtob/5O2++at3qGdnkGNcsQyr/8duKdBoldB1zVUCSfIw3jxwWexsy3I
 84UjEofhDOZ6pcfAkTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_send() and i2c_master_recv() return either a negative errno
or exactly the count passed in, so a length check after the 'ret < 0'
test can never be true. Drop the dead branches.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/light/lv0104cs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/light/lv0104cs.c b/drivers/iio/light/lv0104cs.c
index eba82c334d70..41526c4886d7 100644
--- a/drivers/iio/light/lv0104cs.c
+++ b/drivers/iio/light/lv0104cs.c
@@ -135,8 +135,6 @@ static int lv0104cs_write_reg(struct i2c_client *client, u8 regval)
 	ret = i2c_master_send(client, (char *)&regval, sizeof(regval));
 	if (ret < 0)
 		return ret;
-	if (ret != sizeof(regval))
-		return -EIO;
 
 	return 0;
 }
@@ -149,8 +147,6 @@ static int lv0104cs_read_adc(struct i2c_client *client, u16 *adc_output)
 	ret = i2c_master_recv(client, (char *)&regval, sizeof(regval));
 	if (ret < 0)
 		return ret;
-	if (ret != sizeof(regval))
-		return -EIO;
 
 	*adc_output = be16_to_cpu(regval);
 
-- 
2.43.0

