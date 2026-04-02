Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5BF3E558A;
	Thu,  2 Apr 2026 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146370; cv=none; b=fWvnrRC0kNvImMhVhgtM2USsGIUzR8xBh2J4XHTC3uy3Ol5Jc47JP7/+vzQSbbVNgjV/33eiTRnsPvwSTtRIrIGlrcrR/Hn4hllrruhda33TxJQQZkp/6/K0+LpW2ZXGFFkcWt2pqvw16M2GRnHRulGYzCInQPCdl0kZu+CWt0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146370; c=relaxed/simple;
	bh=jJTiBYBIB5CT8zd/d/a+k0YMZldcj8zdAJP7LpFG0L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLDuNnSyWOiXyDhlNiTY/e8O+xJPmzJTElzilZ9csbu3IKaHSQX5kJIley76ZcFne6gxPKiPRrNxxu1IJ2WyL3GXYBhWNYxuJ9y4+ITqD8o7uWeyDjm7kuwbubu1YdvZNchYv5td++LDGgMM8vz2ZkHBAwdOuMNWWJEGIECp/Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhJeVYQY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhJeVYQY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775146364; x=1806682364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jJTiBYBIB5CT8zd/d/a+k0YMZldcj8zdAJP7LpFG0L8=;
  b=mhJeVYQYuPwcb1I1AUKdZTMvs/yasQ9/uPPx8ciNo/j4wbiOL8+HC2MZ
   QHk2fcKQVrlDNCukYRHWcCHVAovpqmWJsjtaSTmIDml1QGH6yPvWrSaW+
   YVpA8Rl7HIIvKomYl1gStO/gNj3VpZZmQNJ0KZO/52dr+ZixYWOrlE+or
   QdwXp90fax4cvNkj0r1NoFWV9y2gsIaJbTUoJMSAntz0Ej18MAEUUZh8f
   XxoO5qksIIanjbFhENgYN+NLBcSrEfM8nm3bZ1zca8B/6NM9oLxk+roXo
   nSnbun1BzlDSbs9bC/Kxr+hOEfgaMrYjncKq1VINzPKmROu0QDeNxW0l+
   A==;
X-CSE-ConnectionGUID: 8mzph2mLSYy9asHCzRDlEQ==
X-CSE-MsgGUID: rQgWvaNPSCazJcIUKxzG6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76327301"
X-IronPort-AV: E=Sophos;i="6.23,156,1770624000"; 
   d="scan'208";a="76327301"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 09:12:44 -0700
X-CSE-ConnectionGUID: Rp222jsnR5Ojelx8yxgCLA==
X-CSE-MsgGUID: Uaf9i3fVQO2IcQsXgm7wmQ==
X-ExtLoop1: 1
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.31])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 09:12:41 -0700
Date: Thu, 2 Apr 2026 19:12:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, ktsai@capellamicro.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 2/2] iio: light: cm3323: use dev_err_probe() in probe path
Message-ID: <ac6Vd0YM06tJXzJO@ashevche-desk.local>
References: <20260402151730.18901-1-aldocontelk@gmail.com>
 <20260402151730.18901-3-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402151730.18901-3-aldocontelk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 02, 2026 at 05:17:30PM +0200, Aldo Conte wrote:
> Replace dev_err() calls with dev_err_probe() in cm3323_init() and
> cm3323_probe(). cm3323_init() is called by cm3323_probe() ,  so using
> dev_err_probe() ensures that deferred probing is handled
> correctly and simplifies error paths.
> 
> Remove the redundant error message in cm3323_probe().
> 
> Tested on a Raspberry Pi 3B using i2c-stub. The driver probes
> successfully and successfully read integration_time after this change.

...

> +		return dev_err_probe(&data->client->dev, ret,
> +				     "Error reading reg_conf\n");

Add

	struct device *dev = &data->client->dev;

at the top of the function and make these just to be one-liners.

-- 
With Best Regards,
Andy Shevchenko


