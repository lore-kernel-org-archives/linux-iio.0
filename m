Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790A4194C96;
	Sun, 31 May 2026 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780218296; cv=none; b=GyWCmv8iJ/o9gpLsiyzMvr2xaUZobec4NtMVBFg5zAL6k36/GHbphO2SPfxTW0UbnkQ1Zc6doNjXwxkOF+WxUTc1Cm7iP5m0Cs26KQypsZOd1pI+fvoYHEcBHdy5GRZPrZ/5OuKrtc94VBp7MkXDQRVAFWhzO1ualLnvblnG/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780218296; c=relaxed/simple;
	bh=mVlLWQGYe8l6dKMHTKGClnIVz+eMCW6o2KrolMGid9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZVAzhhDZpsRq3u5X+RiYzCtjaO5WayG4qjL3rFb9QafKpZ9Tcej4POnRVLyFoLrcCVO/WZyRk+dE4mk5QDzAYft1KoIKSy1GziAT4MdFUJto9H2cZMy3MhV5iBlH7oks4htXiyYF9ZWpDSUKZ/EmKAUFcS0APPBDVHJ7Mz7vPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxBZPCLp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxBZPCLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7DF1F00893;
	Sun, 31 May 2026 09:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780218295;
	bh=M89qTaLaJ4vSH/PiSN2rm9EOyE8CTekmMeMPLpPtRho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AxBZPCLpfkyBca56MBizj65pWvpQeedgQ1U7hLVagEIwJpZ/P0E7jSKEVqFUtBbqq
	 9yCRl1lECpo+mMdOMso/IG9Tme01vbQM49yw5plVzEzSHz2YA2jtgwlwF9yxQhyZvM
	 cs6wQYZKE2lq2Sc1YomedZZW+H9Er2eZgoZKXG1ggQ4R4+bhnFoD73oht/RAtNTLGB
	 XeAuVyyN4nseKulgiJjO8G+39Ko8FOJbP6GRA8mSFHRM8hBXt/wQpRxJo20BODwos/
	 8/KBO+8FPSspINrIZyl8/NHFR5JTaLVZBR6dfqVIPSxigOLbvOajtJlzM0X/cjq9bW
	 4Jlnrhk7w35kQ==
Date: Sun, 31 May 2026 10:04:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi
 Gupta <gupt21@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: veml3328: add support for new device
Message-ID: <20260531100445.7fd4ca6d@jic23-huawei>
In-Reply-To: <CALoEA-x5h==eL_YmbZ-WV-N=ZokPRF2pC7+p2Z87KOxDAFzu4Q@mail.gmail.com>
References: <20260530-veml3328-v3-0-dd562eaee8d9@gmail.com>
	<20260530-veml3328-v3-2-dd562eaee8d9@gmail.com>
	<CALoEA-x5h==eL_YmbZ-WV-N=ZokPRF2pC7+p2Z87KOxDAFzu4Q@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 May 2026 19:23:53 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sat, 30 May 2026 at 19:07, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> >
> > Add support for the Vishay VEML3328 RGB/IR light sensor communicating
> > via I2C (SMBus compatible).
> >
> > Also add a new entry for said driver into Kconfig and Makefile.
> >
> > Assisted-by: Gemini:3.1-Pro
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---  
> 
> Sashiko had a few remarks, two are bogus IMO, but it does mention
> that the device isn't put to sleep after probing...
> 
> https://sashiko.dev/#/patchset/20260530-veml3328-v3-0-dd562eaee8d9%40gmail.com
> 

I vaguely recall looking into this years ago and being convinced that it
would autosuspend. Easiest is probably to verify if it does by just testing
the device.

However that might rely on turning runtime pm on before calling use_autosuspend
whereas you have it in a different order here.

One of the other sashiko comments is correct.. I'll reply to the patch.

