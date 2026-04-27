Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BEE34B1B0;
	Mon, 27 Apr 2026 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320865; cv=none; b=Piutz58AoN2NTrJLHt25tUjFT5aRoflMM17+sjOw4JFph7dBqobrH2nudMyFno5Wj6eWGKOXRlJL4hs5hqLnRRYxMF+5yXll7GUtaf7flpo1PIkiNpo7GWGq1KvwKB3YZ2b8TWVm44Ih7ZO7IC/VeOSMsEWS9GfZNmm39/rcavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320865; c=relaxed/simple;
	bh=JIGf400tD/IcjdcJvugGuEpXAmyKM8a3/jJ8QYWNqcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI8RpLp3Wlble7Swt1uPI8WHn7+KeMLJCEM2oBD/Moc6sUFuEoYoxxAnlBodziNd+4jAEjXw9MXI3KuQi2PcVP/Sc9lXioPji5/dwE5WdZG8PV/GsGj0sMqJMome8LgIIgbEkQF3zyhTJn/vo+85+m6g0LrPuSNjHGmeFmxD7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpnrfx+7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpnrfx+7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777320864; x=1808856864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JIGf400tD/IcjdcJvugGuEpXAmyKM8a3/jJ8QYWNqcg=;
  b=bpnrfx+7NUG8Fo2CVWZzwcXDxaP2UOj98qvY4qn5Rx8JyUTtijoAsoSt
   1hkwgsHilSfe5wfnBbWt9P+pfHje0n74NYAPzt0/l4daFL3OR1zl92P0i
   +zKtvGjI735lh7LK3VnEyEtj5OeYSUuQSApGGzcK08JAZqWw2it5gUNSF
   kQVTcus6PJzQgYlSk0iQoA5vgcggqbnCRbJofSqieoEAwjA+nPAxF+Ncy
   wy/6iU6aBNKaMTRvwGY6w+E/gHZRZlidQnPsO0ZmOs3mFjDu73+YotZN9
   w6oPHEZsdYj3pzEuDzTcFZT4LRbMRc2z9swCl/GGMC6PxV1+qBCZ03+4n
   w==;
X-CSE-ConnectionGUID: C+xpYjKbQHmQ91CFJKvIuw==
X-CSE-MsgGUID: gXlTgODPQ2ytSW8Wx19x/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78138353"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78138353"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:14:23 -0700
X-CSE-ConnectionGUID: pIrw6MJERYihgyOOZAz/7w==
X-CSE-MsgGUID: yR3F4St0R/ugveSC6nZd3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="238074769"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 27 Apr 2026 13:14:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 60DAFA1; Mon, 27 Apr 2026 22:14:17 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v0 06/14] iio: magnetometer: ak8975: Drop duplicate NULL check
Date: Mon, 27 Apr 2026 22:09:51 +0200
Message-ID: <20260427201412.3067235-7-andriy.shevchenko@linux.intel.com>
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

The gpiod_set_consumer_name() is NULL-aware, no need to perform the same
check in the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b70fbef1ea3c..288bdb3bf14b 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -906,8 +906,7 @@ static int ak8975_probe(struct i2c_client *client)
 	eoc_gpiod = devm_gpiod_get_optional(&client->dev, NULL, GPIOD_IN);
 	if (IS_ERR(eoc_gpiod))
 		return PTR_ERR(eoc_gpiod);
-	if (eoc_gpiod)
-		gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
+	gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
 
 	/*
 	 * According to AK09911 datasheet, if reset GPIO is provided then
-- 
2.50.1

