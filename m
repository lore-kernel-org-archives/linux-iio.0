Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D233A0B0E;
	Thu,  5 Feb 2026 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297173; cv=none; b=BFFSbtZuflFU1Lbc5rcDmj2KGtk5F+oHK8JqTflxim+YNkG6fBKvldoQzWE4IDf2PK/08aQyfcF2jxJuFS3uCgKpJUG6NQD+cy1VzjKHKSpdnqdgHmytVndBnF6054KUvBf6M0ODxCakJ9bJbusxGBhE6WHlATj9NKdfywnxIek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297173; c=relaxed/simple;
	bh=PKTSE3mYh7OcVloe0t2U9BCpsNY2T8x6IgOpbCDGueg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jyqu2E0i//hmvM8RJZ49WP9jCv8s7EGwyJut2kE20vCELemmm2/g2ybM8oEZ9w32dj9hviPlLvyP9CIETFGDP4b00q64KhNsYk5NVtswDjyOD/j6ZsTDs2hu6EMx3FkMeNOtpCc82qGr+DxzQ+JnuE/gGDMUOpmJ+RsjuI4h3Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SnNbETtt; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SnNbETtt"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614MhfQ11789564;
	Thu, 5 Feb 2026 13:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=FFC9F
	vXA6JpOGOmBvUIMQykozeECIB4FNKsq4LYaTIQ=; b=SnNbETttcoPln80u+exo9
	rTpRliXLEiJt7qYHx3XzIjRfi3AgL6a6mDw0B/x08WpDr47hlH+1t4YS9764POiu
	AnihegQQP4yzZYiz/50fsKbVcXHog9VwjfVXRoHVHNQSZ5KRD5MBaI+o8WsMwqNu
	XE9JQoYB7eRTnIKZ8bE64o3if1wFbvSUq92DvbrIzooTNdkVR3uUpYKZgpwM/bNP
	0P2UkJQUBUl0mZLsKl4eiRYWsQYoSrEGYhLw7wQIKhXYDVD2O85Eq8fsnSRVBz+g
	zEveDPuRf65VsDcVtEGrvLP2FGFlOe8nGuZq8z25SxZhsV464m8PmihbRWiIfAPH
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3j8ukr0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:12:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615B7Oc2002721;
	Thu, 5 Feb 2026 13:12:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186d55dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:12:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 615DCbDx038070;
	Thu, 5 Feb 2026 13:12:45 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c186d55b9-3;
	Thu, 05 Feb 2026 13:12:45 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v5 next 2/7] iio: sca3000: switch IRQ handling to devm helpers
Date: Thu,  5 Feb 2026 05:12:08 -0800
Message-ID: <20260205131234.3244467-3-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: 3bxyNQQf_Rlhr1cDvFPeCQC2sWNlWZnG
X-Proofpoint-ORIG-GUID: 3bxyNQQf_Rlhr1cDvFPeCQC2sWNlWZnG
X-Authority-Analysis: v=2.4 cv=BJS+bVQG c=1 sm=1 tr=0 ts=6984974f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=IpJZQVW2AAAA:8
 a=yPCof4ZbAAAA:8 a=GLDwehOdoewJnJclP7YA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfXzbQZ+W8MmwSz
 pIKBTHWmZSDLoUO/UXdj0Mtj6oqE2jRm9knV9eqpmYnRqRAdErChUO/qVjBLQr5lhOOmkkqwcIF
 6IHAIE6pn3w6iQ7RVyH8KvoRSaWD/RFASI9ka1sDunsi43ogmzDmv0uJ+H0o/LLTlzuSslOiCPQ
 fqUGfqaww09mKkKNOfeySG3GmRs4MuW+ARZ6IJloTie+/s1aUK7p5rhnrKU7Znu+ty3uIDAawF5
 f6oa1ks0iOZ81Z2gWmJjDPTdSlLDIfkkyVJXguMV7OsQ60g6dQMWDuyKHSN3ZNn1RkyQn7ofHis
 8Mqxi0+BucRltI30R0zJinrahQPPKVkgau0rvt8gf/MJlz9NmVRwVjJuf6uBUNKE/lsCHLa5eb1
 tUfyHpvxasTwJCNqsfBm+JxOwqef0C8BsgYt8/Q2PsJuEk6aTLJFuc2NhtP9pZmZoDe5P+lyYFn
 uY6o+/Q00dJ1IT44gYg==

Convert the threaded IRQ registration to devm_request_threaded_irq() so
that the probe and remove paths can drop manual freeing of irqs.

No functionality change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/iio/accel/sca3000.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 43373c798714..e270f445bb35 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1470,34 +1470,27 @@ static int sca3000_probe(struct spi_device *spi)
 		return ret;
 
 	if (spi->irq) {
-		ret = request_threaded_irq(spi->irq,
-					   NULL,
-					   &sca3000_event_handler,
-					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					   "sca3000",
-					   indio_dev);
+		ret = devm_request_threaded_irq(dev, spi->irq, NULL,
+						&sca3000_event_handler,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						"sca3000",
+						indio_dev);
 		if (ret)
 			return ret;
 	}
 	ret = sca3000_clean_setup(st);
 	if (ret)
-		goto error_free_irq;
+		return ret;
 
 	ret = sca3000_print_rev(indio_dev);
 	if (ret)
-		goto error_free_irq;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_irq;
+		return ret;
 
 	return 0;
-
-error_free_irq:
-	if (spi->irq)
-		free_irq(spi->irq, indio_dev);
-
-	return ret;
 }
 
 static int sca3000_stop_all_interrupts(struct sca3000_state *st)
@@ -1527,8 +1520,6 @@ static void sca3000_remove(struct spi_device *spi)
 
 	/* Must ensure no interrupts can be generated after this! */
 	sca3000_stop_all_interrupts(st);
-	if (spi->irq)
-		free_irq(spi->irq, indio_dev);
 }
 
 static const struct spi_device_id sca3000_id[] = {
-- 
2.47.3

