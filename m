Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570163128C9;
	Tue,  3 Feb 2026 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121297; cv=none; b=CcS7jcwPklJ7cVJu6OUcShFq1CsABmacu6d7/9oZSv1e7wXfXb3tAHjVd9UNDwWgG6jmCsvCMGqYWMl0lbOtjzmXbU7NV+daATkUIUcXxvPCeNNQrCB/XK7ew91aGs0L9N7mcX7U6Mhgyvoc9Opy+L0KflY8+IpR5F2xRKMeJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121297; c=relaxed/simple;
	bh=ztMNIx0tvqvr+UipuEEePalN7odo3KxrT9pZ5vfHGDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgkTp46UZqDYaambg64TqkxmLNXW6nPJHGC798Ekbacrp0aIdb7GG/VDoqc/2DQiOf72JdsFK/v3GMk4KzqYSf4gccntM1WpcmhUPcxA9r40m7EYj6sdwz070SoZctMIr3JiWdFGU851nQb8J0VRE4eX8ZhmRQghY9FCPdakduQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dj0XOpxx; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dj0XOpxx"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vYqT3151849;
	Tue, 3 Feb 2026 12:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=RoscS
	LfSDcO5bXaHcwQKGUUuXlJWouZZWarpSw87qwI=; b=Dj0XOpxx9yxvmbWA27Juh
	GwfCQptY013+tN+/PjZL8HKVkpXG1qMh8lFV9p3jTKwLvyERlNlNsu7x8iRUaBuK
	j4VKsNg8Xy8RvlSDXp48W6qWJQ/3MAhQ60ehpg1YcmOy6UG1j1G8gnb/DhJXS98O
	HRlgzIuLVNblPkfx2A6NUldX52ZvOChNlP6SjI8ZILOFMiReOG6Qzbdo0iFlo4dd
	cxHprdSI4BPdleo8UBLTjlvb9G570PW/qlH7v96yVM0m3ODqXOqEigiIztdyWRaG
	mDzkbCyC76Qsr2C9TT+/MPURshezNvzfWg945MbNs/LXkpj6qtlTWNZcupvbI19j
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1atakyhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:21:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 613AfkFV025863;
	Tue, 3 Feb 2026 12:21:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c2578c7d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:21:28 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 613CLCVL024167;
	Tue, 3 Feb 2026 12:21:28 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c2578c70s-4;
	Tue, 03 Feb 2026 12:21:27 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
        andriy.shevchenko@intel.com, David Lechner <dlechner@baylibe.com>
Subject: [PATCH v3 next 3/6] iio: sca3000: switch IRQ handling to devm helpers
Date: Tue,  3 Feb 2026 04:20:47 -0800
Message-ID: <20260203122109.689669-4-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: Jz1ov77U2e9AnV36r31UOpQ1E5gfYiG0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5NyBTYWx0ZWRfXx2L+u7YfL93Z
 C9rNpph7DlM9Co9tJy17IjhYEMIz0rD8tMNQditNM3H+8IrdD1oUvD4EmchnWNMuedZIDxM8+QK
 Qp6ww4eOOh6YWnRRnjOnluihur83DFDlOHk1thz1W8Gjj0M3QrOhjJ1WNvGrmtvAJA5eNkYQRQ4
 AVovaPgBPY1uodaG1AlEiwJFHTVuju2KNIAgJAhSIPJXWHcF7OYvaJKE75A/nD73pVQllAh45F6
 NiVeggNdKGZoPAKp/bXswSNcPrhy91SAdjoCpjbZ6wWANmh9j6gkmFFLESmMXe6sC8NsWT0lVXz
 dwjFV8edZK55RF6yK3cO/gJaA1OuOFlsJ0ZeMgdfwYDFqiTsHcYW93WaVK48BU3yLUx1rGVcEWe
 bAUFWsjGZ4XV8JKxEC9/I02d1jQNGecF14ddWsmF+EpLXZ5nEbRb9qHq241sxcJYIr9R2YYED68
 tc6jvZcPCfMkdIbpmrcOc6c39SQZX1NMt08t1rac=
X-Proofpoint-ORIG-GUID: Jz1ov77U2e9AnV36r31UOpQ1E5gfYiG0
X-Authority-Analysis: v=2.4 cv=IaqKmGqa c=1 sm=1 tr=0 ts=6981e84a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=AKfxoly6AAAA:8
 a=yPCof4ZbAAAA:8 a=JC2FEIXQ5Z9dJjKm5LkA:9 a=4Q71d_afUUiBcdzZNBSr:22 cc=ntf
 awl=host:13644

Convert the threaded IRQ registration to devm_request_threaded_irq() so
that the probe and remove paths can drop manual freeing of irqs.

No functionality change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Lechner <dlechner@baylibe.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v2->v3: No changes, add RB from David.
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

