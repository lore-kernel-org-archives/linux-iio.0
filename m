Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F2C3DF016;
	Mon, 18 May 2026 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089128; cv=none; b=Wc1GdZgNJUq45rb+/kMm75MlMqfNnLjHh/LHx4gbs9tTvj4mFcykozkHFgfMsZlZb3t0prBw8QjhKP6il5HAGxMeZDMnO0teBQwUH2vN4Ip1vKOGVX1lvg/OlgV1FGHAFpxMrcgNWosriJus8Tj+fxbQ1IK7pcDc8siiMJFkaj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089128; c=relaxed/simple;
	bh=vpWM/LbGKRwpcPirE1FTUixES7w+m6mOPdE9Sg7W1GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HU5ylSfw91uhqDtLCtfN95fVhn5X9YfuvAs4EvF4cibCGNCGjZymMVKw1Uoz61lnT8kjxFC+gI2papgrBIuGk/m/klBYuDCUuEYRgqJp9LtUSRxoZqmJ3fYVzvJdQTXziKBnr/EpVnDMt50f/91ZAw+Z9AEWcCxt9CaVEkv5uWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9D+I3zJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9D+I3zJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779089127; x=1810625127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vpWM/LbGKRwpcPirE1FTUixES7w+m6mOPdE9Sg7W1GA=;
  b=Q9D+I3zJDuUcH9P9B44G/v8obzL88ELo7FS+ovgEi7ZmDVag9IBfOSXJ
   pTEl+PEAXoiTMabB3lHISToMQyHESha3jz5CHmc9ejxwrnDvvCp2ZtAmg
   ggVW3XnBSQBw6N8FCFDGJoVPe16w+ij6VclcGiUVS/8eOhU7Q3VliPWvM
   A4tjpIvdwtXgYY11BQNBAqcAvoTT6wd+q90suXJ447Q12VbTHPDlPVyQ0
   9yCgUScdRZV8eqiWwbMa78M7//CNeae/pjZMh6cRc6UynbTfIIWvx6r1D
   ArF2bKF7BuKbeye9j1pnz3BilxwqHEI2XLrMH5RBwXp614C5r4Uns2aXb
   A==;
X-CSE-ConnectionGUID: GFYqrYWHRhe1nUug11azvQ==
X-CSE-MsgGUID: Qwtqgp1PQdCk3NICn10xjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="102608529"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="102608529"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:25:26 -0700
X-CSE-ConnectionGUID: u2iT4YJxRGKoKFdDVLY00Q==
X-CSE-MsgGUID: Wvuy77ErSWejdR2mf9MMFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="236712276"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:25:25 -0700
Date: Mon, 18 May 2026 10:25:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: common: ssp: remove SSP_CHAN_TIMESTAMP() macro
Message-ID: <agq-4keSvfshINQy@ashevche-desk.local>
References: <20260517-iio-ssp-timestamp-v1-1-228a9ed05c1b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517-iio-ssp-timestamp-v1-1-228a9ed05c1b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 17, 2026 at 12:29:35PM -0500, David Lechner wrote:
> Remove the SSP_CHAN_TIMESTAMP() macro and replace users with the
> IIO_CHAN_SOFT_TIMESTAMP() macro. The SSP_CHAN_TIMESTAMP() macro is
> identical to the IIO_CHAN_SOFT_TIMESTAMP() macro, so we don't need
> a separate macro for it.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


