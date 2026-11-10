Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327538;
	b=ta6nfGdHcavXSLRp/qi9jbWRG1pE/yo6N304GMYL9UdkIBAzb4v228JfqI0O593UEog/
	 hTD2tn0NBH/we03NvSvBNZqWQkf+mdb98Sz9nRXvih8z6HQhMYpBKkcbhm8LuyyZOy5Wp
	 GcmTPAy18b9bDt0SNpsaovjc82dEocYM009k4Sit5KHW8fe/RxroN8Oy8XWeAxfhgskpo
	 L8CUtBZuitHBG9GGQFJh9G/nu1cJLJ7vM31E9aunMsC4jJw1w8xWLpd+2D2wZj9+sUI+Y
	 DqKODuiNEB5UdRiIgrG+78qbwFHBcCBhxWO7BaVmPO0wUZTb+wkMWxIsMr6fXpE4dYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327538;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=yYskAYVnH6XbVjZCWrX9MMKwY8O7EPYghGutgzkZiEk=;
	b=gYI8Ql1bq1A/TSE5fm5DQ+lTBSCnYbLHyLEo/tUuv9gMv367M1zR4GsvHHLZhYb2Jl+r
	 5FocWLqHbRkzFNQM235LLFv6Go4cZFyECnNHjr7c8B8wz6coDLN1vIXMXSdV87N9knmWB
	 mgMJNYyR4NIpd4iC8uXeeqKu6uutnSRLTUKGaVX50eg3w1TPn4V/e/pQZagcCyqLu0OSe
	 eVx0uz9W40UDCN7D2+uDV++5uPdw78BAlNsd085XkE0KIRylznv2NrYoP94agYYH1Fjju
	 ocVHKL4cYn/gNlvGCn8T/V9/NPf+35FrYH7cqafOt0c69ufgfHGjrujCQPY43lBMpXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fsxeVPOQ;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483CA606A31C;
	Tue, 10 Nov 2026 16:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 483CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fsxeVPOQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794327537; x=1825863537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XLgFMvrq3yUqIfrDH4auZGnz7OE5EcbDwFNADMKNHJ0=;
  b=fsxeVPOQii9m1JAsbbCsy2rwRi9H1dQxwy8u/nYR95aM/AkAsCgSJqlq
   q5VhFMk9I4THSXMhz70Zyl9ZPPb4WhKvbN5iLCgrSGIjepRqOjsdNC3Eu
   HqWAe7PtXD7asvPLgqm71IY2jVgOAUVbYxsQ1YDA/ICwEox/LCULFpAVk
   e/k8tF6wfAntsA6fmZhw3yTGFpAdgS0FtY5m366PUuY84BfCOdKpPAj2W
   78X82VcvgB9FocWq7L3CaMbPoCBv1ykWv46p8fkVI2Zwmbd/diH02ZSpk
   ptLvfnvQhXqlKLStmbEEXDBUn8jUNKM64F1ysAN4uPs5Mi7GhxQf0AUZ6
   A==;
X-CSE-ConnectionGUID: U7OfC/ipRkaiQTnxWxvAGQ==
X-CSE-MsgGUID: hChN51gfRj20k7r22eAgFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2979647"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2979647"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:18:56 -0800
X-CSE-ConnectionGUID: MneuRwbwRX2t1Z8hvWZwaw==
X-CSE-MsgGUID: P73odN+YSh+sOAsPzzVs0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="9967128"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:18:54 -0800
Date: Tue, 10 Nov 2026 18:18:51 +0200
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
Subject: Re: [PATCH v5 09/16] iio: adc: xilinx-xadc: Add unit suffixes to
 macro names
Message-ID: <avND64ZLHcSPFUkX@ashevche-desk.local>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
 <20261110050201.1850399-10-dileepkumar.nagavarapu@amd.com>
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
In-Reply-To: <20261110050201.1850399-10-dileepkumar.nagavarapu@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 10:31:54AM +0530, Dileep Kumar Nagavarapu wrote:
> Append the unit to the relevant macro names (_HZ, _MS, _CYCLES, _SPS)
> so that the expected unit of each value is clear at the point of use
> and to avoid ambiguity.
> 
> No functional change intended

...

> -#define XADC_MAX_SAMPLERATE 150000
> +#define XADC_MAX_SAMPLERATE_SPS 150000

Not sure if _SPS makes it anyhow better, but you may use (150 * KILO)

...

> -#define XADC_ZYNQ_TCK_RATE_MAX 50000000
> -#define XADC_ZYNQ_IGAP_DEFAULT 20
> -#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
> +#define XADC_ZYNQ_TCK_RATE_MAX_HZ	50000000
> +#define XADC_ZYNQ_IGAP_DEFAULT_CYCLES	20
> +#define XADC_ZYNQ_PCAP_RATE_MAX_HZ	200000000

We have units.h full of useful multipliers, use them.

_HZ --> _Hz

...

>  	div = clk_rate / val;
> -	if (clk_rate / div / 26 > XADC_MAX_SAMPLERATE)
> +	if (clk_rate / div / 26 > XADC_MAX_SAMPLERATE_SPS)
>  		div++;

Side note, you can get rid of one division.

	if (clk_rate / div > 26 * XADC_MAX_SAMPLERATE_SPS)

>  	if (div < 2)
>  		div = 2;

-- 
With Best Regards,
Andy Shevchenko


