Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B4230EF6C
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163480; cv=none; b=T+xumq0sRk3B6qkqW3et5tWNfrV+i7sHqalQgHkmekMpHWSGMrfoI4BimQAQ5Eq7DhnNs7ff2p1udsdcUAVRnPSGHlCjGzkYM6xUVyOJ2MjqwlDmoM1sjLCsXp8IhlwwDT/uMO4TOTx8I/O8MbyQ6SCiJM8hpL77d4exO9gmvqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163480; c=relaxed/simple;
	bh=tJUQT18336l30D7+oiUKTgGp6jtTxON9doqmKEYOvR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4uytzDdclONIKqY6Q5eoe5+N10Ge0XJPoTFFksBbUGQwOpSNHMiJRuTk6vttNLE1hOP6G+bMAXPoB/NoL1avfHPKayMVXFmZdfTdB2NBpwwKToeJ8rDY2XFvDo17c/A7L3ChhhRbJAw0JtUO4DovZ7AVUtgHkwuPLPEu2cTReg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FTlLhVXO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FTlLhVXO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0XXww1107758;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=m1lzpAM4ccK
	D4/oI3ZjAVi0SLsZuqkK/1/0RsUKMGGM=; b=FTlLhVXO5gC92Q/2jzM+SOW0EcA
	R/nTp64cpbrnHio6HMIm4OjzPoY2gAYGq4cuAZ6ZZsFwzffYpJPjLlNJ25hPfgvv
	JRqvDhq0v40oG8QfXJoDnyBqh0sI1T2G/K0fxx4wZZvT8BD6jwVswJCMvuX4f0+q
	JyHvWQWS0ihFThGbVZgJtf13iDm63GzFH2H3sKnbx/Y2LcK26q78ELkDRNbr6SY5
	FG5NaRKjJRQY8lj7S0soxK9Plj1vcsaZ/kw3f9us7Dv9rDJv56feQduoGa0Obdv+
	2LlwB1Eki+a1erz2xpE4p5Lb+G8ITcoxucchhZ9YQ8l1BnfjKoxddEidwBA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqhbcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:47 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkE4022733;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fdvwh4ex5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vkJV022708;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 66G0vkKq022705
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id ECE6123112; Wed, 15 Jul 2026 17:57:45 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 09/22] iio: dac: ad5446: Remove redundant i2c_master_send() length check
Date: Wed, 15 Jul 2026 17:57:24 -0700
Message-ID: <20260716005737.254577-10-jonathan.cameron@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=A0A0kB7fLPKLxZo5EqIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX0S0T9dBF4mOm
 bSArhBys/LzaS+GlN/G8hmIignHuu0ogeIvmF2bTbMCnwYwzwVt6b5STFvss15OE6K9j7NcxJHt
 J3oLZN752A7SxwHBEt/0thNS2IBM1jA=
X-Proofpoint-ORIG-GUID: PFIlC6HYMrkYzUzK60dmA5w-mt2p8QMa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX8chkltLxN6ep
 VzLidGUjB6fLRMUK8sVo8PICZcQWDWj3el3h1PrTs+MPd3PQOQHoSqim30PptS90JkAwxkaN3t9
 hXKd9iKvIxUJ3ASlaMIpH6oaSlGDkLGxOMUbr1UqeB/1ZprGZwOPt6aHgP90GRLbRGctu6vjbJX
 RjRIhTnSmTwCL+8iiByn1RlWop+ZajMJ8fbR7LuW4TjNKSr6ej5mVmg/jCULxJAVBxwuXXZ9CnI
 6lmPhmBd+Ipk+F+DRSQ3xLJ3B1FBXJbvdx7fsgTqqiPtliwB9uPlqInTY3InXos1GZnQqIRKC27
 cMWLHoCfVPB6zs2fVNUs+shC2Cbcq0VsO3AV1ktoC9ZtWUqUh4DCZeAG4jDoYjkcgQMetPP10CI
 a1q8sqlF1vqS+Q6Qnoh1O6pouTeuhF4Khr3NSut45sSJ6avck90RJ6ELbAqtT66unTXYKtnHzah
 sBKfeOjQok9A7g8N0fw==
X-Proofpoint-GUID: PFIlC6HYMrkYzUzK60dmA5w-mt2p8QMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_send_dmasafe() returns either a negative errno or exactly
the count passed in, so the length check after the 'ret < 0' test can
never be true. Drop the dead branch.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/dac/ad5446-i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/dac/ad5446-i2c.c b/drivers/iio/dac/ad5446-i2c.c
index 9797fc3e57a9..0a01445f7a82 100644
--- a/drivers/iio/dac/ad5446-i2c.c
+++ b/drivers/iio/dac/ad5446-i2c.c
@@ -22,8 +22,6 @@ static int ad5622_write(struct ad5446_state *st, unsigned int val)
 	ret = i2c_master_send_dmasafe(client, (char *)&st->d16, sizeof(st->d16));
 	if (ret < 0)
 		return ret;
-	if (ret != sizeof(st->d16))
-		return -EIO;
 
 	return 0;
 }
-- 
2.43.0

