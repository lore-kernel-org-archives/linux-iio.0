Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322FB350D50;
	Fri, 30 Jan 2026 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809420; cv=none; b=KFYVppvMRYZeJCSzepM1lx1PZ61nYwSqxr80PBuILqWT0BUWiIs7ky68dRzHhiLaZdoQ3ZfA3xOuBZ9RjpzIi/SXVhY0Jj+DTTvKKa4arAt9Y9nQCYDaY8MoxyuxSvBmgx1QceKroNTQOiKPbg2JhIqiUJdETrRFyRmMgLyeqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809420; c=relaxed/simple;
	bh=l7QFZndwGXGNUoBwmvaA5fUdzeL5Ug6CCi7bquxU3O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bu/a6crs3nDzzcZ13Y2HVviql+1nulQwldqHCrPbAc0k1OGnTpeRZpOvgVmWR+0BXKngbSNZ7LKz7oJFqqIvJizThnXUiD227qkByIwR2jShwKmjUC0XfxPJyDw2IphHlhS19vtsmbV85JdnqPuCt3pJNSUw8RmLl3NqLwh49Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K3JV9eXH; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K3JV9eXH"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UKDTIb3407423;
	Fri, 30 Jan 2026 21:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=q5Mk+
	bhK7oDWoawLsH1zgtGmWxM33aPJ8/RoNJ8yWOs=; b=K3JV9eXHA6MFdYoUwthBT
	1LY7U3LA1+yUMxgvT2m/+Ix6JW0OUOY47DPXJxiJmSX9AaGchUMRDXYiPVMWbaQ2
	9PLTxE8NTYcDeuz8cq1xenAukrv0mqviEa1GJn0DEJAY9Axe/AjevJAVzj1sHBGn
	A63y10P5lTiJcpCdhsqVgJ2d6YFwkUeimKoT0gFpF4wKzynrMzPtS3jNPlcEMwBu
	1zsdQ0Za3NXH+tI4LdkUIeY5xAG9HFa5s3puSpj0a9+2Zr+IuNcaFVaAY3Sxz0js
	ITQ2Ppq+TKgMKv4WjGih7MLxPTDvxhrvI5I0iJzoCxdi1o6caPV6HKpRXx91YGlt
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c103e8fh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 21:43:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60ULRHk8036019;
	Fri, 30 Jan 2026 21:43:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhtg549-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 21:43:32 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60ULhRtg035490;
	Fri, 30 Jan 2026 21:43:32 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bvmhtg52e-2;
	Fri, 30 Jan 2026 21:43:31 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc: kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH next 1/4] iio: sca3000: cache SPI device ID in probe
Date: Fri, 30 Jan 2026 13:43:08 -0800
Message-ID: <20260130214323.236389-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260130214323.236389-1-harshit.m.mogalapalli@oracle.com>
References: <20260130214323.236389-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601300178
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE3OCBTYWx0ZWRfXx8kFOsIelinF
 TL3IDFQlwkOCTyn+xd8S9LkI/ft9R+txtnYBxYQEDUdeLjHHgYaTT82rLgpc/CmUrWbr6vtAEkK
 V/nbpxKjacKbu3T7TolVeeGeuelK9HDS8xPSlk7P5Mlxa3QKqEs6PJZgJ+G7ghNuMiWGNz9Q7pi
 rwmS/aBhHGrxHEmsg0o1K2r3Nd6CDkd+95W3i9qQXWeAqfv1njeo4LDGvAlXBBA+T5dAt3u0TaX
 PRN2gcG39gzKjvu7CJk5al6Uq8Ekj/DKhE5kUIAtpTK4QLtPgIYgU9XXWzqUHeYdc0PXSo46aq9
 7Pi+BQElrA6gQ5ST5C/umrZaqr6VyJQPH/e7LE7MGr5GUhYebmqewaQQtJcZBZ+hRQ8bghvGbGj
 L7Gs2mcXlMnDlSEh/mUnxVDO0z2OqWR+ni9TiqizaAOZVrtRK/JsGpP0dJyIqRlZc1hqvujVg8X
 fODT3e5hiwrQsuG7xSVXNbBqYGHjsM6JoHm7oobs=
X-Proofpoint-GUID: x744ZUCMas4IgxCCKeJ27tUzOwU6pmUf
X-Authority-Analysis: v=2.4 cv=M/FA6iws c=1 sm=1 tr=0 ts=697d2606 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=eY56iXQc7nrdnX74TsgA:9 cc=ntf awl=host:12104
X-Proofpoint-ORIG-GUID: x744ZUCMas4IgxCCKeJ27tUzOwU6pmUf

Store the spi_device_id at probe entry and reuse it for the name and
chip info instead of calling spi_get_device_id() repeatedly.

Reuse the local dev pointer for resource managed helpers. While at it,
reshuffle variable list in a reverse Christmas tree order.

No functional change intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/iio/accel/sca3000.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 9ef4d6e27466..afe6ef61a53b 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1439,11 +1439,13 @@ static const struct iio_info sca3000_info = {
 
 static int sca3000_probe(struct spi_device *spi)
 {
-	int ret;
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct device *dev = &spi->dev;
 	struct sca3000_state *st;
 	struct iio_dev *indio_dev;
+	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1451,10 +1453,9 @@ static int sca3000_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	st->us = spi;
 	mutex_init(&st->lock);
-	st->info = &sca3000_spi_chip_info_tbl[spi_get_device_id(spi)
-					      ->driver_data];
+	st->info = &sca3000_spi_chip_info_tbl[id->driver_data];
 
-	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->name = id->name;
 	indio_dev->info = &sca3000_info;
 	if (st->info->temp_output) {
 		indio_dev->channels = sca3000_channels_with_temp;
@@ -1466,7 +1467,7 @@ static int sca3000_probe(struct spi_device *spi)
 	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
 					  &sca3000_ring_setup_ops);
 	if (ret)
 		return ret;
-- 
2.50.1

