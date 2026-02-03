Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ADD3128C9;
	Tue,  3 Feb 2026 12:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121302; cv=none; b=snXZFJP6ja/BrVUV4COLnbPA3h1IYHwEQ+/iFKTCCeUEAaVVQqqMfuDrtVZ4/p9gbFfGGmiqu8NvH/tid0FJJtjF1HKErdNM5u6I4czIVZZO6f00UHhp3rcYOW3qmvhkt7hXPgq9CzOQ6gmQnGlcCI2eKZKeCuEpEPKFf9E26oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121302; c=relaxed/simple;
	bh=MLe9QcZxMq1fbuIvVEetAas28vucNQHvlwRamg9cKY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feFwXG7I7/iDnmVesV7ySt7sbuiPykg6LDisSrUhJFvfOj1upngtgn3t3sVK36wvPE2GqhF/aJlSG732AfrLN/afz+NgTY9XazjcyQQ58Kdf1sQDgoFKWX3Im7WVCkM3HkFzxeGiKgqymW7EN3f55b+rV9WulNbE5wdHCsAHs1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qzeQzQzC; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qzeQzQzC"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vHmg3502475;
	Tue, 3 Feb 2026 12:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=LoglM
	UjcJvILlwBybRqSYvWchUorTjZaJQYjTdFo/8E=; b=qzeQzQzC4O+ctsb+Csaq+
	iUZ9Z/WiurXkuO8KPrby75rHgZh3DymtgAVvviej5YmraJiYulze36JYGjEn04uI
	hqiM7mC/fGnEZ9gdvWr2MEnjC5avgz2UaI0HNf8eUB2V0JzgtNJ6a2rAOsY3p7C/
	BTDQ95WKnq9IMeBvidMTgVul0eFv8RsvoOQTUBQ2NZWp2N2FN0hDfsurXPIoWvOb
	lmQ6Loc9NXMb0P4Dog7LuEM8meplFdT4J5E3G1YUqTSjC7XKP5eJ+z3GgUWpbH5U
	uqK1fF9+edUpU5nMnTXKEii74/xWQnpR7GrbOOlZbqMJRqm4th9KnXB8/tbGxBFs
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1avj3xwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:21:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 613AtI5w025715;
	Tue, 3 Feb 2026 12:21:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c2578c7gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:21:34 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 613CLCVN024167;
	Tue, 3 Feb 2026 12:21:33 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c2578c70s-5;
	Tue, 03 Feb 2026 12:21:33 +0000
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
Subject: [PATCH v3 next 4/6] iio: sca3000: stop interrupts via devm_add_action_or_reset()
Date: Tue,  3 Feb 2026 04:20:48 -0800
Message-ID: <20260203122109.689669-5-harshit.m.mogalapalli@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=C5DkCAP+ c=1 sm=1 tr=0 ts=6981e84f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=AKfxoly6AAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=hD3i4eV5otfxJbFHET8A:9 a=4Q71d_afUUiBcdzZNBSr:22 cc=ntf
 awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5NyBTYWx0ZWRfXyNik+ZISLJAQ
 3ulD/WdmgsCfBirLczZej12dAG+OW5vtOqS+pRp4PbfEU6pjNw4KZ8NzHQEKdU+eVxEARHjOIOh
 ZY1FrwecS0dvfvAla3zoebeMJT2Dr2auQGz55LowZkJ/F910vRZafYnVIQYHd8X+WKxXFnFKctA
 I/NY9ZP3/+LjpKbhoFhyYuGqnBpGO76L/Lmf1reKeY5I3csXJC/ddkuX1eyE0Fj1YJj6YaFVR3f
 GkMuGJXhHUsZKOJ56ua4+17a7VzhoGL0RtBAKOS7VdTZsg+1yXhlgEpzwiEm8lRekIDqc7XXjNc
 kIkSDWWWLz8i232/29tsllqfKalFwfl4H5f1d3VXPic3R6AD2ULU9RdEQs+1oRKLRSGlWYqKRyA
 Sf5lhMNcllrg23iANk7Hw0JDDV4oLgPISMmCKWy7OYajWyF76L64PNxQZBtHKInUWX/ViIqFhQx
 euIrM5w28ll4dgdUIB2NHqEZJW/mzdUzkpMXUqnY=
X-Proofpoint-GUID: NASh0IjLcecdykPAybRyc2vHiYNuevJE
X-Proofpoint-ORIG-GUID: NASh0IjLcecdykPAybRyc2vHiYNuevJE

sca3000_stop_all_interrupts() is moved above the probe routine so the
new function sca3000_disable_interrupts() used in probe can directly
call it without additional declaration.

Used devm_add_action_or_reset() for shutting down the interrupts.
Make sca3000_stop_all_interrupts() return void now that it always hooks
into devm cleanup.

No functional change intended.

Suggested-by: David Lechner <dlechner@baylibe.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v2->v3: Don't add a new unneeded wrapper around
sca3000_stop_all_interrupts() and make it a void function.
---
 drivers/iio/accel/sca3000.c | 46 +++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 37ef724d5dc5..b89439756eda 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1437,6 +1437,25 @@ static const struct iio_info sca3000_info = {
 	.write_event_config = &sca3000_write_event_config,
 };
 
+static void sca3000_stop_all_interrupts(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct sca3000_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
+	if (ret)
+		goto out_unlock;
+	sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
+			  (st->rx[0] &
+			   ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
+			     SCA3000_REG_INT_MASK_RING_HALF |
+			     SCA3000_REG_INT_MASK_ALL_INTS)));
+out_unlock:
+	mutex_unlock(&st->lock);
+}
+
 static int sca3000_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
@@ -1489,6 +1508,11 @@ static int sca3000_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, sca3000_stop_all_interrupts,
+				       indio_dev);
+	if (ret)
+		return ret;
+
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		return ret;
@@ -1496,33 +1520,11 @@ static int sca3000_probe(struct spi_device *spi)
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

