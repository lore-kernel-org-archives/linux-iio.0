Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BE309EFA;
	Mon,  2 Feb 2026 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061263; cv=none; b=RTz/1nXM72p0usuNngK3jtqVdvHubz4TzhC3EJV2MVmhw/TLeIW6svhsb0rxsy9uKfUPpGglkQlZlZFMY4blkjqM1aTvL07k4CwOPQ5RcQuxTa1YjTW0MiAVzfGuUH18n4sAZvjVc5FGr1hO4dtMspbzVIhsLPVXKBBlChqm6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061263; c=relaxed/simple;
	bh=uwOPfs88su3ZtgLfOZHjkAILEvMAH7oG9NMIOCnFjcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFKNntNlASFhgSIOVlsTKf8SQHpj/m+yDWTWycVQGbIEeYTEjvjMBIRMRTVWdfhGekayKfoOnjYf1oxvDweTb2zSrgDCyrl1Il5NIKJ8Z0fwD9W8Ipnvs9AINnyWXhwP3VIh+TJe8QmP+EYjMWVq8x0kB9zstLRVWAhUJZTJITo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q/GStTfo; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q/GStTfo"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612IwiO61268729;
	Mon, 2 Feb 2026 19:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=TvuhU
	Hd6NQb8DC7pLE6Gf8pzD3TJvmbc5g71btovg5A=; b=Q/GStTfounq9Q13tRQ8j+
	fnRKNnlE0cWFSNyfOY8PZn+Y297c/32azeXv0dQEDEx7NywvF9qFPQSHrNtX6rbN
	R4LHbugNQph34V0uM7k9339Uajq8RmCcpg7Cp8BTTnq9N+aTZqxsIGxWj5Er6ccR
	Lt8kLyWqI/P0b84n5MhbUIcv+cWY4ZJhBtOfSyTXiEih9lKMDjtSMGLov+Fs9kI1
	WFP7Hw4zT2Ar32zVyb7a3jE4GFpMjrLl46KmwgoLOieLlbeEk7qTkiCh7GryAERA
	WGFRIVEWJRC8vFMtNXV4KqLYu/7wh5Em4iwS3PqjO6aced5rF+lnsO/MqZCn9FIP
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1as3avka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 19:40:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 612JWGHe003367;
	Mon, 2 Feb 2026 19:40:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c1868us6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 19:40:54 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 612JeaU7019500;
	Mon, 2 Feb 2026 19:40:53 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c1868ursy-5;
	Mon, 02 Feb 2026 19:40:53 +0000
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
Subject: [PATCH v2 next 4/5] iio: sca3000: manage device registration with devm helper
Date: Mon,  2 Feb 2026 11:40:11 -0800
Message-ID: <20260202194033.627967-5-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-ORIG-GUID: monnDV-A9Zvm8eTsElWxB6T7lUAyJG0R
X-Authority-Analysis: v=2.4 cv=Sq6dKfO0 c=1 sm=1 tr=0 ts=6980fdc7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=TX5tIiqRz0IEpTnFED8A:9
X-Proofpoint-GUID: monnDV-A9Zvm8eTsElWxB6T7lUAyJG0R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE1MyBTYWx0ZWRfX/4ebkmakY6jh
 I0TNbkzZuX0TtIb4QvWQ9iNfyRvfsjW9VGPvtC7eU5Q+Et6v2OaxfgzCyzJOofQopqAS1+64gqK
 cq8JpBAiv9bVPyg+q+ehUBDy1nBvp/Nudd7ChjCJhVsdq27zCgqoPX+g1SmLyCjtaIF6JT3fdVA
 336/1rpm+alCPD4uIrm4mMjfqIa7Yonm0SM01aPsO1HIePiuZaXZJDj3kdCJHObTEBw3lQzODtx
 t1d5MgILJHtcOTCDUaMw10bBjsUfiF6uX8oYojQ9Y0YJWSwddh7f+4lnRFd/4Y9Q443bZMFTU9p
 TCNdkMzEeTql9eL+IzjJGqb6Ktuqrm9dRpHHx2Wd+BArQVUVA1z6D0tXgRFOI/S2vFDrx2BAa1f
 h8gYErqTTFTrWXKlSww4QLVkEQFdqZI8tEKUwr7EH68oMQ2R28Fta+VLegiLAmzT7ZF4EtdJ5fL
 Eqxhc9tgfAts/A/fWHA==

Convert the iio registration to use devm_* helpers so the probe no
longer needs a separate cleanup path and remove callback can also drop
the unregister. After this there is no need for having a remove
callback, so remote it.

No functional change intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v1-> v2: This was a patch 3 in v1 but moved it to patch4 to preserve the
teardown sequence (unregister the iio device first, we can disable
interrupts later) -- Thanks to Jonathan for the guidance on V1.
---
 drivers/iio/accel/sca3000.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 4faffeea328c..989074de18b4 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1520,18 +1520,7 @@ static int sca3000_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static void sca3000_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-
-	iio_device_unregister(indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct spi_device_id sca3000_id[] = {
@@ -1548,7 +1537,6 @@ static struct spi_driver sca3000_driver = {
 		.name = "sca3000",
 	},
 	.probe = sca3000_probe,
-	.remove = sca3000_remove,
 	.id_table = sca3000_id,
 };
 module_spi_driver(sca3000_driver);
-- 
2.47.3

