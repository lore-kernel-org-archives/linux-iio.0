Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B40640E8CA;
	Fri,  5 Jun 2026 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665877; cv=none; b=IwH21CnKbsU1Qs1BvJYRckdu/mIQvS/1aPbcN35YaTMFtkvchoFzO1AsRNCAr+SXU+MGdGEmC7o5W4ba+8SCvWlpNZGOUrZ4AiZk1FOcRtj/aQ+WPfOxx43lyL50SYVQm7UBDAM0vmlImWPrSWZcICX/qj1k1/b/yWYO5+RS2+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665877; c=relaxed/simple;
	bh=81bGJGQreABbs6uaEfo9pHlqGsQ0bs2mY0b1X4FH5nI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIQIgW03Yl5eJUnDw03gNxQjvNh2G5+zSGpl8kUrDKfrXjusmYIiKCb+bhIoJPjt/e9z7nBfnxot7zXldPPI2sZaLwpgDW467mEHXW0mejDcIQikf91gg+4O1aXBNDtuIumgh75tzXDUEVQ4LG3uDoxV+cQ2pmCuMcC4zMMJOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1NWT3hq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1NWT3hq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF0C1F00893;
	Fri,  5 Jun 2026 13:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780665875;
	bh=BpGvgb0hocl8EsAwIZPdM5eWYEjmlqOzZzO985F0TPM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g1NWT3hq9XLZmVnInzDfdllEYebMKqXxuaqAbZZI4pmTxfpamNPIHNQWzjP1oadTy
	 EEgiQMfzHJM3c9BVFlK4Z2lxI3sQcyHgKyfMsc+bl8bMpz7nW5rvZORnnoXMEYVtxn
	 9u+ca7bNNTiFwZQY88YLXqDtqgiFNHfZbCmk7K6uu1VKRV0TYpOL3F8uU6D99qJgwF
	 RJBZj0moC/KwvezgUf5t2rP9kmbzGgNmmZcHpPdhhjl0KzMc3zWDcHIIOFTCNh1o63
	 kwigU/sdKnKkrOrTNXlhDD5j5k9+wV3K802JhrQ5PddlYHDBDLkfaO3mP1Mq8/lo3K
	 9FXIDpAI99VEQ==
Date: Fri, 5 Jun 2026 14:24:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: dac: ad3530r: Add support for AD3532R/AD3532
Message-ID: <20260605142428.5cd21b26@jic23-huawei>
In-Reply-To: <20260604-iio-ad3532r-support-v1-3-c3552f9031de@analog.com>
References: <20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com>
	<20260604-iio-ad3532r-support-v1-3-c3552f9031de@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 15:13:45 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> The AD3532R/AD3532 is a 16-channel, 16-bit voltage output DAC with a
> dual-bank register architecture (bank 0 at 0x1000 for channels 0-7,
> bank 1 at 0x3000 for channels 8-15).
> 
> Introduce a table-driven register bank approach: per-chip register
> address arrays in chip_info are iterated by ad3530r_update_reg_banks()
> and ad3530r_write_reg_banks() helpers. This replaces the single-register
> setup calls for existing variants (AD3530R, AD3531R) and scales
> naturally to the AD3532R's dual-bank layout without per-variant
> conditionals in the setup path.
> 
> Convert sw_ldac_trig_reg from a static register address to a function
> pointer to handle the AD3532R's per-bank LDAC trigger registers.
> 
> Add AD3532R-specific powerdown modes (1kohm_to_gnd, 10kohm_to_gnd,
> three_state) matching the OUTPUT_OPERATING_MODE register encoding, and
> a dedicated ad3532r_set_dac_powerdown() using arithmetic channel-to-
> register mapping for the 16-channel address space.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
Hi

Some minor stuff inline. Biggest thing is split the patch into:
1) Patch that refactors existing code only
2) Patch that adds new device support.

Jonathan

> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> index d9db3226ecd6..2bdff438b2a0 100644
> --- a/drivers/iio/dac/ad3530r.c
> +++ b/drivers/iio/dac/ad3530r.c
> @@ -2,6 +2,7 @@

>  static ssize_t ad3530r_get_dac_powerdown(struct iio_dev *indio_dev,
>  					 uintptr_t private,
>  					 const struct iio_chan_spec *chan,
> @@ -163,9 +209,9 @@ static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
>  					 const char *buf, size_t len)
>  {
>  	struct ad3530r_state *st = iio_priv(indio_dev);
> -	int ret;
>  	unsigned int reg, pdmode, mask, val;
>  	bool powerdown;
> +	int ret;
>  
>  	ret = kstrtobool(buf, &powerdown);
>  	if (ret)
> @@ -190,6 +236,56 @@ static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
>  	return len;
>  }
>  
> +static ssize_t ad3532r_set_dac_powerdown(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 const char *buf, size_t len)
> +{
> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +	unsigned int reg, pdmode, mask, val, local_ch;
> +	bool powerdown;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &powerdown);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +	local_ch = chan->channel % AD3530R_CH_PER_BANK;
> +	reg = (chan->channel < AD3530R_CH_PER_BANK ? AD3532R_OUTPUT_OPERATING_MODE_0 :
> +	       AD3532R_OUTPUT_OPERATING_MODE_2) + local_ch / AD3530R_CH_PER_REG;
Wrap is rather hard to read.
	reg = (chan->channel < AD3530R_CH_PER_BANK ? AD3532R_OUTPUT_OPERATING_MODE_0 :	
	       AD3532R_OUTPUT_OPERATING_MODE_2) +
	      local_ch / AD3530R_CH_PER_REG;
helps a bit

> +	mask = AD3530R_OP_MODE_CHAN_MSK(local_ch % AD3530R_CH_PER_REG);
> +
> +	pdmode = powerdown ? st->chan[chan->channel].powerdown_mode : 0;
> +	val = field_prep(mask, pdmode);
> +
> +	ret = regmap_update_bits(st->regmap, reg, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	st->chan[chan->channel].powerdown = powerdown;
> +
> +	return len;
> +}

> +static const struct ad3530r_chip_info ad3532_chip = {
> +	.name = "ad3532",
> +	.channels = ad3532r_channels,
> +	.num_channels = ARRAY_SIZE(ad3532r_channels),
> +	.sw_ldac_trig_reg = ad3532r_trigger_sw_ldac_reg,
> +	.input_ch_reg = ad3532r_input_ch_reg,
> +	.interface_config_a = ad3532r_if_config,
> +	.output_control = ad3532r_out_ctrl,
> +	.reference_control = ad3532r_ref_ctrl,
> +	.op_mode = ad3532r_op_mode,
> +	.num_banks = ARRAY_SIZE(ad3532r_if_config),
> +	.num_op_mode_regs = ARRAY_SIZE(ad3532r_op_mode),
> +	.internal_ref_support = false,
> +};
> +
> +static const struct ad3530r_chip_info ad3532r_chip = {
> +	.name = "ad3532r",
> +	.channels = ad3532r_channels,
> +	.num_channels = ARRAY_SIZE(ad3532r_channels),
> +	.sw_ldac_trig_reg = ad3532r_trigger_sw_ldac_reg,
> +	.input_ch_reg = ad3532r_input_ch_reg,
> +	.interface_config_a = ad3532r_if_config,
> +	.output_control = ad3532r_out_ctrl,
> +	.reference_control = ad3532r_ref_ctrl,
> +	.op_mode = ad3532r_op_mode,
> +	.num_banks = ARRAY_SIZE(ad3532r_if_config),
> +	.num_op_mode_regs = ARRAY_SIZE(ad3532r_op_mode),
> +	.internal_ref_support = true,
> +};

As mentioned below - split patch into refactors but no new parts, then
a patch just adding the new part support.

> +
> +static int ad3530r_update_reg_banks(const struct ad3530r_state *st,
> +				    const unsigned int *regs,
> +				    unsigned int num_regs,
> +				    unsigned int mask, unsigned int val)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < num_regs; i++) {
	for (unsigned int i...
> +		ret = regmap_update_bits(st->regmap, regs[i], mask, val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad3530r_write_reg_banks(const struct ad3530r_state *st,
> +				   const unsigned int *regs,
> +				   unsigned int num_regs,
> +				   unsigned int val)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < num_regs; i++) {
	for (unsigned int i = 0;
> +		ret = regmap_write(st->regmap, regs[i], val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
>  {
> +	const struct ad3530r_chip_info *chip_info = st->chip_info;
>  	struct device *dev = regmap_get_device(st->regmap);
>  	struct gpio_desc *reset_gpio;
> -	int i, ret;
>  	u8 range_multiplier, val;
> +	int i, ret;

Not in this patch. If you want to tidy up existing code ordering separate patch.

>  
>  	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>  	if (IS_ERR(reset_gpio))
> @@ -384,9 +644,10 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
>  		fsleep(1 * USEC_PER_MSEC);
>  		gpiod_set_value_cansleep(reset_gpio, 0);
>  	} else {
> -		/* Perform software reset */
> -		ret = regmap_update_bits(st->regmap, AD3530R_INTERFACE_CONFIG_A,
> -					 AD3530R_SW_RESET, AD3530R_SW_RESET);
> +		ret = ad3530r_update_reg_banks(st, chip_info->interface_config_a,
> +					       chip_info->num_banks,
> +					       AD3530R_SW_RESET,
> +					       AD3530R_SW_RESET);
>  		if (ret)
>  			return ret;
>  	}
> @@ -395,8 +656,10 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
>  
>  	range_multiplier = 1;
>  	if (device_property_read_bool(dev, "adi,range-double")) {
> -		ret = regmap_set_bits(st->regmap, AD3530R_OUTPUT_CONTROL_0,
> -				      AD3530R_OUTPUT_CONTROL_RANGE);
> +		ret = ad3530r_update_reg_banks(st, chip_info->output_control,
> +					       chip_info->num_banks,
> +					       AD3530R_OUTPUT_CONTROL_RANGE,
> +					       AD3530R_OUTPUT_CONTROL_RANGE);

Maybe worth a helper for 
ad3530r_set_reg_bank_bits() or something like that.

>  		if (ret)
>  			return ret;
>  
> @@ -406,8 +669,10 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
>  	if (external_vref_uV) {
>  		st->vref_mV = range_multiplier * external_vref_uV / MILLI;
>  	} else {
> -		ret = regmap_set_bits(st->regmap, AD3530R_REFERENCE_CONTROL_0,
> -				      AD3530R_REFERENCE_CONTROL_SEL);
> +		ret = ad3530r_update_reg_banks(st, chip_info->reference_control,
> +					       chip_info->num_banks,
> +					       AD3530R_REFERENCE_CONTROL_SEL,
> +					       AD3530R_REFERENCE_CONTROL_SEL);
>  		if (ret)
>  			return ret;
>  
> @@ -420,17 +685,11 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
>  	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(2), AD3530R_NORMAL_OP) |
>  	      FIELD_PREP(AD3530R_OP_MODE_CHAN_MSK(3), AD3530R_NORMAL_OP);
>  
> -	ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_0, val);
> +	ret = ad3530r_write_reg_banks(st, st->chip_info->op_mode,
> +				      st->chip_info->num_op_mode_regs, val);
>  	if (ret)

Given there is non trivial refactoring in here to make it easier to support the new
device, the patch should be spilt.  Refactors and no new support in first patch
so that we can just verify it does the same thing, then second patch adding new
device support.

>  		return ret;
>  
> -	if (st->chip_info->num_channels > 4) {
> -		ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_1,
> -				   val);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	for (i = 0; i < st->chip_info->num_channels; i++)
>  		st->chan[i].powerdown_mode = AD3530R_POWERDOWN_32K;
>  
> @@ -445,7 +704,7 @@ static int ad3530r_setup(struct ad3530r_state *st, int external_vref_uV)
>  static const struct regmap_config ad3530r_regmap_config = {
>  	.reg_bits = 16,
>  	.val_bits = 8,
> -	.max_register = AD3530R_MAX_REG_ADDR,
> +	.max_register = AD3532R_MAX_REG_ADDR,

What happens if we read off the end (via debugfs) for the smaller parts?

>  };
>  
>  static const struct iio_info ad3530r_info = {
> @@ -514,6 +773,8 @@ static const struct spi_device_id ad3530r_id[] = {
>  	{ "ad3530r", (kernel_ulong_t)&ad3530r_chip },
>  	{ "ad3531", (kernel_ulong_t)&ad3531_chip },
>  	{ "ad3531r", (kernel_ulong_t)&ad3531r_chip },
> +	{ "ad3532", (kernel_ulong_t)&ad3532_chip },
> +	{ "ad3532r", (kernel_ulong_t)&ad3532r_chip },

Add a precursor patch to switch this to named initializers. Otherwise
this will clash with the work Uwe is doing to ensure these are all done that
way.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ad3530r_id);
> @@ -523,6 +784,8 @@ static const struct of_device_id ad3530r_of_match[] = {
>  	{ .compatible = "adi,ad3530r", .data = &ad3530r_chip },
>  	{ .compatible = "adi,ad3531", .data = &ad3531_chip },
>  	{ .compatible = "adi,ad3531r", .data = &ad3531r_chip },
> +	{ .compatible = "adi,ad3532", .data = &ad3532_chip },
> +	{ .compatible = "adi,ad3532r", .data = &ad3532r_chip },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ad3530r_of_match);
> 

