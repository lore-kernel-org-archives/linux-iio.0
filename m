Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E45B3B27EE;
	Tue, 19 May 2026 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227773; cv=none; b=fVZideRG/rA4vB/UB//g+EqvD5L/uu//SaaZnNK+9ynhkEiQulun5wfShidMJffjsPApSofPbqA99sc0dehTta7TdpbEAaskHs350tdhZHAmHeGJQAbVl5ZLAFpQ/L5aYXHOtc1OdzcI9geFFwnjANwqf+P8C7NCSdMKMmdK+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227773; c=relaxed/simple;
	bh=hHC34WG+yWQsQ6hrIRiVxRKxEqVcMk/WUVS+PLqD9fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=md7WNbCAk6e9WBrNRzNnakqGEttJ2thLMILcCYumD4qN+y8zYvDpzurVDHZmq4Jx1lfb07CJwDze3+3YlrDw0ZgM1ZhygJR8Xm0KQYmlgCXfxzVyUjulaTb1nfelUKUIFHlp8JQAm3mcIr7o7q7MqeyAshBWXyKDJ0paHGQKRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7ZvGq7+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7ZvGq7+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779227772; x=1810763772;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hHC34WG+yWQsQ6hrIRiVxRKxEqVcMk/WUVS+PLqD9fc=;
  b=T7ZvGq7+VaOZX2B2b55BaajRQu63GuiSvqA7h6xzjWzb4SolvWzA1jXF
   8Wm45iSwuSQiO6VBPlF7uXCd7/xCxlb9UWq/Gl4SDrs72naUvPEzCFIf2
   XAb4oO33skCuIz+RbdYnfMkMwGdr8QN51LwUryw63bYfMfXikTiwQQsyk
   8Iw/6gf8Th2n4m+pfxOenemEPu5h79hD34jWlUtkQi3RPGVyymGxhE90R
   VK5xqgMPqh1mpquuxBtaoQjjU7Y90rsL+CMtihwQ/DHBVQN86NXT8PAJi
   FM4LysYR82Vpxe5ueNhl4RHeJfDcYO2vJwqkgRxAV6eLsBSwSM+ePcqka
   w==;
X-CSE-ConnectionGUID: qjmRherERoKH5ve1gqR5Zw==
X-CSE-MsgGUID: v2X+bCYOQX6a+IWYbbF4Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80235429"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80235429"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 14:56:11 -0700
X-CSE-ConnectionGUID: NS5nDLulRpaDnz5Lw57TNw==
X-CSE-MsgGUID: jU4Nog8nTbixQFsU+J9Z2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="241735705"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 19 May 2026 14:56:09 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 5FBE195; Tue, 19 May 2026 23:56:08 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v1 1/1] iio: adc: nxp-sar-adc: Fix the delay calculation in nxp_sar_adc_wait_for()
Date: Tue, 19 May 2026 23:56:06 +0200
Message-ID: <20260519215607.78241-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original code was using ndelay() twice. In one case the delay
is calculated as 1/3 of ADC clock and in the other as 80 ADC clocks.
But according to the comments in all cases it should be a multiplier
of the ADC clock, and not a fraction of it. Inadvertently
nxp_sar_adc_wait_for() takes the wrong case and spread it over
the code make it wrong in all places. Fix this by modifying a helper
to correctly use the multiplier.

Fixes: 7e5c0f97c66a ("iio: adc: nxp-sar-adc: Avoid division by zero")
Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260416090122.758990-1-andriy.shevchenko%40linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/nxp-sar-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 01f3da56e987..68d237ef30c2 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -198,13 +198,13 @@ static void nxp_sar_adc_irq_cfg(struct nxp_sar_adc *info, bool enable)
 		writel(0, NXP_SAR_ADC_IMR(info->regs));
 }
 
-static void nxp_sar_adc_wait_for(struct nxp_sar_adc *info, unsigned int cycles)
+static void nxp_sar_adc_wait_for(struct nxp_sar_adc *info, u64 cycles)
 {
 	u64 rate;
 
 	rate = clk_get_rate(info->clk);
 	if (rate)
-		ndelay(div64_u64(NSEC_PER_SEC, rate * cycles));
+		ndelay(div64_u64(NSEC_PER_SEC * cycles, rate));
 }
 
 static bool nxp_sar_adc_set_enabled(struct nxp_sar_adc *info, bool enable)
-- 
2.50.1

