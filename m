Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751764AbdFKPBW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 11:01:22 -0400
Date: Sun, 11 Jun 2017 16:01:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, mwelling@ieee.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 2/2] iio: make stm32 trigger driver use
 INDIO_HARDWARE_TRIGGERED mode
Message-ID: <20170611160115.34e5c977@kernel.org>
In-Reply-To: <CA+M3ks44FV=ge=nhiArY_Kt3=WTFo47mLB1SE2DeJdBUsnEXag@mail.gmail.com>
References: <1493299756-18157-1-git-send-email-benjamin.gaignard@st.com>
        <1493299756-18157-3-git-send-email-benjamin.gaignard@st.com>
        <22f5c5c2-bab4-a583-108e-11fbaf233eed@kernel.org>
        <194c7da3-f674-e024-ba59-8b353c3f089b@kernel.org>
        <20170508151701.GA26979@sophia>
        <CA+M3ks6Ywvk+S8006ezz-+MNAXFbnsvFeczLp50fuA5NpUD8bA@mail.gmail.com>
        <274c53a7-4e05-4378-92a5-8c43b50fbe17@kernel.org>
        <CA+M3ks44FV=ge=nhiArY_Kt3=WTFo47mLB1SE2DeJdBUsnEXag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 6 Jun 2017 11:41:43 +0200
Benjamin Gaignard <benjamin.gaignard@linaro.org> wrote:

> 2017-05-14 18:02 GMT+02:00 Jonathan Cameron <jic23@kernel.org>:
> > On 09/05/17 08:46, Benjamin Gaignard wrote:  
> >>
> >> 2017-05-08 17:17 GMT+02:00 William Breathitt Gray
> >> <vilhelm.gray@gmail.com>:  
> >>>
> >>> On Sun, May 07, 2017 at 02:49:16PM +0100, Jonathan Cameron wrote:  
> >>>>
> >>>> On 01/05/17 01:50, Jonathan Cameron wrote:  
> >>>>>
> >>>>> On 27/04/17 14:29, Benjamin Gaignard wrote:  
> >>>>>>
> >>>>>> Add validate function to be use to use the correct trigger.
> >>>>>> Add an attribute to configure device mode like for quadrature and
> >>>>>> enable modes
> >>>>>>
> >>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>  
> >>>>>
> >>>>> Hmm.  I think I quite like this as an approach but have changed my
> >>>>> mind several times over the last few days :)
> >>>>>
> >>>>> Hence I'd ideally like some more opinions and will be leaving it
> >>>>> on the list for at least a short time longer.
> >>>>>
> >>>>> It's missed the current merge window anyway so plenty of time to
> >>>>> tick off this last element of your support.
> >>>>>
> >>>>> I also just checked and our docs for the existing modes is rubbish
> >>>>> (or I can't find it with a quick grep ;)
> >>>>> so we should tidy that up and add some description of this as well.  
> >>>>
> >>>> Still looking for more input on this!
> >>>>
> >>>> Lars - do you have time for a quick look?
> >>>>
> >>>> No real rush though as we are early in the cycle.
> >>>>
> >>>> Thanks,
> >>>>
> >>>> Jonathan  
> >>>
> >>>
> >>> I haven't used triggers before in my drivers so perhaps I can provide
> >>> the naive perspective of someone approaching the API for the first time.
> >>>
> >>>  From what I gather, the INDIO_BUFFERED_TRIGGERED option is used for
> >>> triggers associated with a buffer; for example, a device keeping track
> >>> of ambient temperature may periodically sample its sensors and store the
> >>> data in a buffer for later evaluation.
> >>>
> >>> The INDIO_EVENT_TRIGGERED option appears to be used for triggers
> >>> associated with some sort of event; for example, a threshold voltage is
> >>> reached on an ADC device.
> >>>
> >>> I'm having trouble groking how the INDIO_HARDWARE_TRIGGERED option
> >>> differs from the INDIO_EVENT_TRIGGERED option. It looks like the
> >>> INDIO_HARDWARE_TRIGGERED option is used in this case to associate a
> >>> trigger with a clock edge (first timer chained to second timer).
> >>> Wouldn't an INDIO_EVENT_TRIGGERED option be sufficient in this case
> >>> where the event is defined as the clock edge input to the second timer?  
> >>
> >>
> >> The main difference I have introduce between INDIO_EVENT_TRIGGERED and
> >> INDIO_HARDWARE_TRIGGERED is that this last one doesn't have poll function
> >> (i.e. userland can't wait on the event).  
> >
> > INDIO_EVENT_TRIGGERED has a different intent as well. It's about doing
> > synchronized acquisition of whether a threshold has been passed or not.
> > It's used for comparator chips that don't have anything else to them.
> > Right now the only user is the hi8435.  It took a lot of bouncing backwards
> > and forwards before we came up with this way of handling that chip.
> > So what you have is a comparator with lots of channels, but it will only
> > give you info on which are above threshold when you ask it (not interrupts
> > or internal clocking).  Odd beasts typically used in PLCs where you have
> > a scan function polling the lot in realtime very 5 msecs or so.
> >  
> >> For me userland doesn't need to be informed of each clock rising edge.
> >> More generally this new mode can be used when the event can't/doesn't need
> >> be
> >> notified to userland which is the case in my hardware where it is a
> >> signal on internal
> >> wire.  
> >
> > Absolutely.  The 'fun' corner case is triggers that 'can' be exposed to
> > userspace
> > (so there is an interrupt available) but don't have to be to run the
> > capture on a tightly coupled bit of hardware.  Conceptually there is a
> > hardware
> > implementation of the interrupt handler available.  
> 
> What can I do to progress in implementation of INDIO_HARDWARE_TRIGGERED ?
> Do it feel sensible for you to use it ?
I originally thought this was quite a nice solution and my thoughts haven't
changed.  Given no-one else has joined in the conversation - lets take the
view that it's the way to go (at least for now - it's mostly
internal to the kernel so we can always do something different in future).

Both patches applied to the togreg branch of iio.git.

Let's see if anyone screams ;)

Thanks and good thing you reminded me about these - they'd fallen
straight off the back of my queue (and out of my head - sorry about
that!),

Jonathan
> 
> 
> >  
> >>  
> >>>
> >>> William Breathitt Gray
> >>>  
> >>>>>
> >>>>> Jonathan  
> >>>>>>
> >>>>>> ---
> >>>>>>   .../ABI/testing/sysfs-bus-iio-timer-stm32          | 15 ++++++
> >>>>>>   drivers/iio/trigger/stm32-timer-trigger.c          | 61
> >>>>>> ++++++++++++++++++++++
> >>>>>>   2 files changed, 76 insertions(+)
> >>>>>>
> >>>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> >>>>>> b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> >>>>>> index 230020e..cccdf57 100644
> >>>>>> --- a/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> >>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-timer-stm32
> >>>>>> @@ -90,3 +90,18 @@ Description:
> >>>>>>                      Counting is enabled on rising edge of the
> >>>>>> connected
> >>>>>>                      trigger, and remains enabled for the duration of
> >>>>>> this
> >>>>>>                      selected mode.
> >>>>>> +
> >>>>>> +What:
> >>>>>> /sys/bus/iio/devices/iio:deviceX/in_count_trigger_mode_available
> >>>>>> +KernelVersion:     4.13
> >>>>>> +Contact:   benjamin.gaignard@st.com
> >>>>>> +Description:
> >>>>>> +           Reading returns the list possible trigger modes.
> >>>>>> +
> >>>>>> +What:
> >>>>>> /sys/bus/iio/devices/iio:deviceX/in_count0_trigger_mode
> >>>>>> +KernelVersion:     4.13
> >>>>>> +Contact:   benjamin.gaignard@st.com
> >>>>>> +Description:
> >>>>>> +           Configure the device counter trigger mode
> >>>>>> +           counting direction is set by in_count0_count_direction
> >>>>>> +           attribute and the counter is clocked by the connected
> >>>>>> trigger
> >>>>>> +           rising edges.
> >>>>>> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c
> >>>>>> b/drivers/iio/trigger/stm32-timer-trigger.c
> >>>>>> index 0f1a2cf..7c6e90e 100644
> >>>>>> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> >>>>>> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> >>>>>> @@ -347,12 +347,70 @@ static int stm32_counter_write_raw(struct
> >>>>>> iio_dev *indio_dev,
> >>>>>>      return -EINVAL;
> >>>>>>   }
> >>>>>>
> >>>>>> +static int stm32_counter_validate_trigger(struct iio_dev *indio_dev,
> >>>>>> +                                     struct iio_trigger *trig)
> >>>>>> +{
> >>>>>> +   struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> >>>>>> +   const char * const *cur = priv->valids;
> >>>>>> +   unsigned int i = 0;
> >>>>>> +
> >>>>>> +   if (!is_stm32_timer_trigger(trig))
> >>>>>> +           return -EINVAL;
> >>>>>> +
> >>>>>> +   while (cur && *cur) {
> >>>>>> +           if (!strncmp(trig->name, *cur, strlen(trig->name))) {
> >>>>>> +                   regmap_update_bits(priv->regmap,
> >>>>>> +                                      TIM_SMCR, TIM_SMCR_TS,
> >>>>>> +                                      i << TIM_SMCR_TS_SHIFT);
> >>>>>> +                   return 0;
> >>>>>> +           }
> >>>>>> +           cur++;
> >>>>>> +           i++;
> >>>>>> +   }
> >>>>>> +
> >>>>>> +   return -EINVAL;
> >>>>>> +}
> >>>>>> +
> >>>>>>   static const struct iio_info stm32_trigger_info = {
> >>>>>>      .driver_module = THIS_MODULE,
> >>>>>> +   .validate_trigger = stm32_counter_validate_trigger,
> >>>>>>      .read_raw = stm32_counter_read_raw,
> >>>>>>      .write_raw = stm32_counter_write_raw
> >>>>>>   };
> >>>>>>
> >>>>>> +static const char *const stm32_trigger_modes[] = {
> >>>>>> +   "trigger",
> >>>>>> +};
> >>>>>> +
> >>>>>> +static int stm32_set_trigger_mode(struct iio_dev *indio_dev,
> >>>>>> +                             const struct iio_chan_spec *chan,
> >>>>>> +                             unsigned int mode)
> >>>>>> +{
> >>>>>> +   struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> >>>>>> +
> >>>>>> +   regmap_update_bits(priv->regmap, TIM_SMCR, TIM_SMCR_SMS,
> >>>>>> TIM_SMCR_SMS);
> >>>>>> +
> >>>>>> +   return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int stm32_get_trigger_mode(struct iio_dev *indio_dev,
> >>>>>> +                             const struct iio_chan_spec *chan)
> >>>>>> +{
> >>>>>> +   struct stm32_timer_trigger *priv = iio_priv(indio_dev);
> >>>>>> +   u32 smcr;
> >>>>>> +
> >>>>>> +   regmap_read(priv->regmap, TIM_SMCR, &smcr);
> >>>>>> +
> >>>>>> +   return smcr == TIM_SMCR_SMS ? 0 : -EINVAL;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static const struct iio_enum stm32_trigger_mode_enum = {
> >>>>>> +   .items = stm32_trigger_modes,
> >>>>>> +   .num_items = ARRAY_SIZE(stm32_trigger_modes),
> >>>>>> +   .set = stm32_set_trigger_mode,
> >>>>>> +   .get = stm32_get_trigger_mode
> >>>>>> +};
> >>>>>> +
> >>>>>>   static const char *const stm32_enable_modes[] = {
> >>>>>>      "always",
> >>>>>>      "gated",
> >>>>>> @@ -536,6 +594,8 @@ static ssize_t stm32_count_set_preset(struct
> >>>>>> iio_dev *indio_dev,
> >>>>>>      IIO_ENUM_AVAILABLE("quadrature_mode",
> >>>>>> &stm32_quadrature_mode_enum),
> >>>>>>      IIO_ENUM("enable_mode", IIO_SEPARATE, &stm32_enable_mode_enum),
> >>>>>>      IIO_ENUM_AVAILABLE("enable_mode", &stm32_enable_mode_enum),
> >>>>>> +   IIO_ENUM("trigger_mode", IIO_SEPARATE, &stm32_trigger_mode_enum),
> >>>>>> +   IIO_ENUM_AVAILABLE("trigger_mode", &stm32_trigger_mode_enum),
> >>>>>>      {}
> >>>>>>   };
> >>>>>>
> >>>>>> @@ -560,6 +620,7 @@ static struct stm32_timer_trigger
> >>>>>> *stm32_setup_counter_device(struct device *dev
> >>>>>>      indio_dev->name = dev_name(dev);
> >>>>>>      indio_dev->dev.parent = dev;
> >>>>>>      indio_dev->info = &stm32_trigger_info;
> >>>>>> +   indio_dev->modes = INDIO_HARDWARE_TRIGGERED;
> >>>>>>      indio_dev->num_channels = 1;
> >>>>>>      indio_dev->channels = &stm32_trigger_channel;
> >>>>>>      indio_dev->dev.of_node = dev->of_node;
> >>>>>>  
> >>>>>
> >>>>> --
> >>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >>>>> the body of a message to majordomo@vger.kernel.org
> >>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>>>  
> >>>>  
> >>
> >>
> >>  
> >  
> 
> 
> 

