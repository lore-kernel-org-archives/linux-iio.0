Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9122C340260;
	Tue,  3 Feb 2026 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121307; cv=none; b=fLvMqbxxMUnzph9VQHXzVbuKdwPQDmRS0lhmyF94Xxh/5E4/BRCmBGYryjtHHRY2r5/2zOTT/H8y2u1HaWumWhPUibChURdSrbDEdY7+F6tsf+zHGzKchJUZtzolB6hQnPfVGHt/2VfLuBZ53Q5+rrsxanR9JWBLAsdKd8gvejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121307; c=relaxed/simple;
	bh=euZ6aA5KaZG4ZNnU99hJ1Z+PyEZxL2Rl193wCsx8o6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezCqGn6zDIJ4i8fXhKqcr5pz5GwTLWjXoOc+CGwL77KdyG/TlTIkvGCKB5o0rs0WrFVb81nLMKKCQsTxB6jTPklpd6ZDhhtN493aI91PwmQIg//6iIeadb3cCItWvpPKJ9SFM+3rTgKAnpNZlKl97eT5lHXfAaRdva4habpuu44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qqH4KLrs; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qqH4KLrs"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vI7j3652180;
	Tue, 3 Feb 2026 12:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=6a5xp
	UUJiqwl77+bCTkDynAEy3biBrrr7vNEAzZ/O5g=; b=qqH4KLrsO47yVjq9m0UGv
	peudQ5O2ffM4gV8Iw+hm7F+ClZJTr8nfxbR1yfmQKaTjSj/cakkd3713ahilhW9+
	cOktdP11qVO/EI3l+zF9mWbnrsZboWo47kGBKoifT72tkqjo/QeVIopRqyJvMMAt
	w2NQTmv4b8J2mn24yi/nFzeHLRqPmhRzadDFsEZXYLkDcyQ6l4Xas9qBRG0dkLkb
	aW2Tt1IpRqsn3WHBfBdf5OyCfJFbPafncP99rUiqVIy5S8fqH2yACZtfoL2usrv1
	V8mgqeCOoNSuIcJffZNG9C4CFxvwVRS6/OqCccMtpXeRXIL8Z65JPAUXNmPYF52F
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1as3bxdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:21:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 613CKAHq025619;
	Tue, 3 Feb 2026 12:21:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c2578c7ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:21:39 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 613CLCVP024167;
	Tue, 3 Feb 2026 12:21:38 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c2578c70s-6;
	Tue, 03 Feb 2026 12:21:38 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
        andriy.shevchenko@intel.com, David Lechner <dlechner@baylibe.com>
Subject: [PATCH v3 next 5/6] iio: sca3000: manage device registration with devm helper
Date: Tue,  3 Feb 2026 04:20:49 -0800
Message-ID: <20260203122109.689669-6-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260203122109.689669-1-harshit.m.mogalapalli@oracle.com>
References: <20260203122109.689669-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030098
X-Proofpoint-ORIG-GUID: qmz79wo84GpJND0luVZE-IA_KYQXdpAh
X-Authority-Analysis: v=2.4 cv=Sq6dKfO0 c=1 sm=1 tr=0 ts=6981e853 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=AKfxoly6AAAA:8
 a=yPCof4ZbAAAA:8 a=TX5tIiqRz0IEpTnFED8A:9 a=4Q71d_afUUiBcdzZNBSr:22 cc=ntf
 awl=host:13644
X-Proofpoint-GUID: qmz79wo84GpJND0luVZE-IA_KYQXdpAh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5NyBTYWx0ZWRfX8q0di+liu39r
 OGYee4ox6YpMKb6KN0xzNJYiwmN11j1y9mD4nSQaubv712J4cEDMRudwaXIBvm2mJuil8/NGvSX
 HpWtQRrI6OnEgTZ4RDsVQt0YBgVwYxfZNh1wnGd6doXZVr4ZyujDhgeB027sJv0Ku6P0dFvan9/
 KBIGSkEAT9svoWZ1FJaiQwOkU0HjmDfpMgL8xjOqtstWQRsrr+P8ky6MxgKtrrIqyUhwBmi82EK
 kCQqQ8sJ5AsSStmE2OsAUD3G3bOOiWp+tcatnSzCHIPwBosI7JSYve8ZMB1/ZbxFyFFR1hqF/f/
 gJex/u30m4Q8HvB2HwocyRFTpPvFqa6OZc9nsvn9hJRSWQuV9nfmS/qFsCgBvadKZLMJHjwlNJc
 k+scovqU0/Pjm/2JLR7JbXIfW55ph80b0P5xVz34Q0rIlXUZXh34kD/wvyXCVHMnfgYCASECT8p
 K7qFfkM1fxIg+668lltStsM8orICry4HdqqhEUdw=

Convert the iio registration to use devm_* helpers so the probe no
longer needs a separate cleanup path and remove callback can also drop
the unregister. After this there is no need for having a remove
callback, so remote it.

No functional change intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Lechner <dlechner@baylibe.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v2->v3: No changes, add RB from David.
---
 drivers/iio/accel/sca3000.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index b89439756eda..419c30453805 100644
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

