Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907004;
	b=bwxJsiy8wu77z06nOfCtoP3y1r3FrtNZn0fxPrGXRquSBOe/mzlTxmkVsAIR6Q0Pd2Po
	 3UzrON0xxDjqUBXuLDvu1Z0VmQ8c/b9h2AuFNkyfb9ha3N+QXmQ53kbqcLgCo7WHUHqZ6
	 G5f5wjcxBWSYnjgNXRcTIWGCqMAf99t9h0gJwrfAfnrivc+PZMKiTqS7nkaHJ0nWwL7wz
	 J+JpNZvBolRRGqXy7+5LK8oRtPaQhtLu7BCbmcapuFSjRNPDJBpNM7T5LG/IckWNDuIbC
	 IA+Y25Re/mkS1R6aAS/QOKazFdjTktHpy7iMEqbg86TisfvFAmU921/Gb3k6urip6PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907004;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YB3EuYN7LYlfD5kfTjGUFWkB1+ii1Jjt8eUrKEtV/Uo=;
	b=zNkU0wgFSenKNIOMtkEbpfrCabOey4nPUMXOn8eZ6H249LesnAOT/BWI6uJIt4RqX20T
	 gmRbNUm3Qgr+1jsyjy5AAsB6TAAtyL662rvRROXAZJbzyH/6BCDUtyTVLiVOvZUNsY0wh
	 guImWHOvUBkkazKhUmmINQLkWaNXEFcqfa0NtqzgY+TD7V1ujdOZLMU8g2dWLC6u9iY8Y
	 Ky1Bhd9XC+qygqrER7tZvbny7coxeZiYoJhdZpamIsw6y2rIKW/SgX5Ht8p+2EoACV6lN
	 M6XybHVpYA/1U2CevCRY6ZS38PxWkQBbCQRud2V1WFpxzyelv3VJDKOSU3mTqQZw2rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YBB29olv;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F83D606A32C;
	Tue, 17 Nov 2026 09:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F83D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YBB29olv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794907004; x=1826443004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OGaDaLWDT2/MAwprK9I69ejwvY/ZxxHLbcFoOAR4e7s=;
  b=YBB29olvijLgmUub9sLQDzFWnHXaZ3t8vfubosMIL5Yim2N3YIYbtEub
   StowTMu5wmkzw0SHIfWt3ftm7yBebkYiMOqKkLh8jyB1rVI9B86fqT87t
   IbGbMV1cWdjsZbOnRM6WdfO67RB8IPm1rUHktf8o2don9B8jw7i5r9ifx
   Mnot5wimZijP2jeXD67kpcsPuZsuSp6ISkoglJEkoGp5An9skVJb/g0lI
   Le/Kj6e0P8L8hTe2cU9Qu7ft7WeajXxilXUxBnWCdOEcyx+9HU9yi+LVb
   sRHPGbsQK2X9nBWanS+O2jRVveNcdXcvzCMTxVtKE9mMEVpkDZWDIrrDS
   Q==;
X-CSE-ConnectionGUID: wg9SOTuOSieu1LSXOyY1mw==
X-CSE-MsgGUID: rO3kvGaEQXexGbFtdkEOFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3751685"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3751685"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 01:16:43 -0800
X-CSE-ConnectionGUID: 509woryVQ8WLNqpm/7l9gw==
X-CSE-MsgGUID: 4AyhRL9aRQSKrxsYhhmWCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9785901"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 17 Nov 2026 01:16:41 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8C89F9E; Tue, 17 Nov 2026 10:16:39 +0100 (CET)
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
Subject: [PATCH v1 3/3] iio: adc: ltc2378: Switch to use mult_fract() helper
Date: Tue, 17 Nov 2026 10:14:42 +0100
Message-ID: <20261117091638.1463621-4-andriy.shevchenko@linux.intel.com>
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
Content-Transfer-Encoding: 8bit

Switch the driver to use mult_fract() helper.

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

