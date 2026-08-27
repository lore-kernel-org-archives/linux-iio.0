Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68205347500;
	Thu, 27 Aug 2026 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787813852; cv=none; b=oC0hOafuDJf4d8OQRCQsFtGwMiiYuV7OlvcDWb8xCxopICGw7OMaqE2ZTdyTWjMfBODXA6TG6WNgY7wsW9PGlPem9nwGFxqrNrWJUV7FzRCH6Sf9KIUR4FVTa08W66CQa2cLU6l7h4QVBRkD37ZJtfEqFl5vJaj/nh04/bVoLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787813852; c=relaxed/simple;
	bh=7QL0BDgHCFmRkHSyBe5whoh8fLCC31vux4EyoGOoBHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYr1jJnHOLWnALlNpRkC3OVPbmKax4+RJv9DqYv8htiO8CYGKO34OYVzPTow4rLxaUFXuxOChOT5HtX7BYD5VIw4AvrNx/Pl+Ahh/muppFK8ltFO6Fh8M+pKF78GueRLchkGlVeLI5784w0XoEAXiC8+lkTrgzC7oD0XZQQM5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDLfzpZb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDLfzpZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787813851; x=1819349851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7QL0BDgHCFmRkHSyBe5whoh8fLCC31vux4EyoGOoBHs=;
  b=oDLfzpZbMC3Mk7GW8U/dfuhqk/tcYXPBtkZM/FI1kQ/OVb/QC/EyuVRn
   9gXGCPdiTCExsmrcKpZRjiIkqbH/QyFW6dDz4UNKF72rZ/fa6555NTiSg
   tFboGPPqXzSf9XBan7tUar1WXJvXJaDWo3Ic8JQkdkqiYCf8QCco5/I2R
   llJwWjoQuuTM+YCmMpo8S2hGU/xSXzkxaBzmmdkH1EGpMKGvnFlsLCN0w
   wfOM/4cgcsfn728UkI/8RVqJH8953uv32aG25C151tNfRy9lmFb6eKOCJ
   aCSbmH3r1AjTO8FnNddu/xWbsYuRvUugUkKNgddt7Ua3sjg4thJJokfCU
   A==;
X-CSE-ConnectionGUID: DjesV1tzRmKcZljstpIKNQ==
X-CSE-MsgGUID: WkmjZl9pQXujXBz3lShgZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="113840844"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="113840844"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:57:30 -0700
X-CSE-ConnectionGUID: OZK5ic2qTYGPXWhItKDl1g==
X-CSE-MsgGUID: AsxHDvN9RO2A15cQTGc75w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="271593593"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 23:57:27 -0700
Date: Thu, 27 Aug 2026 09:57:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, grondon@gmail.com, linusw@kernel.org,
	hexlabsecurity@proton.me, sakari.ailus@linux.intel.com,
	srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: accel: bmc150: use aligned scan buffer for
 both trigger and fifo
Message-ID: <ao_f1XfoFd2ihO1I@ashevche-desk.local>
References: <20260825085156.212042-1-yashsuthar983@gmail.com>
 <20260825085156.212042-2-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825085156.212042-2-yashsuthar983@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 25, 2026 at 02:21:54PM +0530, Yash Suthar wrote:
> Drop buffer as duplicate and s16 is not correct we needed __le16 as little
> endian, keep scan at the end of the bmc150_accel_data struct with
> IIO_DMA_MINALIGN, and use it for both paths.
> 
> In trigger handle, replaced AXIS_MAX with sizeof(data->scan.channels).
> Additionally, ensure mutex is held across both read and push to get
> DMA safety for the scan buffer.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

>  	mutex_lock(&data->mutex);
>  	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
> -			       data->buffer, AXIS_MAX * 2);
> -	mutex_unlock(&data->mutex);

> +			       data->scan.channels,
> +			       sizeof(data->scan.channels));

I would put this on a single line (it is 81 characters only).

>  	if (ret < 0)
>  		goto err_read;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
>  					   pf->timestamp);

I would put this on a single line (it is 82 characters only).

>  err_read:
> +	mutex_unlock(&data->mutex);
>  	iio_trigger_notify_done(indio_dev->trig);

-- 
With Best Regards,
Andy Shevchenko


