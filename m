Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8DC3D5256;
	Thu,  5 Feb 2026 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297186; cv=none; b=qa/i54dWOMQx0EzS+Ck/psSNEb5fdLORoOifQ7hT/7AZa6S/DZdLfn8Pzxc3TAM4wQDdGslC1DgX8/8nRFTWitANA++AsDHnAUv8/E+NOfIAjCs+1w2F4fHvfOIS/1XnNup5TzVlN+jLzbbKjNOAx0i/3a6+U+Vzfn2ePqO0F8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297186; c=relaxed/simple;
	bh=4zDnrqdzDpHCZ4wS99ZfZ6BE+dR4TcsTQ6RIUArG348=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgjA7gEgObTvKGBtLs9pSbmxz+0VJLVcNycj8mIO6ElIviqNVsqqS5QyWVmpU0y/tEgSP5jL9E2qjxVi/xSd65Iq27k7aq4P/ZeMLgrDsjJocG/eubCH90cfVUS9OeuLnNQzvmBgW8Z2Bp1C0E97BJBnye6SHSO6DWAJnRWHzVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=irh7yJsg; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="irh7yJsg"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614N0ECK2453214;
	Thu, 5 Feb 2026 13:12:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ciobe
	DaYHPYvk0AvQJsYbx3h4uoJn8Y9lcrRuMAn5mM=; b=irh7yJsgmFbJhnvcfdxQr
	wzAQVkHIaRYaMtVCTVQ3qC5ygHr0RvyYX9+1qkViyehUZJi18xCKMvKjhiAsXLTV
	kafLqF1TXb6918ZfeO5q+j1WN3V9i9XoMNYSwi170S+L6GvQVqABrXmnNSPnD2Ys
	Q4ZZ3HbFgEKQdoetBnHhMOa/NP2TR9iXoN3aFITooBnx2r7B7aX84/aEEHNj8RFl
	oeXvgV2BHkP+v9+J012AHZQWB9dl8NIKq0UQgxm9bNpJB6nHPF8s6fnOcr9Th9Pn
	4zdLdNCtMMIpFUWV7ifNVi9ZzGxx8tZX/HuQjQN+B5OvhQUN3X3H1zFmtoSQNzu6
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1au67py7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:12:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615C5t20003367;
	Thu, 5 Feb 2026 13:12:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186d55h0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:12:55 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 615DCbE3038070;
	Thu, 5 Feb 2026 13:12:54 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c186d55b9-5;
	Thu, 05 Feb 2026 13:12:54 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Gustavo Bastos <gustavobastos@usp.br>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v5 next 4/7] iio: sca3000: make stop_all_interrupts() return void
Date: Thu,  5 Feb 2026 05:12:10 -0800
Message-ID: <20260205131234.3244467-5-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050098
X-Proofpoint-GUID: XQ3xqDcJEpxZ8cmlcNkE5T-iehKUQK4U
X-Proofpoint-ORIG-GUID: XQ3xqDcJEpxZ8cmlcNkE5T-iehKUQK4U
X-Authority-Analysis: v=2.4 cv=Nf7rFmD4 c=1 sm=1 tr=0 ts=69849759 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=3J4RJRd0aDoy1oOJd4IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfXyLzrHfnmM5dL
 +It8iELMLw1fJszK+11EZ6P6WqwD6nB0ywuFBmp5xn5R3spGWv3lxIuCOuXTA1fUc0jDU2kq8Pu
 bmAFs8NJWSuQZH5wT6zzzGCIEhmfcXsfg1QoN/uufBRzdHdzhWD/WMYkoHPCudpuNaywiQMCr9R
 KvQgDhcxmw78O7BA0K7cyGHGcdkjbIFD2TSF0uOMe68/JSeudc49Ct2dj2zTDR7YR22rem39Wv8
 jcV0zYOs7cDNv1MFYsnQsRq7niGjWy9+h4PhHJHMYKOR8OJZIj+LXJASeDloCikj+vPgID7bs/P
 dqW25Qz+mQJAuK/coTSDmPCtAVO/2LLyzN+u3tf4wighm8c1LnW0ZB5t8Dz/UtY+Q8cJgUOWbVD
 vaeuzPn6usfPo4ulvx6/pHZiAT9asPTy50LJt4uNxJutTehG6+7KkxsVlZ1lqHuMmDH9vnblT0k
 PikOGJhzrZPNwqJs+aA==

sca3000_stop_all_interrupts() is called only from the driver remove
path and its return value is discarded, so convert the helper to return
void.

No functional change.

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v4->v5: Keep the label unchanged as its all going away in next patch [
Based on suggestion from Andy, thanks Andy.
---
 drivers/iio/accel/sca3000.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 53628a0ee50a..d3e2a981874d 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1435,7 +1435,7 @@ static const struct iio_info sca3000_info = {
 	.write_event_config = &sca3000_write_event_config,
 };
 
-static int sca3000_stop_all_interrupts(struct sca3000_state *st)
+static void sca3000_stop_all_interrupts(struct sca3000_state *st)
 {
 	int ret;
 
@@ -1443,14 +1443,13 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
 		goto error_ret;
-	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
-				(st->rx[0] &
-				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
-				   SCA3000_REG_INT_MASK_RING_HALF |
-				   SCA3000_REG_INT_MASK_ALL_INTS)));
+	sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
+			  (st->rx[0] &
+			   ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
+			     SCA3000_REG_INT_MASK_RING_HALF |
+			     SCA3000_REG_INT_MASK_ALL_INTS)));
 error_ret:
 	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static int sca3000_probe(struct spi_device *spi)
-- 
2.47.3

