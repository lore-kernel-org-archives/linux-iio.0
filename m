Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A347347C6;
	Wed, 22 Apr 2026 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776822630; cv=none; b=pAOlSR+MJ2zWUcFgvS21Ma0vGr0cLkYYkE/vmfaM74TzuvaSmQ7NyXNGXt/i8mhsNACQJrH4kC995qxSJPmsL+meDrZy4EGdmY9IVsxCG3gHgoZgdSAidBvVjsjZ8b9KVB8aS36BVsTgJOZhbL6ZJ8wbVAxInsl8wEQfhjFTxGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776822630; c=relaxed/simple;
	bh=VSzcOUeaQd1B7GHDhMkvfXl8U7N9B/d/S/r4INQUk40=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ma2BWOvFBVBqnn0C5IxGzk3aOvGszFkM5qpxWpi05RgFGZMfWD9szGWHOujAqxm0WqifclQW2zyZn2LRW7YTVAxMte+oIgAEmiSp56O8yNBu6XgBEpUiRAxrNeBoOEZ3XV0OIhu8WCm96wEHZzRFTc9/mdAP3AhC0/qJf9D7rmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRobLN+n; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRobLN+n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776822630; x=1808358630;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VSzcOUeaQd1B7GHDhMkvfXl8U7N9B/d/S/r4INQUk40=;
  b=RRobLN+nufTiBCNwnuoppqgnH94y1XTNW903QRl5fu6WTop/trSBPe2e
   +CxvxHIOEzhltzJ52NG9czvdyqMJaZaVVbFlKLA9upQuOn50VSbFH2eaH
   rz6jboREop3lavV4/oEsJV8GB0BDsImZbVmmyyHwWw9E6UqCw5mqNXOn1
   2mQQiZhyqNtePQaAk85m3lyJtep4g/BlhBjSw7kiM3Nc/qvRQIgtpwd1c
   O7cIjphqWdrD3g6jwd60w8QI+T8+DomxHPr7c60qGBIHsyslQsL0/GLM9
   htrD2RLFeLemnI0T67+Se/1xMtMuHGHp8hkSnKv7RdpkDwcGbAgY3h2A1
   w==;
X-CSE-ConnectionGUID: Vfj/YlRaTWGZUG5Lxt5pIw==
X-CSE-MsgGUID: YqrN940zQ+2fe0Gg6ArX8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77952579"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77952579"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 18:50:29 -0700
X-CSE-ConnectionGUID: LKR6sithQISOIVbMWPEFmQ==
X-CSE-MsgGUID: CtxIFV4IRXmopMHhbLimlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="227602150"
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 18:50:26 -0700
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
Subject: [PATCH v5] iio: buffer: fix warning in requesting threaded irq
Date: Thu, 23 Apr 2026 09:44:26 +0800
Message-ID: <20260423014426.1999735-1-junxiao.chang@intel.com>
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

Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
V4 -> V5: remove Fixes tag and add back change log
V3 -> V4: remove unneeded backtrace log
V2 -> V3: remove unneeded log in git message
V1 -> V2: use ternary and drop temp variable

V3/V4: https://lore.kernel.org/linux-iio/20260421103807.7ca935e9@jic23-huawei/T/#t
V2: https://lore.kernel.org/linux-iio/20260418002334.3643504-1-junxiao.chang@intel.com/T/#mc0803722dce6585bbc8c9e0ec8289bd96afe99aa
V1: https://lore.kernel.org/linux-iio/20260418002334.3643504-1-junxiao.chang@intel.com/T/#mf0eba6c23049d15c2b43ea5528b5f5a47e216c58

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

