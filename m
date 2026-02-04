Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4573F3D331D;
	Wed,  4 Feb 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199084; cv=none; b=n9TF48yjhfWrjZbRNyfFyizEA+iUFczQ2zqP4FeONN6+LsHGUFjNvPGS4BEx452LbLlsWHQ/wDqmJLzKKIKF4TSFe2DXCb/Mv1LXF+Z2khJAYP3YcGqZoFz7Cw7++HiaG34oHcqHzYxQXwcRQkxrqV1TvHCTjwrzS7LXv+SVb24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199084; c=relaxed/simple;
	bh=1DYAHTtEWrVrKgu2t5cJFMvsZlLWIcBZNCM60CEAgQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ud5tRrcp30LEAcrLkRZrSMkeDaxiYrVpKaNyf/B7LKST4dCmzi0NO3FolE2ZD6H2ZekKVQ9+56CE+O/x4ppRagwVNRsvoGBRyuPbRW1IGjYc8IX/sEOAUDgqMWpH4QWIjZb+AjIiqbViOY2eEgcAAvQzr6VJiXzVgOGj5tq9WiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWbMLP0e; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWbMLP0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770199084; x=1801735084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1DYAHTtEWrVrKgu2t5cJFMvsZlLWIcBZNCM60CEAgQ0=;
  b=lWbMLP0ec3k4zd+p7XDDcVjeyu76/3fbo7b+3PNGT1GxoMhJOIl9jFmk
   6MjPKfx4hjPhE5P23sdbr3hz4vH/AFVRtScfk/jCK4PYsgAWVymIryP1N
   RX9AZxlh+xlyaacS3uy9TR1yvJIn4/0q/nDmluy8MD2sJlvTYS7fbm/Xx
   Wu+Kv1ByNRr/KUiXmuykzs1/BzOawl/Tfawd9jk4GEmLjyg7g82xvOwgU
   I3WGvqg8QsGzz8V/EgRebOp1sQy4eAHN5wLcQY+GKwDuZY/XUMVcKzKtx
   C9quoLz2KKbLFB9ZoqR78c84gPteKFHokpI/Ybo7C1AA03SURMpdVxOgH
   A==;
X-CSE-ConnectionGUID: sb+oFQ3LTbCTHRoN6nxPHQ==
X-CSE-MsgGUID: YkW5mMFjQ7WnQbrNv11Hqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="96834800"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="96834800"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:58:03 -0800
X-CSE-ConnectionGUID: w6CnewQeQMyqSxQZ9E2IiQ==
X-CSE-MsgGUID: n+EpBAZGQm6zzUeAPw+dXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="210158228"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:58:00 -0800
Date: Wed, 4 Feb 2026 11:57:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <aYMYJppigidPeLH4@smile.fi.intel.com>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
 <20260130-adf41513-iio-driver-v6-2-cf46239026bc@analog.com>
 <aYKkv3dq9Vkm3s_3@smile.fi.intel.com>
 <7tiv33i65unu5ypk7puj3buzybykyhv2qbwp54bhcem5t4rawq@dpfedqmmxbhx>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7tiv33i65unu5ypk7puj3buzybykyhv2qbwp54bhcem5t4rawq@dpfedqmmxbhx>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 04, 2026 at 09:42:55AM +0000, Rodrigo Alencar wrote:
> On 26/02/04 03:45AM, Andy Shevchenko wrote:
> > On Fri, Jan 30, 2026 at 10:06:43AM +0000, Rodrigo Alencar via B4 Relay wrote:

...

> > > +static ssize_t iio_safe_strntou64(const char *str, const char **endp,
> > > +				  u64 *result, size_t max_chars)
> > > +{
> > > +	u64 digit, acc = 0;
> > > +	ssize_t idx = 0;
> > > +
> > > +	while (isdigit(str[idx]) && idx < max_chars) {
> > > +		digit = str[idx] - '0';
> > > +		if (unlikely(acc & (~0ull << 60))) {
> > > +			if (check_mul_overflow(acc, 10, &acc) ||
> > > +			    check_add_overflow(acc, digit, &acc))
> > > +				return -ERANGE;
> > > +		} else {
> > > +			acc = acc * 10 + digit;
> > > +		}
> > > +		idx++;
> > > +	}
> > > +
> > > +	*endp = str + idx;
> > > +	*result = acc;
> > > +	return idx;
> > > +}
> > 
> > There is a development in the parse_integer in the lib/. I reviewed that series
> > and hopefully it will go in. With that done, we better reuse the lib/ function.
> > 
> > https://lore.kernel.org/linux-hardening/20260202115451.290173-1-dmantipov@yandex.ru/
> 
> In this patch, I see that it updates the overflow check, but I am not
> seeing that function being exposed to other kernel modules.

Can the IIO be compiled as a module? If so, then we would need to export that
function. (Note, we may export only for the exact module(s) in question, so
nobody else will be able to use it. See EXPORT_SYMBOL_FOR_MODULES() macro.)

-- 
With Best Regards,
Andy Shevchenko


