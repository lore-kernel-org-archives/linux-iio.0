Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0461D34C155;
	Tue,  1 Sep 2026 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260931; cv=none; b=g0nDy0VnENok7VBWwon40njGa8ZQxglA5DtLqIz0y/y+3KX3dzhm+QEk+H2Pw4W3WtdjCvXOET6RC7ku+cL7Lf23Ic1MY19wznHkn+lp2j3jm04GUNtv3IVWpYtgZlyQZzhPIdOK+MEWT9UaEUxJlSiQ1u+Clhxm55gubM6+lqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260931; c=relaxed/simple;
	bh=UNKZkOMzPZIh28Hv7FYnWll/E5+0XCgiQO/XQp8ZPF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=km/Gicn2KLZx4VvYx4fuyeaCuwY5S1J4EJirn9LhYh5kADn7Dtoigp41T/WUU0eISUpuCv0AD25mFUD4yosnxEpmURvs51qIeYMcQ4mAycezPWL5LuNWQfeKQ8fMaZ1ctbWiae1o/YSHB7EtioW2RctTKSQEjb+ye3H/XR+hnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFPa+9AT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFPa+9AT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788260930; x=1819796930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UNKZkOMzPZIh28Hv7FYnWll/E5+0XCgiQO/XQp8ZPF4=;
  b=iFPa+9ATJLvCBtAMj9RheEOLiPIErzprOxFAmwJp7LRvXC4zGqFI3ELY
   7CTp+RAsXE54M9+fUD016zu1Jvb/lVOs1b/etNCM3uldok7G5aNJzfxTK
   PGSFT9HEbYmfHk5QmStXwvCgjeWX1FBKGtPPb+TWI7Pbla4jFHGaRME3y
   oCqZ4GnuEKWbJdhmkAgArmp86pYuYtxau0dlJVNU81yzHPy0LNA3pd7HP
   EKaUWYTe0QpUyYrKD86wIcf4kmpEei+fPQ/L2jmsDxna0Zn2YqWo1wPbk
   O7XYTfB48YQRLd1cZWTrGMBMB8UpEWdDjjYd8xb1p8hWJzVA4d3IqSgcE
   g==;
X-CSE-ConnectionGUID: PjPU9BzVSHmOJMs4IHMG7w==
X-CSE-MsgGUID: z1xFkxryTIixBnhlxybzzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="91199928"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="91199928"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 04:08:49 -0700
X-CSE-ConnectionGUID: D7QzytwNRGKxu51raKwFZw==
X-CSE-MsgGUID: 9NVgcpWzRtS+5wkvr2LN3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="272581352"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 04:08:45 -0700
Date: Tue, 1 Sep 2026 14:08:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: ad4030: fix invalid oversampling_ratio
 validation
Message-ID: <apayPCk4ln_Hh_Bb@ashevche-desk.local>
References: <20260901104243.48732-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901104243.48732-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 01, 2026 at 11:42:43AM +0100, Salah Triki wrote:
> In ad4030_set_avg_frame_len(), the logarithm is calculated before input
> validation. Passing zero or negative values leads to an undefined result
> from ilog2().
> 
> Validate that the input is strictly positive prior to computing its
> logarithm to ensure only valid values are processed.

...

> -	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> +	if (avg_val <= 0 || avg_val > ad4030_average_modes[last_avg_idx])
>  		return -EINVAL;

I still find '<= 0' confusing. Why not check against 1?
And I would rather see an additional comment.

What about

	/* Reject unsupported modes */
	if (avg_val > ad4030_average_modes[last_avg_idx])
		return -EINVAL;

	/* Avoid invalid values for logarithm since it's undefined */
	if (avg_val < 1)
// In this case, when condition is split, if (avg_val <= 0) is also possible
		return -EINVAL;

> +	avg_log2 = ilog2(avg_val);

-- 
With Best Regards,
Andy Shevchenko


