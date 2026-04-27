Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F146933065C;
	Mon, 27 Apr 2026 20:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320863; cv=none; b=ml1gpGLpMK+cyoWYujFaFJRKHzkNcC1uyuItli5Yv1wsH+IZKk3A9KKRgbjd3jItAHScKdwGtb1UpzzNAwZPhgkPfSjbC8r5aAM4aT2NkXdkVq3hKfjHOB2AyaziuekF6qJPW5OTOO48fpnDm8PRSEOFXke234sQVaS7fW7Bojo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320863; c=relaxed/simple;
	bh=31R9TqwUgVnTkMr0J/zYyrjoyWfrAgH+0+7NBskmXnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dbuvnbdqHvYU44cmCi9zexeGFgMXlCEo4Yl5iS0ij6oGOVxdB1nHilAko7j7ByPCyqo7NRYUjMtUYVnGKtGfg8y5buB2saonn2j9QThElcyvCnGtcGvNTIG/kGEx0FE2KT4PTSeIIqj9ad5kXFCqtYKQaObvuZ1tyi1CEE6+yS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJF6qsON; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJF6qsON"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777320861; x=1808856861;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=31R9TqwUgVnTkMr0J/zYyrjoyWfrAgH+0+7NBskmXnA=;
  b=UJF6qsONM23L6arh8gBsu5Ylf1nXV0y5O4A/AVM+OuYqZnwn9qdMW7z2
   n6dJWXfiYNXVvHeOS8IxJT3qltS8KpkDcspfc5ZQRlAhB8IIYtzGC+uoZ
   jO/2yN/Q5HtQgTIUphTNyuzM6WXVkdF++PVz/BARDgUk7BMFzZjZGieTd
   bAGwn7NXrupK91QQXaTO2GtxzPEz0El+gqYCgLb/O+bEVN8dg3DkBbGnw
   f93IP/QSjbcwMu8FYHPMmuJb0VToB0O6H7+tc7CTyRRt+QUBe3d/Q4ks2
   +7tVi+WwwWgXnwwbQcUL6ZRXRFEkIuvfJuKVDabK7M3SfxwsT1WDVvmMQ
   g==;
X-CSE-ConnectionGUID: Sbsqshc2QrqQ7lWxUa7ISg==
X-CSE-MsgGUID: CZH8MKwTRy6+rLHl6q3q/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78138349"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78138349"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:14:20 -0700
X-CSE-ConnectionGUID: jLlRUIezTFyCnnRfSyN+EQ==
X-CSE-MsgGUID: xKDh3pX4TpqWWJnC+6jnVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="238074766"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 27 Apr 2026 13:14:18 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 48B0895; Mon, 27 Apr 2026 22:14:17 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v0 00/14] iio: magnetometer: ak8975: Additional changes to the driver
Date: Mon, 27 Apr 2026 22:09:45 +0200
Message-ID: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is an attempt to make the driver less a rabbit hole.
It's a continuation of what Joshua Crofts started doing. Hence
it is based on his work and first three "patches" here are supposed
to be folded to his series accordingly.

I have compile-tested them, but I haven't done full double check of
the correctness from functional point of view. Joshua, please do that
before incorporating into your series. Yes, my patches are assumed to
become the part of Joshua's whatever next version of the series, that's
why mine is marked as v0.

Should not be taken directly by the maintainers, but any comments, review
are highly appreciated.

Andy Shevchenko (14):
  drivers/iio/magnetometer/ak8975.c: fixup for the IWYU change
  drivers/iio/magnetometer/ak8975.c: fixup for the errno fix
  drivers/iio/magnetometer/ak8975.c: fixup for the iopoll.h conversion
  iio: magnetometer: ak8975: Inline timeout constants
  iio: magnetometer: ak8975: Avoid using temporary variable
  iio: magnetometer: ak8975: Drop duplicate NULL check
  iio: magnetometer: ak8975: remove duplicate error message
  iio: magnetometer: ak8975: Reduce usage of magic lengths of the buffer
  iio: magnetometer: ak8975: Unify return code variable name
  iio: magnetometer: ak8975: switch to using managed resources
  iio: magnetometer: ak8975: Consistently use 'data' parameter
  iio: magnetometer: ak8975: Unify messages with help of dev_err_probe()
  iio: magnetometer: ak8975: Use temporary variable for struct device
  iio: magnetometer: ak8975: Make use of the macros from bits.h

 drivers/iio/magnetometer/ak8975.c | 253 +++++++++++++-----------------
 1 file changed, 112 insertions(+), 141 deletions(-)

-- 
2.50.1

