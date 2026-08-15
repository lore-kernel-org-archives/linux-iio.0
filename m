Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA7284B37;
	Sat, 15 Aug 2026 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786756846; cv=none; b=URUKfX7ernglqv+J2/OLbeVcQEe1ktKXgOPB4EJ3RVVL6zq2v8fAtiBquReqgEA9mn7lU0NvPUAj7VVJpJTMU+T50lhq06Pq7SKgYN2kxnEK6WtsP6J/aWsjDFhe5Yzai8lhJvTKtA7IzflM6crEMKrMynPm/hzkQSZXs2oPwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786756846; c=relaxed/simple;
	bh=hU/MlJFC4Pa1PSVK06LJT7+iKJDUXjRc6a3B7vgNA2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hdLWSCChKaIpdP6qvzuPMFcxgrmeeZZ6NJAl7S89RQdd5PLJTuNPTggP79R4RGcclPlkGHTiGgbTcPV4Lxz3RR4g9akSUwGyuDN66OFgFQjelaIbjOmp3WW05nA4yKq8cg/YOJd02eXu0aww7ScQWAElOaFZyto6k+csOb7WdZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2+Kfnd9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2+Kfnd9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7FA1F000E9;
	Sat, 15 Aug 2026 01:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786756845;
	bh=e1GbwJutY4GdWm624xBCw3VzOLuvHYbs0MQRC3ke+iI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O2+Kfnd97Q/YA1Em578zO+4kBFdO/77iJ2SeVvuaxxOSzFIACMcDaloxuvktQITr8
	 1e2nAq0RFNaiWgjlPsmAVeAAJJPBCUDrC134SZ0q46jzS/MfmWy2QgMZyf4VjfEZcG
	 HWVOaNS9J04tpNMgxRiNdCscPqJKxF/wgGDvs2oqUwwAMk2znlVluIzU2od9jC/0Z0
	 Fkzgcg+Amk7f+ABEdv8mrDYnCkhjWJ1RymAdIM0pT4QRnebe0W25xN9EOpcmRfya4p
	 g2c51qwMQLRgMmlThdm6rsk9FMygyh3F7D4kH3XACnpU6c49fJP2soPl2CVkxBbQRH
	 +2G6rnQowHWLQ==
Date: Sat, 15 Aug 2026 02:20:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vladislav Leonov <vlad@zlab.su>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Heiko Stuebner
 <heiko@sntech.de>, Simon Glass <sjg@chromium.org>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: rockchip_saradc: Add support for RV1106
Message-ID: <20260815022036.7c47585e@jic23-huawei>
In-Reply-To: <20260810090826.146758-1-vlad@zlab.su>
References: <20260714131631.v2.1.0b846080833e4b836793c43fc26d1c6d817cf9b4@changeid>
	<20260810090826.146758-1-vlad@zlab.su>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 12:08:26 +0300
Vladislav Leonov <vlad@zlab.su> wrote:

> The Successive Approximation ADC (SARADC) in RV1106 uses the v2
> controller and supports:
> - 10-bit resolution
> - Up to 1MS/s sampling rate
> - 2 single-ended input channels
> 
> "dt-bindings: iio: adc: rockchip-saradc: Add RV1106 compatible"
> documents "rockchip,rv1106-saradc" as falling back to
> "rockchip,rk3588-saradc" (see Link below). The two IP blocks are not
> equivalent, though: per the RV1106 TRM v0.3, chapter 20 (SAR-ADC),
> RV1106 only has 2 channels at 10-bit resolution, versus 8 channels
> at 12-bit on RK3588. Without a dedicated match entry, the driver
> binds via the fallback compatible and uses the RK3588 channel table,
> which reports 8 channels instead of 2, and an in_voltage_scale that
> is off by exactly 4x (4096 vs 1024 full-scale).
> 
> Add a dedicated compatible/data pair for RV1106 with the correct
> 2-channel, 10-bit layout.
> 
> Tested on a custom RV1106-based board, with:
> 
>   &saradc {
> 	vref-supply = <&vcc_saradc>; /* 1.8V fixed regulator */
> 	status = "okay";
>   };
> 
> Before this patch:
>   # ls /sys/bus/iio/devices/iio:device0/in_voltage*_raw | wc -l
>   8
>   # cat /sys/bus/iio/devices/iio:device0/in_voltage_scale
>   0.439453125
> 
> After this patch:
>   # ls /sys/bus/iio/devices/iio:device0/in_voltage*_raw | wc -l
>   2
>   # cat /sys/bus/iio/devices/iio:device0/in_voltage_scale
>   1.757812500
> 
> Link: https://lore.kernel.org/all/20260714131631.v2.1.0b846080833e4b836793c43fc26d1c6d817cf9b4@changeid/
> Signed-off-by: Vladislav Leonov <vlad@zlab.su>

Hi Vladislav,

Could you also send a fix for the dt-binding as it clearly
shouldn't claim the fallback compatible!

Whilst I can see why you did here, in general don't reply
to an existing series when sending a new one.  Your link tag
is sufficient to associate the two.

I'll give this a little longer on list to let other comment, but
looks good to me.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/rockchip_saradc.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 0f0bf2906af0..5c45fae11890 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -348,6 +348,19 @@ static const struct rockchip_saradc_data rk3588_saradc_data = {
>  	.read = rockchip_saradc_read_v2,
>  };
>  
> +static const struct iio_chan_spec rockchip_rv1106_saradc_iio_channels[] = {
> +	SARADC_CHANNEL(0, "adc0", 10),
> +	SARADC_CHANNEL(1, "adc1", 10),
> +};
> +
> +static const struct rockchip_saradc_data rv1106_saradc_data = {
> +	.channels = rockchip_rv1106_saradc_iio_channels,
> +	.num_channels = ARRAY_SIZE(rockchip_rv1106_saradc_iio_channels),
> +	.clk_rate = 1000000,
> +	.start = rockchip_saradc_start_v2,
> +	.read = rockchip_saradc_read_v2,
> +};
> +
>  static const struct of_device_id rockchip_saradc_match[] = {
>  	{
>  		.compatible = "rockchip,saradc",
> @@ -370,6 +383,9 @@ static const struct of_device_id rockchip_saradc_match[] = {
>  	}, {
>  		.compatible = "rockchip,rk3588-saradc",
>  		.data = &rk3588_saradc_data,
> +	}, {
> +		.compatible = "rockchip,rv1106-saradc",
> +		.data = &rv1106_saradc_data,
>  	},
>  	{ }
>  };

