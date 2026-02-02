Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1A23090D9;
	Mon,  2 Feb 2026 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061259; cv=none; b=XBN9Hz2K3kLZWI/+OMVKOnDV3wrArRIOMpGK/f4H8KwbyY4rer7vcrNcWFrTrxWpDut/U57gg8KAZGfHHlhYEQSEk26xp4aDS175TEH0Ga9d6W8ZNYUJz2RMBsVA1gnYr1fVSE1x63Nhmc99F1hJfd8wrjVPEbFryVrT6klSP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061259; c=relaxed/simple;
	bh=sD0utbWyrvtmYNTdsIZBf2XSHsJzIvm4Q8xEOrwaYkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITGzkE6VmRxIZhL+IJIvCi2atvST8X9igtSP/4kK0AqgkqncMeS+AQcfH0uGBBOA5DINkzWheYQOZCMk2JHJgWBL6mJfX+fJBnRplouNm1NrvhuWUPBJTqZJhniDmLUkdy9mjkvqv93IAGuhwtRORV43/kCmRUPHTFEbym+XeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ltpYBCYA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ltpYBCYA"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612JIoOT1385262;
	Mon, 2 Feb 2026 19:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=jZIGW
	dr7TYcOInlEBYPyl9CuinfHm0geUXksGpgjt44=; b=ltpYBCYAsfN0v+l+8l1t2
	luarKTphfkDlgxxmFd4jhhUSiZu4p2U26LQy6I3fHmHglHJJrLVs8WxE/VQTbtoZ
	S6Ult6j0fjWv/ENLXTezI7ZTBNTYLbbHePOJ9ErkgcDrybTSPbtZEih+CG/lUy82
	zE/Th1emxuJiiJSz4ptXZ8vnarN5FZeRl2C6atkQWIRw/uApIvqcpip5/JmtUMy5
	rMHL4+Jevz9cEOwZr0EpIoD1k6rPbtM6jhGtER8XNDlGyUPhtuSruc//GHycUovC
	fJdJpVAqCTOxrcr+Rn/zhUYAtxW47azZoFi/7W/OcsEmgzhZ7T0jW4YWxwNPIbyx
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1arhjuxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 19:40:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 612JTTJd001228;
	Mon, 2 Feb 2026 19:40:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c1868us43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 19:40:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 612JeaU5019500;
	Mon, 2 Feb 2026 19:40:49 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c1868ursy-4;
	Mon, 02 Feb 2026 19:40:49 +0000
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
Subject: [PATCH v2 next 3/5] iio: sca3000: stop interrupts via devm_add_action_or_reset()
Date: Mon,  2 Feb 2026 11:40:10 -0800
Message-ID: <20260202194033.627967-4-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-ORIG-GUID: VAWc72KYQP86Sg77U16zdzgjDVfyHLVM
X-Proofpoint-GUID: VAWc72KYQP86Sg77U16zdzgjDVfyHLVM
X-Authority-Analysis: v=2.4 cv=fdmgCkQF c=1 sm=1 tr=0 ts=6980fdc3 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=r7h_biJ6kzdeNql_50MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE1MyBTYWx0ZWRfX79McXTXnCRet
 yOKw67WpMszGmS8zRCS7qx0y13q6t45qwtzy3USGOI/oBofiGFgRS+bosaE7h+6lM88dus6VPAH
 HM/dvNsfvLd2fHbZc9nRafNzkI+iHDtboTzjCvZcTsRR+vNpHwDYzqQoz9jhy4TkteAEtlgZAY0
 e7FXA/3KpueZvI2JqKscGsdwZeNzZt76EImOA7GksbrS1xrZz9ZNGNCzT0wlMkX/QvDIuIZ2m/v
 UIPqvHynnBo9wBRzZ0zOT/+4+4x8+tlPR+7vzel/BbgsII4vIAqayKafF5fY8tj+P1v00UU2eb+
 O2JeR1q5hSGWmZqtrDOlBxrKAJfSFfaAq1OrOA3s8Q1O1I04Aabto12ASOjDGGYZjDTu2p0pwRm
 xhw9FZNa577con5U2w9XzLU66G4ptOftBO4M1rPNfbbYr07N1E2W+Ec+4JwgIfqzsTJjgz1ESkg
 CPuwINpwXnOpFT4AcpA==

sca3000_stop_all_interrupts() is moved above the probe routine so the
new function sca3000_disable_interrupts() used in probe can directly
call it without additional declaration.

Used devm_add_action_or_reset() for shutting down the interrupts.

No functional change intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v1->v2: Jonathan found a broken tear down sequence that was introduced
by my ptach 3 in v1: https://lore.kernel.org/all/20260131163218.2a4b93e5@jic23-huawei/

So first converted the interrupt disabling task to devm based call,
order of tear down is as follows after this patch: iio_unregister_device
is called in the remove() callback, post which any interrupts will be
disabled with devm_add_action_or_reset() call.
---
 drivers/iio/accel/sca3000.c | 53 ++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 37ef724d5dc5..4faffeea328c 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1437,6 +1437,33 @@ static const struct iio_info sca3000_info = {
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
 static int sca3000_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
@@ -1489,6 +1516,10 @@ static int sca3000_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, sca3000_disable_interrupts, indio_dev);
+	if (ret)
+		return ret;
+
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		return ret;
@@ -1496,33 +1527,11 @@ static int sca3000_probe(struct spi_device *spi)
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
-	struct sca3000_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-
-	/* Must ensure no interrupts can be generated after this! */
-	sca3000_stop_all_interrupts(st);
 }
 
 static const struct spi_device_id sca3000_id[] = {
-- 
2.47.3

