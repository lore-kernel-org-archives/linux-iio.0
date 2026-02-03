Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E297B285C91;
	Tue,  3 Feb 2026 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121293; cv=none; b=BbAQHkCMQQDRtSjzrpCEzQXtFwQt/7vKVQIDg2OiNAwf4JHxLMPLiLXpOu8uQ5SSOW9zehj0NTL5SC4QG13Zr/WwCjkmkstN0pSXvB3d7tdGocldRufMknwkIkxSy2ewb8NAjirTuLLb1e7g6LE6Bj+MzL2nFJx+FatbXNwreOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121293; c=relaxed/simple;
	bh=pf6YelN+DiZvBnhT4iVHHPIoeEjb3hn4oN8dCd0wxYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olazFH42KmPDXNKrYWA01LcV1OKo6TfncVQ/+P/tQqTmt8+YtPoJs4Heoe6psew0rI86pFwzn10kP9NX5Ua9JX7bLQbgk8iC4kTXiQ631wUOHYtSEQkntnodeO4U94v+LSIIBoJpYBp4Dl5p1NTIijFyYWIEJjWogEhGCBrv+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nuiuyRFw; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nuiuyRFw"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vIX23502497;
	Tue, 3 Feb 2026 12:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=2OUj0
	AdwgtJhPeo1iNKZGuP6jpYnAFJRg5DLiL2QpXs=; b=nuiuyRFwedh19cTxHxbEe
	l8eFWx3KAnax6q3rGfsWRuGpT2ne4tsWAEgNDHGOELfrlxyNPQg+RH8Iw1OnIKZW
	CJyRH9avSwrM1GTehRzKvU4HGqQ+RkhcSeO3scu1KaECbkSkAPuS8oBlX7sAd1jA
	vKcUFRAPMmxQdBJJIClJ4YVjwh3zEZv2ovzJP2xBCc+LcjD47g0YqmEqf8Y7Eb6a
	i8of+pGYYZNFCyleY7IeSufkeEt3ZKCZEeEMvZkuvs1hJbzW1CIfZHC/jN/ttTf5
	FIS3gj2nofbiZD/BUd4mlKY4iLy8l/cvd3G0Ige/Li00Oy1cRUWSLJnOgiaJapwS
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1avj3xwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:21:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 613CEt7S025754;
	Tue, 3 Feb 2026 12:21:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c2578c79u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:21:23 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 613CLCVJ024167;
	Tue, 3 Feb 2026 12:21:23 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c2578c70s-3;
	Tue, 03 Feb 2026 12:21:22 +0000
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
Subject: [PATCH v3 next 2/6] iio: sca3000: reuse device pointer for devm helpers
Date: Tue,  3 Feb 2026 04:20:46 -0800
Message-ID: <20260203122109.689669-3-harshit.m.mogalapalli@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=C5DkCAP+ c=1 sm=1 tr=0 ts=6981e844 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=NZMciLIDH-VbqtUZaRYA:9 cc=ntf awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5NyBTYWx0ZWRfXxyWrqqAMl8Ki
 T8t3f0tANEqnIj/KHWIrh8WFf2aFqOlqgZEe6Lvp77jes8GqJbFszkW1w5JFd8VB02HEt4/lt5h
 EeXGe/jFLE6uSZM8IZcdqZINdaXYLRSfm6KjDaPtTaL556UzoBZ9tbB8YxcqtmX7ZcNOMnhSIsL
 SBLYCI83buu0KKF0zvZ4r2EAfCXFqnSaNQ05MBCOBNRjSTKTCFCiZ1PdgzQEPsrhfrHv5QVsg0n
 wZpQNOEDzmPsZPnQRc6cPD6Za6bRTox5Ae0GLg28XVwWfUlb8JGe/7oheU5gZ2RBapRKctxfpv2
 k0/NMmVdW/Q/feg9HhS2v5IpN941zFFrd5umyvYWuSwpdsucSsrh6DrX/KTEt8B2w+00qK80ST3
 bQx+U4v1YZKFLZVoCFM+6GukHzmwUGdEPyRjjsGBlPx8QkVlLvdKM66TPUlUTGfVGLWSp5gw6n5
 Pw/czLlRAAz8JyCzQdbajT2CNtfB4uYTST5Ps/7k=
X-Proofpoint-GUID: gopoOb_shr5zmGQhcM6CvFGyxw1FICYj
X-Proofpoint-ORIG-GUID: gopoOb_shr5zmGQhcM6CvFGyxw1FICYj

Cache struct device *dev and feed it to the devm helpers to simplify
the probe function. No functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v2 -> v3: Split this dev caching into a separate patch [Thanks David for
the suggestion ]
---
 drivers/iio/accel/sca3000.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index a0b431aff024..afe6ef61a53b 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1440,11 +1440,12 @@ static const struct iio_info sca3000_info = {
 static int sca3000_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct device *dev = &spi->dev;
 	struct sca3000_state *st;
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1466,7 +1467,7 @@ static int sca3000_probe(struct spi_device *spi)
 	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
 					  &sca3000_ring_setup_ops);
 	if (ret)
 		return ret;
-- 
2.47.3

