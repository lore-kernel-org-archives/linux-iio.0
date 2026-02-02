Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12503090D9;
	Mon,  2 Feb 2026 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061254; cv=none; b=TF+DIIsiuF/0A1BmXrWVbayYR1TtcqOj+PEWHrwuHoaxqcTNWAma20M5s4cWlqozHGmzx/S5nnrV6fryV/rM7a2go6xiB1ocv+99SSnCgOYzWFMSTJTw0LY+yt5D/WWvYnqtF9dEEYhZ1RyfaVgASO8VNt2JCVQsqpkyTqlK/14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061254; c=relaxed/simple;
	bh=HVC9ArOx9WOxUBJqsf78/JGCJReRMpqOsXB0aZ+LDoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzKyqaJJW6jxQryC14FWd+5M6uTgHr+OxwUdlSgBg42qtcYI8GaI8OIFKdK18Im3neTD06K0YACXpUuaXVJRx9P7EJFd4R+dY05DdXiZh6T024CkMmFiwNQ80mUXv7+lh2oE9Qnw9TrWByRigjuONSBY3OjBeJFXJRS34whskx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AfKg39PF; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AfKg39PF"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612J6w0m1430165;
	Mon, 2 Feb 2026 19:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=aGYRa
	zAzFESOV0UG63MxkTWbBoME3/WVsyh+DS4KLN0=; b=AfKg39PFdR/IgYyetAWF5
	npN4aMZcCJ/kKZVF0NzruT1qPo10pqgcoz62QQQEf0TZgWnRL78IQ5pN4ywA/nMk
	BTsUNN+ItZ+Z03b5PIkhAunLtsGJsYRf/wyUIdL1FmyqOIBzZ9Y0IfpCiuVvghep
	iumAcQM7sT9Ey/zG6ZIOHGZJS2OF3ZzJY5jwHH80TQkm+IbvgZq0q3i+TJxHBPWf
	SlJfqKi5iICsTwfkIvw8kZGD09g7AV5E3lSnApNe2801yP7xS/L8ei6tlNrbO4JU
	kqH6/6jZ5KRNDqrGe624n9gpc0EuMvQih/tgni6JkZGCAfa+/C/kYwAFrLRbWKMe
	Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1au62vg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 19:40:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 612JTTJb001228;
	Mon, 2 Feb 2026 19:40:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c1868us15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 19:40:45 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 612JeaU3019500;
	Mon, 2 Feb 2026 19:40:45 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c1868ursy-3;
	Mon, 02 Feb 2026 19:40:45 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
        andriy.shevchenko@intel.com
Subject: [PATCH v2 next 2/5] iio: sca3000: switch IRQ handling to devm helpers
Date: Mon,  2 Feb 2026 11:40:09 -0800
Message-ID: <20260202194033.627967-3-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: -1saqS-MAbzJ6eR3Z7MGiCau5gIFUBXn
X-Proofpoint-ORIG-GUID: -1saqS-MAbzJ6eR3Z7MGiCau5gIFUBXn
X-Authority-Analysis: v=2.4 cv=Nf7rFmD4 c=1 sm=1 tr=0 ts=6980fdbe cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=X8t9xCqtd0ov-FsuJpcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE1MyBTYWx0ZWRfXyvTQelgAQ7W0
 m8cC4Q9QXCaWQzdC8OYTkg4wbw64QxqMgCoejocksMeuCGt1oMkMMRH/BAAK9XPNwVddZ9nUtM8
 0XJI98LLWetVx5EaeLGubMlpVGjQGK5JXYNoZGdEfGueifQez2OyZi/KrC6ywhRD70wmPHT3LOj
 A6B2SQeH2tKjgdQwebmb/2mXtrNL6Vc2RD+2cOQ0NHImEQugi1ZzVuE9xiEYs0ldb9kR0nWPcic
 NnXdpbDM0xYKDi5kEjgpqUA6cFFVIG+SftvblqXtf+wKYFHTAS7PMsSgUwlUeFtwkSXJ5Qfy0j2
 +Uj3MmK8kge9C6LWc6Xi/cUgQKRAh7VVm3Qwmgj7kgzZaN20sddSQE8OOmPl1wnPH0Uc+2RhP2u
 YJdq3uovhHKI/Hc4oXJ2RO0GF/60g1DzjjGLcm6hLAsC9Vl4Z7xyWGHDZ1gfy/TPOLrPjfhNdXT
 xMTffoCio7wRJuPoJoA==

Convert the threaded IRQ registration to devm_request_threaded_irq() so
that the probe and remove paths can drop manual freeing of irqs.

No functionality change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v1->v2: Fix indentation in devm_request_threaded_irq() call[ Thanks to
Jonathan]
---
 drivers/iio/accel/sca3000.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index afe6ef61a53b..37ef724d5dc5 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1473,34 +1473,27 @@ static int sca3000_probe(struct spi_device *spi)
 		return ret;
 
 	if (spi->irq) {
-		ret = request_threaded_irq(spi->irq,
-					   NULL,
-					   &sca3000_event_handler,
-					   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					   "sca3000",
-					   indio_dev);
+		ret = devm_request_threaded_irq(dev, spi->irq, NULL,
+						&sca3000_event_handler,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						"sca3000",
+						indio_dev);
 		if (ret)
 			return ret;
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
2.47.3

