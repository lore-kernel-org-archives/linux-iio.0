Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451792DF138;
	Fri, 20 Mar 2026 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774016285; cv=none; b=JK0Vpn+Nvv/pAFFz2FP+hj3AZUHS4bgJ7IhV+w6VVQn9CD9Xe7JTqnCptM2W8tiCrZLbnJO/79+varRwrxt1Z+2wRWT0mKQ6i9Vn3xQ8Zt13Ip49tY9vEqdVxeT7cXvjJcyd02HPjUKfF7+GYkfFpGE23Gk3F30UcO8CaCwWr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774016285; c=relaxed/simple;
	bh=9gaDMcQtKU4cNNAa/T24L9kV638vzjoEWInSOi2XK/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxOLwIXZjvQXCi4XdI4T6wPE64o2WCRS1fchHHxNIo+ndWjnm0JZp9gUb08Ayo6rSbtZhmt9dfx2P5apNY6d2CEFnRGDGD4jrxgwQt/aRGvI5rJx/+L7XJVjF7HfCodFj9NIE6ERJZHjTMbjt5yFSVtNISrvaPYvXUUhE/NJOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3lJKcJz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3lJKcJz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774016283; x=1805552283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9gaDMcQtKU4cNNAa/T24L9kV638vzjoEWInSOi2XK/s=;
  b=C3lJKcJzNqylisMF/FtKUUdvSv/jgzVlvmA2ELJ+tdrPVpdxE5++q0Uv
   GF9ZooxpP7yp0XyuxPZOWP1aiziw+DLVM/d+zr2rY0K7i7cElRgaFSYIm
   pP+9CidvYpyutADTu8a/gWWR+WJ9rhj6YMCRJ/YstdU9t0hLT6IZ/jDHB
   ZAqAz+viilYYdv16CDDnhR884Y5bZA4Oo0gD0nih3uPwDudB0j8sVR/Vl
   zvPylowdqonLpy1vDW1b48Cmtwxkfjqcmup1f2B4HJjFJv/gR6bD+uz9x
   gsaVl3MOZ4crhCsV1gG9LI1CAduf8Hzsk9jJiCEhW7VmqRHSXlmrLEa2T
   w==;
X-CSE-ConnectionGUID: TUBchJAxSCumAEcKlqiS1A==
X-CSE-MsgGUID: skx1cYmcR2uPgrcXmGl9gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="74986176"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74986176"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 07:18:03 -0700
X-CSE-ConnectionGUID: d25DUkM2SWGlF4rWSMEdSA==
X-CSE-MsgGUID: Dqy7/cmxQ0yPBss3NmGLug==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 07:17:59 -0700
Date: Fri, 20 Mar 2026 16:17:57 +0200
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
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 02/10] lib: kstrtox: add kstrntoull() helper
Message-ID: <ab1XFW6qsqKFdNXP@ashevche-desk.local>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
 <20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
 <aabm23jCikXs1l6F@ashevche-desk.local>
 <qcloiwjlbehs4yyuttvrt46monh7isef4d5nzuwlaby6uxfael@j3trvc5jwosy>
 <4mtdzxfj656sjr66npabfvrr7yd7q26l2unhsihjtniz4ossfj@g3qnzonoary6>
 <rygken7oujyoupeanrdnl7r7smesa7js6sn3jsafbajc4sm3jh@adeslfqwwf3x>
 <ab00clb7LL-bmJWe@ashevche-desk.local>
 <ixvzb5mni2lhz733f4fvvzhozmpezkx5s2q7sash3wv3u2g7ov@pgs6pve6kxrq>
 <ab08aHbudFWEtLi8@ashevche-desk.local>
 <qsquhriyrepndxwexox35oi5i7v4klb64lajuk3j3pfozkjiew@fp55l4znck4o>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qsquhriyrepndxwexox35oi5i7v4klb64lajuk3j3pfozkjiew@fp55l4znck4o>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 12:41:57PM +0000, Rodrigo Alencar wrote:
> On 26/03/20 02:24PM, Andy Shevchenko wrote:
> > On Fri, Mar 20, 2026 at 12:08:41PM +0000, Rodrigo Alencar wrote:
> > > On 26/03/20 01:50PM, Andy Shevchenko wrote:
> > > > On Fri, Mar 20, 2026 at 11:16:32AM +0000, Rodrigo Alencar wrote:
> > > > > On 26/03/04 10:02AM, Rodrigo Alencar wrote:

...

> > > > > could you provide more feedback here? Thanks!
> > > > 
> > > > I don't know what new I can add here.
> > > > 
> > > > My suggestion was (and still is) to have something in *_strtoull() family
> > > > with additional checks added, but no limitations on the input string (i.e.
> > > > no max_chars).  If you look at the printf() code the max_chars was added
> > > > solely for scanf() and has no use otherwise (yes, I know about and aware
> > > > of initramfs case).
> > > 
> > > but is it include/linux/kstrtox.h the right place for this?
> > 
> > Seems so, there simple_strto*() are declared.
> > 
> > > *_strtoull familly... then can we just expose simple_strntoull(), which is
> > > private to lib/vsprintf.c, by changing its prototype to expose a error return?
> > 
> > Why do you need that? I'm lost, sorry, I don't understand this big desire of
> > having that max_chars parameter.
> > 
> > > In my case the limitation on the input string is useful for the truncation of
> > > decimal places when parsing the fixed point value. It would avoid a 64-bit
> > > division.
> > 
> > How is it better than checking the returned end pointer? Just treat anything
> > that parses too many digits after dot as invalid input?
> > 
> > 	ret = ..._strtoull(..., &end, &result);
> 
> here I would want to pass max_chars as the precision of the fixed point parsing
> 
> > 	if (ret)
> > 		return ret; // overflow!
> > 
> > 	if (end - start > $YOUR_LIMIT)
> > 		return -EINVAL; // bad input
> > 
> > 	...process result...
> 
> otherwise, here I would need to check the amount of parsed characters and
> perform a 64-bit division if it goes beyond the desired precision.
> Also, having max_chars allows for more flexible usage of the parsing function.
> 
> this is the prototype of simple_strntoull() that would be thinking on expose:
> 
> int simple_strntoull(const char *startp, char **endp,
> 		     unsigned long long *res, unsigned int base,
> 		     size_t max_chars)
> 
> that would also allow to drop the existing FIXME in simple_strntoull().

That's fine, but the prototype should be rather

int simple_strntoull(const char *startp, char **endp,
		     unsigned int base, size_t max_chars, unsigned long long *res)

> > Some (stupid) thoughts loudly. IIUC even if we implement '%g' in scanf(), it
> > wont help you as you want to have more precise values. Do I get it correct?
> 
> If I am parsing 3.14159265359 with 6 decimal precision I want to stop at:
> 
> frac = 141592
> int = 3

This is different to what strto*() usually do. From my p.o.v. this is simply
an invalid input, and TBH, the parsing of this is not as trivial as flooring
the result. One might want ceiling it, and see the difference when it's about
signed value. So, if one wants lesser precision they need to set the rules,
and not the library, because there are several rules that the user may want
to adjust.

P.S.
Avoiding division in your case is copying a (sub)string and using kstrto*() on it.
I believe it's always a room for 20-30 bytes on the stack for that, and it will be
much faster than division, indeed.

-- 
With Best Regards,
Andy Shevchenko


