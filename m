Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4F3ACF1A;
	Fri, 20 Mar 2026 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774009456; cv=none; b=mHTNzjCe4RR/1bxkE5cBqw+PMMCGhO9o5dUWVX1GZLkAWz/MOMzLWqveLPM1PJbFgfNcGrXHDD0BmDNywWQqeS97TNdXbAI2xH/G8CEmRVQuXpMZkRG96RlzCE2IjK4vmCtDtFrK1lzIUHD+ggF39gutcwNgZxOoSwGkdQ3bj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774009456; c=relaxed/simple;
	bh=kXdtIQsgXEinGhMSEwdoG3L66k14q9FpQSx3NwhGOos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tusIpciC0wyOmpl/t+51OkOEYP7Cxt7GAgT1w5fEVz/b+LSMi4qA3DEcn3NaCwfdgrlXq4COnJk96J3qlVxJEgd4kSz91YKpso57RQGR6a2EmtJybnh0oBw2rlGbGB1AuNQOJG1lpBRF6FjhHwjSHQsLPycH1wkmD6DvTgP6Ppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6CoI4TP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6CoI4TP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774009454; x=1805545454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kXdtIQsgXEinGhMSEwdoG3L66k14q9FpQSx3NwhGOos=;
  b=V6CoI4TPTdPlQZhH5T1jClXnfS9ije2zeaC+pLsMl/WmB6CAxY4nolsO
   zTZZJ7EQ6/2h5/8DHlGzCdYRFfJ7pYWYU7R49WS0wMDSY5qvRiKLACyub
   Di7kLRf6ZZ7/dH3Nql8s/penywLo08K4q3+yxdeL76SdQgx9SwyWKNhjL
   Urun4BIzFHZdrOs36F5yCg5Uel434pOHu/71+SaNjcFQIj5fqWjfvLosL
   tGGOS0ZUAKZ+o116g4+H3lT8yBy2FM9WpmUkEy+JHZUxYgGxoMYIthJnN
   d7OfYExudYkP4U6vCsLJ/Mmj8n0uTnPGSQgs0NXv8Cl/etSK9OVEsHVlw
   Q==;
X-CSE-ConnectionGUID: qvioHfjOQhyrXHTbWHc4hg==
X-CSE-MsgGUID: LgiHtUK1RtKsPO0NMIp7fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75002228"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="75002228"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 05:24:14 -0700
X-CSE-ConnectionGUID: MB/c61LnQYiDQ4mVhpUG1Q==
X-CSE-MsgGUID: m+GeijHTS0634HJNhaVxIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="218632505"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 05:24:10 -0700
Date: Fri, 20 Mar 2026 14:24:08 +0200
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
Message-ID: <ab08aHbudFWEtLi8@ashevche-desk.local>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
 <20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
 <aabm23jCikXs1l6F@ashevche-desk.local>
 <qcloiwjlbehs4yyuttvrt46monh7isef4d5nzuwlaby6uxfael@j3trvc5jwosy>
 <4mtdzxfj656sjr66npabfvrr7yd7q26l2unhsihjtniz4ossfj@g3qnzonoary6>
 <rygken7oujyoupeanrdnl7r7smesa7js6sn3jsafbajc4sm3jh@adeslfqwwf3x>
 <ab00clb7LL-bmJWe@ashevche-desk.local>
 <ixvzb5mni2lhz733f4fvvzhozmpezkx5s2q7sash3wv3u2g7ov@pgs6pve6kxrq>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ixvzb5mni2lhz733f4fvvzhozmpezkx5s2q7sash3wv3u2g7ov@pgs6pve6kxrq>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 12:08:41PM +0000, Rodrigo Alencar wrote:
> On 26/03/20 01:50PM, Andy Shevchenko wrote:
> > On Fri, Mar 20, 2026 at 11:16:32AM +0000, Rodrigo Alencar wrote:
> > > On 26/03/04 10:02AM, Rodrigo Alencar wrote:

...

> > > could you provide more feedback here? Thanks!
> > 
> > I don't know what new I can add here.
> > 
> > My suggestion was (and still is) to have something in *_strtoull() family
> > with additional checks added, but no limitations on the input string (i.e.
> > no max_chars).  If you look at the printf() code the max_chars was added
> > solely for scanf() and has no use otherwise (yes, I know about and aware
> > of initramfs case).
> 
> but is it include/linux/kstrtox.h the right place for this?

Seems so, there simple_strto*() are declared.

> *_strtoull familly... then can we just expose simple_strntoull(), which is
> private to lib/vsprintf.c, by changing its prototype to expose a error return?

Why do you need that? I'm lost, sorry, I don't understand this big desire of
having that max_chars parameter.

> In my case the limitation on the input string is useful for the truncation of
> decimal places when parsing the fixed point value. It would avoid a 64-bit
> division.

How is it better than checking the returned end pointer? Just treat anything
that parses too many digits after dot as invalid input?

	ret = ..._strtoull(..., &end, &result);
	if (ret)
		return ret; // overflow!

	if (end - start > $YOUR_LIMIT)
		return -EINVAL; // bad input

	...process result...

...

Some (stupid) thoughts loudly. IIUC even if we implement '%g' in scanf(), it
wont help you as you want to have more precise values. Do I get it correct?

-- 
With Best Regards,
Andy Shevchenko


