Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792746488;
	b=I0nUu0Bv6Y5p/vYx4eYH/t/zxLAUE4A+aE5eYqoN3dkcBCokzDm6zZp6daU0GHkyhnH1
	 VBaTZvqMRVPw1vfeHvnWUpn6hnj0T9oPKCh1PhRxt1LaKIApOkOaaxd9/lArKKG6Q84zE
	 bglNgGliEVVUtxgvEWLfIy0DVHtrcdCctJOwMAcREawLcMKnlUl6f/7MnJA6brGggqYgS
	 5d8PmjQe+8AJGg0SML4HrN3NRjvUS7/TGtWJnBD9yNilIXDoEbzDKYV0WwJbGDUU5Pv0T
	 0lSanadUw8YE538WIQHcyN0mBPRlqJWXmMKG/i/dXFaimyGcD+Xvf9GGVDLk8hEmjgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792746488;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oj5plAiDhvkLrgl/yO16Ihe/4KJIUvPcCw3wCr0eQ18=;
	b=Fu3wrMxtjD2vJ2AhjA+MWhc+mwgLg5uEKAefyaPLiGgRACuJLGoDhc+oXgxiYWpQcgcJ
	 SKdqT8hXYNiPbrKiwzYb1nz728PVrhZpMtVJ6Vk5hupsiKIAjn+mnZZzOlH2Jo61zNje6
	 3DraLfYkF02Eg07gGSJiXk6pZj1ZeITfMUrwxz+qTRCI6aeVvWjrquA4iVSTaNY1Zns2l
	 BIJbo+ndTGDLIanu8Q6FsG3eBy+dNF+bZWm5LgfasnK32CyYLr2bxLnIm38QVbA92yXo3
	 23Ez19PJJYS3dJ+ewezepDLx9D7iuFFEStjpImJzuRfQkNTqaSDVutOIC1KH21gDY0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cBPdpRzi;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523EE606A31D;
	Fri, 23 Oct 2026 09:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 523EE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cBPdpRzi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792746488; x=1824282488;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=82KH3JHj6m6tzFsEqM7OoWpk3yXnB9iS/kKLxps8Vzc=;
  b=cBPdpRzi8tTzSsjpeo38NJcMS17JnVNw2ReU9ZyABNSQxGpzJ3DGbPPA
   OsyiELRbQ+Vh2fZD63f/m9X3D2qYNwy2+nUpwmQexmoGFApexEiGaaKC+
   iq7kSdeme4sLKZ/G+pZKGPt8VGN5fcXzyEZewG/p+u8/V4tcKB36MUoFq
   kz6CZRSb1fg1uRX1QZUl347n8EnQccjxF6qqdFGv3qNdGVRkkMtMjBAnD
   HcHCFpAIYWfvyL9TF9t1fK6VKFsKKw4E8jiE0NHjEAJ+SjhnQbjmL1+eR
   OYNsjuAIw8rb8fv+sHFfLftP+5P5X7FDoXG69M7EM8zWAidT1ks7cVEFK
   A==;
X-CSE-ConnectionGUID: id3Ig3kyShiwOS76jN5jmw==
X-CSE-MsgGUID: JWaj1CnGS5KKX1CHSsJPXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1598952"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1598952"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2026 02:08:08 -0700
X-CSE-ConnectionGUID: zj4pkPBAQx+QbxsvM2nOcA==
X-CSE-MsgGUID: 0ZLSprJOTruewRk5hc6MzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3505471"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 23 Oct 2026 02:08:06 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id DA17D99; Fri, 23 Oct 2026 11:08:04 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Nikhil Gautam <nikhilgtr@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jesper X Nilsson <jesper.x.nilsson@axis.com>
Subject: [PATCH v1 1/1] iio: light: opt4001: Re-use generic struct s32_fract
Date: Fri, 23 Oct 2026 11:08:02 +0200
Message-ID: <20261023090802.1957593-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of custom data type re-use generic struct s32_fract.
No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/opt4001.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index aa3d87995b7c..b2e7abc22434 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -75,8 +75,7 @@
  * lux values.
  */
 struct opt4001_chip_info {
-	int mul;
-	int div;
+	struct s32_fract ratio;
 	const char *name;
 };
 
@@ -88,14 +87,12 @@ struct opt4001_chip {
 };
 
 static const struct opt4001_chip_info opt4001_sot_5x3_info = {
-	.mul = 4375,
-	.div = 10000000,
+	,ratio = { .numerator = 4375, .denominator = 10000000 },
 	.name = "opt4001-sot-5x3"
 };
 
 static const struct opt4001_chip_info opt4001_picostar_info = {
-	.mul = 3125,
-	.div = 10000000,
+	,ratio = { .numerator = 3125, .denominator = 10000000 },
 	.name = "opt4001-picostar"
 };
 
@@ -199,8 +196,8 @@ static int opt4001_read_lux_value(struct iio_dev *indio_dev,
 		return -EIO;
 
 	lux_raw = lux_raw << exp;
-	lux_raw = lux_raw * chip->chip_info->mul;
-	*val = div_u64_rem(lux_raw, chip->chip_info->div, &rem);
+	lux_raw = lux_raw * chip->chip_info->ratio.numerator;
+	*val = div_u64_rem(lux_raw, chip->chip_info->ratio.denominator, &rem);
 	*val2 = rem * 100;
 
 	return IIO_VAL_INT_PLUS_NANO;
-- 
2.50.1

