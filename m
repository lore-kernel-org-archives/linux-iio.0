Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B4536F411;
	Fri, 20 Mar 2026 08:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994275; cv=none; b=CXpTXgG5GcMvUjZLswf2uoVV3QskLp1VoponW4ymIAtqCj8ZN5Cn8tiYIv2IEvq+VzZyRVifpRf3YvL1s4CUr9deOk8JUAmv49QH+roVpilPmGXTMujuKfGoSGL0rQyekVjE8h01PCpaBrHUaUPdIBaQe9JE19Q6x3X3MZwpm6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994275; c=relaxed/simple;
	bh=8WsYe6FPCoE11M6qR+y+iEQxG9P9e9ux0yeaBqWG84o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7VjwZqtooyXxdAGSf9LiKC+ZMagna2QN0LrOpbCY7KAc13uY3p9MUCNuMmmFIEmMdXHNw75lZd3db2vFYvrbvzCdbAt/1FTWIvjczH3xxT5+EnbcYGbcm3pH4XpdCJsBMcLATkYxjabSpzdlDnbmfh9MiwrwuWz8lfnrFIsrIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fd/fG0Hr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fd/fG0Hr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994274; x=1805530274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8WsYe6FPCoE11M6qR+y+iEQxG9P9e9ux0yeaBqWG84o=;
  b=Fd/fG0Hr7u3AiX5TRIliGtpWWIymW30jSCqOVrfqE4xk9Ma7gmlWjVtA
   8DSl5CMgvBZFwvZ5mAxVJqU2/3JvfWnAaJixztJZbB/VVZOANj4A7MRTQ
   dWL0apDNZws1mxOUskdeBd6U8L6OoRnumDHlIoqlFuv0Wzjcvk8W/B7be
   JBrnNejPRLf/Agq/Eeah7Z/5FTaol+2eiWwsNBMQga1ghZYMo6vDFDWmq
   aJ6f5xjtTfM6lk1cb676FyMLKsM6kRh7zju/9dkZIGMxeqXlQLAAXgD2f
   Me0X1TdArK+zbxS/8IWi7/Tj4kF70cXOF1fXmO1yRqwpL13027DRAH4/M
   g==;
X-CSE-ConnectionGUID: gcHosQwsQuuk1PnPxKsRKA==
X-CSE-MsgGUID: bQGEWM4qTsejp39EifX5MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="78934562"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="78934562"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:11:13 -0700
X-CSE-ConnectionGUID: 6HgcTtb3R9SotLU9+9Tcyg==
X-CSE-MsgGUID: NqQI3KNaTha0z5RUOf4/cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227345047"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:11:10 -0700
Date: Fri, 20 Mar 2026 10:11:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gabriel Rondon <grondon@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: iio: ad5933: use sysfs_emit() in show
 functions
Message-ID: <ab0BHU8zNOUIAcJf@ashevche-desk.local>
References: <20260319225719.73587-1-grondon@gmail.com>
 <20260319225719.73587-3-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319225719.73587-3-grondon@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 19, 2026 at 10:57:18PM +0000, Gabriel Rondon wrote:
> Replace sprintf() with sysfs_emit() in all sysfs attribute show
> functions. sysfs_emit() is the preferred API for sysfs callbacks as
> it is aware of the PAGE_SIZE buffer limit. No functional change.

...

> -	return sprintf(buf, "%d\n", (int)freqreg);
> +	return sysfs_emit(buf, "%d\n", (int)freqreg);

Why casting? Can you also address that by using the correct specifier
instead of %d?

...

>  	switch ((u32)this_attr->address) {
>  	case AD5933_OUT_RANGE:
> -		len = sprintf(buf, "%u\n",
> -			      st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
> +		len = sysfs_emit(buf, "%u\n",
> +				 st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
>  		break;
>  	case AD5933_OUT_RANGE_AVAIL:
> -		len = sprintf(buf, "%u %u %u %u\n", st->range_avail[0],
> -			      st->range_avail[3], st->range_avail[2],
> -			      st->range_avail[1]);
> +		len = sysfs_emit(buf, "%u %u %u %u\n", st->range_avail[0],
> +				 st->range_avail[3], st->range_avail[2],
> +				 st->range_avail[1]);
>  		break;
>  	case AD5933_OUT_SETTLING_CYCLES:
> -		len = sprintf(buf, "%d\n", st->settling_cycles);
> +		len = sysfs_emit(buf, "%d\n", st->settling_cycles);
>  		break;
>  	case AD5933_IN_PGA_GAIN:
> -		len = sprintf(buf, "%s\n",
> -			      (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
> -			      "1" : "0.2");
> +		len = sysfs_emit(buf, "%s\n",
> +				 (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
> +				 "1" : "0.2");
>  		break;
>  	case AD5933_IN_PGA_GAIN_AVAIL:
> -		len = sprintf(buf, "1 0.2\n");
> +		len = sysfs_emit(buf, "1 0.2\n");
>  		break;
>  	case AD5933_FREQ_POINTS:
> -		len = sprintf(buf, "%d\n", st->freq_points);
> +		len = sysfs_emit(buf, "%d\n", st->freq_points);
>  		break;

I believe the entire function should be resplit to use a unique one
for each sysfs node. Also IIO has different approaches for static lists
in the _avail nodes.


-- 
With Best Regards,
Andy Shevchenko


