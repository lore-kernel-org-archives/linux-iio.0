Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910341;
	b=CRqzRyVmv4JmhIaZRsStPj1DZOm0uZL9gwI+l60Z9yD5Jc1n7fuEdm01VbJVnM93+llf
	 lbUtv24EN4IRu2VoTddEEKjSfRtmpbv3Ul2SKlGtra3Senph1U+1UyKcWLOf4YKqyB0S1
	 p/D0I7CQVWsYrsc+htDzojVDaDdYUBqUW6tyt/K12bPgYcVFqpweiR3o2IcKDuSNWAdu9
	 4TRZEEcHArtwNqLgVQyd4N0gVGdpYq80SSmuqbmG+3OqHBiJWydkGZFj+vnI98MsqyQrZ
	 lAWpVUT4kJ5r03gymkHnSdjLD2B6RzFbvcV7seWTu1gtZ3hOmVwvETwDPAeW7BbmOCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910341;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TPBqw6R12FU3nw8EgY2HDURUEtbzCSZfVal7HlkpVXU=;
	b=llv3232wnrlafdufifHumEDEyXAOxfbTA4ML0ym99i/q5XGQjElWo9p7IHbSlESSkwpz
	 EfFWsHerXztClf0bn+R+rz8ku0hUr5mwrDCgKYmYNqw6P4+ZxvZ3qmTWV4+qhUh2oO7z9
	 34X9uSQSSktLSo6q64n10cw47SDLBbGBFYDil9UJmgxKGB8SGMyVjE1ikur4Q91J7Cj8B
	 TAtXEaKHyTQwsoxg98vhPHy3IRy1TQIrBfcuisynToDbl/ygQOSzIMERxUuIUY0Gg+t7B
	 99sdMZTP1xRq4Eg8L5HfbcwcRh20TDMTTUXEl8L/nr+fLrSfCG9hbkAnN2cGaacTGMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="L/x/k6KE";
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1AE606A889
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 10:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC1AE606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L/x/k6KE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794910341; x=1826446341;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IRJ4vkIfN0VOBbV2J2t72U46gMPi4o1z/qnn9iXiXd4=;
  b=L/x/k6KEpJ4Z/sPiCYmuyj6ly2oTCBnZ0L0mMDDBgZA7tvF7moXbXLCR
   g3E3bb4bAGv6WYDvHKEClwm5iW0QbFb5dFb91RQabY3MwHcu2anNJpgFx
   lKIU6Z0V4uEyrQlFe8bQidBOycGtgrDWONrDLfddE4XM+VIZ5SPMZm8Mk
   kg2gEHaq/GL6fhTcwCd3qyu8WwgYO3xnyIBgPs4eEfu+KhZs2PSGBFF1e
   tO6K6FHz11noYKrvea0Lg27b+hHBe2AyTiE0itC7djlqxLDuogMOSZCke
   +QuFE6sx4459knMVadu2KoQzfGVDlrKQopVPLADWxMooh95OSlLIMDqPi
   A==;
X-CSE-ConnectionGUID: nfWTQmjNTMmT5MrBAYQmwA==
X-CSE-MsgGUID: zzpMaEkQT1Oe0RF0QWBeYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3570036"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3570036"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 02:12:21 -0800
X-CSE-ConnectionGUID: vcGPzK3+SD2VjtflPP+3Hw==
X-CSE-MsgGUID: YEO9uxwmS7epEac4XUN7MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9734937"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 17 Nov 2026 02:12:19 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D286B99; Tue, 17 Nov 2026 11:12:17 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org
Cc: Peter Rosin <peda@lysator.liu.se>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/1] iio: afe: rescale: Don't use ULL(1) << x instead of BIT(x)
Date: Tue, 17 Nov 2026 11:12:16 +0100
Message-ID: <20261117101216.1486231-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ULL(1) << x is just an open-coded implementation of BIT_ULL().
Replace the former by the latter.

Note, the rest of the code properly uses BIT()/BIT_ULL() already.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/afe/iio-rescale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index b3cc610b48b8..25e179a3706b 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -67,7 +67,7 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		if (scale_type == IIO_VAL_FRACTIONAL)
 			tmp = *val2;
 		else
-			tmp = ULL(1) << *val2;
+			tmp = BIT_ULL(*val2);
 
 		rem2 = *val % (int)tmp;
 		*val = *val / (int)tmp;
-- 
2.50.1

