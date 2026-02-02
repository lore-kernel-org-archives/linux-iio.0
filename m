Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD3305E32;
	Mon,  2 Feb 2026 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061252; cv=none; b=D5RzA9RJZc26mspmTFdwfji3J19hDzT1Z3Q/Jdkhhjz6qHsfHNSCyxWtx3ZNFiLv/RvaTJPZd1Tjb1pZuWSFE4t3YFKmv8SD87E9DCVAmy0DHWW9Hm4tfWYicC5/sg16me6Xutmc1B4DnOjVaKQnDAOK6Mm9qCxfSKEoOSpM0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061252; c=relaxed/simple;
	bh=5QxBWkL2GpHirekmd8T2XkjiVKcSsgff4NWpA8kRhvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/9tDU3Ls3+LsG7a77fsXFovFV7giw0BR86oTW8dFcnFHQWez/6xgFE/FvPxKOwzmPRAPYDtubnreAI7R88b2mfV1UCkhVwiwPJM7x92NZqa7Ag0nL98/njxM1aKwofKCoFkgRj1bGEnq1eQvVcUY6YHpcs/W7tgi9PctsRkL/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qMfso7w0; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qMfso7w0"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612J2aTf1383306;
	Mon, 2 Feb 2026 19:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=kto37
	XlM9klCE2nsRYmNAN7SW5yE4yqWww2L5yHHUF0=; b=qMfso7w0FmoOEDBjI0K0l
	2j459kn7paHGEqbw8BAIhT6/jT2K0pjapqFZ3VvFxEUCvZ286LHw9piKDepKISZ8
	PCH+utwzxqn57Z8E3x1PO/IMSZMn7eabTqgi1G+NpmLGHsArYqlgxXQikoMXdn8b
	NydAEb2A5nT6HkdsYilP6OqlJfXSZdgbKPituqSR+BA/chds8QN/2yxpb6FYZ6bb
	2KfLFvIZFz5k5vNzrtQBqoPMNJxgJwSWW1K5PWIBwJAQKYjwf8hCojIF8fRsqSVw
	eoEcCoXzti6a+lAHgvYP7mmobQIvQLmigSjMF62B2j2eV54MvPfsREUETchHRGFg
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1arhjux5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 19:40:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 612IfVPV001209;
	Mon, 2 Feb 2026 19:40:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c1868urx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 19:40:41 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 612JeaU1019500;
	Mon, 2 Feb 2026 19:40:40 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c1868ursy-2;
	Mon, 02 Feb 2026 19:40:40 +0000
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
Subject: [PATCH v2 next 1/5] iio: sca3000: cache SPI device ID in probe
Date: Mon,  2 Feb 2026 11:40:08 -0800
Message-ID: <20260202194033.627967-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
References: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602020154
X-Proofpoint-ORIG-GUID: GPcfrHGciQEN0Bc6W1ti9DAke3iFKEO6
X-Proofpoint-GUID: GPcfrHGciQEN0Bc6W1ti9DAke3iFKEO6
X-Authority-Analysis: v=2.4 cv=fdmgCkQF c=1 sm=1 tr=0 ts=6980fdba cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=eY56iXQc7nrdnX74TsgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE1MyBTYWx0ZWRfXxAoKzXfEw01P
 SvB6QVaVo+SrP8wlqsGtPX8x9jBQJd8mo8jxANetqyB1QEjKzBAJRt9q+MlPP243wrF/kD7INsI
 nwDsaW/ZJewvq+q5+xD/oaJqt2jWWpb8oW8eTq3SlGfMswMmqv5mlu/3QZVlcXMpyYJeWe7O9su
 lgNUDj56A9CIQpKJfHLNLCtZNQf2aYlXfKB8MEF4tcb5N61uAcVnuTOjj34BBHAhO/VBSZZgkMj
 GmyGA1Ct64bWqbbLAALhxubwYnrwZI2uzCtwL1ay8h1JUVIyfMtEkrqGR1hrxWCOFvhXpIByxjY
 yPghkuly3bkVN9rU9FfhuRokSBCfX1O91YcDthGxfT9wkXoVzCQaYNTbRO3g3prHovuRqz4lQLm
 JIiIVeG3ZdK7eipTtsZ8w3hR52Rwxuq/7OVW9wFdCfjR3AAfRudtofzAlCLFyK2aTSHMWqnFqKi
 cMF+hNSivpVOU1mlEgQ==

Store the spi_device_id at probe entry and reuse it for the name and
chip info instead of calling spi_get_device_id() repeatedly.

Reuse the local dev pointer for resource managed helpers. While at it,
reshuffle variable list in a reverse Christmas tree order.

No functional change intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v1->v2: No change
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
2.47.3

