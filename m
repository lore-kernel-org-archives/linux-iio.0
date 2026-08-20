Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1F624676D;
	Thu, 20 Aug 2026 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787191114; cv=none; b=NWJSIucuj5GW2gvLxDaAkfKip2i3EqLKkqxyMQGP/vuH0Fuhy2W1V2w7HniD9mXWEFzxWh7bvgp8viUeDMWX3bCqYKkCilu/JjaDCTJeht+pvP6Mjp44nH+mPrtBkty5J8IpGgpScJ8z3+m5fWH8ajkas6hR91KU4p2iZcXoHAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787191114; c=relaxed/simple;
	bh=m7MwDlheE9rRdcJ5yjoOx0nP5fA7xkmKFxOtBxFbqF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BA5eMnX6b7j44Y5tTOnD6uoKU3HeT2lholP7L3m/cgOVnNeFSwFGx2UYgeeORkb43QTDUwND+T6ykEZeiMOZXxNIxdvPZnSM/JL6dLtHW4z8AgHXIfBSNXREp9golQsHJjBFBk48PTcI+4H+SIk9kd/X6MoXBJfJbdE+2yfFzl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvCiLJpL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvCiLJpL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5706E1F000E9;
	Thu, 20 Aug 2026 01:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787191113;
	bh=Su5FdNCw0gdBNSa8nJASjfTUCVnkypWSOCmZyqIN0Xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PvCiLJpLzrswaGYMI5jsG8grPvH5GiukH8oC7zhMEmDbAxgVNNXsKLMgqwwKKR8qS
	 h9hLZhN/nzs/THaImHAXheaxGv7OhrhkLCXRPnLkKWaqbcX8MkJkujAnYENNC9ibM+
	 mDVQwRJDCEeKfcwPvZ9REMQJYnBoxIqcjLRTmEwYuxGGsv2yuGDip+gxT8cVAHUW84
	 Rtu5fwbGyIv2MnNzSZ23My7iDEVaPCIiNr91SasTOI7ZInjB5kUr0xH7eEyAzY02ce
	 wvZQFmhgTZ5xt1ML15ir9/smnZXBbOnI2xIHy7WDheam7/minEe5C7FeMt02gefLu5
	 l9jInUjgyYBdw==
Date: Thu, 20 Aug 2026 02:58:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: srf04: fix error handling in
 srf04_probe()
Message-ID: <20260820025829.7a2ae2b4@jic23-huawei>
In-Reply-To: <20260819190317.8745-1-salah.triki@gmail.com>
References: <20260819190317.8745-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 20:03:17 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> If pm_runtime_set_active() fails during srf04_probe(),
> iio_device_unregister() is called to cleanup, but the driver continues to
> execute pm_runtime_enable() and pm_runtime_idle() instead of aborting
> probe.
> 
> Fix this by returning 'ret' immediately inside the error path if
> pm_runtime_set_active() fails, preventing invalid runtime PM operations on
> an unregistered device.
> 
> Fixes: 2251157b335b ("iio: srf04: add power management feature")
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
Fixed a few weeks back.

Thanks

Jonathan

> ---
>  drivers/iio/proximity/srf04.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> index 7be50bdebfcb..e03f3f0dee04 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -330,6 +330,7 @@ static int srf04_probe(struct platform_device *pdev)
>  		if (ret) {
>  			dev_err(data->dev, "pm_runtime_set_active: %d\n", ret);
>  			iio_device_unregister(indio_dev);
> +			return ret;
>  		}
>  
>  		pm_runtime_enable(data->dev);

