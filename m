Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93AB376BE3;
	Wed,  4 Feb 2026 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185561; cv=none; b=WDszUg8hEBOPxqEckyEbudoxvnOotZ7X3gNQIeFwHxEijebsUdDtmVQijcOtZFnViKYJ1EcGhmT+UyCKucXx0lx4JxydIIQvghX0vgJWjfGpz2m/Fdi3+5LCX9E5SttPBsmJXBCn/25rHnJDaOTp469+5Oa2FK9qryrk8Md86gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185561; c=relaxed/simple;
	bh=CR0oJLcesHf+ekPfQKoEmjvBpeTCIJdT+0qND8yzT+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2/Qht8NPCCInhjkym++7ETtfPdAct3MJja2gdh2F3+kcpjg96PDuSJs0WZOEsKsDzdsEqgwCV4Ykstv/lyhNzaP8zlm6OEWFJNKE31XWhAmGUGxxl8ksCu9HRg275R9kT3u4CYgIogGIgmNd5Y+dXyDs1m6RMdA3oxAEzioVnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dim+ieWg; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dim+ieWg"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613IuJFw4161563;
	Wed, 4 Feb 2026 06:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=F5Z+9
	1Bci2/ZpqTg1N9jfVcTz/9YX15bdqKQge3EMvM=; b=dim+ieWgWGJmEfhzgXjRb
	i8psY+uQQt7wa/UbaLHH+Uu5fyzSecQZh3TOHc+UeYQeTQdfXPj23u/stZbo7LV5
	CaZ9oEYCMvMNqWtvYH+A5KwyRYo38VHrr572HwEFXKQd0GRUuGpgIhnPtu7ScOUT
	4wtRUQBOMLed83YpujSOBOE430CS29+DLzIOvZyhD48GfNn63qGzkMjdY/NQmJRG
	nwtaGMTo7PK+vgWIgfnE9RNSJmjtu1LTfJYGCxCjQsJglVc4OZG/YQeXzTvfYmtL
	q1eL0d45oXG1/dc24nCQJDyipSigDY39iZ7MAgHWD1kFDnE5qdskLRfo0T7Jzm9V
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3j8uh9tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 06:12:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6144fHR3018663;
	Wed, 4 Feb 2026 06:12:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186nhbs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 06:12:32 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6146CNO1032959;
	Wed, 4 Feb 2026 06:12:32 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c186nhbnd-3;
	Wed, 04 Feb 2026 06:12:31 +0000
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
Subject: [PATCH v4 next 2/6] iio: sca3000: switch IRQ handling to devm helpers
Date: Tue,  3 Feb 2026 22:11:57 -0800
Message-ID: <20260204061219.791037-3-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: 7sN2dkJoNvDm498wXgWVqs5HKqph9ud9
X-Proofpoint-ORIG-GUID: 7sN2dkJoNvDm498wXgWVqs5HKqph9ud9
X-Authority-Analysis: v=2.4 cv=BJS+bVQG c=1 sm=1 tr=0 ts=6982e352 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=IpJZQVW2AAAA:8
 a=yPCof4ZbAAAA:8 a=S4wibIGCh28zlk_8eiUA:9 a=IawgGOuG5U0WyFbmm1f5:22 cc=ntf
 awl=host:12103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA0NCBTYWx0ZWRfXyNh3X+hZJJMO
 tMgFUx3jTRw4++cNWHS7b72rpkAqXRL43pcSidYnSTmrL8raG2HpLkKHwBqbThXhIkpHPSIdF0L
 J2NTaqALI/D+Uv4ShwKCVV4Y3uKLaEujT2ZsKeacO0Pd39170O1HH/5Oll6yWHF0nLHEoGWh/cR
 jwHV7CbXDXKJSqyr4cIJWFeLY38JGv32q7jlgEmyjqe35iJ2WHHrfjRyLr6XJ2UXeXl331Wybyl
 2wlDYWHMjbE6a2JgfCAbFFkgTbm2UpJWs97XXrvxtdjIdeOvtoQnX8dO/L1jErzeEV1rmN7EwRu
 1hWzQCqdQAnXpwqxV2WWk366E2SEk0LolMKdk+/RtqIV1Eox5oVic5fmg2fURLpGYHWX+qozfmL
 Nf1WTZxvpt3nzCwb1M3/FKrml8WyVl/CTsAyPOHgKMkmbcH31yw8k9uv0mvKJ0D/R5doM+mB9Os
 st/TYjUPmEWq1eQQrNJdCBR8ocDZepWLfb0NtTEo=

Convert the threaded IRQ registration to devm_request_threaded_irq() so
that the probe and remove paths can drop manual freeing of irqs.

No functionality change.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v3->v4: Corrected RB address from David and Added RB from Andy.
---
 drivers/iio/accel/sca3000.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index fa0ec2e1a1a2..4bad152009e8 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1472,34 +1472,27 @@ static int sca3000_probe(struct spi_device *spi)
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
@@ -1529,8 +1522,6 @@ static void sca3000_remove(struct spi_device *spi)
 
 	/* Must ensure no interrupts can be generated after this! */
 	sca3000_stop_all_interrupts(st);
-	if (spi->irq)
-		free_irq(spi->irq, indio_dev);
 }
 
 static const struct spi_device_id sca3000_id[] = {
-- 
2.47.3

