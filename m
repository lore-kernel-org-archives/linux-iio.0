Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BB3342539;
	Fri,  7 Aug 2026 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146093; cv=none; b=ICRZWNqCIF2UNMVPpdmPgtxp0WZDJePoXYNU2hynGb+ibJeGL3h8iUI004P5L3WOYVB4GBUA0CGNvPg+HkQTdsQN0ptcAFDybYbLFjzd+NXeZJzLgX1lqXddd9ksolo4lWiNm/9BZYHL7sOGhJPplX7RW9GqUojfQFYDCPQY7No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146093; c=relaxed/simple;
	bh=lhkrXF2pUDEV5XHbNeTHGkEa7D535otFb/rMM3+x/H8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kuWvcxZD7r9jiJ+/WxASe+ctadSebICY8AHtAK63QdcvE6Ngi8x6OPjRcEQQ14m8asbbjrTfBdM3BahWTb8eZmRjUaRAcc1KmvLwlBU7THGUmOq0Hz2R8Wn6pQhINvzScRmLbxwaSHRv7f/oaTkPuM4WfsKwpuECn5WenYvFjIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhvRa52y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhvRa52y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2ED1F000E9;
	Fri,  7 Aug 2026 23:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786146092;
	bh=hzs/iYWI2QZBhki32UMV5iStd4tQOxlqSSEQURJdnYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EhvRa52yPSOAW+7WVmI3grOt7xRaQM3xDwt8yfY0CR7tzOO3sGC7QWSZHmQ5SfGCZ
	 mALMgb+9SnqqDw1lz2KZW029HXcjJllHIKeX/UOf9q4AOZrzGUfxGjhiNeqhtDW8jz
	 88o6j/5bpwsC7G7BaHd2WrhDTxsDJVLzhBQi1J+taUdHAVToPJAudZHb0Xyq09kwRX
	 EvT6MZ/vnPfytg8M5fJlygDOOqW0JCAo6a0DQu3flzgUNhe1zR6VZN5QH/SdftktUy
	 5ftCGSG9RWyRntEqUZQ5umdDYIkSeoytaYuQlefh5O7BoJBqY19jIDrlakoGW0lTaL
	 F4JJxvW3vZHqg==
Date: Sat, 8 Aug 2026 00:41:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andreas Klinger <ak@it-klinger.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: srf04: fix runtime PM autosuspend
 cleanup
Message-ID: <20260808004129.53eafdd9@jic23-huawei>
In-Reply-To: <20260807141938.2491195-1-lgs201920130244@gmail.com>
References: <20260807141938.2491195-1-lgs201920130244@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Aug 2026 22:19:37 +0800
Guangshuo Li <lgs201920130244@gmail.com> wrote:

> srf04_probe() calls pm_runtime_use_autosuspend() when the optional
> power GPIO is present, but srf04_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> 
> The runtime PM documentation requires pm_runtime_use_autosuspend() to
> be balanced with pm_runtime_dont_use_autosuspend() when the driver is
> removed. Failing to do so can leave the autosuspend usage state
> unbalanced and may result in a usage_count leak when the autosuspend
> delay is negative.
> 
> Add the missing pm_runtime_dont_use_autosuspend() call in the remove
> path before disabling runtime PM.
> 
> This issue was found by manual code inspection.

A cleaner solution may be to move to devm_pm_runtime_set_active_enabled()
though I am slightly concerned by the ordering here where in probe
we do iio_device_register() then runtime pm setup.
Remove would generally be the reverse order but instead it
does iio_device_unregister() the the runtime pm teardown.

That complicates matters and I can't see why we need to do that.
Do take a close look to see if you can see any reason this might be done.

I think easiest is move runtime pm registration before iio_device_register(),
using devm_pm_runtime_set_active_enabled() and ripping out all the calls
that effectively replaces.

Then a follow up patch to move to devm_iio_device_register() and drop
remove() entirely.

Looks like I missed this odd ordering when reviewing back in 2020.
oops.

Thanks,

Jonathan


> 
> Fixes: 2251157b335b4 ("iio: srf04: add power management feature")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/iio/proximity/srf04.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> index 7be50bdebfcb..5f270f506803 100644
> --- a/drivers/iio/proximity/srf04.c
> +++ b/drivers/iio/proximity/srf04.c
> @@ -347,6 +347,7 @@ static void srf04_remove(struct platform_device *pdev)
>  	iio_device_unregister(indio_dev);
>  
>  	if (data->gpiod_power) {
> +		pm_runtime_dont_use_autosuspend(data->dev);
>  		pm_runtime_disable(data->dev);
>  		pm_runtime_set_suspended(data->dev);
>  	}

