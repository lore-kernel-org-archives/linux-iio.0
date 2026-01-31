Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964781F0994
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769863153; cv=none; b=s8ykQ2BUtD1/B4amtRAitjUgq267Sg6jZje2zc7k28Wdl7KyJQ7b8+TSreIvD6vPZtcdT6zn3pleleB+2cmXhqvfoDgwarbSJg2nDLv5xPeLoD9/4qLqc9W/94EWDUuzTGkRPGIiIc9wiT1dsxsoOtm/j1/wakMz27tYmmVGy2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769863153; c=relaxed/simple;
	bh=vh0k3oSdIfCAytUyuFuf5LPsTWD2+vzP5ikdVRXOpyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgf7dFBL4mDehWwWyTOHO4wdYc+WftrUzFEcf29UMz3VkNNnbAMkFneuVUqEW62hxb6G+5WHF3ryQ0oOWKSsfYYT1d8jHGI7zaV+vaJL/Y6IkFMgXGjjjAN7n6FdSiXkjotVvlhrHOEFEnYVBQwTypj9vHdQQBe1oFb1bvWF0LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buXEWSFQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buXEWSFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D191C4CEF1;
	Sat, 31 Jan 2026 12:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769863152;
	bh=vh0k3oSdIfCAytUyuFuf5LPsTWD2+vzP5ikdVRXOpyc=;
	h=From:To:Cc:Subject:Date:From;
	b=buXEWSFQ8kjINnepnJnUnKNKk3bRn/mYwBulzLoI73nPCAI69ky6CqSRi2YYcb7yA
	 vPQbGbJPerktaHYoUcRSaSO/cF4ouKIz9JEOqxLrSZtTHlnXnFpaRbwwnLP0Fw/xhZ
	 He7ZVjHlay8rBlBKvFF3PvrqOC09E9/hp9YNtcKHlggEnwDzJp3oI2SkLOq9FmV5ov
	 AH4TtEAp/8pKJUAgqkOpRwhS7V7xhDNxeDVD+Gk9Sl+e4t3mV/5zSU6HciJy8ellY3
	 Hd+59hQbIWJR+me2QtZn/AF93q43SxR7sftQfIPcbPpkl5hF3wXGUJkSfVtnbUcFoL
	 zmSBGqg7QXzaA==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: magn: mmc5633: Fix Kconfig for combination of I3C as module and driver builtin
Date: Sat, 31 Jan 2026 12:39:01 +0000
Message-ID: <20260131123901.227952-1-jic23@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>


Fix based on similar fix in:
commit 83b645ee43f7 ("hwmon: tmp108: fix I3C dependency")

Note to keep things simple I'm now requiring I2C.
That can probably be relaxed in future, but I want to reduce the test
set of builds for now given this is blocker for the main IIO pull request.

Fixes: e559c8641460 ("iio: magn: mmc5633: Ensure REGMAP_I2C / I3C not build if I2C / I3C is not.")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601310904.DueZdiuY-lkp@intel.com/
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

Note this is already on the IIO togreg branch given very short timing.
Any review much appreciated!

 drivers/iio/magnetometer/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 2b81b22c9550..9345fb6d5317 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -141,9 +141,10 @@ config MMC35240
 
 config MMC5633
 	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
-	select REGMAP_I2C if I2C
+	select REGMAP_I2C
 	select REGMAP_I3C if I3C
-	depends on I2C || I3C
+	depends on I2C
+	depends on I3C || !I3C
 	help
 	  Say yes here to build support for the MEMSIC MMC5633 3-axis
 	  magnetic sensor.
-- 
2.52.0

