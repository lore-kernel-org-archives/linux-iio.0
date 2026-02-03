Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060F333D6DA;
	Tue,  3 Feb 2026 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121283; cv=none; b=g+g4zBcFIvgplxM9eUDNUhLWw9sxZQPgxDvVwGLbyu7yN4E4+u4WpDawFwe/FzGY1cUtz9RADOrToEpGd18aOZxsTYrk0gA8XgNKgxhI2a6cz0SubeWp24juuhEaCYBfdBd4E30BHDifNo7Z2EFk2Dsraa+N0EEjZ2dLX7tb8J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121283; c=relaxed/simple;
	bh=DB1u/62FbCO3Hb6reNHtRavEQzIeLBfd4+7S7wcap6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QkerEaGvo0NVN3AYwQuzmFn/+K1kDnl7XLynKRFIRag+VMY5A2K579W9qWfvRqkbuyAcG1/Yh0b0r9w1pH81eJtwMSQNJqfAWUUmLGVIvQ9ID63jlfUB9htFL/+LvrBkJVH9A11dDF5irIr37zaPY3NUAP4gJAkXacSACIf0pjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yw6uRy3x; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yw6uRy3x"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6138vZN6406954;
	Tue, 3 Feb 2026 12:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=C9fqdO+SZnxYtx44ANq/xwCFWlgiz
	aYH7nWl0yJvwbw=; b=Yw6uRy3xli1gTL1mCph0lgih2N2abmDSr1e6K+/llNzLk
	MruiOvjB7IqhMm1gc3pGim+hRxvZic1/CFNpHkiHt7YfqiOTT2Rs19Y8+mFqXw7D
	1W/G82NUxEL+EsYQqiIwUli9jVkPNj0MDUiu1tfZzPRBOxyid3RTMLRKRNWTTx48
	1Pu+njt2/cCkXmuHu4wVOkJlBJA2yyfVadK4wXq2Cgz1xAw5R1cmEtq8uHmyKuPZ
	tzgw9waXEPqD3lBugNBZjbYFUjWj3jKC1N4rv8080dEeXX6oyc2o7GqK98Yv/Z5F
	XpZzVSKj62mbTodXf508wkIDA1YzCq0r1VQ8OGjrA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1atmbysa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:21:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 613BYAlJ025723;
	Tue, 3 Feb 2026 12:21:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c2578c726-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Feb 2026 12:21:13 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 613CLCVF024167;
	Tue, 3 Feb 2026 12:21:12 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c2578c70s-1;
	Tue, 03 Feb 2026 12:21:12 +0000
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
Subject: [PATCH v3 next 0/6] IIO: sca3000: devm resource management
Date: Tue,  3 Feb 2026 04:20:44 -0800
Message-ID: <20260203122109.689669-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602030098
X-Proofpoint-ORIG-GUID: hobA-u8ySEsFM4SuprHRtd8DVqnvUSg1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5NyBTYWx0ZWRfX5TEABc9+e1Ip
 lhIvGZHZODuo9qvpu14TK87jqOhBzWYUBJa5xk7dpwn23MV5Qdgd9UV5x/O34aTLgi7hdPvbZiP
 3XFUmx2quWhyfWiL/w3R8o9ui5ep5z8sNCCMUT6VC3rz2WXry1awu8u+dxKcP/p/PWlpEwcLQhR
 s6q4BtJHWQT2RSPkyVmd/PJMYxNbEC6rO+SJlMfzfWb3/RmMSOBrTwd1EnhYOixhtPFeta3iqlo
 dAr2s0FGxxe879LlNNtmUHqmyv74PkQomgbZQbXRBs0Db3toIVdalaSAxrFhTJ4LIxQsHqItvmA
 MCbqzPe8rDS2REYzVIh9OKKqfUMa7NUIAw33hIjOMGFY0jI9pDt78rezBR5y9JalulYzSjnmtkC
 i+QhMaoUYygECP/qVNSchWZ7w77KjQmfIepwfk4H/jkBI8+nzC1NQPkwGElGvnyZJrF0zaB9jLS
 LPGwIqLQaqoSLDR1910JCrG2WjKP23DognJTm418=
X-Proofpoint-GUID: hobA-u8ySEsFM4SuprHRtd8DVqnvUSg1
X-Authority-Analysis: v=2.4 cv=E+nAZKdl c=1 sm=1 tr=0 ts=6981e839 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=1a6Wuy4FIUBxDDj1cqgA:9 cc=ntf
 awl=host:13644

Hi,

This is an attempt to update sca3000 accelerometer driver to make use
of devm_ based helpers where needed. I have split it into 6 patches.

Patch 1 - some refactoring and simplification of spi_device.
Patch 2 - some refactoring and simplification of dev.
Patch 2 - switches request_threaded_irq() over to the devm helper
Patch 3 - Used devm_add_action_or_reset() for disabling interrupts.
(Ensured the ordering of teardown bits remain same)
Patch 4 - manage device registration with devm helper
Patch 5 - Make use of guard() in sca3000_stop_all_interrupts() function.

Thanks to David and Jonathan for reviewing v1 and v2.

Yet to be addressed tasks:
1. We shouldn't be using the spi_device_id at all. [Thanks to onathan
and David]
2. Modernize other fucntions to make use of autocleanup style locking
which simpifies the code and makes error paths cleaner.

I will be working on these two above tasks and will be sending a
different patches for those.

The series builds cleanly and I have performed static analysis with
smatch checker but haven't tested on actual hardware.

v1 -> v2: changes are documented in patches where necessary.
v2 -> v3: Address comments from David Lechner.

Thanks for your time.

Regards,
Harshit

Harshit Mogalapalli (6):
  iio: sca3000: cache SPI device ID in probe
  iio: sca3000: reuse device pointer for devm helpers
  iio: sca3000: switch IRQ handling to devm helpers
  iio: sca3000: stop interrupts via devm_add_action_or_reset()
  iio: sca3000: manage device registration with devm helper
  iio: sca3000: use guard(mutex) to simplify return paths

 drivers/iio/accel/sca3000.c | 91 +++++++++++++++----------------------
 1 file changed, 36 insertions(+), 55 deletions(-)

-- 
2.47.3

