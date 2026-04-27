Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6035E372EF6;
	Mon, 27 Apr 2026 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320870; cv=none; b=NdfpjdhP6Y0grtC3tXWdGzzcaUZ3LVySO59dgD3ZlOwY9GRhAU1O5U+aG2+oJWexW5nEV+utkuovOxlTd4ycx9IJyZTxIPM3Wl3R1itLGsAuHo2NB67ImlBMwrSMh/YE1EPJfVOpKoJZVC7DtRqzAVcyXzHpkbKhxfZYDnoSgg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320870; c=relaxed/simple;
	bh=CVRZYCazG89I7PuoYcnKfEFYQtBs0D+MXygDnumjph4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TA0YDesJ3B7MqkJR6AY2uGMWkfemtqWxZbcQ24m9yphBvp4Pw/81AhRr/QFVAUMA6Sw4Q97p/KJoSicnaGm+Q7IKOW18HBHcCDSEkRdkwDD6vW//Xr34JJKYx/oUOgoaCSLgqyTK1u+AuQyYBtJ5ylXqydF8LC7HE5gqGV9zLvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y74C4vO5; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y74C4vO5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777320869; x=1808856869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CVRZYCazG89I7PuoYcnKfEFYQtBs0D+MXygDnumjph4=;
  b=Y74C4vO577tihhD71G+3aMiojXvf4YqQkpDsotLmV8nXvIuR69MSSFjg
   R/HKjP0awUixAUiua5O+cY/J8uQPg3k7x5dP6g0trAyWDPfWIb4PmFpOw
   34xZUtx39oVqyw5Ts0JHaYa2rbwMSbEJo884N+5qgnv61vIyzo9JChAgc
   y1C/Uu+KHjaq0khYt3D32o1qSlM8Ll+RYAMVIXAw7en2FBrBdEhjItXmA
   OBL7qYccCDo3DBt0NWfB7zG/eQN1SY7oxATakqwBrMGBsbPVh8OPmojp/
   zwPOHcSthvC82rp1Pqrx9uLHVVmfn5lKeqH2Ha9hSPEhGxlEYY0u8rRUS
   A==;
X-CSE-ConnectionGUID: zLdhHprwSSG0VX0+gacV8Q==
X-CSE-MsgGUID: FDT7KdGYTlmkUKMPLz5lKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77384101"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77384101"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:14:21 -0700
X-CSE-ConnectionGUID: wph6QvYYRayC84PUF5QHTg==
X-CSE-MsgGUID: dfa2BUyPSQ60u1jKse/JhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232857723"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 27 Apr 2026 13:14:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 580E89D; Mon, 27 Apr 2026 22:14:17 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v0 04/14] iio: magnetometer: ak8975: Inline timeout constants
Date: Mon, 27 Apr 2026 22:09:49 +0200
Message-ID: <20260427201412.3067235-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we have switched to using macros from iopoll.h it's better to read
when the timeout values are explicitly provided in the parameters of the
respective helpers.

Besides that, fix the home grown and obviously wrong in some cases the
jiffy-based timeout.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 4cc92a15e937..53987f3b13d2 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -16,6 +16,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
+#include <linux/jiffies.h>
 #include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -133,13 +134,6 @@
 
 #define AK09912_MAX_REGS		AK09912_REG_ASAZ
 
-/*
- * Miscellaneous values.
- */
-#define AK8975_MAX_CONVERSION_TIMEOUT	500
-#define AK8975_CONVERSION_DONE_POLL_TIME 10
-#define AK8975_DATA_READY_TIMEOUT	((100*HZ)/1000)
-
 /*
  * Precalculate scale factor (in Gauss units) for each axis and
  * store in the device data.
@@ -658,8 +652,7 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data)
 
 	/* Wait for the conversion to complete. */
 	ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val, val != 0,
-				 AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
-				 AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC);
+				 10 * USEC_PER_MSEC, 500 * USEC_PER_MSEC);
 	if (ret)
 		return ret;
 
@@ -678,8 +671,7 @@ static int wait_conversion_complete_polled(struct ak8975_data *data)
 
 	/* Wait for the conversion to complete. */
 	ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
-				AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
-				AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC,
+				10 * USEC_PER_MSEC, 500 * USEC_PER_MSEC,
 				true,
 				client, data->def->ctrl_regs[ST1]);
 	if (ret)
@@ -699,7 +691,7 @@ static int wait_conversion_complete_interrupt(struct ak8975_data *data)
 
 	ret = wait_event_timeout(data->data_ready_queue,
 				 test_bit(0, &data->flags),
-				 AK8975_DATA_READY_TIMEOUT);
+				 msecs_to_jiffies(100));
 	clear_bit(0, &data->flags);
 
 	return ret > 0 ? 0 : -ETIMEDOUT;
-- 
2.50.1

