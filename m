Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792957289;
	b=HOzjZhoZDiw9CNY9SBWmeaJSHBH05kJT+gkWTTXtVgT6wJdkgY/H1GJ3kUJQkDlJuur4
	 eUgr+NN3IoIQjEtCsijWwHd0JC/7/ENZBCreDU+hZNcPYgIQLeRjryQpCfgh+EvYY86l2
	 0t8ai2qxLtoKxyugTJ0zdTGkw829inrsP5fdTaJk0oVxj5OpgspIwxiMDTENQlrWZuarv
	 xKzlJWnHN6OJv+2sM3XmqnmvCGmHP8mQADjlYIJfj3F48ZvQ1H4856OWIUeXcz6Z02NiM
	 7OghG6deVqlNEKoMHOr129gnly5C+t3HUJffvTq70lKcSnuMAf3TmfgReGa6iYqenjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792957289;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=loWA2r/IE4nsDNCChsBycXYC/X66Yw4ZxZ+0xX/WqkI=;
	b=vmmgIC+c6oSx5KYCKJ3uKu9+F9XRad3W1lcqC1aJ07TUo8Kde+TZOdN0IgJUyCrjH+nj
	 SF55d2DXykDsNXf9eLWA7oTbjrZj4oGJ6+SQh4XH2aQfCI/4yjzGu+fDkO8kFgJwGCKfA
	 nKSOWS/IwF6JucV+R9MrEBZKLoE8cPuFW3ANTsNIH1JdHPdHLfhQhLw26+V1Ks644Afql
	 McNEP02tAj/U1xFmbYxizOoKQIW7J7EMXy4Cbvu2ARLcKjQ0mDYNZlOw60Gl73zgdlI4A
	 maSDGXQUlzLVc/tbLY1XCAmI989X7zL7Ja6QXaiclYLx1F3Q03aPAQQqQX0wGSzU7Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TevI6izW;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D15606A31A;
	Sun, 25 Oct 2026 19:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8D15606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TevI6izW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792957287; x=1824493287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EccOnYd2UQC7zr91/Q2wYbVks3BuQI9mfWlB2SLQG6A=;
  b=TevI6izW2gabiZUVyiI8VMV5dAoWo1/I5gY0xnKzC/6nUqT7xD2KlQ9m
   lCQ2X90h6CducPWljQDLmvosM8NEy5Ot7gyxxQxZhT9/Xo0adMNBK8s1q
   GoYmgXepQoFY6XPdqHExQBYA635H+hnQP9xCtOu8KMEcrrJ8/HW3cRvNR
   GpnCfKEgsYHIbeMbzz9TwwrXIJH7hsUGKxTVT+lYNiWC/2ZgStijogkfD
   LFzjo3H7BpR1+8LS2UnDDcn1geXaJy/w2zekP3Myvj+rXmAdc8Kwuw7u5
   gN5g0tnKhsLRGIVG4dzkrPIHnp4sVwY9xp1YaO2ujLLaCiy6boXk+GDDq
   g==;
X-CSE-ConnectionGUID: GMOME7CPRNCoTuMSVD5pQw==
X-CSE-MsgGUID: GYdDt9sRQD+em3fjKLSlNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1631079"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1631079"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 12:41:27 -0700
X-CSE-ConnectionGUID: EB5OyIlpTDW636+Y+sVf6g==
X-CSE-MsgGUID: nXCi9rJqTa2WEOSuV5/d7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4221341"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 12:41:26 -0700
Date: Sun, 25 Oct 2026 21:41:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO}
 formats
Message-ID: <at5bYwbaQhFoO0Ac@ashevche-desk.local>
References: <SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
 <SN1PR12MB2528A44C0997DAEB1C632F0BA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB2528A44C0997DAEB1C632F0BA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 12:48:04AM -0500, Victor Chernyakin wrote:
> The highest-precision format IIO has right now is IIO_VAL_DECIMAL64_FEMTO,
> which gives 15 decimal digits of precision after the decimal point. This
> is not enough for the upcoming TI FDC1004 driver, which needs 22 digits
> of precision to exactly express its scale value. This patch adds higher-
> precision formats, up to IIO_VAL_DECIMAL64_YOCTO (24 digits of precision).

...

> +/* An abs() function that doesn't have undefined behavior for LLONG_MIN. */

Can you elaborate how so?

> +static inline u64 abs_s64_no_overflow(s64 x)
> +{
> +	return x < 0 ? -(u64)x : (u64)x;
> +}

So, the trick you use is to update the type from signed to unsigned.
'-' operator is always defined on unsigned types and produces modulo
results in case the representation requires more bits than type has.

FWIW, it's not MISRA-compliant :-)

-- 
With Best Regards,
Andy Shevchenko


