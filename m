Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7643550A;
	Thu, 13 Aug 2026 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786605567; cv=none; b=MT7Jdr/xzO8lGbXJunif5SBJUeOftiuUPRpDs5Tw37VH7Z8mkX7L3O3flOXHJMxNQsuDfSmVuH6nuua44r4qffoRzv7LMxmmP+WwG8i0CJ6Xq4aK7noENJDt3EePZTV3At1Oqv7rIUYiH8H4tP/8lGhudKbeySOPyS87wk7kkYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786605567; c=relaxed/simple;
	bh=oqgL0oIQvfUY3wKeSrEAs/o9m4Hle+wsoIiN9GUcc84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgwHhApx1BRv3G30RXrMFtC99+VZsmd84l2ACp6QWeSqwgWW1134OMMR32qFNu64cqFBrjIvIJOqtnNUFFL+LIaFyoczv5ANQAm0z0BhZgkoonuN1tNtuXFR3r1lmi8NZtxqgi0ri+wXQCEVqahhpGyC4wvGUwkL/N4ok8N/YdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bCFWM2v1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bCFWM2v1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786605560; x=1818141560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oqgL0oIQvfUY3wKeSrEAs/o9m4Hle+wsoIiN9GUcc84=;
  b=bCFWM2v1Ls97xVukXiY5AOSjwCiatzVzPusCLYdbTjvyhYXwRrWkMn4X
   PJ2TAgaBZdlFuodk4hNSWCzMKs4pSqqrjNCE0JipvueOFbtbmSr2nKi5o
   8DSwuoAoHq+ezpDG9vOAzjCNGi22pLVNDQj6UxXOTBOB6TRDxM45qye3A
   yoLTmQANVsrPm/ugSlvsXx6AZu5GApsBDcoZQTxdhDD2JcN0R4ZGY+nSR
   9pZYrWmR9SECm3jhU4COTd4seBMmIuqXC2z4P3qr7dpUEfgIsAXukfnCB
   BCwGvM2yBCLZSYl3paa0bdbcymo0XIF3/c6kLLS5ZTcgHLU7SXT15kPXE
   A==;
X-CSE-ConnectionGUID: yQ8TrAokQI6rhra4uDSmPw==
X-CSE-MsgGUID: CLuIje9sRyOSr2lT0Dx2QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="87297005"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="87297005"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 00:19:18 -0700
X-CSE-ConnectionGUID: juHRrH4URuSF/WL0oWe4Kw==
X-CSE-MsgGUID: P/XcKvVURu+eVf9bbewa7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="263402936"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 13 Aug 2026 00:19:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 01B4E9E; Thu, 13 Aug 2026 09:19:15 +0200 (CEST)
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
Subject: [PATCH v1 3/4] iio: chemical: sps30: Unshadow error codes in ->store()
Date: Thu, 13 Aug 2026 09:16:52 +0200
Message-ID: <20260813071912.2465208-4-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/chemical/sps30.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
index 8e15baa31423..b47d08ab4d0f 100644
--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -15,6 +15,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 
 #include "sps30.h"
@@ -193,7 +194,10 @@ static ssize_t start_cleaning_store(struct device *dev,
 	struct sps30_state *state = iio_priv(indio_dev);
 	int val, ret;
 
-	if (kstrtoint(buf, 0, &val) || val != 1)
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+	if (val != 1)
 		return -EINVAL;
 
 	guard(mutex)(&state->lock);
@@ -230,8 +234,9 @@ static ssize_t cleaning_period_store(struct device *dev, struct device_attribute
 	struct sps30_state *state = iio_priv(indio_dev);
 	int val, ret;
 
-	if (kstrtoint(buf, 0, &val))
-		return -EINVAL;
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
 
 	if ((val < SPS30_AUTO_CLEANING_PERIOD_MIN) ||
 	    (val > SPS30_AUTO_CLEANING_PERIOD_MAX))
-- 
2.50.1

