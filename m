Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AFB175A99;
	Fri,  8 May 2026 06:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220625; cv=none; b=IsJtbNGMdfJu0MOiVlvqRPdjDTgxjOI1iUp6SdYN2SLliHI8NR8EHlqB+uNcjVKAt0UpQlcUtOaygbzmubyhqax19uDUGa/r9RfaG2tngzk+6C9ER05n9IdlP24LZfSC/0i66l718pWKfZ6Cea25k/GOZw6m6zvzDjRWCMbsRTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220625; c=relaxed/simple;
	bh=YtpwilWHn+Jai8nr2ZcRnl9AbkjZQD5H+Kq823ld2jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8QbbGJ8AhydHIqsf3ADvftfOznFCqS5PWAeBL6RBAL1+nh9UwQuEBUheYbrHdg7gqGy4EPtXbaU5nPfydEQ5bwm17T1d/uqoHfjpL4/WBhVjicWbgG87Y2MilvWQUi8bYsAH3Jm6tQtRTGwVvtSqkzYHMFH7PkFPiyuzS6A33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/IRvhik; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/IRvhik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778220620; x=1809756620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YtpwilWHn+Jai8nr2ZcRnl9AbkjZQD5H+Kq823ld2jE=;
  b=m/IRvhikUavpxrheTg4/UoCOjhZN7mg/OlDcy0jLm8TBKPyoB2rwM4i1
   loMyy9fDx1ddurRLaUGf0Qr8MpbaBA+vul6x/ZV+87A3ewE99T87hJKq8
   ibJ+Ar7aQG0z87aeH/9BZKFRJEyM5vf/2c7DALcmvKasLafeGg2SoMReX
   kgKcTPNlTPzUJ9ynvj2wWpbS1gCq9MJma9LrTfgASDPrNfdVzhi5FY4pl
   jJf96hUFPncBmJmxosZT1s2NEvyJdDpyJ0d4MQR+yQqC7rwWewBn51awY
   /o8JQmEz1BVePX8bKohqYMy3F8DuZyQZwwRgZSFYfqITHGmUglCu4x4Yf
   w==;
X-CSE-ConnectionGUID: 92Ea8NhpTSCG/0TBdUkL2A==
X-CSE-MsgGUID: m/R3ePRKTiyfK6X43JLiaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="83031372"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="83031372"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 23:10:04 -0700
X-CSE-ConnectionGUID: jKIPV+YWQZ6ro8TuQJwIiw==
X-CSE-MsgGUID: 7O4N+oaERgGnN1b3sVlsPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="240669063"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 07 May 2026 23:10:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 15B8B9B; Fri, 08 May 2026 08:10:02 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] iio: magnetometer: yamaha-yas530: Use devm_mutex_init() for mutex initialization
Date: Fri,  8 May 2026 08:08:34 +0200
Message-ID: <20260508060958.1086818-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260508060958.1086818-1-andriy.shevchenko@linux.intel.com>
References: <20260508060958.1086818-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_mutex_init() since it brings some benefits when
CONFIG_DEBUG_MUTEXES is enabled.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index 2ed0d1b93985..d6efa8a595b0 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -1405,7 +1405,10 @@ static int yas5xx_probe(struct i2c_client *i2c)
 	yas5xx = iio_priv(indio_dev);
 	i2c_set_clientdata(i2c, indio_dev);
 	yas5xx->dev = dev;
-	mutex_init(&yas5xx->lock);
+
+	ret = devm_mutex_init(dev, &yas5xx->lock);
+	if (ret)
+		return ret;
 
 	ret = iio_read_mount_matrix(dev, &yas5xx->orientation);
 	if (ret)
-- 
2.50.1

