Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208DD363C66;
	Fri, 30 Jan 2026 21:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809424; cv=none; b=BkOmAfQHMHbx4J2bOf1ekxxiHBSYnw7KJo+rsGciwsmSfDa2+tKc19pCotFUcZCGjPP1hkFKo2kq4RLjJnfwQ17jVWPInNiYQx8XhqxxGdMxTxXWIRagfGitq8kkaG3BfDcr/xebcKmzPo0CU7tCBX+TrYs8Uct1NlIMB0vIKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809424; c=relaxed/simple;
	bh=5oZZfqlX3dRuPzkpMh511OG2qT5whyxmq9Mz2VNWW7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gzos34GVe5aPgTFaysUHXLp8cUAi/y1pyCbZOSuwoQPZ10EJGzaQ3WJpfi3FujTCLgSFP/e/2w7kSe/TvoB7d05jAAHtmPzU5atcM89JN0WhGutQwMWcpjwgG594x6iREpD3DMzWdB81vrgU45jglePhO36QE6oPZT2DrScuZP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r0XPPiVs; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r0XPPiVs"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UKDExH3406906;
	Fri, 30 Jan 2026 21:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=JfXpP
	zrgJOAITFyWSjPqbOb/SP+jZlwZOi6YJTc2wpU=; b=r0XPPiVs8+khhxqfGp48v
	XMO44YuExeodb7Yv4RrfhiK4dAI6pGictXaxXCM3ZtsNGTHfEzRFyJNQr/98qDhM
	o1kJZXAoAT3DkmmzArUHoCev22bkFrn6fr0AbI5n+9Vfp3iu4APfU6T7uLyct0vC
	b2Couv1yAgZZXtKvRDGJTzOo7fQeSh2JfRGqOW68iPAF8bGzOGocaCV9isX3+i/O
	QcmmUXeiAWtqPn3TOeVCT6Y3bilpzZMVcG9qoveEyhTq/U5YH3iGHsLwZmfVEGCy
	KTxyl1i2pF/cr4dl7eCmoYl6eyKaSzLNkA8tIpR8/zVOyPT3BafpU6VHIBMCVFeN
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c103e8fh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 21:43:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60UJfKkY036018;
	Fri, 30 Jan 2026 21:43:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhtg55b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 21:43:35 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60ULhRti035490;
	Fri, 30 Jan 2026 21:43:35 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bvmhtg52e-3;
	Fri, 30 Jan 2026 21:43:35 +0000
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
Subject: [PATCH next 2/4] iio: sca3000: switch IRQ handling to devm helpers
Date: Fri, 30 Jan 2026 13:43:09 -0800
Message-ID: <20260130214323.236389-3-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE3OCBTYWx0ZWRfX2AJ7LvJLAYmX
 A89AvRafR9fWNBzf6Zz6ZF8N/rE6+WjN0N0YVDmq0nAelkrN2hioHi5ya8p/RdMkrCELZd/Mv4C
 vJwMM5nt+odyQVy1bvdRxLHpGyMW984Zk4GzH6ullm9HE5m8ueYX1i+io5XSNWV3ZTSI89vYWNo
 hj+swJK6d8gHmg2FXFW9FqijECIMAUx16FnWTkOdgvX5IPgmTRwkiuv3vitUzpXOhw7F/3uuV0T
 w9/VVWreaebzOGWprunTMXJDNPFdbDwP3JMn5VP7o9Uv7QDMveaKD2uAVAzd2nMjhuEZLMTwAah
 4FhioJsI8QvtOFwnzyVUkZqPI/x1ZpowpMq2dqvy9vZuCE5w86QQD5pQPminRqu4k8Aw954u9cK
 4QbadClhA9ntGCNjxtylj4VXo4eHjqrOIOAG/RH2TaP8YwCFR+mLxCpo1eWwIiVtYNKUnOowtDo
 o9s5g6f/WwTRR8VrI2oQNgNxCr/UB7w9Hhoryz8c=
X-Proofpoint-GUID: bSlcLwkN9B9LZfXnR5GkFm8M0IUlyIqB
X-Authority-Analysis: v=2.4 cv=M/FA6iws c=1 sm=1 tr=0 ts=697d2609 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=tHKmUTQGYKKxxhY8VEwA:9 cc=ntf awl=host:12104
X-Proofpoint-ORIG-GUID: bSlcLwkN9B9LZfXnR5GkFm8M0IUlyIqB

Convert the threaded IRQ registration to devm_request_threaded_irq() so
that the probe and remove paths can drop manual freeing of irqs.

No functionality change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/iio/accel/sca3000.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index afe6ef61a53b..0210c716cf38 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1473,8 +1473,7 @@ static int sca3000_probe(struct spi_device *spi)
 		return ret;
 
 	if (spi->irq) {
-		ret = request_threaded_irq(spi->irq,
-					   NULL,
+		ret = devm_request_threaded_irq(dev, spi->irq, NULL,
 					   &sca3000_event_handler,
 					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					   "sca3000",
@@ -1484,23 +1483,17 @@ static int sca3000_probe(struct spi_device *spi)
 	}
 	ret = sca3000_clean_setup(st);
 	if (ret)
-		goto error_free_irq;
+		return ret;
 
 	ret = sca3000_print_rev(indio_dev);
 	if (ret)
-		goto error_free_irq;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-		goto error_free_irq;
+		return ret;
 
 	return 0;
-
-error_free_irq:
-	if (spi->irq)
-		free_irq(spi->irq, indio_dev);
-
-	return ret;
 }
 
 static int sca3000_stop_all_interrupts(struct sca3000_state *st)
@@ -1530,8 +1523,6 @@ static void sca3000_remove(struct spi_device *spi)
 
 	/* Must ensure no interrupts can be generated after this! */
 	sca3000_stop_all_interrupts(st);
-	if (spi->irq)
-		free_irq(spi->irq, indio_dev);
 }
 
 static const struct spi_device_id sca3000_id[] = {
-- 
2.50.1

