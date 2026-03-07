Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF379CD;
	Sat,  7 Mar 2026 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772890129; cv=none; b=Cv5LSnQYKAXwqIME99IrEldfDmoG+J+R4ezMaON1GxRFaVrQLM7iAP9MhjKJ0ZfMzWfaI0rvjxbBqetk5DTaVl78pZtjEUiHtmVazxN1/mxepZN3IuGR8xLqqy0p9RkGp84mUMK7Hzj1LPcT13WfFDbqecX8p/vWX+BxGqMIEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772890129; c=relaxed/simple;
	bh=8vMTG5OOmCJMXA2EGTfUTjyjg7fRHm+MjrEBcdyE03o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGebflDOA5cmLvd5HTqMUUuiBJJaXQY9A/A3QXvD/OX4M8Ry0N+uas26Cb5K2yMTAtbig137+mKHyN3R764Ezm5EvlKuNFj1XtM5Y/KCGOwD2RxtnFEg56goH/O+pNexTrnU27xrzG23BoTgxm+W539jj3f3OLJneavc5uxtVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9Qh5YAa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9Qh5YAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A82C19422;
	Sat,  7 Mar 2026 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772890129;
	bh=8vMTG5OOmCJMXA2EGTfUTjyjg7fRHm+MjrEBcdyE03o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q9Qh5YAaYT7I9ExOGO9djbucD5YhfFJ13NYE/MJnYSDI6iYvGk17fUPjcn3/NYlcE
	 U9ox2lxlTmx+yauXV4HI+gwBpf1msScL1beSra86vOGpKaAGR+fNwqWgsb+1TW/gAP
	 71NnB0g2jc5/c8ge4bu7Gn+TYbaoPw0kDd/RNBlmN7JcdigFjleGNwr8gg184EIPro
	 P3/WNcIciFPcQSEh/buVQ+FThAav0A8OkV93fEevWJRww5vhbQnU1h2j1RDlimA0/J
	 dsTFsF4FHTv2MGEobdTQoDwafnpufJouz70pHwEqbYIENDEeCrPJpuhiane0EWI1cq
	 adEBitGKknaxQ==
Date: Sat, 7 Mar 2026 13:28:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: adc: aspeed: clear reference voltage bits
 before configuring vref
Message-ID: <20260307132839.3126f5bc@jic23-huawei>
In-Reply-To: <20260303-adc-v3-1-10570f23d3ce@aspeedtech.com>
References: <20260303-adc-v3-1-10570f23d3ce@aspeedtech.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Mar 2026 10:38:26 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Ensures the reference voltage bits are cleared in the ADC engine
> control register before configuring the voltage reference. This
> avoids potential misconfigurations caused by residual bits.
> 
> Fixes: 1b5ceb55fec2 ("iio: adc: aspeed: Support ast2600 adc.")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
> Changes in v3:
> - Added the missing Fixes: tag
> 
> Changes in v2:
> - Remove Gerrit Change-Id's
> ---
>  drivers/iio/adc/aspeed_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 4be44c524b4d..83a9885b9ae4 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -415,6 +415,7 @@ static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
>  	}
>  	adc_engine_control_reg_val =
>  		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
> +	adc_engine_control_reg_val &= ~ASPEED_ADC_REF_VOLTAGE;
>  
>  	ret = devm_regulator_get_enable_read_voltage(data->dev, "vref");
>  	if (ret < 0 && ret != -ENODEV)
> 
> ---
> base-commit: af4e9ef3d78420feb8fe58cd9a1ab80c501b3c08
> change-id: 20260303-adc-47e5bfdf89c9
> 
> Best regards,

