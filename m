Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEB2248F47;
	Thu, 19 Feb 2026 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511989; cv=none; b=DYXzrV7zelNv0uIqPmOGYip6O80AROS1OuyGatmr3bH7voYUVXcLITgRpLy+cryw5RU+Bnbd8MZSEFi+mzfwqCMHvXxaAQZDRHQA5GXjJzk2cjiJSZDoAD/Y+k/zuaIaG/C8U9dd2HueKVph60Y+lnt/nhKYEqriQCQJGDvks10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511989; c=relaxed/simple;
	bh=s9MXV7lH4hCfZovIakXUYCiLrJA9JvNf2AURQ3N1JBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IeaZqc9X1QI2Xi/bWXTevqDqPkXciGKKiPuB0hEXNwbrMTXpR9k4izjOSJKOFVVASEFZ3VlkJi+33j+LAtv6BEY2RT7d215yJ8I0eOyS4nNR6RgT35j9X0rJi5R2K8dpkG9So6chvEQ13B3Hx+SET1UpU7gwCmR58+RzKe+sojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnYwQ5fU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnYwQ5fU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771511988; x=1803047988;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s9MXV7lH4hCfZovIakXUYCiLrJA9JvNf2AURQ3N1JBU=;
  b=nnYwQ5fUf/CCTxKHmbjyGJ9JoceNezSwfz16/ih12RMgAcAvJBmVRKNz
   x/QvF5rwx4Y19CYAa6Q1wllubaZwezYryJj4wR2SJKf5t2ZCSmaDZT03e
   G/LalIWHArfqn5+LnpWSa+6WdnPPgdLIBfOQqxPm5ez32taE3gZ91UL45
   0fX8UAHIupBYy3ZXQXJEgmeOokmC9oVqoYmcA9knYq+aXxnz4pV50R34y
   zNg19t+eXt2cEQy1YBYrx5TNiRD78M3QBLCai1ny2MhpERhf6wQnpRlS6
   rAT9nw+TzuKU6NQRzW6uHhDKFsr2grN7ryOGn45RE/zartmp8yNwgWbqy
   g==;
X-CSE-ConnectionGUID: 5dopiqupTZ2HMF214v1Bng==
X-CSE-MsgGUID: k6buo5iUQhWYZVmKE+FYhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72482203"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72482203"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 06:39:47 -0800
X-CSE-ConnectionGUID: pMerpM0pS52QP3kPtayLTg==
X-CSE-MsgGUID: ErtpXLDiRHGtZ3H6kq6GSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="213622108"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 19 Feb 2026 06:39:44 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id CA64695; Thu, 19 Feb 2026 15:39:37 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 1/1] iio: adc: ad7191: Don't check for specific errors when parsing properties
Date: Thu, 19 Feb 2026 15:39:36 +0100
Message-ID: <20260219143936.2276366-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking for the specific error codes (that can be considered
a layering violation to some extent) check for the property existence first
and then either parse it, or apply a default value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ad7191.c | 63 +++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/ad7191.c b/drivers/iio/adc/ad7191.c
index d9cd903ffdd2..51ec199fb06f 100644
--- a/drivers/iio/adc/ad7191.c
+++ b/drivers/iio/adc/ad7191.c
@@ -154,27 +154,18 @@ static int ad7191_config_setup(struct iio_dev *indio_dev)
 	const u32 gain[4] = { 1, 8, 64, 128 };
 	static u32 scale_buffer[4][2];
 	int odr_value, odr_index = 0, pga_value, pga_index = 0, i, ret;
+	const char *propname;
 	u64 scale_uv;
 
 	st->samp_freq_index = 0;
 	st->scale_index = 0;
 
-	ret = device_property_read_u32(dev, "adi,odr-value", &odr_value);
-	if (ret && ret != -EINVAL)
-		return dev_err_probe(dev, ret, "Failed to get odr value.\n");
+	propname = "adi,odr-value";
+	if (device_property_present(dev, propname)) {
+		ret = device_property_read_u32(dev, propname, &odr_value);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to get %s.\n", propname);
 
-	if (ret == -EINVAL) {
-		st->odr_gpios = devm_gpiod_get_array(dev, "odr", GPIOD_OUT_LOW);
-		if (IS_ERR(st->odr_gpios))
-			return dev_err_probe(dev, PTR_ERR(st->odr_gpios),
-					     "Failed to get odr gpios.\n");
-
-		if (st->odr_gpios->ndescs != 2)
-			return dev_err_probe(dev, -EINVAL, "Expected 2 odr gpio pins.\n");
-
-		st->samp_freq_avail = samp_freq;
-		st->samp_freq_avail_size = ARRAY_SIZE(samp_freq);
-	} else {
 		for (i = 0; i < ARRAY_SIZE(samp_freq); i++) {
 			if (odr_value != samp_freq[i])
 				continue;
@@ -186,6 +177,17 @@ static int ad7191_config_setup(struct iio_dev *indio_dev)
 		st->samp_freq_avail_size = 1;
 
 		st->odr_gpios = NULL;
+	} else {
+		st->odr_gpios = devm_gpiod_get_array(dev, "odr", GPIOD_OUT_LOW);
+		if (IS_ERR(st->odr_gpios))
+			return dev_err_probe(dev, PTR_ERR(st->odr_gpios),
+					     "Failed to get odr gpios.\n");
+
+		if (st->odr_gpios->ndescs != 2)
+			return dev_err_probe(dev, -EINVAL, "Expected 2 odr gpio pins.\n");
+
+		st->samp_freq_avail = samp_freq;
+		st->samp_freq_avail_size = ARRAY_SIZE(samp_freq);
 	}
 
 	mutex_lock(&st->lock);
@@ -200,22 +202,12 @@ static int ad7191_config_setup(struct iio_dev *indio_dev)
 
 	mutex_unlock(&st->lock);
 
-	ret = device_property_read_u32(dev, "adi,pga-value", &pga_value);
-	if (ret && ret != -EINVAL)
-		return dev_err_probe(dev, ret, "Failed to get pga value.\n");
+	propname = "adi,pga-value";
+	if (device_property_present(dev, propname)) {
+		ret = device_property_read_u32(dev, propname, &pga_value);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to get %s.\n", propname);
 
-	if (ret == -EINVAL) {
-		st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
-		if (IS_ERR(st->pga_gpios))
-			return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
-					     "Failed to get pga gpios.\n");
-
-		if (st->pga_gpios->ndescs != 2)
-			return dev_err_probe(dev, -EINVAL, "Expected 2 pga gpio pins.\n");
-
-		st->scale_avail = scale_buffer;
-		st->scale_avail_size = ARRAY_SIZE(scale_buffer);
-	} else {
 		for (i = 0; i < ARRAY_SIZE(gain); i++) {
 			if (pga_value != gain[i])
 				continue;
@@ -227,6 +219,17 @@ static int ad7191_config_setup(struct iio_dev *indio_dev)
 		st->scale_avail_size = 1;
 
 		st->pga_gpios = NULL;
+	} else {
+		st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
+		if (IS_ERR(st->pga_gpios))
+			return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
+					     "Failed to get pga gpios.\n");
+
+		if (st->pga_gpios->ndescs != 2)
+			return dev_err_probe(dev, -EINVAL, "Expected 2 pga gpio pins.\n");
+
+		st->scale_avail = scale_buffer;
+		st->scale_avail_size = ARRAY_SIZE(scale_buffer);
 	}
 
 	st->temp_gpio = devm_gpiod_get(dev, "temp", GPIOD_OUT_LOW);
-- 
2.50.1

