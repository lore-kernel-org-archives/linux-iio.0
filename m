Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2970395D9B;
	Thu, 16 Apr 2026 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330095; cv=none; b=PIbckUsyf8kyt6a8aoUbT2aorEkiCzQtwEDsmxqaaqaZb1FjSReMP24NY1blUI6ZmfgugpWKiKv5SrddX4Y8jx32ggLv4+1nVurjkhXXsfYFzjA68aH38CeU/41JbMRu2fhlt7qVTavDqvoDf24i24Bia1CI2SU5LVz0cmiRpfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330095; c=relaxed/simple;
	bh=tgdPa9lFNPFRYrCesyJF59+/fzIw3vwPAUQY6XVDOPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuAugSo5opH7vVemq7nHM9Qq9bAGJjZPE2Sf0vPrrs/Ds06MSfPIsxv29dAbTumM7VRVCpwlxsYq4mnCQGiEtNqRW7XD6+fOqaAsUgGFHWUNw0TiNZpdC+0faQd3Y9cMkCOxwUsYbx1DiOEEiawwuheaG14DiuodV2s/H2aidm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enoAuFN1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enoAuFN1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776330095; x=1807866095;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tgdPa9lFNPFRYrCesyJF59+/fzIw3vwPAUQY6XVDOPI=;
  b=enoAuFN1p06JbSnQN92KxeecWZ/yjLHPSdy/h9qTuovoUl0rDqpkypGr
   NqAjDI0fhN/UcMwH3yihJW6GOsIJcypfLhO+/5dQJrEejaophAcgs9/Lw
   hYiSx1IMMzlf1PKqUy46flumSPRsph1VRjJOcoKhi26TtKSBOxA+M1g3c
   Rtqfk3el9YmDXwwgw7N9+DMWSBmVPyXzn2puOqrbvjR7oO5qQ0/2OUJe0
   Qpqy3cZsz8HFvAb72DegVt7+9WFBkgFkef3B3LOpeLMhuR4Hvfm+d+oRI
   TXJGLnxrWdZlpvqIqfLnVp3SBj2Sx3WmUCm1/g6rTrHCvB99uUghAxaGx
   Q==;
X-CSE-ConnectionGUID: XEq1JjIlS0eTlNcC6HWg2g==
X-CSE-MsgGUID: csVsw2LXR8+Z9wpLQPGRrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="94728373"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="94728373"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 02:01:34 -0700
X-CSE-ConnectionGUID: G/mV/P0aRbqLfEGNXJ9tBQ==
X-CSE-MsgGUID: O4dAmKufQOKUFPSM1DEf2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="227526914"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 16 Apr 2026 02:01:31 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 78DD695; Thu, 16 Apr 2026 11:01:29 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Felix Gu <ustc.gu@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] iio: adc: nxp-sar-adc: Avoid division by zero
Date: Thu, 16 Apr 2026 11:01:22 +0200
Message-ID: <20260416090122.758990-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When Common Clock Framework is disabled, clk_get_rate() returns 0.
This is used as part of the divisor to perform nanosecond delays
with help of ndelay(). When the above condition occurs the compiler,
due to unspecified behaviour, is free to do what it wants to. Here
it saturates the value, which is logical from mathematics point of
view. However, the ndelay() implementation has set a reasonable
upper threshold and refuses to provide anything for such a long
delay. That's why code may not be linked under these circumstances.

To solve the issue, provide a wrapper that calls ndelay() when
the value is known not to be zero.

Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603311958.ly6uROit-lkp@intel.com/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/nxp-sar-adc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 9d9f2c76bed4..705dd7da1bd2 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -198,6 +198,15 @@ static void nxp_sar_adc_irq_cfg(struct nxp_sar_adc *info, bool enable)
 		writel(0, NXP_SAR_ADC_IMR(info->regs));
 }
 
+static void nxp_sar_adc_wait_for(struct nxp_sar_adc *info, unsigned int cycles)
+{
+	u64 rate;
+
+	rate = clk_get_rate(info->clk);
+	if (rate)
+		ndelay(div64_u64(NSEC_PER_SEC, rate * cycles));
+}
+
 static bool nxp_sar_adc_set_enabled(struct nxp_sar_adc *info, bool enable)
 {
 	u32 mcr;
@@ -221,7 +230,7 @@ static bool nxp_sar_adc_set_enabled(struct nxp_sar_adc *info, bool enable)
 	 * configuration of NCMR and the setting of NSTART.
 	 */
 	if (enable)
-		ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk) * 3));
+		nxp_sar_adc_wait_for(info, 3);
 
 	return pwdn;
 }
@@ -469,7 +478,7 @@ static void nxp_sar_adc_stop_conversion(struct nxp_sar_adc *info)
 	 * only when the capture finishes. The delay will be very
 	 * short, usec-ish, which is acceptable in the atomic context.
 	 */
-	ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk)) * 80);
+	nxp_sar_adc_wait_for(info, 80);
 }
 
 static int nxp_sar_adc_start_conversion(struct nxp_sar_adc *info, bool raw)
-- 
2.50.1

