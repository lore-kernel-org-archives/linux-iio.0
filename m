Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794907004;
	b=XOIcLQ/TAT57ynrGmNhI9Nk4a+ZjPX803+XNhp/xlQsTZhN+z/NU9GmfEZaveLeJzaK7
	 PurAatm0ouyDdnC5LLzVE9mDxC3ZgO4kC12HVpYnA3d+0LWfuq9bV6IsrBFnQ8IEyCtMo
	 dQYqWpYBxxGNxDQnVfX83hMTwubVQc7tzK2NwtTm+pTRIHQ8cwyR9a86YMSZrwJcQQzTX
	 1AE1OZ1V0DRqG/duS1SeZ/9WhoWnrWgB6AobTrU9Od5K9W9cGQQ3T97Nq02lzEPQf4PKy
	 otM111LfzuAT85FOqlYMZqtvbZ1a+nbHQXQw2vPvFjjUVI0ToDeT0Iqe/B7L/+bWpbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794907004;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+UPc0XDAwkz6UInIaxlT3XkqPTg3M24URPATN5ZcUsQ=;
	b=CTEPxU7b3RYXhFEN0KfTH8iscCrNaQBTFPFfGd0nDZewc5HkeFHVks4a8J/fjJl49LyD
	 z9ZMdPLDYVscXqTGHuA0v37QwlaMk836b41pykdRuq15sJuAeqsjVHONxWBgTtcc9VHrb
	 mdSX0xjXSmS+a1rl/iZ5TdfivAgi7lNJvFLbmd5/hDL9vEeM5KEbdmJAu2aXZcSua6o8Z
	 qf1quDVx/KjX0tTcVNBkS1UhUqQlBBNl1sk84CYTFDOJHSqM0IY0uvSxx9oJVpHFvwlcJ
	 0Z4S9RIY7vmzSv3jRaQLYh9kJ9jRhvqhp34xctEAmuGQ66wATq5EFmBL0aQ9q+imFNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bR3WmEzA;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C38C606A31C;
	Tue, 17 Nov 2026 09:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C38C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bR3WmEzA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794907004; x=1826443004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YwahVZCVz6RbomMbUkZVNK0CeSMy0Mf8HARHACJLguw=;
  b=bR3WmEzA/X2+8UhaPIwxtP33fsyoezr04LUTwCscD1/Q+L+SzDWbHiW0
   Ljs5uDaGfWRcfr2sThUGas6KxR5wORgXDiKH3ya5u5CT5PXhQx2+u0N7Y
   G/fn6ePw2m4geM9cy+yZqlVOSh9wNi5mi/g6HPvhWqsjLPHA9/yXRLNoB
   Uj6qzPUHl0pd+O8TqS5niRV1mLolLa4mkPUv9bZxkdRN21o7Twu5/5TTK
   kULrZKqREmPuZABxGUqGSuu+ABBDEX4wnQpdMkPzMtX/+ONXTXYHrNwiQ
   WH0pBFzjOiTemNVuMaoWBK9ruqg4l6D9emHwORbVdH8tAAvMJ9jld3cKv
   g==;
X-CSE-ConnectionGUID: wItWDpYFSDSNNzSR4KD6Kg==
X-CSE-MsgGUID: GWGRsP6wSAuqXQPWAVs2eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3568525"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3568525"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 01:16:43 -0800
X-CSE-ConnectionGUID: MKLhVUQLSOG5b1dTtAmfLg==
X-CSE-MsgGUID: I7iresJAQjKU/IQEIt+vUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10145330"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 17 Nov 2026 01:16:41 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 8391C9B; Tue, 17 Nov 2026 10:16:39 +0100 (CET)
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
Subject: [PATCH v1 1/3] math.h: Add mult_fract() that takes struct __Txx_fract as argument
Date: Tue, 17 Nov 2026 10:14:40 +0100
Message-ID: <20261117091638.1463621-2-andriy.shevchenko@linux.intel.com>
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

Add mult_fract() that takes struct __Txx_fract as argument and
calls do_div() instead of plain divisions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/math.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/math.h b/include/linux/math.h
index 1e8fb3efbc8c..ded258df50df 100644
--- a/include/linux/math.h
+++ b/include/linux/math.h
@@ -128,6 +128,10 @@ __STRUCT_FRACT(u32)
 	q * n_ + r * n_ / d_;	\
 })
 
+/* Same as above but for a struct __Txx_fract fraction */
+#define mult_fract(x, f) 				\
+	mult_frac(x, (f)->numerator, (f)->denominator)
+
 #define sector_div(a, b) do_div(a, b)
 
 /**
-- 
2.50.1

