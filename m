Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0D3C3C02;
	Tue,  3 Mar 2026 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772537637; cv=none; b=dpUk5reaDVX5P0rEzwqR5nR7w0Zw7g5Y5Vfh+mTtrDHA79s95U+8fj/YdGARBVUb0DY9XpT9BHCiSHwHHm/90EujrtZCI4tRFaHxPu1akvzevEaA9md+iS7GuRF+9rFYQPOtSOlu/4DtTWb3wksbpnVWHrVyonpC8cuxuc/mRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772537637; c=relaxed/simple;
	bh=EqWR6yh7IDEyuLs2U41m4uVN5veWQTnljJmPh0SV17s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+Mc9w1N5oms1Z/1WdFPsdFlM+b1Phc42UQ8l/oTnh1E0Vh1TFvSaXRjnEeUwoH2vxjF0M1yodTNUplgv8qYlSclQwTZiTTHCANaxBzgVKch2oEKrojBE7QWSO7vTynuRjOSt18PWdmT2dH/GGZcV4ABWdLDI5b2hp1f/QM+LDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6II+/CU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6II+/CU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772537630; x=1804073630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EqWR6yh7IDEyuLs2U41m4uVN5veWQTnljJmPh0SV17s=;
  b=j6II+/CUbhI4zs25Et+751xBFuemYKBqlh+TFr3YRkS/p7rrFbOjlcP/
   79Q9Dz2qfyepeMaRimJ+GS/vf0wwWA3g9Z2Y+jHPU8k0tI30tWsnRKQ+/
   mgvWzzYUVHo7uTwPrnlYrfAk+uQHOmmDDPWHYxjIJHG0ipI4TcIEf5TM7
   LS8vXvbCE39V7CW9Hph+rPGr3RDSt3grs73UhVyWxxX7MDwhe2mu8BH7B
   VcaKFIYkh3HbF1VvZGrEnCYknL6Nr4nSP2GfwwUdtFpq463p1a8QIErbx
   cGNcdwaLGnps5gPcXk2EGhI4vvfNC+IUhGebYR/pM3AWtW3xhBNlyY33Q
   Q==;
X-CSE-ConnectionGUID: L+2EtYyySbCyq1yaakhLxA==
X-CSE-MsgGUID: FlEXim57QBy7xVeN774VhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="77180017"
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="77180017"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 03:33:48 -0800
X-CSE-ConnectionGUID: ZZHiEuO2QNm2t5i+japAPw==
X-CSE-MsgGUID: vtexAkgPTF60OBbyQTpv5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,321,1763452800"; 
   d="scan'208";a="240990623"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 03:33:45 -0800
Date: Tue, 3 Mar 2026 13:33:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: frequency: admv1013: fix NULL pointer
 dereference on str
Message-ID: <aabHFq2PZssgpK2G@ashevche-desk.local>
References: <20260303095228.7494-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303095228.7494-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 03, 2026 at 11:52:28AM +0200, Antoniu Miclaus wrote:
> When device_property_read_string() fails, str is left uninitialized
> but the code falls through to strcmp(str, ...), dereferencing a garbage
> pointer. Replace manual read/strcmp with
> device_property_match_property_string() which reads the property as a
> single string value and matches it against an array of known valid
> strings, handling the missing property case internally.

...

> +static const char * const admv1013_input_modes[] = { "iq", "if" };

This array has to be indexed.

static const char * const admv1013_input_modes[] = {
	[ADMV1013_IQ_MODE] = "iq",
        [ADMV1013_IF_MODE] = "if",
};

...

> +static const char * const admv1013_quad_se_modes[] = { "diff", "se-pos", "se-neg" };

Also this one.
Taking into account the indices are not sequential, this may require another
enumerator.

Ideally you need to list all possible modes and choose only supported by
assigning an empty string to unsupported ones.

I haven't checked datasheet to understand why only 6, 9, 12 are in use.
Maybe they can be simply 1, 2, 3 with a formula like 3 + x * 3 ? Dunno.

...

> +	switch (ret) {
> +	case 1:
>  		st->quad_se_mode = ADMV1013_SE_MODE_POS;
> -	else if (!strcmp(str, "se-neg"))
> +		break;
> +	case 2:
>  		st->quad_se_mode = ADMV1013_SE_MODE_NEG;
> +		break;

This (the default) should take

	case 0:

as well

> +	default:
> +		st->quad_se_mode = ADMV1013_SE_MODE_DIFF;
> +		break;
> +	}

-- 
With Best Regards,
Andy Shevchenko


