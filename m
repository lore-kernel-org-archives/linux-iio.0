Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931743;
	b=NxWXCKgt2jOjKuvm7bvSRS8A4sjw0NgVhjCixQqOB8eVCM4rwvuuQGOGr/+h7Nuvxtea
	 dJkadFWPa07c1WXdtrwuIygENF20BYYm6KZxTk9IqFlV4hVsTZroiaRhSFXcSVlDVrM7a
	 olzmtFHbtFJ7Po5rhC+Xypz1Im5gLzT9xr4rzknGs6Wugmz1elX3vF5v6tCa4SevJg+O9
	 3HqIRZydNKGshE5HK7EwAhw5g3F6QillBCd/VjS9sQAzEA7Mi5v1A4MsQFkTZsusD55AL
	 /KmN9xR3r0Nh9CYI0Lhv9Kic2TMhhaYait2+MLyHz3R1vK4Trv/VwZ+WX85iLXRw0yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931743;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AFsO+fgSlCH6yt0xOXXyKqfxOzwMQ5TDw56x7sKMr68=;
	b=z3RPUFIWPtWafT+Yfaj3iOFGWZE2PYbK+dQ3QiCOeX0sNlvaXn4ScB+ES/oC+cNAX+Cp
	 p+KTr6FsCtfmX42nLF8mgt1F8UuDPAp0tpw65zcgw8RhJufbJkUVovqgGOC4GqQi8RrLv
	 2s1GClfSa1BBQPVfakS8QCTbGcXB8ZuQnHgry9/T3DrNua8sJ8JL68BwXuCdxid+sFxNK
	 w4Eo+uwCA8ln9X1zqpmdwkCbQmYyg71yqQ24nTbRROeZSROvB/l6rddzxD1rgil6Lwdov
	 iqtbP5JE6ougYodggAwjjIhhHf3LyjVEDCfseKvnx2fMR5qQ93lq8jBczz2H0kIhKGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="dodU3rd/";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5B2606A32F
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 16:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F5B2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dodU3rd/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794931743; x=1826467743;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q6wIeJJrs75VMZxn7rswcN/NSJ5hop2vPQvWY7RbmOw=;
  b=dodU3rd/SvdVdQJNeyuoGw4UhiqJGxMNxHT/J6vkcf6Ip4fHKMpQ5uWM
   +cJn42S3EGnUvLfe1Ak/fJLCq8DHYZYBiTXpSKBw8uj90Tuq+BsmROMdQ
   BMvtlUO+sm6YvlXEi8LLChO770RrPFVKGNsdffyiDVMKdbFVxdAtSj4K+
   vu9X5eaP6haLBh8XPO4mqj98XED4c02tQ818CAwfC819koAFtN0/2RJK7
   TyfL5DEntCmhGAPMgHXCpVVRJmUbYTZ6qEXChVB73O4bO7grAsXaIGfY5
   mdglRv76dkH3GUA1vJW0N2wItZkXWLkLU4z3ACtdb66WilAG02M5WGPom
   Q==;
X-CSE-ConnectionGUID: sdk7TUUeT1C5BBByoCVm4A==
X-CSE-MsgGUID: sO55r9JFRHWaytn/6rCzFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3815087"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3815087"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:09:02 -0800
X-CSE-ConnectionGUID: rnxu3J5wTtSAN2qSRMCWCw==
X-CSE-MsgGUID: y1aG0eOMTIGKw0sWagsY9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10103727"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 17 Nov 2026 08:09:00 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B347199; Tue, 17 Nov 2026 17:08:58 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux@analog.com,
	linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] iio: dac: ad5766: Convert GENMASK() to use static parameters
Date: Tue, 17 Nov 2026 17:08:43 +0100
Message-ID: <20261117160857.1799863-1-andriy.shevchenko@linux.intel.com>
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

There is no need to use run-time calculated masks in the code. Besides,
GENMASK() over non-static parameters might lead compiler to generate
much worse code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: fixed typo

 drivers/iio/dac/ad5766.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
index 061b43fc0345..ba6c54e2c9ac 100644
--- a/drivers/iio/dac/ad5766.c
+++ b/drivers/iio/dac/ad5766.c
@@ -18,9 +18,9 @@
 
 #define AD5766_UPPER_WORD_SPI_MASK		GENMASK(31, 16)
 #define AD5766_LOWER_WORD_SPI_MASK		GENMASK(15, 0)
-#define AD5766_DITHER_SOURCE_MASK(ch)		GENMASK(((2 * ch) + 1), (2 * ch))
+#define AD5766_DITHER_SOURCE_MASK(ch)		(GENMASK(1, 0) << ((ch) * 2))
 #define AD5766_DITHER_SOURCE(ch, source)	BIT((ch * 2) + source)
-#define AD5766_DITHER_SCALE_MASK(x)		AD5766_DITHER_SOURCE_MASK(x)
+#define AD5766_DITHER_SCALE_MASK(ch)		(GENMASK(1, 0) << ((ch) * 2))
 #define AD5766_DITHER_SCALE(ch, scale)		(scale << (ch * 2))
 #define AD5766_DITHER_ENABLE_MASK(ch)		BIT(ch)
 #define AD5766_DITHER_ENABLE(ch, state)		((!state) << ch)
-- 
2.50.1

