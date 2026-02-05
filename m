Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514953A0B0E;
	Thu,  5 Feb 2026 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297192; cv=none; b=Wy/5TtwFFa9Re7Jh4tCKgkmXzKDtqe2uSGvz0/02zz8lIiSxDEkrRNPAcJWPFEulh56K044Ica5OT/DHC/IyoAFo58mbnG7+YngQGMVy+KHsoPncFKrNq8YknPenvp2KwQ4WFxyGYRPRtMK1vCcFHw+857lx317T8ceJMsDh3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297192; c=relaxed/simple;
	bh=cqx2EVfWHXbkjp/7PC0dXNOUYZ0rTWtw4elZE54WjUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsDAfVehpoSL37ECYpJxpm5fW/VEZi9KhoukwPXWWnE+1ntyWBZmkWfznYQDtR+Xamh7/I3nXY56skh0z8G7n7Rh4+8q7ffzOT7eZgqNV3s3w9OU2TkPE4fuVJphx9mtrBeL3dhgk6CjMC8hFN3jt6Hh7/6BdmnkZ4k20A372Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YSnoWE0k; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YSnoWE0k"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614NGfYi2453238;
	Thu, 5 Feb 2026 13:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=xPkAT
	GQtIoyKWOdZf6accwcFRfJmM/Cqq4uijf0YxXc=; b=YSnoWE0ko3lsWjkrtBuDC
	mmQrakIJR7TzXtXoAqIwIYUQ8AO6ZeOM4vIK0yZ6bDpXO0YCWU97qEEzeYHS/GHj
	18rd2/rrsC0vD4tzihu5yq1MeAhSDeaRYeRmGN5m4INF0FSZzgs2JVWDP09Yzmf2
	38qENylUB0xlA1opKcsVWBKWBY/BRkVQztoztnLSIJqnud7F0L1CppDzTIbAwDg0
	qkXEXWOLVAi6Bm4X9rGD6XkMFLKALaw8gl9MI1yfLsO23LjnngTGO7YzWnMd6meO
	6dPjptkX0QcV9a8V195Yw0NGwirO7nU26fKWZ43ukjkP3EEF0g6JtzZD3su0Rpq9
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1au67pyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:13:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615BZqjA003449;
	Thu, 5 Feb 2026 13:13:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186d55n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:13:04 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 615DCbE7038070;
	Thu, 5 Feb 2026 13:13:04 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c186d55b9-7;
	Thu, 05 Feb 2026 13:13:04 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v5 next 6/7] iio: sca3000: stop interrupts via devm_add_action_or_reset()
Date: Thu,  5 Feb 2026 05:12:12 -0800
Message-ID: <20260205131234.3244467-7-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: bYEaDreFoJCnmHS6GFJ8whgE61D1ltLC
X-Proofpoint-ORIG-GUID: bYEaDreFoJCnmHS6GFJ8whgE61D1ltLC
X-Authority-Analysis: v=2.4 cv=Nf7rFmD4 c=1 sm=1 tr=0 ts=69849761 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=IpJZQVW2AAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=mjWuCRx8u4tSYEBlnWYA:9 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX0iwe7O8rU6bf
 HrfLCS4ps1xHKg/GFyIKcYtP3z1RA+VVhSosEAZ78ZXLdsrNc7h6UODgSYsZFjZU+z0dgOfypjp
 /YPyVs0p2sLyFvVhKnCdgvRp/cjp1XOqNxOxaytXvLCp9UqKRShSp8Ae/U5bnGAyDPSJtdsFuVs
 4I9g4qVlynX+HrpwTSfxWRc1Um9xu7KrlNhOnmdfXvepGR4e2val6n2e7/TYgt8Ll1Qb4a1Tvou
 T+cv+mLzjgBMYZHsTHg2gbMajt7h/wu1U+MIlMdBpaezTJ2JlYUcWcygk1QUDRnJ4gaB9WDGV0k
 vyzTlCs7gdJN4y8V5nCZXc7mwtxr4094QbPMKejGEm2qiTUSi1kHYQRbOGcBx993Gqn4MdjEGVK
 iOItMuOnClnXZmoYcCgE1+Wi4UdfOLer6d9WnHZIRqk62mTRcPyUDmUGoefE1kHV3iv85IJyDCs
 huL1ciRLC2NdcJ+sNMg==

Used devm_add_action_or_reset() for shutting down the interrupts.
Make sca3000_stop_all_interrupts() return void now that it always hooks
into devm cleanup.

No functional change intended.

Suggested-by: David Lechner <dlechner@baylibre.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v4->v5: Offloaded the move of the sca3000_stop_all_interrupts() above
probe in a earlier patch, thanks to Andy for the suggestion of making
this simple.
---
 drivers/iio/accel/sca3000.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 56ff646684c0..cfc3353f7ffd 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1436,8 +1436,10 @@ static const struct iio_info sca3000_info = {
 	.write_event_config = &sca3000_write_event_config,
 };
 
-static void sca3000_stop_all_interrupts(struct sca3000_state *st)
+static void sca3000_stop_all_interrupts(void *data)
 {
+	struct iio_dev *indio_dev = data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 
 	guard(mutex)(&st->lock);
@@ -1504,6 +1506,10 @@ static int sca3000_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, sca3000_stop_all_interrupts, indio_dev);
+	if (ret)
+		return ret;
+
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		return ret;
@@ -1514,12 +1520,8 @@ static int sca3000_probe(struct spi_device *spi)
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

