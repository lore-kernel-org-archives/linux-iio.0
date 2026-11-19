Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116256;
	b=kYipealPXT0qDcSxjBXSCPF3ALcny/qas/DJmSxI2oqhBqFA4FZj/m7ZX3H1B1ws96w1
	 Ev6BZiqLVeeyCCs/Sc/P83m33E1qnBEEcf/Bl/9W5fxk6Mtxpc57v+p1pIjgU36J1e6av
	 EBLQ0PQBCQ/y8fdy4c/z6URsiFZHvxxvDSgkgAKwbi2QZDRjVdAAwk71r+aruukzqZC2x
	 pJagHDndR0W8oR13GHeBEYde9uN27IAtHJk+sW2XQZsiBiev/mVE4qyp80Bodfz5Vt73g
	 v+wBAzcC/z9S9pdIifZQFLxLQa/4hQtYQ9CjRyHsFitp93HJBzQqpJFYcS4qGICJ/Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116256;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3vHB83GnBW39HQDSjqCc/DCnZn8nMMC9n1F0Xktlo2M=;
	b=E6InSiVuWJ1XKCTzUz+OjR9yumeiaBDj2ATAtJHc0FDyQ7Z/paw2y3+FGQqxCOw3UYtX
	 SnYubAquVkGC7Nr2o1QJlqyvmJGCkoWEFeqM8ZPpGApxemga2TcWxzpaswMjl/vGr1v+8
	 20COHiPOVENVNn6f0KwxaVK/6R1yP0zDPZPbdnXkb+mMgLgLlave7vgMtjSvSP29kd2Ys
	 crcTA+pRzAYUQeAHYNEA4s2mSOu6YNfZuSDdHN3Jek5LwXrJ/v05f1IH7cbJiHibsxEdM
	 cZstirMSdbu+C7dY/u1WLT9NWU25cN61WICkAlxTu7VFYsxszPoTZSK/LJ7bGS0hOhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GBj9gPKQ;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD02606A335;
	Thu, 19 Nov 2026 19:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDD02606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GBj9gPKQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795116256; x=1826652256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHA9Cha6qDTyrbB1StS4Q5hp2Dho0bVwyxip+C9BP7c=;
  b=GBj9gPKQKhiEP/H422TO4nNFVkCb2eRvZMjqF9evSVuKZmZdxJ6NSxJT
   caFwia3UBuUmDGkE/NsBIq6oEV8wmdbyCxoOAksWl+3Jpis7ooyyTk2WE
   EgVH24vnS8sMqtnjtMS/UqLHSIj7P9+IbKC33mXNQFqI7Vhp8gXvCONhh
   +dD/+5qkE6GBpOL7qYYL1r26Ds0OJyBvbXMaN7p76CBlIDDmmt9JDyIba
   kkFTJ+X6fTobGMojyt0L93A5Oqd1UzJunqxJyzQengNaqeDkLWajWIu+D
   K8NjfVZR2sJvDsTOW4BvMclpXmFbHaoOcpZYeTBZjgXDgKuaDQvMZxzvt
   w==;
X-CSE-ConnectionGUID: AAuzFUcERkmDs6ohX1JwHw==
X-CSE-MsgGUID: ymFn9UQqTm2NpYRU2BIYWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4010435"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4010435"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 11:24:14 -0800
X-CSE-ConnectionGUID: HKrvBOHdTkCZXIbn5oBlcw==
X-CSE-MsgGUID: Ekoo25SASzu08bKlWaP0Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="12227134"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa012.fm.intel.com with ESMTP; 19 Nov 2026 11:24:11 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 124849E; Thu, 19 Nov 2026 20:24:10 +0100 (CET)
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
Subject: [PATCH v2 3/3] iio: adc: ltc2378: Switch to use mult_fract() helper
Date: Thu, 19 Nov 2026 20:19:47 +0100
Message-ID: <20261119192408.1724611-4-andriy.shevchenko@linux.intel.com>
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
Content-Transfer-Encoding: 8bit

Switch the driver to use mult_fract() helper.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ltc2378.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
index b0ff2be1aee0..a0c5fdd5e761 100644
--- a/drivers/iio/adc/ltc2378.c
+++ b/drivers/iio/adc/ltc2378.c
@@ -396,9 +396,11 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
 	}
 	case IIO_CHAN_INFO_SCALE: {
 		struct u32_fract fract = st->info->internal_div;
+
 		*val = st->ref_uV / MILLI;
 		if (fract.numerator && fract.denominator)
-			*val = mult_frac(*val, fract.numerator, fract.denominator);
+			*val = mult_fract(*val, &fract);
+
 		/*
 		 * For all LTC2378-like devices, the amount of bits that express
 		 * voltage magnitude depend on the polarity / output code format:
-- 
2.50.1

