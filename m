Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6178356A07;
	Fri, 30 Jan 2026 21:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809428; cv=none; b=YFoPcZ+densRNTEL8FNqKjSJfeVqP0A1sjFkP/L2+HyjrNO9BTllomuf3DSpVxr1HXNc8wBibZYKQ6+BSlvmGZDIKKEvEXou6nNMJ3LzS/1kusNvCDLXAWX3u4K2T5nBfAqv81kXLM0cNszMSTK5MY1zFhevFj/LadyUGWm6h+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809428; c=relaxed/simple;
	bh=HjK0S4UJB+pkBWgeRGdhne2UiJUehPZNAWJqB1ll6FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxEJsKHro4+KzXLo8bg1dKy/J+DU5bPU5UO7uegpaO/uaahGNkY4ua7ceMptv9RCcOd5E8Dsf4L8ZwiHG7e7KNq2DJYv5w1veUoxPR7BQAyRD3b7nr3VzVSdeuYGh6nGYfRl2V5pzPFqcV1HOef4l3RFzN+w67r20/JkytzD5uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AEjQv1SB; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AEjQv1SB"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UKDY1q4028786;
	Fri, 30 Jan 2026 21:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=SvOs6
	/3ry4YJIweG5TA/qh9Wg3XrHz0pjWJkiZMX9Zg=; b=AEjQv1SBdPTQmyQKN158c
	BsEaQGjKNwdMFzjqE01UPmrJXlhWrYTJ9D5tCJ0LJ86+JsEhqlniAVrircV5cpnK
	S19m6Lf+mzNdM7PQyE20psPofDSMYXOQdPV2nTWBI0HpLTwE24Ax/C2uwh3VHz4C
	wFKq18MR9W9UYMQzfPeBgnWtRLSQQ7/celp8cnAzGAF82LOOS8Q0HzQDzYJT7nt5
	IK/PlE0+q/OLSHBG/CSKNAM38rIVb06YbNtcbGCAidXRkEasG6meTp5NpIrGPedC
	gd4/5EuQBmrAF7g06YvMMYMiWMtug9ctAj/AS4K2vch+QaINS7pKj2pe9Qz6F2cN
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c10668dym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 21:43:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60UL3P0p036178;
	Fri, 30 Jan 2026 21:43:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhtg56m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 21:43:40 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60ULhRtk035490;
	Fri, 30 Jan 2026 21:43:39 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4bvmhtg52e-4;
	Fri, 30 Jan 2026 21:43:39 +0000
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
Subject: [PATCH next 3/4] iio: sca3000: manage device registration with devm helper
Date: Fri, 30 Jan 2026 13:43:10 -0800
Message-ID: <20260130214323.236389-4-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE3OCBTYWx0ZWRfXwvraCHWDWM+k
 Y/65lEehYmiIZ7XqwIFad4nEQLgDXc1GxaPfTZpWlu6BYbk6R+7HgDMEf1iRNshGuokz3iYPPC5
 yudwjg68pApBRwaY1FYNjYpNeQGhMRfG5xL0sbwTdLs00pEPkaM/uKp1COw7n4Dt8mfp73d7ks4
 BGZzOBKAUcxxpicG/l1eHRy0zWDwEwbTQPqC1yqPwcyMETNuEDZ+KD+FWm2+dypLOksA9AjaxiZ
 svmVJykWVFG3WR4YqWpYr+mKalfYUCDI4Dllk9H0HYgbTTHHBl5ikd9M+WXhsay2Ww2I1diS0dE
 8cq338g2GZXDYywk9pLt6yVJjHxpOY5oIPCDQifPW/ORxCqM9p4hPbb826Aj5Am1QppqlLafyFC
 b2q102F9QQbsHKQhh4w48wHKHSUZtrjOAP6HwphKEIqqSgicFVkEfHpNyrp5VQNxL93dOEFq7tf
 wIc9uxsn34iFrEDHWXietalk0nhVP4FacC8j/egE=
X-Proofpoint-ORIG-GUID: CdcOq3kmIIJGPU2ZsrFLdEdtKlU6Imis
X-Authority-Analysis: v=2.4 cv=EebFgfmC c=1 sm=1 tr=0 ts=697d260c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=f-Xc2Zeil6Wuw2QwVq8A:9 cc=ntf awl=host:12104
X-Proofpoint-GUID: CdcOq3kmIIJGPU2ZsrFLdEdtKlU6Imis

Convert the iio registration to use devm_* helpers so the probe no
longer needs a separate cleanup path and remove callback can also drop
the unregister.

No functional change intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/iio/accel/sca3000.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 0210c716cf38..bf1957c7bc77 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1489,11 +1489,7 @@ static int sca3000_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		return ret;
-
-	return 0;
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int sca3000_stop_all_interrupts(struct sca3000_state *st)
@@ -1519,8 +1515,6 @@ static void sca3000_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct sca3000_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
-
 	/* Must ensure no interrupts can be generated after this! */
 	sca3000_stop_all_interrupts(st);
 }
-- 
2.50.1

