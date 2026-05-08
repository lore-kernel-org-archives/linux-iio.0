Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B86A37472D;
	Fri,  8 May 2026 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778233960; cv=none; b=LC1s1ZAXvJNiYI5roOuzAm2SbN1912SHa2WJX5SZE3nbkX0VzGcCqQmbMXAKNHtVsJHubosLcvYBF1z69znW50niib9dAVVK2E4MXsSFK5W/y25s+Tx/hAKBpPFRDogAKYnLiHqpTeQRui2FaozDMlakoO90Ltqv1Jz57kwf16E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778233960; c=relaxed/simple;
	bh=tcT4Ke3eonYhGbRY7q/wz2GsdpR5v03TooPgQ/VT3So=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bGBV1bqhtGDyMhl6cWXtLi9IypDAeXRc/mGSCEalVgOG2ui0sL/fDOo72CA1VY56n3KKzg2bVTLApXl4BiJDyac0H2ac+IfL9WommGscl3ODfj6g8mERoSQxmMTkfrYg4HYkzH/iAMKBqWKsHU5clbfGSNbyKtW+Yp4p2X/+1c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+QsifVr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+QsifVr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778233958; x=1809769958;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tcT4Ke3eonYhGbRY7q/wz2GsdpR5v03TooPgQ/VT3So=;
  b=a+QsifVrt6tT03BVYOfHYLQxjeFNrToi9AZ+NG/aE5h85a6XR5hhtAEj
   scLBTYAK5AkSHZ2JGRCwSU0pO1ASwxETDikgdC7YMJfMyJCc382p9ouvL
   d4NcbObRnI0kny+vihDfovKnBgg6OdvlnRQYq8PyJdB2dSm9fxdH3JpCI
   gM3x0CVtiJpm/tb2foCYyVVAe3BAs8zsmHFEcYRyZF+/pgGcU5gtmjk0u
   J9bEDZ5E7Ru/ahjbwZiMl2IWLBe70VgPOrE4jaJvJBalT9Vb2UHavArLl
   enbsBkt6JezjXVNhiLeO1K9FsJpGRqqcK3AcG7k5qFYQAJ1xHHu921J6M
   g==;
X-CSE-ConnectionGUID: 33dyqCVzSFiV158dCTEJiw==
X-CSE-MsgGUID: g/yOWTQKSMaLXCXfeD+AaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="104659529"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="104659529"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 02:52:33 -0700
X-CSE-ConnectionGUID: 44ayaFGvTg6nqP32p7SG/Q==
X-CSE-MsgGUID: /Kk7z0f3Qe+4X+3NVhkh6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="235740003"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 08 May 2026 02:52:30 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4C08398; Fri, 08 May 2026 11:52:28 +0200 (CEST)
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
Subject: [PATCH v1 0/4] driver core, iio: suppress driver_override
Date: Fri,  8 May 2026 11:42:38 +0200
Message-ID: <20260508095224.1275645-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently Sashiko started reporting the missed NULL check of
spi_get_device_match_data() or device_get_match_data() in SPI drivers
in IIO subsystem. It appears that the way to crash can be made by use
of driver_override sysfs attribute. However, many drivers, that may be
instantiate via ACPI, OF, or, in some cases, user space won't work
without necessary driver data. These are, e.g., most of the drivers
in IIO subsystem. Trying to override the driver for the device that
has no matching entry makes no sense in such cases and might lead to
a crash, when the driver is not prepared for that.  Instead of adding
a NULL check for driver data pointer in each of that drivers, effectively
meaning a dead code for normal functionality, introduce a special
attribute in the struct device_driver to allow drivers just to hide
the attribute for good.

The last two patches are the examples of use and code simplification
at the same time.

I consider getting an Ack from Mark for SPI, and from Jonathan for IIO
and route this via driver core, while providing an immutable branch/tag
for the above mentioned stakeholders.

Note, this doesn't change the state of affairs for some busses that
do not have driver_override flag set while using custom approach.
On a brief look it's the s390 crypto case which may not ever need
the above and hence left untouched.

Andy Shevchenko (4):
  driver core: allow certain drivers prohibit override via sysfs
  spi: Support suppress_override_attrs flag
  iio: imu: inv_mpu6050: Suppress driver_override sysfs attribute
  iio: imu: inv_icm42600: Suppress driver_override sysfs attribute

 Documentation/driver-api/driver-model/binding.rst |  4 ++++
 drivers/base/bus.c                                |  4 ++--
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c   |  8 ++------
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c         |  3 +--
 drivers/spi/spi.c                                 | 11 +++++++++++
 include/linux/device/driver.h                     |  2 ++
 6 files changed, 22 insertions(+), 10 deletions(-)

-- 
2.50.1

