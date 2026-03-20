Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF23AA517;
	Fri, 20 Mar 2026 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007420; cv=none; b=VtvMz9JYOkA7REgF+PSlliz3NaEmsn00Xwtzy2mkAGZdYdoP8/u/6gRKm/ZcuDKov0ISoENEx7ygwvRtLp8T7c0FolkM+vY/6JEd5VIBcmUray0VbFu3j5nLJMJ96cmhf9tOvH7Snfn0g1Dhnp681kTFSbm+aZTpK8+8jG9XzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007420; c=relaxed/simple;
	bh=k2Ux2aWImiPiBRYhz9t4krfISTTvT7OqcLHKH8Hgdiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv2fnXFNdS0+GEp+iNzAco5iDcvYqb+uKVf8Rhs7L9FQtFjaWPHUnr1VrZbcWhxmCH/hJIdyRqEX6ld45YtWboWxSal1kZ2ZYRy9RwM9c/USbYjZ8yzXa9di7DlBmkRDDBAWke7YWuLslpoLIoruHacdyD8U1ArAlmquIi0qNy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMygCkNn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMygCkNn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774007417; x=1805543417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k2Ux2aWImiPiBRYhz9t4krfISTTvT7OqcLHKH8Hgdiw=;
  b=SMygCkNnOkmRoZpExPl751ss2lpWAzJ7k/hShyRlxq6gY/McZOhKqDvA
   7P43nVMQ6kw69732K5xTQRkq87YNaW/7C0SBK4Q/IVOjWrULmSn3B4Wlw
   GaoQAqpJAkvZkyJ9uzdobdZDL4lv8z/BqZV4fkGONUh9gRUvQCicBNnH4
   sI7eSXVCz92hJfUcCNuKUYd38n0nvGklcFFwZ2PvycXnKLER7wiXcugis
   unxFprCglwInling/XntjZO+0zcbVLv+h+P/4V2K2QDNgOWiRDZMh4BeA
   WlUg3Tzk0YzedN36vhlZCDjx33CMAJEKGXBDPtLoCv0iZHM3VawiYKKr8
   Q==;
X-CSE-ConnectionGUID: k5Aa0UIIQU2ACy6P9/ZCwA==
X-CSE-MsgGUID: qM184sglSQiOBvQ/AVxxow==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100545430"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="100545430"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 04:50:16 -0700
X-CSE-ConnectionGUID: 0MAUj6p9QX6QyMqzUYi6AQ==
X-CSE-MsgGUID: PLxY4bP6Rjy831F3P4oHRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="261164313"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 04:50:13 -0700
Date: Fri, 20 Mar 2026 13:50:10 +0200
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
Message-ID: <ab00clb7LL-bmJWe@ashevche-desk.local>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
 <20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
 <aabm23jCikXs1l6F@ashevche-desk.local>
 <qcloiwjlbehs4yyuttvrt46monh7isef4d5nzuwlaby6uxfael@j3trvc5jwosy>
 <4mtdzxfj656sjr66npabfvrr7yd7q26l2unhsihjtniz4ossfj@g3qnzonoary6>
 <rygken7oujyoupeanrdnl7r7smesa7js6sn3jsafbajc4sm3jh@adeslfqwwf3x>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rygken7oujyoupeanrdnl7r7smesa7js6sn3jsafbajc4sm3jh@adeslfqwwf3x>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 11:16:32AM +0000, Rodrigo Alencar wrote:
> On 26/03/04 10:02AM, Rodrigo Alencar wrote:
> > On 26/03/03 02:16PM, Rodrigo Alencar wrote:
> > > On 26/03/03 03:49PM, Andy Shevchenko wrote:
> > > > On Tue, Mar 03, 2026 at 01:27:07PM +0000, Rodrigo Alencar via B4 Relay wrote:
> > > > 
> > > > > Add kstrntoull() function, which converts a string to an ULL with a max
> > > > > character limit. The function is an alternative integer parsing function
> > > > > that does not require a null-terminated string. It becomes a better option
> > > > 
> > > > null -->  NUL
> > > > 
> > > > > over simple_strtoull() or kstrtoull() when parsing integers from a buffer
> > > > > with custom delimiters without having to create temporary copies.
> > > > > The function is consumed inside the implementation _kstrtoull(),
> > > > > promoting reuse.
> > > > 
> > > > But this will not properly convert 0000000000000000000000000000000000000000100,
> > > > for example, if the max_chars say set to 20.
> > > 
> > > Why would I want that? truncation will happen in the case and the value will
> > > be zero. max_chars can be zet to INT_MAX/SIZE_MAX if you want to get 100.
> > > 
> > > > Also kstrto*() have a common idea behind to consume the only \n and allowed
> > > > digits. This (naming) doesn't fit into the kstrto*() category.
> > > 
> > > mmm ok, but include/linux/kstrtox.h is the right place for this? how about just
> > > strntoull()? I feel like a safe_ prefix does not make much sense if it is
> > > only to differentiate from simple_strto*(), which should have been safe at
> > > the first place.
> > 
> > Also kstrntoull() does not really match kstrto*(), as the 'n' is often used
> > to indicate a stop condition on amount of characters, which would not need
> > to require any termination character at all.
> > The 'k' prefix was add to 'strntoull', mostly because the function is being
> > added to the include/linux/kstrtox.h file. Other names I could think off:
> > - bounded_strtoull()
> > - bstrtoull() - 'b' for bounded
> > - bstrntoull()
> > - strtoull_bounded()
> > - strtoull_limit()
> > - safe_strntoull() - emphasizes overflow safety over simple_strtoull()
> > 
> > Extras considerations:
> > - Single-letter prefixes (bstrntoull, lstrntoull, etc.) are too cryptic
> > for a public API
> > - safe_ prefix is subjective and doesn't describe the actual behavior
> > 
> > kstrntoull() is still my first candidate, other than that it would be
> > bounded_strtoull().
> 
> could you provide more feedback here? Thanks!

I don't know what new I can add here.

My suggestion was (and still is) to have something in *_strtoull() family
with additional checks added, but no limitations on the input string (i.e.
no max_chars).  If you look at the printf() code the max_chars was added
solely for scanf() and has no use otherwise (yes, I know about and aware
of initramfs case).

-- 
With Best Regards,
Andy Shevchenko


