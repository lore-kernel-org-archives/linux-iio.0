Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0787B285C91;
	Tue,  3 Feb 2026 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121285; cv=none; b=IFptc8Xcw8oIHMsXZvtPTIQqIVQ/Sv2E51My54Ku22Mky/UQzCtGSDGfqcFEtJUtGAe4CIqXMyl3VYZx9rCJkB3b32Hqe0L+MIZNQxjieKMkSQlnU94wCZFnQaUCAVjQXJ3TJtt2WRFZbTGfv/He3bFpgFgRWnTyjBGHyywyHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121285; c=relaxed/simple;
	bh=ig3tvpX7Zq83AA9nPx2GueGpHttdynJ7XkDjmZhhGzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUW/VyOmblhcBn8V6Cvdx8Dz9LbHukk5LebB5npnZEL6djZ95WaAWkY9wUWjBbrJUsoK5pO0BtYcX36vYgd/vrr5mCRof7UnCxL4WY2e8dhDH3W2nm4k4caJZlC196EB5xI0QmQjmyOCLyvS8OFw3QhB2L8DPFShjI5gOeS3HQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nIKd3vcK; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nIKd3vcK"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vQ1O3652502;
	Tue, 3 Feb 2026 12:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=z4TlZ
	grxT3F/Y9JlB0VH0FzR30TxpQpktQA7ifB2h8A=; b=nIKd3vcK4FcYjv2Vuxkxy
	fuyRU6Owr+HPKaFYElPvUPogPRGdRVG5W8RO89WWcvVZ3Scn8WimXLDuvn+3LcAm
	eKK0I3t6V4Gp/YULtEUOhUPfbfmF89mXZetIvGqx8sx1E16ttzZx5D32YTBufCiv
	PNNXKNNDmYG82TgivZZ78Gg75gXFIpOYM/LmoAUuxzA376AppMnlhAuhqii3WFMB
	e4Q0t218/TWiGYY35/ileBmDauSHKs5v6pnCF/n4N/aF48RYkjYRRbp/6NhjJ7a3
	pxbra0hjLYWAFtnY9SpxbLGY44vtt/VBWt1vygCn3fvjM83o0s7G3ml+q/EkrrbR
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1as3bxd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:21:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 613ARP6R025931;
	Tue, 3 Feb 2026 12:21:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c2578c760-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:21:18 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 613CLCVH024167;
	Tue, 3 Feb 2026 12:21:17 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c2578c70s-2;
	Tue, 03 Feb 2026 12:21:17 +0000
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
Subject: [PATCH v3 next 1/6] iio: sca3000: cache SPI device ID in probe
Date: Tue,  3 Feb 2026 04:20:45 -0800
Message-ID: <20260203122109.689669-2-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-ORIG-GUID: tI3dUEKLJwfNcj9mSsve5zanBzsLn6fR
X-Authority-Analysis: v=2.4 cv=Sq6dKfO0 c=1 sm=1 tr=0 ts=6981e83e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=eY56iXQc7nrdnX74TsgA:9 cc=ntf awl=host:13644
X-Proofpoint-GUID: tI3dUEKLJwfNcj9mSsve5zanBzsLn6fR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5NyBTYWx0ZWRfX+wwU+VT0CFUi
 eT2eyZ7de9ZM1h7N/gZpbQ8KxVJBBD1t1nR6fFijAiaq12MbkOAGbA4zSLC/EBHahkzQLhxe6kM
 Tx3tYfamRz8h44SdNk9YYw9RkESkFgqioIc4wvnZCa/ddxZKliq4hevbC88lTwe0luqVT+OYpIi
 25HYzWOgSPvo2VpyNkyWjgZpwaY2FxV3TjIatnQ/J5W5eVmt5MOhaBQH3Axwtzzp+fUAsamUAhn
 nKGIDgcsTVnxNk+sYh7bCYRjK/kmvEqsAeXLtDQOZ0s4T4wzHrQE2Dfq+8qvLc86EVHk9Lbr/kX
 ncuDTvTi2gD0A9fWrTYIv+0sAipClhx2i9EJmoyYdpUJ18noBlceVD9XpkST3bCKirLbh3oHg22
 5AGiwYqsPJtoz5IoEAnHefo7RJlDHlk9PlgUHRaa87SSm9AqxzLlkZDkaw4dDXTYXutvrA452+J
 +JluhYuUIg7D/m5eh31KIaAN0IqF9VtH+B+uB4ME=

Store the spi_device_id at probe entry and reuse it for the name and
chip info instead of calling spi_get_device_id() repeatedly.

While at it, reshuffle variable list in a reverse Christmas tree
order. No functional change intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v2->v3: Split cachine spi device id patch from the  dev cleanup.
---
 drivers/iio/accel/sca3000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 9ef4d6e27466..a0b431aff024 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1439,9 +1439,10 @@ static const struct iio_info sca3000_info = {
 
 static int sca3000_probe(struct spi_device *spi)
 {
-	int ret;
+	const struct spi_device_id *id = spi_get_device_id(spi);
 	struct sca3000_state *st;
 	struct iio_dev *indio_dev;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -1451,10 +1452,9 @@ static int sca3000_probe(struct spi_device *spi)
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
-- 
2.47.3

