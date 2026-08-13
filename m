Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E113E7BC6;
	Thu, 13 Aug 2026 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786605564; cv=none; b=dH+WU57/MRbi6xlNXXqTJHRWVEdpI+BV//A3R2tId32WCivod75oL495pJ/oh18Sn1VejZDIqBKFw9FNtpIaFLYK1E6mQb32p7utt7ZyGJ//sDEO5D4OgPRenrAbjLjJHKfJb2bMoBiCDWJErHPDjH3uUtdff+16cgLCN4I9jt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786605564; c=relaxed/simple;
	bh=uRV56n5MxzD2fGsyRgTGrGLMf5tZTR65vbwBkxNa7W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9eCHVe1QJHLkmPt9ea9JbKpCuv7WWR3pU56F37aW1YAwlmnbzd/WB2qb0yAnqylx6poDeDD5Mm6OU7yVp3/X4aGvAIHEbQNFfYMl2kSTRSN9Xs+ZQUagGimMwBCacLCV5cGoicqDQaWLAT3wglY34exiMucMjaO5NM8f6oX6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeVr9qku; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeVr9qku"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786605560; x=1818141560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uRV56n5MxzD2fGsyRgTGrGLMf5tZTR65vbwBkxNa7W4=;
  b=VeVr9qkumGPEVXcm8qZ0da5v1LS2MdUVcVBxnxK5GPe37504rjlwcyTa
   hftkhxuNGPfq/gMQQliw6C+EcxqImP5T7hQx778Jl3NskwfuVhfScYJzo
   QgaU6VpMGHpxw/RUbndPaIi9HvgwnrrSLnvkbHUPxCTxlWoxH0+Ssz+61
   /DyfhgSzUZcC5JUgIh2dhaNUhNvUGWrKL83yS8ymSKt3XK8TTvvPSG+mk
   Tht0lb5JzvgiDBwcdUe7IQiLgUgBobINGAf9vixPIUZIk0AxtKYZHxyQ2
   BhQ+iPLBpFo/QZejBX2qofiMzfmajjpid+GLFGeqBiWd2qMxllo0joRbT
   g==;
X-CSE-ConnectionGUID: /rxkie1dT8KajmxaO8eJZg==
X-CSE-MsgGUID: ahlsysVpTymkaQM3m4Hcaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86936967"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="86936967"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 00:19:19 -0700
X-CSE-ConnectionGUID: x+oaR0miRJC+Gus05eNzmw==
X-CSE-MsgGUID: fzyFRs8RQgiaMVnC3K11gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="268138716"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 13 Aug 2026 00:19:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id E88859D; Thu, 13 Aug 2026 09:19:14 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Marius Cristea <marius.cristea@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH v1 2/4] iio: imu: inv_mpu6050: Unshadow error codes in ->store()
Date: Thu, 13 Aug 2026 09:16:51 +0200
Message-ID: <20260813071912.2465208-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kstrtox() may return different error codes.

Unshadow them in the ->store() callback to give better error report.

While at it, add missing kstrtox.h inclusion.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 5796896d54cd..38c3f3b398d4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/acpi.h>
+#include <linux/kstrtox.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
 #include <linux/math64.h>
@@ -1303,8 +1304,9 @@ inv_mpu6050_fifo_rate_store(struct device *dev, struct device_attribute *attr,
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	struct device *pdev = regmap_get_device(st->map);
 
-	if (kstrtoint(buf, 10, &fifo_rate))
-		return -EINVAL;
+	result = kstrtoint(buf, 10, &fifo_rate);
+	if (result)
+		return result;
 	if (fifo_rate < INV_MPU6050_MIN_FIFO_RATE ||
 	    fifo_rate > INV_MPU6050_MAX_FIFO_RATE)
 		return -EINVAL;
-- 
2.50.1

