Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A72DC77F;
	Wed, 13 May 2026 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778681465; cv=none; b=OOuNhItspDQ03rDg12xyGUuVF/H2z8QHuYZk8TLCHwR7vZquYQmFjwvsGgZciiA0lX+OW69YqzKtl2YuK6xUJE1iHuTiZdFpysD0dNw16Wcmrhmxt6bnwvtxxdOQbA3TtJS3jgrdCw6LDozG458/ZfWtKUv/BJOqe8QZegf44bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778681465; c=relaxed/simple;
	bh=CyAVAcpNGtqCn5j4tWF3NsURVjA1tr9YOJkujq5Zx78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1MgAaJyNRX0qxQ84m/CknW/U93trKFSC0HOUpoLkBswx8ViIadRXyLukxHL9UYiLAzcGluu59oVKZHB4paBF0xZ80fH4x0EFO+0SeOdFeLm6jJu4K/rlrxhMvV8ym8Bl0JfduTzDhDdis5LolryliUFpGK8KKy96Kq6z6FtEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/iJOxt3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/iJOxt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44266C19425;
	Wed, 13 May 2026 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778681465;
	bh=CyAVAcpNGtqCn5j4tWF3NsURVjA1tr9YOJkujq5Zx78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j/iJOxt3cYeX3hOvNzEVISeWagUQHLRpF9lVYVKc4PgTOLOqL1KC1zPS1lkRSFhXA
	 +GrnmnJO/g6ulxMghuOE1FzXX1D9bQgX4+MEH1eRx0rEw2kzUSqKJ7H96vYDQnc63L
	 kgza8isEDJcmnUPRgLqCy5hinDesW3ebEeGpxe3+mRaQDCgXDY1ryazlUMS43nQvVa
	 lZaVizE9Znncc4w1jZ8vW8/4+xuhlCD7jy5yzV+pa0IIIzI+zb1z17t0sc8j3nuCJT
	 0RL8E/hhTzVzItt2wkHpnrwEeVSLFSok4H04YvrzRUw51g5bojLyz3BXcXcD2lA9n2
	 c+TVLjExVibfg==
Date: Wed, 13 May 2026 15:10:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Michal Piekos <michal.piekos@mmpsystems.pl>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai
 <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: sun20i-gpadc: support non-contiguous channel
 lookups
Message-ID: <20260513151055.471cb719@jic23-huawei>
In-Reply-To: <20260513-fix-sunxi-gpadc-sparse-channels-v1-1-6c21e290bcee@mmpsystems.pl>
References: <20260513-fix-sunxi-gpadc-sparse-channels-v1-1-6c21e290bcee@mmpsystems.pl>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 11:51:31 +0200
Michal Piekos <michal.piekos@mmpsystems.pl> wrote:

> Using consumer driver like iio-hwmon which resolve channels thorugh
> io-channels phandles will fail for sparse channels because IIO core

Can we say the "IIO core by default" does this. Otherwise implication
is we don't provide an alternative - whereas the fwnode_xlate() callback
is there to cover this sort of thing.  Otherwise this sounds like we should
be modifying the IIO core rather than the driver.

Otherwise nothing from me to add to what Andy's already covered.

> threats phandle argument as index into channel array.
>         eg. <&gpadc 1> will fail if there is only channel@1 specified
> 
> Add fwnode_xlate which maps DT phandle to the registered channel whose
> chan->channel matches the hardware channel number. It allows sparse
> channel maps to be consumed by drivers like iio-hwmon.
> 
> Tested on Radxa Cubie A5E.
> 
> Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
> ---
>  drivers/iio/adc/sun20i-gpadc-iio.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20i-gpadc-iio.c
> index 861c14da75ad..95f34a352158 100644
> --- a/drivers/iio/adc/sun20i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun20i-gpadc-iio.c
> @@ -139,8 +139,21 @@ static irqreturn_t sun20i_gpadc_irq_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static int sun20i_gpadc_fwnode_xlate(struct iio_dev *indio_dev,
> +		const struct fwnode_reference_args *iiospec)
> +{
> +	int i;
> +
> +	for (i = 0; i < indio_dev->num_channels; i++)
> +		if (indio_dev->channels[i].channel == iiospec->args[0])
> +			return i;
> +
> +	return -EINVAL;
> +}
> +
>  static const struct iio_info sun20i_gpadc_iio_info = {
>  	.read_raw = sun20i_gpadc_read_raw,
> +	.fwnode_xlate = sun20i_gpadc_fwnode_xlate,
>  };
>  
>  static void sun20i_gpadc_reset_assert(void *data)
> 
> ---
> base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524
> change-id: 20260513-fix-sunxi-gpadc-sparse-channels-2b6b2063bd49
> 
> Best regards,
> --  
> Michal Piekos <michal.piekos@mmpsystems.pl>
> 

