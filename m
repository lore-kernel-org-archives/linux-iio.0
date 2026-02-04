Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0894376BE5;
	Wed,  4 Feb 2026 06:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185553; cv=none; b=RB097fU2YdboUvMnbMZV13uKTv5Zs4E5wfXKZY7nOHJbz/ZNCetlJGdL3h7qqJQeihZFeooISLJYysSDrS8IqZbFAjRkGb5aiBxszRKLug+FX6cqneU6++/kgQhzmIzfJ6Am0MxaYUw/jqn6F3gWuz8c+TE0ExANbZfWb+9dtUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185553; c=relaxed/simple;
	bh=eTfpg8gH77+XrQhgAnWdkeBKwEdAceb10OV99TlL2jI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JPhZFxvEr84CwALy5MacGwWLMlqj3ix+ZgMuZ3EzNNvQ5rnbz0XxP98VP02pRiW1GYKGaAGfa1ZoRKHu5wSz4jfjlXcYWmLLaV0XToT+XGNFYZ+ixTsRk1W75tCXTKPI5NM6Hk95xTU34IVpDRo7s/I4nnuvamoTJg6etF8QyFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q8aaBFYp; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q8aaBFYp"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613IuHve4087925;
	Wed, 4 Feb 2026 06:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=3pg6Tbk/7lPY8Ed85em9edbraw53d
	OLjp3sXnDgiX+E=; b=q8aaBFYpF2qOnTyqpOZtZOf4OGKdk2N8FWM85CRiq0eIS
	boUygRcf6a2Sjnam7Hcx70HHIxg1ZHcv1/WwODeQjnrUDtuJF40JHKQ3sOJqWRND
	XDLvwrSIsig+Qz34wAUfux5n/XYdfhO8zjWqQad6ZhwKSyfyXCQZIuIhvgmUsM8Y
	V6t7PnVzHGmTWS4oAreC4/fZsYrprZ/epRXj1gAII7mD3mC9eaPFn3VSKol5tBjo
	mhxAdI/aDabNnsLB2p6Wewip6WuyCKSJIN0wVcW8KWEcbh2beYg0Qd9r7gpz/yrP
	lvTSokHUjT/6eKoB+v50i/iwi6ubQoqTrrTfZRxGQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jhb18kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 06:12:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6145gWfu018751;
	Wed, 4 Feb 2026 06:12:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186nhbp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Feb 2026 06:12:23 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 6146CNNv032959;
	Wed, 4 Feb 2026 06:12:23 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4c186nhbnd-1;
	Wed, 04 Feb 2026 06:12:22 +0000
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
Subject: [PATCH v4 next 0/6]  IIO: sca3000: devm resource management
Date: Tue,  3 Feb 2026 22:11:55 -0800
Message-ID: <20260204061219.791037-1-harshit.m.mogalapalli@oracle.com>
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
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602040043
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA0NCBTYWx0ZWRfX8FRWBlAXubO3
 3D0ooXAggRi+HZf9V1bbIO0MuqfCgNrKpDCdaAmJlLJNcA9KSlbBnbymuNfoUXhY3TjSvt9vE4c
 zM9YjGMZRaEql2i7V/BNX34Eu6rwX6CNLe9ErLv+TIF40r7opicr7LsvJ7da/AxfZWPsl13cGWt
 9siwdXrrZvnccTd6BiLRXd4GrK4yemeBAhnXbHXd1rT3e52Ev5dzjDXIIYfgJamy7tXetfkdewS
 4hxI38M6VXfbkRJ8OqhBYCVlJWAsJgK1MVe677tuhhvdZuU65FwyLESTzTG5nq/+AjJtELQD+Y3
 gHJr0sWUZssDznhgYHszuyzOi7tAq2MWS+6F15LvEDD7vD76X5qh67/le1qddzsBF94L5j3rqCN
 Mud9Gw/GEnugY7hAiWhp7qZjLpW4QS1O0io3rAi6s0VIy73qsRRI5rqMsfd55npW0r8ZdfEBxQg
 XS0s0f0BL7lsmzLJSh6dg6yYcC2tvn0+IScnywc0=
X-Proofpoint-ORIG-GUID: YBWg0179Dl49ACETpPKJaWfzVqCZX94x
X-Proofpoint-GUID: YBWg0179Dl49ACETpPKJaWfzVqCZX94x
X-Authority-Analysis: v=2.4 cv=CaYFJbrl c=1 sm=1 tr=0 ts=6982e348 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7SaLGChLczK45WM0K4gA:9 cc=ntf
 awl=host:12103

This is an attempt to update sca3000 accelerometer driver to make use
of devm_ based helpers where needed. I have split it into 6 patches.

Patch 1 - some refactoring and simplification of dev.
Patch 2 - switches request_threaded_irq() over to the devm helper
Patch 3 - make stop_all_interrupts() return void
Patch 4 - Make use of guard() in sca3000_stop_all_interrupts() function.
Patch 5 - Used devm_add_action_or_reset() for disabling interrupts.
(Ensured the ordering of teardown bits remain same)
Patch 6 - manage device registration with devm helper

Thanks to David and Jonathan for reviewing v1 and v2.

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

Thanks for your time.

Regards,
Harshit


Harshit Mogalapalli (6):
  iio: sca3000: reuse device pointer for devm helpers
  iio: sca3000: switch IRQ handling to devm helpers
  iio: sca3000: make stop_all_interrupts() return void
  iio: sca3000: use guard(mutex) to simplify return paths
  iio: sca3000: stop interrupts via devm_add_action_or_reset()
  iio: sca3000: manage device registration with devm helper

 drivers/iio/accel/sca3000.c | 88 +++++++++++++++----------------------
 1 file changed, 35 insertions(+), 53 deletions(-)

-- 
2.47.3

