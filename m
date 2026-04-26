Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C76D21256C;
	Sun, 26 Apr 2026 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777211092; cv=none; b=YZNswITvBgsrt1l53/6A80yP5hVzuuvnh2tlLd8qcRyeToABKxjvkgfQW56Znq66eyFH2ubyDWRuWj9dzH1V09GGvGOVTDiRuJNC5jInjxm3wuPfERJENiWz1knyACFcwxiETGDIi50R4cBbLJ3151EUeUQM2xtKFOAx+Y+hboA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777211092; c=relaxed/simple;
	bh=TUTzVPHCONlQ9CuJLDwyy+kNdND3yI/JvPPcjoIgZbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNSMPUseCfER0NjfmEVD6moub4193/K8hTH/W6NF43pOTV1x+aEd2GXRRyd+D2A6OVICKXwcxaUOrmGao/emKhEZSxYr1g7cDSPKDTb5IoQrnQm0LdupafNo+0AhbMczHSyS0x3pxzDGmPYUG/EPHPcSFo4+EWecnYDRAfSBQvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o663pZpb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o663pZpb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8802C2BCAF;
	Sun, 26 Apr 2026 13:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777211091;
	bh=TUTzVPHCONlQ9CuJLDwyy+kNdND3yI/JvPPcjoIgZbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o663pZpbwxF8CKh1UHaZs5EBd4bke2y6UqnA7M4Em57GJU/VI04TklOURsA0PDwm7
	 g/It6b0wbp/QQGI1bbah856aeeTqNhIbdCuuViboCVbmgKgSTNhh+Og13wodSM9LWJ
	 6Bykr6ZCSXI5JuEhT4o+/9OIMLd3uwKzlvi4zWSEuf2ganglcGO/jZDL3H7xFRe0do
	 XP3oCmCObvxYQSs8waOIzt5uCu2aq/vJY6i8I88GtL0x+f6KmOGfNuVpfHtcuGnsF+
	 x1BImfYlRGnLKuyzgEwtKOAq5RpjyatpG5fsWhgxj23qvRTA/IgSKAWa7Fu2xi1V2d
	 h2eiq8vZNCD9A==
Date: Sun, 26 Apr 2026 14:44:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 05/10] iio: dac: ad5686: fix ref bit initialization for
 single-channel parts
Message-ID: <20260426144442.04d88a18@jic23-huawei>
In-Reply-To: <20260426-ad5686-fixes-v1-5-7c946a77794e@analog.com>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
	<20260426-ad5686-fixes-v1-5-7c946a77794e@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 09:38:06 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> For single-channel parts the control register is used to enable the
> internal voltage reference and perform powerdown control. The reference
> enable bit position was ignored when writing the register at the probe
> function (!!val was used). This patch adds a control_sync() function that
> properly consumes the mask definitions with FIELD_PREP(). As further
> cleanup, the created functions and definitions are also used in
> ad5686_write_dac_powerdown(). 

Probably split this out unless it is very trivial.
Just include stuff needed for fix in this patch.  Then follow
(after all the fixes) with the reuse.

> Some local variables ended up being unused
> (so removed) and st->use_internal_vref is initialized earlier in probe,
> because it is also applicable to the AD5686_REGMAP case.
> 
> Fixes: be1b24d24541 ("iio:dac:ad5686: Add AD5691R/AD5692R/AD5693/AD5693R support")

Why is this not at the start of the series?  Fixes always come
first even if that means they are a bit messier.  We need to
be able to backport them and don't want to have to mess with 
the large refactors that you have before them, to do so.

> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/ad5686.c | 89 ++++++++++++++++++++++++++++--------------------
>  drivers/iio/dac/ad5686.h |  3 +-
>  2 files changed, 54 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index e67faef91164..843e425f656f 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -6,11 +6,13 @@
>   */
>  
>  #include <linux/array_size.h>
> +#include <linux/bitfield.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/sysfs.h>
> +#include <linux/wordpart.h>
>  
>  #include "ad5686.h"
>  
> @@ -20,6 +22,24 @@ static const char * const ad5686_powerdown_modes[] = {
>  	"three_state"
>  };
>  
> +static int ad5310_control_sync(struct ad5686_state *st)
> +{
> +	unsigned int pd_val = st->pwr_down_mask & st->pwr_down_mode;
> +
> +	return st->write(st, AD5686_CMD_CONTROL_REG, 0,
> +			 FIELD_PREP(AD5310_PD_MSK, pd_val) |
> +			 FIELD_PREP(AD5310_REF_BIT_MSK, st->use_internal_vref ? 0 : 1));
> +}
> +
> +static int ad5683_control_sync(struct ad5686_state *st)
> +{
> +	unsigned int pd_val = st->pwr_down_mask & st->pwr_down_mode;
> +
> +	return st->write(st, AD5686_CMD_CONTROL_REG, 0,
> +			 FIELD_PREP(AD5683_PD_MSK, pd_val) |
> +			 FIELD_PREP(AD5683_REF_BIT_MSK, st->use_internal_vref ? 0 : 1));
> +}
> +
>  static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
>  				     const struct iio_chan_spec *chan)
>  {
> @@ -65,8 +85,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  	bool readin;
>  	int ret;
>  	struct ad5686_state *st = iio_priv(indio_dev);
> -	unsigned int val, ref_bit_msk;
> -	u8 shift, address = 0;
> +	unsigned int val;
> +	u8 address;
>  
>  	ret = kstrtobool(buf, &readin);
>  	if (ret)
> @@ -79,32 +99,34 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  
>  	switch (st->chip_info->regmap_type) {
>  	case AD5310_REGMAP:
> -		shift = 9;
> -		ref_bit_msk = AD5310_REF_BIT_MSK;
> +		ret = ad5310_control_sync(st);
> +		if (ret)
> +			return ret;
>  		break;
>  	case AD5683_REGMAP:
> -		shift = 13;
> -		ref_bit_msk = AD5683_REF_BIT_MSK;
> +		ret = ad5683_control_sync(st);
> +		if (ret)
> +			return ret;
>  		break;
>  	case AD5686_REGMAP:
> -		shift = 0;
> -		ref_bit_msk = 0;
>  		/* AD5674R/AD5679R have 16 channels and 2 powerdown registers */
> -		if (chan->channel > 0x7)
> +		val = st->pwr_down_mask & st->pwr_down_mode;
> +		if (chan->channel > 0x7) {
>  			address = 0x8;
> +			val = upper_16_bits(val);
> +		} else {
> +			address = 0x0;
> +			val = lower_16_bits(val);
> +		}
> +		ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, address, val);
> +		if (ret)
> +			return ret;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	val = ((st->pwr_down_mask & st->pwr_down_mode) << shift);
> -	if (!st->use_internal_vref)
> -		val |= ref_bit_msk;
> -
> -	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC,
> -			address, val >> (address * 2));
> -
> -	return ret ? ret : len;
> +	return len;
>  }
>  
>  static int ad5686_read_raw(struct iio_dev *indio_dev,
> @@ -416,11 +438,8 @@ int ad5686_probe(struct device *dev,
>  		 const char *name, ad5686_write_func write,
>  		 ad5686_read_func read)
>  {
> -	struct ad5686_state *st;
>  	struct iio_dev *indio_dev;
> -	unsigned int val, ref_bit_msk;
> -	bool has_external_vref;
> -	u8 cmd;
> +	struct ad5686_state *st;

I'd not bother with fixing up reverse xmas tree here.
That's an unrelated change and it makes this patch noisier than ideal.

>  	int ret, i;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> @@ -438,8 +457,8 @@ int ad5686_probe(struct device *dev,
>  	if (ret < 0 && ret != -ENODEV)
>  		return ret;
>  
> -	has_external_vref = ret != -ENODEV;
> -	st->vref_mv = has_external_vref ? ret / 1000 : st->chip_info->int_vref_mv;
> +	st->use_internal_vref = ret == -ENODEV;
> +	st->vref_mv = st->use_internal_vref ? st->chip_info->int_vref_mv : ret / 1000;
>  
>  	/* Set all the power down mode for all channels to 1K pulldown */
>  	for (i = 0; i < st->chip_info->num_channels; i++)
> @@ -457,29 +476,25 @@ int ad5686_probe(struct device *dev,
>  
>  	switch (st->chip_info->regmap_type) {
>  	case AD5310_REGMAP:
> -		cmd = AD5686_CMD_CONTROL_REG;
> -		ref_bit_msk = AD5310_REF_BIT_MSK;
> -		st->use_internal_vref = !has_external_vref;
> +		ret = ad5310_control_sync(st);
> +		if (ret)
> +			return ret;
>  		break;
>  	case AD5683_REGMAP:
> -		cmd = AD5686_CMD_CONTROL_REG;
> -		ref_bit_msk = AD5683_REF_BIT_MSK;
> -		st->use_internal_vref = !has_external_vref;
> +		ret = ad5683_control_sync(st);
> +		if (ret)
> +			return ret;
>  		break;
>  	case AD5686_REGMAP:
> -		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
> -		ref_bit_msk = 0;
> +		ret = st->write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
> +				st->use_internal_vref ? 0 : 1);
> +		if (ret)
> +			return ret;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	val = (has_external_vref | ref_bit_msk);
> -
> -	ret = st->write(st, cmd, 0, !!val);
> -	if (ret)
> -		return ret;
> -
>  	return devm_iio_device_register(dev, indio_dev);
>  }


