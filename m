Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE3C3CAE66;
	Tue, 14 Apr 2026 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159861; cv=none; b=c81N1lNMAt0KLF3geGiT9JJ4cHso1EXwXXCHqMzhZX/9xXvFqqNzqkI1GFA9x8ksayLlIqqvjHVjtDpem7U/bCKAcJBQQoDDxl6PJb8DIqKUBiDAZ75e7Z2uwqsMUQDS09JI8cKDIoa3EBgjOFRQgk1LbeA9gUZGweRVfiRE+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159861; c=relaxed/simple;
	bh=6Jj16FGScif9hrQK/wJWezS+Rp94w5JuHfThcjOz7TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDYpE1SuOFSuBoVqtJ/miwMvvJb15Dz3d8BKuB1vydsHsuaOV0L2hNzGSSsSFSSHIJmkhu5+I6ZVrfsGx4SMeTEByzkxyzrsSl48aOv41lXPIa/fCQbq5LEUTGmtI+z54XYf8W0QL8vqMBwDKzYdHJrtPH+wPE47dN7A88KwZEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TfSBtvUh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TfSBtvUh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776159860; x=1807695860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Jj16FGScif9hrQK/wJWezS+Rp94w5JuHfThcjOz7TE=;
  b=TfSBtvUhMNkawkEhMY+b50yfYBpqMn5kmkdj0AriaDGNqErOh5Cqj1JX
   wZf39ktCIxxKO/g+qS302fi1InckCb0shl/v9rA+ww+CRN/PZcrV/lGSn
   ugPutdHJYwfZAy2Ho9aEqvJYceZ/crluESI/Nl8KNeY/zUHspPNZFXh1C
   dQrX2UqeFSj/x/04pLk7YIHcWtJy3XfHJe6moEW1INy/zWLd+JB1KU+ns
   ssyLFx6BIvFq8mif6opxD9a7LAeYEhwWttzC7TJpvNxWLdF0XgTiiJi4D
   w6KWkBPdGw84XZQ4pOCG3Z+Tn+jrHHARSSELubMPzLgAfnjyD1S2MYy7V
   Q==;
X-CSE-ConnectionGUID: ts1q1mCMQ9a8EfQr7CPqkw==
X-CSE-MsgGUID: H2fLSvj2RgmXMAJN2WuVBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="99755202"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="99755202"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:44:19 -0700
X-CSE-ConnectionGUID: HS5pf99rT/mGOztkREr+sA==
X-CSE-MsgGUID: 0fm1FUizSa+wAa0yOCqNxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253271534"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:44:16 -0700
Date: Tue, 14 Apr 2026 12:44:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: frequency: ad9832: simplify bitwise math
Message-ID: <ad4MbnpAfBEXKDzm@ashevche-desk.local>
References: <20260411123512.84739-1-joshua.crofts1@gmail.com>
 <20260411123512.84739-3-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411123512.84739-3-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 11, 2026 at 02:35:12PM +0200, Joshua Crofts wrote:
> Refactor the ad9832_calc_freqreg by adding a BIT_ULL()
> macro instead of manual bit shifting for better
> readability.

"While at it, switch to u64 type for the local variable
 that may hold big values."

...

> -	unsigned long long freqreg = (u64)fout *
> -				     (u64)((u64)1L << AD9832_FREQ_BITS);
> +	u64 freqreg = (u64)fout * BIT_ULL(AD9832_FREQ_BITS);

It can even be just like this:

	u64 freqreg = fout * BIT_ULL(AD9832_FREQ_BITS);

if I understand the integer promotion for unsigned types here
and the * operator correctly.

-- 
With Best Regards,
Andy Shevchenko


