Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2035F8C5;
	Mon, 27 Apr 2026 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320865; cv=none; b=PMTq4hLdpBGbN9SEolECUgKxw3XT2t1VvizeyBCrcNLitilae4sMIsxltazw0aLnUcGiGSWN+JEWiVuq35sE8B27hJGN7ErpDDUVOKaOshflYOVw4jkeGhSWbMKqm+8Z7HvTLFyO07ZdjXeXMrbXJ+cGOLptVby8mE9eM2f7o2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320865; c=relaxed/simple;
	bh=QYgEMYbhm3EK8rVSz7/6YWVSQPkpF5v5THgixu78Itc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAelL75MgTD6oocyxwVaTvM2LrD67Pe9I7Nqfo1qd3z2HhyktJtI9H83baiEl8K9xqepSCsx0rE0KGTxn9e+4isHUlGJtw3iJifDUd8vGJWlnuMX0OI/1lUdtfzWLJg/cVE5buHJy0xLmy2gxn+3i5HvefKEW/dzdOW+3+5q28k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDH1pqbo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDH1pqbo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777320864; x=1808856864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QYgEMYbhm3EK8rVSz7/6YWVSQPkpF5v5THgixu78Itc=;
  b=oDH1pqbohUN2qUxNv1slvlD6l+PAGmghPS7hxSmlASItoxkeLy6m/UKm
   kmO5g3aSp4gDvNdv18sykcBMOAniL7NK/UL5GX4xdywxzinVWGzt48jRU
   Wg6jcvq1iXrRp93lcg2/o30b+XTK07F950L6NOhW35ADINb5zBhV0L6Ci
   nrvigX9AmuVMGc0yHgvtGkq6LBU3pc/hiot3+dqg3hMgS5H1XBTCjIJrS
   laJm8S6phwTEA2PvpNJqn924DIpRuVdr111W7+IB6VKz4GBtee6oEqjye
   Kb7gQW/TBgjzlI3PDrg+qRfewIBpDbGiTrCHdrVPgz0R6knrFz/Xa5DyK
   A==;
X-CSE-ConnectionGUID: pi8Ob+5fTGuPJYlAGxTZ3w==
X-CSE-MsgGUID: 9FF5810QSGWK5zrz35UH+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78138358"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78138358"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:14:23 -0700
X-CSE-ConnectionGUID: OxEHzRWuSG2ULTBKKvS39Q==
X-CSE-MsgGUID: QzTHqTVJQtugm5yN4Bkr0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="238074772"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 27 Apr 2026 13:14:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 656EEA2; Mon, 27 Apr 2026 22:14:17 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v0 07/14] iio: magnetometer: ak8975: remove duplicate error message
Date: Mon, 27 Apr 2026 22:09:52 +0200
Message-ID: <20260427201412.3067235-8-andriy.shevchenko@linux.intel.com>
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

The devm_request_irq() already prints an error message.
Remove the duplicate.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 288bdb3bf14b..dbaa64c66e4d 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -584,17 +584,14 @@ static int ak8975_setup_irq(struct ak8975_data *data)
 	rc = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
 			      IRQF_TRIGGER_RISING,
 			      dev_name(&client->dev), data);
-	if (rc < 0) {
-		dev_err(&client->dev, "irq %d request failed: %d\n", irq, rc);
+	if (rc < 0)
 		return rc;
-	}
 
 	data->eoc_irq = irq;
 
 	return rc;
 }
 
-
 /*
  * Perform some start-of-day setup, including reading the asa calibration
  * values and caching them.
-- 
2.50.1

