Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB23A0B1D;
	Fri, 17 Apr 2026 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416274; cv=none; b=AEmDgHd1nbujzs5Pogsue/EAgrjTEsRttcAWvQZd0UYV8n4b7PEAfbGJI4wGaO9oDOwEQwtVjTZMqBqBTwV1wd5sDiCny4+/TPJo7Uo4o6iojIJnqGX4jgJ+u0xSilYKdorspUFh6NRaXPHBAvNyVw0eQF0WZz12onugyo5/9KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416274; c=relaxed/simple;
	bh=fbAp3aqHBovUzDTm4xwPW3hSnIqJnovhr4kePKGtDKo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r587rhJlr/upR0+x7s004NVI+bh04bnSgesDGIGG46zu4pBf7VnKyfMoMUc5tR0HkGI1UUUjb6UOAWI1BMgYd++cvp4m058HC3MlFwKt7aXH3ZElSwiJz/ST5YKBF3CiCUgofP2gQpNRhxNWuiiSWyuG7W27JuKYULNJKVj2LTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyapiF5A; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyapiF5A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776416273; x=1807952273;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=fbAp3aqHBovUzDTm4xwPW3hSnIqJnovhr4kePKGtDKo=;
  b=nyapiF5AXT6SwGXio3rKEdtrUxZvd1xZiBIz9qMpyzG7/DANbGTJiWfJ
   +yz1mTCuQVhvcby6fJmJoeIm30DQyyNvZdPEFud+c1eLmag3lmPNxz3do
   uqPbZSl7sKMEYAzeiVy+64uoTrvO+FQevH/jUqwTQWthDzCcET/EgIPc9
   3SNSgT/yttbShxWerbjka19Cs+3zI1tRoUir11MX7CJH34RFQckz5SX8C
   VG4Sk5sQuAO8AV+AeBkOs/s/pd0sEcuNGnSKaTO0KTGk8/T+1s+gQov4P
   MdH7RzqLEXFCtC+OhSC1qS9eRCJsXDYA5hpQL/PZuO83+kCjwbbaa+YiE
   A==;
X-CSE-ConnectionGUID: Q4fKDiseSRG8lkgAQ5M1Bg==
X-CSE-MsgGUID: sP5za14jRvaPWowou2qhAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77338369"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="77338369"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:57:52 -0700
X-CSE-ConnectionGUID: btDKY4XqTU2mKdrAHTr1Cg==
X-CSE-MsgGUID: 0HUu8PNVT9yNmJRWZlZdUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="235941672"
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:57:49 -0700
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
Subject: [PATCH v2] iio: buffer: fix warning in requesting threaded irq
Date: Sat, 18 Apr 2026 16:51:56 +0800
Message-ID: <20260418085156.121947-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260418002334.3643504-1-junxiao.chang@intel.com>
References: <20260418002334.3643504-1-junxiao.chang@intel.com>
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
RIP: 0010:__setup_irq+0x1639/0x2510
Call Trace:
request_threaded_irq+0x2c7/0x490
iio_trigger_attach_poll_func+0x353/0x6b0
__iio_update_buffers+0x2420/0x2c70
enable_store+0x183/0x270
dev_attr_store+0x5e/0x90
sysfs_kf_write+0x1e8/0x290
kernfs_fop_write_iter+0x406/0x5f0
vfs_write+0x71c/0xea0

v2: using ternary and drop temp variable

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

