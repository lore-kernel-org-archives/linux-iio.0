Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E5C3A0B0E;
	Thu,  5 Feb 2026 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297169; cv=none; b=DzJbmqmDp+g5IoKOjEJdzsgRtL380zbxSSvFvNECnX+69eWNRMEYMyWHlUQeDOJjO2CyOrolSN5H/Fm1aSw7d3OPgdy1WDEnBBxkhdoEZX3bKNuqi2zleHV7rfzJyP2ysVHNVTKzdThwX1LpTgiLFvYl28kbCN5mQ0sXGPdfZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297169; c=relaxed/simple;
	bh=/c7HVVnHddzcq8j8oLWvARrJnqprphShQiAUeRe8t+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKx1QL3ja6WKwV9NQH3VNRaJIYB53DEGzMhu6irtqLZFWfTBEtP9ybd7in1yd8vMhbTpx8TSB1kMZIWIRXXmTs6FFunJE0xO/6gaWD+QUYxcERfFfnEPsr2fQJ6/4xGFuRHxpFnhbqi8gRuLYQpmRC/4tEYBcOYi2Ux6y+n8v2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SPzeiZbq; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SPzeiZbq"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614MbsKh1792231;
	Thu, 5 Feb 2026 13:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=5bUrS
	2pO99877gx2Hcblau1sxSm7LFJxG5ZggOTZOXo=; b=SPzeiZbqAqkuVaxAwJOo5
	Cgilw/JBYoA79Oyrx7chxHfBSsAQviuAUauhsWay69zuy761ErvVo+IIJarIqWbJ
	+tYHOQ9zU6vhy2vLFiSP8/kGy9Bf4R6/+uWZy5I30K7D5BrNw3zj8oyePCtiLLhW
	kN2z5pOIu8LT4/lmsCf0gDxJZ7WpIjBIGBxq3Dn5xD5y4oam/Ib+89coRSSXJ9+K
	N91Z4+qhYPdU5Q3TDPqDbDDCDYHQKeP1Zd6Uu3zCD8ds5RBK55yt2ma3IOpWtJln
	y+QfPR53OBOKWFbyptYnUmLROsZW14iJDCATRXR62Rgfp1xb0JzRTUqTyzEWJMu7
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3j8ukr0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:12:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615BWRuD001253;
	Thu, 5 Feb 2026 13:12:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186d55ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:12:42 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 615DCbDv038070;
	Thu, 5 Feb 2026 13:12:41 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c186d55b9-2;
	Thu, 05 Feb 2026 13:12:41 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Gustavo Bastos <gustavobastos@usp.br>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v5 next 1/7] iio: sca3000: reuse device pointer for devm helpers
Date: Thu,  5 Feb 2026 05:12:07 -0800
Message-ID: <20260205131234.3244467-2-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: McCLQLjsV4BJIAMotUucIzHaacMsG7Qs
X-Proofpoint-ORIG-GUID: McCLQLjsV4BJIAMotUucIzHaacMsG7Qs
X-Authority-Analysis: v=2.4 cv=BJS+bVQG c=1 sm=1 tr=0 ts=6984974a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=Y1h7d2OGzECVDNLjVKIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX8Web8d1myW2T
 lEyqZoFYztjZwCMV5tDWjaF6dm38h3Wp3Bm8PuQB4IELc2fLNuYg27TLkjIPiuBWvJLurdXoCEN
 CSH4WNAKzWugZL47LVyYTVstkfqoQTohmYLqMIpoV8GyUDmakMhly79J5YTX9QHWQtWvisF7pFv
 HAVVRIlgm/Wkf2gRYYNhL7LIv0k0fHr3VfpnQzQrm3ed0wjQQbEkDNVmWOgr+2oqOEP0zvp30VL
 p3iKMSbWq6dL4rS9ULmvbn9copeu7hZnpy4uMM0UgacW4kr5hp6Os/+T+ZkE51cLmt0ZWJt+FGx
 RaDA40rQncco+26VNYaKjkrVgo1xI5N2KUt+iI5WIDFckcLTETYBghS7Q/LpgGdCOgKaexHdnaB
 AddA/yDflCwQKtxUHp9uDhyvfgCnGNiUbWxcVs0aAxIwoThI4O5kl+1Ce+PuhzbQZ5CKOn8wSLj
 SAaypHAY4lcMc1898KA==

Cache struct device *dev and feed it to the devm helpers to simplify
the probe function. No functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/iio/accel/sca3000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 4a827be439a2..43373c798714 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1437,11 +1437,12 @@ static const struct iio_info sca3000_info = {
 
 static int sca3000_probe(struct spi_device *spi)
 {
-	int ret;
+	struct device *dev = &spi->dev;
 	struct sca3000_state *st;
 	struct iio_dev *indio_dev;
+	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1464,8 +1465,7 @@ static int sca3000_probe(struct spi_device *spi)
 	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
-					  &sca3000_ring_setup_ops);
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &sca3000_ring_setup_ops);
 	if (ret)
 		return ret;
 
-- 
2.47.3

