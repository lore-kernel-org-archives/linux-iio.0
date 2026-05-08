Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B2369985;
	Fri,  8 May 2026 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220614; cv=none; b=KFjpbh9p1xxUeOkqao5Hhl3G6i/r32B/hIX3YDP0jFBacPiwFyWl5JngM2SgyFozt/WqUlo+oIyHY6GlBOj7nNdV9e0GXlzedhyTR10p5kroBAPBFZkFNB1QlaMrpj480ATy13jnfLLkClG+iv1pCqbaOXtR9jA0K24u7vUuPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220614; c=relaxed/simple;
	bh=Z6Gi+N1rGF1ohqrOrdciuA21enKoBkxAgwu3HVDHaYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S07DoalNszxYZ7pHr/yQr9w9sFEZqqbSD4KEpn/Fwq1bNtcBPwITCvaLcSYxcqtaXp0RTUoXiQAvlbzCAqo++CTLSaOVMB0dfZ8AtdO6jseWr2ILxUFy28Vx+kyq6xs4jn+Qe1tjll1wpis2gM1+9rvY1dIMVeugMcsG32bbmoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2NKDIwa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2NKDIwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778220608; x=1809756608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z6Gi+N1rGF1ohqrOrdciuA21enKoBkxAgwu3HVDHaYw=;
  b=Q2NKDIwajz0RoYBvkB46C2oiS49ztYlMHwbq9AUxPD7l0BBe2AtW3QGS
   hk7oHvoEzAJz8Mtue6xa0FRTJxEcVM+dCAyOb8kx8gCj07sK+ji/NvhsU
   /hbPo7W6mf4APrMPKHReuYQvT5GFQNeHVIcCQwXjV8R2i+WIiGsSrakFG
   DEcciWcJpn4DDLBb9mcD354AFRUWxJMWRko5RDjA01/Pr/3xSzsg34EYz
   ZuMruyZkvbnuid2gh8+rj5LWjVs+uMTjvzW1A0t8zX9bhT1iWzlxYC58M
   dSdtzvvG34QZu5RKzBo9RwUIDPpnQcU60CNbXG+qu0wRYQ0hCFxBrEu9y
   w==;
X-CSE-ConnectionGUID: 6lxA+LPeSEqFMN+usoCTfw==
X-CSE-MsgGUID: 83yQRFHrTu6sn8+BbAAV0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="83031360"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="83031360"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 23:10:02 -0700
X-CSE-ConnectionGUID: NEnnDIXfQ72qKg52aeU1nA==
X-CSE-MsgGUID: wBIRztFBS3GCTm4OaRVirQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="240669023"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 07 May 2026 23:10:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id C768898; Fri, 08 May 2026 08:09:59 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/3] iio: magnetometer: yamaha-yas530: Ad-hoc cleanups
Date: Fri,  8 May 2026 08:08:32 +0200
Message-ID: <20260508060958.1086818-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some small cleanups against yamaha-yas530 driver. I wanted to produce more
but have had no time so far, hence just this mini-series.

Andy Shevchenko (3):
  iio: magnetometer: yamaha-yas530: Get rid of
    i2c_client_get_device_id()
  iio: magnetometer: yamaha-yas530: Use devm_mutex_init() for mutex
    initialization
  iio: magnetometer: yamaha-yas530: replace usleep_range() with fsleep()

 drivers/iio/magnetometer/yamaha-yas530.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

-- 
2.50.1

