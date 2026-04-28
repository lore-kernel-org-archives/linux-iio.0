Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC533D6F0;
	Tue, 28 Apr 2026 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395979; cv=none; b=UgEaDET8nb5FQtaCObCWJ3R1v2k37Zr7wB9ze9hpKBUVFdgs54/zoG9lgOZZpgxavt31ctXKi9MzDLWNuyrJGipH8M42PCpSPgTPI9Vj8i6ilIU7GG238V8i3IpH2nR8SG6ePvSgB03PiZDGsOOF8BgVJjJQlfkUExl/p+6HNKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395979; c=relaxed/simple;
	bh=O+rNYJ1EehedO+vWmOfClMYQFk8f3onpq9Asf3+GGbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmvlS+j0mASNWGNQ6Tw4J4jRzbqztpmHd1AaSmxVhP3cCLkNxyKm0ZINnbCf/invxU6vAGbvmCNgxA8eh80C5NI2aBT5x2NXTrAMZT140VuLQNh/D739zuircQ7hi8w0xnaIY3LAH0MswWIN12vi2lJt4ZnlpLWRvluAFjhqEqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQA+aVGh; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQA+aVGh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777395978; x=1808931978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O+rNYJ1EehedO+vWmOfClMYQFk8f3onpq9Asf3+GGbk=;
  b=SQA+aVGhxEN3WywQdJsNR8/l6P+O8sU+NJmroVjX3fLY2FVLIwbTMkga
   ZcpLVcjsndc2PKZ8H6IQCLVxG+GBJj0bmrqFQhVnfJ9aDBrUZu0HWlAVG
   5c8s5fMOAmEcBX5xTXw2GG/H1FWYldHKxf4hI8xQxJiHLcYzeG/nFGxtn
   AjwGpLOOS9S0iQvZWgK8sYg7ispWD4+doEIidiwQRWhMD8S9V0cC3rR8O
   TFElo7BqPvTxbtR4NWwesofIP5/09+5YCBqjzCl6tkVvcLae8XnUJijct
   AH+7NcJrZ8WI4asqgYkBnZ38OCcqY1Qif6C9+Iy97NLdADjV6uRTXmxNT
   Q==;
X-CSE-ConnectionGUID: wkp0tzisRIKiVPyGtKVMMQ==
X-CSE-MsgGUID: UXxRAOhBSRu9eVdaUHecyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89402453"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="89402453"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 10:06:17 -0700
X-CSE-ConnectionGUID: 0crLMVOJSlmXcSSZHxwNUQ==
X-CSE-MsgGUID: ddJfdcF1RFa2dbzYEU1pkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="257565377"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 10:06:15 -0700
Date: Tue, 28 Apr 2026 20:06:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v0 04/14] iio: magnetometer: ak8975: Inline timeout
 constants
Message-ID: <afDpBGa3N8Dd1L6y@ashevche-desk.local>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <20260427201412.3067235-5-andriy.shevchenko@linux.intel.com>
 <20260428172212.1e1bacd9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428172212.1e1bacd9@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 05:22:12PM +0100, Jonathan Cameron wrote:
> On Mon, 27 Apr 2026 22:09:49 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> >  	/* Wait for the conversion to complete. */
> >  	ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
> > -				AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
> > -				AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC,
> > +				10 * USEC_PER_MSEC, 500 * USEC_PER_MSEC,
> 
> I'm not that keen on these being repeated in two places given they take the same values.
> Perhaps we should push them up to the caller?  That is, add them as
> parameters of wait_completion_complete_gpio() and wait_completion_polled()
> 
> I don't mind if we have them hard coded into those two calls as they are right next
> to each other so it should be obvious they values are the same.
> 
> Ideally I'd like to see a comment on why these numbers next to those calls.
> 
> Fine to pass them in msecs and do the scaling here.  Just name the variables to
> make that clear.  poll_msecs timeout_msecs maybe?

I think we are fine with _ms, so poll_ms, timeout_ms.

For the completeness we may also give a timeout_ms to the third one
(and convert it to jiffies there).

-- 
With Best Regards,
Andy Shevchenko


