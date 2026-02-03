Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71357340260;
	Tue,  3 Feb 2026 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121311; cv=none; b=tKnC/8d0fv/2CWGcRNsbIq1GV71FUzmc09DQVkPbmlY9Ajr56Cw9rYPyJy8ON4tCvS1gziV3Jglsu2M2shZUtO86i4qwBFKhg8eKWd0BmEMimgMFF24oeJO0wLN82KLZ+It3eprfnm3T7nKywojghplXFk7Qqi5La/LYC3uozeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121311; c=relaxed/simple;
	bh=AHn1T0h9AlDT9ZjNbLSIAf6/10nKBYK471R/fQzK6b4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ri7UdwKn3VYga9TyqDqFuobT+G/PyUirNXfvbciv9DpUXFqMsEAOA34ZLbSOzJJg/t7sRey7yewkE8A6kLABCEVFwrhaX5ywcIJirRNwxVCYfSQ88O6G8nueF6yXqXSJdKfFOAN1he/oaKdw9ZWvRaP3/eMfxdke7W7LdRAiPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TtSKYNso; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TtSKYNso"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vFpm3765849;
	Tue, 3 Feb 2026 12:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=KMqjR
	EqVc0bVJnnFgsqhJuHDUPxDk+ExKpMUFEyzbZg=; b=TtSKYNsowK0shBWZyvpQr
	bXEjJnwXk5acPESRBiFQoGtqoUAsW7zgwC06kmbUhlRTh6P36bgaIkxuj7cMxwYB
	fS+kv7ScNjnVTZrj1WUTmf1CFGayX+xL5z5W25H4OFl1hS2Y8O1J6GBHDYVGgn2q
	aV8UTk/pd8Md9UNuliWpKlU3F30jczdEc/K6SAgraEU9RY9czSQcFacRKEn0wztg
	fxHCvTqJ/tii97ZpZl9O7UAAdXEI2MmIdsqfcdsTT+cUttE3YEJhmjqzMj/7jQ1T
	vX7cD7ueZCU5YAf9BtpCy3Q4Qb2qiO/w1TmxDQWyrtpMTutZpOzEAKpV2kSl4AC4
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1arhkwsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:21:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 613C16Wn025691;
	Tue, 3 Feb 2026 12:21:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c2578c7nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:21:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 613CLCVR024167;
	Tue, 3 Feb 2026 12:21:43 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c2578c70s-7;
	Tue, 03 Feb 2026 12:21:43 +0000
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
Subject: [PATCH v3 next 6/6] iio: sca3000: use guard(mutex) to simplify return paths
Date: Tue,  3 Feb 2026 04:20:50 -0800
Message-ID: <20260203122109.689669-7-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-ORIG-GUID: rlMIRkHzUoexBGaq3p9QgOieW-z7uZYq
X-Proofpoint-GUID: rlMIRkHzUoexBGaq3p9QgOieW-z7uZYq
X-Authority-Analysis: v=2.4 cv=fdmgCkQF c=1 sm=1 tr=0 ts=6981e858 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Fb_YtQGqNHn76Ybc1w8A:9 cc=ntf awl=host:13644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5NyBTYWx0ZWRfX8RgFDg3yRRe3
 8naB9mZR84h8DFQiQ/xmcVzXysC3JaTUC7tLdYdU6jHBIPNnw1fU/yvfKUS67vwzLVOLX6YtSbP
 BYnUAJW6Y0UdCdWshvFR0H4JwRvvFpZR3KdlnlIYjRFbxU8Ne1m2e8CroRrEc0Y9zQMZRFATh19
 m+kLlajM+ZjJTuyzce4WS1HMcHpxw96BOWaj3GenEDCOen+f48kVl5pq5kddnfKJqUz14Q6qBXW
 3Md9tpBoGV8mDKXVQpAZjg9fddm3T9zYvR5qqIPBJWwZoMK+qINjRpLCer5bLzNd7Bdq6gclmRW
 GgNBAGH8wYsW3JOkMPDSpw0ty6X29LYaX361iGwsDLfMo29xRblYr8FN8F0HSPa0M/cKLsyjM8d
 ewaLePgYAnpk/nP810XER3uckkOag/36pILggx03qp22BP2oU/bQf0fp9WlvFKy17CV+K3V7bkx
 Zd+WTa9QiZrS83KBc9R7Ludl/WJ19Br4BW9WiThU=

Switch sca3000_stop_all_interrupts() to use guard(mutex) to simplify the
error paths without needing a goto.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v2->v3: Had to rewrite this patch as we have changes in patch3, Also
mention using guard() based auto cleanup simplifies error path( Thanks
to David for the suggestion ) -- didn't include RB of David from v2 as
the code is slightly different now.
---
 drivers/iio/accel/sca3000.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 419c30453805..307e51279cb6 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -7,6 +7,7 @@
  * See industrialio/accels/sca3000.h for comments.
  */
 
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/device.h>
@@ -1443,17 +1444,15 @@ static void sca3000_stop_all_interrupts(void *data)
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
-	if (ret)
-		goto out_unlock;
-	sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
-			  (st->rx[0] &
-			   ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
-			     SCA3000_REG_INT_MASK_RING_HALF |
-			     SCA3000_REG_INT_MASK_ALL_INTS)));
-out_unlock:
-	mutex_unlock(&st->lock);
+	if (!ret)
+		sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
+				  (st->rx[0] &
+				   ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
+				     SCA3000_REG_INT_MASK_RING_HALF |
+				     SCA3000_REG_INT_MASK_ALL_INTS)));
 }
 
 static int sca3000_probe(struct spi_device *spi)
-- 
2.47.3

