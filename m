Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA591C28E;
	Mon, 20 Apr 2026 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776650331; cv=none; b=bPg3gwTx0ZPUplD5dgo/bKd/UQsdPULv+WHCcEbkvfP47lL1ZYwRiE6fXScFrcr6xDf59+wRt1E7ImCYQ/nZUG+15sVd+7vUOTOZS+of3768AAM3KHedBF7MNh8AGSSia88pezb2nBqMlMZDqDr6gkkO8pmiJYGHPds+0VvKbus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776650331; c=relaxed/simple;
	bh=1OAv1qHwn1+12iuqL4ooZC8TIeubR/WmsIzn0acNPmI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dCRL2Ou85YnrL8Jb27QhJyJiAGoHatA+5vYgJKZfzpCNCfw3zv6wUlrTvVu4BTg4zQSLps4SbvyBdKcLCHzyuiBPfiSulkSs6X1mMA6ptYXbOpZr+iYjrO7NsPnehHEroP/UpEthMppBf6QjnXdD8beZM2+nE2GVnWrLG6iTEqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ni7l7iOY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ni7l7iOY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776650330; x=1808186330;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1OAv1qHwn1+12iuqL4ooZC8TIeubR/WmsIzn0acNPmI=;
  b=ni7l7iOYow5k6T1XJrk2pg2anBjxGADdJ8xMt93lOlaSCk6XwkzRIurT
   rIdBkT2WR7Hnfsnqrp85LvNgoJbPXAE+CwtTUv9qpAOoRFZnkO1IixM0c
   20RA8LAWXrA2kxgqdjkdhTXzKOV57u8uBTfn6XH41Q52CfbVbHeEXYxN2
   B1Cs2GlG1kXDEzZLh57ZceO2cBdSwg7f8NjNtQv6P1KCDFEJMQoiYF3YH
   Tr35GzJB/YiLlO5BHqtdc2/ziSSOJlRghRsuJJHy3/zXhGKURUqt9f17x
   Tu7Oi+RWl50mtZGQN8+97+ebbamZ1R1nsuxWR/cP6MyXOoLouqPvtrug+
   A==;
X-CSE-ConnectionGUID: bOrJOCkOSCCXxGrg5HObjA==
X-CSE-MsgGUID: CleBskstRleOSuw9dfn14Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77431254"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="77431254"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 18:58:49 -0700
X-CSE-ConnectionGUID: OgrV/iSQQTuCOjof/WmakA==
X-CSE-MsgGUID: oh9yUxKKROinVL5j46kUlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="228435227"
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2026 18:58:47 -0700
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
Date: Tue, 21 Apr 2026 09:52:52 +0800
Message-ID: <20260421015252.621393-1-junxiao.chang@intel.com>
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

This change fixes a warning during booting with kernel v7.0-rc3:

WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x1639/0x2510, CPU#3: iio-sensor-prox/974
Call Trace:
request_threaded_irq+0x2c7/0x490
iio_trigger_attach_poll_func+0x353/0x6b0
__iio_update_buffers+0x2420/0x2c70
enable_store+0x183/0x270
dev_attr_store+0x5e/0x90
sysfs_kf_write+0x1e8/0x290
kernfs_fop_write_iter+0x406/0x5f0
vfs_write+0x71c/0xea0

v3: remove unneeded log in git message
v2: use ternary and drop temp variable

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

