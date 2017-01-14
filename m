Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51632 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdANOHZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2017 09:07:25 -0500
Subject: Re: [PATCH 3/4] iio: adc: add a driver for the SAR ADC found in
 Amlogic Meson SoCs
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <02fbde00-f325-56a6-7367-7101f7d4ee21@gmail.com>
 <aeafc889-0b2f-e341-5368-5c9d49caa9dd@gmail.com>
 <CAFBinCAD_EjYq9i1=vVNAh046q0jSSG38kc+UL_=6aeZRqsRHw@mail.gmail.com>
 <055cc8fa-46c3-fab2-2d9e-be4e5416fc5a@gmail.com>
 <CAFBinCAuTGrgOC5wNqoGfCb6NeQUsBCB9TreLPrjLQNT+h-XzA@mail.gmail.com>
 <3e32fc4b-d28c-c003-d292-39cad5179839@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a48bc6b6-a9ea-6b00-cd9a-1201b2e9d3c7@kernel.org>
Date: Sat, 14 Jan 2017 14:06:28 +0000
MIME-Version: 1.0
In-Reply-To: <3e32fc4b-d28c-c003-d292-39cad5179839@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/01/17 13:57, Jonathan Cameron wrote:
> On 13/01/17 23:48, Martin Blumenstingl wrote:
>> Hi Heiner,
>>
>> On Fri, Jan 13, 2017 at 9:26 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> [snip]
>>>>>> +static int meson_saradc_read_raw_sample(struct iio_dev *indio_dev,
>>>>>> +                                     const struct iio_chan_spec *chan,
>>>>>> +                                     int *val)
>>>>>> +{
>>>>>> +     struct meson_saradc_priv *priv = iio_priv(indio_dev);
>>>>>> +     int ret, regval, fifo_chan, fifo_val, sum = 0, count = 0;
>>>>>> +
>>>>>> +     ret = meson_saradc_wait_busy_clear(indio_dev);
>>>>>> +     if (ret)
>>>>>> +             return ret;
>>>>>> +
>>>>>> +     regmap_read(priv->regmap, SAR_ADC_REG0, &regval);
>>>>> The resulting regval value isn't used, therefore this statement doesn't seem
>>>>> to be needed.
>>>> I can probably replace this with "0", good catch!
>>>>
>>>>> In the vendor driver there is such a dummy statement before reading the busy
>>>>> flags in REG0 after starting sampling. Reason seems to be a potential race
>>>>> when we try to read the busy flags before the sampling engine has set them.
>>>>> This isn't needed in meson_saradc_wait_busy_clear here as an udelay(1) is
>>>>> done first always.
>>>> do you think it's worth adding a comment here that a do ... while loop
>>>> is there on purpose?
>>>>
>>> Yes, a hint would be good that there's a potential race.
>>> Else there's a good chance that a future refactoring introduces a regression.
>> indeed, a comment will be part of v2
>>
>>>>>> +
>>>>>> +     while (meson_saradc_get_fifo_count(indio_dev) > 0 &&
>>>>> IMHO this loop isn't needed. When we come here the FIFO contains exactly
>>>>> one element. This is true also in averaging mode as the averaging engine
>>>>> writes only the resulting mean value to the FIFO.
>>>>>
>>>>> And we can't have multiple samples active in parallel due to the locking
>>>>> done in meson_saradc_get_sample.
>>>>>
>>>>> By the way: I use an IRQ here to wake up when the FIFO contains one
>>>>> element. But as you wrote: It's not clear whether this works on all
>>>>> Meson systems.
>>>> maybe I should switch to IRQ mode as even the old Meson6 vendor kernel
>>>> sources indicate that the SAR ADC has IRQ support?
>>>>
>>> As you like. We can also add interrupt mode later (but leave polling intact)
>>> and activate it only if an interrupt is set in DT.
>>> This way we'd have a fallback in case there should be a problem with
>>> interrupt mode on some system.
>> I'm fine with either way, my idea was to keep it simple for the start.
>> as a side-note: even if we get rid of polling mode we still need
>> something like meson_saradc_wait_busy_clear(), because it's required
>> to stop sampling (at least in some cases) according to the datasheet:
>> "To stop sampling, simply set This bit and wait for all processing
>> modules to no longer indicate that they are busy."
>>
>>>>>> +            count < SAR_ADC_MAX_FIFO_SIZE) {
>>>>>> +             regmap_read(priv->regmap, SAR_ADC_FIFO_RD, &regval);
>>>>>> +
>>>>>> +             fifo_chan = FIELD_GET(SAR_ADC_FIFO_RD_CHAN_ID_MASK, regval);
>>>>>> +             if (fifo_chan == chan->channel) {
>>>>>> +                     fifo_val = FIELD_GET(SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK,
>>>>>> +                                          regval) & SAR_ADC_VALUE_MASK(priv);
>>>>>> +                     sum += fifo_val;
>>>>>> +                     count++;
>>>>>> +             }
>>>>>> +     }
>>>>>> +
>>>>>> +     if (!count)
>>>>>> +             return -ENOENT;
>>>>>> +
>>>>>> +     *val = sum / count;
>>>>>> +
>>>>>> +     return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static void meson_saradc_set_averaging(struct iio_dev *indio_dev,
>>>>>> +                                    const struct iio_chan_spec *chan,
>>>>>> +                                    enum meson_saradc_avg_mode mode,
>>>>>> +                                    enum meson_saradc_num_samples samples)
>>>>>> +{
>>>>>> +     struct meson_saradc_priv *priv = iio_priv(indio_dev);
>>>>>> +     u32 val;
>>>>>> +
>>>>>> +     val = samples << SAR_ADC_AVG_CNTL_NUM_SAMPLES_SHIFT(chan->channel);
>>>>>> +     regmap_update_bits(priv->regmap, SAR_ADC_AVG_CNTL,
>>>>>> +                        SAR_ADC_AVG_CNTL_NUM_SAMPLES_MASK(chan->channel),
>>>>>> +                        val);
>>>>>> +
>>>>>> +     val = mode << SAR_ADC_AVG_CNTL_AVG_MODE_SHIFT(chan->channel);
>>>>>> +     regmap_update_bits(priv->regmap, SAR_ADC_AVG_CNTL,
>>>>>> +                        SAR_ADC_AVG_CNTL_AVG_MODE_MASK(chan->channel), val);
>>>>>> +}
>>>>>> +
>>>>>> +static void meson_saradc_enable_channel(struct iio_dev *indio_dev,
>>>>>> +                                     const struct iio_chan_spec *chan)
>>>>>> +{
>>>>>> +     struct meson_saradc_priv *priv = iio_priv(indio_dev);
>>>>>> +     u32 regval;
>>>>>> +
>>>>>> +     /* the SAR ADC engine allows sampling multiple channels at the same
>>>>>> +      * time. to keep it simple we're only working with one *internal*
>>>>>> +      * channel, which starts counting at index 0 (which means: count = 1).
>>>>>> +      */
>>>>>> +     regval = FIELD_PREP(SAR_ADC_CHAN_LIST_MAX_INDEX_MASK, 0);
>>>>>> +     regmap_update_bits(priv->regmap, SAR_ADC_CHAN_LIST,
>>>>>> +                        SAR_ADC_CHAN_LIST_MAX_INDEX_MASK, regval);
>>>>>> +
>>>>>> +     /* map channel index 0 to the channel which we want to read */
>>>>>> +     regval = FIELD_PREP(SAR_ADC_CHAN_CHAN_ENTRY_MASK(0), chan->channel);
>>>>>> +     regmap_update_bits(priv->regmap, SAR_ADC_CHAN_LIST,
>>>>>> +                        SAR_ADC_CHAN_CHAN_ENTRY_MASK(0), regval);
>>>>>> +
>>>>>> +     regval = FIELD_PREP(SAR_ADC_DETECT_IDLE_SW_DETECT_MODE_MUX_MASK,
>>>>>> +                         chan->channel);
>>>>>> +     regmap_update_bits(priv->regmap, SAR_ADC_DETECT_IDLE_SW,
>>>>>> +                        SAR_ADC_DETECT_IDLE_SW_DETECT_MODE_MUX_MASK,
>>>>>> +                        regval);
>>>>>> +
>>>>>> +     regval = FIELD_PREP(SAR_ADC_DETECT_IDLE_SW_IDLE_MODE_MUX_SEL_MASK,
>>>>>> +                         chan->channel);
>>>>>> +     regmap_update_bits(priv->regmap, SAR_ADC_DETECT_IDLE_SW,
>>>>>> +                        SAR_ADC_DETECT_IDLE_SW_IDLE_MODE_MUX_SEL_MASK,
>>>>>> +                        regval);
>>>>>> +
>>>>>> +     if (chan->channel == 6)
>>>>>> +             regmap_update_bits(priv->regmap, SAR_ADC_DELTA_10,
>>>>>> +                                SAR_ADC_DELTA_10_TEMP_SEL, 0);
>>>>>> +}
>>>>>> +
>>>>>> +static void meson_saradc_set_channel7_mux(struct iio_dev *indio_dev,
>>>>>> +                                       enum meson_saradc_chan7_mux_sel sel)
>>>>>> +{
>>>>>> +     struct meson_saradc_priv *priv = iio_priv(indio_dev);
>>>>>> +     u32 regval;
>>>>>> +
>>>>>> +     regval = FIELD_PREP(SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, sel);
>>>>>> +     regmap_update_bits(priv->regmap, SAR_ADC_REG3,
>>>>>> +                        SAR_ADC_REG3_CTRL_CHAN7_MUX_SEL_MASK, regval);
>>>>>> +
>>>>>> +     usleep_range(10, 20);
>>>>>> +}
>>>>>> +
>>>>>> +static void meson_saradc_start_sample_engine(struct iio_dev *indio_dev)
>>>>>> +{
>>>>>> +     struct meson_saradc_priv *priv = iio_priv(indio_dev);
>>>>>> +
>>>>>> +     regmap_update_bits(priv->regmap, SAR_ADC_REG0,
>>>>>> +                        SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE,
>>>>>> +                        SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE);
>>>>>> +
>>>>>> +     regmap_update_bits(priv->regmap, SAR_ADC_REG0,
>>>>>> +                        SAR_ADC_REG0_SAMPLING_START,
>>>>>> +                        SAR_ADC_REG0_SAMPLING_START);
>>>>>> +}
>>>>>> +
>>>>>> +static void meson_saradc_stop_sample_engine(struct iio_dev *indio_dev)
>>>>>> +{
>>>>>> +     struct meson_saradc_priv *priv = iio_priv(indio_dev);
>>>>>> +
>>>>>> +     regmap_update_bits(priv->regmap, SAR_ADC_REG0,
>>>>>> +                        SAR_ADC_REG0_SAMPLING_STOP,
>>>>>> +                        SAR_ADC_REG0_SAMPLING_STOP);
>>>>>> +
>>>>>> +     /* wait until all modules are stopped */
>>>>>> +     meson_saradc_wait_busy_clear(indio_dev);
>>>>>> +
>>>>>> +     regmap_update_bits(priv->regmap, SAR_ADC_REG0,
>>>>>> +                        SAR_ADC_REG0_SAMPLE_ENGINE_ENABLE, 0);
>>>>>> +}
>>>>>> +
>>>>>> +static void meson_saradc_lock(struct iio_dev *indio_dev)
>>>>>> +{
>>>>>> +     struct meson_saradc_priv *priv = iio_priv(indio_dev);
>>>>>> +     int val;
>>>>>> +
>>>>>> +     mutex_lock(&indio_dev->mlock);
>>>>>> +
>>>>>> +     /* prevent BL30 from using the SAR ADC while we are using it */
>>>>>> +     regmap_update_bits(priv->regmap, SAR_ADC_DELAY,
>>>>>> +                        SAR_ADC_DELAY_KERNEL_BUSY,
>>>>>> +                        SAR_ADC_DELAY_KERNEL_BUSY);
>>>>>> +
>>>>>> +     /* wait until BL30 releases it's lock (so we can use the SAR ADC) */
>>>>>> +     do {
>>>>>> +             udelay(1);
>>>>>> +             regmap_read(priv->regmap, SAR_ADC_DELAY, &val);
>>>>>> +     } while (val & SAR_ADC_DELAY_BL30_BUSY);
>>>>>> +}
>>>>>> +
>>>>>> +static void meson_saradc_unlock(struct iio_dev *indio_dev)
>>>>>> +{
>>>>>> +     struct meson_saradc_priv *priv = iio_priv(indio_dev);
>>>>>> +
>>>>>> +     /* allow BL30 to use the SAR ADC again */
>>>>>> +     regmap_update_bits(priv->regmap, SAR_ADC_DELAY,
>>>>>> +                        SAR_ADC_DELAY_KERNEL_BUSY, 0);
>>>>>> +
>>>>>> +     mutex_unlock(&indio_dev->mlock);
>>>>>> +}
>>>>>> +
>>>>>> +static int meson_saradc_get_sample(struct iio_dev *indio_dev,
>>>>>> +                                const struct iio_chan_spec *chan,
>>>>>> +                                enum meson_saradc_avg_mode avg_mode,
>>>>>> +                                enum meson_saradc_num_samples avg_samples,
>>>>>> +                                int *val)
>>>>>> +{
>>>>>> +     int ret, tmp;
>>>>>> +
>>>>>> +     meson_saradc_lock(indio_dev);
>>>>>> +
>>>>>> +     /* clear old values from the FIFO buffer, ignoring errors */
>>>>>> +     meson_saradc_read_raw_sample(indio_dev, chan, &tmp);
>>>>>> +
>>>>>> +     meson_saradc_set_averaging(indio_dev, chan, avg_mode, avg_samples);
>>>>>> +
>>>>>> +     meson_saradc_enable_channel(indio_dev, chan);
>>>>>> +
>>>>>> +     meson_saradc_start_sample_engine(indio_dev);
>>>>>> +     ret = meson_saradc_read_raw_sample(indio_dev, chan, val);
>>>>>> +     meson_saradc_stop_sample_engine(indio_dev);
>>>>>> +
>>>>>> +     meson_saradc_unlock(indio_dev);
>>>>>> +
>>>>>> +     if (ret) {
>>>>>> +             dev_warn(&indio_dev->dev,
>>>>> Using the struct device in indio_dev results in IMHO ugly messages like
>>>>> iio iio:device0: already initialized by BL30
>>>>>
>>>>> We should use the parent instead, this is more readable:
>>>>> meson-saradc c1108680.adc: already initialized by BL30
>>>>>
>>>>> For this we need to move the assignment to indio_dev->dev.parent
>>>>> in probe, else messages may be written when parent isn't set yet.
>>>> indeed, I'll change this - thanks for the hint!
>> a little correction on this: I am all for setting the parent early.
>> However, I think that devm_iio_device_alloc() itself should take care
>> of building the device name correctly (to prevent code-duplication
>> across drivers in drivers/iio/*).
>> as an example: phy_create() does this (which includes the OF node
>> name): dev_set_name(&phy->dev, "phy-%s.%d", dev_name(dev), id);
>> iio_device_alloc does it like this (which is obviously missing the OF
>> node name): dev_set_name(&dev->dev, "iio:device%d", dev->id);
>>
> Propose a patch if you would like to.
> People 'shouldn't' be relying on this naming so hopefully we'll get
> away with such an user space interface change without anyone noticing!
> 
Err, hang on. I didn't think this through.  This same name is used
for the naming of the chardev.  Changing it is a nonstarter I'm
afraid unless there is some way of splitting the two uses.

Jonathan


> Jonathan
>>
>> Regards,
>> Martin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

