Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0FB12CDA5;
	Tue, 21 Apr 2026 00:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776732998; cv=none; b=hFIak0c36qE7LtGUSNosYEn1n0BeSznlIRVNTngq2vEqv6wZ2Cx4dw8ULMi3/S0MIXV3QsqVb3MiHLEdmrkPQWznCSH/CCwE9WyijTYJ3nUuus9eEfciVP/mXyejC+nyxsJDX4M5U8xPgRFbpT4He/PqK9gOisPMZBXCtfMp8G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776732998; c=relaxed/simple;
	bh=NcZTS7Cb7FVX7/jLRhX8DFbFqTRFS+QcojMWvcSeWNk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JvXDL3Q1jllikLS/ZnvP4WOZNytYlZ1FjCrQSV9mWOqfcsaIv3kb2fI0FqY4jCOQr1i87LqJrVQU+9+wcalDbKMurU9R6jjUO8fG/iMb/bhIdoMrvkaicwUOYIb5Bm1MZhAxHeKbY3jRsKwBu6B5Rd1u7gYYr070SrzLJPDCLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5alxr/z; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5alxr/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776732997; x=1808268997;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NcZTS7Cb7FVX7/jLRhX8DFbFqTRFS+QcojMWvcSeWNk=;
  b=T5alxr/zvYbN+3A3aqzr8IV8q8wpEPRfpL9ObilBGK6lTVDtq5qRD8mj
   6hfgYlbYUdTG5OKpyQlE+v5132hP3im2h7X0btOGQYWStDufz015kDg7B
   lqMKAMvdt7Bfin+qjaWfbW6olMnFbH/i4xGLrBozawqBXz/YiRhbYJO3L
   TgIVWtNi15RGjw0nzF/L58NKzysX+3gZs7x31wGR40Xo2GwG/Wufbxbuf
   f3sP/GneGUUgq5W8LknhmBQ4pF798udkE14nUySG6PGaZeO+JEcfp/3eZ
   TsCn+BdsrK2LSCb3e6g0bvCbi+P722ZsGboKgfi9wjRhviNlMrpWotdo8
   w==;
X-CSE-ConnectionGUID: TDm9C8Z2T5az+rVH33MJUw==
X-CSE-MsgGUID: vC+IxB1YS2itYWBpCDaGSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77530530"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77530530"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:56:37 -0700
X-CSE-ConnectionGUID: XskA4MEHRS+fQJqv7AzhRQ==
X-CSE-MsgGUID: Qx3jJFnyQnuYEi0CO/iCNA==
X-ExtLoop1: 1
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 17:56:34 -0700
From: Junxiao Chang <junxiao.chang@intel.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gye976@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lars@metafoo.de,
	junxiao.chang@intel.com
Subject: [PATCH] iio: buffer: fix warning in requesting threaded irq
Date: Wed, 22 Apr 2026 08:50:38 +0800
Message-ID: <20260422005038.1600632-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IRQF_ONESHOT is for threaded IRQ. If there is no threaded IRQ
handler, this flag should not be set.

This change fixes a warning during booting with kernel v7.0-rc3.
Hardware: ARLs(Ultra 9 285) desktop
Software: Ubuntu 24.04 + v7.0-rc3 kernel.

WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x1639/0x2510, CPU#3: iio-sensor-prox/974
Call Trace:
request_threaded_irq+0x2c7/0x490
iio_trigger_attach_poll_func+0x353/0x6b0
__iio_update_buffers+0x2420/0x2c70
enable_store+0x183/0x270
dev_attr_store+0x5e/0x90

There is no threaded handler in thiggered buffer setup, e.g. vf610_adc
and hid-sensor. They might introduce this warning.

Fixes: 23f2d735a932 ("iio: Add helper function for initializing triggered buffers")
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 drivers/iio/buffer/industrialio-triggered-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index 9bf75dee7ff86..40eea3a447246 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -64,7 +64,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(h,
 						 thread,
-						 IRQF_ONESHOT,
+						 thread ? IRQF_ONESHOT : 0,
 						 indio_dev,
 						 "%s_consumer%d",
 						 indio_dev->name,
-- 
2.43.0

