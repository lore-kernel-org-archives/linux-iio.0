Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA843081DF;
	Mon,  2 Feb 2026 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061270; cv=none; b=WbH/eoLEFh0yDtCDv+cAlSXZR6kSCHC7hYABYoz4724/MYPKdTY6NkF4LmnDaZrPairv08T+WaAE9StjABoycDCPCTD5WYSFYMN4btLZaWrZxDx8/qs3FPU8OJvuWJX1doC7x7RIu1Qm8h5BpVxFeK4z7XzMK/A1rODRH2NOjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061270; c=relaxed/simple;
	bh=ax92lBpMK4VLdhfSOhRHAYSY2oWIjwdzzAdFmfao3xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bT/AJxxEPMnJaAMOHpzjg+ZjV1DUpgOQWUDjZNCFNTGaFUcm5aVCw74bjlf0C/wYvqVadhOk4lrrcFoX4nJ/Yw+sj2AkTgl4upxk3m9HkJUlzgF8XwHP+gHBZpXCws655n7Gs16CaonlBNyBdpgEhgMxy3Ybvhjc6e6nfjLYZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mNPMfZwf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mNPMfZwf"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612IuEER2198518;
	Mon, 2 Feb 2026 19:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Bvhlt
	QZ5+qvXJMPvxkGy4pZ0eqB062+hihcHLT52xcs=; b=mNPMfZwfmvAyfnevwx+U/
	+qfkNtmfdIFN48w8smO40CJfxw4525zinZLGctV6JLEzTIr/g/SfhB5ilvNM24Eh
	IKyJBYB5+tvpoApNaJ3eKK3mxGffgwT1fco7UynQVOqmgiYifdAvEmGuskiptFBT
	on4Btr7xdKbAqYOV0dZwrGG6bXuvoFDgiB2WHyxxw5+MbIiDSUbgoM9cDI1SZzKO
	3+xKrgnj9xW/PPPIxhWR5lRVLPu7TJqMlOSwgRvVmSHOSptheBMttUQha273JUYH
	dEYYtXGCNXuYYa4MGcKDbMBBiQC2i4TXAW7W6y3jlKYemrqwRidf05BrVnRTZJ2W
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1atmawnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 19:40:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 612JWGHk003367;
	Mon, 2 Feb 2026 19:40:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c1868us97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 19:40:58 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 612JeaU9019500;
	Mon, 2 Feb 2026 19:40:57 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c1868ursy-6;
	Mon, 02 Feb 2026 19:40:57 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Gustavo Bastos <gustavobastos@usp.br>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
        andriy.shevchenko@intel.com
Subject: [PATCH v2 next 5/5] iio: sca3000: use guard(mutex) to simplify return paths
Date: Mon,  2 Feb 2026 11:40:12 -0800
Message-ID: <20260202194033.627967-6-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-ORIG-GUID: XVq4FYbNW7kjkGq8TWgqiNjbEJQKjPMV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE1MyBTYWx0ZWRfXzvItVkxDrVx4
 M7lvpbSB6jwstt4OWVWi/5IMul6bPNerhfTgslmq1iGaZVm/OC09Qv9Mx74IvVSN9XxrHaAwaN9
 cbse41/ji3v9Hx12psutJebxz6v8HavCsl8Y59Q8H4VnC795oxi/xt5jP4gmSu2yodGS6dXMFwA
 TX8/TIE2rOsnxOwslvEFPjbe35+DQ63l7QseOGm7mHjUYOlcmRaHomZ+qiIbm7d+ZoalMLYsKNS
 EhOrsCLiYrOT68DLjIGk34duVVlSPdl/Ta8bmJQf+U4KbPx1ZVO8/VDwUpsEKu9eIHsTmbCmtIe
 s0drko/n7lqaqZvHzFT6q0sL7OvHw7uada8QD4QwrYfT7l/NOC/gznDFWnf9KyXe9L/gOEPzLaT
 +ACbPfApggUN1E1bnwmt901nIQhW1G4ZrWbqigWzl4Pgkh6Z9uK9D6vEzF7ancEFPqE/+3I71/d
 gyugBOZ9nfhNVemHMgg==
X-Proofpoint-GUID: XVq4FYbNW7kjkGq8TWgqiNjbEJQKjPMV
X-Authority-Analysis: v=2.4 cv=E+nAZKdl c=1 sm=1 tr=0 ts=6980fdcb cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Fb_YtQGqNHn76Ybc1w8A:9

Switch sca3000_stop_all_interrupts() to use guard(mutex).

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/iio/accel/sca3000.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 989074de18b4..1fccc493a0d7 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -7,6 +7,7 @@
  * See industrialio/accels/sca3000.h for comments.
  */
 
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/fs.h>
 #include <linux/device.h>
@@ -1441,18 +1442,17 @@ static int sca3000_stop_all_interrupts(struct sca3000_state *st)
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
 	if (ret)
-		goto error_ret;
-	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
-				(st->rx[0] &
+		return ret;
+
+	return sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
+				 (st->rx[0] &
 				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
 				   SCA3000_REG_INT_MASK_RING_HALF |
 				   SCA3000_REG_INT_MASK_ALL_INTS)));
-error_ret:
-	mutex_unlock(&st->lock);
-	return ret;
 }
 
 static void sca3000_disable_interrupts(void *data)
-- 
2.47.3

