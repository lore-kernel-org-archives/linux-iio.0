Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068CC277C9D;
	Wed, 29 Apr 2026 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472365; cv=none; b=gHShVPeasTI03wVVduwzl27lktou78KyLJvRMj7e7CAlTZfiHg1dWEQuuCAPFbhhpg9OGBAF5BCFy+Pdlv9xJdHNuEXZOY2hNgC8ZaAPU4269t1XEG46N1AUHJG7IGXhJJLMjpqV/ntpfDYw7VnkNDJPZpjjbxQ+08LnNPGIf0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472365; c=relaxed/simple;
	bh=Y12ZlerCy0I/McJ3SbkKfbe+JaHpZy8Bpzacwg6wGfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/HGpH1OPfNVzme+ZWmefnM4X0iHw9WsvtBpGb259W1aK9E9Xot3a/+seOwL/0riPelES4inUQZL/eBefp0WtRCm2f840dD4xOz5uXBUuwUI03JgzU6XNq8voN7MeBpNQ8eaYAMVR9Uk5dF4vGrK11Yfk+dw+rfCo8LZAHUtvKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXfB0IM7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXfB0IM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777472364; x=1809008364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y12ZlerCy0I/McJ3SbkKfbe+JaHpZy8Bpzacwg6wGfc=;
  b=FXfB0IM7SCwxzENaBC0kMtcpkyomGb62B/3Htv8dXrQ1FUkeBgd0EhOI
   SHHj6Oms7zK+2tjm3TAmyr+C6up8pQZM6waTKlUKTwpxH7TIgNZ/eOTcM
   Mj/Uwqjfs/b0PTQ6hN/RkIRTefl3ZorOr+tedpPOVa/jfO9MR9KK2rUI/
   wobCqimo5kuwab/p21CXdCsgc8JBFQucZI7xJtceHIeLPUaE7ZbVG8DAW
   GzE6V6TiY5qYO2EhaNApP6ugJ+pwMAQclReJeKzusW5wTy6hg1LAp4BN7
   hTE0QXIfKfRxvR8hzAOfEb+KRCZ2Y8eUzcj+mOzlihqvmf2UUl3AqolRk
   g==;
X-CSE-ConnectionGUID: 8MVflsaLRh6zL8bqOQvGeg==
X-CSE-MsgGUID: AZnEUHU2TICgJFrp+jYwUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88998857"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="88998857"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:19:23 -0700
X-CSE-ConnectionGUID: IiP9hSemR4q/XoW5SzcMEw==
X-CSE-MsgGUID: S4cqQdjARjGH1qcSnnPzmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="233255895"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:19:20 -0700
Date: Wed, 29 Apr 2026 17:19:17 +0300
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
Subject: Re: [PATCH v4 10/13] iio: dac: ad5686: remove powerdown mask magic
 number
Message-ID: <afITZQhexjXMM1qu@ashevche-desk.local>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
 <20260429-ad5686-fixes-v4-10-bb8f1cbd68e1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-ad5686-fixes-v4-10-bb8f1cbd68e1@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 02:07:40PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Define macro AD5686_PD_MSK to hold powerdown mask value.

...

> -	return ((st->pwr_down_mode >> shift) & 0x3) - 1;
> +	return ((st->pwr_down_mode >> shift) & AD5686_PD_MSK) - 1;

I believe you want two macros that shifts that accordingly.

#define AD5686_PD_MSK			GENMASK(1, 0)
#define AD5686_GET_PD_MSK(shift)	(AD5686_PD_MSK << shift)
#define AD5686_GET_PD_BITS(mode, shift)	(((mode) >> shift) & AD5686_PD_MSK)

But this all seems like reinventing a wheel, id est
FIELD_GET()/FIELD_PREP()/FIELD_MODIFY() from bitfield.h.

...

> -	st->pwr_down_mode &= ~(0x3 << shift);
> -	st->pwr_down_mode |= (mode + 1) << shift;
> +	st->pwr_down_mode &= ~(AD5686_PD_MSK << shift);
> +	st->pwr_down_mode |= ((mode + 1) & AD5686_PD_MSK) << shift;

This is FIELD_MODIFY()

...

> -	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask & (0x3 << shift)));
> +	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask & (AD5686_PD_MSK << shift)));

FIELD_GET()

...

>  	if (readin)
> -		st->pwr_down_mask |= 0x3 << ad5686_pd_mask_shift(chan);
> +		st->pwr_down_mask |= AD5686_PD_MSK << ad5686_pd_mask_shift(chan);
>  	else
> -		st->pwr_down_mask &= ~(0x3 << ad5686_pd_mask_shift(chan));
> +		st->pwr_down_mask &= ~(AD5686_PD_MSK << ad5686_pd_mask_shift(chan));

FIELD_MODIFY()

...

>  		shift = ad5686_pd_mask_shift(&st->chip_info->channels[i]);
> -		st->pwr_down_mask &= ~(0x3 << shift); /* powered up state */
> -		st->pwr_down_mode &= ~(0x3 << shift);
> +		st->pwr_down_mask &= ~(AD5686_PD_MSK << shift); /* powered up state */
> +		st->pwr_down_mode &= ~(AD5686_PD_MSK << shift);

FIELD_MODIFY()

>  	}

...

Since these require some shifts at run-time perhaps better to have helpers
that will do all needed stuff in one call.

-- 
With Best Regards,
Andy Shevchenko


