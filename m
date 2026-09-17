Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96CD327BFC;
	Thu, 17 Sep 2026 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789606421; cv=none; b=XOWc5/0Onf4LDrTemVAykMrNni9MMTfT3D3HajzVWd7OCRf2W0c/TD5Or/bAcMrggnztI8PHqLiwwBIVLoW0gzQkRnXY4B4mvKFcDZrm3VuaNdOMy6n2G99zFlRdlTOqYeO3ALGn4cJ6q0bqtm0IQyE+Z+tjdNGF5crSp90dIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789606421; c=relaxed/simple;
	bh=Uz4p6DxU0SdxyUydaJvPRrf/toztJ8IMffbc31mCCkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9zoY7a0bnZXjrju58IDWFh+RmTb6//89Xqfl/x0oYlvXHKGmfkkVxmwejhrHazMbVOvZkwUtMVqfZ465JLrc4+K6LgE6tsoZ7T/UrKTyQxnZeMk3JZngmP1HVuXSTgX47fDirWMbYcWVc0WJHywY9LSZvEL9MW+ld/RxNoJZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgH+0UYE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgH+0UYE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFA71F000FF;
	Thu, 17 Sep 2026 00:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789606420;
	bh=tDAfd7qxjT3QFs5LZwZv4JIuJna7RAV6zJz8QZI5R9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BgH+0UYEzFc5jTYrumueCjpQVp9FPEvoiZci6/w0caUAl1reCqkjxyinGn+JikkD/
	 AwtntjKfzZF00WmJ820B8O87eD9I/25nSankCewHZrbTI0ovsY0iylvGOimZA8Rour
	 BUoMKJpD/1CTP401MhFO01FGB/2D5lHVxEgJvB6Ec5bN+msGtj/O/cJr8nQqDzV/y7
	 +Wz/8f8+tVNomtGU31BZis82nD2NPas/LKutLWuuQHeXl7onxX9tAd7xb2BharNdm6
	 YHrhBa38hq/sy5eGYJ91McYw3OrqY8GNGVc9YdoHx2KYen5RrTnq2/CP4NBd/VIaFt
	 x8KsHlsetHa4g==
Date: Thu, 17 Sep 2026 01:53:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 08/11] iio: dac: mcp47feb02: rename channel mask and
 value macros
Message-ID: <20260917015334.1f43bd02@jic23-hlaptop>
In-Reply-To: <20260916-mcp47feb02_refactor-v6-8-285464651f89@microchip.com>
References: <20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com>
	<20260916-mcp47feb02_refactor-v6-8-285464651f89@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 17:16:34 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> Rename generic DAC_CTRL_MASK/VAL macros to MCP47FEB02_VREF_PD_MASK/VAL
> in order to clearly indicate for which control registers these channel
> masks are suitable.
> 
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/all/20260528125140.16a8f173@jic23-huawei/
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  drivers/iio/dac/mcp47feb02.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> index 8dac4e2fb74fe4563324343ce215af3389129130..5c09ca25a75e0ecb2bfc5a2d5e62e5f7d3156810 100644
> --- a/drivers/iio/dac/mcp47feb02.c
> +++ b/drivers/iio/dac/mcp47feb02.c
> @@ -49,8 +49,8 @@
>  #define MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK		GENMASK(7, 0)
>  
>  /* Voltage reference, Power-Down control register and DAC Wiperlock status register fields */
> -#define DAC_CTRL_MASK(ch)				(GENMASK(1, 0) << (2 * (ch)))
> -#define DAC_CTRL_VAL(ch, val)				((val) << (2 * (ch)))
> +#define MCP47FEB02_VREF_PD_MASK(ch)			(GENMASK(1, 0) << (2 * (ch)))
> +#define MCP47FEB02_VREF_PD_VAL(ch, val)			((val) << (2 * (ch)))
Can we drop this one...
>  
>  /* Gain Control and I2C Slave Address Register fields */
>  #define DAC_GAIN_MASK(ch)				(BIT(0) << (8 + (ch)))
> @@ -555,7 +555,8 @@ static int mcp47feb02_suspend(struct device *dev)
>  		data->chdata[ch].powerdown = true;
>  		pd_mode = data->chdata[ch].powerdown_mode + 1;
>  		ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
> -					 DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, pd_mode));
> +					 MCP47FEB02_VREF_PD_MASK(ch),
> +					 MCP47FEB02_VREF_PD_VAL(ch, pd_mode));
.. and here have a local for mask.

		mask = MCP47FEB02_VREF_PD_MASK(ch);
  		ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
					 mask, field_prep(mask, pd_mode));		

Same in all the other cases. Will then match you do the field_get().


>  		if (ret)
>  			return ret;
>  
> @@ -587,7 +588,8 @@ static int mcp47feb02_resume(struct device *dev)
>  			return ret;
>  
>  		ret = regmap_update_bits(data->regmap, MCP47FEB02_VREF_REG_ADDR,
> -					 DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, pd_mode));
> +					 MCP47FEB02_VREF_PD_MASK(ch),
> +					 MCP47FEB02_VREF_PD_VAL(ch, pd_mode));


>  		if (ret)
>  			return ret;
>  
> @@ -598,8 +600,8 @@ static int mcp47feb02_resume(struct device *dev)
>  			return ret;
>  
>  		ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
> -					 DAC_CTRL_MASK(ch),
> -					 DAC_CTRL_VAL(ch, MCP47FEB02_NORMAL_OPERATION));
> +					 MCP47FEB02_VREF_PD_MASK(ch),
> +					 MCP47FEB02_VREF_PD_VAL(ch, MCP47FEB02_NORMAL_OPERATION));
>  		if (ret)
>  			return ret;
>  	}
> @@ -656,7 +658,8 @@ static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, uintptr_t p
>  	 */
>  	tmp_pd_mode = state ? (data->chdata[reg].powerdown_mode + 1) : MCP47FEB02_NORMAL_OPERATION;
>  	ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
> -				 DAC_CTRL_MASK(reg), DAC_CTRL_VAL(reg, tmp_pd_mode));
> +				 MCP47FEB02_VREF_PD_MASK(reg),
> +				 MCP47FEB02_VREF_PD_VAL(reg, tmp_pd_mode));
>  	if (ret)
>  		return ret;
>  
> @@ -822,7 +825,7 @@ static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
>  	}
>  
>  	ret = regmap_update_bits(data->regmap, MCP47FEB02_VREF_REG_ADDR,
> -				 DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, tmp_val));
> +				 MCP47FEB02_VREF_PD_MASK(ch), MCP47FEB02_VREF_PD_VAL(ch, tmp_val));
>  	if (ret)
>  		return ret;
>  
> @@ -1027,7 +1030,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
>  			return ret;
>  		data->chdata[i].dac_data = dac_val;
>  
> -		data->chdata[i].ref_mode = field_get(DAC_CTRL_MASK(i), vref_ch);
> +		data->chdata[i].ref_mode = field_get(MCP47FEB02_VREF_PD_MASK(i), vref_ch);
>  		data->chdata[i].use_2x_gain = field_get(DAC_GAIN_MASK(i), gain_ch);
>  
>  		/*
> @@ -1071,7 +1074,7 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
>  			break;
>  		}
>  
> -		pd_tmp = field_get(DAC_CTRL_MASK(i), pd_ch);
> +		pd_tmp = field_get(MCP47FEB02_VREF_PD_MASK(i), pd_ch);
>  		data->chdata[i].powerdown_mode = pd_tmp ? (pd_tmp - 1) : pd_tmp;
>  		data->chdata[i].powerdown = !!(data->chdata[i].powerdown_mode);
>  	}
> 

