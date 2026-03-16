Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77F39A06C;
	Mon, 16 Mar 2026 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669422; cv=none; b=H8FGVh/+Fr0LpRPQr1RTar6AZoLT98gVT+z5vSoRp2IeK8C8VmANIqLwQzfCXqc9ZkqjRrfltcdJwQy6k/Q2/TYwI7DG2k+MsGQnUUml7e0HpqaHUkq+gTrTaT/A44AsxEtMGThkzpvRlQl1U61NsJlCduQUh9WPHQF0AUPw8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669422; c=relaxed/simple;
	bh=Js8fsx9vQnD+oPA+yaKk85KablrktexWsla1PbwhS+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l69/Lnh4UhaU0AoS6Wjr0RpSyK/0o7kKMYoeWHsYmrlgvZXBUhJalhdyZ9fizRm9rmWgYDEhaL/+Vcf+wL0iLtFu1q5i9y5G9QKNv135kpGxN9UzoBEbqXxj4DJZqe8lfglfTvLhNLx1auMofcVpnbW8ai2zqbSxlD1jSVWxIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NaKMmjO1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NaKMmjO1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773669421; x=1805205421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Js8fsx9vQnD+oPA+yaKk85KablrktexWsla1PbwhS+w=;
  b=NaKMmjO19h13npnShiUHoflqKY1xekIottILQUZwtIXTtvgp6/L0iHtt
   DZ/sOO2OjctAwmEBLmmZw9kEYl4szKHyOIxRS7iZtLrz21EUWslfDowOB
   9x122JNCxHlSacGOLRexmAgEdy4/wc6AGgHBA2AFabI//DXFCb5k785UC
   E6+7CA3kb421x2969bOqcw4D/W8puzSmf5wwnUIQkUTy4OxRxGGI7mbky
   BCDMnrtAQafBq5wFim/eVA1KrmuXe40IEdmJkdUOeHthR323+qRRoDxPD
   88bmZhWGetBYTeBXJ7Sj/qwXiUz4IZju9JLRLpQmnCjHAbgx/cSHogRvX
   g==;
X-CSE-ConnectionGUID: pzJ4VdeKSzavOUCIq5vGSQ==
X-CSE-MsgGUID: Y4ZoT9NTSMidjIjznoFvJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73700360"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="73700360"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 06:56:31 -0700
X-CSE-ConnectionGUID: pYFVNjWgRMW1TegSiLjx5g==
X-CSE-MsgGUID: dC+4uWnUSWW/+Q6qBVMJaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226382281"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 06:56:29 -0700
Date: Mon, 16 Mar 2026 15:56:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti-adc161s626: fix buffer read on
 big-endian
Message-ID: <abgMCgp8JIUigQLq@ashevche-desk.local>
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
 <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-1-56243b11e87b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-1-56243b11e87b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 06:13:31PM -0500, David Lechner wrote:
> Rework ti_adc_trigger_handler() to properly handle data on big-endian
> architectures. The scan data format is 16-bit CPU-endian, so we can't
> cast it to a int * on big-endian and expect it to work. Instead, we
> introduce a local int variable to read the data into, and then copy it
> to the buffer.
> 
> Since the buffer isn't passed to any SPI functions, we don't need it to
> be DMA-safe. So we can drop it from the driver data struct and just
> use stack memory for the scan data.
> 
> Since there is only one data value (plus timestamp), we don't need an
> array and can just declare a struct with the correct data type instead.
> 
> Also fix alignment of iio_get_time_ns() to ( while we are touching this.

...

>  	struct iio_poll_func *pf = private;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ti_adc_data *data = iio_priv(indio_dev);

> +	int ret, val;

Can this be put after the 'scan'?

> +	struct {
> +		s16 data;
> +		aligned_s64 timestamp;
> +	} scan = { };
> +
> +	ret = ti_adc_read_measurement(data, &indio_dev->channels[0], &val);

> +	if (!ret) {

Personally I prefer goto approach over unusual pattern and TAB indentation.

> +		scan.data = val;
> +		iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> +						   iio_get_time_ns(indio_dev));
> +	}
>  
> +	ret = ti_adc_read_measurement(data, &indio_dev->channels[0], &val);

	if (ret)
		goto exit_notify_done;

	scan.data = val;
	// Also can we consider moving towards new API?
	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));

exit_notify_done:

>  	iio_trigger_notify_done(indio_dev->trig);

-- 
With Best Regards,
Andy Shevchenko


