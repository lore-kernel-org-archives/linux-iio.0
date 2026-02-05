Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918803A0B0E;
	Thu,  5 Feb 2026 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297186; cv=none; b=cppDPPfgBXHxplQa2W66bVXSr8RUtEv3sXm/tsdbswFYZ91Q2HlFdlUsGS1anbXlp8jowbaqfHbGpxv+2/0wXsFrcHrYuMcjmfV6WFrsJKRWBO/eIW63+eN1loUlu0gcx3u48p/4Pz/BJg44hj8qyHnsvpTDTITStSlBP379QcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297186; c=relaxed/simple;
	bh=/wPUS9cV0xqKTOleYUNuY2F/z6GSIl8yw8SIeK9LpXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnQcYzhHbwiPgZve7pfs0t1R0Tl5QvAfB0a4VEMoEQVx+1a2J1gizxhA/cuVhJEdjlUiTt/bLyuFbMxObCwtolExHGEFO0XEWjcTZuDIh2zu/4Vy+V+ZYypkWcqCKGpdXoS8Za/3p7O1DIoI/dfx0ILA21WxlLwhFT++GLrGWbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SGnT7CgE; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SGnT7CgE"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614N3dbZ2453313;
	Thu, 5 Feb 2026 13:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=lbzuF
	Uxr7CiMmL/KovieMOXKVrXH756GzhPXX2pCYzw=; b=SGnT7CgEy/MkwNo9RMt63
	6MVR+1aVdu4Om5ELSC9jkzzlScRT+gSG5YZN5M7/10KXvtJ1gl1OtCY6WTs0+a/R
	Z3Grs4UNPwYjNCHm+0We8QW4vv0MQrlMBPqy2dMVEYbsNPb4hvhZFUF1kyAB5Rn0
	eED86j7OLMRzynmlQCrJg9TdDE7uy/xc04o36E+TaCjgDFmbPjuZnuo+ni/lh6je
	TdGZIox41630pvVXKfYpfrTuudKC1IY8GM6rKkBxOKVeGvHM4+qNlxzXaQWoHjaM
	qNL5eCFGH+/3B16A0RKpechbxIkakqUQR0V6uZWh1Nwnh4WY1kpKSoZR5Rr/b5nd
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1au67py9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:13:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615D3Tc9003605;
	Thu, 5 Feb 2026 13:12:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186d55j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:12:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 615DCbE5038070;
	Thu, 5 Feb 2026 13:12:59 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c186d55b9-6;
	Thu, 05 Feb 2026 13:12:58 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v5 next 5/7] iio: sca3000: use guard(mutex) to simplify return paths
Date: Thu,  5 Feb 2026 05:12:11 -0800
Message-ID: <20260205131234.3244467-6-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: t2HiztFU7m9-zKSsSdgI1MitY6deIiym
X-Proofpoint-ORIG-GUID: t2HiztFU7m9-zKSsSdgI1MitY6deIiym
X-Authority-Analysis: v=2.4 cv=Nf7rFmD4 c=1 sm=1 tr=0 ts=6984975c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Fb_YtQGqNHn76Ybc1w8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfXyMCjBIEH41be
 3n4SynP1Vp1oUBAbEjroOi/RLByyp8Ls0WQKhADpDAfHiAN69VMZTA8RIOwGjk42IyhlX3mpKk8
 lW9VMaQFaIhfod5BLh8vVOHDTsPBMmpSUsxbdT/2uUfDa+XQGms8LbUzFVQy7WliA4t5nGCnXUd
 J8yOV+22qPa0culjMM06qM5ot1JFGHTBHaA4CKD1Efw7GotDL4RIIGbkYX4j6RvdsO95BRJBDYk
 rI44XIddLowvt7eMHB5cqmagyS46WUp1vWzfEiAFWxwcYs8kCyFiJT3dJ72gbUG4vzAotK/kG0j
 b6gDRjqwStG4Y+8OGl3TcI9YJiii2eyKfbeWNvRdMXjieooaoMMLuAAfthi1ZGO+aQLqXgBlSH+
 zrNfVrdF7zg4e0IYPXgYSz3VVCE1xsRLy27BCiMJO8SwnTQu0zaPK/IKWb5Thu1ROW6mH8N+edi
 jtOHgY3o6donO46wG5Q==

Switch sca3000_stop_all_interrupts() to use guard(mutex) to simplify the
error paths without needing a goto.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
v4->v5: rebase it accordingly as we didn't change label "error_ret" in
the previous patch.
---
 drivers/iio/accel/sca3000.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index d3e2a981874d..56ff646684c0 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -7,6 +7,7 @@
  * See industrialio/accels/sca3000.h for comments.
  */
 
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/device.h>
@@ -1439,17 +1440,17 @@ static void sca3000_stop_all_interrupts(struct sca3000_state *st)
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto error_ret;
+		return;
+
 	sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
 			  (st->rx[0] &
 			   ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
 			     SCA3000_REG_INT_MASK_RING_HALF |
 			     SCA3000_REG_INT_MASK_ALL_INTS)));
-error_ret:
-	mutex_unlock(&st->lock);
 }
 
 static int sca3000_probe(struct spi_device *spi)
-- 
2.47.3

