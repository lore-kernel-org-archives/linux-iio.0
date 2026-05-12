Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ABD3EDE66;
	Tue, 12 May 2026 17:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608178; cv=none; b=rGyfExC/05gkxkF0lHeh+qb7sSneCJD3Du2FVYz9By8GcEo3yM9k/aruitWbch/KtDee1v5AsENv1tggn3YRNXAQzne1rT3RVGHdDY2e8zoF7GuSfKmggOZd5TpjY9wyokZE04HK/W43Lni3NUAQucO6kGIF1JnDaAzpHI9jxCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608178; c=relaxed/simple;
	bh=hGoLgFvqmnL2T34vovl9lReM81TwNgRLYfnvDPzQ79Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daJ8HIsCmdw8UviTF6/3WjqfP2KLOViDh4+V1+HEZGmkC7kEBsQlKIIpUBOqvB1FTYbNW302YfmYc8zSz7HEDjCIR6DtzQvE2VVhOhIXEyl9JjOHIGy4ijlMTGe8bF+FwkIjqtZWT9WJSzHTPS68d1K7CgDe1SPcSKmoY9Yq1e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QkLzH+wE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QkLzH+wE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778608178; x=1810144178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hGoLgFvqmnL2T34vovl9lReM81TwNgRLYfnvDPzQ79Y=;
  b=QkLzH+wE9c6lQtfHumg6f/aCO4oY7Ju4H4gpmlYkQZYC+0rALjG6pIXS
   Cd4P0Zti8u3ZNVVCRamcMZ/xr34ARVphlKQl9tZGZF1GLbkj4VkCKr//3
   1JhUTwB1d9li53ZLZbOK0kxXHI69NWQxwhaDY705sXy6IS/cFcOwlnCv4
   NN8VZLWg6osOIg4meG5Dw/jd/5Qx2ZqStTJB6lc+F1W/fffcc7uFDTryk
   s6WtXa1tPjrrkjj6D/xH6Nx8pksnt2D6AYM4zlm9ptuHCKP++nRlyZYjQ
   6iExuosnLiQauE2C+I8VX2fbzeyIFYgNI8iPo8n7P5VNgmYOvXb/mZqdD
   g==;
X-CSE-ConnectionGUID: HgpRW/v3SLO0h8d++51/Ng==
X-CSE-MsgGUID: 5eQoEL9zRb+vdnJbHR8KGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="89828685"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="89828685"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:49:37 -0700
X-CSE-ConnectionGUID: bD2MznS+Qjq6sKdEpImUKg==
X-CSE-MsgGUID: QRO0mplfRH2QqADyc2KxGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="235165510"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:49:32 -0700
Date: Tue, 12 May 2026 20:49:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v12 05/11] iio: core: add decimal value formatting into
 64-bit value
Message-ID: <agNoKbcwT6_spC93@ashevche-desk.local>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-5-34af2ed2779f@analog.com>
 <agM6uzhdn7o8g9v5@ashevche-desk.local>
 <ql7smsqza7liupm7fhdts73cxsltrpxsqofu5ovzpxpwvcscuv@qigi3dwukk7k>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ql7smsqza7liupm7fhdts73cxsltrpxsqofu5ovzpxpwvcscuv@qigi3dwukk7k>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 05:09:32PM +0100, Rodrigo Alencar wrote:
> On 26/05/12 05:35PM, Andy Shevchenko wrote:
> > On Sun, May 10, 2026 at 01:42:23PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > 
> > > Create new format types for iio values (IIO_VAL_DECIMAL64_*), which
> > > defines the representation of fixed decimal point values into a single
> > > 64-bit number. This new format increases the range of represented values,
> > > allowing for integer parts greater than 2^32, as bits are not "wasted"
> > > in the fractional part, which can be seen in IIO_VAL_INT_PLUS_MICRO and
> > > IIO_VAL_INT_PLUS_NANO. Helpers are created to compose and decompose 64-bit
> > > decimals into integer values used in IIO formatting interfaces, which
> > > creates consistency and avoid error-prone manual assignments when using
> > > wordpart macros. When doing the parsing, kstrtodec64() is used with the
> > > scale defined by the specific decimal format type.

...

> > > +		tmp2 = div64_s64_rem(iio_val_s64_from_array(vals),
> > > +				     int_pow(10, scale), &frac);
> > > +		if (tmp2 == 0 && frac < 0)
> > > +			return sysfs_emit_at(buf, offset, "-0.%0*lld", scale,
> > > +					     abs(frac));
> > > +		else
> > > +			return sysfs_emit_at(buf, offset, "%lld.%0*lld", tmp2,
> > > +					     scale, abs(frac));
> > > +	}
> > 
> > What about
> > 
> > 		/* Print a leading '-' for negative fractions */
> > 		if (tmp2 == 0 && frac < 0)
> > 			offset += sysfs_emit_at(buf, offset, "-");
> > 
> > 		return sysfs_emit_at(buf, offset, "%lld.%0*lld", tmp2, scale, abs(frac));
> > 
> > Also note this won't work with the frac that are == S64_MIN. It's UB (undefined
> > behaviour), see the comment at abs() implementation. Maybe a time to add abs()
> > corner case tests...
> 
> frac cannot be S64_MIN, it is always and remainder of a power of 10 modulus.

Okay, but what about input of -0.9999999999999999999 ? Will it fit the signed
frac type?

-- 
With Best Regards,
Andy Shevchenko


