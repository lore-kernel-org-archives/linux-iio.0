Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EC9374758;
	Wed,  4 Feb 2026 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185575; cv=none; b=HEZ3qcyj4np1Cv5MR/rE4JN3KtW7QMGzcNJZLo9IG6RYWx2Mts944YwWqNBqz65KJ61uc4HBGfqQkbZWeKWzxBkErFwMQHokPGjW4ROmshXjUALiq03xevW0WDeiYkH/YpCFSkPivQfGzfWf1MmYwRsEyvv9W5nMj5y9TrJuW50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185575; c=relaxed/simple;
	bh=ZVyJxfc0bE2I9F2HJClUSo2hS6qDRGgaRQJpfxrttXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtnODvm4XU4yMFsUTTASABpLNm4Q+Y46cZkXEwQ2Mb26YxpjJ1c5CNs75l8VS0w0HG2kDz19oenhsaBrAE17Br4mvxqxd+dHlNn8gV7jJGeqODlB0wWtKX9XSc7TT6owHpmIT3c8M7361eYQpza9xLNTvMOFyadq1K7Bjxrqgmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CciuPlZu; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CciuPlZu"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613IuGn84161162;
	Wed, 4 Feb 2026 06:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Idpik
	wJ0rTCbj9DitdH2cLfftrSNru4S3cXLfBwSaj4=; b=CciuPlZuEE0Tpvjh0h1fA
	yK7cIajfCn6sZ6uPZlBSmTQZ6mSsRO3nue32C+3dSTdWcpisY0Dscf6Z/fb8OTuH
	VrHdy7WXPDaHUcBCcTTrJ66xO0wXjXUa14YFv+Jn1u+7as1K688tU9t1cGFXKNp6
	zikH9vWR7Itlrbc0PG3f6nEX17WrPbhEyuNBEUsmAw3Hqx36x8AUb02qfLt4CxE2
	wOZWTaKDhj2DORJjd+yQx7/IEkE2gH/6Jlo3qkn26qT8wzibWtR7dkmk1+Yqgzjm
	wFHJkivSx6sd5YJdB7v/azvdW89dZ7JfBfooJXycmF74qCQ83AxKi2PuY32ZWB1p
	g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3j8uh9tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 06:12:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 614666j3018820;
	Wed, 4 Feb 2026 06:12:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186nhbwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 06:12:47 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6146CNO7032959;
	Wed, 4 Feb 2026 06:12:46 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c186nhbnd-6;
	Wed, 04 Feb 2026 06:12:46 +0000
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
Subject: [PATCH v4 next 5/6] iio: sca3000: stop interrupts via devm_add_action_or_reset()
Date: Tue,  3 Feb 2026 22:12:00 -0800
Message-ID: <20260204061219.791037-6-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: NGMRdnLUtaQIQTClHWtzzhXEWFXiqNXN
X-Proofpoint-ORIG-GUID: NGMRdnLUtaQIQTClHWtzzhXEWFXiqNXN
X-Authority-Analysis: v=2.4 cv=BJS+bVQG c=1 sm=1 tr=0 ts=6982e360 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=IpJZQVW2AAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=9yJhIapc68VNqS8YdaUA:9 a=IawgGOuG5U0WyFbmm1f5:22 cc=ntf
 awl=host:12103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA0NCBTYWx0ZWRfX4vn6spIbxJVl
 ymM/LtQwW9yr9dH8VwK0ufxYE3+wgAaHq5CrE9nPXYFwrw4xgBX90hOWm8OFmibVtTzKEf+ETF3
 PCXHi2nIkoZAV1olHaJv9NWghZPB2G9cxP+S9yaEO2zehyiYt6aCiuEE/CcimRF7QMwG0qbmCtM
 kL9Gp4PTMCYyckUGLcx/ADqKZLfF90xqDEOAErSNOAdscR8oUu25HYYP4NydHq1X5wGlIkywU7X
 TkVyPkH/D9yuOuHJmduk9BKGZ4PO+yNReQimyfe8No3I4wnTAgpgifldpGEAHs3Vt9HGbWWANZT
 FpEoN2TNgC5BTTkxABYc3mo3YjkJLk1ijJMslDQOMPk50hHNOehyAdKb5gpjqVZThrojw8DwPXC
 oeKvZPjTbtnyvnSPRU5QmFfIeY3nAV7RQwCDBzISFlTSWyW3LcvulpfD/J642bfarq0BMtACNh/
 gWV/XU0CU1XJqeZN55ELo4OO4/2M1kdBlUyDCl5w=

sca3000_stop_all_interrupts() is moved above the probe routine so the
new function sca3000_disable_interrupts() used in probe can directly
call it without additional declaration.

Used devm_add_action_or_reset() for shutting down the interrupts.
Make sca3000_stop_all_interrupts() return void now that it always hooks
into devm cleanup.

No functional change intended.

Suggested-by: David Lechner <dlechner@baylibre.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v3->v4: had to rebase becuase guard change is now moved earlier [Thanks
to Andy for the suggestion]
---
 drivers/iio/accel/sca3000.c | 45 ++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index a46990453ed0..c3a8f34d4852 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1438,6 +1438,25 @@ static const struct iio_info sca3000_info = {
 	.write_event_config = &sca3000_write_event_config,
 };
 
+static void sca3000_stop_all_interrupts(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct sca3000_state *st = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	if (ret)
+		return;
+
+	sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
+			  (st->rx[0] &
+			   ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
+			     SCA3000_REG_INT_MASK_RING_HALF |
+			     SCA3000_REG_INT_MASK_ALL_INTS)));
+}
+
 static int sca3000_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -1489,39 +1508,23 @@ static int sca3000_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_add_action_or_reset(dev, sca3000_stop_all_interrupts,
+				       indio_dev);
 	if (ret)
 		return ret;
 
-	return 0;
-}
-
-static void sca3000_stop_all_interrupts(struct sca3000_state *st)
-{
-	int ret;
-
-	guard(mutex)(&st->lock);
-
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = iio_device_register(indio_dev);
 	if (ret)
-		return;
+		return ret;
 
-	sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
-			  (st->rx[0] &
-			   ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
-			     SCA3000_REG_INT_MASK_RING_HALF |
-			     SCA3000_REG_INT_MASK_ALL_INTS)));
+	return 0;
 }
 
 static void sca3000_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct sca3000_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-
-	/* Must ensure no interrupts can be generated after this! */
-	sca3000_stop_all_interrupts(st);
 }
 
 static const struct spi_device_id sca3000_id[] = {
-- 
2.47.3

