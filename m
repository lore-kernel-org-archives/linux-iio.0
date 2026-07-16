Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42B30E82E
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163477; cv=none; b=pFVNV98GwQn0IZJKtPGB6j4QLYMY99G8gTLvYBry3+X/hXxfU8VX7l3/w5AAmlbBW+pOCYTVmN1ZxYJuRG80qQI++nhfaanjElXktcNHvLVAsO3wpNlVC1f27NjSJViYoknj+Jb4IJuWmWESYL2JvAhla8IdWpT4kVKzE8dcoKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163477; c=relaxed/simple;
	bh=SgSlPpvU7uJu+dmoeTeHYXsY2yybPC4tVzmrOlK+L+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMzMSOEEhDPqVtA9YDJ4u/zaPbX5U987qEeAbxF1nraeZNHXUi8h6SmpAVDxIAZa7lOCGR62Q20bb7zjgCg39VU1Lb2sdGtMKegSEc9laOBpJaXEv2GYTJjzEH2Dk2zLInslyMjm8jd4If2bRGbrgI3RNnCbZvx3bu4juVySD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FjGVTwlS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FjGVTwlS"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0Xn7T1226890;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=IcSKKrbyIwM
	kn4tCQWRqN6NjLC3eaQwH3laEpD9QfWI=; b=FjGVTwlSKcUcNyOftWQ77rZLvPb
	rEv+o8uIwoHDrrVWsWiRBDU1RHUQD2Lbt2wXdFKajXlNKRPhP+jQP+PWCVZ42wCR
	xLNo2Z00J4xucTTYoAsU4/13x7Kpo5ZYvFMVkFVTFdCHqvZ0vuV7mA66jlDbtfh0
	ROpXEuJkG1o+IXf2ekajwsz/WTOq3ovKSoA9bHE9GEijwAfojWqNsvyMLBihCsNw
	vNpOPbkiUDq2XYAkhzv6KcpZq8vu9/WR7feQUj11JMJTtTVkykqW/1T7rOiOWiYI
	HzLoXk6oH6VllUxr9O7Axa5KtZjjfAe4Yy39kwteOJqzh0ujCbx2AJkd7Rg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feeg1hbxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkVu018846;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 4fdywfk3e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0s8Cp014594;
	Thu, 16 Jul 2026 00:57:45 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 66G0vjeo018835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:45 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id C9593230A8; Wed, 15 Jul 2026 17:57:45 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 02/22] iio: adc: ti-ads7138: Remove redundant i2c_master_send() length checks
Date: Wed, 15 Jul 2026 17:57:17 -0700
Message-ID: <20260716005737.254577-3-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX9ACDzBAJm0M3
 8roWjTtgWiYSYWGjgaDU7ncEwCYkvvnz0Z0bjmwnYMn6iKvDLRy2VuCEKU1j8m53qtlVqkI8Irq
 rt4SZW/+gcuzub/INkln4Tc1gXB4EBunE8zlyv24KtkNEhhf5TQax6cBb9wWYEQnddREwgdJsyq
 O2zEljPtOCwRIXT3r862U0vmFxtfgkNAai0v2x+YTRkg0dubtfP9ggFP0vp31IiCsc2tRz7HuRs
 xuOULTTTbkcmjDWV8MSXzBslUrN1Bs0U1bX8mzLY2wdAoaLh4rDSyfTTwnHIJx3zRDOMHzdm3L4
 nfz6csPLRM7cs5u1RE40WLD5G3wfxjTmrVTXilhbvZ8WraKJhfvbx4vuE4OgvesgdSnVEP+L6Hr
 V4VpoqFywnG4jmzKPBCdHb+3L7w00xOU9yufRbvNRvRmjdYUG5dN2Z8d2fv0qC2nOh3pdXprGJt
 xyCNnhK7ud3Wg20R6sg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX65VEw0vNbiWY
 E+C3B4sSgJnATATEk4OA9BzPdvPomEf5jS328UJLsIkkTmE9Y3KMYRIdW/r+7/tIT+gvflhrZxx
 +vPuwzb+ceZlN6igv4K5fMNfMcn5CK4=
X-Proofpoint-GUID: 47gnMW8_IjzAHy7B1oCiG3MvIYMqe4aH
X-Proofpoint-ORIG-GUID: 47gnMW8_IjzAHy7B1oCiG3MvIYMqe4aH
X-Authority-Analysis: v=2.4 cv=SsOgLvO0 c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=-wwdGtABmJBr61P2H80A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_send() returns either a negative errno or exactly the count
passed in, so a length check after the 'ret < 0' test can never be true.
Drop the dead branches.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/adc/ti-ads7138.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
index af87f5f19a0f..afb20accc170 100644
--- a/drivers/iio/adc/ti-ads7138.c
+++ b/drivers/iio/adc/ti-ads7138.c
@@ -116,8 +116,6 @@ static int ads7138_i2c_write_block(const struct i2c_client *client, u8 reg,
 	ret = i2c_master_send(client, buf, len);
 	if (ret < 0)
 		return ret;
-	if (ret != len)
-		return -EIO;
 
 	return 0;
 }
@@ -131,8 +129,6 @@ static int ads7138_i2c_write_with_opcode(const struct i2c_client *client,
 	ret = i2c_master_send(client, buf, ARRAY_SIZE(buf));
 	if (ret < 0)
 		return ret;
-	if (ret != ARRAY_SIZE(buf))
-		return -EIO;
 
 	return 0;
 }
-- 
2.43.0

