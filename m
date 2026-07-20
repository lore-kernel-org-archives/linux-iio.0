Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE8036EA8B;
	Mon, 20 Jul 2026 11:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547001; cv=none; b=Ug93w2fnRDgbp1qFxuUAqjUf2u24gzL57QZ0Q4eLNdZRlA9DQpeStHtnvfeEsNCXEZbxhJ8jgHZTCzrcthP2cTvO2AZRKw7+5rg1ZEAc4t3y4Wh+ZXw9WBCCo3OCh8Xp0LCSnOwfvUD9RtJXkbfE6WtLBjnmRYtOK547qQPDL0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547001; c=relaxed/simple;
	bh=kIcIhIbK3vVTNFmbrkJC8tCSP4DHpt5hFH7fS7W79W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1kIIapTbuMM8PTIYL55yROLJkCWMs4ub2wSxy1bpZ/gjFO2LoYVMkAfr9GrusCbKsHCCYa05rrw35XEKCC29cKBuf8XZCPjtYcDYoZ3WEmD6pnAcytCzWHGpwPcbK4xePFZehA0pkwMQ7pxXRrtsJs7/bzWH9/b7Ln0N3LBhSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N96FYfbp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N96FYfbp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784546999; x=1816082999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kIcIhIbK3vVTNFmbrkJC8tCSP4DHpt5hFH7fS7W79W4=;
  b=N96FYfbpGHdhi/QMUV5/kJh7vMgmuqxx7g0w8hrbe0ba9Ro4H0wLK58Y
   zPYnQyeWFFD/WfdKPWelkUfd2dji1L4GPcutf5TaHBfFNPMRVVHJmX1Wt
   ue7chXUXgUmsiC2o20E3jDyhbobVzmXkBQ2j/dYXlb7YjsCOFRvPxaPCX
   s8rUSySpHPLzM3uVJVXqqETboKitpZrgJ4KdJRxrElsc0oekRwrJiaorw
   X52aMjX6Sjc0ep9aSo80cK36SGgvQk4+f2b1wcFqOSsX48bebLPS5FaYj
   lyAehqSkXu9f04r7n/PJ8D2pTU3yRQTuQwwCJwhUrsMdELbWhvvFtntPU
   Q==;
X-CSE-ConnectionGUID: ljd9UDBnTjq37y5xNrdqKw==
X-CSE-MsgGUID: mIJP49cNRXy6mWRtXyYQFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="96488384"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="96488384"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:29:57 -0700
X-CSE-ConnectionGUID: drW0RLIcQ/u8SW8aqL+SUw==
X-CSE-MsgGUID: mF9NP215TDuI9ID0TukRkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; 
   d="scan'208";a="281903304"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.175])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 04:29:55 -0700
Date: Mon, 20 Jul 2026 14:29:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: inv_sensors: convert to kernel types
Message-ID: <al4GseUNqFlMMF70@ashevche-desk.local>
References: <20260720-iio-common-inv-sensors-timestamp-rework-v2-0-aec31446809c@tdk.com>
 <20260720-iio-common-inv-sensors-timestamp-rework-v2-1-aec31446809c@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720-iio-common-inv-sensors-timestamp-rework-v2-1-aec31446809c@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 20, 2026 at 12:38:32PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

> Convert standard types (u)intXX_t to kernel type u/sXX.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  void inv_sensors_timestamp_apply_odr(struct inv_sensors_timestamp *ts,
> -				     uint32_t fifo_period, size_t fifo_nb,
> +				     u32 fifo_period, size_t fifo_nb,
>  				     unsigned int fifo_no)
>  {
> -	int64_t interval;
> -	uint32_t fifo_mult;
> +	s64 interval;
> +	u32 fifo_mult;

It makes sense to also amend the ordering to follow reversed xmas tree.
(On a glance there are more places, but let Jonathan to tweak if he feels
 so.)

-- 
With Best Regards,
Andy Shevchenko


