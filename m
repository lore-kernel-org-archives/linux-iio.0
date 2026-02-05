Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511AF3A0B0E;
	Thu,  5 Feb 2026 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297165; cv=none; b=eM0bClgngUuOOP4zf8QIkJ6/wP7xlLE3OVsFiX3NPbO3JAqfzNjj7PBdNw7XIHFiGSWiAWrrctY6NX6Irk9w01uPZP7eXweh3BMlJ6bTZF9kgJUaY87X0iTmfvTHeeV2JDw7hhEXOnr8zmuC2ghcFuz/oRhcr1AlaxpglrfYEK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297165; c=relaxed/simple;
	bh=g5VpYPtgum8ebn6P5cytDltDHcfD8nUsLmDnJgR6Ir4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kI3jpNk0hpsBQk0GhOl210tIaHNPIqgN06pQEtP0oBcOS4d1Mbq6LUlglyHsCDyGafYlhFf7DSknTOGOWsjwZL7vdThRUSJNGdigsVbmNt9RfKqm63elGB1JaMEMqzqdZOhyH5aijZixZctOp3dkOTrD215WtaiWGIDbW5aR3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r41XeZpO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r41XeZpO"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614N4HBS1716188;
	Thu, 5 Feb 2026 13:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=bYyjhPgmAptEIMPi4JXQtGcScqw92
	A9WvziGGmCM++M=; b=r41XeZpOVfPrgpzdKhVVUi1SGtVgfUXDdmNToqSCug3kk
	CycNMIsLq0ihp17KIYUCdJlqY3PF77OElWgjLDk0vxVjOUz7ow6e5GF9czkpKOMB
	Dsun+n4BPFHXi2fBJsMgS/s0A1X/FfiAlQ7NaQ+gSfKrYOIL4QIZ+O1soXr2DJer
	3Vu2kbfoWwenR8QX5mGVNxAp0V3X2nwER93zCuVPkNw73ztmByX1LsXf0N0d95FG
	UwgillbvSZOQqqvXtJ9Dz25xN/rVRVvDYhmKwhH7e2gLz5YCLQWHMJy5x9Sn3uZL
	ZK8FoNmCaS22mqslIxXRZOWSMjXxYp8l42tDIW9oA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jhb3p54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:12:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615CsMMp001900;
	Thu, 5 Feb 2026 13:12:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186d55bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 13:12:37 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 615DCbDt038070;
	Thu, 5 Feb 2026 13:12:37 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4c186d55b9-1;
	Thu, 05 Feb 2026 13:12:37 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, andriy.shevchenko@intel.com
Subject: [PATCH v5 next 0/7] IIO: sca3000: devm resource management
Date: Thu,  5 Feb 2026 05:12:06 -0800
Message-ID: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2026-02-05_02,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050098
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA5OCBTYWx0ZWRfX66pWjeSOMD6R
 8ZiCKNqS4HZOjT6+pLh+X1G8UBa3rM4T/pTU19T65hrTQbwY2DqfK4cnAZXCldQUsqK0zik6WWA
 W4w6fQFEE6CjEEHu9yD3XFLrfKBWTbqK0agQrK0e4iA669AOs6XCMZr9c2xNhN/dO5Zu9QmImNp
 IZVuliOMMjyvf7PzcjpJktHC3wES46fXI31d6nyiLBq7ai64jCNQPIQfSYRYlYo92a9ITdc023C
 HFyBDf0N+8gO7ihcXE9EVY0DODJrm0j8VAsWA4HgYudnhKvdcvduYEHUkg4T6K4/G0hzVBmuas8
 folJxoosqGv0pjCOdu1SR1/YPZWQevq2mcMrb+8AUkggm/hGda39DrDZ56molq4d1P/dyV98qAJ
 cZqcxNjZ30xrNqHPSKzECrh8UOgROgLnYi4nw4kr8MSBISKjvHOx8PUhrgYvaNS5oEP3PpDZHtc
 d3qkN+b3HQQhdnoJXBA==
X-Proofpoint-ORIG-GUID: 0xNG8gt5-SH9raVHY06KoAjbOuBuAC7m
X-Proofpoint-GUID: 0xNG8gt5-SH9raVHY06KoAjbOuBuAC7m
X-Authority-Analysis: v=2.4 cv=CaYFJbrl c=1 sm=1 tr=0 ts=69849746 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=1D1gIlUcNSU6DadnfT0A:9

This is an attempt to update sca3000 accelerometer driver to make use
of devm_ based helpers where needed. I have split it into 6 patches.

Patch 1 - some refactoring and simplification of dev.
Patch 2 - switches request_threaded_irq() over to the devm helper
{atch 3 - Move stop_all_interrupts() above probe
Patch 4 - make stop_all_interrupts() return void
Patch 5 - Make use of guard() in sca3000_stop_all_interrupts() function.
Patch 6 - Used devm_add_action_or_reset() for disabling interrupts.
(Ensured the ordering of teardown bits remain same)
Patch 7 - manage device registration with devm helper

Yet to be addressed tasks: (Would like to take this up as a separate
activity)
1. We shouldn't be using the spi_device_id at all. [Thanks to onathan
and David]
2. Modernize other functions to make use of autocleanup style locking
which simpifies the code and makes error paths cleaner.

I will be working on these two above tasks and will be sending a
different patches for those.

The series builds cleanly and I have performed static analysis with
smatch checker but haven't tested on actual hardware.

v1 -> v2: changes are documented in patches where necessary.
v2 -> v3: Address comments from David Lechner.
v3 -> v4: Address comments from Andy.
v4 -> v5: Rebase the patches based on suggestions from Andy which
simplifies the patches.

Thanks for your time.
Regards,
Harshit

Harshit Mogalapalli (7):
  iio: sca3000: reuse device pointer for devm helpers
  iio: sca3000: switch IRQ handling to devm helpers
  iio: sca3000: Move sca3000_stop_all_interrupts() above sca3000_probe()
  iio: sca3000: make stop_all_interrupts() return void
  iio: sca3000: use guard(mutex) to simplify return paths
  iio: sca3000: stop interrupts via devm_add_action_or_reset()
  iio: sca3000: manage device registration with devm helper

 drivers/iio/accel/sca3000.c | 87 +++++++++++++++----------------------
 1 file changed, 34 insertions(+), 53 deletions(-)

-- 
2.47.3

