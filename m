Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9639399892;
	Sat,  1 Aug 2026 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785552942; cv=none; b=uPByr4VMOL7giN6nXAZG1MmpfHcAFkL2dGfe15Xi7y4naQ/LYFUY5icoutEFnzDQ3LxOYROXzaJjKpqb3VCUV00byWsATltDSXphzuy7uzOm4/sN6dFM9p/X+eoyEYYDKHwxFwM/jbIXqRPwUObfOn308cq1scP5HPcD3/VaAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785552942; c=relaxed/simple;
	bh=oGfo4celj+FCBqB+kjgT01iq06yO3Uf0lyMXr6rSA7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruf3MxL7ST2ToUpTsGyT7CEePyo9s85JWTA00YKrDvJUBrbPOtq9d2br5s2rSlKBBK3OAbQMFyK8nRbeQtFO5fyb43BTBpYbjhwfDR7vutw2Z/28iNXhxn7Lo+FiCrTwg0Utf2u1rvY6d18swgHI02nu6G8n5vNk0sKjnKV88TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Afr2JVG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Afr2JVG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54351F00AC4;
	Sat,  1 Aug 2026 02:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785552937;
	bh=WcUXGgRYYdqFfUZCq9+GNOMwdOyQQiKoPsI1D02I8l0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Afr2JVG0ZQSybBOB/hPwNUI0ntsHAx0qT3hbnXh0FcYrz5pELVGbV+cAksQ8DCrMd
	 NT/rwc2hxYk+BzNVovgh//DbfK8b87F0+mvA6HdKcoakGNKBcHaLgd01A4lWEufCfX
	 rVqlE4dnJTB7dlY0J4R4+aJXY5SmHm9njatRicmbx9Ewip/B5QjEkKBKdGGlKr5/X8
	 udOmc5XN+p47mvAmierhqGXrzw3/zpIbMiPKbjI8ylontc5mY23PKbMsB6edybm47W
	 qOkRLudO9bQ/hKy7DlFqAKuMINqXh25nEZDFxDz15mIcmsoHV7/JBWzsiBgkA4Zbsk
	 dO/GOll6nsDlQ==
Date: Sat, 1 Aug 2026 03:55:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Cong Nguyen <congnt264@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: srf04: fix pm_runtime handling on probe error path
Message-ID: <20260801035533.1a854a57@jic23-huawei>
In-Reply-To: <20260727155115.1855881-1-congnt264@gmail.com>
References: <20260727155115.1855881-1-congnt264@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 22:51:15 +0700
Cong Nguyen <congnt264@gmail.com> wrote:

> When pm_runtime_set_active() fails during probe, the driver logs the
> error and unregisters the IIO device, but then falls through and still
> calls pm_runtime_enable() before returning the error.
> 
> Since probe returns an error, srf04_remove() is never called, so
> runtime PM is left enabled without a matching pm_runtime_disable().
> This leaks the enable and triggers an "Unbalanced pm_runtime_enable!"
> warning on a subsequent bind of the device.
> 
> Return the error right after unregistering the IIO device so that
> runtime PM is not enabled on the failure path.
> 
> Fixes: 2251157b335b ("iio: srf04: add power management feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan


> ---
>  drivers/iio/proximity/srf04.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> index e97f9a20ac7a..337938657449 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -331,6 +331,7 @@ static int srf04_probe(struct platform_device *pdev)
>  		if (ret) {
>  			dev_err(data->dev, "pm_runtime_set_active: %d\n", ret);
>  			iio_device_unregister(indio_dev);
> +			return ret;
>  		}
>  
>  		pm_runtime_enable(data->dev);

