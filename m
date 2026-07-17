Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B493E1234;
	Fri, 17 Jul 2026 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276134; cv=none; b=V+Rqs6jR77d+V04mycEWaYUAX0SzVPlsmfHXND9eRTaAn2ZF7Bz7zumHf2LIZ52d3DlQ7IjlO10AcTpmbx7vaUaLbzcXvVySO/H7wPxZcM5JzVWP8yvT4FtqOQV1WWKo0J0rrZiDFVrjhhVZPUNAKuepctntjvizRVhP4GC9AWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276134; c=relaxed/simple;
	bh=Icfqbb3rEIiFxXFRxS8O+X8oNH9+xaaTCNfk2QK60rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMIuSxONsRqdAtREx32Er9Mh5zoz/F2niw7jPkiFE90m3LVxunvmPpEf+msZy9RyMyLQd+DaZjresBHwCLVUaICufLQL5F1un0LvrKkI7HAIEx69CjCmcc4fsXJCo94bO2jnZYqrXN9qVjgNaDaBjWhQrEkbRHhTdiwrVqjBh9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qol3CTLt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qol3CTLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784276133; x=1815812133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Icfqbb3rEIiFxXFRxS8O+X8oNH9+xaaTCNfk2QK60rY=;
  b=Qol3CTLt6XsDyXFHOftWwY+35LJBcust+SRnT1pY4LhSZHs6zKnJaoiR
   dV4w2M89B6aE4GODFN7ootA79tX4ij2tTfq+4tv3jOZqV6IyUtF7yGkl7
   9qNJ1+ukyt/wN8HUNxSomh0LbptYTIF1n4sXbKg7F4O5YV3GJDJ97vD6h
   GvdG0NtK9WHe+MziXyCTC/6EpeTwGQY+eXi/XMhUGsW917srlhsBed1qk
   aDGkoYlFe+ZMgj7Y18bw3Yr9k86SoyjciUq+cX4SsnoaHQ4FCJM3+CgE4
   S1dTrcOJOQrKhjwn/MlvEIjtM4G5aq8TABMrxTRKlsxg4MtrWu/UnoCfl
   w==;
X-CSE-ConnectionGUID: 5jCHv8KwTh+IYuf4rWBp7g==
X-CSE-MsgGUID: REUT/e4nRImColF+/yaxnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="95300707"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="95300707"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:15:33 -0700
X-CSE-ConnectionGUID: FEMOgqSsQICEJ6vQ/MYLvg==
X-CSE-MsgGUID: reeqV29lRv29dNC9HSRyLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="250377846"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:15:29 -0700
Date: Fri, 17 Jul 2026 11:15:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] iio: dac: ad5686: missing NULL check on match data
Message-ID: <alnknz55FbyyqqlL@ashevche-desk.local>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
 <20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
 <alkmAcDvSXr_COc_@ashevche-desk.local>
 <ondynh4kmchzugk2l24klamrcaje3qxnhgiks7gnc46wwwvo35@hysk2zaimb2e>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ondynh4kmchzugk2l24klamrcaje3qxnhgiks7gnc46wwwvo35@hysk2zaimb2e>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 07:51:35AM +0100, Rodrigo Alencar wrote:
> On 16/07/26 21:42, Andy Shevchenko wrote:
> > On Thu, Jul 16, 2026 at 01:14:18PM +0100, Rodrigo Alencar via B4 Relay wrote:

...

> > >  	struct iio_dev *indio_dev;
> > >  	int ret, i;
> > 
> > Move an assignment here as well.
> > 
> > 	chip_info = ...
> 
> assignment? this is an input param validation

Can we make sure we always get a correct one to begin with?
With that an assignment and check can be coupled together.
Also consider use -ENODATA as it's most likely comes from
driver_data.

> > > +	if (!chip_info)
> > > +		return -ENODEV;

-- 
With Best Regards,
Andy Shevchenko


