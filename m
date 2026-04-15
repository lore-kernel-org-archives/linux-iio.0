Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4402340DB8
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248452; cv=none; b=GVGD8q46LJwT2ADbfU0xDYULFhTKhH2QmS/s04SkReI0PNmk4yPeGiprJQbwEYfpzT28HfOuhpyQDHBbNF6A2kkcl7Skww4lkBHg86MGLx63taMsPcWMfXVzPl5Cd5PAuyKrZq29WkDH0HsDM1utHBBDEFOZToX1ZxtFDBeGY0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248452; c=relaxed/simple;
	bh=o8V2mSjkukuASl+hizraNrm/4irsMdwMYrHZc5n5qhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AudqGh4B7ftWPoL6biq9CET3+HV0HAZA4fvBsHsilkTe9hDWt1/jjUTpobRtfiy38xl234y2ydoJZmVSRl+1re/o7jYOPKOQE3x+kwBOiwMqfKzFB1FRO6lT8twSVIzMgu09Plmjqx0OTOjpVE7fsuZUsevhra4k8gX/T4+S+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfo03vkp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfo03vkp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776248451; x=1807784451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o8V2mSjkukuASl+hizraNrm/4irsMdwMYrHZc5n5qhc=;
  b=nfo03vkp2Y6qIqk9ENRZO5kA/WCsrp6C6U/MPle9rhDJQTIiRQQ9RNjV
   UM50rEOYkYtbPVt8JyqUnDwtOBtVrsXjav3VUuIYhhLZD/01rZ4/+3XZs
   i0zX+fM1BueiZtW4iYvWl6R1JRMa7M9E5hvTEtU+pjTKmPqEzPI/xaVce
   /qssSC4hUQi8uRQGhjCSftPGctwy8thUrNZAKeKZKqlTnLABQFTp8vR5Q
   3Rg99VwnmEun8hOJC25MebSnzULJdpB+ReGbkTSg79datz5UD9IToXHVj
   vQ4so8wFdeM9tizQRRQe7S/F7I3QmhxTd1vcG5hCtHAo/doxHFl4/AvJV
   A==;
X-CSE-ConnectionGUID: P0mPPfr2Q1aFxnUP/kKMLw==
X-CSE-MsgGUID: eJulRDxwSIGdSMJI43U5ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="79804886"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="79804886"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 03:20:50 -0700
X-CSE-ConnectionGUID: 8b/ufIiXQrayIaAoKKBGmw==
X-CSE-MsgGUID: LO6YG8amSQyjo5xlq4bB0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="260800043"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 03:20:49 -0700
Date: Wed, 15 Apr 2026 13:20:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erick Henrique <erick.henrique.rodrigues@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dac: m62332: Use guard(mutex) for locking
Message-ID: <ad9mfuQ0wZpqiZTT@ashevche-desk.local>
References: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 08:39:10PM -0300, Erick Henrique wrote:
> Replace mutex_lock()/mutex_unlock() calls with guard(mutex)() to
> simplify locking and make cleanup automatic when the lock goes out
> of scope.

...

>  	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
>  	if (res >= 0 && res != ARRAY_SIZE(outbuf))
>  		res = -EIO;
>  	if (res < 0)
> -		goto out;
> +		return res;

Now it may be rewritten to drop for additional < 0 check:

	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
	if (res < 0)
		return res;
	if (res != ARRAY_SIZE(outbuf))
		return -EIO;

-- 
With Best Regards,
Andy Shevchenko


