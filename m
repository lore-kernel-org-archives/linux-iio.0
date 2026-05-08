Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA5D37BE8A;
	Fri,  8 May 2026 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233956; cv=none; b=NFe93rmAfeJQTrPU/7UsQw4OUMlk9olvSayxSo3EG327Wg6n+jteFjF06dRLvAJploWuz2swUCFrg3NwGvORcEY9uWwPKSET1gNzSrdOZ7nD1n6z0JX6qJsFa82xhUkD5JpZTEKA0enohtRi+KND3BMMrOT6NgqiYGDR5heUgx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233956; c=relaxed/simple;
	bh=hQjsX+NTjlVcp96hVIMi/EdhSFR0dTjbMqwFNvIXsIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRgdMUzBn3NLEGwjDv5QCKS4E/o/f3AIc5SPekLWPk1NjznOq1hQ4bCGoK5dgvnFrQexDdTjjPlZB9joZkMJey3U50Np4YiK0tC/zlsZfzPnByOLm1hJ7xxzim8MNSaVrGI+dlbTZFd/IWHkeNymngeYy1+wJQuIw+xXeAOcrFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nv+nzy/j; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nv+nzy/j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778233954; x=1809769954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hQjsX+NTjlVcp96hVIMi/EdhSFR0dTjbMqwFNvIXsIE=;
  b=Nv+nzy/j8/V+9zGqbHv5G87zhc9V6aXVL8q4gBiuyS8Rj4zQ4LiLnhw5
   AECB9neAuIPxCpT43UPBdbDkl+S6OdONO4bySv9luKNuZuqBIjR23uR/s
   ll/01jyQ9Ey//3CpyuR+uUysg/AUVb96WEw9EdkmWlVVaIzz7oB08HhCU
   2VXOLGwnyVSgBAfXr9x1+KzEhQW2UA8EZFylmgUdf7OXkjMJ+5XQLRZwY
   RTRIGTyW1dr1/cSupbnIHyjBwEPq7adaQNEok/otPl85l5vdqLyC6Z7wQ
   n0ebXa51tXZfNNLWvf7pfJW1ZCV5SGLz1Kout/+w9y7k3+fbJvpV0Y0mA
   Q==;
X-CSE-ConnectionGUID: FJVY7h0rQrG8hmnvfClIeQ==
X-CSE-MsgGUID: KZtPO3ChSzOY1V7rGEEN7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="96623819"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="96623819"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:52:33 -0700
X-CSE-ConnectionGUID: 5Vv0NwryQn+2myJaRXnEEg==
X-CSE-MsgGUID: zp01J5f3QEexHiPlQl9W1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241728649"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 08 May 2026 02:52:30 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5BA2E9E; Fri, 08 May 2026 11:52:28 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	driver-core@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 4/4] iio: imu: inv_icm42600: Suppress driver_override sysfs attribute
Date: Fri,  8 May 2026 11:42:42 +0200
Message-ID: <20260508095224.1275645-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260508095224.1275645-1-andriy.shevchenko@linux.intel.com>
References: <20260508095224.1275645-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver makes no sense for the devices without associated driver data.
Instead of checking for absence of it, disable driver_override feature
and drop the no more required check.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 13e2e7d38638..cb8c501d86c3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -50,20 +50,15 @@ static int inv_icm42600_spi_bus_setup(struct inv_icm42600_state *st)
 
 static int inv_icm42600_probe(struct spi_device *spi)
 {
-	const void *match;
 	enum inv_icm42600_chip chip;
 	struct regmap *regmap;
 
-	match = device_get_match_data(&spi->dev);
-	if (!match)
-		return -EINVAL;
-	chip = (uintptr_t)match;
-
 	/* use SPI specific regmap */
 	regmap = devm_regmap_init_spi(spi, &inv_icm42600_spi_regmap_config);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	chip = (uintptr_t)device_get_match_data(&spi->dev);
 	return inv_icm42600_core_probe(regmap, chip, inv_icm42600_spi_bus_setup);
 }
 
@@ -115,6 +110,7 @@ static struct spi_driver inv_icm42600_driver = {
 		.name = "inv-icm42600-spi",
 		.of_match_table = inv_icm42600_of_matches,
 		.pm = pm_ptr(&inv_icm42600_pm_ops),
+		.suppress_override_attrs = true,
 	},
 	.id_table = inv_icm42600_id,
 	.probe = inv_icm42600_probe,
-- 
2.50.1

