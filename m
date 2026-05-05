Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C5F25A655;
	Tue,  5 May 2026 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985946; cv=none; b=eLhE7LnVgHQIHRq4cQ91SStiAgJ/pN6LoIasUO1KJ14eI+dNxeoYG/iC1JLHofVFSJZ1585TudpNjoWgW8SvqXjhtW6BoV5QGfjWJaPMdEdFkt3wduPy7dGrjHafvG0oeG3ilKAqYIW1mClYpcyDhDdx65yl8O0aLQ6izfzQENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985946; c=relaxed/simple;
	bh=YDWud8J4IITZXxrPrxoIOq3325oO5EirR/dvdtm0698=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhZaTJ7ZoxTC4X/qQ54XYW2EgMtijCMJo5z1c2n7g+MEmbgtUJLf5fVYzijnA1bGqsvWqGUmBuKEaETNc7c+ZypyPE79vhfyoKWW+tix5BXdM6I/HfcGFIei3Bs3e9tE+oufepFWyLS88GKd/miUKyHpxzyQwMPl3KaFHU5WfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHt4nUCj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHt4nUCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777985944; x=1809521944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YDWud8J4IITZXxrPrxoIOq3325oO5EirR/dvdtm0698=;
  b=kHt4nUCjWMmK7VjzYz90RRUwneX/ilUSKdsOcn3ZiVefH0dzFDCCYhqU
   sxS9VWvMEsbLKI4Aua8YCbTvKPuRu6bQja0uaXML6SulpE76vZm31RyST
   FQpjOb3DAWP6qSrHcD//5Jc2Ry/FnnVcddf5MUnOl6SRPo0pluXYxE/DX
   aqkZE74pEEtCaF38XFt3CmYs1iWZLwFV/dTrQ4rTA4Pwv7Fb7+QqghqTS
   pGGKKmAbKi6Fp5hnsEenopz/vEccfhbrRjWIH2bX+OmMqvNEtE9DvLlHV
   AquLCPOausWl9osdIXSEahjgWdbETgb3fzADIIv1ZpDy2amjL1eL0t9fB
   g==;
X-CSE-ConnectionGUID: wfnB7dV7QLSvIidoq7hgvA==
X-CSE-MsgGUID: FXdvY/tHTDimshnoaM3Klw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="89447549"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="89447549"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 05:59:02 -0700
X-CSE-ConnectionGUID: CzA+BRgMSqOpT+awZrZSGw==
X-CSE-MsgGUID: hPB2iYxnSA6dYUCvtc69Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="266145469"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 05:58:59 -0700
Date: Tue, 5 May 2026 15:58:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 03/12] iio: dac: ad5686: acquire lock when doing
 powerdown control
Message-ID: <afnpkRLOn7ZDzSj-@ashevche-desk.local>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
 <20260505-ad5686-fixes-v6-3-c2d5f7be32be@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-ad5686-fixes-v6-3-c2d5f7be32be@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 01:35:04PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Protect access of pwr_down_mode and pwr_down_mask fields with existing
> mutex lock. Each channel exposes their own attributes for controlling
> powerdown modes and powerdown state. This fixes potential race conditions
> as those the write functions perform non-atomic read-modify-write
> operations to those pwr_down_* fields. This issue exists since the ad5686
> driver was first introduced.

...

> static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  
> +	guard(mutex)(&st->lock);
> +
>  	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
>  				       (0x3 << (chan->channel * 2))));

Why not use ad5686_get_powerdown_mode() instead?

>  }

...

> static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> +	guard(mutex)(&st->lock);
> +
>  	if (readin)
>  		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
>  	else

Similar question here...

-- 
With Best Regards,
Andy Shevchenko


