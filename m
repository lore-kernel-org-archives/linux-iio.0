Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A534A374E6F;
	Mon, 27 Apr 2026 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320870; cv=none; b=MSbl6XLz4H0coEKZiMKdwpu770wQv2xH1LJnRhIyu1pcdeipc3pXX4+FDeykSkzmmB/WreOcmhIDGdr9p/XU0h1RyCon3C1o5L/fPydXOumz9z89+p1Qbx/Q2+acBwsjpNs0BwiJJ3u0+XMyAtbHLpOLDn9WJgyydo664AEiUA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320870; c=relaxed/simple;
	bh=JztD/4jQB7bnX5nFIToIiwdz0tTeOpMBNe7z3mvFR8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=piLNe4A5T0OneGKSJMzpnp9yd8HLkEUMWyKIPh2GfGVT2dTz3AMghpYU1Z0AHzitTCxKIrsloVnUlOOXYNGMDSBX60iypuEOSUmjj/Y93VeEiT/FDXQaJd/zu1lcfrHr+Ra1ySwwuNr12tRSIpFaqwthwqvC5kkM7k/ZzLaefnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMmV7RSc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMmV7RSc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777320869; x=1808856869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JztD/4jQB7bnX5nFIToIiwdz0tTeOpMBNe7z3mvFR8Q=;
  b=cMmV7RSc7ZvdeXlVvvRtJXjwIPXYQRu0Rjob1HkawDBLtdqQ0js8HDWp
   MNLyZ74J1Cv7zPeN1FcdjS3A1m8nXcqndh3WQ/aCqxPWJlhWHDTEhyHFu
   RpdYI3Xjz56EeOHkNo6bXidtZrBNwGycpUPrLO+Nj23yQiJe5Fl8JumFV
   4JpQpiK97KuZpzFljCM9b0rS3yf5VrUjJgmvP6yxjkMwcpP6wrWrW/+eF
   +hV8WuKkc98rp9Dw2wxA4Xafq/k8cUrFbnbY8G3o8U2WGZO3+SH/eDrPt
   TV9BPMpk0mUcGxvUqEO6qe1EAbgSsRVTCs3NJDt9pvijSlJ7Z2ybBbFJV
   A==;
X-CSE-ConnectionGUID: wsnKYp4qSXCOszuwZVBUjQ==
X-CSE-MsgGUID: dhFa//MES0u8zv+jyCf3Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77384113"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77384113"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:14:23 -0700
X-CSE-ConnectionGUID: DhWRuzd9QBSIlvtvDBxZPA==
X-CSE-MsgGUID: VCkXpuCvR8qmBMYP3K3fTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232857727"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 27 Apr 2026 13:14:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5C5079E; Mon, 27 Apr 2026 22:14:17 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v0 05/14] iio: magnetometer: ak8975: Avoid using temporary variable
Date: Mon, 27 Apr 2026 22:09:50 +0200
Message-ID: <20260427201412.3067235-6-andriy.shevchenko@linux.intel.com>
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

Avoid using temporary variable in ak8975_read_axis(). With that being done,
the clamp_t() call becomes idiomatic in the driver and can be factored out
to a helper later on (and if needed).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 53987f3b13d2..b70fbef1ea3c 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -729,7 +729,6 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	const struct i2c_client *client = data->client;
 	const struct ak_def *def = data->def;
 	__le16 rval;
-	u16 buff;
 	int ret;
 
 	pm_runtime_get_sync(&data->client->dev);
@@ -766,8 +765,8 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 	pm_runtime_put_autosuspend(&data->client->dev);
 
 	/* Swap bytes and convert to valid range. */
-	buff = le16_to_cpu(rval);
-	*val = clamp_t(s16, buff, -def->range, def->range);
+	*val = clamp_t(s16, le16_to_cpu(rval), -def->range, def->range);
+
 	return IIO_VAL_INT;
 
 exit:
-- 
2.50.1

