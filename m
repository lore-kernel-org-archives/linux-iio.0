Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA673D9DC3;
	Mon, 27 Apr 2026 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315913; cv=none; b=c3lEzhrxiYi5/1LjkY8vfcrHV6H9haMMKfzq+4AbrzzJql2hyJUTy14t3uLykAaBvVI7qFEyvEB7R2Xe64cDsJFA9TCIEsbNn5PviXqsLamIh6jxD2FwB9n1DXvBN5AelV+kqKvHAYFOhg+zoN4GTNugC3lnfTphi/78eLuMTsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315913; c=relaxed/simple;
	bh=QPpQ0V26QSTKv9uHyiwOxakgB2Dbn/ub7G+urt7bHuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R9XIIgD1OHjPB7MkdzhmDp9q5r1NkckRvp4L0/P6CCBhqoUABwAic2LLjJ42Gg1l//dEWB12EUUQq+g964NYd3G7c6Z0Qx1kgr7yrBwFaJLJOtOWoBUo/lPRNXMgACDieq+Un3gymMGen6UMvacnCC19ZDLEjTLkI1Q4Vz1opY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dv5ISk76; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dv5ISk76"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777315912; x=1808851912;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QPpQ0V26QSTKv9uHyiwOxakgB2Dbn/ub7G+urt7bHuw=;
  b=Dv5ISk76gORZaE4YQe75TPvz+ss89Obz/4Z4+mSeemlVYKNs4w0RiAsr
   I1yf1Yxz3dy4BTkC/Zk4FumfNanG7EzupiRY52wvEOGO9TTZTW6RxXVAC
   kKyBBPBZJ3JbYRxpIFo6YiAz5AdqUkOCx4/lyNrOxbALfm8O5rBpnmMsn
   JBlxb5NWqM85NMHuYIgr/JUeZt6M262SKCDZIsDsfyfIZds2T6ly894vY
   qBMDkiHfExkWkgvItofmxoUvZeqc6UoeIewc8QNP8mN3QC5XrxtZl3Uk4
   LG7shdo4g4I0TaLWrgclfdQOCIYznGkOeN0d7IAvWMZNekAdyr/LdmvVx
   w==;
X-CSE-ConnectionGUID: iu35g/yOR/qRX6q59Mn2YQ==
X-CSE-MsgGUID: 8nA5wzQySruvHnXZLIv3pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82065118"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="82065118"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:51:51 -0700
X-CSE-ConnectionGUID: guT3dcw6Toqib5omZ+bYCg==
X-CSE-MsgGUID: b3FldYJdR9eSZumFXAUdHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="227200054"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 27 Apr 2026 11:51:49 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3234095; Mon, 27 Apr 2026 20:51:48 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: buffer: Move from int64_t to s64 for timestamp
Date: Mon, 27 Apr 2026 20:51:47 +0200
Message-ID: <20260427185147.3016331-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_push_to_buffers_with_ts_unaligned() uses int64_t for timestamp.
Move it from int64_t to s64 to make consistent with:
- iio_push_to_buffers_with_ts()
- all current users that supply s64 anyway

This will reduce potential of wrong type being chosen when using
this API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 include/linux/iio/buffer.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 46f36a6ed271..6d92295422be 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2422,7 +2422,7 @@ EXPORT_SYMBOL_GPL(iio_push_to_buffers);
 int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
 					  const void *data,
 					  size_t data_sz,
-					  int64_t timestamp)
+					  s64 timestamp)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index d37f82678f71..e0344d51b4f9 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -71,7 +71,7 @@ static inline int iio_push_to_buffers_with_ts(struct iio_dev *indio_dev,
 
 int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
 					  const void *data, size_t data_sz,
-					  int64_t timestamp);
+					  s64 timestamp);
 
 bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
 				   const unsigned long *mask);
-- 
2.50.1

