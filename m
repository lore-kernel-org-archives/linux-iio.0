Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498128;
	b=SzudeiO2MCmeQ/mmB4f9pGWmJBF8yhm1Hi4Rn88bpK+ddKMN2Zfh/bpdGidLOh3u6A+t
	 O3korybAA2fluWk3Vd4PKsk/sjZPc0uvvwG2V7m7G15uRFZlZsUSOFoKh/zBxiMRykhjV
	 9GFQJXhBM0Z0oJKSAdAH6HC0UTJCblyqk2IP4xSMawY6Nrj03YLmLPxCOegMgkRhJv+C1
	 06Y8UQLPA3YUbxWP+XevnxWCvFKlpgy920onF6H4cEDrtakNyL2Wj0HTJGTyepSlJOzzf
	 PuSaOXN+PcHrE8dulmccyoDVMv/Sl2FoEyTpKDejbZtB4eVLgW3jObRbCsSBqXoLV+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498128;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=hAeTOjf174STEwxwVgfITibCbRsXn3ujgkdfM5DYTis=;
	b=tmEFjNY7dNgzKjemiJv8putYjzxR2aP0uFlBAa81QEVhN2ggI17rr9oPOqOYRuD2SdwK
	 DLjNnLy8UoQ7Ey6o99xohbwWhXfHtgDLsaue2Esyj5dz8gHD+BUfQ2KBqMqIZERCLxtKl
	 PBavY6u/e3VVV9R5AG2WZuayJD6fH8qsP2ObCYykr2GSsb7JiOw9fHnPMAS/duOZigntl
	 ZzOkedf6ukUzVuKFOuPs1L8US0PF4Ri788tBJIVwspdF3mckVWoHQSuIDBxhsuvlr4Pu8
	 cKGG2DC64vaDjo6pbFIU71kUvmuHLQSxvQhmYePb4BBftZtdDbPjIOyo9lJxtuHsfGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dIeVsekf;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82C606A32D;
	Thu, 12 Nov 2026 15:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E82C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dIeVsekf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794498128; x=1826034128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qF0v4s9qDer1hJ6UNByTJb00HU/4skZhp/e4qG6xHw8=;
  b=dIeVsekfdYPwOQjvi6uICdL2buZol5Ei3ZG5PJ/mqzA5eROGDDwaWZr6
   aMBFZzkRHt2iMFNvfIZWlK1H/EKtJKDlDKXaEP6o8oB3rbk1BcXYWrh9P
   vnbjKozKUvkmruY++Zc04Eo8xQ0nuLsy5gdgTNFvPRkXxROcsTQeISbXG
   AXkbb8Xih9D0hulDeT9oPQuIWo34c65vk/vlxlyfN5ym88Pc7Sup2q/+n
   Cppq4gpUrK1T0hbjsbpTaE2kx6o3ZkvxFmC50lrha9rnO05sa24jl2JJo
   rkWmiaLqiWbZhQM2FZhf4l9okYcr2h24zOs5teiQWeBmk3DXxfM4+o1wC
   Q==;
X-CSE-ConnectionGUID: cwr8qA/PQ4mnVLMcvsT3mg==
X-CSE-MsgGUID: qmR/VzlPSy2V2oRNI0v0Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3151845"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3151845"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 07:42:06 -0800
X-CSE-ConnectionGUID: yEGXgSmzQzS6LILfxkKDmQ==
X-CSE-MsgGUID: vuC+XqfCTeGz9LT9vC5kiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8858312"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 07:42:03 -0800
Date: Thu, 12 Nov 2026 17:42:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: proximity: sx9310/sx9360: reject
 out-of-range hardware gain values
Message-ID: <avXeSbAEGhkMjMJa@ashevche-desk.local>
References: <20261111164041.341776-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111164041.341776-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 11, 2026 at 10:10:35PM +0530, Arnav Kapoor wrote:
> sx9310_write_gain() and sx9360_write_gain() squeeze ilog2() of any
> integer into the register field. Values that don't fit wrap around,
> and 0 and negative values turn into the maximum code, while the write
> reports success. Reject those. One patch per driver, as the Fixes tags
> differ.

Now it looks better.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


