Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668121CC4F;
	Wed, 28 Jan 2026 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769583024; cv=none; b=uOcDVK9Iyq9W6lxyyr8h8m6MAXiMxifETYHIkHmLUSF1nAv2r9B1/Kq12Z5755CKJ/IYWyhe1g5iqcLFc1u9zJCcX5h8gJTRSpXco/fABOA2m/OALtcWhKo7BF9vFZ2j96LwdN9pzFa7FDJfdsj819TsIADsWiJ73QixdaTiWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769583024; c=relaxed/simple;
	bh=+i8rRoSWxdVWEcMGElAkMRSSVSHed/ybjlHMI3RNMA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=re+7qKlzXQR8W4koIdargHSt9kl7cDcUPvJutpI4G7qzzRbSotJqmExcyfhiUJ2U0/cLD95eUqEJ4qBvwuVyA2Xcjxi6NsA4QaJHsXr06ev/cNvmDNoILavh47V+v4BDu76q8LTsoTy6TYi6J3g/LGWjwZSQR/aqYqKxGjAKqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dXyRkuh2; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dXyRkuh2"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S4DHid1232258;
	Wed, 28 Jan 2026 06:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=2UAdLl8oGzc8kQluGGOp7dtkd6xaA
	adTemh7pq/N6Hg=; b=dXyRkuh2g7ZKtvbfEtnsGQOCFGva6eX8+yX2xMKE37HkB
	eOxMkpJddfnb72YLMl7ch75BRdEOlP6+I6dOVidJx78gl5UAZM9xKJIw+ujXI0/d
	aUU+fay9TNx13WfIF9VuGECSprN2Cm4g/lsJP8Z3xj8AvrqT1oswppfkcanworpf
	FdphAa7Nm/vNboKCwj4JEPSRimDJBoRHNiOkdbxKKiaYD3RTF/CrerG4b3TsFLMC
	cOwagmf8JPioc/Z1SpBh87TIRQL5sO7JyBSStxw9jXn2MDHFwKeL2GLImzMrDgQA
	Xi70bb3/arzDrYSAb1Qi/EaBdiPBjwc4ggTVxjPww==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by5t68fxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 06:49:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60S6OvZv010466;
	Wed, 28 Jan 2026 06:49:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhahyq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 06:49:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60S6nwJ8018952;
	Wed, 28 Jan 2026 06:49:58 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4bvmhahypm-1;
	Wed, 28 Jan 2026 06:49:58 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Gustavo Bastos <gustavobastos@usp.br>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
Subject: [PATCH] iio: sca3000: Fix a resource leak in sca3000_probe()
Date: Tue, 27 Jan 2026 22:49:49 -0800
Message-ID: <20260128064953.2952714-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_01,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601280054
X-Proofpoint-ORIG-GUID: 8l9cSgZ896flxuBmSldOv4293MHRMDcN
X-Proofpoint-GUID: 8l9cSgZ896flxuBmSldOv4293MHRMDcN
X-Authority-Analysis: v=2.4 cv=IIcPywvG c=1 sm=1 tr=0 ts=6979b197 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=pGTsnlEIH4ZyE0gP-noA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA1MyBTYWx0ZWRfX0xrKhThc930E
 JSj4vIAY4ohlc8/Feotzi4Y5RZOooVpzBbiHkn705plcdzv2hBK3eWiniwrkO+/fyIyFoQfzIxC
 nNa+5irgOE2PQTnEGpKG85sWTaO83jeYi/cdlriX8XI2i4l/Kue0OZSIB3TqYh5NPVUrsuVOeUt
 tIgY6+bpZI+L9PwWfzUDEuTQWfyTBmKIJ81F/XfrEz1S+vpRRtkYK7xBlE6t/PN5Lh0le0SOoIP
 06MQ6e7WhM2nMb78iyOhOKUYw1LGOdhfe34esw14NThk1e8B8mL/6iL84C6Y9J6MXsDWnZiDXB7
 04yhcXV2uOLRALt/LrLzu9jOJbXcSoW7L0C/TuhBRZjEDIt6Sbh7y4PANq8HUoP+HdAEQLPeGo0
 71vtX61FCRTksO+OkAMj4KnXBo1qaKqudrbjOKmeQYD3PZq3lNawb7rBCLn6wW+vlPVnuJwzfz3
 15fWHrN8u49oQmRWS0Q==

spi->irq from request_threaded_irq() not released when
iio_device_register() fails. Add an return value check and jump to a
common error handler when iio_device_register() fails.

Fixes: 9a4936dc89a3 ("staging:iio:accel:sca3000 Tidy up probe order to avoid a race.")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/iio/accel/sca3000.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index bfa8a3f5a92f..9ef4d6e27466 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1489,7 +1489,11 @@ static int sca3000_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_irq;
 
-	return iio_device_register(indio_dev);
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_free_irq;
+
+	return 0;
 
 error_free_irq:
 	if (spi->irq)
-- 
2.47.3

