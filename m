Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AD530C360
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163472; cv=none; b=pcHJs22zHVyGUsT7tXPSbOgY7XBCzXJSsPhv0A1Xr6648JMfA+cP7xMiMJ3h8p9ClMclAmslRIHYPGHpQu4sTeDZ1zfUWpPMBM7gMDRtU5jbujFSyhS3oFP99yQMlp3h9UCIl1mrN9bCSXx03tq1apb7ZubaldZR15rWfwKhDIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163472; c=relaxed/simple;
	bh=bJCRwmDGklZyRTZP1tuad63v1M01A4onfHtlzV/sbPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RtvR9PVcMNZ3jmRn5f4YHOfhWwlMIxrgDMvvQmlRE5GsTwE+rbyhCuwOq5aunI9m0bGmnGQ9jKpsqd7RLhJX/jD+kh+R4zldVHuN40tT8NOvjfncPJCAiZxDmygOixcYxydnm/W3OZavA8lidTBsybH3+o9ANccOURJklcRdzhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FuZS00uu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FuZS00uu"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0qCgW1253435;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YkPN3PEuuGI
	4T7aENocEW3bJnfyAebLonv8hnHmURyY=; b=FuZS00uub/rdxsE/8YZgw6JzW+/
	E3Hl+cEuEwRl3mEVgpv51bjay5NFmCB/DQmWJNZSh6RYgch063WjjFSVQygVNBw2
	fHkgv/u4j5uA4DomW0Zk4JJIIYPPXQUOE6QjVvpksMOVkP7Jp4xrAlDXDk0qPOOX
	2WnionSB3lte98/7hdZLXo0rsmKUb9hnW+hqaYn+28nVopo2OH7aEKch3xW4lQat
	oog0kDTteRSho4K3xTHF8phhIFifKELgHzpAQwWRS3KENclsxRWZc40+lZ5itFnM
	0dtx8LVvY9gjlW8uVbk4eZGl1JUhwwoMjJOpzQq5lumDrm2mp0+krnBcchg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fen4w80da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:47 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkTa029773;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 4fdygh38ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vkXi029787;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 66G0vkI4029774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 2D8CF2313F; Wed, 15 Jul 2026 17:57:46 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 20/22] iio: pressure: icp10100: Remove redundant i2c_master_send() length check
Date: Wed, 15 Jul 2026 17:57:35 -0700
Message-ID: <20260716005737.254577-21-jonathan.cameron@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=PsejqQM3 c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=vefV402jATEBxCjMCgUA:9
X-Proofpoint-GUID: H4tgiy33WzBdTVqpjekuylTQvwbr-pj3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX+Ak2RsvcPhEo
 6959auDe4eB04SGCvHyzipf24oMQJ8BJ5KKh5AtXprbbFlL+Jc0ehY/y5Gj7EdIFSw2hxNPI8S7
 M7jp1OykMFuNM4/jQ3+5HytImYPFZkc=
X-Proofpoint-ORIG-GUID: H4tgiy33WzBdTVqpjekuylTQvwbr-pj3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX6qwvAydGLg80
 v95veoMDkwRHv1NQadpoq1lhmT+9r/c+QwoP49F8bwLO5LlpKc3Ty7z0fqn8nNiHiijCq9bgngy
 vAycrJmgLiyz9QbrXj7dYYLJ2IiFbYwjg+PIvoRcvEbPYWpR5VWtGrUcICtZEsQi6jX9/6ZRuTx
 UV6zUMOW3jxhBPFfWV56ZKrVSFyBTvSQqyMHFxvOejQrPq34+UwoEZyZ+UHotfNKiJBni+rEPUp
 tdaYhwvUcvPlpCBmscIuYFzRps+Bz+QewerKp0S9Vub5fStQl18VgeC9ialQZTBPLSiU7LA/G1f
 0sS6EyMOM0lt7F0zFyVFCqX+C87uU/EoLcML00jd2P/TwxY5S4Ps1Yy5CasVcbG0J6XKruk18Bj
 tyKn2WkbHuer4Iau0C5uVeVwRE4mUiwE2VV56b+KovYciNd6COV7DnFo8evHZFE0JY2dcq0aUz/
 wSxuxgRUy/I+ySYtirQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_send() returns either a negative errno or exactly the count
passed in, so the length check after the 'ret < 0' test can never be
true. Drop the dead branch.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/pressure/icp10100.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/pressure/icp10100.c b/drivers/iio/pressure/icp10100.c
index 82824e3e8db9..783d306bd959 100644
--- a/drivers/iio/pressure/icp10100.c
+++ b/drivers/iio/pressure/icp10100.c
@@ -201,8 +201,6 @@ static int icp10100_read_cal_otp(struct icp10100_state *st)
 			      ARRAY_SIZE(icp10100_switch_mode_otp));
 	if (ret < 0)
 		return ret;
-	if (ret != ARRAY_SIZE(icp10100_switch_mode_otp))
-		return -EIO;
 
 	/* read 4 calibration values */
 	for (i = 0; i < 4; ++i) {
-- 
2.43.0

