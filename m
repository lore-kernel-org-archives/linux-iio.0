Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116256;
	b=lz9XxJNEeTn3LZo5XRaCBFvoEH/ChZ8+13jsQiHr8xn4hFSAFS1YrpFJ9r8njDxgEFD9
	 e3q1OHk9C2sB9eHBSwzNvi0kPzjY5EbAJuAfUojmPvo56PU6uXbT5MkVVaDTNWUTKaw3d
	 kWSGCDohPo8pGiszw1bXKRiNguRcD2vGd09h/KOq+E5I+eclgDoGjZn/3WV7QaSpezAPn
	 ab0yYrWmODJmkIltBX4Gm66UoIU/nORz9/3+MTZfcDV6WgOSV7BzYjpXG3EWLCHkbydH3
	 JypIY0BSDjXrQ3croQ3KblTPiTyfoVIbEWfdz2chkjoNxT6+xuO89fsRz4dam0eGXwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116256;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=A/MdpfhJOI7LZdK42uwjLuNgxVKMsQ9BEmNzJEZ9F3g=;
	b=LIZReix8UQYauWzuNco+Y8iNXodTKSCvlBf3Lwv3JFgQ2TJ/RZ2baorMeVH73OEzh10Y
	 jQK4gaNmtAKS98U24D68tHB1l5mQhaKGol/sMOhL/8zUguvLF5MMaipbdJA4TU+CSIcLs
	 JXC96bMlKQkuctgwvXZPzn9jSZwFAOZP8NHlhAzDHlWuHlS2hbB564F+jmSc8Gqf2Dqzu
	 9+3XKOsv7dE3JwsLJgpYPyptkh6cQ9C7FShIIoNG+OdY44dxzuNtCaxvCTHdKv/I7alMK
	 0jMvs1V4PK98gCXbCMGjfYJDLeShXNR2jUzFddatx3RuO+IT0nYJ9YaU3hwyOKSq2dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C6L18+Mz;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2334606A32C;
	Thu, 19 Nov 2026 19:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2334606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C6L18+Mz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795116256; x=1826652256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W6RA+2cKfo8WNDSppK/i12q/pNUztsdRjLg5fWaiOoQ=;
  b=C6L18+Mzx5QtgKDgLGTFzxMyAQYWCiZ7o7OvhdL1fVCQpJaXJ61B9Lx7
   OeiUEEpO8ZToQPMmb1Xw79rxi+wifxL/BjiKJP41nGQr/B/a2xdEtaXly
   PYcsgHRVrO50qR0VEh7Rezw1hJFIFBjbmzH1vVQH5dKLPQ/s9XQXMashP
   dqH4Yk53142plqXYBG3dUrAb6+Zn8LHqwCyOYu2TDtHfWz5YCq5/zVyy1
   Yy90wjqE9QWJb48AXqdYwxCvI8fI5ASa5QYXRfzd8UvPzKX/Tcr/zRMAZ
   3DZ6IB07QABdhH1hkpuia3Gllgrs9M03KgTId7glhR5/oJZBY953DSSDF
   w==;
X-CSE-ConnectionGUID: VL7kcBMnSaW/ViVWyLzZkQ==
X-CSE-MsgGUID: kSIPGWd9Sv6YYXbk3+0CYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4010443"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4010443"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 11:24:14 -0800
X-CSE-ConnectionGUID: JZXJfyWPSwWDIXxH2/HJYA==
X-CSE-MsgGUID: v7Qd/+P1QT+HWHaZtLijUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="12227135"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa012.fm.intel.com with ESMTP; 19 Nov 2026 11:24:11 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0E0E99D; Thu, 19 Nov 2026 20:24:10 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 2/3] iio: adc: ad4030: Switch to use mult_fract() helper
Date: Thu, 19 Nov 2026 20:19:46 +0100
Message-ID: <20261119192408.1724611-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261119192408.1724611-1-andriy.shevchenko@linux.intel.com>
References: <20261119192408.1724611-1-andriy.shevchenko@linux.intel.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Switch the driver to use mult_fract() helper.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ad4030.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 877b06007396..d61950129083 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -161,11 +161,11 @@ static const int adaq4216_hw_gains_vpv[] = {
 	20 * MILLI / 3,		/* 0.6666 */
 };
 
-static const int adaq4216_hw_gains_frac[][2] = {
-	{ 1, 3 },  /* 1/3 V/V gain */
-	{ 5, 9 },  /* 5/9 V/V gain */
-	{ 20, 9 }, /* 20/9 V/V gain */
-	{ 20, 3 }, /* 20/3 V/V gain */
+static const struct s32_fract adaq4216_hw_gains_frac[] = {
+	{ .numerator = 3, .denominator = 1 },  /* 1/3 V/V gain */
+	{ .numerator = 9, .denominator = 5 },  /* 5/9 V/V gain */
+	{ .numerator = 9, .denominator = 20 }, /* 20/9 V/V gain */
+	{ .numerator = 3, .denominator = 20 }, /* 20/3 V/V gain */
 };
 
 struct ad4030_chip_info {
@@ -467,8 +467,7 @@ static void ad4030_fill_scale_avail(struct ad4030_state *st)
 	mag_bits = st->chip->precision_bits - 1;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(adaq4216_hw_gains_frac); i++) {
-		range = mult_frac(st->vref_uv, adaq4216_hw_gains_frac[i][1],
-				  adaq4216_hw_gains_frac[i][0]);
+		range = mult_fract(st->vref_uv, &adaq4216_hw_gains_frac[i]);
 		/*
 		 * If range were in mV, we would multiply it by NANO below.
 		 * Though, range is in µV so multiply it by MICRO only so the
-- 
2.50.1

