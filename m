Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67DF364939;
	Mon, 23 Mar 2026 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252464; cv=none; b=ffPH7xhw9W8oH+1SREQ9FQsz9rHx0kqPb687JxL0yzw8l246XA2kTbcCminQdkfmAOr7Tu4iPOm8bxdXE6sBAXKXmHMuyYfDrtBvi5xKX6uv7G/Bsp09dlDpixJdk2rWu6KFlGn96N9Gwiv7JrG3R8MntEGzVWIHL+vC/3Xnj/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252464; c=relaxed/simple;
	bh=4nI58+qRE2GtQ0izikLXOL0cpLBkhqpsV4mcS9D3lD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfLcvEjZj1M110hZNq2ICvKPErZYn2N/2cW0rt4cmzBeffD5IJRcdTUUpl0M3M2teyHymXsd1v4c4y1YBGP5WfsUvsQQBbuIzwlwtEqUOIfEGusC3sZa2Ixotlt2EXRuRhDBWzNA1HQ7aD4GGp6gxm1pgpL2p8QnsqsI0Ef4Yv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6p0VKN3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6p0VKN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FFBC4CEF7;
	Mon, 23 Mar 2026 07:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774252464;
	bh=4nI58+qRE2GtQ0izikLXOL0cpLBkhqpsV4mcS9D3lD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6p0VKN3yoPEvE4orghwUnJTvJEOytkhKlz8EFdpfxjAYOZiuKVsC4tHbcRwWqAQz
	 cWEsPnqklsXdI7DDvn3zcq8qPrm3jbKNgnlkefQ8hQ/DRQoUIuJsxViEaPztOoZdID
	 3GkqjSkU/1Z0ie8YLb3Z5aCf1H3Uu+0cDi8YAvEH3Q8ze/AHZSx3M/q3bPXHP3nnhK
	 9AwlD8ISq8CrrP3+Mbw0omPoSP84vAlOUx5bsthKksHjchWuW9qnqtPMjVDnkg1mNL
	 S7CO6haiQoQEoTcZMtOVZ4XelZm/L6iQPUYOGEv9LaSrmiIMe+PVv+bIVPckWEScF3
	 5WYEH3y0SuvZg==
Date: Mon, 23 Mar 2026 08:54:21 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Xie <nick@khadas.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, 
	martin.blumenstingl@googlemail.com, jbrunet@baylibre.com, jic23@kernel.org, dlechner@baylibre.com, 
	andy@kernel.org, krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: adc: meson-saradc: add support for Meson S4
Message-ID: <20260323-quizzical-striped-husky-68e24e@quoll>
References: <20260323013408.429701-1-nick@khadas.com>
 <20260323013408.429701-3-nick@khadas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323013408.429701-3-nick@khadas.com>

On Mon, Mar 23, 2026 at 09:34:06AM +0800, Nick Xie wrote:
> Add support for the SARADC found on the Amlogic Meson S4 SoC.
> According to the documentation and current testing, it is fully
> compatible with the G12A parameter set, so we reuse
> `meson_sar_adc_g12a_data` for this new compatible string.
> 
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Signed-off-by: Nick Xie <nick@khadas.com>
> ---
>  drivers/iio/adc/meson_saradc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 47cd350498a0d..3ac48b7842c4f 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -1313,6 +1313,11 @@ static const struct meson_sar_adc_data meson_sar_adc_g12a_data = {
>  	.name = "meson-g12a-saradc",
>  };
>  
> +static const struct meson_sar_adc_data meson_sar_adc_s4_data = {
> +	.param = &meson_sar_adc_g12a_param,
> +	.name = "meson-s4-saradc",
> +};
> +
>  static const struct of_device_id meson_sar_adc_of_match[] = {
>  	{
>  		.compatible = "amlogic,meson8-saradc",
> @@ -1341,6 +1346,9 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
>  	}, {
>  		.compatible = "amlogic,meson-g12a-saradc",
>  		.data = &meson_sar_adc_g12a_data,
> +	}, {
> +		.compatible = "amlogic,meson-s4-saradc",

The point of compatible devices is to not add such entries. Drop.

Best regards,
Krzysztof

