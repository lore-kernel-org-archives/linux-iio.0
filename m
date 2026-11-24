Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540993;
	b=k0U5DzPJQzImgHFrix5C0XesDx26+eUDWKHWOAB98TwuB2d7bCjdms23dV47dFHRp1DG
	 vhURgO1Gq3eJSrRfBiKtWWDUc5KIQUhsD79IMlr800vpDD2W4UIgwGJkA2rLusk9ejtKF
	 6MBw3QRpCVRshXz5cd7590Cgjit8vP04sxBgxUfDcRperE7KO4mEgKnfCM2X4koXLCO3G
	 JrWsOp2ThUduUYE3xWCY3s+RPAMOSeLg9tRXgEi0JBWUk2tSrvwPV1mw8BeBpG0bmBIbQ
	 XMcXRVwEWyjVYkrHDgKPcIQAk9pE+Ih4Af6t+RLOqRz7rb/Zftt52LgsDWve50pgUtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540993;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=QB3iU+E6oyxQS/JyhDVo0yHo/2d1Hsj9txbeC2yWP8g=;
	b=2BLekNdfGxYVRAsIYXrGPGVP2HrRvp9lNRHcMpl6Wi04Macb5trohpNtBSGtktV+Kdxq
	 a6bEG8210YfR27lyxdnMTRSAU/A6x4rrrXw5BWF3rwd+Ffz8C+21f49q8nlnCooHh4Qgg
	 4hK65wiefbPP+Q6xYW4O70KZ+UPZ5QkMmSmi7soc3lpfb/tAQCLvhCEFsLb/M4Zk9eWbh
	 yydN+DaqtHTKq+rUEkKFU4/f+ixjYTyfMe0q8E+IcvWJbOpA7WP8EBefjGhkRFPXSBvn9
	 437eW+4orjU0bc+YEgRGef3W5SzFdQboykH03YdFmm5dDv8hgYmCZ2SK+wdGwekbm6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jTUatixS;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A29606A333;
	Tue, 24 Nov 2026 17:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28A29606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jTUatixS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795540993; x=1827076993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wpVMG93aHYjeK4cRmMuTJVoZTPgP747FjeTd/hCPVTE=;
  b=jTUatixS0b0FKDuIifuAZ7aQdOy8up1OrGgD/qZ9m/eu3SbGWMjLAd43
   ZESq+jl8yeZXaTEIzTHY/EcP8/RxcNxXE/W7mbeldlCHjWa8ClwDP7L8a
   unr8WTkP/fPx4t0z1uZbx35M21k7GXF/Ypq547NfB0takR3zeW5BEUTBk
   0OLUorekV+PvtDcz1e41XGik9w12wmVd/0K8CSMpcEoXUXeTjmdMHmdq8
   NQCLYv03NRHY97og/P4zLKyLrCBOg6NcRr0sj+QqaP64VkafXl91/lCYe
   3rd+8SSjjt0BBmYphka1TbS8mVdfDRxtcLFJcfy/CPVjBY2dGI5o7T5xF
   g==;
X-CSE-ConnectionGUID: hguHChhDQJi+USMw1wsaAQ==
X-CSE-MsgGUID: /T7/IBcdTHW+07IT82fmWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4447380"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4447380"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:05:23 -0800
X-CSE-ConnectionGUID: gVewJTBkQdmaPuvBAvZOCQ==
X-CSE-MsgGUID: FfvISExHSDqpLos8PF/+mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="12029816"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 09:05:19 -0800
Date: Tue, 24 Nov 2026 19:05:17 +0200
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
Message-ID: <awXDzR6tSPHh64SZ@ashevche-desk.local>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
 <20261110050201.1850399-15-dileepkumar.nagavarapu@amd.com>
 <avNGcpcemoeE3J7O@ashevche-desk.local>
 <42949fe9-b336-40e7-8a8e-43f6d24da9bc@amd.com>
 <awVzDqxuwsOjoFCi@ashevche-desk.local>
 <f7273b47-0835-4afb-9e45-ddf729f05b8e@amd.com>
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
In-Reply-To: <f7273b47-0835-4afb-9e45-ddf729f05b8e@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 10:23:29PM +0530, Nagavarapu, Dileep Kumar wrote:
> On 11/24/2026 4:50 PM, Andy Shevchenko wrote:
> > On Tue, Nov 24, 2026 at 04:33:59PM +0530, Nagavarapu, Dileep Kumar wrote:
> > > On 11/10/2026 9:59 PM, Andy Shevchenko wrote:
> > > > On Tue, Nov 10, 2026 at 10:31:59AM +0530, Dileep Kumar Nagavarapu wrote:

...

> > > > > ---
> > > > >    drivers/iio/adc/Kconfig                       |   8 +-
> > > > >    drivers/iio/adc/Makefile                      |   5 +-
> > > > >    drivers/iio/adc/xilinx-xadc-core.c            | 690 +--------------
> > > > >    drivers/iio/adc/xilinx-xadc-events.c          |   1 +
> > > > >    ...inx-xadc-core.c => xilinx-xadc-platform.c} | 818 +-----------------
> > > > >    drivers/iio/adc/xilinx-xadc.h                 |  27 +
> > > > >    6 files changed, 72 insertions(+), 1477 deletions(-)
> > > > 
> > > > This is weird statistics... I think it's a bug in Git. What it did, it copies
> > > > -core.c twice and uses statistics on each file after that without duplicating
> > > > the *original* amount of lines.
> > > 
> > > I generated the patches using the following command: "git format-patch \
> > >     -M \
> > >     -C10% \
> > >     --histogram \
> > >     --base=origin/togreg \
> > >     --cover-letter \
> > 
> > >     --subject-prefix="PATCH v5" \
> > 
> > Hint: You can use -v5 instead of the above long parameter.
> > 
> > >     origin/togreg..HEAD"
> > > 
> 
> > > If I remove the 10% similarity threshold from the command,
> > 
> > 10% is way too low threshold!
> 
> Is it OK to use `-M -C --histogram` (default thresholds) instead?

Yes.

> With it, xilinx-xadc-platform.c is shown as a new file with all lines as
> additions rather than as a copy of xilinx-xadc-core.c. The statistics
> then look like this:
> 
>  drivers/iio/adc/Kconfig                |   8 +-
>  drivers/iio/adc/Makefile               |   5 +-
>  drivers/iio/adc/xilinx-xadc-core.c     | 688 +------------------------
>  drivers/iio/adc/xilinx-xadc-events.c   |   1 +
>  drivers/iio/adc/xilinx-xadc-platform.c | 677 ++++++++++++++++++++++++
>  drivers/iio/adc/xilinx-xadc.h          |  28 +
>  6 files changed, 733 insertions(+), 674 deletions(-)
> 
> Are these statistics OK?

Yes.

> > > xilinx-xadc-platform.c is no longer detected as a copy of the original
> > > xilinx-xadc-core.c, which is not the expected output.
> > > Is there a better command or approach that would allow Git to recognize
> > > xilinx-xadc-platform.c as being split from the original file while also
> > > producing meaningful diff statistics?
> > 
> > But it's not a full copy. Have you tried to apply the patch from the mailing
> > list and see if `git am` correctly recognises the split?
> 
> Yes. I applied the v5 series from the mailing list with `git am`
> and all patches applied without errors

So, then it seems like a Git bug as I pointed earlier, and hence it's fine
to use 10% threshold in _this_ case.

-- 
With Best Regards,
Andy Shevchenko


