Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425183043A4;
	Mon,  2 Feb 2026 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061244; cv=none; b=duITK9tMHqMaetxYFFDmXLagK69zrOgDY4KdSs8sUmtYQ11nXCjDZH2VVBcPDSkmMmWT49TKJ7pMjvO6HopmO13dTeQVONn3yROaL6lQpHjYlwp32Q3cQPG7cHaVgzXoXQMa3CuHUJ+E3h1SQhSF15soG9Efe0/2K7xF3vkpoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061244; c=relaxed/simple;
	bh=/nFzEeSZmYeyrC6AGWNiuGGWHnhKXaBQINf2HSAQnBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCGrqEQlyKeDn8fHNwNGBbHe6tZetV2VcfgK4jZ4Y/6NF8xxebNRxryyMB6uepiWFFRA8792vIgRpwpCvL3TNBN5QXAmLMWhHEEzu3Gx95ETUybpBccdqzUzkWzxtoUXuZvlSqlMd+LKKO4Z12Ee42YLhhg8aDKwY+e/vi23/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pDBe+hF8; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pDBe+hF8"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612JNZ2u943963;
	Mon, 2 Feb 2026 19:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=X+xQV9pwQC+n2Wx3Gkm1JYLTp4dcT
	G4Y1JxHpy0JWrw=; b=pDBe+hF8wrCwr8Xl1L2Ue1u+syes+xY5/uD1FMcSFd4Yq
	LkukSgStyjOoxH0YU+NvipLaQwvnqoPHuHInNHhJo1o29wppQPXyErYhiViWXDPL
	x6WTjLmWWaT5B1vp+N8T9ncbORzoy4pZlwqqlBb+G8MJLnKQ6GNPIFVCX9PkTHkT
	uyc4wavr1EHM/gku7p83P4RnaScmF/GHR6dQd+0vA+pPaEr6wuWjaOeEUUqYhGOO
	oWWPpwnN+f2rKH+QiMrdDegFxbbaL9V7B1yYCImACg69Z9BgtuQT16xxvm/M0A3X
	pPejGxA6DspEYcWEr5m4eKsw3Mhz9kJxJBl/r6jgA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1arktw58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 19:40:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 612IT0mE003402;
	Mon, 2 Feb 2026 19:40:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c1868urtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Feb 2026 19:40:37 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 612JeaTx019500;
	Mon, 2 Feb 2026 19:40:36 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c1868ursy-1;
	Mon, 02 Feb 2026 19:40:36 +0000
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
Subject: [PATCH v2 next 0/5] IIO: sca3000: devm resource management
Date: Mon,  2 Feb 2026 11:40:07 -0800
Message-ID: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE1MyBTYWx0ZWRfXzv9Q080B7lUP
 CNxB3uq4MjuvUFy8+ciUTUDUtjfwf+XWUGVlNoJYuFyCMxpRRnRvJjYT3Oy6UZopesXhb/YaWrE
 1xgU+PDkQkM26OenXQw4RAuzTJ22xdqKUJSHsfnq/6OQ4e9lpd2VePZN2Xs/Fnu+YyZwwfE53px
 2X7m2xMVZSnM0ecF79IYrjsOMrriJ8h0TEhvrsyvS/1XN+zIIxRzy9BIH9wcigXUU51KsUi5JmL
 9rxHNNU2VunBf8u4Lo0MNO7ZKN7t31ATPiuIf0ys4264BAe0G3UDSerJ0+rv/k6JeGML/vqGefo
 B8TnVptSHNsxdDjOm28s9p3MSxftNYT4YfSHkZCRtFPUHMs61XDbZ03Lg6G3VDvEv2qhdKkwR3z
 GS6nfml3hVzo/YKa6UUh8zHQAmQKWW3CAkry/fvWtTE5F+JpTBQVfKBLrczGue7GVhkXG6a4UOd
 E8G3aTVgnytGa6x0d8A==
X-Proofpoint-ORIG-GUID: XePyaL9q1qP8BAJPWJ0lHB_o2lsPaeht
X-Proofpoint-GUID: XePyaL9q1qP8BAJPWJ0lHB_o2lsPaeht
X-Authority-Analysis: v=2.4 cv=VfL6/Vp9 c=1 sm=1 tr=0 ts=6980fdb5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=ByHQw8ue95Rse8izIskA:9

Hi,

This is an attempt to update sca3000 accelerometer driver to make use
of devm_ based helpers where needed. I have split it into 5 patches.

Patch 1 - some refactoring and simplification.
Patch 2 - switches request_threaded_irq() over to the devm helper
Patch 3 - Used devm_add_action_or_reset() for disabling interrupts.
(Ensured the ordering of teardown bits remain same)
Patch 4 - manage device registration with devm helper
Patch 5 - Make use of guard() in sca3000_stop_all_interrupts() function.

Thanks a lot to Jonathan for detailed review of V1.

During v1 review comments, Jonathan Cameron kindly provided some great
suggestions to improve this driver. One of them is making use of
gaurd(mutex) - autocleanup style, patch 5 does that for one function.

Yet to be addressed tasks:
1. We shouldn't be using the spi_device_id at all.
2. Modernize other fucntions to make use of autocleanup style locking
which simpifies the code and makes error paths cleaner.

I will be working on these two above tasks and will be sending a
different patches for those.

The series builds cleanly and I have performed static analysis with
smatch checker but haven't tested on actual hardware.

v1->v2 changes are documented in patches where necessary.

Thanks for your time.

Regards,
Harshit

Harshit Mogalapalli (5):
  iio: sca3000: cache SPI device ID in probe
  iio: sca3000: switch IRQ handling to devm helpers
  iio: sca3000: stop interrupts via devm_add_action_or_reset()
  iio: sca3000: manage device registration with devm helper
  iio: sca3000: use guard(mutex) to simplify return paths

 drivers/iio/accel/sca3000.c | 99 +++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 55 deletions(-)

-- 
2.47.3

