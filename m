Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D760C5616BF;
	Fri, 11 Sep 2026 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161034; cv=none; b=Q5XKbWm+rzQIutfPKuBE9X8cywziqmSu+n3mxNST6bQ0nMybz2CKQbNYnEQqimc1rElTxgDXjAmLdTQK5LpzOiovnauuhOcliJiMUN1GSZoRktkMu5YN1ceINjK/4zXZxU4dLabsbDDQTjPJzArE4DZOSGxPa9/pmHSHNoVzZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161034; c=relaxed/simple;
	bh=dDcwussPtOcU/2tEN0jlHtp0t7Q8mx5IopeFb9RDcm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GhVPx3gLNZTcCuoZi7ht+J4Dbj55qqhq7ldTzwC3fdhqbT/sNa6NkpD64l7xe03yGzXQQXpQWft6KNfA6SC++n/CtKkJ1r2T2Jo9l3nGta/rT4H1KSkEv/dGfc328TvhJcX3Srd2N83uYH7try6vu/TMfDPKYeTj/yViBcNoYCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NqeRpJIm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NqeRpJIm"
Received: by linux.microsoft.com (Postfix, from userid 1223)
	id EB2D120B716A; Fri, 11 Sep 2026 14:09:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EB2D120B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789160990;
	bh=Z5BYHRojbzYvp+T4LUdSyrCMr6yXtuD1XFpIZRp+i8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqeRpJImOddxShGQf4U2xaHK7fZ7yH1CImhW9uttcgOKD7nUDRhJDQ/jrF6b0gbFZ
	 9c6ouiUNd0IQS7ml/gWJWMg0/7w2doKxSPyqkMMBo4izTGZxg87yOrp3F85yLYyCby
	 Ls7JJyMvfX0XHBllOBRKlcJwp0yzf4WWlMONKdVo=
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
To: linux-i3c@lists.infradead.org
Cc: meaganlloyd@linux.microsoft.com,
	alexandre.belloni@bootlin.com,
	vitor.soares@toradex.com,
	samagazaryan@google.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	boris.brezillon@collabora.com,
	oleksandr.shulzhenko.viktorovych@intel.com,
	tgopinath@linux.microsoft.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux@roeck-us.net,
	Frank.Li@nxp.com,
	jorge.marques@analog.com,
	pgaj@cadence.com,
	wsa+renesas@sang-engineering.com,
	tommaso.merciai.xr@bp.renesas.com,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org,
	lorenzo@kernel.org,
	enelsonmoore@gmail.com,
	rppt@kernel.org,
	pratyush@kernel.org,
	giovanni.cabiddu@intel.com,
	gabewhigham@gmail.com,
	haren@linux.ibm.com,
	pasha.tatashin@soleen.com,
	jirislaby@kernel.org,
	adrian.ho.yin.ng@altera.com,
	ustc.gu@gmail.com,
	jszhang@kernel.org,
	adrian.hunter@intel.com,
	akhilrajeev@nvidia.com,
	tze.yee.ng@altera.com,
	manikanta.guntupalli@amd.com,
	shubhrajyoti.datta@amd.com,
	jarkko.nikula@linux.intel.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/3] i3c: master: enable driver_override for I3C
Date: Fri, 11 Sep 2026 14:09:33 -0700
Message-ID: <20260911210935.1353126-2-meaganlloyd@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
References: <20260911210935.1353126-1-meaganlloyd@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Opt-in to driver_override sysfs functionality for I3C subsystem.

Update some I3C drivers that are assuming that if their .probe is
invoked that the bus match function already checked the ID table. Go
ahead and verify in .probe that i3c_device_match_id() returns a valid
match before using the i3c_device_id pointer.

Signed-off-by: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
Assisted-by: Claude:claude-opus-4.8 copilot
---
 drivers/hwmon/lm75.c                        |  7 ++++++-
 drivers/hwmon/tmp108.c                      |  2 ++
 drivers/i3c/master.c                        |  6 ++++++
 drivers/iio/adc/ad4062.c                    | 10 ++++++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c |  3 +++
 5 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 104149a03bad..0d3c843d1823 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -888,6 +888,7 @@ MODULE_DEVICE_TABLE(i3c, lm75_i3c_ids);
 static int lm75_i3c_probe(struct i3c_device *i3cdev)
 {
 	struct device *dev = i3cdev_to_dev(i3cdev);
+	const struct i3c_device_id *id;
 	const struct lm75_i3c_device *id_data;
 	struct regmap *regmap;
 
@@ -895,7 +896,11 @@ static int lm75_i3c_probe(struct i3c_device *i3cdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	id_data = i3c_device_match_id(i3cdev, lm75_i3c_ids)->data;
+	id = i3c_device_match_id(i3cdev, lm75_i3c_ids);
+	if (!id)
+		return -ENODEV;
+
+	id_data = id->data;
 
 	return lm75_generic_probe(dev, id_data->name, id_data->type, 0, regmap);
 }
diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index 1c4a58855e2d..98076ae8dce8 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -581,6 +581,8 @@ static int p3t1085_i3c_probe(struct i3c_device *i3cdev)
 				     "Failed to register i3c regmap\n");
 
 	id = i3c_device_match_id(i3cdev, p3t1085_i3c_ids);
+	if (!id)
+		return -ENODEV;
 
 	return tmp108_common_probe(dev, regmap, "p3t1085_i3c", id->data);
 }
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index afcd7a21a3e6..42bc9a923d81 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -340,10 +340,15 @@ static int i3c_device_match(struct device *dev, const struct device_driver *drv)
 	struct i3c_device *i3cdev;
 	const struct i3c_driver *i3cdrv;
 	u8 static_addr_method = 0;
+	int ret;
 
 	if (dev->type != &i3c_device_type)
 		return 0;
 
+	ret = device_match_driver_override(dev, drv);
+	if (ret >= 0)
+		return ret;
+
 	i3cdev = dev_to_i3cdev(dev);
 	i3cdrv = drv_to_i3cdrv(drv);
 
@@ -890,6 +895,7 @@ const struct bus_type i3c_bus_type = {
 	.probe = i3c_device_probe,
 	.remove = i3c_device_remove,
 	.shutdown = i3c_device_shutdown,
+	.driver_override = true,
 };
 EXPORT_SYMBOL_GPL(i3c_bus_type);
 
diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index 8e5984055b15..f28b503d16eb 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -1482,14 +1482,20 @@ MODULE_DEVICE_TABLE(i3c, ad4062_id_table);
 
 static int ad4062_probe(struct i3c_device *i3cdev)
 {
-	const struct i3c_device_id *id = i3c_device_match_id(i3cdev, ad4062_id_table);
-	const struct ad4062_chip_info *chip = id->data;
+	const struct i3c_device_id *id;
+	const struct ad4062_chip_info *chip;
 	struct device *dev = &i3cdev->dev;
 	struct iio_dev *indio_dev;
 	struct ad4062_state *st;
 	bool ref_sel;
 	int ret;
 
+	id = i3c_device_match_id(i3cdev, ad4062_id_table);
+	if (!id)
+		return -ENODEV;
+
+	chip = id->data;
+
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
index cb5c5d7e1f3d..153a03e06801 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
@@ -32,6 +32,9 @@ static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
 	struct device *dev = i3cdev_to_dev(i3cdev);
 	struct regmap *regmap;
 
+	if (!id)
+		return -ENODEV;
+
 	regmap = devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config);
 	if (IS_ERR(regmap)) {
 		dev_err(dev, "Failed to register i3c regmap %ld\n", PTR_ERR(regmap));
-- 
2.49.0

