Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43104 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbdDIJe6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Apr 2017 05:34:58 -0400
Subject: Re: [PATCH v2 5/5] iio: dac: stm32: add support for waveform
 generator
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1491495116-7209-1-git-send-email-fabrice.gasnier@st.com>
 <1491495116-7209-6-git-send-email-fabrice.gasnier@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8fa183fe-42f1-dc27-efd9-1f7d2e5b5057@kernel.org>
Date: Sun, 9 Apr 2017 10:34:54 +0100
MIME-Version: 1.0
In-Reply-To: <1491495116-7209-6-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/17 17:11, Fabrice Gasnier wrote:
> STM32 DAC has built-in noise or triangle waveform generator.
> - "wavetype" extended attribute selects noise or triangle.
> - "amplitude" extended attribute selects amplitude for waveform generator
> 
> A DC offset can be added to waveform generator output. This can be done
> using out_voltage[1/2]_offset
> 
> Waveform generator requires a trigger to be configured, to increment /
> decrement internal counter in case of triangle generator. Noise
> generator is a bit different,  but also requires a trigger to generate
> samples.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Various bits inline.  Mostly I think the blockers on this will be
making sure the ABI defined is generic enough to handle the more crazy
DDS chips out there... (basically the ones doing frequency modulation).

Jonathan
> ---
> Changes in v2:
> - use _offset parameter to add DC offset to waveform generator
Conceptually this offset is just the normal DAC output value (particularly
in the flat case)  I guess we can paper over this by having the _raw
and this always have th same value, but it's a little inelegant.
Still people are going to expect _raw to control it when in DAC mode but
that makes limited sense in DDS mode.

Mind you nothing stops us defining all DDS channels as the sum of whatever
the DDS is doing and whatever is _raw is set to. Perhaps we tidy this up
purely through documentation.  Think of the DDS as a modulation on top
of the DAC...

> - Rework ABI to better fit existing DDS ABI: use out_voltageY_wavetype,
>   out_voltage_wavetype_available, out_voltageY_amplitude,
>   out_voltage_amplitude_available
Hmm. I'm thinking those amplitude values aren't nice and don't fit well
with the more general ABI.

I suggested (but didn't really expand upon) having standard defined types
for each waveform then using scale to control the amplitude.

Is that something that might work here?

So say we have our triangle standard form having an amplitude of 1V Peak to
Peak. Then we can use scale to make it whatever we actually have in this
case?  The docs for wave type will need to describe those standard forms
though.

Hmm. Whether this is worth doing is unclear however as we'll still have
to describe the 'frequency' in terms of the clock ticks (here the triggers)
So maybe amplitude is worth having.  Again, looking for input from ADI lot
on this...  There are some really fiddly cases to describe were we are doing
symbol encoding so have multiple waveforms that we are switching between based
on some external signal. Any ABI needs to encompass that sort of usage.
Parts like the AD9833 for example...

> - Better explain trigger usage in case of waveform generator.
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-dac-stm32 |  16 +++
>  drivers/iio/dac/stm32-dac-core.h                  |   4 +
>  drivers/iio/dac/stm32-dac.c                       | 158 +++++++++++++++++++++-
>  3 files changed, 177 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-stm32
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-dac-stm32
> new file mode 100644
> index 0000000..8f1fa009
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-stm32
Fair enough to initially introduced these for this part only, but I'd very
much like to see us agree on these sufficiently to get them into the main
docs asap so we have something to work with for getting the DDS chips out
of staging...
> @@ -0,0 +1,16 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_wavetype
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_wavetype_available
> +KernelVersion:	4.12
> +Contact:	fabrice.gasnier@st.com
> +Description:
> +		List and/or select waveform generation provided by STM32 DAC:
> +		- "flat": waveform generator disabled (default)
> +		- "noise": select noise waveform
> +		- "triangle": select triangle waveform
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_amplitude
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltage_amplitude_available
> +KernelVersion:	4.12
> +Contact:	fabrice.gasnier@st.com
> +Description:
> +		List and/or select amplitude used for waveform generator
> diff --git a/drivers/iio/dac/stm32-dac-core.h b/drivers/iio/dac/stm32-dac-core.h
> index e51a468..0f02975 100644
> --- a/drivers/iio/dac/stm32-dac-core.h
> +++ b/drivers/iio/dac/stm32-dac-core.h
> @@ -37,8 +37,12 @@
>  #define STM32H7_DAC_CR_TEN1		BIT(1)
>  #define STM32H7_DAC_CR_TSEL1_SHIFT	2
>  #define STM32H7_DAC_CR_TSEL1		GENMASK(5, 2)
> +#define STM32_DAC_CR_WAVE1		GENMASK(7, 6)
> +#define STM32_DAC_CR_MAMP1		GENMASK(11, 8)
>  #define STM32H7_DAC_CR_HFSEL		BIT(15)
>  #define STM32_DAC_CR_EN2		BIT(16)
> +#define STM32_DAC_CR_WAVE2		GENMASK(23, 22)
> +#define STM32_DAC_CR_MAMP2		GENMASK(27, 24)
>  
>  /* STM32_DAC_SWTRIGR bit fields */
>  #define STM32_DAC_SWTRIGR_SWTRIG1	BIT(0)
> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
> index a7a078e..2ed75db 100644
> --- a/drivers/iio/dac/stm32-dac.c
> +++ b/drivers/iio/dac/stm32-dac.c
> @@ -42,10 +42,12 @@
>  /**
>   * struct stm32_dac - private data of DAC driver
>   * @common:		reference to DAC common data
> + * @wavetype:		waveform generator
>   * @swtrig:		Using software trigger
>   */
>  struct stm32_dac {
>  	struct stm32_dac_common *common;
> +	u32 wavetype;
>  	bool swtrig;
>  };
>  
> @@ -222,6 +224,29 @@ static int stm32_dac_set_value(struct stm32_dac *dac, int channel, int val)
>  	return ret;
>  }
>  
> +static int stm32_dac_get_offset(struct stm32_dac *dac, int channel, int *val)
> +{
> +	int ret;
> +
> +	/* Offset is only relevant in waveform generation mode. */
> +	if (!dac->wavetype) {
> +		*val = 0;
> +		return IIO_VAL_INT;
> +	}
> +
> +	/*
> +	 * In waveform generation mode, DC offset in DHR is added to waveform
> +	 * generator output, then stored to DOR (data output register).
> +	 * Read offset from DHR.
> +	 */
Just thinking what fun we could have if we do the fifo based output to push
this that I was suggesting for the previous patch ;) triangles on top
of fun general waveforms..

> +	if (STM32_DAC_IS_CHAN_1(channel))
> +		ret = regmap_read(dac->common->regmap, STM32_DAC_DHR12R1, val);
> +	else
> +		ret = regmap_read(dac->common->regmap, STM32_DAC_DHR12R2, val);
> +
> +	return ret ? ret : IIO_VAL_INT;
> +}
> +
>  static int stm32_dac_read_raw(struct iio_dev *indio_dev,
>  			      struct iio_chan_spec const *chan,
>  			      int *val, int *val2, long mask)
> @@ -231,6 +256,8 @@ static int stm32_dac_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		return stm32_dac_get_value(dac, chan->channel, val);
> +	case IIO_CHAN_INFO_OFFSET:
> +		return stm32_dac_get_offset(dac, chan->channel, val);
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = dac->common->vref_mv;
>  		*val2 = chan->scan_type.realbits;
> @@ -247,8 +274,16 @@ static int stm32_dac_write_raw(struct iio_dev *indio_dev,
>  	struct stm32_dac *dac = iio_priv(indio_dev);
>  
>  	switch (mask) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		/* Offset only makes sense in waveform generation mode */
> +		if (dac->wavetype)
> +			return stm32_dac_set_value(dac, chan->channel, val);
> +		return -EBUSY;
Yeah, I think I sent you down a blind alley here.  If people agree, lets
just define DDS signals as always being the sum of _raw + the dds element.
Then it's easy.
>  	case IIO_CHAN_INFO_RAW:
> -		return stm32_dac_set_value(dac, chan->channel, val);
> +		if (!dac->wavetype)
> +			return stm32_dac_set_value(dac, chan->channel, val);
> +		/* raw value is read only in waveform generation mode */
> +		return -EBUSY;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -334,6 +369,122 @@ static ssize_t stm32_dac_write_powerdown(struct iio_dev *indio_dev,
>  	.set = stm32_dac_set_powerdown_mode,
>  };
>  
> +/* waveform generator wave selection */
> +static const char * const stm32_dac_wavetype_desc[] = {
> +	"flat",
> +	"noise",
> +	"triangle",
> +};
> +
> +static int stm32_dac_set_wavetype(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  unsigned int wavetype)
> +{
> +	struct stm32_dac *dac = iio_priv(indio_dev);
> +	u32 mask, val;
> +	int ret;
> +
> +	/*
> +	 * Waveform generator requires a trigger to be configured, to increment
> +	 * or decrement internal counter in case of triangle generator. Noise
> +	 * generator is a bit different, but also requires a trigger to
> +	 * generate samples.
> +	 */
> +	if (wavetype && !indio_dev->trig)
> +		dev_dbg(&indio_dev->dev, "Wavegen requires a trigger\n");
> +
> +	if (STM32_DAC_IS_CHAN_1(chan->channel)) {
> +		val = FIELD_PREP(STM32_DAC_CR_WAVE1, wavetype);
> +		mask = STM32_DAC_CR_WAVE1;
> +	} else {
> +		val = FIELD_PREP(STM32_DAC_CR_WAVE2, wavetype);
> +		mask = STM32_DAC_CR_WAVE2;
> +	}
> +
> +	ret = regmap_update_bits(dac->common->regmap, STM32_DAC_CR, mask, val);
> +	if (ret)
> +		return ret;
> +	dac->wavetype = wavetype;
> +
> +	return 0;
> +}
> +
> +static int stm32_dac_get_wavetype(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan)
> +{
> +	struct stm32_dac *dac = iio_priv(indio_dev);
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(dac->common->regmap, STM32_DAC_CR, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (STM32_DAC_IS_CHAN_1(chan->channel))
> +		return FIELD_GET(STM32_DAC_CR_WAVE1, val);
> +	else
> +		return FIELD_GET(STM32_DAC_CR_WAVE2, val);
> +}
> +
> +static const struct iio_enum stm32_dac_wavetype_enum = {
> +	.items = stm32_dac_wavetype_desc,
> +	.num_items = ARRAY_SIZE(stm32_dac_wavetype_desc),
> +	.get = stm32_dac_get_wavetype,
> +	.set = stm32_dac_set_wavetype,
> +};
> +
> +/*
> + * waveform generator mamp selection: mask/amplitude
> + * - noise: LFSR mask (linear feedback shift register, umasks bit 0, [1:0]...)
This needs breaking out into two attributes - for noise it isn't amplitude in
any conventional sense...  Keep the result device specific for now. I'm not
even sure what type of pseudo random source that actually is...
If anyone wants to figure it out it would be great to document it in a general
form!

> + * - triangle: amplitude (equal to 1, 3, 5, 7... 4095)
> + */
> +static const char * const stm32_dac_amplitude_desc[] = {
> +	"1", "3", "7", "15", "31", "63", "127", "255", "511", "1023", "2047",
> +	"4095",
> +};
> +
> +static int stm32_dac_set_amplitude(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   unsigned int amplitude)
> +{
> +	struct stm32_dac *dac = iio_priv(indio_dev);
> +	u32 mask, val;
> +
> +	if (STM32_DAC_IS_CHAN_1(chan->channel)) {
> +		val = FIELD_PREP(STM32_DAC_CR_MAMP1, amplitude);
> +		mask = STM32_DAC_CR_MAMP1;
> +	} else {
> +		val = FIELD_PREP(STM32_DAC_CR_MAMP2, amplitude);
> +		mask = STM32_DAC_CR_MAMP2;
> +	}
> +
> +	return regmap_update_bits(dac->common->regmap, STM32_DAC_CR, mask, val);
> +}
> +
> +static int stm32_dac_get_amplitude(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan)
> +{
> +	struct stm32_dac *dac = iio_priv(indio_dev);
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_read(dac->common->regmap, STM32_DAC_CR, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (STM32_DAC_IS_CHAN_1(chan->channel))
> +		return FIELD_GET(STM32_DAC_CR_MAMP1, val);
> +	else
> +		return FIELD_GET(STM32_DAC_CR_MAMP2, val);
> +}
> +
> +static const struct iio_enum stm32_dac_amplitude_enum = {
> +	.items = stm32_dac_amplitude_desc,
> +	.num_items = ARRAY_SIZE(stm32_dac_amplitude_desc),
> +	.get = stm32_dac_get_amplitude,
> +	.set = stm32_dac_set_amplitude,
> +};
> +
>  static const struct iio_chan_spec_ext_info stm32_dac_ext_info[] = {
>  	{
>  		.name = "powerdown",
> @@ -343,6 +494,10 @@ static ssize_t stm32_dac_write_powerdown(struct iio_dev *indio_dev,
>  	},
>  	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &stm32_dac_powerdown_mode_en),
>  	IIO_ENUM_AVAILABLE("powerdown_mode", &stm32_dac_powerdown_mode_en),
> +	IIO_ENUM("wavetype", IIO_SEPARATE, &stm32_dac_wavetype_enum),
> +	IIO_ENUM_AVAILABLE("wavetype", &stm32_dac_wavetype_enum),
> +	IIO_ENUM("amplitude", IIO_SEPARATE, &stm32_dac_amplitude_enum),
> +	IIO_ENUM_AVAILABLE("amplitude", &stm32_dac_amplitude_enum),
>  	{},
>  };
>  
> @@ -352,6 +507,7 @@ static ssize_t stm32_dac_write_powerdown(struct iio_dev *indio_dev,
>  	.output = 1,					\
>  	.channel = chan,				\
>  	.info_mask_separate =				\
> +		BIT(IIO_CHAN_INFO_OFFSET) |		\
>  		BIT(IIO_CHAN_INFO_RAW) |		\
>  		BIT(IIO_CHAN_INFO_SCALE),		\
>  	/* scan_index is always 0 as num_channels is 1 */ \
> 

