Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEEB43785C;
	Thu, 13 Aug 2026 07:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786605572; cv=none; b=o9ux8GhO3FqeW2jRUwcDmXXBCxy3PKLCzM+Y6DWKJdNacM4QDxP9JW2Yc+yJgRXMK0MSBk4mmAXacWT4Hxv4vugZS6rnZNY1M/5Y4EY3LjUaFvsjIf4nZIs0AbCOirUAPnc2y5ppirITlZNy+N5Ud4ZoQ/eToc2rR5qXX3ZoP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786605572; c=relaxed/simple;
	bh=4vEfbJ1bFrwiB8zuPyABnVqy7qXxeSMyybLAVMQoo1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSic6I9AdOkE3eHXbzUW2I8ma9/ZjAa5Lk+ATdgcFQstgdQFKL8G4Iol3hz4DS+RqQzJy+C45rYXQbEJ6qO1KCykzS5OsSuolxZjKz2gInXfmU9Stug3CwlA19MBjRASDpcaItdWR0MV8toUjqhRidgQkz6fumLWjbUXZzZhox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=es6QJpCq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="es6QJpCq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786605568; x=1818141568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4vEfbJ1bFrwiB8zuPyABnVqy7qXxeSMyybLAVMQoo1k=;
  b=es6QJpCq8nJpb4ViigwZjDK5yPksfKFVDpwyySXF+6kZ4hj1U6JcNYHL
   WEJl5SF8CMuOEW4SrujpBKSErO2XnJUW/+61AMSSapgLtcuGPkSW7CiIj
   VIysQCKoUD++Nx/1dhGGwkhsm8htNqs5DXjjWJHsEooDMmG8SFf4zQYUS
   eIxn+RYLCd+jYYflj3OQZBRPnLfy6VpXsZ9rWgGCdvmqLIopPKckcthq9
   LPMn49/dft+Z6rbQDRtj8LD8h7meMP/5TsxcSZMqzNJQJbGUaQ+oKm07a
   1bxlZ3V0arIqcRpWH/2pSAO79J/+b9HmmJwx72xD1oBd8gLdpUAXi9Utw
   w==;
X-CSE-ConnectionGUID: 0iKr0ltVQCWAEZxG+DsL5Q==
X-CSE-MsgGUID: qEnWypWFQTuZdMTq8Ekk7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87297017"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87297017"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 00:19:18 -0700
X-CSE-ConnectionGUID: VUvg0XJyTZq/rlVIpU5egw==
X-CSE-MsgGUID: jj4+YFg1SlmR94MBqFVfSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="263402935"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 13 Aug 2026 00:19:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0D985A1; Thu, 13 Aug 2026 09:19:15 +0200 (CEST)
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
Subject: [PATCH v1 4/4] iio: adc: pac1934: Unshadow error codes in ->store()
Date: Thu, 13 Aug 2026 09:16:53 +0200
Message-ID: <20260813071912.2465208-5-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/adc/pac1934.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index 23055405a6e0..2d934452eb11 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -19,6 +19,7 @@
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/kstrtox.h>
 #include <linux/unaligned.h>
 
 /*
@@ -494,11 +495,13 @@ static ssize_t pac1934_shunt_value_store(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct pac1934_chip_info *info = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int sh_val;
+	unsigned int sh_val;
+	int ret;
 
-	if (kstrtouint(buf, 10, &sh_val)) {
+	ret = kstrtouint(buf, 10, &sh_val);
+	if (ret) {
 		dev_err(dev, "Shunt value is not valid\n");
-		return -EINVAL;
+		return ret;
 	}
 
 	scoped_guard(mutex, &info->lock)
-- 
2.50.1

