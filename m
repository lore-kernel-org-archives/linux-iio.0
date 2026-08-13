Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCD5437114;
	Thu, 13 Aug 2026 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786605569; cv=none; b=Va6BpsO9mhLFbDZh4tv7Nxri8jqkgc0Sw8YeJNkJMOui5zJxSYBFk4iQTTYwoU8AWGaSxxmXG5R5KxExOuv8le41ZMSJRi/s8IEt0T8v4XKS2hmGGSfjd8qPLUk6+Z2k2vC06R0oSRRRvIFocc5LcQ6/VKKoc+taKcAD8bxMKnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786605569; c=relaxed/simple;
	bh=4hvBYiay1D+J9xhvewbp0NNHm/SH5Uklb/smhANx+1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lY/js/NNiJUOTMhWmYDSPb5mwwv8ZS4MWV3nZeBpTilcYqG/APN41GltR4tTQRzIpjJMUo0qntmCuJi9NUUT/8tJ7PU2iQajC6iNmdIe9Canxorzhh0hOuPy4XxD9vYpLzPaU9WtOpr6S9JWpnO7P8pS3YzApbvsLr3Kb5G4Vc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlCu75lb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlCu75lb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786605567; x=1818141567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4hvBYiay1D+J9xhvewbp0NNHm/SH5Uklb/smhANx+1E=;
  b=hlCu75lbtk3Zq60NGsv6Q74jLYYoBRX+mnEYBFdleFcBWwTmKIJnnkBJ
   Csx5vhmFxx8iz9EdMS5OMVQhWlkKUWcTSFKrOdY4nBW58+khoB/6O+gDx
   cUl7SNlvR8aaPw9ffO9ovXAUiUJFB9CKaHSfxu0ej68ywrWry3jsRkGye
   nrPYdVOS3NQ+ICXMkCHjEsbDaQ4+XT9S82Gune+8DkvPH/iJf46N04MAO
   ljR1csj8OJ8dGmbuEBDYBwDhwCOD0P4irq4W3cvHY0bt/4N6J/ef2lvRg
   hWYALaBtb+AhBcKTUIUm9WxG5+Nt/Xu4WU4+aw7fuh0nxM+DwlzF5NLJX
   A==;
X-CSE-ConnectionGUID: aS0rMfK/RICCHaU6b4CB6g==
X-CSE-MsgGUID: /l+zwR8hRtakfkZwTtaisQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86936978"
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="86936978"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 00:19:19 -0700
X-CSE-ConnectionGUID: Qv/4OSMlRwetD7HtvguM2Q==
X-CSE-MsgGUID: WLZ0/2HDRGuaA28bhA+JSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,220,1779174000"; 
   d="scan'208";a="268138717"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 13 Aug 2026 00:19:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D492A99; Thu, 13 Aug 2026 09:19:14 +0200 (CEST)
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
Subject: [PATCH v1 0/4] iio: Unshadow error codes in ->store()
Date: Thu, 13 Aug 2026 09:16:49 +0200
Message-ID: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kstrtox() may return different error codes. Allow them to be returned.
This mini-series makes all IIO drivers to follow the same pattern when
using kstrtox() APIs. Patches can be individually applied, the series
is just a union by the subject, no code dependencies are there.

Andy Shevchenko (4):
  iio: light: Unshadow error codes in ->store()
  iio: imu: inv_mpu6050: Unshadow error codes in ->store()
  iio: chemical: sps30: Unshadow error codes in ->store()
  iio: adc: pac1934: Unshadow error codes in ->store()

 drivers/iio/adc/pac1934.c                  |  9 ++++++---
 drivers/iio/chemical/sps30.c               | 11 ++++++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  6 ++++--
 drivers/iio/light/isl29018.c               |  7 +++++--
 drivers/iio/light/lm3533-als.c             | 11 +++++++----
 drivers/iio/light/tsl2583.c                | 15 +++++++++++----
 drivers/iio/light/tsl2772.c                | 16 ++++++++++++----
 7 files changed, 53 insertions(+), 22 deletions(-)

-- 
2.50.1

