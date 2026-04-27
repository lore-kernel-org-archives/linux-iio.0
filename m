Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C290332EC8;
	Mon, 27 Apr 2026 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320867; cv=none; b=EzbbcbT+rwkO7wrHzHSuZ1DU+EaySQLxLuouyNJOVxHOpf9gB+gC9JCbMcZ7T7ufIGooO8Diq5oaKHugJenvibR4l8wt7+xu0jdo9+7AUqekt0vpD+sXxDX7fezIWCrE5lms4Momm/BEB2H7Y60An0xbGT2TitPN1Sio3DmkgCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320867; c=relaxed/simple;
	bh=MXgGfSVa8kgYgbv7NCsM8eBhNUmCowLhQjSuWcFltj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJ5lJcVzbgNxq37DtI5hGddQa06psY1mHoFrfuZnQE4znWJ/fMNqStGl+bFk22/t2qJKS/TLvJycvtbgISinUFH/aMVNSCnNc+/rxXppEPGBJIBhczx0diKtxHgt1yWCJG4Fhv7Vi3cOcs4T01rFApaDOR6sFKonbi9OAJtaUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNcrwBuQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNcrwBuQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777320866; x=1808856866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MXgGfSVa8kgYgbv7NCsM8eBhNUmCowLhQjSuWcFltj4=;
  b=GNcrwBuQZ2btpwC8KnUUK/IgD3O5goq/GVGVaRCxXwh/r48XhrQWLcvR
   H8aJbPBbRtwS0fzFtVcu41RQpCnnDeAcbZ6QiVoHkS7QifEJQoZOfNzzq
   7VYxHOks06hhge/O04aq03QqYalAPc91grN2bgOk9YyskdES7uLak/4IU
   iPWilq02OEc6BxnnMKc8FiZTWQrbMwFgZ+XIp7T8jjbc64izxRSQKwtR8
   fmm8EsEjamoL/oTo+jLBw+fTDBjfrOaASmBbTg3jUiSyuqun7ryuqfnh7
   743ZbZI+4ShSnQoLl6Vv4DO8G/0EBmzLwu14JMk1q1O7/fhdtiWvrn/74
   g==;
X-CSE-ConnectionGUID: 09Mv0OIsSdWduHOCjzKXcA==
X-CSE-MsgGUID: PfwGVMyRRd2KfLvJu+/lSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78138366"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78138366"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:14:23 -0700
X-CSE-ConnectionGUID: iox6gbJBT6Cz3idRsTO28Q==
X-CSE-MsgGUID: 8OInR5v1RSSCXBS9UarngQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="238074770"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 27 Apr 2026 13:14:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6E3AFA5; Mon, 27 Apr 2026 22:14:17 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v0 09/14] iio: magnetometer: ak8975: Unify return code variable name
Date: Mon, 27 Apr 2026 22:09:54 +0200
Message-ID: <20260427201412.3067235-10-andriy.shevchenko@linux.intel.com>
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

In one case 'rc' is used in the other 'err', the most use 'ret'.
Make the latter use the former, id est 'ret'.

While at it, drop unneeded ' < 0' checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 46 +++++++++++++++----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 7ec1d4848fca..53158ffd173b 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -573,8 +573,8 @@ static irqreturn_t ak8975_irq_handler(int irq, void *data)
 static int ak8975_setup_irq(struct ak8975_data *data)
 {
 	struct i2c_client *client = data->client;
-	int rc;
 	int irq;
+	int ret;
 
 	init_waitqueue_head(&data->data_ready_queue);
 	clear_bit(0, &data->flags);
@@ -583,15 +583,15 @@ static int ak8975_setup_irq(struct ak8975_data *data)
 	else
 		irq = gpiod_to_irq(data->eoc_gpiod);
 
-	rc = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
-			      IRQF_TRIGGER_RISING,
-			      dev_name(&client->dev), data);
-	if (rc < 0)
-		return rc;
+	ret = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
+			       IRQF_TRIGGER_RISING,
+			       dev_name(&client->dev), data);
+	if (ret)
+		return ret;
 
 	data->eoc_irq = irq;
 
-	return rc;
+	return 0;
 }
 
 /*
@@ -895,8 +895,8 @@ static int ak8975_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	struct gpio_desc *eoc_gpiod;
 	struct gpio_desc *reset_gpiod;
-	int err;
 	const char *name = NULL;
+	int ret;
 
 	/*
 	 * Grab and set up the supplied GPIO.
@@ -931,9 +931,9 @@ static int ak8975_probe(struct i2c_client *client)
 	data->reset_gpiod = reset_gpiod;
 	data->eoc_irq = 0;
 
-	err = iio_read_mount_matrix(&client->dev, &data->orientation);
-	if (err)
-		return err;
+	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	if (ret)
+		return ret;
 
 	/* id will be NULL when enumerated via ACPI */
 	data->def = i2c_get_match_data(client);
@@ -954,20 +954,20 @@ static int ak8975_probe(struct i2c_client *client)
 	if (IS_ERR(data->vid))
 		return PTR_ERR(data->vid);
 
-	err = ak8975_power_on(data);
-	if (err)
-		return err;
+	ret = ak8975_power_on(data);
+	if (ret)
+		return ret;
 
-	err = ak8975_who_i_am(client, data->def->type);
-	if (err < 0) {
+	ret = ak8975_who_i_am(client, data->def->type);
+	if (ret) {
 		dev_err(&client->dev, "Unexpected device\n");
 		goto power_off;
 	}
 	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
 
 	/* Perform some basic start-of-day setup of the device. */
-	err = ak8975_setup(client);
-	if (err < 0) {
+	ret = ak8975_setup(client);
+	if (ret) {
 		dev_err(&client->dev, "%s initialization fails\n", name);
 		goto power_off;
 	}
@@ -980,15 +980,15 @@ static int ak8975_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
 
-	err = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
+	ret = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
 					 NULL);
-	if (err) {
+	if (ret) {
 		dev_err(&client->dev, "triggered buffer setup failed\n");
 		goto power_off;
 	}
 
-	err = iio_device_register(indio_dev);
-	if (err) {
+	ret = iio_device_register(indio_dev);
+	if (ret) {
 		dev_err(&client->dev, "device register failed\n");
 		goto cleanup_buffer;
 	}
@@ -1011,7 +1011,7 @@ static int ak8975_probe(struct i2c_client *client)
 	iio_triggered_buffer_cleanup(indio_dev);
 power_off:
 	ak8975_power_off(data);
-	return err;
+	return ret;
 }
 
 static void ak8975_remove(struct i2c_client *client)
-- 
2.50.1

