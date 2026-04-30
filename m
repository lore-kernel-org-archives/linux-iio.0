Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC31B406269;
	Thu, 30 Apr 2026 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553882; cv=none; b=s4kXvd0Om1TxXqBwBWY7VeW6/U5Bd+vks1IMuv4FFrvnCdwM2+X7/h4D82YdV59AfCc0hzIBv0SAnStOHc0BYTXtMFNaCAr6yDOwOmOf990B4htTbkBhI5PCigrJ2weyLfJkctlthKtyQ+I3BQIHCLw5RWFXdx8Gw5GI58UZYiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553882; c=relaxed/simple;
	bh=10oTO4Su5mzg/uiU5vtv2y+YIzp9gag4OfR6EzO87ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcLj1lGDhRG8P4hnBbH+9iWUs3TWGzTzLe0lmmziw2JxzVXqGRifiUjFAYocizSJ61ZS47HYd9X3FjSvfh3D7135np2h5hbmAuTPbhE9VOtWqMz1zGTxpHq1PUoIBAn42EAP4cQbxcg3uSTUJG7u74WR2vxBhOAzZpj2r8peyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=asq2cwQ3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="asq2cwQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777553881; x=1809089881;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=10oTO4Su5mzg/uiU5vtv2y+YIzp9gag4OfR6EzO87ek=;
  b=asq2cwQ3ZCJCjjQSDdRGBHrIEXkGQg7XQl/6oJJ6f0BZ7p8avw/M6FG7
   VHLxcoKZdcOhZ0crR1XlNlZo0/h3bu0JnEXEXZr0e6J+ZtnT7J7r59AQJ
   wpifkCdWHQZnKS7jRQXgVUr29OC4kUK7mNVKqNW+j4QM4vZcdjM+1E/Tm
   vdz1AAlujaRfELAbx8/7ccAmb67NXtZyCN7pnBdpaO0OSNhksoaM0vMyd
   N/JORUpauLhOhpXLAZj/r5MIXqMBwKVySwEB2kWKtReF8tssGIOSSMTKX
   qFVMkK2koUCnJ8ydFDYBjrgAZQ1pNwR3IajJe8KmGbCw2tWg/8WP1+3vn
   g==;
X-CSE-ConnectionGUID: 2dlD8oAuTyqWSwF1s8teNg==
X-CSE-MsgGUID: h3TXiB3STYCeJi/yj9L/Fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="95921848"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="95921848"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:58:01 -0700
X-CSE-ConnectionGUID: GFaFi9CpQJWXU1x4wXmOdg==
X-CSE-MsgGUID: E545mgxvRKKzL82y6FK6KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="230228087"
Received: from zzombora-mobl1 (HELO localhost) ([10.245.244.42])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 05:57:58 -0700
Date: Thu, 30 Apr 2026 15:57:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:PNI RM3100 IIO DRIVER" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
Message-ID: <afNR1Apx86FeAcKd@ashevche-desk.local>
References: <20260430124148.11572-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430124148.11572-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 30, 2026 at 07:41:47AM -0500, Maxwell Doose wrote:
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

...

> +			ret = rm3100_regmap_bulk_read_locked(data, RM3100_REG_MX2 + 3 * bit,
> +							     data->buffer, 3);

Jonathan, if you feel to tweak this to make it shorter, I mentioned previously
this:

			ret = rm3100_regmap_bulk_read_locked(data,
							     RM3100_REG_MX2 + 3 * bit,
							     data->buffer, 3);

> +			if (ret < 0)
>  				goto done;

I confirm that my Rb stays with or without this change.
Maxwell, no need to resend for this.

-- 
With Best Regards,
Andy Shevchenko


