Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8313230DEB8
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163475; cv=none; b=aZ2Ng/q0ujWtKw/0HOkXOlidkJ3gVzKcVi0PwU9ksGMRsfNKZPjkW8eBVVaNnpWH8REIinrfyayiVnezVe99BUh3UIHKxkh+7+UuH2LPqsO6rE+5Cqv1qmK5wkISINkzQBtGUdX5ElYrwWIig1ZIoTX9aUPBCBs2Kr/DZJl4rbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163475; c=relaxed/simple;
	bh=979Zv+tm3Q8hsTJnMAPZPjJ4nuW9DLoHd5JvPqmFuHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6QJjsUShSW1Wrqc/AYVBEUgC7RiZeEjy8MO3H0RZxig1bGQ/YHs1As4O2GlkmVVy/kH2Cx1UxO/3O3o+cXM7OATrH279x2KhopWUzrakM7alOdu6l4RvMWyCV8vdaD/eg17JI+/ACPqBXDdYQSe28a9jTZvd/finAz9mJ/05KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j7dxsRFU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j7dxsRFU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0YOos1126408;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ij2khx1qVQW
	vy6YkycBKCjhcI4IUlvsAyJiOhdohfKA=; b=j7dxsRFUXTG6akxZOuXFagUopGk
	kMEDbXltJXUnZaBtaUvJ6d9ct/keL4yqj7eNID76Yf8GuVAtUFkb2iyiNFvjwyOP
	8RT9Iza9fFUadflP3ZOdAAnqBoADdtYnoTAqNLu8oIS/R9uMvbkfFP7c23v/ajtu
	wCg4pHuezLHq1JXqD+xrTGppny8Z0Hoh8keFQUQWz3f7JuPQg30A18CqHeKIqeHu
	vTXa3lfv2xeHbIE+O+p72UqqPSjikuaXQzqe83Cw5XzpRSK63UmFsWLOakPslUk5
	ZrzKqAts1BJSg7uu0CyPWPqX3SGD4qZAWzwFzE+FSs3pWg8etpJ4kP9k6jA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7q639j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:47 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0q6Wi012253;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 4fdywfk3er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vk1X018853;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 66G0vk4e018849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 074FA23122; Wed, 15 Jul 2026 17:57:46 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 12/22] iio: dac: max517: Remove redundant i2c_master_send() length check
Date: Wed, 15 Jul 2026 17:57:27 -0700
Message-ID: <20260716005737.254577-13-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNiBTYWx0ZWRfX+aTznkL2YnXp
 jrhpYI/yxyusApNG8X54XDJo8u0XOFmqGFLVZmdBSbf6gIqA6b96vCfgNC+wXAE6szVJCTj2nzH
 wqXEyFRRP+FkT3leiHShBqLCFfAzsFQ=
X-Proofpoint-ORIG-GUID: 3lE0QNYFDrvXQY-8NH6z7qmgstO1qph3
X-Proofpoint-GUID: 3lE0QNYFDrvXQY-8NH6z7qmgstO1qph3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNiBTYWx0ZWRfX/BSe/GrlNl+O
 uymWXg1QBM3o4OBNJ0/LRxLXyjLRuivVkH8SaM24LbYq5dXRbEda457lpyjbIABstBJaHOVA3Re
 Um2B8sNWQUOKhBDBKyeGFy/+2Pre4Nc2X3JNYDhSkqviMIMFRlR8ngQ+LuraptPAs56a+FmXlw9
 OxmygK+J4Ap53KXLg3WUZ7xp/f4SpxcPOnbpikMxitZox+Q+TI2KOT2e8MJpKwUKXAm4hcc4y6P
 CmceB+MrARSUdr+yun7Xmx4tN3zx3S8JB0rlh0BYHSLwEQqHpGvhoxMgkU+7/YONXAgCSlWwmsj
 +PtOs+LQhXr3HdFBRrPx68ckVk1Y6RT3AAvXS/ix6hRGM8PBFEIkYvULU4fuQEqg1RnKTDE0Op3
 A6elKUv7xoV1RzRK3W0GyLJQAVft7Uw80J6bC06XuvC5+biTFJML8e4rKrjP3BsT1wBCajHht3X
 rqNV/CJjHLsYW+v6LUw==
X-Authority-Analysis: v=2.4 cv=BajoFLt2 c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=r0dgtAz1XB34ppFZNlAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160006

i2c_master_send() returns either a negative errno or exactly the count
passed in, so the length check after the 'ret < 0' test can never be
true. Drop the dead branch.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/dac/max517.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index d2ddc72e0e50..e0d1a26c4f73 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -55,10 +55,8 @@ static int max517_set_value(struct iio_dev *indio_dev,
 	res = i2c_master_send(client, outbuf, 2);
 	if (res < 0)
 		return res;
-	else if (res != 2)
-		return -EIO;
-	else
-		return 0;
+
+	return 0;
 }
 
 static int max517_read_raw(struct iio_dev *indio_dev,
-- 
2.43.0

