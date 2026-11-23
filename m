Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428300;
	b=qYOa8nTnCif/9V6MFEBQj9xvcO+H6jMfdKY7E+lO9LCRjx+eF25pE/uo5m32T332eOs0
	 rq1PkWwlBe7aGpLNyLA/2Z3MGxa7+aeoihFPCeyw41Uo2d0REcfon7z9cjK1HPXXlJaax
	 mk8JdmrVI+mS1dHyBTak/sHCZNBX1tFxBsu7XwTreyf3NevPm6hVreapmFQiLucuaiVrh
	 ZbrPNr32nKEB+epBcLcIvKsishrxyhBBuZciAEamoSgAhNkE55+wxyqWaO0bwp6Lbrttd
	 f6IY5eTRYo5JHEpbwWtkkCSXcWTWkt2YhsM3j4ZTaOCyjE+Gt5OwHEFPxX+1IUe1F3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428300;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=uFotz/PBNoJ86Mzc+Vb7F9h81RpsnbNUlSTRRVj22Uk=;
	b=ZYv8VB4aEyOsTDQ1JTmxJh7UmES0KiHOJrnM9kYgLweTwxbvE5Xb76uRq9svVm5aq3+L
	 yfyQTDdmXTHqxLcV1bpWEb4KU8JUeYUyzgi7YDhMd1Ab0nnWblB5XazAF9LVuSv0ADhYj
	 ig6vvlHLybcLZ/8+06Kjs0VM6XrvuTkAfZQqKquUHRZB0UpOmH9Zi5LSb/8b08nTkGxmI
	 ew0h0c0t/SZDZujiCoXLQIvZPPsYUf9Vsku6fTHXITioWS3fUwtbGPFlU6l/hZ5ZRZcdC
	 B18BkEncT4vyozzFSTKogSJaJIFAplsrTztU8Q7HExCKJy+bmTn+PndBzcym5JiD5Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m0FxNPI4;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7886606A31A;
	Mon, 23 Nov 2026 10:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7886606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m0FxNPI4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795428301; x=1826964301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dub71eKiV2/3YtfuEZPw6uumWMkbGA+kBpd2hRXyyp0=;
  b=m0FxNPI4jYhyrNp0Gydcno4hk6aixwzadOTk9kZn6nZFqf+OFbf+Y/vm
   eaRvbI0TC90o3//fPS0B+FsirSXQfcxfsOqBznGoGPEfIVztYtheESR++
   YLnn7wC8197tPxD79gVFl1aFObxaStPaRbMKV9muRAopSO+KYZROUrc6v
   ls3bOicuadQsQ9m5pO/83ETEnoFck9bxXx+Eq72HlO5XZulInfN6OKPUl
   17vPA69rnSdISJ8viGcHxoAVUx7ixJWJOXdlSMGSQND6e+FV1QQH0tOG8
   PAega+YEWx8QNhsImhulgqaRiIjp7x70QYruuHZ8TRXyjDvgLyDnvfiaX
   A==;
X-CSE-ConnectionGUID: UCTL9MEbTtqiQF5noAriTQ==
X-CSE-MsgGUID: Zd0P0AdKTgO45JCgspYK6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4242404"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4242404"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 02:04:56 -0800
X-CSE-ConnectionGUID: B65L1yQORU2006WM5Pr7Jw==
X-CSE-MsgGUID: EAKfBXh8Qhm2TX6UL47YEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11462982"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 02:04:51 -0800
Date: Mon, 23 Nov 2026 12:04:48 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com, amin.gattout@gmail.com,
	antoniu.miclaus@analog.com, gregkh@linuxfoundation.org,
	mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/8] iio: adc: at91_adc: pass struct device to
 at91_ts_register()
Message-ID: <awQPwFIWTO5ktbhL@ashevche-desk.local>
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
 <20261123070101.53868-7-abdelnasserhussein11@gmail.com>
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
In-Reply-To: <20261123070101.53868-7-abdelnasserhussein11@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 09:00:59AM +0200, Abdelnasser Hussein wrote:
> The at91_ts_register() helper only uses its platform_device argument to
> obtain the parent struct device.  Pass that device directly and simplify
> the function signature and its call site.

Perhaps Suggested-by: ?

-- 
With Best Regards,
Andy Shevchenko


