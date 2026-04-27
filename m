Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEFA36605D;
	Mon, 27 Apr 2026 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320867; cv=none; b=LtcMT+ZtYylLsAcCRv4IjjIoMLmTYc0uluxRiQKXa4Em8j+B4/9gxjE9HE+WajaGHwxyu49W/VWltSaRbR3zd11twOHGSeBIcTKxCv1Wvm6zkkU1vpPzHhqc0d7P/o34ftSkIolkllPdlwd1d9IQI1x3//DK+uZkkviLXBmAUak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320867; c=relaxed/simple;
	bh=bvAb3rmm2QsUxkx2+qv0zd/GFtfUEF4/M5sMzqm6L6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kl06OAUc1dkRLJLaJ//5V/lRhgRJ5DTNkObEDE0HqlPPl8Kxg8A69yQ/ihJw2et5pMMrIMqLG914CtaUeJ0apkGqrVsWZHtiBqv8PPBoMdEK1crzwzu6E7crMxVrBJq2LM9bGsrwFX2swaIZdc3nD9XvfXBGo3N1w23/Bi0AGi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4Ub3EH8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4Ub3EH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777320866; x=1808856866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bvAb3rmm2QsUxkx2+qv0zd/GFtfUEF4/M5sMzqm6L6k=;
  b=W4Ub3EH8Nfz+qro3LCf5ErbxbgAsATtWbSKlnSlWLY629ZJetYw5Ji2H
   q0QDnKgNUrZDjdSorHp7zcFOR7T7KymYKGvRvHyfWcA/MkW1gRHQaQqmb
   EOhxMhtSaibh6PQDQczr4dGEwW+GTxIMMWbd5dgM7oJiOkctwscUf6tZL
   hig4Q6D1EXEm85jhbgNFbe6S+KK1j6y81LndKl3fKMyBcdpOcLQbCmwsx
   UuW+CsI19iXlYWlwS4Sbb0bSGaUiEmkVJUpmBfaVzPRXhHjlSF8VtYl/m
   uJ5gQQ+8DwlVrcsj9+DYKUmlGPel5SGXUVdTVhlXqerCm0pwlvhqlS5Zh
   g==;
X-CSE-ConnectionGUID: MTJ/T1qtTf62Qd1+bnBYQg==
X-CSE-MsgGUID: iU+UK2OFTKGCSVJDZv1DZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78138376"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78138376"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:14:23 -0700
X-CSE-ConnectionGUID: jhZeSeTHR5C+F9GrpyqlrA==
X-CSE-MsgGUID: SJBfUn01TSWHPBSEj4sWlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="238074771"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 27 Apr 2026 13:14:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7692EA7; Mon, 27 Apr 2026 22:14:17 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v0 11/14] iio: magnetometer: ak8975: Consistently use 'data' parameter
Date: Mon, 27 Apr 2026 22:09:56 +0200
Message-ID: <20260427201412.3067235-12-andriy.shevchenko@linux.intel.com>
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

Some of the functions use 'client', some use 'data', and some use both.
Refactor the driver to consistently use 'data' in all cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index d666d9d171bd..b734a5939f73 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -474,9 +474,10 @@ static void ak8975_power_off(const struct ak8975_data *data)
  * Return 0 if the i2c device is the one we expect.
  * return a negative error number otherwise
  */
-static int ak8975_who_i_am(struct i2c_client *client,
+static int ak8975_who_i_am(const struct ak8975_data *data,
 			   enum asahi_compass_chipset type)
 {
+	struct i2c_client *client = data->client;
 	u8 wia_val[2];
 	int ret;
 
@@ -598,10 +599,9 @@ static int ak8975_setup_irq(struct ak8975_data *data)
  * Perform some start-of-day setup, including reading the asa calibration
  * values and caching them.
  */
-static int ak8975_setup(struct i2c_client *client)
+static int ak8975_setup(struct ak8975_data *data)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ak8975_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
 	int ret;
 
 	/* Write the fused rom access mode. */
@@ -697,12 +697,13 @@ static int wait_conversion_complete_interrupt(struct ak8975_data *data)
 	return ret > 0 ? 0 : -ETIMEDOUT;
 }
 
-static int ak8975_start_read_axis(struct ak8975_data *data,
-				  const struct i2c_client *client)
+static int ak8975_start_read_axis(struct ak8975_data *data)
 {
-	/* Set up the device for taking a sample. */
-	int ret = ak8975_set_mode(data, MODE_ONCE);
+	struct i2c_client *client = data->client;
+	int ret;
 
+	/* Set up the device for taking a sample. */
+	ret = ak8975_set_mode(data, MODE_ONCE);
 	if (ret < 0) {
 		dev_err(&client->dev, "Error in setting operating mode\n");
 		return ret;
@@ -735,7 +736,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 	mutex_lock(&data->lock);
 
-	ret = ak8975_start_read_axis(data, client);
+	ret = ak8975_start_read_axis(data);
 	if (ret)
 		goto exit;
 
@@ -846,7 +847,7 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 
 	mutex_lock(&data->lock);
 
-	ret = ak8975_start_read_axis(data, client);
+	ret = ak8975_start_read_axis(data);
 	if (ret)
 		goto unlock;
 
@@ -969,7 +970,7 @@ static int ak8975_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ret = ak8975_who_i_am(client, data->def->type);
+	ret = ak8975_who_i_am(data, data->def->type);
 	if (ret) {
 		dev_err(&client->dev, "Unexpected device\n");
 		return ret;
@@ -977,7 +978,7 @@ static int ak8975_probe(struct i2c_client *client)
 	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
 
 	/* Perform some basic start-of-day setup of the device. */
-	ret = ak8975_setup(client);
+	ret = ak8975_setup(data);
 	if (ret) {
 		dev_err(&client->dev, "%s initialization fails\n", name);
 		return ret;
-- 
2.50.1

