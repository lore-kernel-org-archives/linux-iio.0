Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0029DB64;
	Sun, 13 Sep 2026 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789335826; cv=none; b=IyHXA/Iky1L4Jqt9miIh8kflsr4k7QldAJ+3iRWRAdm78NhQy5Fd+Tv6p1TVSKthVecLUWLVrdf2m6yroVx1uALJfqLaPzVpk2tIxoiUMKJN7SGPZvMgh7V6McYHfegAnBmsYO6qcoObnhvbRskJh/kVjk9DRnofpgO9EppgH1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789335826; c=relaxed/simple;
	bh=JIjszEbSA6ErzNHrKHBeLPcCmWcPej2aI1gqPOhCQb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMuc29AjAXvgUFoKXmbtcvw9M3ia7aMz0p3BBvmg/uH/o+8a/RUK/eTvgNjLG7pVIpODGHiZ7EtKWx8vg+4T9cogYSooEWofTStT3/iPGhdOI9uBgC+Z5otSJe3Xnc/GjuYTagNdUe5EEMTeUv+gWOywarfcmOvMjRKMBPBSO5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bm/MMFkP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bm/MMFkP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C571F000FF;
	Sun, 13 Sep 2026 21:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789335825;
	bh=cN2MMO4oTnmKgdpYsxYvdjfCKnOBm7xsrM9v5nYbt9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bm/MMFkPghb4h5T2AmSGISDUKsxVcYIw9u5vTzMT7vT+hPvaD6aSJ0ZSEr2h25nGQ
	 k+XjOs3Xq4/o+B3fDmTTWXv1DXe5+CzXSqAZEo8+zAqXigIulCx6kTgKy7rGbcSAf3
	 RNkj+mV6lS4E7iVdB9x4ejaT+sfxmaHMpbijIoVIBZzYx8wuZajuey/acw1qulHa6e
	 G9IUArqiqEnsJJFm7lVMQPdhw70QSU+e7YjjQa8EYVaUX6S3fqEBF77OEqg6PJtKBE
	 2sh9igyB1TS2hmTB0t1YLZhKLUkvPlFCoO9zIIhiJec0D1jjit4Z7XN9kJe7XjYhxW
	 +Emc4j3iVrspQ==
Date: Sun, 13 Sep 2026 22:43:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 02/10] iio: dac: mcp47feb02: Fix gain field
 initialization for active channels
Message-ID: <20260913224339.490d89ba@jic23-hlaptop>
In-Reply-To: <20260909-mcp47feb02_refactor-v5-2-8b67bcab93d1@microchip.com>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
	<20260909-mcp47feb02_refactor-v5-2-8b67bcab93d1@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 17:18:45 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> As per MCP47FXBX48 Datasheet, in the format of the Gain Control and System
> Status Register each DAC channel has one bit to control its gain,
> starting at bit 8, while bits 0-7 contain status or unimplemented bits.
> 
> The previous formula didn't initialize correctly all channels, being
> replaced by the already defined macro used in write operations where needed
> in the rest of the driver implementation. DAC_GAIN_MASK(i) extracts the
> gain control bit for each active channel correctly ine one step.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  drivers/iio/dac/mcp47feb02.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> index 7502959d98eab27941d58b6b961e6e3dee4222e6..bf78618ac2c896b94e494a1ce76ef5b3e520f482 100644
> --- a/drivers/iio/dac/mcp47feb02.c
> +++ b/drivers/iio/dac/mcp47feb02.c
> @@ -1017,7 +1017,6 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
>  	if (ret)
>  		return ret;
>  
> -	gain_ch = gain_ch & MCP47FEB02_GAIN_BITS_MASK;
>  	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
>  		struct device *dev = regmap_get_device(data->regmap);
>  		unsigned int pd_tmp, dac_val;
> @@ -1028,7 +1027,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
>  		data->chdata[i].dac_data = dac_val;
>  
>  		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
> -		data->chdata[i].use_2x_gain = (gain_ch >> i)  & MCP47FEB02_GAIN_BIT_MASK;
> +		data->chdata[i].use_2x_gain = (gain_ch & DAC_GAIN_MASK(i)) ? 1 : 0;
It's not a performance path (field_get() is a bit heavyweight!) so
		data->chdata[i].use_2x_gain = field_get(DAC_GAIN_MASK(i), gain_ch);
is perhaps a little more readable.

I don't mind that much either way.

Jonathan

>  
>  		/*
>  		 * Inform the user that the current voltage reference read from the volatile
> 

