Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDAE3E0257;
	Sat, 16 May 2026 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778932610; cv=none; b=l94oN+35c+Smcxsn0nOJP43pDdpfXC0GerK9e/Xlu7dcnffaxOgb9NaJTjl52IQU5n74ZxPZljbU/iMoAOqA1qaARselEC6tiME8HhyrB6a3FUW6STg8eV5eRTejP3OFXt2QorB7tFzfPHIGIxAkFSM52KZ2haHFQeBbtb2VkDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778932610; c=relaxed/simple;
	bh=3PpX64/KwUcKCQovla4ev6y/V5oZSP13uo4LPEpInhI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFlrwnqPlHEbu13y7JRMHSDVWp30tIyn4YVXcFDLeBNJU6fABlT6jh1BTmnK+iQp2BswuALu2ul0xAWiMBITk6sl68sciSwEffTer3dJgrKLi1+JOpI4XrysL79H0BmcsyB5Xxq57/X6jON79w8yFpMVAeEtRqoPxVc5r9/oIpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv21S8/7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv21S8/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A67C2BCFA;
	Sat, 16 May 2026 11:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778932609;
	bh=3PpX64/KwUcKCQovla4ev6y/V5oZSP13uo4LPEpInhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tv21S8/73ErdswF1KG0234sRuaRJKddO2BYAYki+51EU3hoFtAKteb642PdaCMrCp
	 RfxkOAFrmFN8pwSDlTSw+LuyDTJ4hWYzCZaA+8q6lsJsnLARtyp9KzWEdvAvjkmkVC
	 oe5KzEwnFBAJAZ799bROTskx3Zz1Y4Qk0sv9dw0K7MyMsSJ2BDCLL+JZTN4p9ygXOU
	 SHJtQtCjjAcTr4twlvvZquvvfjLuW0mZX10mmRfntmyp3TbupC7gJ3b8paF+nxegRB
	 64qi50YenNJ6JXcQipdB6fXwamd6JWeU6L4k9BtOeeLBGpBofQNsg0L+YY8TBHkF+2
	 T6Ye2ZvWJkypA==
Date: Sat, 16 May 2026 12:56:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Alexander Koch <mail@alexanderkoch.net>, Michael Hornung
 <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 01/10] iio: light: opt3001: move device registration
 to end of probe()
Message-ID: <20260516125628.53b90c7e@jic23-huawei>
In-Reply-To: <20260512-opt3001-cleanup-v2-1-8018cf3a8a0a@gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
	<20260512-opt3001-cleanup-v2-1-8018cf3a8a0a@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 12:57:21 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Move devm_iio_device_register() to end of the opt3001_probe() function
> to prevent a race condition where userspace could interact with the
> device before the hardware IRQ was set up.
> 
> Fixes: ac663db3678a ("iio: light: opt3001: enable operation w/o IRQ")
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260511-opt3001-cleanup-v1-0-f7879dc3455c%40gmail.com?part=7
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/light/opt3001.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 53bc455b7bad142695d9fecc6cabb934fb3ace0c..3c79e0c4ca32fedf33e318d047d6ab3f62b6c03b 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -874,12 +874,6 @@ static int opt3001_probe(struct i2c_client *client)
>  	iio->modes = INDIO_DIRECT_MODE;
>  	iio->info = &opt3001_info;
>  
> -	ret = devm_iio_device_register(dev, iio);
> -	if (ret) {
> -		dev_err(dev, "failed to register IIO device\n");
> -		return ret;
> -	}
> -
>  	/* Make use of INT pin only if valid IRQ no. is given */
>  	if (irq > 0) {
>  		ret = request_threaded_irq(irq, NULL, opt3001_irq,
> @@ -894,6 +888,10 @@ static int opt3001_probe(struct i2c_client *client)
>  		dev_dbg(opt->dev, "enabling interrupt-less operation\n");
>  	}
>  
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err(dev, "failed to register IIO device\n");

Sashiko correctly points out this won't build.  I guess you were aiming for
	if (ret)
		return dev_err_probe(dev, ret, "failed to register IIO device\n");

My eyes skipped right over that whilst reading :(

The devres comment is also correct. So given this is a fix you can't do it
like this.  You'd need to move to
	ret = iio_device_register(iio);
and explicit iio_device_unregister(iio) in remove.

Then later put it back to devm when you convert the rest.

https://sashiko.dev/#/patchset/20260512-opt3001-cleanup-v2-0-8018cf3a8a0a%40gmail.com

Jonathan


> +
>  	return 0;
>  }
>  
> 

