Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D51CAA78;
	Wed,  4 Feb 2026 06:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185582; cv=none; b=H+nC9RUHP4RI2wFE/NTuQR1Nk9En+F+tOCejFPWd6iFadvxiebGPsfWctTVu49sgL8R/RpnmgN2BthgosNM/9To9ui043T71lhBsJbA6Yz3S0X8B01ZK3EiuUGAEZLrRJNzauqzpXn+9hMgOmHabJnBN376K4ruOEx19XxeBfIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185582; c=relaxed/simple;
	bh=1rCySF32yDiebvTRRRU+TWuGqgFpFzCm3OAvgYwodeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozg6BlL/994fd+Z6w/sRNx2Pw8aICk3DACm/qzRDO160fkjEcM8iyiTQPWcRzxWR8I/8uVedEECATEU9js6GtFqDQKqlFeICEWqWui2PqkGENELtARzqoz49MDe4LY/mjJBm8vZx9wqdX6fea8nTxUweMkGLmiFfrWRfy/wA/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MBGDH/2d; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MBGDH/2d"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613IuHvi4087925;
	Wed, 4 Feb 2026 06:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ohcuo
	hxaQohL2AO2lfvb1PAi80c/48HAgDp5ft5wi88=; b=MBGDH/2dJtCUJHf4nWfr2
	luKjfScqkHVt1fAmLQJvxyr1b+ZEo7aQde3apppNBURHKurjiCOlz6zVKRXacV/C
	hGHDHkNBYC50s00cidPEnJTHbEmO6jczsi4oRIltHLvXL/R9XyHIXYviC11RyYRL
	AcOguMETvEgZfT3F1y71na4gF/K8N/4yg9fJqRPtCzhuFT18L6qeE3Ddxv5gB+0v
	VjeJGm84iC1Yt2PdGg3GV+HmMJ3YdqKZYm16+fA3cJqoLe+VasEHEVeb+ruKTi7n
	dbn9OkcLkFwRz9EPhdWy3FbKLYUfF1rUdOT9T3cHme0dr5WeKC/abZgdb+YLzJSo
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jhb18m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 06:12:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6145n4PS018919;
	Wed, 4 Feb 2026 06:12:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186nhbyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 06:12:54 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6146CNO9032959;
	Wed, 4 Feb 2026 06:12:53 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c186nhbnd-7;
	Wed, 04 Feb 2026 06:12:53 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Gustavo Bastos <gustavobastos@usp.br>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
        andriy.shevchenko@intel.com
Subject: [PATCH v4 next 6/6] iio: sca3000: manage device registration with devm helper
Date: Tue,  3 Feb 2026 22:12:01 -0800
Message-ID: <20260204061219.791037-7-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA0NCBTYWx0ZWRfX+2mUC8Wkxu+W
 XnzIzE+00bS8k8Wxats549yYEEhC5QF/fAvdJPIxDjEdcWFXxFgqmOBvtP8S3Lvn9khFUePb2pD
 y2XUQq61byzmHQ4KeGXne+SkTKI8wq4CWPtPAU5J4iXyAiJ07NJt13PqrCK3xLvzQpxBNxr20/+
 KEwQf/NPf7/aWaO7tfhsxCoG7ge5ClzCa76eg7nIo9QVzvVdxBWb9XdJgdC2IB4EdlwvHICFn5S
 kN+3fU1cw9PNwTnAenzN+rpYKeQpAWC01NBsp9zF44A7UNMmNaBW7Fhz6rOn1OFWWg4qrdflGk5
 Dpo9GaHX1IwwhWVyFGKIJdQlFE2HntxTtrQvPFHzVlaGhryiWjQMDIl4aRNiaiNLDJx0BwqHQbb
 0dH+2pXwKu8WbqpZ3ofpL4T/nrU0Ul5gELHTod4wHBHigR4qKnt2+JjZCKrYtStqBAMYrZyaHdz
 TyZALKmAmUhLT+dhtKLVW2/IhjIELW5lfh+OnpO0=
X-Proofpoint-ORIG-GUID: X-bfEOADUP5GS6wV6mdX-b9RfXA8VDEo
X-Proofpoint-GUID: X-bfEOADUP5GS6wV6mdX-b9RfXA8VDEo
X-Authority-Analysis: v=2.4 cv=CaYFJbrl c=1 sm=1 tr=0 ts=6982e367 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=IpJZQVW2AAAA:8
 a=yPCof4ZbAAAA:8 a=TX5tIiqRz0IEpTnFED8A:9 a=IawgGOuG5U0WyFbmm1f5:22 cc=ntf
 awl=host:12103

Convert the iio registration to use devm_* helpers so the probe no
longer needs a separate cleanup path and remove callback can also drop
the unregister. After this there is no need for having a remove
callback, so remote it.

No functional change intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/iio/accel/sca3000.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index c3a8f34d4852..88900b9d5ee1 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1513,18 +1513,7 @@ static int sca3000_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static void sca3000_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id sca3000_id[] = {
@@ -1541,7 +1530,6 @@ static struct spi_driver sca3000_driver = {
 		.name = "sca3000",
 	},
 	.probe = sca3000_probe,
-	.remove = sca3000_remove,
 	.id_table = sca3000_id,
 };
 module_spi_driver(sca3000_driver);
-- 
2.47.3

