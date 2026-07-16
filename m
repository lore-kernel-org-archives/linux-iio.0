Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9672230E0FB
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163473; cv=none; b=umby1SrzuuNLh2gQxIkKgRkTW+YkkqYK6qKrQVAG8S73VcXY5hZZqrx0b4OIo/YY7vyLBZCaPN8mz3NSQCOBg26tBjPmwiuw1f6MBGTrUa9xcAD49K57JaR9o4Q5RHYB/ouwT+KHd3uFAOTSDuZ/IF9k211/oEKNSIGpUsn2VVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163473; c=relaxed/simple;
	bh=PtbLMJ7C9uSHeiu/uI+CXJfovW9Sih9XqJI+b+DhpHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrXwWith+gMZh99kAjpyUxyCEAHjATnuONVKoFwLNXVp+R0xKmnPLxONPg50/0ahQs2IwCyZ8o7VS9xWCQDYy8AprCsWGiWSi7iRGYDLHRpB/fIdmFWXbq9/xLhmyFIw6ivsEm5na/z5QwzNSWa/mYEVUT9I3TQ5tbDVX/fuC4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fXMWbTFX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fXMWbTFX"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0q7eG1253061;
	Thu, 16 Jul 2026 00:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=svRYogxpPc8
	VpVN6iieRUAL7oUw1Pb7gdaXWNpZqtrY=; b=fXMWbTFXJisMrUrViFcwQzBv9QL
	poH23r/xv8410hOwJMgItUu9leEDtFyUjuhuYD+MgjnnvoHHojjEa3c5vOVUl1WK
	vsNgqGq2XwYLdSu/Yx+57cMa6z76N0bjemavDTghShM5vELwB8qXspErI5G+1+V0
	YigQF0Hmv86Q1YzefU2D50u9kMDh8A+KAigg1MeaKqQprG8pA0qsKDXSX+zjNGdY
	oAUWtomji341B3oaxcgnUHVixXBxEJIuztjRs2s/JbXez7MYUQVqN0jUCHsRj2iN
	XRWHNDPQtsYP+xmFr4lnM2gY72TsbnmaYRbZ6Bmsk6OOm4MtdD4/gyu1Vkg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fen4w80d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkTZ029773;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 4fdygh38nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vkJA029754;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 66G0vkXW029750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id D91A6230DE; Wed, 15 Jul 2026 17:57:45 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 05/22] iio: chemical: scd4x: Remove redundant i2c_master_{send,recv}() length checks
Date: Wed, 15 Jul 2026 17:57:20 -0700
Message-ID: <20260716005737.254577-6-jonathan.cameron@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=PsejqQM3 c=1 sm=1 tr=0 ts=6a582c8d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=k_uKFR2PTYDLZdHsI_IA:9
X-Proofpoint-GUID: hIQ-TPar9ztxhWuDX42EN3W4O7-dVjdg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX18gwTMw+eouE
 2HyHNHvdTtO791OFccgx2i13zTs5Hurae+8i9q118iXZDXSsVpX0bm8vdta+6Gjp2QxgRxELoCu
 GP+leC9uqqYyREZ8ouYAPYpga/hB+8k=
X-Proofpoint-ORIG-GUID: hIQ-TPar9ztxhWuDX42EN3W4O7-dVjdg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX9uc1/27iULKi
 IzIhcn2UezOyNDpaJJo4YX58OW38+Tdp4+L7YoWkvS/RxiIv2TvL3OegKpVidcU6MuY7fZ/SsVC
 Hrrzq1DFWTL+OLLTIbEOdRbep+AJMJzTpZlhgxGpX7ETBxES72zXgwS2ehhfgTLiJqRerPXWO09
 t4bjJ5RHBgJNWmNSbSHp27FKCkbOzYjAhhFeTI94R7Knj+Pt689LE1FDNMxbnkAErgAq472o8MZ
 pt6hoYipRGn2QaWrsdgTco09p85OTwO03VvFTEO3NZpGfrFTwWizprC5u6B3bY1K4riczY5Sjiq
 pQC9z5NeKnSN+tOMw7houql8HdeFqyrSXbht8T7L9AQtZAIEbzdrDS5TkxAFL7ifcPt3WH2jxU5
 mvT7zRcxtS+fP/NxVaINYbrKilujL+9CnZyg7PrVWqPI3zc8RsEExDXUW1Mj2ZzaZLqT5Eg+EoZ
 TzUad4+V7tMA/MJPbPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_send() and i2c_master_recv() return either a negative errno
or exactly the count passed in, so a length check after the 'ret < 0'
test can never be true. Drop the dead branches.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/chemical/scd4x.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
index 23a326fb62a7..b52072a4eb65 100644
--- a/drivers/iio/chemical/scd4x.c
+++ b/drivers/iio/chemical/scd4x.c
@@ -82,8 +82,6 @@ static int scd4x_i2c_xfer(struct scd4x_state *state, char *txbuf, int txsize,
 
 	if (ret < 0)
 		return ret;
-	if (ret != txsize)
-		return -EIO;
 
 	if (rxsize == 0)
 		return 0;
@@ -91,8 +89,6 @@ static int scd4x_i2c_xfer(struct scd4x_state *state, char *txbuf, int txsize,
 	ret = i2c_master_recv(client, rxbuf, rxsize);
 	if (ret < 0)
 		return ret;
-	if (ret != rxsize)
-		return -EIO;
 
 	return 0;
 }
@@ -241,10 +237,6 @@ static int scd4x_write_and_fetch(struct scd4x_state *state, enum scd4x_cmd cmd,
 	ret = i2c_master_recv(client, buf, response_sz);
 	if (ret < 0)
 		goto err;
-	if (ret != response_sz) {
-		ret = -EIO;
-		goto err;
-	}
 
 	for (i = 0; i < response_sz; i += 3) {
 		crc = crc8(scd4x_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
-- 
2.43.0

