Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38509 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753098AbdDHRV2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2017 13:21:28 -0400
Subject: Re: [PATCH 4/4] iio: dac: stm32: add support for waveform generator
To: Fabrice Gasnier <fabrice.gasnier@st.com>, linux@armlinux.org.uk,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1490960707-22422-1-git-send-email-fabrice.gasnier@st.com>
 <1490960707-22422-5-git-send-email-fabrice.gasnier@st.com>
 <e6a02296-fa72-50e8-d5e8-25bb5d496085@kernel.org>
 <ca8304bf-9107-f248-baff-8106fd68341c@st.com>
Cc: linux-iio@vger.kernel.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        benjamin.gaignard@linaro.org, benjamin.gaignard@st.com,
        linus.walleij@linaro.org, amelie.delaunay@st.com,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2dd966fd-f603-f58c-e724-fae8aba8e3d4@kernel.org>
Date: Sat, 8 Apr 2017 18:21:25 +0100
MIME-Version: 1.0
In-Reply-To: <ca8304bf-9107-f248-baff-8106fd68341c@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/04/17 17:46, Fabrice Gasnier wrote:
> JonathanOn 04/02/2017 02:19 PM, Jonathan Cameron wrote:
>> On 31/03/17 12:45, Fabrice Gasnier wrote:
>>> STM32 DAC has built-in noise or triangle waveform generator.
>>> Waveform generator requires trigger to be configured.
>>> - "wave" extended attribute selects noise or triangle.
>>> - "mamp" extended attribute selects either LFSR (linear feedback
>>>   shift register) mask for noise waveform, OR triangle amplitude.
>>>
>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>
>> Looks like AN3126 is the relevant doc.
>> (a quick note from this relevant to earlier patches- doc says
>> 1-3 channels - perhaps build that from the start with that
>> possibility in mind).
> Hi Jonathan,
> 
> Just to clarify this, some products like STM32F334xx have 3 channels,
> yes. Several STM32 DAC IPs (& so registers) are instantiated: DAC1 have
> two outputs (dac1_out1 & dac1_out2), DAC2 have one output (e.g.
> dac2_out1). Driver can be instantiated several times. Is it ok ?
Sure - I'd missed the complex structure when reading the doc.
> 
>>
>> As you probably know, this wanders into a large chunk of 'poorly'
>> defined ABI within IIO as it stands.
>>
>> Note there are a number of waveform generators still in staging.
>> Not a lot of movement on getting them out of staging unfortunately
>> (so far!)
>>
>> However, let us keep those drivers in mind as we work on ABI and
>> I definitely want some input from someone at Analog. 
>> Lars, who is best for this? I see at least some of these were
>> originally Michael's work.
>>
>> They do have partial docs under
>> drivers/staging/iio/Documentation/sysfs-bus-iio-dds
>> I'll highlight thoughts from there as I look through this...
> 
> Thanks for pointing this out.
> 
>>
>>
>>> ---
>>>  Documentation/ABI/testing/sysfs-bus-iio-dac-stm32 |  32 ++++++
>>>  drivers/iio/dac/stm32-dac.c                       | 124 ++++++++++++++++++++++
>>>  2 files changed, 156 insertions(+)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-stm32
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-dac-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-dac-stm32
>>> new file mode 100644
>>> index 0000000..c2432e1
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-dac-stm32
>>> @@ -0,0 +1,32 @@
>>> +What:		/sys/bus/iio/devices/iio:deviceX/wave
>>> +What:		/sys/bus/iio/devices/iio:deviceX/wave_available
>> Needs to be channel associated. Whilst in your case you have basically
>> a pair of single channel devices, in more general case, it's not usual
>> to have multiple parallel waveform generators clocked together.
>>
>> Old ABI is:
>> What:		/sys/bus/iio/devices/.../out_altvoltageX_outY_wavetype etc
>>
> I'll rework this in V2.
>>
>>> +KernelVersion:	4.12
>>> +Contact:	fabrice.gasnier@st.com
>>> +Description:
>>> +		List and/or select waveform generation provided by STM32 DAC:
>>> +		- "none": (default) means normal DAC operations
>> none kind of hints at nothing coming out.  Perhaps 'flat' would be closer?
>> i.e. only changes when someone tells it to.
>>
>>> +		- "noise": select noise waveform
>>> +		- "triangle": select triangle waveform
>>> +		Note: when waveform generator is used, writing _raw sysfs entry
>>> +		adds a DC offset to generated waveform. Reading it reports
>>> +		current output value.
>> Interesting.  This gets fiddly but one option would be to describe the whole
>> device as a dds.
>>
>> Then we have flat type above, combined with an _offset.
> 
> I'll update from 'none' to 'flat' in V2, and use _offset.
It's a bit ugly and doesn't generalize well to driving this via DMA for example...

J
>>
>>> +
>>> +What:		/sys/bus/iio/devices/iio:deviceX/mamp
>>> +What:		/sys/bus/iio/devices/iio:deviceX/mamp_available
>>> +KernelVersion:	4.12
>>> +Contact:	fabrice.gasnier@st.com
>>> +Description:
>>> +		List and select mask/amplitude used for noise/triangle waveform
>>> +		generator, which are:
>>> +		- "0": unmask bit 0 of LFSR / triangle amplitude equal to 1
>>> +		- "1": unmask bit [1:0] of LFSR / triangle amplitude equal to 3
>>> +		- "2": unmask bit [2:0] of LFSR / triangle amplitude equal to 7
>>> +		- "3": unmask bit [3:0] of LFSR / triangle amplitude equal to 15
>>> +		- "4": unmask bit [4:0] of LFSR / triangle amplitude equal to 31
>>> +		- "5": unmask bit [5:0] of LFSR / triangle amplitude equal to 63
>>> +		- "6": unmask bit [6:0] of LFSR / triangle amplitude equal to 127
>>> +		- "7": unmask bit [7:0] of LFSR / triangle amplitude equal to 255
>>> +		- "8": unmask bit [8:0] of LFSR / triangle amplitude equal to 511
>>> +		- "9": unmask bit [9:0] of LFSR / triangle amplitude equal to 1023
>>> +		- "10": unmask bit [10:0] of LFSR / triangle amplitude equal to 2047
>>> +		- "11": unmask bit [11:0] of LFSR / triangle amplitude equal to 4095
>> I don't fully understand what is going on here - so I'm guessing somewhat.
> Sorry for this, this is basically amplitude.
> 
> I think best is to rename above to something like 'amplitude' and
> 'amplitude_available'.
> 
> I'll rework this in V2.
>>
>>
>> Let us try describing these generically.  If we define standard 'forms' of each
>> waveform type.  Say a 0 to 1 V peak to peak, then we could use _scale to control
>> this nicely.
>>
>>> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
>>> index 62e43e9..d7dda78 100644
>>> --- a/drivers/iio/dac/stm32-dac.c
>>> +++ b/drivers/iio/dac/stm32-dac.c
>>> @@ -41,10 +41,14 @@
>>>  /**
>>>   * struct stm32_dac - private data of DAC driver
>>>   * @common:		reference to DAC common data
>>> + * @wave:		waveform generator
>>> + * @mamp:		waveform mask/amplitude
>>>   * @swtrig:		Using software trigger
>>>   */
>>>  struct stm32_dac {
>>>  	struct stm32_dac_common *common;
>>> +	u32 wave;
>>> +	u32 mamp;
>>>  	bool swtrig;
>>>  };
>>>  
>>> @@ -157,6 +161,24 @@ static int stm32_dac_is_enabled(struct stm32_dac *dac, int channel)
>>>  	return !!en;
>>>  }
>>>  
>>> +static int stm32_dac_wavegen(struct stm32_dac *dac, int channel)
>>> +{
>>> +	struct regmap *regmap = dac->common->regmap;
>>> +	u32 mask, val;
>>> +
>>> +	if (channel == STM32_DAC_CHANNEL_1) {
>>> +		val = FIELD_PREP(STM32_DAC_CR_WAVE1, dac->wave) |
>>> +			FIELD_PREP(STM32_DAC_CR_MAMP1, dac->mamp);
>>> +		mask = STM32_DAC_CR_WAVE1 | STM32_DAC_CR_MAMP1;
>>> +	} else {
>>> +		val = FIELD_PREP(STM32_DAC_CR_WAVE2, dac->wave) |
>>> +			FIELD_PREP(STM32_DAC_CR_MAMP2, dac->mamp);
>>> +		mask = STM32_DAC_CR_WAVE2 | STM32_DAC_CR_MAMP2;
>>> +	}
>>> +
>>> +	return regmap_update_bits(regmap, STM32_DAC_CR, mask, val);
>>> +}
>>> +
>>>  static int stm32_dac_enable(struct iio_dev *indio_dev, int channel)
>>>  {
>>>  	struct stm32_dac *dac = iio_priv(indio_dev);
>>> @@ -164,6 +186,17 @@ static int stm32_dac_enable(struct iio_dev *indio_dev, int channel)
>>>  		STM32_DAC_CR_EN1 : STM32_DAC_CR_EN2;
>>>  	int ret;
>>>  
>>> +	if (dac->wave && !indio_dev->trig) {
>>> +		dev_err(&indio_dev->dev, "Wavegen requires a trigger\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	ret = stm32_dac_wavegen(dac, channel);
>>> +	if (ret < 0) {
>>> +		dev_err(&indio_dev->dev, "Wavegen setup failed\n");
>>> +		return ret;
>>> +	}
>>> +
>>>  	ret = stm32_dac_set_trig(dac, indio_dev->trig, channel);
>>>  	if (ret < 0) {
>>>  		dev_err(&indio_dev->dev, "Trigger setup failed\n");
>>> @@ -291,6 +324,96 @@ static int stm32_dac_debugfs_reg_access(struct iio_dev *indio_dev,
>>>  	.driver_module = THIS_MODULE,
>>>  };
>>>  
>>> +/* waveform generator wave selection */
>>> +static const char * const stm32_dac_wave_desc[] = {
>>> +	"none",
>>> +	"noise",
>>> +	"triangle",
>>> +};
>>> +
>>> +static int stm32_dac_set_wave(struct iio_dev *indio_dev,
>>> +			      const struct iio_chan_spec *chan,
>>> +			      unsigned int type)
>>> +{
>>> +	struct stm32_dac *dac = iio_priv(indio_dev);
>>> +
>>> +	if (stm32_dac_is_enabled(dac, chan->channel))
>>> +		return -EBUSY;
>>> +	dac->wave = type;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int stm32_dac_get_wave(struct iio_dev *indio_dev,
>>> +			      const struct iio_chan_spec *chan)
>>> +{
>>> +	struct stm32_dac *dac = iio_priv(indio_dev);
>>> +
>>> +	return dac->wave;
>>> +}
>>> +
>>> +static const struct iio_enum stm32_dac_wave_enum = {
>>> +	.items = stm32_dac_wave_desc,
>>> +	.num_items = ARRAY_SIZE(stm32_dac_wave_desc),
>>> +	.get = stm32_dac_get_wave,
>>> +	.set = stm32_dac_set_wave,
>>> +};
>>> +
>>> +/*
>>> + * waveform generator mask/amplitude selection:
>>> + * - noise: LFSR mask (linear feedback shift register, umasks bit 0, [1:0]...)
>>> + * - triangle: amplitude (equal to 1, 3, 5, 7... 4095)
>>> + */
>>> +static const char * const stm32_dac_mamp_desc[] = {
>>> +	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11",
>>> +};
>>> +
>>> +static int stm32_dac_set_mamp(struct iio_dev *indio_dev,
>>> +			      const struct iio_chan_spec *chan,
>>> +			      unsigned int type)
>>> +{
>>> +	struct stm32_dac *dac = iio_priv(indio_dev);
>>> +
>>> +	if (stm32_dac_is_enabled(dac, chan->channel))
>>> +		return -EBUSY;
>>> +	dac->mamp = type;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int  stm32_dac_get_mamp(struct iio_dev *indio_dev,
>>> +			       const struct iio_chan_spec *chan)
>>> +{
>>> +	struct stm32_dac *dac = iio_priv(indio_dev);
>>> +
>>> +	return dac->mamp;
>>> +}
>>> +
>>> +static const struct iio_enum stm32_dac_mamp_enum = {
>>> +	.items = stm32_dac_mamp_desc,
>>> +	.num_items = ARRAY_SIZE(stm32_dac_mamp_desc),
>>> +	.get = stm32_dac_get_mamp,
>>> +	.set = stm32_dac_set_mamp,
>>> +};
>>> +
>>> +static const struct iio_chan_spec_ext_info stm32_dac_ext_info[] = {
>>> +	IIO_ENUM("wave", IIO_SHARED_BY_ALL, &stm32_dac_wave_enum),
>>> +	{
>>> +		.name = "wave_available",
>>> +		.shared = IIO_SHARED_BY_ALL,
>>> +		.read = iio_enum_available_read,
>>> +		.private = (uintptr_t)&stm32_dac_wave_enum,
>>> +	},
>>> +	IIO_ENUM("mamp", IIO_SHARED_BY_ALL, &stm32_dac_mamp_enum),
>>> +	{
>>> +		.name = "mamp_available",
>>> +		.shared = IIO_SHARED_BY_ALL,
>>> +		.read = iio_enum_available_read,
>>> +		.private = (uintptr_t)&stm32_dac_mamp_enum,
>>> +	},
>>> +	{},
>>> +};
>>> +
>>>  #define STM32_DAC_CHANNEL(chan, name) {		\
>>>  	.type = IIO_VOLTAGE,			\
>>>  	.indexed = 1,				\
>>> @@ -306,6 +429,7 @@ static int stm32_dac_debugfs_reg_access(struct iio_dev *indio_dev,
>>>  		.storagebits = 16,		\
>>>  	},					\
>>>  	.datasheet_name = name,			\
>>> +	.ext_info = stm32_dac_ext_info		\
>>>  }
>>>  
>>>  static const struct iio_chan_spec stm32_dac_channels[] = {
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

