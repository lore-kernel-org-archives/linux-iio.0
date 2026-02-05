Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541DB3A0B0E;
	Thu,  5 Feb 2026 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297199; cv=none; b=P/WUTOAw8db7V4tbTX1vThUPPcPT03l7G6LpzR2tTPRqLZh7SHrKxoduxyhiYKfS/zTOk5ueFCRhBMvYnfzkZgH1AYWlM1wc58/5iE7rkyfMkkQLBLzyTbDWtrb057/G4aRtxNTsxkfMUL4FelPkFfnWDDPFWSD8nA4egaZqIR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297199; c=relaxed/simple;
	bh=W1l3BG66FZpu6RpW3YmOTfR1KhTLDujC/83K9BApQrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYaMxmgodEJg1MAjKF+TjT3mIRIQiltOsXHsDd6a7fAPnp0ecuoGQhyyPtB92zgrcHCL0ypKfoRlJUDgdnjdlTulmYEg8sgKpMwB35/DWxE/XTAwushLqfDtPKsDeZARuYtb7FYsKYEm/jvzcShfOOFJ9ebVvFKZuhRzUjQd89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZdrJMSUN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZdrJMSUN"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614Ka1xe2730756;
	Thu, 5 Feb 2026 13:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Fh9xo
	OM903iacZumat+t8PuBkVN4UlB84F4tz2RNITw=; b=ZdrJMSUNbCe9gURycT/VS
	8NJLtk6AgfsjiqsZtfHzVUJeBMeWHsCtbTdKnXti1Yy+bxNg1hgGSI7qVoKfUbAq
	t54yJv78ljmAqIJAhrCWQZPeXMoiiRN3REza6rf44yTqGyOZclmUhIvNic70YNlk
	zIrtdKg1gwv9b0J4dVxJlfH8fwQRmbkxSEzq1gbpUByqs1LAmlNqQSIm98VzbJyC
	XF3ZSxyQfuuh0dOaVWDBK7QRHVYKwktM0I59yEf0o0QYeUouXj4Cvy/twTcfe5wg
	iGAZL3S8I35PBo0d7GecmmIsgIRkZ/cHxMw1DW9LEsA/unbHC9uC/oTpN0lqIa7H
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c4d9v10ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:13:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615AvAea001347;
	Thu, 5 Feb 2026 13:13:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186d55qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:13:09 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 615DCbE9038070;
	Thu, 5 Feb 2026 13:13:08 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c186d55b9-8;
	Thu, 05 Feb 2026 13:13:08 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, andriy.shevchenko@intel.com,
        David Lechner <dlechner@baylibe.com>
Subject: [PATCH v5 next 7/7] iio: sca3000: manage device registration with devm helper
Date: Thu,  5 Feb 2026 05:12:13 -0800
Message-ID: <20260205131234.3244467-8-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-ORIG-GUID: VDoqOGYo96hI17KfRc2wn8NdfNtCffDl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX68aNE5qPYO+G
 1jt6iOK0FA+qTh4muTZAeJy/3/fzJzhZjvIQRp+vuIS36Jb5DJrRt3FttTX/MjiJamVf5D38We/
 TWyEhTQBQoCDUEnCdQhYvvvTsgU22z0/1oUMcoPE+QCUvCdHsWcOhcOwE+i69pNbmO4XXl9GuI6
 CN8zpRBOcYyGEZvGait6ejaAKbOHCEsApt+qWmGD2jEhQns0mX0Ge94LmukdFv/YW8NrmW5mZwH
 XqRwmZ5uvZ32wjaS8Giq2kHSiLIRMuG5BEnereuyxgjNrKDqPbFGY65fUAGhi3vUcjnnLfDIvxP
 gFuxzUuy62VTWya8MWdgssoSjMU2S1gyIDm8nZ39vwGUoX544xuhIVUAyKSib/FAXHL/lIIqHkV
 OqXEwRpEHaDWxpcKEFp/kEc1t00RCdaS59WQC/FtfVSo18XJtNicgdQ3EuD3gcEcS9xVm2DHjLI
 1AXAv8lQTF2tvi831tw==
X-Proofpoint-GUID: VDoqOGYo96hI17KfRc2wn8NdfNtCffDl
X-Authority-Analysis: v=2.4 cv=NprcssdJ c=1 sm=1 tr=0 ts=69849765 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=AKfxoly6AAAA:8
 a=yPCof4ZbAAAA:8 a=TX5tIiqRz0IEpTnFED8A:9 a=4Q71d_afUUiBcdzZNBSr:22

Convert the iio registration to use devm_* helpers so the probe no
longer needs a separate cleanup path and remove callback can also drop
the unregister. After this there is no need for having a remove
callback, so remote it.

No functional change intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: David Lechner <dlechner@baylibe.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v4->v5: Add RB from Andy.
---
 drivers/iio/accel/sca3000.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index cfc3353f7ffd..49abe4ece233 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1510,18 +1510,7 @@ static int sca3000_probe(struct spi_device *spi)
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
@@ -1538,7 +1527,6 @@ static struct spi_driver sca3000_driver = {
 		.name = "sca3000",
 	},
 	.probe = sca3000_probe,
-	.remove = sca3000_remove,
 	.id_table = sca3000_id,
 };
 module_spi_driver(sca3000_driver);
-- 
2.47.3

