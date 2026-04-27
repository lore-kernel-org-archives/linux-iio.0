Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF21F37756F;
	Mon, 27 Apr 2026 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320870; cv=none; b=YPiiBtymnF2tnP1ZGFyax+tt9uYC+M3f0U1s13UAU2p2MV84wWpqPOy4qKpATBdcsU9J2kBLvSrBPJsZ9V2CAScZLkpJ17qHUA4vNMaxRAc231r1KecbyVEiHQ16hl0iazJUhusUMOau5qL9oSBTZIZc7RqYaIHbFZ/4VT3ej1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320870; c=relaxed/simple;
	bh=QXnPBK5SscAJkaUY7ARK2dsTnAChVGIyVqfliTIYWeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFR+T9cBoP35W7RmmB1wIAow+C0KWQ8F9ALPZgjD56vbGCv51PMzyckw9xg9F6B5G1xlu5iWuig6OwW9cL6J549VKDAbRzEBDMzgIIuoOAjuUQo2Nb5r++OMc4Zd5K+rmPmrjWkkgpWvOdKjNGGrEsOBFdT8/k2XV+y+o6BthiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AUNwjXaB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AUNwjXaB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777320869; x=1808856869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QXnPBK5SscAJkaUY7ARK2dsTnAChVGIyVqfliTIYWeo=;
  b=AUNwjXaBksxTdHIKSHHkSUtIS9a3/45bxD8w0zUeF5rIlsbedn9kFCrH
   qRTuxXidXlFeJSadbkJDFFTwf/dik7yza/41fv10gn/2d2z4cAljmQ/gi
   OsreVlooDXIYgjdQG3FZVKTZVELMS4c3IOdI0Xcr1vqfD4k1oIRoiOE37
   ynM4CNUr4ieifoOfD8pfO2KIE4Z1EJEpKh5ATwKnB2wm4MygrHnJUYc2b
   3gR2GWicZK8xc9WYt4ei8bytzSpfq1PwspAz/4EOV6tuZLBRAyix6FDlP
   TwRJ8aVa1vQU9Z/IktDQ+R4LNNeacV0wyWZLhJ/5xtg4l4x0irN2tF43i
   Q==;
X-CSE-ConnectionGUID: 59H6caA2SGavyBocF0C6ew==
X-CSE-MsgGUID: LqYtq+guT4KCx36wtFtkBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77384104"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77384104"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:14:23 -0700
X-CSE-ConnectionGUID: /NezYaYoQaKL7zgQOcKdZg==
X-CSE-MsgGUID: IYfoDXzyQD6nBtRKnCfQ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232857728"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 27 Apr 2026 13:14:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7AEC8A8; Mon, 27 Apr 2026 22:14:17 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v0 12/14] iio: magnetometer: ak8975: Unify messages with help of dev_err_probe()
Date: Mon, 27 Apr 2026 22:09:57 +0200
Message-ID: <20260427201412.3067235-13-andriy.shevchenko@linux.intel.com>
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

Unify error messages that might appear during probe phase by
switching to use dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b734a5939f73..c2eb7b0d0da8 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -495,10 +495,8 @@ static int ak8975_who_i_am(const struct ak8975_data *data,
 							AK09912_REG_WIA1,
 							sizeof(wia_val),
 							wia_val);
-	if (ret < 0) {
-		dev_err(&client->dev, "Error reading WIA\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "Error reading WIA\n");
 
 	if (wia_val[0] != AK8975_DEVICE_ID)
 		return -ENODEV;
@@ -971,18 +969,14 @@ static int ak8975_probe(struct i2c_client *client)
 		return ret;
 
 	ret = ak8975_who_i_am(data, data->def->type);
-	if (ret) {
-		dev_err(&client->dev, "Unexpected device\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Unexpected device\n");
 	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
 
 	/* Perform some basic start-of-day setup of the device. */
 	ret = ak8975_setup(data);
-	if (ret) {
-		dev_err(&client->dev, "%s initialization fails\n", name);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "%s initialization fails\n", name);
 
 	ret = devm_mutex_init(dev, &data->lock);
 	if (ret)
@@ -997,16 +991,12 @@ static int ak8975_probe(struct i2c_client *client)
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ak8975_handle_trigger, NULL);
-	if (ret) {
-		dev_err(&client->dev, "triggered buffer setup failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "triggered buffer setup failed\n");
 
 	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret) {
-		dev_err(&client->dev, "device register failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "device register failed\n");
 
 	/* Enable runtime PM */
 	ret = devm_pm_runtime_set_active_enabled(dev);
-- 
2.50.1

