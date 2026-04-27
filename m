Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE834D911;
	Mon, 27 Apr 2026 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320866; cv=none; b=hz6rpS4F4Tve+6YyS6B3LLoRqbyjwPacewKD1OuGBD8SBByKBmg5b8Xqaqwz5Cc96Kich5bG34gWoFX+ibnCNEKyl+5w5S7/IKDiwS03Rn9pZDpPo227txWqdk0sY7YwnZRO5/IIwOi/sFfwTXesj0J97VyXTSRfHjzrO/LC/wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320866; c=relaxed/simple;
	bh=RtKsKY072NESOXa+UJHijk0YAKoJeRw9V3ZqEU5r3D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ls+D7dpmc19rmNcwR0EKAF+x1/35RM/z/dQsCijijZdCaN2Gv1aksM/Ikgd4V1a3q7A7zPMMRoPXLth8YM/1yvNvb1othttOOhUGR8mBGKK8XB0WmSTXPF+ejFwgpo6uoeuDPxMBhnN2V2dPbIwwoVf2ZL8tE5p8MvpOrx+/Ers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JH3vY087; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JH3vY087"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777320865; x=1808856865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RtKsKY072NESOXa+UJHijk0YAKoJeRw9V3ZqEU5r3D4=;
  b=JH3vY087qZrIWZ2C38GMDuo12C5FTpvPrDG13yQec1/O00+G/vO/upL9
   4H03/Mjw/7Mr9nQjk5mpNW6tQ8AUK/85qIb8GaFAtuomwugU6ZAc/yxvA
   ErPTsB1zaoSxkZ7f4/PthEJyMwptxkSW2FrHBtXC2q9GNIme0XfuH4el9
   2TbQdiDdwC/K49OwAYmLgk5L2uOb9o91VaIq/cdXpMUO1lZ6X/GTAVppE
   EWqYMGstWUaRwrt22Ax29LVS9sI+lAC3pgyMB3zvFJrLT9vVg7NW1UOrG
   4BGtHACff2fxhKv8XlfrF8PNnc49DnPo91Qvf3Ri9l9ta9PelB6tzzwa2
   Q==;
X-CSE-ConnectionGUID: UXVB13pxSmCU6Wk+FVArnQ==
X-CSE-MsgGUID: f1WPfSW3RPm61MLUEUd1Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77384091"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77384091"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:14:20 -0700
X-CSE-ConnectionGUID: cK/OvxHNQwiLrHLNv/zRag==
X-CSE-MsgGUID: 0Sg3G9prTpubkjAryyVxQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232857722"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 27 Apr 2026 13:14:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 539AF9B; Mon, 27 Apr 2026 22:14:17 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v0 03/14] drivers/iio/magnetometer/ak8975.c: fixup for the iopoll.h conversion
Date: Mon, 27 Apr 2026 22:09:48 +0200
Message-ID: <20260427201412.3067235-4-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 833ee7ca9f46..4cc92a15e937 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -657,8 +657,7 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data)
 	int val;
 
 	/* Wait for the conversion to complete. */
-	ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val,
-				 val != 0,
+	ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val, val != 0,
 				 AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
 				 AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC);
 	if (ret)
-- 
2.50.1

