Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBFF3A16A2;
	Thu, 26 Mar 2026 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774550424; cv=none; b=FHIhn0jgVT4gGcjVfiDs9UzaaLjhmjesePjG2FBnaW4IHUEVHALIgfPpAHW0/Ak8vnuTeDkOd6imV+zI58CoT8Byj1KaRJhFsuyVcrooIqgA+QdhhXNvl/qBJqg/JXLFUbeBNLW/0oVlduI0mJGPEuE/TviAWwN/+3cC3qnbW9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774550424; c=relaxed/simple;
	bh=tvnHWeNCjPdPATfWPZgdcn7WnJAgTmIx9i1QRoWiu1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQ5M08MiErw22qqjPhn+4UAmv1ITWM0yBg0cZjXXmsSH2kDpYAMo9/ABNM0tm6c92MJEdKtllp1BBPiAccu3PBwBB/UOGmy1HAukMkWXCjwEVNYdylHdD/Fvdo9xvhWSVO8yTQf8H7hF3egT6JPIf5b8chTbh+BTI3mRj6YEkAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j676UKtQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j676UKtQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774550423; x=1806086423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tvnHWeNCjPdPATfWPZgdcn7WnJAgTmIx9i1QRoWiu1U=;
  b=j676UKtQMP+tx5IHZ9Aj0YGVY3A1Fi1Nz0dnp0ipK1hNRdi7kZB4/EkH
   UNoiu/cu8D5wAMHFygYaCxSxi9fMlDaBOjejaa9SU4EBVIloNQLDnSgyp
   PXXTDF4ziVtnTS7DI/HpYixx9sbO4kqIcRS2SUROutqrc8mw5CVuzZq4F
   z2ZdSZhbaDZR2vC5J00i04UUj8ujNYwcr+b12aYktjbTcwhH+VU1dMv26
   qiRUmtcRCNDiaUgp9KMG+0L8fBhvu4oIZ709RTk4hoCjlA711aBFbeBaX
   fItEd8KJ3B84NvyORDOhTqSR8xZB60NJm/IOvtSv+T05MlKFuhYiE7AMl
   g==;
X-CSE-ConnectionGUID: OoRgEf3uTP+MpF/bXYvI3A==
X-CSE-MsgGUID: 0/1b3cdmRH21Psji5DM6kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75335831"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75335831"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 11:40:23 -0700
X-CSE-ConnectionGUID: zzcsNcpKSIiNFo813Ucszg==
X-CSE-MsgGUID: rGMNUOAkS7i/NOiEtTHyew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="248460025"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 11:40:19 -0700
Date: Thu, 26 Mar 2026 20:40:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: veml6070: Fix resource leak in probe error
 path
Message-ID: <acV9kcmPr9Xegd9O@ashevche-desk.local>
References: <20260326-veml6070-v1-1-5d79022e76f1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-veml6070-v1-1-5d79022e76f1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 08:11:42PM +0800, Felix Gu wrote:
> The original code registered the i2c dummy device cleanup via
> devm_add_action_or_reset() after i2c_new_dummy_device(). If probe
> failed between these two calls, the dummy device would leak.

I see what you meant by reading the code, but the above is simply wrong.

The

	ret = i2c_new_dummy_device();
	if (ret)
		return ret; // "probe failed between these two calls"

	ret = devm_add_action_or_reset();

Please, rephrase.

> Use devm_i2c_new_dummy_device() which registers cleanup atomically
> with device creation, eliminating the error-path window.

With the fixed commit message
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


