Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD1E33F383;
	Mon, 19 Oct 2026 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403619; cv=none; b=Qyes4ROMo+U3nSQOyHOePyWutSg6hAVhx40T9NCV5S99143tG9Bo/DHHN8e41ADbPLLiaRgmjyczeuY9H0y216GwqogeRo9W1N7ha6MVfkypUHwpuc00oVPWwGujoIZQxRRrJ1Y8X5bClUtKZ0xZMJYCY+Hj6UzelU3WogybDJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403619; c=relaxed/simple;
	bh=UAvQEyO7YcF5XflKLEHcE1A94egeQEcAvUo8vH2B5p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWfb0b0O6NZRevc3fmdHnUROm/zAPKVZwbz/TWz4YJG5GcntMvAFnRwlaD95FOxhw+mkOrbcqeR5R4DXtNiRLZcpmI2ATX4ViXq9QwI1Py1X4aYzSuOfVogjdnsdr9Z3HmaR1ovfnFAMUSnlrJtDOO6ITU4a/uO1kYR5j8ntriM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpxB26FN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpxB26FN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792403619; x=1823939619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UAvQEyO7YcF5XflKLEHcE1A94egeQEcAvUo8vH2B5p8=;
  b=lpxB26FNf9h2MdNf0QRlvLzA9Ag3UxWx7UlvSOcshLPUMqD/BbClw4Cb
   Fde4L8CXhElJSDHdJk8IuIWxPVEI7eEOAjHdJoW/72ZqhFQTiI7HMC0lw
   1Ne0GELkUhtHpVvByXPoRSvf9FwLOKjEp82YBqax7FJVB8j6O8v3UKHSL
   L36H8wrWcqKfrbmFMN5Ne2BbQpA4LYqCi0F+MnYLK0wlxHvC793/Oh42v
   eFeQNEcetl9ifGtZdJmDh0F1qlGPBX/God6wjiLhw8ajPa1e/gSiKtUdU
   ybmbR94/PsDL8fomNBck1Ts/VAYEFZhcAyNVPq/POhD3v7+FbXctpIma+
   A==;
X-CSE-ConnectionGUID: +75ddC3CSnC9YH+HYNt+tw==
X-CSE-MsgGUID: KirXmCmORxCBxoAkM50gNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1102566"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1102566"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:53:38 -0700
X-CSE-ConnectionGUID: 0seK9oIfTPqgkhf51t4w/Q==
X-CSE-MsgGUID: V3lz7EfPRzG6GAcDkbzy+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2873703"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:53:36 -0700
Date: Mon, 19 Oct 2026 12:53:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nithishvelan M <mnithishvelan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: impedance-analyzer: ad5933: use
 guard(mutex) in ad5933_show()
Message-ID: <atXoncij2_IrGjZZ@ashevche-desk.local>
References: <20261018200128.642-1-mnithishvelan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018200128.642-1-mnithishvelan@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 18, 2026 at 08:01:27PM +0000, Nithishvelan M wrote:
> Use guard(mutex) to automatically manage the state lock in
> ad5933_show(). This simplifies the function by allowing direct returns
> from each switch case, eliminating the mutable return variables and
> manual mutex_unlock() calls.

...

>  	switch ((u32)this_attr->address) {
>  	case AD5933_OUT_RANGE:
> -		len = sysfs_emit(buf, "%u\n",
> -				 st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
> -		break;
> +		return sysfs_emit(buf, "%u\n",
> +				  st->range_avail[(st->ctrl_hb >> 1) & 0x3]);

Keep it on a single (not so long) line.

		return sysfs_emit(buf, "%u\n", st->range_avail[(st->ctrl_hb >> 1) & 0x3]);

Most likely Sashiko might warn of use ctrl_hb variable as an index without
checking. So it might make sense to be prepared for that by adding a local
variable:

		unsigned int ridx = (st->ctrl_hb >> 1) & 0x03;

		return sysfs_emit(buf, "%u\n", st->range_avail[ridx]);


>  	case AD5933_OUT_RANGE_AVAIL:
> -		len = sysfs_emit(buf, "%u %u %u %u\n", st->range_avail[0],
> -				 st->range_avail[3], st->range_avail[2],
> -				 st->range_avail[1]);
> -		break;
> +		return sysfs_emit(buf, "%u %u %u %u\n", st->range_avail[0],
> +				  st->range_avail[3], st->range_avail[2],
> +				  st->range_avail[1]);

Split logically

		return sysfs_emit(buf, "%u %u %u %u\n",
				  st->range_avail[0], st->range_avail[3],
				  st->range_avail[2], st->range_avail[1]);

>  	case AD5933_OUT_SETTLING_CYCLES:
> -		len = sysfs_emit(buf, "%d\n", st->settling_cycles);
> -		break;
> +		return sysfs_emit(buf, "%d\n", st->settling_cycles);
>  	case AD5933_IN_PGA_GAIN:
> -		len = sysfs_emit(buf, "%s\n",
> -				 (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
> -				 "1" : "0.2");
> -		break;
> +		return sysfs_emit(buf, "%s\n",

> +				  (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
> +				  "1" : "0.2");

A single line

				  (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?  "1" : "0.2");

and, IIRC the operator precedences, the parentheses can be dropped.

>  	case AD5933_IN_PGA_GAIN_AVAIL:
> -		len = sysfs_emit(buf, "1 0.2\n");
> -		break;
> +		return sysfs_emit(buf, "1 0.2\n");
>  	case AD5933_FREQ_POINTS:
> -		len = sysfs_emit(buf, "%d\n", st->freq_points);
> -		break;
> +		return sysfs_emit(buf, "%d\n", st->freq_points);
>  	default:
> -		ret = -EINVAL;
> +		return -EINVAL;
>  	}

-- 
With Best Regards,
Andy Shevchenko


