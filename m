Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561F3D5240;
	Thu,  5 Feb 2026 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297177; cv=none; b=LmhCjPpDF9OLPIFwSvOGEbH41B+b9WkRf9lyBuy1BmFCZT6tdpODVafnap61RA2fJNMaGWQfVVSnAO5JUVlFRYqejX09sDVWE3p+EsVqQ9tVZjZ5SLH8r/VzD78f3OSpR+o/hrmXpMin3+8vU4J0Bz/qiKSy1G4xmduch92LYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297177; c=relaxed/simple;
	bh=aRHGEchsrEL+5HVeSn0ufskCcn+c2gzI3wr1TKJraTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVznCb9qAkE37n4RImLjsICV4nFzqXp5OhJ5zwIzjfY0rFUA9t1zmAoYD/3mMVCaYCmlc7lw8Xow9ynC/vkVC1i0HrLSHFwAPAHXasbH8gH375JBhW7r4dqJb//hcwjB/MGSbCYdHdU7TbC7z6CO6D6zI7/kc9tUP305Wdms3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sgLafxXV; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sgLafxXV"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614N8gnh2146435;
	Thu, 5 Feb 2026 13:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=9/pd2
	3imdSHDCAK62OCHdfA06OkCtfpiJyqLGR/XsN0=; b=sgLafxXVibhgNVoDmLDOK
	Wq0fR0uDaXYg519C8bGJ8mFsU+pKeo6AwzYA/B+LFEUShhCW//vyWBm5QMCpOGnz
	uZuGAs8C5u7bMp9MM8uLl7adr8n1jUXp3LbM+RVn+unCS/nyis5AnRzOkKuDCH41
	vk99yJtSB71F30S+KEsLBP2ZY9sxL0eTUR50juCVue6/M2IG+E7p5MGWx+xM5Pqn
	DcmspR3eCa+vYYxezLuHVLQZR9ZLxyABTkbkr4AyaT3iCllpNGy5zzY9kN8LCU7K
	ibHGVcCt3z+EN8eYxiEY2CyhpYaIUEmboXJ65Na9CnNtaKw2ccdf83UxWqhppf1u
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3k7ukj7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:12:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615CncN6001247;
	Thu, 5 Feb 2026 13:12:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186d55fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:12:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 615DCbE1038070;
	Thu, 5 Feb 2026 13:12:50 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c186d55b9-4;
	Thu, 05 Feb 2026 13:12:50 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v5 next 3/7] iio: sca3000: Move sca3000_stop_all_interrupts() above sca3000_probe()
Date: Thu,  5 Feb 2026 05:12:09 -0800
Message-ID: <20260205131234.3244467-4-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX5Qzxh02OoFLk
 wWExV8NMbgFnkTpbncC7qVbBloFMEjLus0Zjso6InoVvzmFVX56YOzskqVCnYdoIU5b90SKHjoq
 7TL9DdC8YjwahN9/IwnifI1+54go4EOl3llztMAnmFRaJi5aoNkjwQbSzG4DzQ9TS/+rynNdn6z
 uouzXa8YdXtxcppaLvIZCpoF9FmuRtPEUx97D/Ffb2Rv1os+1lFSFVq6hGeXSLpLfxQ7EAj7WbU
 May2WKpBUUtMJW0RAi89I5BZ9XpOlnnLt25KayeuyL5TOcgBYzL2rgxDd6yqNIUadQqnFokfMFV
 AdEZGledKSLXD4g1Ehe/Pa5Qtt8mJ7YNew3DoWqeUVTUY0JCiGZWxXL8sIgUa1QutgOeRTPMhS8
 2G7Gw6BajPqaxqJIFE1wQtbTKPLjLcBj/kHjS1GueptTsdVvAaQje2Z4xPDzkDYxe62QPD/KdHV
 QuGPZIW/JToQzyarOug==
X-Proofpoint-GUID: Mu4Rx4xPG3wymO-cpN0DKVuoGkvEhNON
X-Authority-Analysis: v=2.4 cv=Z7Dh3XRA c=1 sm=1 tr=0 ts=69849753 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=lATyolU4PqpKJ5i4NuAA:9
X-Proofpoint-ORIG-GUID: Mu4Rx4xPG3wymO-cpN0DKVuoGkvEhNON

Move sca3000_stop_all_interrupts() above sca3000_probe() without
altering its logic so the next set of patches are easier to review.

No functional change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/iio/accel/sca3000.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index e270f445bb35..53628a0ee50a 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1435,6 +1435,24 @@ static const struct iio_info sca3000_info = {
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
 static int sca3000_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -1493,24 +1511,6 @@ static int sca3000_probe(struct spi_device *spi)
 	return 0;
 }
 
-static int sca3000_stop_all_interrupts(struct sca3000_state *st)
-{
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
-	if (ret)
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
-
 static void sca3000_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-- 
2.47.3

