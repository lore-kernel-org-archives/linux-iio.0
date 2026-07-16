Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972EB30D3FA
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163472; cv=none; b=CH9g7obWFADUl6Gi8M3n2MYEcnU+IawAHHlk8STDnNjepz7pAiSczKscDqmvd1Df66hXHLrtv6FRUuMUKtCGpn4O29IA5Ul7SCrAE358exKHXBCFsdgz23tYFNYsbOTdlrmvaHASg60PcbqgUvMsGTVdp2SQIgBqd/0Ue2ivzkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163472; c=relaxed/simple;
	bh=LQc7x70w/e/gRpAgAgLRFWLIM2L9fKRk8gcbV7s9dsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTp+bLMxo89reNOH/UZRErSIGQZqT5ZRfhCoopcEQNTpGLcS/lIkqaIvMStlxcZds6uPISAPrci9cJgzTTGLl0Ngud6qooeIs/gSI/N9tJECbrZwF1ra2CtS/PcL6mCiTjorGU4hkYGld67nRSzueVJZdroz4dmWVR52CkKIeSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=La5LC9ID; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="La5LC9ID"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0XBrp997430;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yAg0OSrx+2u
	PMF7y1vZdqaQOntcCHx7jutDfMsSVJfc=; b=La5LC9IDBf+eN9qwVLE8QYDdCIQ
	PTEZF2KmuOMkEJ/yWHuXmPX2cim6Ub+Gl28zDJOQqLI+WF6+2p6dWbpOP/u8VKQj
	Vi3E93PtNNEM72TJ5t8CuKpfAslNGtSlsSCw2dL9yc/sfvSqD+PAuwK5vhgoJyK2
	UnFzePoxjIFlHCbysFizVhuRFY4IiNvd8nX8c+HTZhBM8ax9/OM/UwvHw/H03ZMG
	h9/ovrqOpyenyjC4vY7n3cg2EVm6Brgfi0APVWCBWCnz+8e9TjU7pXT4mEogAr2U
	gGMtde+sMBK0L7ORiJMFPzz6tpWTSYNLtSMmQwIdx5S/JZY3TGelLhujlPA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feehv9bag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkqo029786;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 4fdygh38nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vkoA029760;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 66G0vkJ0029755
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 02B3922173; Wed, 15 Jul 2026 17:57:46 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 11/22] iio: dac: m62332: Remove redundant i2c_master_send() length check
Date: Wed, 15 Jul 2026 17:57:26 -0700
Message-ID: <20260716005737.254577-12-jonathan.cameron@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=ZpDd7d7G c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=9wGTaeRJUmhCC4rX9KUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX9V/N1SJ7POge
 IDwJDL3oyEZy09Ad9/u+MqQCkn6Aub2D4LSUBDmZD7qDtzGx4bqH6w5F5LWVBEHB+7IPsg1oVJ/
 PyXct9pIupUw/Bzy/hrMDMqbqcLsJuxq3X0ZHSQ9GdKkQlyGOaWBrvuU7zyc0UqIv4uU+amz9Jy
 gbp0AJRh3XjSuT7RCpxJYjVQ48B68HyqsCuhSBB1YSgZ0sOjDNqQBBVSbOdzL285E2vZHk1uCTa
 UaVK/4aIL+05K0fPuNM9LpnHHMuUL4wREXhONxwsuBGd3wds2NJDaB5ujlH4rnq+Wp0fdb1FtU1
 KuofKVznhtZsctmtgpK1uUoFgkcBX74962h7R85OV2mhJtv3/87R9w0TnkdUz66zg0orxIomWy0
 TPjZlSvfViP7gFVFY/za7Z1PreikZL5PadzTGZdQ5l4zpuoqpisvb8C2NUSECtlIIz4IdJLcMNd
 OQ5iPAz5/1Wb+/luXIw==
X-Proofpoint-GUID: aMANCvbFVjRSf0AGJUpepEJ20SrNz4kJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfXxZydfiITy96Y
 JWoDrO5wDjz9wobs0EiqmdUWJt5IJ87uXcK7Wrm3wFuFWHqXn6RSssy35JtLay0bfZEehsfFyIq
 GnEyzQpvJyhq9mn31Q2EZY0FdnuCeWw=
X-Proofpoint-ORIG-GUID: aMANCvbFVjRSf0AGJUpepEJ20SrNz4kJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_send() returns either a negative errno or exactly the count
passed in, so the 'res >= 0 && res != ARRAY_SIZE(outbuf)' condition can
never be true. Drop the dead branch.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/dac/m62332.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 7e80c0eb5cc1..a945533a596e 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -50,8 +50,6 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
 	}
 
 	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
-	if (res >= 0 && res != ARRAY_SIZE(outbuf))
-		res = -EIO;
 	if (res < 0)
 		goto out;
 
-- 
2.43.0

