Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588CA346777;
	Fri, 30 Jan 2026 21:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809436; cv=none; b=awbQJDivVzvcAGHKaX/O+5899qaZII7/YggguQQYckxm6bQzbMGunKfeezaYoWdPPC1p3I2GKXCFryhQe8MNsauFnTzbICEliFUfqyM7P41lK6fhXVmJx2L5MuFDM+xUktdUmszh5DUdjZG2KzXBOLuTLTssocOrqz9DlvEJmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809436; c=relaxed/simple;
	bh=s/BpMjeQMlr4MYFXDq3SJDML0E2iz4u3+i0o58uMEM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/8izGjGJXqaUW3zgBq5vjLEIy4C8PylxTvO6IPiHDJG2pOHU+d30jmljIziQAMalctNsAfSvfCG7qHoaeuF1WgMXIwrop15CvC3ioHBDpYLDR8F4saDGN3UvLCg9Rq2jR12bvKn4txn/AMhhLGmoIlGlu9inFtXnljVLZyMWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kxNi7/xM; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kxNi7/xM"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UKDNLP3407068;
	Fri, 30 Jan 2026 21:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=N6ioH
	kPVQQWZYqBHEsPUEvGR9p10BLcNTVYF4uG2Luk=; b=kxNi7/xMMHqlpWIkpsqhb
	ntpmpytnzGRfbpsMnIxUasKXhFauObskVi2QuR2QSLHSxiQPuFQt+/X26hZdM9f5
	kdpJMS5cRepisWD2YyoDt5icT9qw1Np53Pl+hjcyPXgrXpHZGFHWo9+g35Vmalte
	BPxshsrOrPCnp8esUualc/r5vvH6+r3h4dYM8Mjx6LZSTZtT3FK6rSuGm022D0Dm
	6Wf/FqhPzN8dp1X4ZT7kH3ZHe9meS8VNmXwTRMVrus4SVA3L9M5gEdeJl1VgIIsT
	BmpVpDLh5LZV0H8nhX1Qh+WZyZbWUwGCFVGBJL2BWyFzQ3x+u0Admwv3nB4rllf1
	w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c103e8fh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 21:43:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60UJrWPF036075;
	Fri, 30 Jan 2026 21:43:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhtg58u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 21:43:47 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60ULhRtm035490;
	Fri, 30 Jan 2026 21:43:46 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bvmhtg52e-5;
	Fri, 30 Jan 2026 21:43:46 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Gustavo Bastos <gustavobastos@usp.br>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Cc: kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH next 4/4] iio: sca3000: stop interrupts via devm_add_action_or_reset()
Date: Fri, 30 Jan 2026 13:43:11 -0800
Message-ID: <20260130214323.236389-5-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE3OCBTYWx0ZWRfX09tXLxnjJ2zC
 3ajFX9/+LDY/cRWM8pEBa/EAzSLIgHkfG6woo6K84ZPK4V/VpzGwFqLY5FcLvDzzuyNz+trXDNz
 HIzGxsRqICliwB/6POr0fwCYJOYMjnXJVg+PtcLiiC8TfksOx1oBcF/mIkCU5gTM5QkHI3SJWfW
 hGM+0gHBFoLTEi9LOGHzKOQbQUduBND5kggImiqvLQbAdN6+4HSz+TAMuPdjW2/Wk+K6QVDBRF5
 kbhewurNuFtjY82YYHJB2kMCp1NLhHD2kFg4tJvvBoLt4Zl9fQkm0yyML8dj+3YaEROePtz+DlP
 ewbXMf+zaoYJZVZ/kGvAZ8p/MVbmUoAHp4137zRvORno4xEgj63LqfQP//vTYwN7uXdPm/HCxbt
 cJD2Zuszz7q/jPUQoq8Nkd1qBlWbvzQOX+Jb3Cdy/JJWLLWVX9T3pnNnfzVtjGlIhxehuA+A2Hj
 wQ6ssG755Sq+c1I1SdEuhY4h4FmpW9NbtoBUqhYQ=
X-Proofpoint-GUID: orWRI84-ipYdeCfz1cUnL3d8Ag4yO941
X-Authority-Analysis: v=2.4 cv=M/FA6iws c=1 sm=1 tr=0 ts=697d2614 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=f1nxArf7_yZUxjG6GTgA:9 cc=ntf awl=host:12104
X-Proofpoint-ORIG-GUID: orWRI84-ipYdeCfz1cUnL3d8Ag4yO941

sca3000_stop_all_interrupts() is moved above the probe routine so the
new function sca3000_disable_interrupts() used in probe can directly
call it without additional declaration.

Used devm_add_action_or_reset() for shutting doing the interrupts. After
this there is no need to have a remove call back, so got rid of the
remove callback.

No functional change intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/iio/accel/sca3000.c | 58 ++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index bf1957c7bc77..7f7d29688a81 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1437,6 +1437,34 @@ static const struct iio_info sca3000_info = {
 	.write_event_config = &sca3000_write_event_config,
 };
 
+static int sca3000_stop_all_interrupts(struct sca3000_state *st)
+{
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	if (ret)
+		goto error_ret;
+	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
+				(st->rx[0] &
+				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
+				   SCA3000_REG_INT_MASK_RING_HALF |
+				   SCA3000_REG_INT_MASK_ALL_INTS)));
+error_ret:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static void sca3000_disable_interrupts(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct sca3000_state *st = iio_priv(indio_dev);
+
+	/* Must ensure no interrupts can be generated after this! */
+	sca3000_stop_all_interrupts(st);
+}
+
+
 static int sca3000_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
@@ -1481,6 +1509,7 @@ static int sca3000_probe(struct spi_device *spi)
 		if (ret)
 			return ret;
 	}
+
 	ret = sca3000_clean_setup(st);
 	if (ret)
 		return ret;
@@ -1489,34 +1518,12 @@ static int sca3000_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	return devm_iio_device_register(dev, indio_dev);
-}
-
-static int sca3000_stop_all_interrupts(struct sca3000_state *st)
-{
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
-		goto error_ret;
-	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
-				(st->rx[0] &
-				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
-				   SCA3000_REG_INT_MASK_RING_HALF |
-				   SCA3000_REG_INT_MASK_ALL_INTS)));
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
-}
+		return ret;
 
-static void sca3000_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct sca3000_state *st = iio_priv(indio_dev);
+	return devm_add_action_or_reset(dev, sca3000_disable_interrupts, indio_dev);
 
-	/* Must ensure no interrupts can be generated after this! */
-	sca3000_stop_all_interrupts(st);
 }
 
 static const struct spi_device_id sca3000_id[] = {
@@ -1533,7 +1540,6 @@ static struct spi_driver sca3000_driver = {
 		.name = "sca3000",
 	},
 	.probe = sca3000_probe,
-	.remove = sca3000_remove,
 	.id_table = sca3000_id,
 };
 module_spi_driver(sca3000_driver);
-- 
2.50.1

