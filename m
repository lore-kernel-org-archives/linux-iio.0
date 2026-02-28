Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B70342C98;
	Sat, 28 Feb 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772284336; cv=none; b=NdKfOnyDb+SbZ4eWNaiIFXK+Itqc7M9mdEtw0tK4R9n69baDd8Ws/ABfb6X17mO7lWk6eMdu1DfB76rF0WE0z0eqxZFV16ucO/5owMCbcPlY1WgeBjqC9i6Qws2Lav1cPeFedbB0WyudXnqBfJGTaAlK5Qu5tSHOJPUyCzXrXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772284336; c=relaxed/simple;
	bh=7PKoXbbbZGuaoaD3wd8J03XJk792XyUev5sWPl/XkbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CL8Xys070uvMuG+0ZC5emxgr8nfS6o5rA23h2j4od55bTRPyhnTdH/pSdV3KsKZwdutw+e1mjoDkXwXnMd+4Q/ZxpGIqEL+d8Phbl6UIRNvJhk1+TtkA6IGfxoHL1I9CZBy8mAZ5tn4cxO+wz4naWFm0OEefVHjLUuvp+bhSTlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfdpVxqb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfdpVxqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644D8C116D0;
	Sat, 28 Feb 2026 13:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772284336;
	bh=7PKoXbbbZGuaoaD3wd8J03XJk792XyUev5sWPl/XkbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BfdpVxqbx0z+6y/XazCyPEgJ385DkoEU2lN3ouyy7PPXlnCrKVLj1P6h9u9UbfKYG
	 FtYm9NiXbHblGRY/ijkLxe94id2Bem7MT02sG74fvr6u2haqCp5Lknc2ejsExP8AWH
	 O8N/2EyU53ULzLsfbgMvkjSCqCGx20kyuaOtm8+73TMllqT29dvAYP0LZabi+6cMM/
	 7GI8WYDb63XJvCydbS8vR/36mIxtqKZFEMonYG0jkmsRLIsh3+QeIXY7fS0CXJMuCW
	 2b3Y2WZzfXak1aL+ecvIwneGAYVFhBTRYVw2RBaLbmBlAwxFCAM5jW+R8KA2A9AzrK
	 yACAm6NKZmGAA==
Date: Sat, 28 Feb 2026 13:12:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: tsl2772: fix all kernel-doc warnings
Message-ID: <20260228131208.27fd3131@jic23-huawei>
In-Reply-To: <fc1eddb4-b01f-49a4-808c-9a58b2b63ad8@infradead.org>
References: <20260226051258.555019-1-rdunlap@infradead.org>
	<aZ_-pVTbTUkByPIJ@smile.fi.intel.com>
	<7f61d93a-37df-44fc-ab47-b0e5ff70259a@infradead.org>
	<aaCtJE4tvVZDn1zz@smile.fi.intel.com>
	<fc1eddb4-b01f-49a4-808c-9a58b2b63ad8@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 14:25:12 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi Andy,
> 
> On 2/26/26 12:29 PM, Andy Shevchenko wrote:
> > On Thu, Feb 26, 2026 at 11:14:05AM -0800, Randy Dunlap wrote:  
> >> On 2/26/26 12:04 AM, Andy Shevchenko wrote:  
> >>> On Wed, Feb 25, 2026 at 09:12:57PM -0800, Randy Dunlap wrote:  
> >>>> Use the correct kernel-doc notation for struct members to eliminate
> >>>> kernel-doc warnings:
> >>>>
> >>>> Warning: include/linux/platform_data/tsl2772.h:88 struct member
> >>>>  'prox_diode' not described in 'tsl2772_settings'
> >>>> Warning: include/linux/platform_data/tsl2772.h:88 struct member
> >>>>  'prox_power' not described in 'tsl2772_settings'  
> >>>
> >>> Hmm... I do not see any of the user of this header file.
> >>> Have you checked if these values are even used?
> >>> Perhaps we can simply kill all this?  
> 
> AFAICT all macros and structs and struct members from that header file are used
> in tsl2772.c.
> 
> >> They are used in drivers/iio/light/tsl2772.c.  
> > 
> > It's the same driver. So it's *not* a user of the platform data.
> > 
> > Under 'kill' I meant the following:
> > - inline the content of the file to the c-file  
> 
> Would that be "violating" this commit?

I think the proposal is to remove platform data support entirely from
this driver on basis we have no upstream users.

There are defaults in driver for the stuff that can still come from
platform data.  Note there is generic property support for a bunch
of other stuff (i assume for DT).

So I'd be fine with a patch that removes this header and the use
of platform data in the driver. Easiest path to that is as Andy described
in putting the defs in the c file, plus only using the driver defaults
(so no more 'real' platform data).

Jonathan

> commit 436d42c61c3e
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Fri Aug 24 15:22:12 2012 +0200
> 
>     ARM: samsung: move platform_data definitions
>     
>     Platform data for device drivers should be defined in
>     include/linux/platform_data/*.h, not in the architecture
>     and platform specific directories.
> 
> > - recheck the c-file for the unused fields and drop them for good  
> 
> All used AFAICT.
> 
> > Alternatively converting c-file to use device properties instead
> > of platform data.  
> 
> That's your area, I guess.
> 
> > We have done many times in the past such transformations in other
> > drivers.
> >   
> >>> But if Jonathan wants to take this as a quick fix to make less
> >>> warnings appear effective immediately I'm fine with the change
> >>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>  
> >   
> thanks.

