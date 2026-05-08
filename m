Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE1377579;
	Fri,  8 May 2026 06:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220627; cv=none; b=blipKMtaS0wpDB2jsyxn4MWM4G24xUOE7TjuBYLdYbMcrUuS/21l+j3UXmnk4P0sZD0qRPZQRTmr0sAC1sZvLi63jRP1u7HPWUd8YqwRQOrCCaqEkszs8URJFhVstd9dhEr4ACwShQnWuJ7SnTblpxfKCdnHPJM9leVuXU0+ytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220627; c=relaxed/simple;
	bh=5pqj1WIghnR1R3C025rh4ZztFhyLfaFUTqE2ln9wWHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hk2yfPrtl0JWX2Sq5w+qfmORmO05+peI2MRdBbv07ifArcYEDNlU4/wBoLTQp3OwNpDS6Zwn2/2tc9m7dPitNpdPBdgTnUJ9Qmll+lNEw4LzCYITaVBFXYTSEfi/vdfG67aGKghyQZIdf7nP4NVVzg0sGi7BUuV3NA4tXZQqpR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iE6bBXjd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iE6bBXjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778220623; x=1809756623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5pqj1WIghnR1R3C025rh4ZztFhyLfaFUTqE2ln9wWHA=;
  b=iE6bBXjd/+c75+7v/90h7Ve6geJGHtQSVGcFLPimC1DrsUDpRsKw7Gky
   A/+mEHfCumJpjPw8QiH4x4t9W76w3Y1Y+xfZ9hskqRQ0b2HNa5s3YLqgq
   BwV9egcAC42wifnE/gbwe+GFZwiScvuAWhyyJHJumkF0MtF6J+KXEhI9m
   vXatRJkK/Nb6TBcNV9INWLf0rP3hv1PdfNirBlf/HmFGJeaBa8LIkT6+5
   fFmFygtbaa8vLgSHhQTdo6maivQIumS5iUf8wkAqkFXLA3ZA3nlbQ0w3M
   pFmQqrPVrMUZfynte2CJAiekeiO+e3gP8cGDiVPB69yFE6no8hI0WVGDJ
   w==;
X-CSE-ConnectionGUID: kUPkjqXdRDSnKLGlcT9o2g==
X-CSE-MsgGUID: vbPb7viXQqOtsdcMWnrhvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="83031378"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="83031378"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 23:10:05 -0700
X-CSE-ConnectionGUID: ys8JQPBoQOCbt/QTuccuZA==
X-CSE-MsgGUID: HS4NQ0K8S/SY+YBjWgt6yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="240669070"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 07 May 2026 23:10:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 916BE9D; Fri, 08 May 2026 08:10:02 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] iio: magnetometer: yamaha-yas530: replace usleep_range() with fsleep()
Date: Fri,  8 May 2026 08:08:35 +0200
Message-ID: <20260508060958.1086818-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260508060958.1086818-1-andriy.shevchenko@linux.intel.com>
References: <20260508060958.1086818-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace usleep_range() with fsleep() to allow the kernel
to select the most appropriate delay mechanism based on duration.
Using USEC_PER_MSEC makes the unit conversion explicit.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index d6efa8a595b0..75ff2ba0c23f 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -1317,7 +1317,7 @@ static int yas537_power_on(struct yas5xx *yas5xx)
 		return ret;
 
 	/* Wait until the coil has ramped up */
-	usleep_range(YAS537_MAG_RCOIL_TIME_US, YAS537_MAG_RCOIL_TIME_US + 100);
+	fsleep(YAS537_MAG_RCOIL_TIME_US);
 
 	return 0;
 }
@@ -1426,7 +1426,7 @@ static int yas5xx_probe(struct i2c_client *i2c)
 		return dev_err_probe(dev, ret, "cannot enable regulators\n");
 
 	/* See comment in runtime resume callback */
-	usleep_range(31000, 40000);
+	fsleep(31 * USEC_PER_MSEC);
 
 	/* This will take the device out of reset if need be */
 	yas5xx->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
@@ -1565,7 +1565,7 @@ static int yas5xx_runtime_resume(struct device *dev)
 	 * for all voltages to settle. The YAS532 is 10ms then 4ms for the
 	 * I2C to come online. Let's keep it safe and put this at 31ms.
 	 */
-	usleep_range(31000, 40000);
+	fsleep(31 * USEC_PER_MSEC);
 	gpiod_set_value_cansleep(yas5xx->reset, 0);
 
 	ret = ci->power_on(yas5xx);
-- 
2.50.1

