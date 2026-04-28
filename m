Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6309A2765FF;
	Tue, 28 Apr 2026 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395423; cv=none; b=UhvnHgRyioYQg+5ho+f6baEl81AMrYNNYG1qeG/aXRJS//knYUo6ry01MR+CRqDG+GrIYS5+9CoielhKOMCWgVh0d6lM62sCiNP0MA1DRIUD0b8ryM5jRJhUefpvdo7Y5k7B5NHCj79ne/NCisPCPes94lFEAXYGr8LM2JO/6m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395423; c=relaxed/simple;
	bh=iFE/LQeaQyGxzEuEbACG1dva0oGWkxgtF08/qddFMH0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPmDoi4/LYxrKOh0KkgbPv/Pl85zIMMfhit6Mr7e8AFu19sgBDjwEDtkNRF3i9eQPJ/2rT3CQrFPH5aLA8sFgEK8CtwkIpl8lyvdG9ajgSn2PaRGlJjkuZFk+15bkbtD6zDF72lxhFuTRS0cHD41P+P6iWL2bXOFcCwA4YTzEaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NEoC3AbA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NEoC3AbA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90AE1C2BCB5;
	Tue, 28 Apr 2026 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777395423;
	bh=iFE/LQeaQyGxzEuEbACG1dva0oGWkxgtF08/qddFMH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NEoC3AbAcnbiyJbtbJtdFsGmVOj1n2oWzU2qIThW0gCISe0bzZ5HDAyJ5uO8qum0P
	 y+omPQIL1AJz6lGCBDmL1sTjxYnVZ76q+R2ULFTDFHZZlNm2u4wOyhpz4Pk7yFrngo
	 qb465RQhpkdvtk3EcuJY/6z2/IBXJodtZf0HaQdWBf09E3p2v0gDLXwClmthRsf3nf
	 dg6ze6xEubaNifFxpP93xBZSWhgHxe/mIHtXXTM+WdzzT+n3GLC7vBChS6x2kkirOK
	 f19nNEblcTM7tdWnarhYnnIogJ8JGohoXk/hM380oweUfba13tFvtYtCsn+Hy5MFst
	 nWEb75d13mZtA==
Date: Tue, 28 Apr 2026 17:56:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 00/11] Fixes and cleanups for the AD5686 IIO driver
Message-ID: <20260428175651.19571cc5@jic23-huawei>
In-Reply-To: <ae-m9-yTveKKClww@ashevche-desk.local>
References: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
	<ae-m9-yTveKKClww@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 21:12:07 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Apr 27, 2026 at 12:30:07PM +0100, Rodrigo Alencar via B4 Relay wrote:
> > This is the first series of three on updating the AD5686 driver.
> > 
> > A bigger patch series was sent before ("Extend device support for AD5686 driver"),
> > but this is not exactly a v2:
> > 
> > https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> > 
> > This one adds a number of cleanups and fixes, like:
> > - Refactor include headers (IWYU);
> > - Remove redundant register definition;
> > - Drop enum chip id in favor of per-device chip_info structs;
> > - Fix internal voltage reference control for single-channel devices;
> > - Acquire lock when doing power down control;
> > - Fix powerdown control for dual-channel devices;  
> 
> I have only a few nit-picks, in general LGTM, thanks!
> 
> 

I had nothing to add :)
Indeed looks good.  Just enough in what Andy raised that, given
we are early in the cycle I'd like a v3 rather than tweaking stuff
as I apply,

No need to hold off for usual week I think given nature of
comments (if you have time to respin earlier obviously!)

Thanks,

Jonathan

