Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519253;
	b=kuG+E71LddoghINELyCFEGMsPhwglYp6PSfDB4YHSb4DeMHFqo0EzbImgSnMlJ/sXUQF
	 f72I/HW5RMXLdhSjSE5yUaQ1Vmrst7ATdHHX+9Z/opbpymCCU3bbNS2rmNL50MFLrcIWe
	 bC60WilUBfUWywZb/SdvKtDcYp+1OPrJJAuzzcqFrLBXWw5hJgHSxc1WXsTaiLJrPDO4J
	 JsLChJqbEz8KxbG2oPjD2wWF3ILFcDveq00Zeh54Egb3+7PnnQgW1FHvEcTqtRbDTcRli
	 0GFqemk/4DNiMPOJ9yg0TAhCeHwMIh/COVsjyiHynidvqVwvpZhLiRvhC6l1mMBdEug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519253;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=nNxFk53XQyez1lUlJ2CrGyJaS71dey2820xfRwu34aw=;
	b=zlXcfTDrUNv5Bn4lXre3pi1OJL8r6q0Q8p7Gvx6Fz45Djbzjk28TiayY4QQCGvUx9503
	 sdqul12lnBp0NOak10Iq4WQacrTL3ffT1M+NRTd0vmHQM5gm7lSHgRVaqCYgUrJn1m/cn
	 pv6AEwg21FmYwVoXUUX61Zbt1mV4MroqpIck5Vjk+5s/+NwF3ceTF3NYNMbgs4hmSjs1Z
	 7VKZYrXfewk87gvSbjduwalvYXZ5W59paIEOVJErZqhUTwqcPcWpuFMlbdVliL5BOZzDW
	 uzQiP+QjhICQI4AKhsUxdpdpxpIJHvQ7npV5QFaN6aL2t+A11DFp85JSyOmF09GGoiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="M61aQt/b";
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B6606A31E;
	Tue, 24 Nov 2026 11:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA6B6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M61aQt/b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795519252; x=1827055252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=03Q6v7uaraHRYSZmyQflbI/DTg3ospB40MWwlur2lms=;
  b=M61aQt/baRakwYX6t1HGXIJeoKjHL1HTXkN6pzpiuxw8C5ANoO4A+DQ1
   iV23tn4iUPJtE8Dm6gGgVHsFWXVE8ukTBh2lWIddPLB13nOGB0byMhudX
   5W/HodHoKxn7e50yBUCNGGcXuLluqpy/ATj/FmlS6PnhHFxlnELyQ9log
   3YxzaHoC5b6BbqR9eq5sqV3NHWOasFFYGtkuEbavVowLQ9LmK3YgCa7gu
   olstYku6gVl64H0ImUBQ91/lyj9YSRBvKfZ4C9X4bhm+8haq1BF++l2J7
   nulIuiA5CyUSwd9QZz3Bs6LxE0oJ/GI9ihfizbK4RuNbB0QWSwQQb3mZR
   A==;
X-CSE-ConnectionGUID: XhUT8CTBQiy4c5UxzubHwA==
X-CSE-MsgGUID: ggEL+VORTsqTX3sc9Xz1Dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4264530"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4264530"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 03:20:51 -0800
X-CSE-ConnectionGUID: 97NAeX2/R9KMk/C4ZiMX/Q==
X-CSE-MsgGUID: LdKfzg7dQFuqZ0sTExnHIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11872329"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 03:20:48 -0800
Date: Tue, 24 Nov 2026 13:20:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Nagavarapu, Dileep Kumar" <dnagavar@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v5 14/16] iio: adc: xilinx-xadc: Split driver into core
 and platform files
Message-ID: <awVzDqxuwsOjoFCi@ashevche-desk.local>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
 <20261110050201.1850399-15-dileepkumar.nagavarapu@amd.com>
 <avNGcpcemoeE3J7O@ashevche-desk.local>
 <42949fe9-b336-40e7-8a8e-43f6d24da9bc@amd.com>
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
In-Reply-To: <42949fe9-b336-40e7-8a8e-43f6d24da9bc@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 04:33:59PM +0530, Nagavarapu, Dileep Kumar wrote:
> On 11/10/2026 9:59 PM, Andy Shevchenko wrote:
> > On Tue, Nov 10, 2026 at 10:31:59AM +0530, Dileep Kumar Nagavarapu wrote:

...

> > > ---
> > >   drivers/iio/adc/Kconfig                       |   8 +-
> > >   drivers/iio/adc/Makefile                      |   5 +-
> > >   drivers/iio/adc/xilinx-xadc-core.c            | 690 +--------------
> > >   drivers/iio/adc/xilinx-xadc-events.c          |   1 +
> > >   ...inx-xadc-core.c => xilinx-xadc-platform.c} | 818 +-----------------
> > >   drivers/iio/adc/xilinx-xadc.h                 |  27 +
> > >   6 files changed, 72 insertions(+), 1477 deletions(-)
> > 
> > This is weird statistics... I think it's a bug in Git. What it did, it copies
> > -core.c twice and uses statistics on each file after that without duplicating
> > the *original* amount of lines.
> 
> I generated the patches using the following command: "git format-patch \
>    -M \
>    -C10% \
>    --histogram \
>    --base=origin/togreg \
>    --cover-letter \

>    --subject-prefix="PATCH v5" \

Hint: You can use -v5 instead of the above long parameter.

>    origin/togreg..HEAD"
> 
> If I remove the 10% similarity threshold from the command,

10% is way too low threshold!

> xilinx-xadc-platform.c is no longer detected as a copy of the original
> xilinx-xadc-core.c, which is not the expected output.
> Is there a better command or approach that would allow Git to recognize
> xilinx-xadc-platform.c as being split from the original file while also
> producing meaningful diff statistics?

But it's not a full copy. Have you tried to apply the patch from the mailing
list and see if `git am` correctly recognises the split?


-- 
With Best Regards,
Andy Shevchenko


