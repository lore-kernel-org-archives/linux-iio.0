Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AED37756E;
	Wed,  4 Feb 2026 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185556; cv=none; b=M90E8K+eYkoF22mwJiGEaVtmNLAYji0uBzb0bh2LPeqj3CxNKGfGvOp2gkxTkbQmNwUI6+vUc3yPGQFH2isEKp1gR++1N6EbAcAeGV6WTlyIYBi+LHdi+ggJxbmo7ouTveRzMXoENXb7ofA+xaFUe9F+TUq4bhd3qRWlWG1fwoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185556; c=relaxed/simple;
	bh=XUyFGFtrEh0ZPbD0xEb6CrJSYnsMbsd99La1OeAHhJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMpi5OKjdG6stxBfOYG0sLKFtjHYFMWaYVM7EEoIRRgpZ9YfIyjMuOy4gXSCWau5sfhdaxgfgqlxRIX01I/OMpVf20nPemd0un6NQe2YITGIJurw8HIhBn/bP40BR4XcxEV/VVXOFTaX0yyM007V5FrnP1Or3JabfEv+ZlOb3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pUMsv7zA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pUMsv7zA"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6144Je7o1083653;
	Wed, 4 Feb 2026 06:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=euvID
	rOsXWoZLuf1uBMrPX+1OIMIYYC+RyWR1dcS0lQ=; b=pUMsv7zAo/6MIxb8I00wW
	yaNy26VAcTtnwU1dMYtJvQq1l0onXmVZKc2UHlDzLPoeFc7AaOex9Q1Hzz9yNyJU
	r78iFu+LtyYTCyaB3w832Mebzvzu58Cxv/jRX69SsbQGpStcOM6zDUiqzsEr2DLc
	hc9b4+fNCWlWX9CYXFsQO6JaYprdGaJrlwGktIGqfEi6R44JucD739vDQDdKpdv9
	J5WsqZbs1dnGgY9264tYblZRLKJjuGi13dLIWlkF1BLTUzY7FPOWEglxscftHCgs
	lTbjHNsaP9m7j+rCvHS/g0moE7VrK7OBwd1qnfJIqiZlGEuS77b3vgc2jViSy9ll
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1arkwceu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 06:12:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6144dbhL018660;
	Wed, 4 Feb 2026 06:12:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186nhbqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 06:12:27 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6146CNNx032959;
	Wed, 4 Feb 2026 06:12:27 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c186nhbnd-2;
	Wed, 04 Feb 2026 06:12:27 +0000
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
Subject: [PATCH v4 next 1/6] iio: sca3000: reuse device pointer for devm helpers
Date: Tue,  3 Feb 2026 22:11:56 -0800
Message-ID: <20260204061219.791037-2-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA0NCBTYWx0ZWRfXwjj8G00VdX6j
 SP9n4uL+nSLENWNjzqhed+YYyL3NTTPOvZADKx3Je3Z142CgD4b7Ki9aie9vwSN1C5StK7zHGng
 MUrDtohkfOhQ6WMQEIvmLn1+XrzLxm9PozPDAQ1uaxN4rMyGhmut4XZDisiP20UtWSXjT830cVp
 CEa+Xv0YKR80XkIYJ86DPDZNfCPkANhQVSGfjeTZvsYsBo1ewf/akmTOHWQq33bTzkJUqhH0kfH
 CLqDY/jhTp2arQQLA1oUpCPbd5uma6UUH69C94SENN9nHhuIEjtBBCY2k/sDCoyGxfl84lvpR/J
 HfaJgg6GgfB5AdHWoCl/E0dp7vRsZT7NMiAg7qcKLAq1BhHlyqExcLHsp41vDNCXxsF+HGrKrR2
 EfwRZoYNU5+UqkUeq2dw2CG9DzlZ/uh+mM9qwUpaPgbg2aG7dubhT8+xLzE2Wtc151PXOXqFp4G
 X4WRUUJ7Qo/sTJjYMzzWjuTkIB56E/V4gTBh+ZJY=
X-Proofpoint-ORIG-GUID: 3dVI_zgCWhcCwk6bEAB8VBdRnmA_hXb0
X-Proofpoint-GUID: 3dVI_zgCWhcCwk6bEAB8VBdRnmA_hXb0
X-Authority-Analysis: v=2.4 cv=VfL6/Vp9 c=1 sm=1 tr=0 ts=6982e34d b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=7-6Z21dQ6CCI4-vYCE4A:9 cc=ntf awl=host:12103

Cache struct device *dev and feed it to the devm helpers to simplify
the probe function. While at it, also use reverse christmas tree order
for local variables.

No functional changes.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v3->v4: Add RB from Andy and use a single line for
devm_iio_kfifo_buffer_setup()
---
 drivers/iio/accel/sca3000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 9ef4d6e27466..fa0ec2e1a1a2 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1439,11 +1439,12 @@ static const struct iio_info sca3000_info = {
 
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
 
@@ -1466,8 +1467,7 @@ static int sca3000_probe(struct spi_device *spi)
 	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
-					  &sca3000_ring_setup_ops);
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &sca3000_ring_setup_ops);
 	if (ret)
 		return ret;
 
-- 
2.47.3

