Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDACC374758;
	Wed,  4 Feb 2026 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185566; cv=none; b=eB1jymIqRWaUP2+CBeUyA/pTcO9brRQO+8LYecgPrTR1ih2HtJiCXDQwtG8wdyHmHsT5Pk77UPMbcuT8DwYPKagr/hMkjhKKpKJ8BdR8H/6IOUBotdygWgSrpDuLvNUTqExMjYlWDZjlFD8HNkZdX2gchi36R59jyTIdzG3dmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185566; c=relaxed/simple;
	bh=AqSH0mAODuY+6aFj03LoC11FUPB04+XbTWG0dRzkTfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zzm99vvSoKFgzXSk/9ca0JzO2pmnt904Rs3jPGBAXWpaHal95QRq3PhQ78l4BI11WU3CuuE94+VF6tsa8/Jt1ebQ14kF+Y+6TuoDyBRceYUT8b9wCnZHVrYAJHtzgKpMzcFDnsP15QCBubyEGODJu16OczR7wy3teH8ZSTGGGhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FMCh2EoU; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FMCh2EoU"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613IuFeX318462;
	Wed, 4 Feb 2026 06:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=d1bQA
	LcdeCKZ50/FgwT8Y1MUiiGiMEmxFdOShjQk0dg=; b=FMCh2EoUM9ATF+1Dod1HO
	e6XRS8u9TaNNizRqosaVXit3HMj0Z29YiOVaH/wKL7UffMnYI4iY9INNV/no0Pcs
	34EauJdy+bip8RhDbh/+tIuu+h3H3A2jtH/ABRkuaLskA6Q1HvO444Bhy/ImLGxR
	Tjw7PPtWAgn5DIfu+u2luXqnTdIZqLwr5GxEpucBIDDyNt+Kzbwehqpi7LdQGOAK
	9MpbZjfH1h+LPjgSc+ajbhDVgmsdhACIGpFVlYUtfg9hOCorY96NdUxDpLT97Lug
	mFoONQgHMTEsFdo9jnk6vXFV6yHKx9aq5qV2KkWUuUU1be8ilghNtJSTytpsXUpi
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3k7uh52s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 06:12:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6144pRMe018920;
	Wed, 4 Feb 2026 06:12:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186nhbtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 06:12:37 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6146CNO3032959;
	Wed, 4 Feb 2026 06:12:36 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c186nhbnd-4;
	Wed, 04 Feb 2026 06:12:36 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
        andriy.shevchenko@intel.com
Subject: [PATCH v4 next 3/6] iio: sca3000: make stop_all_interrupts() return void
Date: Tue,  3 Feb 2026 22:11:58 -0800
Message-ID: <20260204061219.791037-4-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260204061219.791037-1-harshit.m.mogalapalli@oracle.com>
References: <20260204061219.791037-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602040043
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA0NCBTYWx0ZWRfXwhdv3Ym7ild4
 gKIry2xAEtb/hOxt/w/0bER42OEUznXRbdUVZJBaSS8u6xUmvDHqe38VYsPmiDzZ1ju1bYtg9M5
 12LaH8FmkNAcKlnbm+a1/dgjKEbYPrIbACotX7IIby2ECaKqa4FZlzhMuzarwP/hOGfJXuUY/Bx
 kTXC6H+S93QoKFZ2EPvorn9wUK78vqk+0dCtW3rdugy8oDHONenq/o/XWKlVFz1/e709SChIrp1
 04ljv9C/G8MqK7S5eWGhjgoe0KExQpccx1fLSRjuVAvkOeDFNIpqgGU95yrXvGo8orS28VGzYXw
 IMzyJn/dFGtexQ5Fi9Z6eYT8hhPlAra3CMpMno8v2Xhvany2ezQEcrdF95Y2G4zo6ourY3zVeLY
 lH8Tr/BCffE0ra9u1M36H2dMbetQQsLRC09Q3a+Hrb0wE13L3kBT/yeIjOYzp7XiyZjD8E6Jnmb
 OmxvOH3xmhRK+droeIUxpO6g2Xtxq2Vs+34l5Fbw=
X-Proofpoint-GUID: hvADGnkdYKsW3MWfw9Kt3-fl839P5YXj
X-Authority-Analysis: v=2.4 cv=Z7Dh3XRA c=1 sm=1 tr=0 ts=6982e356 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=_1GDA9l6zoHD2SEvZEwA:9 cc=ntf awl=host:12103
X-Proofpoint-ORIG-GUID: hvADGnkdYKsW3MWfw9Kt3-fl839P5YXj

sca3000_stop_all_interrupts() is called only from the driver remove
path and its return value is discarded, so convert the helper to return
void.

No functional change.

Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/iio/accel/sca3000.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 4bad152009e8..f9680071bbbe 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1495,22 +1495,21 @@ static int sca3000_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int sca3000_stop_all_interrupts(struct sca3000_state *st)
+static void sca3000_stop_all_interrupts(struct sca3000_state *st)
 {
 	int ret;
 
 	mutex_lock(&st->lock);
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto error_ret;
-	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
-				(st->rx[0] &
-				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
-				   SCA3000_REG_INT_MASK_RING_HALF |
-				   SCA3000_REG_INT_MASK_ALL_INTS)));
-error_ret:
+		goto out_unlock;
+	sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
+			  (st->rx[0] &
+			   ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
+			     SCA3000_REG_INT_MASK_RING_HALF |
+			     SCA3000_REG_INT_MASK_ALL_INTS)));
+out_unlock:
 	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static void sca3000_remove(struct spi_device *spi)
-- 
2.47.3

