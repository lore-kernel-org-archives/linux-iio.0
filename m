Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114373AFAEA;
	Sat, 15 Aug 2026 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786784025; cv=none; b=TYTsfhlYcENs4EQvau9TQYIjVGNJsUSOELI6bg10tEFOdp/PahAkEmnN6hVrDgGL73icvMwDgwhCqp0siAoos0eJeewiCRu/4SPqGQK4356VP65OSWvKaUhtD+Zwb0q9IyjS6U7T++mV7MWTyYHkLy+1WCNkqin50wFOVlP/PSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786784025; c=relaxed/simple;
	bh=V77R8LCca2Ig+XVCXUcPXJuZ7CUGYd3fpfJS55ELJXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9v4MZlH+sIKcp7C3sAwvDmGYm/+/ufTtRMwBWaPLsYZ6Ql7xMsRE0yOB+rey/MroS7oio6l/w2F6SC/CzRAHctyz4WLt77LT5FQeXtSSQ2V7HpHcF4qoiVpCDo3FdXz8BVj91lDCaTYApcftz5o4r8cMx1qFsh8cIDygpbSGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vy1SreFN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vy1SreFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786784024; x=1818320024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V77R8LCca2Ig+XVCXUcPXJuZ7CUGYd3fpfJS55ELJXc=;
  b=Vy1SreFNvZM3I/ccLl8DBXYdZBXZOUJ10oowJT6jAl27O+IIJrcdbM40
   P2DcYknyjZrQ8lMP4kbjL079kn9Ffz5R0kFHW32GZ6ozUM/EsiD38zrOW
   kTmWhCTATyJQxvkULvbdIhTarSc8AMZ0nVC+n4xSZ9M90G0Y0uvnDd/0I
   w65yvAqnajFhSDUxbH3owOD0aG3tRkL4l6OCUTwMTD1f1EwlCCaaYEKir
   pNXoQlEWNoMJwXLU4mWR9R4XzwQrtX0ON0wfk66LS0WG6sTMbGLY4bw70
   Yka/F7hSCV4182qmVoFszqonX0KKRZuQmCdD5poCg/GpB3HYbZbB80ipJ
   A==;
X-CSE-ConnectionGUID: R43v2z8FQ2yKJhW4MiuAww==
X-CSE-MsgGUID: enxfr/TgQHKx4EUGrcyaww==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="98706586"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="98706586"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 01:53:43 -0700
X-CSE-ConnectionGUID: 26jPdJUVRPGEmMhRL1PDhA==
X-CSE-MsgGUID: Klhhw8GtRkmDw6w85lCMcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="263100400"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.12])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 01:53:40 -0700
Date: Sat, 15 Aug 2026 11:53:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, grondon@gmail.com, linusw@kernel.org,
	hexlabsecurity@proton.me, sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: accel: bmc150: use aligned scan buffer for both
 trigger and fifo
Message-ID: <aoApEqsbXp9Pd7Mf@ashevche-desk.local>
References: <20260814101845.301769-1-yashsuthar983@gmail.com>
 <20260814101845.301769-2-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814101845.301769-2-yashsuthar983@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 03:48:42PM +0530, Yash Suthar wrote:
> Drop buffer as duplicate and s16 is not correct we needed __le16 as little
> endian, keep scan at the end of the bmc150_accel_data struct with
> IIO_DMA_MINALIGN, and use it for both paths.

...

>  	mutex_lock(&data->mutex);
>  	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
> -			       data->buffer, AXIS_MAX * 2);
> +			       data->scan.channels, AXIS_MAX * 2);
> +	if (!ret)
> +		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +						   pf->timestamp);
>  	mutex_unlock(&data->mutex);
> -	if (ret < 0)
> -		goto err_read;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> -					   pf->timestamp);
> -err_read:
>  	iio_trigger_notify_done(indio_dev->trig);

Vast of these lines do not need to be touched. Please, keep the usual pattern
of checking for errors first.

>  	return IRQ_HANDLED;

-- 
With Best Regards,
Andy Shevchenko


