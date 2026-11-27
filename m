Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795778503;
	b=ybMhTlfZC6RkOU/A3bTxCctKRAQm5ZMJIG/vrWg+QhRTZbhUvsaHTrfgZuUacTROoJXA
	 j10yxYPaVTSqPUhB7woAPXztUBdgwQaFJLAK6uKrllcrgB2pphJJZVvxLOtciRAe0v1sD
	 qqbGRqhqkDpLDOz89hP6jirYIzBU12KGAGdalXr4JLN11s1vMJQVT0GPot/OK3LWTsvcV
	 6j3XVGh0xAOUx+MO+Rih4qcW6tvmqEMfeafWRW9Um1sr2lysuuh8j755zgbchfjLo41Hy
	 7T4Bdw4HngNOUHrm0mrJaPON2uH4R7aAP5HmJw/qvWqxIe5rZF/QPcbfCbJz/UZ4qVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778503;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=wbK+OrVmH+KHFEjT2qKmOySgClPwYT7zSYvrqmF9LNA=;
	b=UE4JA/rLb8dMMqPCYOnqL8f02RCgJ/yFpZbGDMQpibrJFrFlzqK8gAYVb0qJE3jIgM1/
	 2CEJ3zweqhjYTk+IcnCBHYtUPSKwSizxFyOeclQAjH46uLt8JG1eT3hR4xeNWutEKgZ9u
	 ZWCa9TK+bDXjZAjzZbuj+SP1TxJ27UICjiRQd3466EcW34TjoKf4CWWgSCRz3uMWltymI
	 TgWVM9bdDINi+NHy7EoDYR843DNXNnsOk3enO6tmIByPF/vtYqxoAoUxA7Ff2ekRjD3Lo
	 4j7eu7Iu0S83dnqO53OiHEZT0X/mXl1IofzVy19UhV2B5HzGj96/yZW1Mdoi1DBDnng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QQODPmUW;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581A0606A31C;
	Fri, 27 Nov 2026 11:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 581A0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QQODPmUW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795778504; x=1827314504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y/JqkyOc8ZhpzRq4dPZ6DkybSaeE081LmmKDYHKtAAY=;
  b=QQODPmUWxaCekCFF7vkAfLqf+EGBLTqG8Ttt8RrrX436+Y+Q4CZm/cm7
   d86enPxppn9nNhdAd08w8+h55aG3rAgGs1XcL3FNs0naiIlWM3II14COW
   N0cWPkTlfYDOvtKvY/YKXHU3jSg42KtQ0r0NlCxJqYPu1gurAQHFrdlgq
   /GtLfMgQRGb9MSJ+d1z/a/3JfdklbqA0rnUi+f/n2L+zsTO+eOnV6jQyn
   rsoOrduO9X/VLc9/Vo/DEX1mz2Qs6Z0PfOQTtZLMDjMfl5Fg97Ok8y2Lq
   wYtjXT3HeMZJWzs2uiKOymkTsN4dxUXMPtMv+8ZIXuIXtm5S9gdC/NmRe
   Q==;
X-CSE-ConnectionGUID: sE0/TWTpSWuQAzqLAFVFuA==
X-CSE-MsgGUID: A+X11BtbTqOxu+FMv/+Q8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4533391"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4533391"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:21:43 -0800
X-CSE-ConnectionGUID: erV67uUaQiSm88JS1Vya5g==
X-CSE-MsgGUID: eFLOXavRTLC8IzoRRuQZUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12712351"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 03:21:40 -0800
Date: Fri, 27 Nov 2026 13:21:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Yasin Lee <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] iio: proximity: hx9023s: reject out-of-range
 threshold values
Message-ID: <awlnwvtXj-K09MJI@ashevche-desk.local>
References: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
 <20261126213710.1047676-5-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126213710.1047676-5-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 27, 2026 at 03:06:49AM +0530, Arnav Kapoor wrote:
> The proximity thresholds are 10-bit register fields in units of 32.
> hx9023s_set_thres_near() and hx9023s_set_thres_far() mask val / 32 with
> GENMASK(9, 0) instead of checking it, so a value out of range is
> silently written as a different threshold: 32768 becomes 0, the most
> sensitive threshold, and -32 becomes 1023 * 32 = 32736, the least
> sensitive one.
> 
> Return -EINVAL for negative values and values above 32767, the largest
> value that still maps to the field. val >= BIT(15) catches both, as
> BIT() is an unsigned long. The low 5 bits are still dropped, since the
> field is in units of 32; add a comment saying so.

...

>  static int hx9023s_set_thres_near(struct hx9023s_data *data, u8 ch, int val)
>  {
> -	__le16 val_le16 = cpu_to_le16((val / 32) & GENMASK(9, 0));
> +	__le16 val_le16;
>  	unsigned int reg;

Keep reversed xmas tree order.

> -	data->ch_data[ch].thres.near = ((val / 32) & GENMASK(9, 0)) * 32;
> +	if (val >= BIT(15))
> +		return -EINVAL;
> +
> +	/* The field is in units of 32, so the low 5 bits are dropped */
> +	val_le16 = cpu_to_le16(val / 32);
> +	data->ch_data[ch].thres.near = val & ~GENMASK(4, 0);

This comment seem detached from the actual expression. I don't see anything
wrong in having the

	if (val >= BIT(15))
		return -EINVAL;

	val_le16 = cpu_to_le16(val / 32);

	/* The field is in units of 32, so the low 5 bits are dropped */
	data->ch_data[ch].thres.near = val & ~GENMASK(4, 0);

...

In the similar way in the second case.

-- 
With Best Regards,
Andy Shevchenko


