Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D378830D411
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163479; cv=none; b=ML9/9d6WARDOnuzOGwKhM+sNte8z1PcYgt1w1bAEf9T5Gv+75YbdMI23zFCJ9ch1PNDRNAoKdM89x6NvMqz4bEY/uid3x4UZDWLyw7EtUhh7R7kQT24U7gdKM33CjOB4L3fZoE8tlnqFymQ5vSlhMdvpUv2PWKRk6ttR2rcyxqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163479; c=relaxed/simple;
	bh=epjkjCoqdYPb7uiz2D+mDRWyqnLhYd8KlT7EJ/+/wG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOktDZoYXVYT6OajJFYWGFAjXuphbWXhf3oP0j5LLpRzuDCgbhgX5lVjclkr+CT7J9+cj7tQ0wuMZPPDs0oWTurokqjOPWWhBHyrTpBBHDB0cCGJaaEo4UxJVM9JVVWSUcpzIFd2MfMy20rlrJrp865Dkvnx9M+HX7Mug8Jh3qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vdc9HDAC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vdc9HDAC"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0XdYO1160395;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=w/jdsV0yujy
	dGkLNYfjYD4vpt9/IwHNaJAGE2neEkhw=; b=Vdc9HDACSiIXX9wwfzOxqHPxXZE
	uaj7L5rdTluqi1p25jWDwcrWtL06mm0hxI3rlQ4XU5TzC+Dwro9fp/4fFF/OwwBr
	IwSB22400qYvSg9bX5d+cDULPpFxZ88mLxhBdYAQx7W78eGJOevb4fpneAmzJvJM
	DUNVXqUNQyrqH6iwfB1KO/drqnWSQPlFjBPwhyBpK/+2aT9V2yd9PaWEuLOYGafC
	XGQpfyOBtQADzvynVU3KgT3NTt/c4GcyEfA244oe604JgfY84rp4K91xXZ90eGbV
	O4ZsxqMa1NVBriQKQpQ68GQcHrdQWUxJsRysrRMrV64oaa1wYapKqlL9mYA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feayfjh56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:47 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkA6018874;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 4fdywfk3en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0s8Cr014594;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 66G0vkoY018844
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id E81AC2310A; Wed, 15 Jul 2026 17:57:45 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 08/22] iio: chemical: sps30: Remove redundant i2c_master_{send,recv}() length checks
Date: Wed, 15 Jul 2026 17:57:23 -0700
Message-ID: <20260716005737.254577-9-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-GUID: GGUNrL-MBG-jNl5I2usv1cvINyPos0g1
X-Authority-Analysis: v=2.4 cv=WoMb99fv c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=Bx3w5NfjrIkKNDwUZBcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNiBTYWx0ZWRfXzSHNfqOsxjLZ
 1i0t4B32K4nvcksuNxw12zSHjSgdF/86JU+/8Jdzhv3Yz6VaxmrhtQN5A/NDBHdVeTxIDhH6pY2
 6Y36iVi5hrNVFYFXkpw9F6LCkNEp4DVi/mXeu2GU3OT2DW/qUqsp7UYhXBpBMBMQr2kxiu7r2Sv
 2TBrVcdr4af2ri/25ugi4Y2jRDQBwg3aDFLC9I5yylYMwkp7mQjL+NEtgqGNRQvueigWmLSD9MK
 kdOecbCnC+kfR4nOgWZoJL3FAPCUw7ZnOV0RSf82cAXNoRermNFAcIqNVuYw01XZN1si2x+iFJC
 TE4EeF2g8vr72xTt/iJq6mrstYKPl1ceI+j6vnyDD8W8ciP/6Yh5lRZRA/byyfTay89cH9OAzoR
 NjpGCNPbIPW9fj2KwKP/y3Bw4a7M5kxReDfccO/gQ7m9HzW/Xf7JD3O7GD5vQJCFBiKEm2tS0QD
 ME8LSNq38avaq5K1Vew==
X-Proofpoint-ORIG-GUID: GGUNrL-MBG-jNl5I2usv1cvINyPos0g1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNiBTYWx0ZWRfXzUnerkCcFVe2
 SlgBhdMTqsPNCxNYLvsE6EkzgoN6hPnNs1jWhOSAmnPy22861peVsyINwW5dTQb7PMPvtMGcrwS
 Q3LGYam3+JJzs/Spde3hlfFdjfld1vo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160006

i2c_master_send() and i2c_master_recv() return either a negative errno
or exactly the count passed in, so a length check after the 'ret < 0'
test can never be true. Drop the dead branches.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/chemical/sps30_i2c.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/chemical/sps30_i2c.c b/drivers/iio/chemical/sps30_i2c.c
index 2d3a876cc06e..284b10ef63e9 100644
--- a/drivers/iio/chemical/sps30_i2c.c
+++ b/drivers/iio/chemical/sps30_i2c.c
@@ -46,8 +46,6 @@ static int sps30_i2c_xfer(struct sps30_state *state, unsigned char *txbuf, size_
 	ret = i2c_master_send(client, txbuf, txsize);
 	if (ret < 0)
 		return ret;
-	if (ret != txsize)
-		return -EIO;
 
 	if (!rxsize)
 		return 0;
@@ -55,8 +53,6 @@ static int sps30_i2c_xfer(struct sps30_state *state, unsigned char *txbuf, size_
 	ret = i2c_master_recv(client, rxbuf, rxsize);
 	if (ret < 0)
 		return ret;
-	if (ret != rxsize)
-		return -EIO;
 
 	return 0;
 }
-- 
2.43.0

