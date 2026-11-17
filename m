Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907004;
	b=c8d/k/SomGddoUIUsedv53Z6H5olbWWvquOE8b4C5gZ3czsfO1Qa/+qxNdePR1ez9xvO
	 9/vsYgYkMDaHJHTYmKMqsW5+/O/Mbg33j0IF9QjqD8eY7t7OnZ8HKR8MaOfQIki3eYsEN
	 dLzZ61+Nv8MhilhyjSLMMX8cSlfyB49n313NLHFkHBPV7HpVLcCkC2bXd9FJwYSgAKTAx
	 dXR4T67EiG9RGycxH8d34VCV1DWG0tR8egGjAKMBWScJUcAN0w7q6pS3FOPp3d/s08RqP
	 SkvzSs+XT4HJ+K9r8fnZ5W7dNx5z6pr74tKukLLyB90xK9230GfcN2Dk5nIESFDRyfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907004;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=8XDBS8uCWUHc2ThxYCFeft+ASgCY6cyBibTVp9Hh8R8=;
	b=13jF5kzpCfv97U8LAWi9Kd28a4KoZxZ5V/3BgBFeORfKsDb+lysrLsqiHd4SlXBHF9Dr
	 mT2466qBhT2KezktZ5aGXbQrZh9FVhNSWMWsT3vD0Sb5nTL4Xip0ikm6w9pdCnYQ3B5XD
	 kmr8UzULDqQ3F3645/fXWjaBnf2Z4flunXElekdfFHlkTzJvt9f+VabtmXVyFW2Svw3Z0
	 QzoaNNm3NqUYylWHhq0sFwhA9GNICso+hUowR8VEBq4LHWJFRIqvy3BYISh0aRe5fTd+T
	 qlcbOExGgfeHUuu6TWBngfA4kZoE104fURDGuSfPPOYAYWqWXCEV3q9Cqpc117ca1gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JGnh0VQq;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894DB606A335;
	Tue, 17 Nov 2026 09:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 894DB606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JGnh0VQq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794907004; x=1826443004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fh7mdEcK6SBdAh7hhUdiT8Yta+9cJ5aGG1kvmRStFBs=;
  b=JGnh0VQqAQiH0XBT64tyUNv/RRMfIzYZ++X9aBtfxuo+QKM7MU54I7ba
   YTZsr98wEgLLWJnM17Db86w2aEcKoaBOVonNVEkwKhm20QHCogEXwBE8K
   4k1xQNbuXgV0L5+qb/8fMigQr2M+InuYw58+j+PdefkdIGJ7ymmvPId9H
   JZV7YlJ/s6CUMg0ihlEgDECl3yJfvbXaOthBFkby3lZBGxMrptDxSEgkr
   lvy3HqyAi30K8DqiV1xCNqV9f2691h71pLLL1P6zc+BwUOcNXf0amc5db
   oXEDWNPbCq/3fLbkQ6+/G4YBwhpqfHrXn+9rsZUtVpV7ji60dX5SILk/1
   g==;
X-CSE-ConnectionGUID: 07sdIjJkT6+p9PVZHzwGTQ==
X-CSE-MsgGUID: fvzspjpPQk6ctC2F64Xh7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3568531"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3568531"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 01:16:43 -0800
X-CSE-ConnectionGUID: qcYFqx69QAutNA2z4LkyeQ==
X-CSE-MsgGUID: /912d083SzqkKbthZ0zyLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10145329"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2026 01:16:41 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8807C9D; Tue, 17 Nov 2026 10:16:39 +0100 (CET)
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
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 2/3] iio: adc: ad4030: Switch to use mult_fract() helper
Date: Tue, 17 Nov 2026 10:14:41 +0100
Message-ID: <20261117091638.1463621-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261117091638.1463621-1-andriy.shevchenko@linux.intel.com>
References: <20261117091638.1463621-1-andriy.shevchenko@linux.intel.com>
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

