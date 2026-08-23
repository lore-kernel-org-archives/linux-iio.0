Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B541A01BE;
	Sun, 23 Aug 2026 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787446127; cv=none; b=cj6yMUOCuZtT8YevG1tXrX4Aem6dTIQ39tQ0i3aV22EqZ2CdmpxX73/Atg9UmM39Qlik8gHVEIVK2TXnlEOl3yVfpey9TQONPHLz9oNMEPxVuhjSyGvAOxTIvGKRYoSUV0D5FajzR4idp7RImvuiNNvvkIi8DunnKIGLUpaSxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787446127; c=relaxed/simple;
	bh=2iZIGXchkAsDDo733kG6sKqq11PlSvjaxBPPgaSTRtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGRzrc+lRpGGpnRMXBFOVcIkyznAxEWgEUGPAkrghOjTkcn3dzGxaywkRvYhKOb6wDba1xdt6+A22ER5Ybbr7cfhbfarXMGK2QdN4lqcxJ7r6drPGRPNJQUdQoOdzWzGgHUzr7gFEk8aREVTg+ChJHZzPKml0kINKwGcMYw/iIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+IctrPQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+IctrPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663AE1F000E9;
	Sun, 23 Aug 2026 00:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787446126;
	bh=5fKLL+Ehk5W+FozPcr70/c98hS122nJUm5i+7bKcYyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A+IctrPQkvrGneUmRitegrmMI3MhNXcCbDXCQNwrZlv/wBTxNHytEmQRkFDrYYfV7
	 7c69B5Z++hnnM1rGGdkHM8xb4i3w1y54mQxveI2+eZTe5RQU6MZkypGLavxZkSNs9J
	 EeSb0nbevCfgIDuMk5IOecIrl8/Mf+H1epdRGhmhLukzJbMcoqOSKvSCY9bl+PbPNn
	 Uzi4Tilni3LdHS86pOXYQC6kNsINuzWArMV0oEvV41ENT+IwEZHJrdEElCgmF8/Pn/
	 xo9bSyP7s/KBPDeg3fH24bNaZ8Oe1hdeO2Byv2Hw1GF5V2xj4nWlA3DFBThFPLxwDE
	 bt4aVZo9fMGQQ==
Date: Sun, 23 Aug 2026 01:48:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: sca3000: fix frequency divider condition
 check
Message-ID: <20260823014841.0ec4be19@jic23-huawei>
In-Reply-To: <20260819135156.00002b2c@gmail.com>
References: <20260819114101.28232-1-salah.triki@gmail.com>
	<20260819135156.00002b2c@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 13:51:56 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Wed, 19 Aug 2026 12:41:01 +0100
> Salah Triki <salah.triki@gmail.com> wrote:
> 
> > When setting the sampling frequency, the check for `base_freq / 2` is
> > followed by an independent `if` statement for `base_freq / 4`. If `val`
> > equals `base_freq / 2`, the second check fails and falls through to the
> > `else if (val != base_freq)` branch, returning `-EINVAL` erroneously.
> > 
> > Fix this by chaining the checks with `else if`.
> > 
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > ---  
> 
> Good catch, this issue is 10 years old!
> 
> However, you're missing a fixes tag, I think b4 will pick it up
> if I leave it here since I already ran git blame.
> 
> Fixes: e0f3fc9b47e6 ("iio: accel: sca3000_core: implemented IIO_CHAN_INFO_SAMP_FREQ")
Thanks - b4 indeed picks it up. It saves me time even though b4 puts it
in the wrong place (well the right place given it came from the thread, but
wrong as it should have been there in the first place).
> 
> + cc stable
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> 


