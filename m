Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327723;
	b=JUT+SshrFiROYtWWZJVS+yI7NoXP+SNb8pfp25DYgy7nIXF2WGxH6v0YF4LP//ovu27O
	 lcwphAizdJLW6+rQ2TbwamIcta2/9dmGU6fvcyUru2PBPasrnlwXxvR75UAr9DesZpnfj
	 5rbj5w1YgubOeIMRaoXzCa8Wro3Z4+44UlBzq0b8yaPBxO4JXtr3e0o3aUTwvVtj1tCkp
	 NSqqeg7sc9xoArFECQpi4Ido2j/E1qbgyKcszG5YOx5q6OCt++OYMt8QM3XqsNy0bHfW+
	 9vBRZfwKAxq/qgQc0rwIvVty3DkHAmJlJHGqdcF8dgN9Gp2mkTx2t6LQzVq+QUVnVWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327723;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=CBpuD9EN7mGAnC0N09j6dxtwPl1Nk8UemTazmCtVEmo=;
	b=ji8PlE3IBs84EyOGQBZNcCGWUxIvka6rvUJTw8pJ/VS3q7tr0ssI+gHm0/vLWjt7IT4P
	 u+l1yuEVXmm1w3hYe5U4/Tx2Z0yKPEShf5JkWw/SIDk5FqMSh4H9Qo+oaU4Fgr2SsIs0r
	 s5whZJ8WEgk/IBukepjH4HZTa6zfhQORYn+c5/hen40KwgXQoXNnDM6IMZnXRwHaRIx5t
	 SEHorFTCXHeitT4hIBiLofOehsnBy/hS3FZqV4QsnLQB55Nlnfi7SXMTTG4ZiznGwIHeg
	 8DHC+ObAE+zkEESbyFIDSZhR4EA+jPHrBc2B1YOurIW92rAB9otPicKka4/ABKT7dag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MCOMSxH0;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9BE606A320;
	Tue, 10 Nov 2026 16:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D9BE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MCOMSxH0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794327722; x=1825863722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cy+rZt1gNtVr4opsRLmcs7QTL/zYCRzwfuBXOZCZ7sM=;
  b=MCOMSxH0Q0tnrrazeDCeiFeBsy9/G1568ARzAi9XJFa65XoOmt7od/3y
   aHU/3yYcZeB6UzIxWpDQV6nRa+rhQU6EKEZiGJQABaVQpIQ29UVEsRSSj
   +TPZUXMmiP8o4/VDLdnTZLMTPClLCGU0WrqXiADJqi2T8VBQc3bfWpfbq
   F2u+7oEujpDZt9xTwMCLJq617wbAdySfs2du7dtFNovj5BC70I16WRgRO
   pPCmoKGq55mkDK1vbXr1OA28YRK9b3pzNaXlhtiY9rtVhjdhZbvyIpQ6P
   OKeCWdNGHSLBUwuR63rdV+1VMxWmsXUItWRn9JWcB4uZsTiLa6678GaOc
   g==;
X-CSE-ConnectionGUID: nxd2x6UNRI2HEG+Q6/bwaw==
X-CSE-MsgGUID: 18L8v8f7RESvf+NQVpcaRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2973430"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2973430"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:22:01 -0800
X-CSE-ConnectionGUID: rskXrzBaQJa6lenaPAoyjA==
X-CSE-MsgGUID: EUnsRGwFTlyeG6iuM9I8lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8018663"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:21:59 -0800
Date: Tue, 10 Nov 2026 18:21:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v5 12/16] iio: adc: xilinx-xadc: Refine Zynq read/write
 error handling on timeout/interrupt
Message-ID: <avNEpH6KGJkeI7dX@ashevche-desk.local>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
 <20261110050201.1850399-13-dileepkumar.nagavarapu@amd.com>
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
In-Reply-To: <20261110050201.1850399-13-dileepkumar.nagavarapu@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 10:31:57AM +0530, Dileep Kumar Nagavarapu wrote:
> Refine the error codes returned from the wait, the same way in both
> xadc_zynq_write_adc_reg() and xadc_zynq_read_adc_reg(): a timeout
> (ret == 0) now returns -ETIMEDOUT instead of the previous -EIO,
> giving a more precise errno for this condition. An interrupted wait
> (ret < 0) now propagates that error to the caller instead of being
> silently treated as success.
> 
> xadc_zynq_write_adc_reg() waits on xadc->completion after issuing the
> Zynq DRP write command, then drains the response word from
> XADC_ZYNQ_REG_DFIFO. The DFIFO read already ran unconditionally after
> the wait, regardless of outcome.

...

>  	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
> -	if (ret == 0)
> -		ret = -EIO;
> -	else
> -		ret = 0;
>  
>  	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
>  
> -	return ret;
> +	if (ret == 0)
> +		return -ETIMEDOUT;
> +
> +	if (ret < 0)
> +		return ret;

First check for generic errors, then for exclusive conditions ( == 0).

> +	return 0;

...

>  	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
>  	if (ret == 0)
> -		ret = -EIO;
> +		return -ETIMEDOUT;
> +
>  	if (ret < 0)
>  		return ret;

Ditto.

-- 
With Best Regards,
Andy Shevchenko


