Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6561E2C21F4;
	Wed, 11 Feb 2026 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799466; cv=none; b=L+/W6vfQ9O/BHNW7apS3ZVSwTAT92ZSjwRFs/SEi0Rrv0n+pfdDXEB9a+ItP9KBMJkBKDDOWrbewXgSKChKgqxw6diNqMPxvmDYQSKWiVc3lu8UJgUCfzWNS8VrBaUEnanpSXS7AIX6/0zGNuc1YOLhSb6APu9+lrKoPN+YPT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799466; c=relaxed/simple;
	bh=5BaXDmEkowd/i15uptERR54Lt6BQJN2wU5SUKFbkadA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czhmkuSrKSLuYISYebp8cch7iWHRzTXSF4i6AbpKiYPYWyqeqFaQurnHW6JNlAkxInOGn0hOxYXWh7/XlBNzryNMyourZRxAQfd7Yg4rTLug35FT8+7Vard4ZCBwPmntCLzuiPlfAOECEHu/qHOx/ktiH/8N7LRklTCp4E5Ze5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecbEZbO7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecbEZbO7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770799465; x=1802335465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5BaXDmEkowd/i15uptERR54Lt6BQJN2wU5SUKFbkadA=;
  b=ecbEZbO7xvCuVvMb5zA/UytIx3UXOuopDJOMpcQbpsC/+4VlJlqdBmIO
   yC/N9uFX3sLOioYx36Ypexvvs05xsTVE2JjYW5EzQcWGY/3kj1gtD+Fys
   vrLBmwW2inVt9WalHps3QW4i2i22s3UzE0lBTAZj89UTR5pm3X651+U7l
   V6NVX4UdlOfpAgkiyfaIaR7e6KhD2SqcoeoJzJDGV5pQNM++1jvzBZZHU
   2C9+2KKWPg0VO0O+fYDaKtnRzvl6g0/tsJKUGv3ObOXgyzUNrHJV8cMeI
   AdE1RZKalGkKruUvTGBfnaM9qVF9ZUHKgppHTsdWsfS2IMXBbioiBtCZf
   A==;
X-CSE-ConnectionGUID: ZT5ZalNnQ+ux8iBdQ9bWnQ==
X-CSE-MsgGUID: Dl1S02i+TRiNQl4GXCY7Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89531777"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="89531777"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:44:25 -0800
X-CSE-ConnectionGUID: Ayf2MqayQWGpWDxRjBHqRg==
X-CSE-MsgGUID: Dj0AsNM1QVOAVar0wZKi0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="249827652"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:44:24 -0800
Date: Wed, 11 Feb 2026 10:44:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap020a00f: Correct return type to int
Message-ID: <aYxBZGJZ8q0Wa2xs@smile.fi.intel.com>
References: <20260211004819.854169-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211004819.854169-1-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 10, 2026 at 06:48:19PM -0600, Ethan Tidmore wrote:
> The function gp2ap020a00f_get_thresh_reg() can return type -EINVAL in
> its error path. Yet, the function has return type of u8. Added error
> checking for gp2ap020a00f_get_thresh_reg() return's value.

...

> -static u8 gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
> +static int gp2ap020a00f_get_thresh_reg(const struct iio_chan_spec *chan,
>  					     enum iio_event_direction event_dir)

While at it, correct the indentation of the second line.

...

>  	mutex_lock(&data->lock);
>  
>  	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);

> +

Drop this blank line.

> +	if (thresh_reg_l < 0) {
> +		err = thresh_reg_l;
> +		goto error_unlock;
> +	}

>  	thresh_reg_l = gp2ap020a00f_get_thresh_reg(chan, dir);

>  

Ditto, no blank line between an assignment and a conditional that checks
the value.

> +	if (thresh_reg_l < 0) {
> +		err = thresh_reg_l;
> +		goto error_unlock;
> +	}

-- 
With Best Regards,
Andy Shevchenko


