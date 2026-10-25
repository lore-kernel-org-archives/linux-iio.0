Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792941519;
	b=zVxhLaFf5cFLlnzGJO9GZwDpyDrAzXuEAFAQMr13gQKf8Ff0FmUkM+96r877jNWMrhzd
	 +9TpD8mvf9opCtBmhJlMdH1B4n2j5tpBLqC/ODasvHsHGJxL6npTHwhCynxWSKklIqzDA
	 0pmTfXcSuvAuxX3SRlYxEV1Ewat7SlbU28LR4ySFW9gT3P1ruWKxqPrXRKq5aJ05tLHLC
	 II8e5pExpIUyimhKAxYhZtq7O4UgsKNRLpuV88r753jOmXvMRmzmss6h4ALFVCayXWSUV
	 18G56N77XPUj2Bw6XmdZ58QR6TlRklb0XhPIHuOyWKwcq2G82Y9xM89BFRz7n6NufNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792941519;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=eRTIY2QmE6ACq8H2nMlgUMbhu46IBSihGykRErDnDlA=;
	b=mtTex6w1rzZhJWHwxOe+grjei6kyWfDbXouFu/gGpuIT7ET+aX+Bon/VBok+oi3VdoqA
	 ZsgZMT8i29Bk2vpl7MjAJiZxs3hdH4NYpzPXPsY+Mjqk6XGTdSbzBYVA0Vpt3EsG2hxVs
	 q3S2WeDWSoIf1StUTsY4rWkDFvqfO9umzxib1ydkgwrMlUIpsadzggedtd4CC26QMXhfJ
	 cieZ9bhI0pv9r4wetTGpG6VwWa0q/sLNUZc7epjz2uPivwaCnp1SOoHYF2nSLs1+OWrAO
	 vj9mOJ6NH+OPo4H/CgRnxDxwxCEGo7VVz9UpX7j8nZXoz1dAF1QXjGpHuIv7BKPx8tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ODpn1dJJ;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36DC606A31A;
	Sun, 25 Oct 2026 15:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F36DC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ODpn1dJJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792941518; x=1824477518;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IRySX0dv0SSIuLXVhOjByfyPWsSteJjEmoJdxJX+ZFE=;
  b=ODpn1dJJaWrJAsgGS/IM8WQn4erBVlcZ73/VrZPwRaJasfN/H+8V64PF
   C8fFHLH15dI1DZn/xrONe5r24z33eXUbzvozN81zFLgXaLvEQRnYu6sjX
   +ySOLJ5fLKLeBv7WYW2me4Vdc9rZOssi/eP2BfnwoMzTJx5/NpdzHAmqf
   CU+h8u1jcxh+ooNwcovFcM7hQi5f/JCVRIr3c7jGD3+vQtqcJ/Ylg9T8f
   NE5Uof4P8DtwD/j2bGNHldIQ0M1TQAIGQRtEJ2zKOvxAMR7umMyE77KaH
   HJmwoyHdHg64U1cN9PhHKUT/j78NBm/DcGVXoE5a/AFktM1zRSZoxW35/
   Q==;
X-CSE-ConnectionGUID: f/wU9nlqRIeg6hpXrcvTyg==
X-CSE-MsgGUID: FxY+iVOWQu6BdeeUPouUBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1623656"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1623656"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 08:18:38 -0700
X-CSE-ConnectionGUID: 5y8bQpGCQnuqFxSlkmJJlQ==
X-CSE-MsgGUID: ubjvbqYRRE2VRO1r6YQPWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4405461"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 08:18:36 -0700
Date: Sun, 25 Oct 2026 17:18:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <at4dyW-XNABCF51c@ashevche-desk.local>
References: <atyGxFmgv85JUTls@ashevche-desk.local>
 <SN1PR12MB2528B54E68524DC62C378CD7A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB2528B54E68524DC62C378CD7A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 12:55:25AM -0500, Victor Chernyakin wrote:
> > > > I'd look at using regmap even though you only have a single bus. It provides
> > > > a rich set of helpers and the caching functionality that will save a bunch
> > > > of bus traffic.
> > > 
> > > Ah... is that a strong preference in new drivers? That would be quite
> > > a bit of rewrite work...
> > 
> > Yes, usually drivers start being looked cleaner. On top you got a few benefits
> > of regmap for free (cache, debugfs, tracing, maybe even more).
> 
> Alright, v2 is now regmap-based!
> 
> > > > Looking at these data types, can you check if linear_range.h APIs
> > > > can be applied instead?
> > > 
> > > Doesn't look like they can, since they only work with unsigned int, but
> > > these values are s64.
> > 
> > The types in the software is a result, but what is the cause? Do you have
> > ranges with a sign?
> 
> Yes, fdc1004_calibbias needs a sign.

Need a sign and having it in the data tables is different. Do you mean that min
of some ranges in your case are negative?

-- 
With Best Regards,
Andy Shevchenko


