Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703852;
	b=FSIl9XpgbWE2HzC1MEpfZpm9zsf1ml1iezbe5hbyrT1hrVJNq+5gWM06o+PLhL1AyqLG
	 5CPXQxcVXH+gDTVRrV0MTLMlJwwlv2PYhE6KOiYVVhkG/IYN/mYjduHceXxEuL9Q3XnWc
	 NgGsQQiVn6bc2expEFEa4R6m4vzvl1vuDMm8XpbqA+XjHnQBC60ZeCxouwYWg9Wg5l5nJ
	 Kj1dZKffNvH9lzm7Il5wd0Rd/0HP1KFoGTvKHHm2gUL33g7nMuAM1ZBAu1uklnTHvMzU1
	 HShBywKsdY1pF2Ql3rmWwiGB/UBUAGU8x+k3LHIhVmfWbRYRbq7bgZOyDg/zOafb7ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703852;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=uvOAD9yOGnAC8Ztss/IjrgdkyvLur1+4cPbktijaMrU=;
	b=5L2XuGjPKMcRxUggQ1PySQJc/3NLSIKY2i9phJCQyxwMyWKDWsKoIg8uxyLFfaO2Den2
	 YaYSmdAbqhHTWJENmjT7jrAXloQTVsKKEZKdyj/MqmUWr6AoOK4/HtCpDwJY1fqS4Tguq
	 aXO7g6YtW5JJH1IryD76tchDZZxYgdPI6GZmdjRW7+KtlrSLrzqZsfkzIfAWa3XjJX+tf
	 DCdVY4gdLLBp93FCqXlsctpJVdIHmBexzFzy7LdpgOV9GlUBjHZ6sa0uxPOqwin/Z062N
	 /suQIwyeTgEWZl8f+WnPLU5S0zwgMMCprlPozS7CJzST1YCtQEE21fWhm4JaQtBpdWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ttn9dtxO;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49E4606A31C;
	Thu, 26 Nov 2026 14:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B49E4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ttn9dtxO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795703851; x=1827239851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NFMhsQ7/o1fMsj01WtwyF816qClvD9yZEfnRKx8D37Y=;
  b=Ttn9dtxORVX/yLCkaFeMKEDdiIGx5emoBKV6Or5KBuJmS5BCV559pMfV
   NNFzt+4DgX6juRoiDkAyzUq7xxU1xnIXmNMmLjrTpUHEfz7ZedGotKEOe
   grhz+mwsmbz2L1LQvSy1WIrUmBTagZYQ2GVUPX6GhjpMvkpXYgyHwxrjw
   jMFVA2EYcHay/Y7dJAN6PFnoS+mGa98IFi3K0MK6y/YgEuofbPPmnvQ4b
   bwhcoY7ZdnIaULHCTrf3TjNwvdLKvmNG+63vG6wlvcYZ+Zl8bRyqNq20H
   Zb4im3Y2R+0bkCVGpi03KRblm9TWBiZ8P+rDmhVo0RiYwJdS00YP72P+W
   w==;
X-CSE-ConnectionGUID: 6I0JEZBLQ++kqvF+Vt5YyA==
X-CSE-MsgGUID: qelGVfCfRgmabvZ2FbFtFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4624557"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4624557"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 06:37:30 -0800
X-CSE-ConnectionGUID: 396ke5XTQ8+QU+WBAMzH2A==
X-CSE-MsgGUID: KukHOz3eSM2Jqy0/UEKSTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="13959107"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 06:37:28 -0800
Date: Thu, 26 Nov 2026 16:37:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] iio: pressure: dps310: use time unit macros for
 sleeps and timeouts
Message-ID: <awhEJX_XLkFS-ZF0@ashevche-desk.local>
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
 <20261126121331.10438-6-zoone.rupert@gmail.com>
 <065da662-2670-4f7c-93dd-410e9c11d18a@kernel.org>
 <awg42TwLsgf_Xp3U@ashevche-desk.local>
 <7951c11e-b7f3-4a1a-ac07-87e231e7eb68@kernel.org>
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
In-Reply-To: <7951c11e-b7f3-4a1a-ac07-87e231e7eb68@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 03:19:06PM +0100, Joshua Crofts wrote:
> On 26-Nov-26 14:49, Andy Shevchenko wrote:
> > On Thu, Nov 26, 2026 at 02:17:34PM +0100, Joshua Crofts wrote:
> >> On 26-Nov-26 13:13, Rupesh Majhi wrote:

...

> >> > -	usleep_range(15000, 55000);
> >> > +	msleep(20);
> >> I think it's safe to use 15 as specified in the datasheet, as msleep()
> >> guarantees sleep for the specified time + a max of 12.5% slack.
> > 
> > Wouldn't be better to have some margin still? You know that time goes
> > differently on different CPUs and in general time can go backwards (in
> > computers), so the long sleeps can (I haven't checked though) go both ways,
> > and a minimum sleeping time can be less. Also on the other side firmware
> > might have issues in some circumstances and require slightly bigger sleep
> > than specified. That's why I proposed margin.
> Sure, it's just that some patches add a margin and some patches ignore this
> and just add the default datasheet value. A lot of times slack is an adequate
> enough margin. I was always for just the default value.

Yeah, probably for 10+ ms delays this is fine.

-- 
With Best Regards,
Andy Shevchenko


