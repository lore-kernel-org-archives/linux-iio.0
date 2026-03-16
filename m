Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9CC37C0F1;
	Mon, 16 Mar 2026 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656127; cv=none; b=LM5OpQiy4oX9OJmG4l5gm3LWRUCCq0zqlelS/xbJqtUhx1igtR5eiByY805VdzIGrOfKTunXYmoWwfScox7cYniShyKyqpUKcImjc8oC7MTxS6OkPWLu436yisJRIKdKfQ+C4hSGkM/UJExzZy3995D4Y1tsVyM3EMKJAynczjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656127; c=relaxed/simple;
	bh=vY29cWqRnr3YbqfTvrLrabpL0G4X8yTIx7yS+USS6MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrKHHzm5g3d8FEZHyy8BzdOjd/BhSXC2IvixPIvLGHi2jLlXoXuzHhH5dbaxkd+UkVmcCY0sgMlD9bmh3T7jalTYV1eqbHQrnHSzoSuaOtGsp0nAhih9bdYrElCuz6O4Q8Mkfu2i7DBgwHvAt+4qdlNVyGzf9tjy2YLdBI4Jb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiCEzlnz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiCEzlnz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773656125; x=1805192125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vY29cWqRnr3YbqfTvrLrabpL0G4X8yTIx7yS+USS6MM=;
  b=SiCEzlnzUBcNc5IGeIsSt3xg8kSQ5w1K+5XyVkLZy5anulAVhd95/ryN
   TRUR3/xywMUGyY2bi84zpYhfa6HHUTZ1d5zk4bnh0bD9+nA1YZmViztGV
   Rc1ZV5rPb1neQKkoCdLui9um2e24IgfrIGETeYJE1uHxfMWc3js2QyC7o
   Q3ei3xInQOFEiyVm9bEy93Es0dIJe7teliFqWqWMaapBpYxtQi6XQNeD1
   4OYhlR4fcqFcyNMtAasfHU6uT9Xa08PGZhm74kxDsHRmI04qAL5l02UM0
   0y5JTMvbpQTeH6g19VzJEuMxlbNQkT5hFioCdoOktrNQpDF8z6ga0MzOs
   Q==;
X-CSE-ConnectionGUID: mpp8UFh9Rq+Ytce1E/BuJg==
X-CSE-MsgGUID: HlD4kraKT8+tfzuzqNsDXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="85368688"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="85368688"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:15:24 -0700
X-CSE-ConnectionGUID: 29/mWe93Q0uKpGvs7TlvGQ==
X-CSE-MsgGUID: 5+FjK84kRVKDmIz4xtLJ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="225990371"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:15:22 -0700
Date: Mon, 16 Mar 2026 12:15:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Parthiban Nallathambi <pn@denx.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: vcnl4035: fix scan buffer on big-endian
Message-ID: <abfYN9gszSSb83J9@ashevche-desk.local>
References: <20260314-iio-light-vcnl4035c-clean-up-scan-buf-v1-1-400d273eb026@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-iio-light-vcnl4035c-clean-up-scan-buf-v1-1-400d273eb026@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 05:18:10PM -0500, David Lechner wrote:
> Rework vcnl4035_trigger_consumer_handler() so that we are not passing
> what should be a u16 value as an int * to regmap_read(). This won't
> work on bit endian systems.
> 
> Instead, add a new unsigned int variable to pass to regmap_read(). Then
> copy that value into the buffer struct.
> 
> The buffer array is replaced with a struct since there is only one value
> being read. This allows us to use the correct u16 data type and has a
> side-effect of simplifying the alignment specification.
> 
> Also fix the endianness of the scan format from little-endian to CPU
> endianness. Since we are using regmap to read the value, it will be
> CPU-endian.

...

> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> -					iio_get_time_ns(indio_dev));
> +
> +	buffer.als_data = val;
> +	iio_push_to_buffers_with_timestamp(indio_dev, &buffer,
> +					   iio_get_time_ns(indio_dev));

Do you have plans to drop this old API as well?

-- 
With Best Regards,
Andy Shevchenko


