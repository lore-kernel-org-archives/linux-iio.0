Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB6C30F81A;
	Wed,  3 Jun 2026 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506964; cv=none; b=To4vwt6bYbp6E3fX1shYoktz4WYruzr4HMaHCMU5G7B4+2sDXltfQGqGfNRRFKgtzyW6HKXwdyt4uoDMisqEJXVko2VN+r1of+i1nPnQOkhSXU+4ru4/1ryNc5D2BWugZZ5s4jwOXGV6JK+8sMAd7mch9Hc8ekuEHKUSpqTNsnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506964; c=relaxed/simple;
	bh=05E1w9Bj1w082bF3CaFZ5vMy+yBRO7W+OKVxMHCjI8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oz+NkOUu9fBNEFJ1K7cNDRtjm6ZXoc6nPmJBlmv/Re5+YvRAWPbfa58MLyNwfHfzABvMyBUcDtiNyCdwZSV/6ow81x22Pz/NmQ25wOGrJuxv6KR042QukInh6ri41K0cJmA1o769EuN0IVIoaskEYctDjgsih7SAx/syF08kBBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HquZ4THf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HquZ4THf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D101F00893;
	Wed,  3 Jun 2026 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780506963;
	bh=jnHzvITIsCtz3W2hnqu5dB5xBTJHlHY+sAmwSj3uYag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HquZ4THfv+HlUA01Mv55k2krOVX1gmN2TMuZRmI5/RR9wt1Ja/+VH/8+j1d4cbgyP
	 Dq+BD4AV186HT3+DtJe7lI/Le9yd3ed09SvYtu/QWVL2imckVsJ78EBRP9ZrPB2dGU
	 +/hmyrOrx9IDjAK9lqqxyTvZV5C/lVFfqdeK9jdQOVsHm34qAmGgB/ZaI2MCBoDzwW
	 DC/ft6DTePn5HnGUUTQo4Pt2esgtH/SQUiRilkRX4Jdq33+powujUlDcKjTwOgEBS3
	 XFHwdeciFg4KnsF4UsXkM6HFD6rPlnxNfZoFnEIGXfFT5xthzAqV9ZN3xxxT0whmuI
	 o+q2XKR34IERg==
Date: Wed, 3 Jun 2026 18:15:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3] iio: dac: mcp47feb02: Fix passing uninitialized
 vref1_uV for no Vref1 case
Message-ID: <20260603181554.33cca28c@jic23-huawei>
In-Reply-To: <20260603-mcp47feb02-fix4-v3-1-ed09975cad15@microchip.com>
References: <20260603-mcp47feb02-fix4-v3-1-ed09975cad15@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 17:44:48 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> Ensure that if a device has Vref1 but reading the regulator returns an
> error, mcp47feb02_init_ctrl_regs() is not called with an uninitialized
> vref1_uV value.
> 
> Also add a device_property_present() check for the Vref1 supply before
> reading the regulator.
> 
> Fixes: dd154646d292 ("iio: dac: mcp47feb02: Fix Vref validation [1-999] case")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/all/adiPnla0M5EzvgD-@stanley.mountain/
> 

No blank lines in tags block - that breaks all sorts of scripting.
There is even a bot that runs on some upstream trees to moan about htis.

> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

This is certainly a complex fix. Is there any path to simplify things by
first applying a more restrictive check and then later relaxing it as
a 'feature' which can take a slower path.


> ---
> Changes in v3:
> - Handle mismatch between vref modes at power up and enable regulator
>    only after the user corrects it.
> - Link to v2: https://lore.kernel.org/r/20260420-mcp47feb02-fix4-v2-1-8b758eaa8bcf@microchip.com
> 
> Changes in v2:
> - return the reading regulator error to not use vref1_uV uninitialized in
>    mcp47feb02_init_ctrl_regs() call 
> - add device_property_present() check for the Vref1
> - Link to v1: https://lore.kernel.org/r/20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com
> ---
>  drivers/iio/dac/mcp47feb02.c | 245 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 202 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> index faccb804a5ed548088aaf83266b16ed45a92916c..09eab829b1b57c7a794bbac2dee581cb1fad575f 100644
> --- a/drivers/iio/dac/mcp47feb02.c
> +++ b/drivers/iio/dac/mcp47feb02.c
> @@ -68,6 +68,11 @@
>  #define MCP47FEB02_INTERNAL_BAND_GAP_uV			2440000
>  #define NV_DAC_ADDR_OFFSET				0x10
>  
> +#define MCP47FEB02_VDD_VOLTAGE_REFERENCE "Device VDD"
> +#define MCP47FEB02_INTERNAL_BAND_GAP_VOLTAGE_REFERENCE "Internal Band Gap"
> +#define MCP47FEB02_PRIMARY_VOLTAGE_REFERENCE "External VREF pin"
> +#define MCP47FEB02_SECOND_VOLTAGE_REFERENCE "External VREF1 pin"
> +
>  enum mcp47feb02_vref_mode {
>  	MCP47FEB02_VREF_VDD = 0,
>  	MCP47FEB02_INTERNAL_BAND_GAP = 1,
> @@ -307,6 +312,7 @@ static const struct mcp47feb02_features mcp47fvb28_chip_features = {
>   * @powerdown: is false if the channel is in normal operation mode
>   * @powerdown_mode: selected power-down mode
>   * @dac_data: dac value
> + * @ref_mismatch: true if the restored register configuration is different from the device tree one
>   */
>  struct mcp47feb02_channel_data {
>  	u8 ref_mode;
> @@ -314,6 +320,7 @@ struct mcp47feb02_channel_data {
>  	bool powerdown;
>  	u8 powerdown_mode;
>  	u16 dac_data;
> +	bool ref_mismatch;
>  };
>  
>  /**
> @@ -326,11 +333,15 @@ struct mcp47feb02_channel_data {
>   * @active_channels_mask: enabled channels
>   * @regmap: regmap for directly accessing device register
>   * @labels: table with channels labels
> + * @vref1_reg: Vref1 regulator to be enabled after correcting reference mismatch
> + * @vref_reg: Vref/Vref0 regulator to be enabled after correcting reference mismatch
>   * @phys_channels: physical channels on the device
>   * @vref1_buffered: Vref1 buffer is enabled
>   * @vref_buffered: Vref/Vref0 buffer is enabled
>   * @use_vref1: vref1-supply is defined
>   * @use_vref: vref-supply is defined
> + * @vref1_enabled: true if Vref1 regulator has been enabled
> + * @vref_enabled: true if Vref/Vref0 regulator has been enabled
>   */
>  struct mcp47feb02_data {
>  	struct mcp47feb02_channel_data chdata[MCP47FEB02_MAX_CH];
> @@ -341,11 +352,15 @@ struct mcp47feb02_data {
>  	unsigned long active_channels_mask;
>  	struct regmap *regmap;
>  	const char *labels[MCP47FEB02_MAX_CH];
> +	struct regulator *vref_reg;
> +	struct regulator *vref1_reg;
>  	u16 phys_channels;
>  	bool vref1_buffered;
>  	bool vref_buffered;
>  	bool use_vref1;
>  	bool use_vref;
> +	bool vref1_enabled;
> +	bool vref_enabled;
>  };
>  
>  static const struct regmap_range mcp47feb02_readable_ranges[] = {
> @@ -798,6 +813,48 @@ static int mcp47feb02_check_scale(struct mcp47feb02_data *data, int val, int val
>  	return -EINVAL;
>  }
>  
> +static void mcp47feb02_regulator_disable(void *d)

As mentioned below for ordering this needs to be registered unconditionally
and in a form that lets you check if the regulator is thought to be enabled.

> +{
> +	struct regulator *reg = (struct regulator *)d;
> +
> +	if (reg)
> +		regulator_disable(reg);
> +}
> +
> +static bool mcp47feb02_ref_mismatch(struct mcp47feb02_data *data, unsigned int ch)
> +{
> +	bool use_vref, use_bandgap;
> +
> +	if (data->chdata[ch].ref_mode == MCP47FEB02_VREF_VDD)
> +		return false;
> +
> +	use_vref = (data->phys_channels >= 4 && (ch % 2)) ?  data->use_vref1 : data->use_vref;
> +	use_bandgap = (data->chdata[ch].ref_mode == MCP47FEB02_INTERNAL_BAND_GAP);
> +
> +	return use_vref == use_bandgap;
> +}
> +
> +static int mcp47feb02_enable_reg(struct mcp47feb02_data *data, struct regulator *reg, bool *enabled)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	if (*enabled)
> +		return 0;
> +
> +	ret = regulator_enable(reg);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> +
> +	ret = devm_add_action_or_reset(dev, mcp47feb02_regulator_disable, reg);
> +	if (ret)
> +		return ret;
> +
> +	*enabled = true;
> +
> +	return 0;
> +}
> +
>  static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
>  {
>  	int tmp_val, ret;
> @@ -806,6 +863,10 @@ static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
>  		tmp_val = MCP47FEB02_VREF_VDD;
>  	} else if (data->phys_channels >= 4 && (ch % 2)) {
>  		if (data->use_vref1) {
> +			ret = mcp47feb02_enable_reg(data, data->vref1_reg, &data->vref1_enabled);
> +			if (ret)
> +				return ret;
> +

So, the devm call here is safe?  It occurs after devm_iio_device_register() which means on tear down
path you might get a read after this turns the power off.

I guess the intent here is to lazily enable the regulator and maybe save power.
For the fix, just turn it on at the start. We can be clever later even then I'd do it
by registering the cleanup at the point you do if they are initially using the reference
but gate it on a flag that says if the regulator is in use.

>  			if (data->vref1_buffered)
>  				tmp_val = MCP47FEB02_EXTERNAL_VREF_BUFFERED;
>  			else
> @@ -814,6 +875,10 @@ static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
>  			tmp_val = MCP47FEB02_INTERNAL_BAND_GAP;
>  		}
>  	} else if (data->use_vref) {
> +		ret = mcp47feb02_enable_reg(data, data->vref_reg, &data->vref_enabled);
> +			if (ret)
> +				return ret;

Alignment gone wrong.

> +
>  		if (data->vref_buffered)
>  			tmp_val = MCP47FEB02_EXTERNAL_VREF_BUFFERED;
>  		else
> @@ -828,6 +893,7 @@ static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
>  		return ret;
>  
>  	data->chdata[ch].ref_mode = tmp_val;
> +	data->chdata[ch].ref_mismatch = false;
>  
>  	return 0;
>  }
> @@ -872,6 +938,16 @@ static int mcp47feb02_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec c
>  	struct mcp47feb02_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> +	guard(mutex)(&data->lock);
> +
> +	/*
> +	 * The reference mode restored from EEPROM may not match the current
> +	 * device tree configuration. Access will be allowed after a matching
> +	 * scale is written by the user.
> +	 */
> +	if (data->chdata[ch->address].ref_mismatch)
> +		return -EBUSY;
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		ret = regmap_read(data->regmap, REG_ADDR(ch->address), val);
> @@ -896,6 +972,12 @@ static int mcp47feb02_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		/*
> +		 * Allow only scale write operation until reference mismatch is corrected.
> +		 */
> +		if (data->chdata[ch->address].ref_mismatch)
> +			return -EBUSY;
> +
>  		ret = regmap_write(data->regmap, REG_ADDR(ch->address), val);
>  		if (ret)
>  			return ret;
> @@ -1034,36 +1116,67 @@ static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
>  		 * In order to overwrite the setting from volatile register with the one from the
>  		 * device tree, the user needs to write the chosen scale.
>  		 */
> -		switch (data->chdata[i].ref_mode) {
> -		case MCP47FEB02_INTERNAL_BAND_GAP:
> -			if (data->phys_channels >= 4 && (i % 2) && data->use_vref1) {
> -				dev_dbg(dev, "ch[%u]: was configured to use internal band gap", i);
> -				dev_dbg(dev, "ch[%u]: reference voltage set to VREF1", i);
> -				break;
> -			}
> -			if ((data->phys_channels < 4 || (data->phys_channels >= 4 && !(i % 2))) &&
> -			    data->use_vref) {
> -				dev_dbg(dev, "ch[%u]: was configured to use internal band gap", i);
> -				dev_dbg(dev, "ch[%u]: reference voltage set to VREF", i);
> -				break;
> +		data->chdata[i].ref_mismatch = mcp47feb02_ref_mismatch(data, i);
> +		if (data->chdata[i].ref_mismatch) {

This is getting too deeply nested. Maybe factor out a few helper functions.

> +			unsigned int ref_mode = data->chdata[i].ref_mode;
> +			const char *restored_vref;
> +			const char *dt_vref;
> +
> +			if (ref_mode == MCP47FEB02_VREF_VDD) {
> +				restored_vref = MCP47FEB02_VDD_VOLTAGE_REFERENCE;
> +			} else if (ref_mode == MCP47FEB02_INTERNAL_BAND_GAP) {
> +				restored_vref = MCP47FEB02_INTERNAL_BAND_GAP_VOLTAGE_REFERENCE;
> +			} else if ((ref_mode == MCP47FEB02_EXTERNAL_VREF_UNBUFFERED ||
> +				ref_mode == MCP47FEB02_EXTERNAL_VREF_BUFFERED) &&
> +				data->phys_channels >= 4 && (i % 2)) {

Align as:
			} else if ((ref_mode == MCP47FEB02_EXTERNAL_VREF_UNBUFFERED ||
				    ref_mode == MCP47FEB02_EXTERNAL_VREF_BUFFERED) &&
				   data->phys_channels >= 4 && (i % 2)) {

otherwise this is very hard to read.

> +				restored_vref = MCP47FEB02_SECOND_VOLTAGE_REFERENCE;
> +			} else {
> +				restored_vref = MCP47FEB02_PRIMARY_VOLTAGE_REFERENCE;
>  			}
> -			break;
> -		case MCP47FEB02_EXTERNAL_VREF_UNBUFFERED:
> -		case MCP47FEB02_EXTERNAL_VREF_BUFFERED:
> -			if (data->phys_channels >= 4 && (i % 2) && !data->use_vref1) {
> -				dev_dbg(dev, "ch[%u]: was configured to use VREF1", i);
> -				dev_dbg(dev,
> -					"ch[%u]: reference voltage set to internal band gap", i);
> -				break;
> -			}
> -			if ((data->phys_channels < 4 || (data->phys_channels >= 4 && !(i % 2))) &&
> -			    !data->use_vref) {
> -				dev_dbg(dev, "ch[%u]: was configured to use VREF", i);
> -				dev_dbg(dev,
> -					"ch[%u]: reference voltage set to internal band gap", i);
> -				break;
> +
> +			if (data->phys_channels >= 4 && (i % 2))
> +				if (data->use_vref1)
> +					dt_vref = MCP47FEB02_SECOND_VOLTAGE_REFERENCE;
> +				else
> +					dt_vref = MCP47FEB02_INTERNAL_BAND_GAP_VOLTAGE_REFERENCE;
> +			else
} else {
and other brackets to match.  Arguably it might be a kind of single statement but it is
too complex for the eye of a reviewer to parse it like that.


> +				if (data->use_vref)
> +					dt_vref = MCP47FEB02_PRIMARY_VOLTAGE_REFERENCE;
> +				else
> +					dt_vref = MCP47FEB02_INTERNAL_BAND_GAP_VOLTAGE_REFERENCE;
> +
> +			dev_info(dev, "ch[%u]: restored configuration uses %s\n",
> +				 i, restored_vref);
> +			dev_info(dev,
> +				 "ch[%u]: currently selected vref will not be in scale_available\n",
> +				 i);
> +			dev_info(dev, "ch[%u]: DT describes %s as the available reference source\n",
> +				 i, dt_vref);
> +		} else if (data->chdata[i].ref_mode == MCP47FEB02_EXTERNAL_VREF_UNBUFFERED ||
> +			   data->chdata[i].ref_mode == MCP47FEB02_EXTERNAL_VREF_BUFFERED) {
> +			unsigned int reg_vref;
> +			bool is_buf;
> +
> +			if (data->phys_channels >= 4 && (i % 2))
> +				is_buf = data->vref1_buffered;
> +			else
> +				is_buf = data->vref_buffered;
> +
> +			if (is_buf)
> +				reg_vref = MCP47FEB02_EXTERNAL_VREF_BUFFERED;
> +			else
> +				reg_vref = MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
> +
> +			if (data->chdata[i].ref_mode != reg_vref) {
> +				ret = regmap_update_bits(data->regmap, MCP47FEB02_VREF_REG_ADDR,
> +							 DAC_CTRL_MASK(i),
> +							 DAC_CTRL_VAL(i, reg_vref));
> +				if (ret)
> +					return ret;
> +
> +				data->chdata[i].ref_mode = reg_vref;
> +				dev_info(dev, "Mismatch buffer property for ch[%u]\n", i);
>  			}
> -			break;
>  		}
>  
>  		pd_tmp = (pd_ch >> (2 * i)) & MCP47FEB02_DAC_CTRL_MASK;
> @@ -1091,11 +1204,35 @@ static int mcp47feb02_init_ch_scales(struct mcp47feb02_data *data, int vdd_uV,
>  	return 0;
>  }
>  
> +static int mcp47feb02_try_enable_reg(struct mcp47feb02_data *data)

I'd just call it mcp47feb02_enable_regulators() or something like that.
Try usually implies it might fail in a normal condition. I don't think that's
true here?

> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
> +		if (data->chdata[i].ref_mismatch)
> +			continue;
> +
> +		if (data->chdata[i].ref_mode < MCP47FEB02_EXTERNAL_VREF_UNBUFFERED)
> +			continue;
> +
> +		if (data->phys_channels >= 4 && (i % 2))
> +			ret = mcp47feb02_enable_reg(data, data->vref1_reg, &data->vref1_enabled);
> +		else
> +			ret = mcp47feb02_enable_reg(data, data->vref_reg, &data->vref_enabled);
As mentioned above, if it is worth the late enable register the devm_ action for all cases here
but add a flag to gate on whether they happen to be on.  That way the tear down ordering is
correct in all cases.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int mcp47feb02_probe(struct i2c_client *client)
>  {
>  	const struct mcp47feb02_features *chip_features;
>  	struct device *dev = &client->dev;
>  	struct mcp47feb02_data *data;
> +	struct regulator *vref_reg;
>  	struct iio_dev *indio_dev;
>  	int vref1_uV, vref_uV, vdd_uV, ret;
>  
> @@ -1136,32 +1273,54 @@ static int mcp47feb02_probe(struct i2c_client *client)
>  
>  	vdd_uV = ret;
>  
> -	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> -	if (ret > 0) {
> -		vref_uV = ret;
> -		data->use_vref = true;
> +	if (device_property_present(dev, "vref-supply")) {
> +		vref_reg = devm_regulator_get(dev, "vref");
> +		if (IS_ERR(vref_reg))
> +			return PTR_ERR(vref_reg);
> +
> +		data->vref_reg = vref_reg;
> +
> +		vref_uV = regulator_get_voltage(vref_reg);
> +		if (vref_uV < 0)
> +			return vref_uV;
> +
> +		if (vref_uV > 0)
> +			data->use_vref = true;
> +		else
> +			dev_dbg(dev, "Vref is 0 uV, internal band gap will be used.\n");

Not sure why we paper over this one. Seems like a nonsensical setup - why not just
error out?

>  	} else {
>  		vref_uV = 0;
> -		dev_dbg(dev, "using internal band gap as voltage reference.\n");
> -		dev_dbg(dev, "Vref is unavailable.\n");
> +		dev_dbg(dev, "Using internal band gap as voltage reference.\n");
>  	}
>  
> -	if (chip_features->have_ext_vref1) {
> -		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
> -		if (ret > 0) {
> -			vref1_uV = ret;
> +	if (chip_features->have_ext_vref1 && device_property_present(dev, "vref1-supply")) {

I'd break that line.  Don't think it will greatly affect readability.

> +		vref_reg = devm_regulator_get(dev, "vref1");
> +		if (IS_ERR(vref_reg))
> +			return PTR_ERR(vref_reg);
> +
> +		data->vref1_reg = vref_reg;
> +
> +		vref1_uV = regulator_get_voltage(vref_reg);
> +		if (vref1_uV < 0)
> +			return vref1_uV;
> +
> +		if (vref1_uV > 0)
>  			data->use_vref1 = true;
> -		} else {
> -			vref1_uV = 0;
> -			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
> -			dev_dbg(dev, "Vref1 is unavailable.\n");

As above.

> -		}
> +		else
> +			dev_dbg(dev, "Vref1 is 0 uV, internal band gap will be used.\n");
> +	} else {
> +		vref1_uV = 0;
> +		dev_dbg(dev, "Using internal band gap as voltage reference 1.\n");
>  	}
>  
>  	ret = mcp47feb02_init_ctrl_regs(data);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Error initialising vref register\n");
>  
> +	ret = mcp47feb02_try_enable_reg(data);
> +	if (ret)
> +		return ret;
> +
>  	ret = mcp47feb02_init_ch_scales(data, vdd_uV, vref_uV, vref1_uV);
>  	if (ret)
>  		return ret;
> 
> ---
> base-commit: 51e7665ab81f02adc80a1219c260ee678e9c6eb8
> change-id: 20260414-mcp47feb02-fix4-614de9334f22
> 
> Best regards,

