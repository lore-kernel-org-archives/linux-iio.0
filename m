Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7A4207A;
	Thu, 30 Apr 2026 06:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777530674; cv=none; b=aJ7heRsyKBmLDYTHynwHBzLAivbT9zNahP9ycA5pryR/PivG/3LBN1TZkIMU5Gt3hVvg5F6+bFMjKNJUKr9+JLoO7+RbK3yGPFoRMW31KVQ3B9tSphO7BCuR9B4NMXJgzseiXlfvGFgGFGGtG3V8hVal+QGZy8q8KtPaUrKJR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777530674; c=relaxed/simple;
	bh=OB4hxB7F3L4bZHAgT1pzISmFISINn/7A6YXRiVLuPL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVOBlP4L2cg2k4F3Csmb6G5tj4N12a4jjuAA4bNG7/KmLLwvg9LCIUJVUk1D8wVvSnyc9vJxvhIyXV7Qogs7YmpntOcN7M74K3/ZKYDrXu67X1df4DqYP9hD5U5h/GRXET26GYEs8GfRlbCBy8Cky8BvcfjRl+EPlcz86PHUfYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ebfoCVv9; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ebfoCVv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777530672; x=1809066672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OB4hxB7F3L4bZHAgT1pzISmFISINn/7A6YXRiVLuPL8=;
  b=ebfoCVv9oBpcY6L7rqgvQO9q5krlBXizXAF5WP20tONjm4VoyqpoZzU7
   UXCKQKcaFjAvPp223lNm7I8uxR8Tq85i8oPz1ESzYMI2ZDXvcRIM4moKh
   80eSCPryHcrX002FzIikD1LwTTEk6NViTqBZYhhEpagn1HlUy71hbg3m6
   ObszwYliHVsIt2Zsr+qzmJJwYEgTtZeqrmNQjp1v1FiFDXhug+4s5aoBM
   mq1AB0OpmlmzxoX6zDZITowSb8joD6flRcTvUnBJNxYwu8NGycvsJ+uln
   Cn5GTfBJkWb6kGFInZRxRTlHmxa2knDhaVk7yIYiw6Tpa3BZ3VjFtQNZJ
   g==;
X-CSE-ConnectionGUID: rJhPO5YlRsqOMcbIlm4Ymg==
X-CSE-MsgGUID: y7z7WxFITB6j4sMGXfeeoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89566424"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="89566424"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 23:31:12 -0700
X-CSE-ConnectionGUID: FAR4e7xNRBGLlSOiwTcbfg==
X-CSE-MsgGUID: RRLJmGPbR6KKihybIbb0/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="238815006"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.244.42])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 23:31:10 -0700
Date: Thu, 30 Apr 2026 09:31:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:PNI RM3100 IIO DRIVER" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
Message-ID: <afL3K_xeOrjIIQ_X@ashevche-desk.local>
References: <20260430021439.67591-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430021439.67591-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 09:14:39PM -0500, Maxwell Doose wrote:
> Replace mutex_lock() and mutex_unlock() calls in rm3100-core.c with
> the more modern guard(mutex)() family. This will help modernize the
> driver and bring it up-to-date with modern available macros/functions.
> 
> While replacing mutex_lock() and mutex_unlock(), the critical sections
> of rm3100_read_mag() and rm3100_get_samp_freq() have been extended to
> include negligible operations for cleaner logic.
> 
> Add new helper-wrapper function rm3100_guarded_regmap_bulk_read() to
> help keep rm3100_trigger_handler() switch-cases clean while maintaining
> mutex locking and avoiding re-entrancy risks from potential callbacks.
> 
> While at it, remove redundant gotos where applicable, and use direct
> returns instead. In addition, remove regmap variable in
> rm3100_trigger_handler() as its references have been replaced with
> variable data.

Almost there, a couple of minor issues and feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

(Side note:
 compare this change to ACPI PMIC one, you see what I have told about
 in that thread.)

...

> +/**
> + * rm3100_guarded_regmap_bulk_read() - Wrapper around regmap_bulk_read() with a mutex

Always validate kernel-doc

	scripts/kernel-doc -v -none -Wall -- $FILE


You forgot to update function name here.

> + * @data: Data structure containing regmap and mutex
> + * @reg: First register to be read from, passed to regmap_bulk_read()
> + * @val: Pointer to store read value, in native register size for device,
> + * passed to regmap_bulk_read()
> + * @val_count: Number of registers to read, passed to regmap_bulk_read()
> + *
> + * Intended for use only in rm3100_trigger_handler().
> + *
> + * Return:
> + * A value of zero on success, a negative errno in error cases.
> + */

...

>  		for_each_set_bit(bit, &scan_mask, mask_len) {
> -			ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * bit,
> -					       data->buffer, 3);
> -			if (ret < 0) {
> -				mutex_unlock(&data->lock);
> +			ret = rm3100_regmap_bulk_read_locked(data, RM3100_REG_MX2 + 3 * bit,
> +							     data->buffer, 3);

			ret = rm3100_regmap_bulk_read_locked(data,
							     RM3100_REG_MX2 + 3 * bit,
							     data->buffer, 3);

> +			if (ret < 0)
>  				goto done;
> -			}
>  		}

-- 
With Best Regards,
Andy Shevchenko


