Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C934E777;
	Wed, 29 Apr 2026 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777490872; cv=none; b=o/G2MsjfzPCzLRfKan8cRq5e0LXA0kROBQvllHSrhCk8zAquLse4gRDMB/GKZfmGO+QWt2/ovfSJFVZuPtvUAjNmbb6flHYXgnu2duXprkSHoxKE1/IWAzQ3hxlGW6W+PJOc2MiTNmZk7jXrgIvnIbo0IrHZjch8OqXt+ARxy2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777490872; c=relaxed/simple;
	bh=pByWYPh08ownNdyxFOrSJX9TZDW32WVPALUiaFKvnmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHkay5NI5yt6C3fvbywgFH6lRRZ4aoC8uV6xEFDU8LwR0UTaIoJd6iqD+Ya2IqholYi6oVxDh2RydUmwcOaoXXmC4M8Bl98Xb3tUKfvdYAr/+4SvOzGgz0eg9hkxnev2PgTfGhgckBwjM8xyWApx2vii7InV7v+NnNSK1OX++OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kAeo0t1i; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kAeo0t1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777490871; x=1809026871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pByWYPh08ownNdyxFOrSJX9TZDW32WVPALUiaFKvnmA=;
  b=kAeo0t1i4GmXJ0dK/w+pEMOjnK5N3kioY3DXEwzBmziirKRnhlFa2MRb
   Qz4GmklDxgZc6D9libYxdeYk2A+sPfBr6MNJZ5xqMT4jg2UxT8+rBBA92
   EHAaDd57gvZ4jBMmcICOB53w5R6BMtRJX/MinwOet8CEsBEkoy0AOwIFj
   jocFJydd4BNdXvdmjI6y6GzUSK0YeR6X7Hg1BNtzUzQA9G0mU6hRPx0Cd
   7x4g3sh5z+8/hXTdJPP9KhBW1xHwqG8gEzBwQCqWxAEUnxRnB3+yB8vA5
   +rhOrIbr12JdtbkXeNsJuo6FHdWTyBfjXr2b+eQSGlKY9Q+JFFtoTXQLu
   A==;
X-CSE-ConnectionGUID: M2JYkIscQZKl1CNc338TiQ==
X-CSE-MsgGUID: k8zB9IDYTtKSVfZq5jiSXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="77458223"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="77458223"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:27:50 -0700
X-CSE-ConnectionGUID: dPF0smezSnWXZSomsLwc5Q==
X-CSE-MsgGUID: VJL6HMFWTAyFlfqhAfon+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="234630231"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:27:48 -0700
Date: Wed, 29 Apr 2026 22:27:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] iio: light: si1133: prevent race condition on
 timeout
Message-ID: <afJbshe8SURhqKqA@ashevche-desk.local>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
 <20260429-si1133-checkup-v3-8-469f21d960eb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-si1133-checkup-v3-8-469f21d960eb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 05:04:56PM +0200, Joshua Crofts via B4 Relay wrote:

> Sashiko reported a bug where the si1133_command exits on timeout
> without halting the sensor or masking the interrupt. If the sensor
> completes the command later, any subsequent command to the sensor
> will cause the IRQ handler to complete immediately, returning stale
> data to the driver all while the command hasn't finished yet, shifting
> all potential reads in the future.
> 
> Fix this by masking the IRQ if wait_for_completion_timeout() fails.
> When initiating a new command, do a dummy read of the IRQ_STATUS
> register and turn the IRQ back on.

> Closes: https://sashiko.dev/#/message/20260428-si1133-checkup-v2-5-70ad14bfefe2%40gmail.com
> Assisted-by: gemini:gemini-3.1-pro-preview
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

Reported-by?

Also with this seems the Fixes tag is appropriate (and in the other patch).
Also note, fixes should go first in the series.

...

> -		if (!wait_for_completion_timeout(&data->completion, timeout))
> +		if (!wait_for_completion_timeout(&data->completion, timeout)) {
> +			/* Mask the IRQ to prevent delayed interrupt waking up
> +			 * any subsequent command.
> +			 */
> +			regmap_write(data->regmap, SI1133_REG_IRQ_ENABLE, 0);
>  			return -ETIMEDOUT;
> +		}

Seems like you dropped {} and reinstantiated them. It's not good style. Just
make sure that the first patch that does something leaves it in the form that
next patches won't have too many + or - lines that basically revert previous
subchanges. I call this style ping-pong and highly discourage from using it.

...

>  			/*

> -			 * reset counter on err to prevent sofware and hardware
> -			 * counters being out of sync
> +			 * Reset counter on err to prevent sofware and hardware
> +			 * counters being out of sync.
>  			 */

Ha-ha, doesn't belong to this change (see also previous reply).

-- 
With Best Regards,
Andy Shevchenko


