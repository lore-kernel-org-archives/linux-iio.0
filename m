Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A438423A;
	Fri,  8 May 2026 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233961; cv=none; b=Vf4+ROKMjBi2rIJ0/dLvdsxJblUw124Qo6if/DEsEVUB6Hj8JcoowmTM/jkszU4WqTh3HBFSOnbK2GHqPict82HGlbvSuNO9sTciVIIi6eNH5lzGZx0oLZn+3dfEe7/eJx3xjyRMxGuMBc+r6WYvNeeYHGP6FbQWkafipHpB/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233961; c=relaxed/simple;
	bh=zi2Eq5Nx9ILrXnLAdjuej3Tr3Z7lDXPzlUP/KHyHTOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdGcau5oDW6TrSidK8fmCIG0OQl0d5OV/QByLCpS/wYoLnBCqf5ThHXyU/5Zi8CFb+I40JXQMo9cum18pw1TSCeTBRwBw0FJhZagGwLdVeQCltn+/MpQY6XJEdp8MR4K6dRCGd2pKWIAHbUo6bkgJsqyBM1Tz5HGDBe99Hu0p4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfxXGNfC; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfxXGNfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778233958; x=1809769958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zi2Eq5Nx9ILrXnLAdjuej3Tr3Z7lDXPzlUP/KHyHTOU=;
  b=gfxXGNfC2ePMRUDeKMI5pzDv03dkZyy/IUosNOcj2j37E4+lOdktUlGm
   rt8jJdUypcN9q3x1f9m96r/7USML5K8ZKpbiwwLLZl5/9NGuuRXSrUC3M
   PNg4D6+QRyzFmKXShHvFeqjxtwFMfOlDxK32bmc0K7yUigWsN4DIm+FOc
   gdiJF+VEL/HLiveu/hj7mVBC2DlsbnSXZ5MXlfLffvz9qsfU7xe6EUZks
   90tpsYxkyDxnChgKJmqt/JKHy8mYXBEWWxUGlSdA3Pq/ADpLMCzMofexH
   0Ozu1qLTKJAAYe+Q3EytScKMuzJSYk6d1z65r8LhWaDhRoH9idGCZKrvc
   g==;
X-CSE-ConnectionGUID: Op959p38QaqgPpJd7ufsQg==
X-CSE-MsgGUID: wKYFKm5AQpSqIZIBkV4m7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="96623827"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="96623827"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:52:33 -0700
X-CSE-ConnectionGUID: HpMymi5ESJOEvOzUxWozMA==
X-CSE-MsgGUID: QCGJySUfQVWeYOq0/TZofw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241728648"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 08 May 2026 02:52:30 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 573E49D; Fri, 08 May 2026 11:52:28 +0200 (CEST)
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
Subject: [PATCH v1 3/4] iio: imu: inv_mpu6050: Suppress driver_override sysfs attribute
Date: Fri,  8 May 2026 11:42:41 +0200
Message-ID: <20260508095224.1275645-4-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 1f4c62142b60..bdd4ba4e117e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -46,8 +46,6 @@ static int inv_mpu_probe(struct spi_device *spi)
 	} else if ((match = device_get_match_data(&spi->dev))) {
 		chip_type = (uintptr_t)match;
 		name = dev_name(&spi->dev);
-	} else {
-		return -ENODEV;
 	}
 
 	regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
@@ -175,6 +173,7 @@ static struct spi_driver inv_mpu_driver = {
 		.acpi_match_table = inv_acpi_match,
 		.name	=	"inv-mpu6000-spi",
 		.pm     =       pm_ptr(&inv_mpu_pmops),
+		.suppress_override_attrs = true,
 	},
 };
 
-- 
2.50.1

