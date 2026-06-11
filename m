Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4792409E0A;
	Thu, 11 Jun 2026 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194712; cv=none; b=TuODXR80HiSFfFcS681GdA5K/aZb8C4b8Dy/TdGO3BJJ3FdUO4L6VkBCfOQCBazK2UH1aqwlrBWxQfNgp0aZhDJQSxT/gpM1Gs3lw2W8jBFnGt1UhdxbxVSMR40CmoTlafRR7ZjMR67nVekF9HRmwH8NGgw9DrilqNucvvEAEPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194712; c=relaxed/simple;
	bh=fRzN8kkamd+k6dJQ/kRrk2yDExhgXYIsqBsRAAtJvus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tL2bSAdnQt60Wa2NVAFNddPvSvQ+qHIZEH4wEnYfwPE4B0J+IwXFiBEFTW1sx9dfbG1MEVEo1BLINcUA+xmgBbiIm4vrgLSDezlrOk2SWCuYtMvG8kql3G/Z1DGR5kCmQgprNjTVMqw9xUpuwCmsR8a41QSR6A2eHVgeRfpul4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Drk2SBYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Drk2SBYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FACD1F00893;
	Thu, 11 Jun 2026 16:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781194711;
	bh=qQppVLeWH0TOuEFEy5iQoyvPB6/Yhmt/u7HRd/Sg38Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Drk2SBYVjVsfl1R5r2BwLZ7ZzeCkwakkMXe25YZE9Hk00mYyvR7CiQkdpJ+DGJ2bq
	 n3LYxOcC30rWmpT9t2LRClEbc97fCxgaUE0o3uKErfgzGDzfWWgCBAcIT+VMR1lkkc
	 XVpByt2Wkx+17tMMHLoaZ3IwwwyJxfGQ1hoFdwi5RqMEUv+1m50GHATKf5LeHg0Ysn
	 IdliOCVB4P97CCzttGJuS5v25KCUWpufiZvnAW2P3pc8Xjfuz8FLKcSCKFFiz5iFlY
	 x2vB8hwwlerMErmQW1CF/2JG41/3HDUMhKQvctga9ZFZamgMs8twp7RNBZDSwfQrvo
	 F5Mi3K9/Td9ZA==
Date: Thu, 11 Jun 2026 17:18:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
 andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com
Subject: Re: [PATCH V11 0/9] Add Invensense ICM42607
Message-ID: <20260611171824.0f932f3f@jic23-huawei>
In-Reply-To: <PH0PR19MB99733845CDEFA1D8441200B60FA51B2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
	<20260611115938.27712b66@jic23-huawei>
	<PH0PR19MB99733845CDEFA1D8441200B60FA51B2@PH0PR19MB997338.namprd19.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 09:36:08 -0500
Chris Morgan <macromorgan@hotmail.com> wrote:

> On Thu, Jun 11, 2026 at 11:59:38AM +0100, Jonathan Cameron wrote:
> > On Wed, 10 Jun 2026 12:54:44 -0500
> > Chris Morgan <macroalpha82@gmail.com> wrote:
> >   
> > > From: Chris Morgan <macromorgan@hotmail.com>
> > > 
> > > Add support for the ICM42607 IMU. This sensor shares the same
> > > functionality but a different register layout with the existing
> > > ICM42600.
> > > 
> > > This driver should work with the ICM42607 and ICM42607P over both I2C
> > > and SPI, however only the ICM42607P over I2C could be tested.  
> > Hi Chris,
> > 
> > Just a quick reminder to check if there is useful feedback at:
> > https://sashiko.dev/#/patchset/20260610175455.19006-1-macroalpha82%40gmail.com
> > 
> > I didn't look into most of the but the last one about no avail mask bits
> > being set for gyro channels was easy to verify as correct and suggests
> > a testing gap.
> > 
> > Jonathan
> >   
> 
> Thanks, I've been checking sashiko on every patch and trying to address
> what it says to the best of my ability. Honestly I wish there was a way
> to simply push to that bot first and *then* push to the mailing list
> once I've resolved all of its comments.

Agreed - that would be helpful.  I believe it is possible to run locally
against a bunch of LLMs - I recall seeing something saying there
is a git repo with scripts. No idea if that is possible with a free level though.

Jonathan

> 
> Thank you,
> Chris

