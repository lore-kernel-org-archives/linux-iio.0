Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F9E26FA5B;
	Tue, 17 Feb 2026 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315521; cv=none; b=O52/uGBW9QpOel6ebj9GhtYKNKKK48b+B6RAXOD0soAH2B5VLn9ZIexJFr8c2VS1pPXk4EDpTXEBnObPjhHJTOX1IGO6rPHSoIACOkZob4bCui9JU2/PU0oZDGinzkVNcQ9MEkD+S5xt8piRxV/yJTgUdC7bMYHNxNDnYRIErHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315521; c=relaxed/simple;
	bh=HZYglLDL0lMK4wCaYUTSaYqepcpecMW3fm5yM1/Ihkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WLtPll/2G9CvJ0xt3G4wF0vsr0tboQJsLUom6DAU+D2WcryZ+nEW5UdKkDmNvkXivy0T6/Md2GkNhog7Ddrn7ek5jCr6yo9mOIjPBrH/DT6/KQkTh/Q+ifZkzFM+xHJgXPmJKRDUT9ZCI5r9IOxAkGEiOoJ/7cA7giyoz9xMOek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdmTwgFp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdmTwgFp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771315521; x=1802851521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HZYglLDL0lMK4wCaYUTSaYqepcpecMW3fm5yM1/Ihkw=;
  b=jdmTwgFpc58KgFGPRSKVDK0pBFCgHBl3FPhcDok/Gk3wi0pg/dbTsb0F
   tzBsa0d7B4OTHfPSxm8YbuZuDrupXfFnYnJNPRcjYNlJHImCmQPWC9RKB
   hh13OXfxqngwgtBwmDSOvufMv+tF90XwKJWUx4d113HIXzLv/Z4QwEeHY
   gWaUp4IpsjwQDft4/TZ4Jbh09nyNmZlHTRypCDATMZSwvKhAQURMQVU4p
   8eFS7Gs6EiJBCvc1bgeE0X9sKGvE578+0hx+ZXSarm27xR97wGZfFS4Vh
   /SVACec0HTShpkaKqbo1G6GdBSojB7OspupkQEyxWgcPAGeG8ZWZYYeHd
   A==;
X-CSE-ConnectionGUID: Qq3WQcljTTmC2mCKvaLxXg==
X-CSE-MsgGUID: PMXXkXB5QzaLBlIT933aAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83480527"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="83480527"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 00:05:20 -0800
X-CSE-ConnectionGUID: 7xlTmhuwSKK9OX9wA6UbGQ==
X-CSE-MsgGUID: VdTpCjC7TQK6s4x3l+CaHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="213055990"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 17 Feb 2026 00:05:17 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id A9E0795; Tue, 17 Feb 2026 09:05:15 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH v1 1/1] iio: adc: ad7192: Revert "properly check spi_get_device_match_data()"
Date: Tue, 17 Feb 2026 09:05:14 +0100
Message-ID: <20260217080514.1288115-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit b7f99fa1b64af2f696b13cec581cb4cd7d3982b8.

The added code is currently a dead code. Moreover, the driver is not
designed to have any defaults effectively making driver data a mandatory
information to work with. Taking all together, revert unneeded change.

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ad7192.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 530e1d307860..8b1664f6b102 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1402,9 +1402,6 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
 
 	st->chip_info = spi_get_device_match_data(spi);
-	if (!st->chip_info)
-		return -ENODEV;
-
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = st->chip_info->info;
-- 
2.50.1

