Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDB843441C;
	Thu, 13 Aug 2026 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786605570; cv=none; b=omlmDvyIVglIOv6m9e1xbPker4DHEAmyS2mHb4PT4nZGIw1K4ZwfzPLWpO+6c4wFYTiW5gWMd1Wbsp59yaMsakmgdpxeYu1sjPXnTMByuacufvpYpRe6qqeZbLfpejhKaVVB98A7s17IpR4QWfLDTnRpi8cVQLW2qCix4mMsojQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786605570; c=relaxed/simple;
	bh=eAWIBrQWLETu+nZHLtHg3nJVtjZwcFnWQJ7W7jTlwW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VamKh8nOg7RJcQ4lHGgzYnolHVrVF69NwvlHGmETqUy7/chaGUej317AFZZahCjPigHVMnRlqlkjiAtJ0mbMW/veX5219WJ8ure3aHaEMcDXDvvKDP4ejNkwqquXI5zxEs2IgLtRAe7p052q/yK5meQbDwyitoMcqmIPYm45l/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WpHQS9sP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpHQS9sP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786605567; x=1818141567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eAWIBrQWLETu+nZHLtHg3nJVtjZwcFnWQJ7W7jTlwW4=;
  b=WpHQS9sPiEozZHhiHyqaYYf377JgYNEKRe8vyA/rhGObyc05dDqgJIeC
   6CQiv9rKce5wBPOXNTRRWMDIZssmq923CpJSczRWMyY92W41DAxjoCPpc
   NkOfVBOxKPziRjhCQM5Af+7zsIS+tdTwc9ts9iqGIWOuVFB5JZqCu3d3b
   fBErAJFvyqA/7ScDBY91EVAaWFisAPV/Sq+vjP3j9bv04gvTr31/ExF+q
   ohEfa2ZqBSiuABnAqxOUttSFYzweO8cPdHuXQ7GCjuVQ+jMSm8tcMrc9l
   oJsieMb6W+QJBLTUzk1br7jP4WnOVlntpRPWxgCsZX/ADXWnqcGX7Lgv6
   w==;
X-CSE-ConnectionGUID: zWb+eCvaTQybRtRggQge1g==
X-CSE-MsgGUID: PsS7HrRPSbulQ0MmokrNHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86936983"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="86936983"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 00:19:19 -0700
X-CSE-ConnectionGUID: 5TiFO+P4Ro6bKMzgpBJxeQ==
X-CSE-MsgGUID: VwxuEc0oRnqQnUuWedXykw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="268138715"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 13 Aug 2026 00:19:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id DD60F9B; Thu, 13 Aug 2026 09:19:14 +0200 (CEST)
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
Subject: [PATCH v1 1/4] iio: light: Unshadow error codes in ->store()
Date: Thu, 13 Aug 2026 09:16:50 +0200
Message-ID: <20260813071912.2465208-2-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/light/isl29018.c   |  7 +++++--
 drivers/iio/light/lm3533-als.c | 11 +++++++----
 drivers/iio/light/tsl2583.c    | 15 +++++++++++----
 drivers/iio/light/tsl2772.c    | 16 ++++++++++++----
 4 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index 759cb71ed1c5..7f7a563df4d9 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -10,6 +10,7 @@
 
 #include <linux/i2c.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
@@ -339,9 +340,11 @@ static ssize_t proximity_on_chip_ambient_infrared_suppression_store
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct isl29018_chip *chip = iio_priv(indio_dev);
 	int val;
+	int ret;
 
-	if (kstrtoint(buf, 10, &val))
-		return -EINVAL;
+	ret = kstrtoint(buf, 10, &val);
+	if (ret)
+		return ret;
 	if (!(val == 0 || val == 1))
 		return -EINVAL;
 
diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 99f0b903018c..5db9591a85b9 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/mfd/core.h>
@@ -434,8 +435,9 @@ static ssize_t store_thresh_either_en(struct device *dev,
 	if (!als->irq)
 		return -EBUSY;
 
-	if (kstrtoul(buf, 0, &enable))
-		return -EINVAL;
+	ret = kstrtoul(buf, 0, &enable);
+	if (ret)
+		return ret;
 
 	int_enabled = test_bit(LM3533_ALS_FLAG_INT_ENABLED, &als->flags);
 
@@ -542,8 +544,9 @@ static ssize_t store_als_attr(struct device *dev,
 	u8 val;
 	int ret;
 
-	if (kstrtou8(buf, 0, &val))
-		return -EINVAL;
+	ret = kstrtou8(buf, 0, &val);
+	if (ret)
+		return ret;
 
 	switch (als_attr->type) {
 	case LM3533_ATTR_TYPE_TARGET:
diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 53fd423aa7ae..2d041b7530e6 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -7,10 +7,11 @@
  * Copyright (c) 2016-2017 Brian Masney <masneyb@onstation.org>
  */
 
-#include <linux/kernel.h>
 #include <linux/i2c.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/string.h>
 #include <linux/mutex.h>
 #include <linux/unistd.h>
@@ -483,9 +484,12 @@ static ssize_t in_illuminance_input_target_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	int value;
+	int value, ret;
 
-	if (kstrtoint(buf, 0, &value) || !value)
+	ret = kstrtoint(buf, 0, &value);
+	if (ret)
+		return ret;
+	if (!value)
 		return -EINVAL;
 
 	mutex_lock(&chip->als_mutex);
@@ -503,7 +507,10 @@ static ssize_t in_illuminance_calibrate_store(struct device *dev,
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
 	int value, ret;
 
-	if (kstrtoint(buf, 0, &value) || value != 1)
+	ret = kstrtoint(buf, 0, &value);
+	if (ret)
+		return ret;
+	if (value != 1)
 		return -EINVAL;
 
 	mutex_lock(&chip->als_mutex);
diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 4486a1d9d84d..c8a7afc65c1f 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
@@ -951,8 +952,9 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
 	u16 value;
 	int ret;
 
-	if (kstrtou16(buf, 0, &value))
-		return -EINVAL;
+	ret = kstrtou16(buf, 0, &value);
+	if (ret)
+		return ret;
 
 	chip->settings.als_cal_target = value;
 	ret = tsl2772_invoke_change(indio_dev);
@@ -970,7 +972,10 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
 	bool value;
 	int ret;
 
-	if (kstrtobool(buf, &value) || !value)
+	ret = kstrtobool(buf, &value);
+	if (ret)
+		return ret;
+	if (!value)
 		return -EINVAL;
 
 	ret = tsl2772_als_calibrate(indio_dev);
@@ -1061,7 +1066,10 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
 	bool value;
 	int ret;
 
-	if (kstrtobool(buf, &value) || !value)
+	ret = kstrtobool(buf, &value);
+	if (ret)
+		return ret;
+	if (!value)
 		return -EINVAL;
 
 	ret = tsl2772_prox_cal(indio_dev);
-- 
2.50.1

