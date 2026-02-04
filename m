Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DF4376BE5;
	Wed,  4 Feb 2026 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185570; cv=none; b=RIfOatq4jHaW///RUPCUBw+xnvvGoOaAk8jMgAVTn1pVC/i0+TZsuQ4UKrASMvLEohHszpgG2+EKaZjEMhrFcvdB01vgoUkG9ivS+RiYnyfMXuOxoVS3/BH0J2covprAHrgC68Ep40R+azyY8D1mQeuwPK/HaHbZsmsvYz6XUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185570; c=relaxed/simple;
	bh=4dV2WIY5YiwMvUwagQxea2LCppnTFc3jiBx2ATL1yPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irujo7zE/LdQKzpCRTDOIy6SJcqg9zsKn0HDzvJA4qUUgGY5Ujnn8GBkt8akswmK78mrOk5pUM1LW7AjVdn8led+wsFGsfb6/kMHmXFSnpVUZXVvht9oHyVC3S78eobRC5WWZYnQnStxOHKmy6b00ySj/V7qfqD4+MMiwCweUr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AqQotHLu; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AqQotHLu"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613IuFeY318462;
	Wed, 4 Feb 2026 06:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Dbl2o
	NlT3HUVq+EJAxkKT3f7M6JchCPfJxV3yM+Ena8=; b=AqQotHLuQrT3eWp1o09z9
	MKAQYdB5JpfvnAQxqicNZJLRDEHIOP+Lj0ywW8NfcgagKUHyt9E8bV9RC50EZAZo
	mHZsj0FxF6y03N03VfaFchYsuRKq1RPhJT+/83z2Y+rUr4i+IfGKsVw6neQ/AiFE
	Q2hr7vKk82QBLscfdBit8ao39ePUnDS54S1vkDG7Skc4Bai7OnpR4TIJEVWhW69X
	8UAL2L6zUipl1KL3hHtYwk9w14Zpw30U/bTc+LgS7MCU6Sqfz5/WqdtuXRjvs0zM
	VEISSHKWU7YwOPX7tCBa/OvXALqVmKBtHzuw4lkHR1gtPoaEWiVBIQ3ar3yhWqxw
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3k7uh52w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 06:12:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6143pthS018782;
	Wed, 4 Feb 2026 06:12:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186nhbuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 06:12:42 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6146CNO5032959;
	Wed, 4 Feb 2026 06:12:41 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c186nhbnd-5;
	Wed, 04 Feb 2026 06:12:41 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Gustavo Bastos <gustavobastos@usp.br>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
        andriy.shevchenko@intel.com
Subject: [PATCH v4 next 4/6] iio: sca3000: use guard(mutex) to simplify return paths
Date: Tue,  3 Feb 2026 22:11:59 -0800
Message-ID: <20260204061219.791037-5-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA0NCBTYWx0ZWRfX+u45InY8Jial
 g3xDeu9GMgvFLwHOOf9ikecnguBPN3MmtzqdGShBdGKPf83k1GmwfHF7HbmFsT/jJ+Ewup3fqD/
 4jwe5uPLLKf92gnXXwinLML9/y+xEnep3l2gQu38sYeGHMbppYJNycGo7lmQT1USHnRcebzhw/s
 doD3sndMmyFkizXZKpFXGWKxPerJfMx+J3tdB4ne8cDc+aXRdhvynSHx7rcHDn+eowL+Awp501U
 P6TSk4HXpGyELt9kwP9UeCKm2nTkaS14mYv9y6Mm+/6NyflF74rZBL+bD/7MR9VJoCH/ODPT12x
 g9aJIJ3iaIsSuNG8dL59P1m/KhhNXDq52pGvziRbGT3DkAPcrLDtB7MEtnfp7mYARfIyqO7t7vv
 ozsvKkZlxQ8PR+0UhX8kCsrSKpcIl5b9UOKUhs/uR0aXIo3fCQUzmCEFDpUn+2Y56dtmeh+C8YM
 I5kbjrSxuN83FIYN4u9si/WHUIc//Zy43knYyrpw=
X-Proofpoint-GUID: C0X1R9qq30wDLL8dYpqI6XW_8OCsgcS-
X-Authority-Analysis: v=2.4 cv=Z7Dh3XRA c=1 sm=1 tr=0 ts=6982e35b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Fb_YtQGqNHn76Ybc1w8A:9 cc=ntf awl=host:12103
X-Proofpoint-ORIG-GUID: C0X1R9qq30wDLL8dYpqI6XW_8OCsgcS-

Switch sca3000_stop_all_interrupts() to use guard(mutex) to simplify the
error paths without needing a goto.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
V3->V4: Move this patch earlier this simplifies a fucntion involved in
the movement.[Thanks to Andy for the suggestion]
---
 drivers/iio/accel/sca3000.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index f9680071bbbe..a46990453ed0 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -7,6 +7,7 @@
  * See industrialio/accels/sca3000.h for comments.
  */
 
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/device.h>
@@ -1499,17 +1500,17 @@ static void sca3000_stop_all_interrupts(struct sca3000_state *st)
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto out_unlock;
+		return;
+
 	sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
 			  (st->rx[0] &
 			   ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
 			     SCA3000_REG_INT_MASK_RING_HALF |
 			     SCA3000_REG_INT_MASK_ALL_INTS)));
-out_unlock:
-	mutex_unlock(&st->lock);
 }
 
 static void sca3000_remove(struct spi_device *spi)
-- 
2.47.3

