Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D72F9D83
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912038; cv=none; b=iXEq+fAcl8JNiPaylaiYrh0bj+M956pMa+53UaWNqvNnJggIqqGhBWWCdtI3s0DA08Hz6P/iQ69nx0ZJ6VyWLw1fhjZDY1AZVKt75c6GR/Y5d8okv9yuLTNZMkDYJSlN0KhTsW3jvbICauCj05gPOlqebf5L4kOjBXn0N2QnTl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912038; c=relaxed/simple;
	bh=VJ0kQjJVtXfhmNIti6r35MiGUjKnVf5d1YXf/pzTOmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTUPzPMlfI2R1m6HFAKzvy+5Qk3nWVLMdjKDfTH/3VTRRZ1Jv+wx4f/A1j7yC/g+pOo/5hw/+PB4A2UGKk34HFrGzELFNUppRe1IroAwyTh77yUwU/YlqsIkljVkjW+G7J+5wYXQxpBrEkzGYBQWqRupv6qVDS3i+JVNIbJ6VIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kV74RmvG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kV74RmvG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773912037; x=1805448037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VJ0kQjJVtXfhmNIti6r35MiGUjKnVf5d1YXf/pzTOmY=;
  b=kV74RmvGX9C6u9i8ntonbETc1TvsLntQ2aD4oxtd91WzAgOgizzUN51f
   w3aZs0So3dxBGx0tWlSyzMDqQzVn3CpJqXVaj4W8XlXiJ2qkPzJpcEaCp
   +QLbsxyFppowGG2XCWDurmZLWpfBi88RpmXBoDfQjyWpZfYegJpJNCDmH
   0+kv4lUYAVEPrWaAc5ssU+u3uIxtKDVg3Hvp3jRzxgPj3fjkHGzfVpL0U
   cPx8+st86F27FefIFJmWGaZKULa7ATiVayVF+iZ0NlFSBT329KXF8dNsd
   IloHZ1n8EbKPBaQsxXD0su/aQAW5vyAxMc0SZyfEwOpMdcY3fw+IAe1I0
   w==;
X-CSE-ConnectionGUID: TOIEzy0SQ5WA13IP1D9u0Q==
X-CSE-MsgGUID: WWOe4lk3Qbug1ONSKiH+ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="97589410"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="97589410"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:20:36 -0700
X-CSE-ConnectionGUID: hR9xpBiwQEuyJnYgBTltxQ==
X-CSE-MsgGUID: mXYiCgBbTa2iGac+Gm3jTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; 
   d="scan'208";a="222144628"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.120])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 02:20:28 -0700
Date: Thu, 19 Mar 2026 11:20:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: remove redundant OR with
 zero
Message-ID: <abu_2Y6gjLU1aSHv@ashevche-desk.local>
References: <20260319085741.109359-2-giorgitchankvetadze1997@gmail.com>
 <abu-21Hi5eXkuGkQ@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abu-21Hi5eXkuGkQ@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 19, 2026 at 11:16:15AM +0200, Andy Shevchenko wrote:
> On Thu, Mar 19, 2026 at 12:57:42PM +0400, Giorgi Tchankvetadze wrote:
> > The expression 'ADC5_GEN3_CHAN_CONV_REQ | 0' is redundant because
> > OR-ing any value with zero does nothing. Remove the pointless '| 0'
> > to simplify the code.
> 
> Have you read the comment above?

...

> >  	 * Use channel 0 by default for immediate conversion and to indicate
> 
> ^^^
> 
> >  	 * there is an actual conversion request
> >  	 */
> 
> I believe this is done for clarity. No need to have this patch, but I won't
> object going it in, since the comment still stays. I leave it to Jonathan,
> but I'm not going to give any tag here.

FWIW to add is that I personally do stuff like this (*) from time to time
and see nothing wrong with the code that gets optimised just at compile-time
even by some dumb and old compilers.

*)
IIRC I have done something like 'foo = BAR | (0 << 20) | BAZ;' for the clarity
of the value that gets into bit 20 of the register.

-- 
With Best Regards,
Andy Shevchenko


