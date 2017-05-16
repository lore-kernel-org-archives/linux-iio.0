Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33288 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbdEPSDb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 May 2017 14:03:31 -0400
Subject: Re: [PATCH v2 2/3] iio: adc: at91-sama5d2_adc: add hw trigger and
 buffer support
To: Eugen Hristev <eugen.hristev@microchip.com>,
        nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com,
        linux-iio@vger.kernel.org, lars@metafoo.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
        Peter Rosin <peda@axentia.se>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
References: <1493900000-26220-1-git-send-email-eugen.hristev@microchip.com>
 <1493900000-26220-3-git-send-email-eugen.hristev@microchip.com>
 <aeaf25d7-5e05-d854-1ae9-06d224925cad@kernel.org>
 <7fb32b5f-4705-ab23-d9c8-020b03af9ac1@microchip.com>
 <20170511060937.pzam3drvyaci6rnv@rfolt0960.corp.atmel.com>
 <af420704-0df8-184a-4fa2-c7e509a9b15d@kernel.org>
 <b492b8d7-2f94-635e-518d-1e7563acb392@microchip.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ae4e7987-d34e-0e8b-a975-6506af49a807@kernel.org>
Date: Tue, 16 May 2017 19:03:23 +0100
MIME-Version: 1.0
In-Reply-To: <b492b8d7-2f94-635e-518d-1e7563acb392@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

<snip> As we are only left with one area of questions.
>>>>>>
>>>>>> +static const struct at91_adc_trigger at91_adc_trigger_list[] = {
>>>>>> +    {
>>>>>> +        .name = "external-rising",
>>>>>> +        .trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_RISE,
>>>>>> +    },
>>>>>> +    {
>>>>>> +        .name = "external-falling",
>>>>>> +        .trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_FALL,
>>>>>> +    },
>>>>>> +    {
>>>>>> +        .name = "external-any",
>>>>>> +        .trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_ANY,
>>>>>> +    },
>>>>> Hmm. Should this be a userspace configurable option?  Feels rather like
>>>>> it is an element of the hardware - reflecting the characteristics of
>>>>> some
>>>>> hardware device sat on the pin.
>>>> The user can choose from sysfs which trigger
>>>> is best suited for the use case, since all
>>>> three triggers are provided and can be connected to the buffer.
>>>> It reflects more the triggering capability of the ADC rather than
>>>> any different hardware device sitting on the pin
>>>
>>> I am also in favour of a userspace configurable option. For sure it's
>>> hardware related but on our board we only provide a trigger pin, we
>>> don't know which hardware the customer will put on this pin.
>> hmm. OK I'm persuaded I think.
>>
>> Could do this with devicetree overlays or similar.
>>
>> So follow up question is whether this is the right interface.
>> Can all 3 run at once sensibly?  If not are we not looking at a control
>> parameter for a single trigger?
> 
> There is a single trigger hardware pin, but can work in one of the three
> modes. Do you suggest I should change it to a single trigger, but then
> we need some kind of sysfs entry to control it ?
> 
> Or perhaps change the trigger to be exclusive to the device/buffer, in
> which case just one trigger can be used anyway with the current_trigger
> option in buffer.
> 
> If somehow more than one trigger would be enabled in the same time,
> only the last enabled one will work, since I write the corresponding
> trigger edge configuration value in the ADC register. So in fact these three triggers are mutually exclusive, as enabling one disables the
> other, however, it's not transparent to the user.
Ah that definitely suggests to me it should be a sysfs attribute associated
with the trigger rather than 3 separate triggers.  The interpretation
of those triggers would require userspace to have some knowledge of what
is going on, so I don't think we have any problems by requiring it instead
to know about a sysfs attribute.
> 
> These kind of different edge triggers used to be in device tree in
> older at91 driver.
> I have given it thought and decided to let just the driver know about
> them. Since they are bound to the ADC IP block and not related to any
> hardware description of the board or the special connectivity that
> the driver might be interested about. I mean the driver knows the
> trigger works this way because it's part of the block, and device tree
> cannot change this, so the portability of the driver is not affected
> and related to SoC design only.
Sort of (I think..)  As I understand it we are still talking about an
external pin?  A possible usecase for this sort of thing would be
combining with an external sequencer with an analog mux.  In that
case only one of the options will make any sense. (this is the
hardware equivalent of what Peter Rosin's mux subsystem puts
under software control)

We might be in one of those interesting cases where a devicetree
binding should exist for the fixed case, but with the flexibility
to allow userspace to specify it if and only if it is not specified
in the device tree.  So if the devicetree in some sense describes
downstream hardware it is fixed as appropriate.  If it doesn't and
we are looking at an 'edge of known world' situation then we let
userspace have control?  Does that make sense?

I don't suppose we have any idea what this is actually used for
on real world boards?

I've pulled in Peter, Mark and Rob as CCs to see if they want to
comment.
> 
> Thanks for the help and let me know if you consider something needs
> to be changed.
I'm definitely thinking single trigger.  Just need to pin down
how we control which type it is!

Jonathan
> 
> Eugen
> 
>>>
>>> Regards
>>>
>>> Ludovic
>>>
>>>>
>>>>>> +};
>>>>>> +
>>>>>>   static const struct iio_chan_spec at91_adc_channels[] = {
>>>>>>       AT91_SAMA5D2_CHAN_SINGLE(0, 0x50),
>>>>>>       AT91_SAMA5D2_CHAN_SINGLE(1, 0x54),
>>>>>> @@ -226,8 +274,168 @@ static const struct iio_chan_spec
>>>>>> at91_adc_channels[] = {
>>>>>>       AT91_SAMA5D2_CHAN_DIFF(6, 7, 0x68),
>>>>>>       AT91_SAMA5D2_CHAN_DIFF(8, 9, 0x70),
>>>>>>       AT91_SAMA5D2_CHAN_DIFF(10, 11, 0x78),
>>>>>> +    IIO_CHAN_SOFT_TIMESTAMP(AT91_SAMA5D2_SINGLE_CHAN_CNT
>>>>>> +                + AT91_SAMA5D2_DIFF_CHAN_CNT + 1),
>>>>>>   };
>>>>>>
>>>>>> +static int at91_adc_configure_trigger(struct iio_trigger *trig,
>>>>>> bool state)
>>>>>> +{
>>>>>> +    struct iio_dev *indio = iio_trigger_get_drvdata(trig);
>>>>>> +    struct at91_adc_state *st = iio_priv(indio);
>>>>>> +    u32 status = at91_adc_readl(st, AT91_SAMA5D2_TRGR);
>>>>>> +    u8 bit;
>>>>>> +    int i;
>>>>>> +
>>>>>> +    /* clear TRGMOD */
>>>>>> +    status &= ~AT91_SAMA5D2_TRGR_TRGMOD_MASK;
>>>>>> +
>>>>>> +    if (state)
>>>>>> +        for (i = 0; i < AT91_SAMA5D2_HW_TRIG_CNT; i++) {
>>>>>> +            if (!strstr(trig->name,
>>>>>> +                    at91_adc_trigger_list[i].name)) {
>>>>>> +                status |= at91_adc_trigger_list[i].trgmod_value;
>>>>>> +                break;
>>>>>> +            }
>>>>>> +        }
>>>>>> +
>>>>>> +    /* set/unset hw trigger */
>>>>>> +    at91_adc_writel(st, AT91_SAMA5D2_TRGR, status);
>>>>>> +
>>>>>> +    for_each_set_bit(bit, indio->active_scan_mask,
>>>>>> indio->num_channels) {
>>>>>> +        struct iio_chan_spec const *chan = indio->channels + bit;
>>>>>> +
>>>>>> +        if (state) {
>>>>>> +            at91_adc_writel(st, AT91_SAMA5D2_CHER,
>>>>>> +                    BIT(chan->channel));
>>>>>> +            at91_adc_writel(st, AT91_SAMA5D2_IER,
>>>>>> +                    BIT(chan->channel));
>>>>>> +        } else {
>>>>>> +            at91_adc_writel(st, AT91_SAMA5D2_IDR,
>>>>>> +                    BIT(chan->channel));
>>>>>> +            at91_adc_writel(st, AT91_SAMA5D2_CHDR,
>>>>>> +                    BIT(chan->channel));
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int at91_adc_reenable_trigger(struct iio_trigger *trig)
>>>>>> +{
>>>>>> +    struct iio_dev *indio = iio_trigger_get_drvdata(trig);
>>>>>> +    struct at91_adc_state *st = iio_priv(indio);
>>>>>> +
>>>>>> +    enable_irq(st->irq);
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static const struct iio_trigger_ops at91_adc_trigger_ops = {
>>>>>> +    .owner = THIS_MODULE,
>>>>>> +    .set_trigger_state = &at91_adc_configure_trigger,
>>>>>> +    .try_reenable = &at91_adc_reenable_trigger,
>>>>>> +};
>>>>>> +
>>>>>> +static int at91_adc_buffer_preenable(struct iio_dev *indio_dev)
>>>>>> +{
>>>>>> +    struct at91_adc_state *st = iio_priv(indio_dev);
>>>>>> +
>>>>>> +    st->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);Why
>>>>>> allocate it here?  Presumably the biggest it can get is fairly
>>>>> small?  Unless very large, just make sure you allocate enough
>>>>> directly in st in the first place.
>>>>
>>>> Yes , as discussed above will change to static allocation.
>>>>
>>>>>
>>>>>> +
>>>>>> +    if (!st->buffer)
>>>>>> +        return -ENOMEM;
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
>>>>>> +{
>>>>>> +    struct at91_adc_state *st = iio_priv(indio_dev);
>>>>>> +
>>>>>> +    kfree(st->buffer);
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static const struct iio_buffer_setup_ops at91_buffer_setup_ops = {
>>>>>> +    .preenable = &at91_adc_buffer_preenable,
>>>>>> +    .postenable = &iio_triggered_buffer_postenable,
>>>>>> +    .predisable = &iio_triggered_buffer_predisable,
>>>>>> +    .postdisable = &at91_adc_buffer_postdisable,
>>>>>> +};
>>>>>> +
>>>>>> +static struct iio_trigger *at91_adc_allocate_trigger(struct
>>>>>> iio_dev *indio,
>>>>>> +                             char *trigger_name)
>>>>>> +{
>>>>>> +    struct iio_trigger *trig;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    trig = devm_iio_trigger_alloc(&indio->dev, "%s-dev%d-%s",
>>>>>> indio->name,
>>>>>> +                      indio->id, trigger_name);
>>>>>> +    if (!trig)
>>>>>> +        return NULL;
>>>>>> +
>>>>>> +    trig->dev.parent = indio->dev.parent;
>>>>>> +    iio_trigger_set_drvdata(trig, indio);
>>>>>> +    trig->ops = &at91_adc_trigger_ops;
>>>>>> +
>>>>>> +    ret = devm_iio_trigger_register(&indio->dev, trig);
>>>>>> +
>>>>>> +    if (ret)
>>>>>> +        return NULL;
>>>>>> +
>>>>>> +    return trig;
>>>>>> +}
>>>>>> +
>>>>>> +static int at91_adc_trigger_init(struct iio_dev *indio)
>>>>>> +{
>>>>>> +    struct at91_adc_state *st = iio_priv(indio);
>>>>>> +    int i;
>>>>>> +
>>>>>> +    for (i = 0; i < AT91_SAMA5D2_HW_TRIG_CNT; i++) {
>>>>>> +        st->trig[i] = at91_adc_allocate_trigger(indio,
>>>>>> +                        at91_adc_trigger_list[i].name);
>>>>>> +        if (!st->trig[i]) {
>>>>>> +            dev_err(&indio->dev,
>>>>>> +                "could not allocate trigger %d\n", i);
>>>>>> +            return -ENOMEM;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>>>>>> +{
>>>>>> +    struct iio_poll_func *pf = p;
>>>>>> +    struct iio_dev *indio = pf->indio_dev;
>>>>>> +    struct at91_adc_state *st = iio_priv(indio);
>>>>>> +    int i = 0;
>>>>>> +    u8 bit;
>>>>>> +
>>>>>> +    for_each_set_bit(bit, indio->active_scan_mask,
>>>>>> indio->num_channels) {
>>>>>> +        struct iio_chan_spec const *chan = indio->channels + bit;
>>>>>> +
>>>>>> +        st->buffer[i] = at91_adc_readl(st, chan->address);
>>>>>> +        i++;
>>>>>> +    }
>>>>>> +
>>>>>> +    iio_push_to_buffers_with_timestamp(indio, st->buffer,
>>>>>> pf->timestamp);
>>>>>> +
>>>>>> +    iio_trigger_notify_done(indio->trig);
>>>>>> +
>>>>>> +    /* Needed to ACK the DRDY interruption */
>>>>>> +    at91_adc_readl(st, AT91_SAMA5D2_LCDR);
>>>>>> +
>>>>>> +    return IRQ_HANDLED;
>>>>>> +}
>>>>>> +
>>>>>> +static int at91_adc_buffer_init(struct iio_dev *indio)
>>>>>> +{
>>>>>> +    return devm_iio_triggered_buffer_setup(&indio->dev, indio,
>>>>>> +            &iio_pollfunc_store_time,
>>>>>> +            &at91_adc_trigger_handler, &at91_buffer_setup_ops);
>>>>>> +}
>>>>>> +
>>>>>>   static unsigned at91_adc_startup_time(unsigned startup_time_min,
>>>>>>                         unsigned adc_clk_khz)
>>>>>>   {
>>>>>> @@ -293,14 +501,19 @@ static irqreturn_t at91_adc_interrupt(int
>>>>>> irq, void *private)
>>>>>>       u32 status = at91_adc_readl(st, AT91_SAMA5D2_ISR);
>>>>>>       u32 imr = at91_adc_readl(st, AT91_SAMA5D2_IMR);
>>>>>>
>>>>>> -    if (status & imr) {
>>>>>> +    if (!(status & imr))
>>>>>> +        return IRQ_NONE;
>>>>>> +
>>>>>> +    if (iio_buffer_enabled(indio)) {
>>>>>> +        disable_irq_nosync(irq);
>>>>>> +        iio_trigger_poll(indio->trig);
>>>>>> +    } else {
>>>>>>           st->conversion_value = at91_adc_readl(st,
>>>>>> st->chan->address);
>>>>>>           st->conversion_done = true;
>>>>>>           wake_up_interruptible(&st->wq_data_available);
>>>>>> -        return IRQ_HANDLED;
>>>>>>       }
>>>>>>
>>>>>> -    return IRQ_NONE;
>>>>>> +    return IRQ_HANDLED;
>>>>>>   }
>>>>>>
>>>>>>   static int at91_adc_read_raw(struct iio_dev *indio_dev,
>>>>>> @@ -499,6 +712,18 @@ static int at91_adc_probe(struct
>>>>>> platform_device *pdev)
>>>>>>
>>>>>>       platform_set_drvdata(pdev, indio_dev);
>>>>>>
>>>>>> +    ret = at91_adc_buffer_init(indio_dev);
>>>>>> +    if (ret < 0) {
>>>>>> +        dev_err(&pdev->dev, "couldn't initialize the buffer.\n");
>>>>>> +        goto per_clk_disable_unprepare;
>>>>>> +    }
>>>>>> +
>>>>>> +    ret = at91_adc_trigger_init(indio_dev);
>>>>>> +    if (ret < 0) {
>>>>>> +        dev_err(&pdev->dev, "couldn't setup the triggers.\n");
>>>>>> +        goto per_clk_disable_unprepare;
>>>>>> +    }
>>>>>> +
>>>>>>       ret = iio_device_register(indio_dev);
>>>>>>       if (ret < 0)
>>>>>>           goto per_clk_disable_unprepare;
>>>>>>
>>>>>
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

