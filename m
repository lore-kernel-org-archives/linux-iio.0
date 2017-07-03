Return-Path: <SRS0=HPxE=6G=gmail.com=vilhelm.gray@kernel.org>
Date: Sun, 2 Jul 2017 21:02:53 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Lee Jones <lee.jones@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Benjamin GAIGNARD <benjamin.gaignard@st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PWM List <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] iio: counter: Add support for STM32 LPTimer
Message-ID: <20170703010253.GA6369@sophia>
References: <1498055415-31513-1-git-send-email-fabrice.gasnier@st.com>
 <1498055415-31513-9-git-send-email-fabrice.gasnier@st.com>
 <20170624213539.6c4337d1@kernel.org>
 <20170626202943.GA10994@sophia>
 <CA+M3ks73_-TRVRFYrGyWqB24aZCjdXv5ZwmnFQvvbOvKUVn-rw@mail.gmail.com>
 <20170630191959.096f4de7@kernel.org>
 <CA+M3ks5PXzUVrnoEEcmRObB-65_Er9CVQcN9c8wJyjgP3=0Oxg@mail.gmail.com>
 <20170701132518.4ce92c96@kernel.org>
 <20170701134035.GA25342@sophia>
 <20170701190917.62acff57@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170701190917.62acff57@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jul 01, 2017 at 07:09:17PM +0100, Jonathan Cameron wrote:
>On Sat, 1 Jul 2017 09:40:35 -0400
>William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>
>> On Sat, Jul 01, 2017 at 01:25:18PM +0100, Jonathan Cameron wrote:
>> >On Fri, 30 Jun 2017 22:36:48 +0200
>> >Benjamin Gaignard <benjamin.gaignard@linaro.org> wrote:
>> >  
>> >> 2017-06-30 20:19 GMT+02:00 Jonathan Cameron <jic23@kernel.org>:  
>> >> > On Tue, 27 Jun 2017 10:21:43 +0200
>> >> > Benjamin Gaignard <benjamin.gaignard@linaro.org> wrote:
>> >> >    
>> >> >> 2017-06-26 22:29 GMT+02:00 William Breathitt Gray <vilhelm.gray@gmail.com>:    
>> >> >> > On Sat, Jun 24, 2017 at 09:35:39PM +0100, Jonathan Cameron wrote:    
>> >> >> >>On Wed, 21 Jun 2017 16:30:15 +0200
>> >> >> >>Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>> >> >> >>    
>> >> >> >>> Add support for STM32 Low-Power Timer, that can be used as counter
>> >> >> >>> or quadrature encoder.
>> >> >> >>>
>> >> >> >>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>    
>> >> >> >>Hmm. Sometime I'm going to ask you guys to document how all these different
>> >> >> >>components fit together.  Far too many ways of cooking the same dish with
>> >> >> >>some of these ST parts ;)
>> >> >> >>
>> >> >> >>I've cc'd William.  You already have Benjamin.  Hopefully they also
>> >> >> >>have time to cast their eyes over this patch as it would be very helpful.
>> >> >> >>We are still defining new ABI for these devices so good to have more eyes
>> >> >> >>than for a normal patch.
>> >> >> >>Jonathan    
>> >> >> >>> ---
>> >> >> >>> Changes in v2:
>> >> >> >>> - s/Low Power/Low-Power
>> >> >> >>> - update few comments
>> >> >> >>> ---
>> >> >> >>>  .../ABI/testing/sysfs-bus-iio-lptimer-stm32        |  57 +++
>> >> >> >>>  drivers/iio/counter/Kconfig                        |   9 +
>> >> >> >>>  drivers/iio/counter/Makefile                       |   1 +
>> >> >> >>>  drivers/iio/counter/stm32-lptimer-cnt.c            | 383 +++++++++++++++++++++
>> >> >> >>>  4 files changed, 450 insertions(+)
>> >> >> >>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32
>> >> >> >>>  create mode 100644 drivers/iio/counter/stm32-lptimer-cnt.c
>> >> >> >>>
>> >> >> >>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32 b/Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32
>> >> >> >>> new file mode 100644
>> >> >> >>> index 0000000..ad2cc63
>> >> >> >>> --- /dev/null
>> >> >> >>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32
>> >> >> >>> @@ -0,0 +1,57 @@
>> >> >> >>> +What:               /sys/bus/iio/devices/iio:deviceX/in_count0_preset
>> >> >> >>> +KernelVersion:      4.13
>> >> >> >>> +Contact:    fabrice.gasnier@st.com
>> >> >> >>> +Description:
>> >> >> >>> +            Reading returns the current preset value. Writing sets the
>> >> >> >>> +            preset value. Encoder counts continuously from 0 to preset
>> >> >> >>> +            value, depending on direction (up/down).    
>> >> >> >>Some of these are generic now and used by several parts.  Time we started
>> >> >> >>thinking about a more generic file. sysfs-bus-iio-counter    
>> >> >> >>> +
>> >> >> >>> +What:               /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
>> >> >> >>> +KernelVersion:      4.13
>> >> >> >>> +Contact:    fabrice.gasnier@st.com
>> >> >> >>> +Description:
>> >> >> >>> +            Reading returns the list possible quadrature modes.
>> >> >> >>> +
>> >> >> >>> +What:               /sys/bus/iio/devices/iio:deviceX/in_count0_quadrature_mode
>> >> >> >>> +KernelVersion:      4.13
>> >> >> >>> +Contact:    fabrice.gasnier@st.com
>> >> >> >>> +Description:
>> >> >> >>> +            Configure the device counter quadrature modes:
>> >> >> >>> +            - non-quadrature:
>> >> >> >>> +                    Encoder IN1 input servers as the count input (up
>> >> >> >>> +                    direction).
>> >> >> >>> +            - quadrature:
>> >> >> >>> +                    Encoder IN1 and IN2 inputs are mixed to get direction
>> >> >> >>> +                    and count.    
>> >> >> >>Don't suppose we can call them A and B in common with labelling on many encoders?
>> >> >> >>Also makes this documentation same as for the 104 device.    
>> >> >> >>> +
>> >> >> >>> +What:               /sys/bus/iio/devices/iio:deviceX/in_count_polarity_available
>> >> >> >>> +KernelVersion:      4.13
>> >> >> >>> +Contact:    fabrice.gasnier@st.com
>> >> >> >>> +Description:
>> >> >> >>> +            Reading returns the list possible active edges.
>> >> >> >>> +
>> >> >> >>> +What:               /sys/bus/iio/devices/iio:deviceX/in_count0_polarity
>> >> >> >>> +KernelVersion:      4.13
>> >> >> >>> +Contact:    fabrice.gasnier@st.com
>> >> >> >>> +Description:
>> >> >> >>> +            Configure the device encoder/counter active edge:
>> >> >> >>> +            - rising-edge
>> >> >> >>> +            - falling-edge
>> >> >> >>> +            - both-edges    
>> >> >> >>For both edges, I believe we last supported this with scale.
>> >> >> >>So can we have both edges for the non quadrature?  If so your scale reported
>> >> >> >>is not taking this into account.    
>> >> >> >>> +
>> >> >> >>> +            In non-quadrature mode, device counts up on active edge.
>> >> >> >>> +            In quadrature mode, encoder counting scenarios are as follows:
>> >> >> >>> +            ----------------------------------------------------------------
>> >> >> >>> +            | Active  | Level on |      IN1 signal    |     IN2 signal     |
>> >> >> >>> +            | edge    | opposite |------------------------------------------
>> >> >> >>> +            |         | signal   |  Rising  | Falling |  Rising  | Falling |
>> >> >> >>> +            ----------------------------------------------------------------
>> >> >> >>> +            | Rising  | High ->  |   Down   |    -    |    Up    |    -    |
>> >> >> >>> +            | edge    | Low  ->  |    Up    |    -    |   Down   |    -    |
>> >> >> >>> +            ----------------------------------------------------------------
>> >> >> >>> +            | Falling | High ->  |    -     |    Up   |    -     |   Down  |
>> >> >> >>> +            | edge    | Low  ->  |    -     |   Down  |    -     |    Up   |
>> >> >> >>> +            ----------------------------------------------------------------
>> >> >> >>> +            | Both    | High ->  |   Down   |    Up   |    Up    |   Down  |
>> >> >> >>> +            | edges   | Low  ->  |    Up    |   Down  |   Down   |    Up   |
>> >> >> >>> +            ----------------------------------------------------------------    
>> >> >> >>Last case was definitely done with scale for the 104 counter - not that it
>> >> >> >>is detailed enough here to cover the other two cases.
>> >> >> >>It might make sense to add any new interface to that one as well to become
>> >> >> >>the favoured way of setting or reading this...
>> >> >> >>
>> >> >> >>Anyone else have a better idea?    
>> >> >> >
>> >> >> > When we introduced the first counter device driver to the iio subsystem
>> >> >> > we anticipated the arrival of subsequent counter device drivers to
>> >> >> > elucidate the common functionality of these kinds of devices; I believe
>> >> >> > the new counter device drivers added to the kernel in these past few
>> >> >> > releases have provided us with enough to see the trends in these
>> >> >> > devices. Congolmerating the attributes we see repeated among these
>> >> >> > drivers into a common sysfs-bus-iio-counter interface would be
>> >> >> > beneficial for future authors.
>> >> >> >
>> >> >> > Specific devices are bound to require specific attributes, but there are
>> >> >> > certain functionalities that all counters share -- determining the
>> >> >> > essence of a counter is key to defining a useful generic counter
>> >> >> > interface. For example, a good number of counter devices I've
>> >> >> > encountered have some sort of "preset" functionality; but whereas one
>> >> >> > device may treat the "preset" value as a count ceiling, another may
>> >> >> > treat it as a count floor. Knowing where to draw the line of defining
>> >> >> > what the "preset" attribute represents is the problem.    
>> >> >>
>> >> >> Maybe we should have min, max and reset values attribut instead of using
>> >> >> preset ?
>> >> >>    
>> >> >> >
>> >> >> > Allow me to propose the following generic definition of an idealized
>> >> >> > counter device: a counter is a device that accumulates the state changes
>> >> >> > of one or more signal lines to a defined value. This generic definition
>> >> >> > should guide us in defining a proper generic iio counter interface.
>> >> >> >
>> >> >> > Referring to the generic description, we know that every counter device
>> >> >> > will have a "value" attribute where the accumulation of the signal lines
>> >> >> > are held. Furthermore, the accumulation operation must be defined: some
>> >> >> > devices count up, some down, and some either; an attribute can be used
>> >> >> > to select the accumulation operation.
>> >> >> >
>> >> >> > The accumulation operation in these devices must have a trigger
>> >> >> > condition (i.e. state change). This is where we've had trouble in the
>> >> >> > past trying to deal with quadrature modes. I propose that we separate
>> >> >> > the idea of quadrature modes from the concept of state changes.
>> >> >> >
>> >> >> > Quadrature counters in my mind are simply regular counters that
>> >> >> > accumulate state changes on multiple wires at the same time to a single
>> >> >> > value; the fact that the signals are quadrature (90 degrees offset) is
>> >> >> > of no consequence: reversal of direction is simply a change of the
>> >> >> > accumulation operation in most devices to indicate the change to
>> >> >> > counting is the opposite direction.
>> >> >> >
>> >> >> > I don't particularly like how the "scale" attribute is used to hide the
>> >> >> > quadrature modes (x1, x2, and x4) of the 104-QUAD-8 device: the various
>> >> >> > quadrature modes indicate how state changes are interpreted by the
>> >> >> > device, but "scale" loses such information by representing it as simply
>> >> >> > a scaled accumulated value which could overlap with another counting
>> >> >> > mode.
>> >> >> >
>> >> >> > For example, traditionally quadrature modes are defined as such: x1
>> >> >> > counts the rising edges of channel A in the forward direction and the
>> >> >> > falling edges of channel A in the backward direction, x2 counts both
>> >> >> > rising and falling edges of channel A, and x4 counts both rising and
>> >> >> > falling edges of both channel A and channel B. Now suppose a device
>> >> >> > allows another possible mode where just the rising edges of both channel
>> >> >> > A and channel B are, or a mode where just the falling edges of both
>> >> >> > channel A and channel B, or a mode where only channle B is counted
>> >> >> > instead of channel A, etc.? In these modes, the accumulated value may
>> >> >> > match closely to one of the traditional quadrature modes, but the
>> >> >> > "scale" attribute does not display this information.
>> >> >> >
>> >> >> > The reason I point out these hypothetical modes is because I don't
>> >> >> > think the iio counter interface should be so tied to quadrature encoder
>> >> >> > functionality: although, position tracking is a useful functionality of
>> >> >> > a counter, a counter should be able to count arbitrary signals based on
>> >> >> > well defined state changes. This will allow counter drivers to be
>> >> >> > written to serve a diverse variety of devices. That is why the focus
>> >> >> > should be on what constitutes a "state change."
>> >> >> >
>> >> >> > So let us separate what we have been calling "quadrature mode" into a
>> >> >> > more generic interface of "signal lines" and "state changes." A "signal
>> >> >> > line" would be the channels associated with a single accumulation
>> >> >> > "value," such as channel A and channel B. Each signal line can then have
>> >> >> > an associated "state change" mode (i.e. the trigger for the accumulation
>> >> >> > operation) which can be set to the desired mode such as "None," "Rising
>> >> >> > Edge," "Falling Edge," "Both," etc. In this way, multiple signal lines
>> >> >> > (even more than 2) can be associated to an accumulation value, and
>> >> >> > configured to the desired mode (e.g. quadrature mode) to handle whatever
>> >> >> > kind of data is represented by those incoming signal lines.    
>> >> >>
>> >> >>
>> >> >> Name it  "Signal lines" sound good for me, I would prefer "active state" rather
>> >> >> than "state changes" but it just wording so with a good documentation
>> >> >> it could works.
>> >> >> If you propose patch (and documentation) for that I could convert my
>> >> >> stm32 timers
>> >> >> driver to this interface.
>> >> >>    
>> >> >> >
>> >> >> > To summarize: the generic iio counter interface should feature
>> >> >> > accumulation value attributes, which shall each have an associated
>> >> >> > accumulation operation attribute and respective number of signal line
>> >> >> > attributes associated with the accumulation value, where each signal
>> >> >> > line has an associated state change mode which defines the condition
>> >> >> > on the respective signal line that triggers the accumulation operation.    
>> >> > As I read this, the complexities of quadrature counting aren't covered...
>> >> > The reason it works and can tell direction is down to order of state
>> >> > transitions across the two channels.  So how do we describe that?  It's not
>> >> > even the case that a particular existing state is relevant, there is
>> >> > a temporal element (basically the state machine).
>> >> > http://www.edn.com/design/integrated-circuit-design/4363949/Decode-a-quadrature-encoder-in-software
>> >> > is a good description of the algorithm...    
>> >> 
>> >> We don't need to describe the state machine because is done inside
>> >> the hardware block. We need to tell to the hardware on which edge(s)
>> >> it had to count and the number of lines, with that it will give you the
>> >> counter value and the direction.  
>> >Agreed, we don't need the state machine, but...
>> >
>> >We need it to be apparent to userspace that this is a quadrature
>> >channel.  We don't need to control that, but we need userspace to be aware
>> >in some fashion.  Only then does the question of counting up and down on
>> >particular edges make sense - because on a quadrature channel it will only
>> >do this under some circumstance.  Every rising A edge does not result in
>> >a count up for example - if we are going the other way, it would be a count
>> >down only on the falling edge.  
>> >>   
>> >> >
>> >> > Now if we had some concept of composite signal lines, so a quadrature
>> >> > pair was treated as one entity then that might work - but we still aren't
>> >> > dealing with edges as such, but rather the state machine change
>> >> > they represent.
>> >> >
>> >> > Agreed the counter interface shouldn't be particularly tied to
>> >> > quadrature type signals, but those are one of the most common
>> >> > types so we do need to make sure we handle them cleanly.
>> >> >    
>> >> 
>> >> I do believe that describe active edges per lines is a good and generic
>> >> way to configure counters and quadrature encoders  
>> >Configure perhaps but I'm not following how userspace or a user is supposed
>> >to know whether a channel is part of a quadrature pair rather than a
>> >single line where say a rising edge always means count up.
>> >
>> >Counting on particular edges of particular lines can't give this information
>> >(as far as can see anyway - feel free to prove me wrong with examples!)
>> >
>> >Jonathan  
>> 
>> You're right: if a single quadrature channel signal flatlines, the count
>> ceases to increase/decrease, regardless of whether the other channels
>> keep pulsing; that's a very important quality of quadrature signals.
>> 
>> However, I believe the interface I described can communicate the
>> quadrature nature of the signal lines via the accumulation operation
>> attribute.
>> 
>> For example, if the edges of the signal lines should be independently
>> evaluated (i.e. non-quadrature mode), then the accumulation operation
>> attribute may be set to simply "increase count." The signal lines
>> themselves can then be configured to the desired line state trigger
>> (rising edge, falling edge, etc.), and each signal line triggers the
>> "increase count" accumulation operation independently given their
>> respective trigger condition.
>> 
>> Now, your concern was the case of quadrature signals: i.e. how do we
>> communicate the dependence of signal line state as it relates to the
>> count operation. In this scenario, I would imagine the accumulation
>> operation attribute to allow a respective "quadrature" mode value. So
>> then, if quadrature x1 is desired, then the accumulation operation
>> attribute is set to "quadrature x1" or such.
>> 
>> The desired edge trigger configuration can then be set on the desired
>> signal line. Note that in this case the driver would have to perform
>> sanity checks to ensure a valid configuration is selected for the
>> desired accumulation operation; e.g. "quadrature x1" should only have a
>> single signal line triggering the accumulation operation -- attempts to
>> configure multiple signal lines for edge triggering should yield back a
>> respective "invalid operation" error code to userspace, until either the
>> accumulation operation is changed or a different valid configuration is
>> set.
>Hmm. That might work reasonably well, but seems it might have some
>redundancy in configuration. Can handle that by having one attribute
>change effect multiple options.
>
>For example, 'quadrature x4' would set both A and B lines to be on
>both edges.
>
>Do we need to make quadrature pairs explicit in some way?
>
>I hope there are no devices out there where multiple quadrature pairs
>can effect a single counter.  Can't immediately think of what you
>could use such a beast for, but that doesn't mean hardware doesn't
>implement it!
>
>Jonathan

Yes, this interface is effectively the generic counter template --
essentially any device that qualifies as a counter should be capable of
exposure via this generic counter interface. However, as you noted there
are subtypes of counter devices ubiquitous enough to warrant further
standardization, such as quadrature encoder counters.

I'm not certain yet what the best way to expose common quadrature
configurations would be, but for now I can see some sort of
"quadrature_mode" attribute being useful (it seems this configuration
option reoccurs often among the quadrature devices). Then, as you
described, we can have common presets available (x1, x2, x4, etc.) that
would automatically set the correlating configuration on the respective
signal line and accumulation operation attributes. This way, both user
and driver author only need to setup and interact via a common
quadrature counter interface rather than the more tedious generic
counter interface (while still providing a compliant and working generic
counter interface as a baseline of functionality).

Specifying quadrature pairs explicitly may not be necessary if the
respective signal line attributes are automatically configured; but on
the other hand I can see some benefit to simplifying the communication
of such information if we already know we are dealing with a quadrature
device. I'm unfortunately undecided as of right now, but perhaps another
person may have some ideas of what such an interface would look like.
It's very likely that the majority of counter drivers will be for
quadrature devices, so it makes sense that this area of the interface
will grow to accomondate the redundancy of code we see, and we should
embrace that if it makes interaction with these devices simplier in the
end.

Your description of a theoretical device where multiple quadrature pairs
effect a single counter is interesting. This is where the utility of the
generic counter interface as a fallback for unique devices may be
exemplified: such an effect of configured signal lines can be
communicated via a custom accumulation operation mode, perhaps specified
as "dual quadrature x1" or such to indicate the additive combined nature
of the multiple quadrature pairs. Or perhaps, if we do add an explicit
quadrature pair attribute, we can have an association attribute to tie a
quadrature pair (or perhaps more) with an associated quadrature mode and
accumulation value.

While I'm not certain yet of what an explicit quadrature counter
interface would look like, I believe the generic counter interface is
robust enough to provide at least some utility as a baseline interface
for counter devices in general. I'll try to submit a patch adding such a
generic counter interface some time this week. From that point, we
should be capable of introducing a more specific quadrature counter
interface, which is in no doubt necessary to reduce the redundant code
that has been popping up among these drivers.

William Breathitt Gray

>> 
>> William Breathitt Gray
>> 
>> >>   
>> >> > All the other common counter types are more straight forward.    
>> >> >> >
>> >> >> > Let me know what you think. I'm worried if this interface would be too
>> >> >> > generic or cumbersome to use -- but I'm also worried about the counter
>> >> >> > interface becoming too specific to quadrature signals and getting tied
>> >> >> > down such a specialized use case.    
>> >> >>
>> >> >> Define on which edges counter is active seems generic and no specifically
>> >> >> link to quadrature devices so it is not a problem for me.
>> >> >>    
>> >> >> >
>> >> >> > William Breathitt Gray
>> >> >> >    
>> >> >> >>> diff --git a/drivers/iio/counter/Kconfig b/drivers/iio/counter/Kconfig
>> >> >> >>> index b37e5fc..474e1ac 100644
>> >> >> >>> --- a/drivers/iio/counter/Kconfig
>> >> >> >>> +++ b/drivers/iio/counter/Kconfig
>> >> >> >>> @@ -21,4 +21,13 @@ config 104_QUAD_8
>> >> >> >>>        The base port addresses for the devices may be configured via the base
>> >> >> >>>        array module parameter.
>> >> >> >>>
>> >> >> >>> +config STM32_LPTIMER_CNT
>> >> >> >>> +    tristate "STM32 LP Timer encoder counter driver"
>> >> >> >>> +    depends on MFD_STM32_LPTIMER || COMPILE_TEST
>> >> >> >>> +    help
>> >> >> >>> +      Select this option to enable STM32 Low-Power Timer quadrature encoder
>> >> >> >>> +      and counter driver.
>> >> >> >>> +
>> >> >> >>> +      To compile this driver as a module, choose M here: the
>> >> >> >>> +      module will be called stm32-lptimer-cnt.
>> >> >> >>>  endmenu
>> >> >> >>> diff --git a/drivers/iio/counter/Makefile b/drivers/iio/counter/Makefile
>> >> >> >>> index 007e884..1b9a896 100644
>> >> >> >>> --- a/drivers/iio/counter/Makefile
>> >> >> >>> +++ b/drivers/iio/counter/Makefile
>> >> >> >>> @@ -5,3 +5,4 @@
>> >> >> >>>  # When adding new entries keep the list in alphabetical order
>> >> >> >>>
>> >> >> >>>  obj-$(CONFIG_104_QUAD_8)    += 104-quad-8.o
>> >> >> >>> +obj-$(CONFIG_STM32_LPTIMER_CNT)     += stm32-lptimer-cnt.o
>> >> >> >>> diff --git a/drivers/iio/counter/stm32-lptimer-cnt.c b/drivers/iio/counter/stm32-lptimer-cnt.c
>> >> >> >>> new file mode 100644
>> >> >> >>> index 0000000..1c5909b
>> >> >> >>> --- /dev/null
>> >> >> >>> +++ b/drivers/iio/counter/stm32-lptimer-cnt.c
>> >> >> >>> @@ -0,0 +1,383 @@
>> >> >> >>> +/*
>> >> >> >>> + * STM32 Low-Power Timer Encoder and Counter driver
>> >> >> >>> + *
>> >> >> >>> + * Copyright (C) STMicroelectronics 2017
>> >> >> >>> + *
>> >> >> >>> + * Author: Fabrice Gasnier <fabrice.gasnier@st.com>
>> >> >> >>> + *
>> >> >> >>> + * Inspired by 104-quad-8 and stm32-timer-trigger drivers.
>> >> >> >>> + *
>> >> >> >>> + * License terms:  GNU General Public License (GPL), version 2
>> >> >> >>> + */
>> >> >> >>> +
>> >> >> >>> +#include <linux/bitfield.h>
>> >> >> >>> +#include <linux/iio/iio.h>
>> >> >> >>> +#include <linux/mfd/stm32-lptimer.h>
>> >> >> >>> +#include <linux/module.h>
>> >> >> >>> +#include <linux/platform_device.h>
>> >> >> >>> +
>> >> >> >>> +struct stm32_lptim_cnt {
>> >> >> >>> +    struct device *dev;
>> >> >> >>> +    struct regmap *regmap;
>> >> >> >>> +    struct clk *clk;
>> >> >> >>> +    u32 preset;
>> >> >> >>> +    u32 polarity;
>> >> >> >>> +    u32 quadrature_mode;
>> >> >> >>> +};
>> >> >> >>> +
>> >> >> >>> +static int stm32_lptim_is_enabled(struct stm32_lptim_cnt *priv)
>> >> >> >>> +{
>> >> >> >>> +    u32 val;
>> >> >> >>> +    int ret;
>> >> >> >>> +
>> >> >> >>> +    ret = regmap_read(priv->regmap, STM32_LPTIM_CR, &val);
>> >> >> >>> +    if (ret)
>> >> >> >>> +            return ret;
>> >> >> >>> +
>> >> >> >>> +    return FIELD_GET(STM32_LPTIM_ENABLE, val);
>> >> >> >>> +}
>> >> >> >>> +
>> >> >> >>> +static int stm32_lptim_set_enable_state(struct stm32_lptim_cnt *priv,
>> >> >> >>> +                                    int enable)
>> >> >> >>> +{
>> >> >> >>> +    int ret;
>> >> >> >>> +    u32 val;
>> >> >> >>> +
>> >> >> >>> +    val = FIELD_PREP(STM32_LPTIM_ENABLE, enable);
>> >> >> >>> +    ret = regmap_write(priv->regmap, STM32_LPTIM_CR, val);
>> >> >> >>> +    if (ret)
>> >> >> >>> +            return ret;
>> >> >> >>> +
>> >> >> >>> +    if (!enable) {
>> >> >> >>> +            clk_disable(priv->clk);
>> >> >> >>> +            return 0;
>> >> >> >>> +    }
>> >> >> >>> +
>> >> >> >>> +    /* LP timer must be enabled before writing CMP & ARR */
>> >> >> >>> +    ret = regmap_write(priv->regmap, STM32_LPTIM_ARR, priv->preset);
>> >> >> >>> +    if (ret)
>> >> >> >>> +            return ret;
>> >> >> >>> +
>> >> >> >>> +    ret = regmap_write(priv->regmap, STM32_LPTIM_CMP, 0);
>> >> >> >>> +    if (ret)
>> >> >> >>> +            return ret;
>> >> >> >>> +
>> >> >> >>> +    /* ensure CMP & ARR registers are properly written */
>> >> >> >>> +    ret = regmap_read_poll_timeout(priv->regmap, STM32_LPTIM_ISR, val,
>> >> >> >>> +                                   (val & STM32_LPTIM_CMPOK_ARROK),
>> >> >> >>> +                                   100, 1000);
>> >> >> >>> +    if (ret)
>> >> >> >>> +            return ret;
>> >> >> >>> +
>> >> >> >>> +    ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
>> >> >> >>> +                       STM32_LPTIM_CMPOKCF_ARROKCF);
>> >> >> >>> +    if (ret)
>> >> >> >>> +            return ret;
>> >> >> >>> +
>> >> >> >>> +    ret = clk_enable(priv->clk);
>> >> >> >>> +    if (ret) {
>> >> >> >>> +            regmap_write(priv->regmap, STM32_LPTIM_CR, 0);
>> >> >> >>> +            return ret;
>> >> >> >>> +    }
>> >> >> >>> +
>> >> >> >>> +    /* Start LP timer in continuous mode */
>> >> >> >>> +    return regmap_update_bits(priv->regmap, STM32_LPTIM_CR,
>> >> >> >>> +                              STM32_LPTIM_CNTSTRT, STM32_LPTIM_CNTSTRT);
>> >> >> >>> +}
>> >> >> >>> +
>> >> >> >>> +static int stm32_lptim_setup(struct stm32_lptim_cnt *priv, int enable)
>> >> >> >>> +{
>> >> >> >>> +    u32 mask = STM32_LPTIM_ENC | STM32_LPTIM_COUNTMODE |
>> >> >> >>> +               STM32_LPTIM_CKPOL | STM32_LPTIM_PRESC;
>> >> >> >>> +    u32 val;
>> >> >> >>> +
>> >> >> >>> +    /* Setup LP timer encoder/counter and polarity, without prescaler */
>> >> >> >>> +    if (priv->quadrature_mode)
>> >> >> >>> +            val = enable ? STM32_LPTIM_ENC : 0;
>> >> >> >>> +    else
>> >> >> >>> +            val = enable ? STM32_LPTIM_COUNTMODE : 0;
>> >> >> >>> +    val |= FIELD_PREP(STM32_LPTIM_CKPOL, enable ? priv->polarity : 0);
>> >> >> >>> +
>> >> >> >>> +    return regmap_update_bits(priv->regmap, STM32_LPTIM_CFGR, mask, val);
>> >> >> >>> +}
>> >> >> >>> +
>> >> >> >>> +static int stm32_lptim_write_raw(struct iio_dev *indio_dev,
>> >> >> >>> +                             struct iio_chan_spec const *chan,
>> >> >> >>> +                             int val, int val2, long mask)
>> >> >> >>> +{
>> >> >> >>> +    struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
>> >> >> >>> +    int ret;
>> >> >> >>> +
>> >> >> >>> +    switch (mask) {
>> >> >> >>> +    case IIO_CHAN_INFO_ENABLE:
>> >> >> >>> +            if (val < 0 || val > 1)
>> >> >> >>> +                    return -EINVAL;
>> >> >> >>> +
>> >> >> >>> +            /* Check nobody uses the timer, or already disabled/enabled */
>> >> >> >>> +            ret = stm32_lptim_is_enabled(priv);
>> >> >> >>> +            if ((ret < 0) || (!ret && !val))
>> >> >> >>> +                    return ret;
>> >> >> >>> +            if (val && ret)
>> >> >> >>> +                    return -EBUSY;
>> >> >> >>> +
>> >> >> >>> +            ret = stm32_lptim_setup(priv, val);
>> >> >> >>> +            if (ret)
>> >> >> >>> +                    return ret;
>> >> >> >>> +            return stm32_lptim_set_enable_state(priv, val);
>> >> >> >>> +
>> >> >> >>> +    default:
>> >> >> >>> +            return -EINVAL;
>> >> >> >>> +    }
>> >> >> >>> +}
>> >> >> >>> +
>> >> >> >>> +static int stm32_lptim_read_raw(struct iio_dev *indio_dev,
>> >> >> >>> +                            struct iio_chan_spec const *chan,
>> >> >> >>> +                            int *val, int *val2, long mask)
>> >> >> >>> +{
>> >> >> >>> +    struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
>> >> >> >>> +    u32 dat;
>> >> >> >>> +    int ret;
>> >> >> >>> +
>> >> >> >>> +    switch (mask) {
>> >> >> >>> +    case IIO_CHAN_INFO_RAW:
>> >> >> >>> +            ret = regmap_read(priv->regmap, STM32_LPTIM_CNT, &dat);
>> >> >> >>> +            if (ret)
>> >> >> >>> +                    return ret;
>> >> >> >>> +            *val = dat;
>> >> >> >>> +            return IIO_VAL_INT;
>> >> >> >>> +
>> >> >> >>> +    case IIO_CHAN_INFO_ENABLE:
>> >> >> >>> +            ret = stm32_lptim_is_enabled(priv);
>> >> >> >>> +            if (ret < 0)
>> >> >> >>> +                    return ret;
>> >> >> >>> +            *val = ret;
>> >> >> >>> +            return IIO_VAL_INT;
>> >> >> >>> +
>> >> >> >>> +    case IIO_CHAN_INFO_SCALE:
>> >> >> >>> +            /* Non-quadrature mode: scale = 1 */    
>> >> >> >>Both edges case?    
>> >> >> >>> +            *val = 1;
>> >> >> >>> +            *val2 = 0;
>> >> >> >>> +            if (priv->quadrature_mode) {
>> >> >> >>> +                    /*
>> >> >> >>> +                     * Quadrature encoder mode:
>> >> >> >>> +                     * - both edges, quarter cycle, scale is 0.25
>> >> >> >>> +                     * - either rising/falling edge scale is 0.5
>> >> >> >>> +                     */
>> >> >> >>> +                    if (priv->polarity > 1)
>> >> >> >>> +                            *val2 = 2;
>> >> >> >>> +                    else
>> >> >> >>> +                            *val2 = 1;
>> >> >> >>> +            }
>> >> >> >>> +            return IIO_VAL_FRACTIONAL_LOG2;
>> >> >> >>> +
>> >> >> >>> +    default:
>> >> >> >>> +            return -EINVAL;
>> >> >> >>> +    }
>> >> >> >>> +}
>> >> >> >>> +
>> >> >> >>> +static const struct iio_info stm32_lptim_cnt_iio_info = {
>> >> >> >>> +    .read_raw = stm32_lptim_read_raw,
>> >> >> >>> +    .write_raw = stm32_lptim_write_raw,
>> >> >> >>> +    .driver_module = THIS_MODULE,
>> >> >> >>> +};
>> >> >> >>> +
>> >> >> >>> +static const char *const stm32_lptim_quadrature_modes[] = {
>> >> >> >>> +    "non-quadrature",
>> >> >> >>> +    "quadrature",
>> >> >> >>> +};
>> >> >> >>> +
>> >> >> >>> +static int stm32_lptim_get_quadrature_mode(struct iio_dev *indio_dev,
>> >> >> >>> +                                       const struct iio_chan_spec *chan)
>> >> >> >>> +{
>> >> >> >>> +    struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
>> >> >> >>> +
>> >> >> >>> +    return priv->quadrature_mode;
>> >> >> >>> +}
>> >> >> >>> +
>> >> >> >>> +static int stm32_lptim_set_quadrature_mode(struct iio_dev *indio_dev,
>> >> >> >>> +                                       const struct iio_chan_spec *chan,
>> >> >> >>> +                                       unsigned int type)
>> >> >> >>> +{
>> >> >> >>> +    struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
>> >> >> >>> +
>> >> >> >>> +    if (stm32_lptim_is_enabled(priv))
>> >> >> >>> +            return -EBUSY;
>> >> >> >>> +
>> >> >> >>> +    priv->quadrature_mode = type;
>> >> >> >>> +
>> >> >> >>> +    return 0;
>> >> >> >>> +}
>> >> >> >>> +
>> >> >> >>> +static const struct iio_enum stm32_lptim_quadrature_mode_en = {
>> >> >> >>> +    .items = stm32_lptim_quadrature_modes,
>> >> >> >>> +    .num_items = ARRAY_SIZE(stm32_lptim_quadrature_modes),
>> >> >> >>> +    .get = stm32_lptim_get_quadrature_mode,
>> >> >> >>> +    .set = stm32_lptim_set_quadrature_mode,
>> >> >> >>> +};
>> >> >> >>> +
>> >> >> >>> +static const char * const stm32_lptim_cnt_polarity[] = {
>> >> >> >>> +    "rising-edge", "falling-edge", "both-edges",
>> >> >> >>> +};
>> >> >> >>> +
>> >> >> >>> +static int stm32_lptim_cnt_get_polarity(struct iio_dev *indio_dev,
>> >> >> >>> +                                    const struct iio_chan_spec *chan)
>> >> >> >>> +{
>> >> >> >>> +    struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
>> >> >> >>> +
>> >> >> >>> +    return priv->polarity;
>> >> >> >>> +}
>> >> >> >>> +
>> >> >> >>> +static int stm32_lptim_cnt_set_polarity(struct iio_dev *indio_dev,
>> >> >> >>> +                                    const struct iio_chan_spec *chan,
>> >> >> >>> +                                    unsigned int type)
>> >> >> >>> +{
>> >> >> >>> +    struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
>> >> >> >>> +
>> >> >> >>> +    if (stm32_lptim_is_enabled(priv))
>> >> >> >>> +            return -EBUSY;
>> >> >> >>> +
>> >> >> >>> +    priv->polarity = type;
>> >> >> >>> +
>> >> >> >>> +    return 0;
>> >> >> >>> +}
>> >> >> >>> +
>> >> >> >>> +static const struct iio_enum stm32_lptim_cnt_polarity_en = {
>> >> >> >>> +    .items = stm32_lptim_cnt_polarity,
>> >> >> >>> +    .num_items = ARRAY_SIZE(stm32_lptim_cnt_polarity),
>> >> >> >>> +    .get = stm32_lptim_cnt_get_polarity,
>> >> >> >>> +    .set = stm32_lptim_cnt_set_polarity,
>> >> >> >>> +};
>> >> >> >>> +
>> >> >> >>> +static ssize_t stm32_lptim_cnt_get_preset(struct iio_dev *indio_dev,
>> >> >> >>> +                                      uintptr_t private,
>> >> >> >>> +                                      const struct iio_chan_spec *chan,
>> >> >> >>> +                                      char *buf)
>> >> >> >>> +{
>> >> >> >>> +    struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
>> >> >> >>> +
>> >> >> >>> +    return snprintf(buf, PAGE_SIZE, "%u\n", priv->preset);
>> >> >> >>> +}
>> >> >> >>> +
>> >> >> >>> +static ssize_t stm32_lptim_cnt_set_preset(struct iio_dev *indio_dev,
>> >> >> >>> +                                      uintptr_t private,
>> >> >> >>> +                                      const struct iio_chan_spec *chan,
>> >> >> >>> +                                      const char *buf, size_t len)
>> >> >> >>> +{
>> >> >> >>> +    struct stm32_lptim_cnt *priv = iio_priv(indio_dev);
>> >> >> >>> +    int ret;
>> >> >> >>> +
>> >> >> >>> +    if (stm32_lptim_is_enabled(priv))
>> >> >> >>> +            return -EBUSY;
>> >> >> >>> +
>> >> >> >>> +    ret = kstrtouint(buf, 0, &priv->preset);
>> >> >> >>> +    if (ret)
>> >> >> >>> +            return ret;
>> >> >> >>> +
>> >> >> >>> +    if (priv->preset > STM32_LPTIM_MAX_ARR)
>> >> >> >>> +            return -EINVAL;
>> >> >> >>> +
>> >> >> >>> +    return len;
>> >> >> >>> +}
>> >> >> >>> +
>> >> >> >>> +/* LP timer with encoder */
>> >> >> >>> +static const struct iio_chan_spec_ext_info stm32_lptim_enc_ext_info[] = {
>> >> >> >>> +    {
>> >> >> >>> +            .name = "preset",
>> >> >> >>> +            .shared = IIO_SEPARATE,
>> >> >> >>> +            .read = stm32_lptim_cnt_get_preset,
>> >> >> >>> +            .write = stm32_lptim_cnt_set_preset,
>> >> >> >>> +    },
>> >> >> >>> +    IIO_ENUM("polarity", IIO_SEPARATE, &stm32_lptim_cnt_polarity_en),
>> >> >> >>> +    IIO_ENUM_AVAILABLE("polarity", &stm32_lptim_cnt_polarity_en),
>> >> >> >>> +    IIO_ENUM("quadrature_mode", IIO_SEPARATE,
>> >> >> >>> +             &stm32_lptim_quadrature_mode_en),
>> >> >> >>> +    IIO_ENUM_AVAILABLE("quadrature_mode", &stm32_lptim_quadrature_mode_en),
>> >> >> >>> +    {}
>> >> >> >>> +};
>> >> >> >>> +
>> >> >> >>> +static const struct iio_chan_spec stm32_lptim_enc_channels = {
>> >> >> >>> +    .type = IIO_COUNT,
>> >> >> >>> +    .channel = 0,
>> >> >> >>> +    .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> >> >> >>> +                          BIT(IIO_CHAN_INFO_ENABLE) |
>> >> >> >>> +                          BIT(IIO_CHAN_INFO_SCALE),
>> >> >> >>> +    .ext_info = stm32_lptim_enc_ext_info,
>> >> >> >>> +    .indexed = 1,
>> >> >> >>> +};
>> >> >> >>> +
>> >> >> >>> +/* LP timer without encoder (counter only) */
>> >> >> >>> +static const struct iio_chan_spec_ext_info stm32_lptim_cnt_ext_info[] = {
>> >> >> >>> +    {
>> >> >> >>> +            .name = "preset",
>> >> >> >>> +            .shared = IIO_SEPARATE,
>> >> >> >>> +            .read = stm32_lptim_cnt_get_preset,
>> >> >> >>> +            .write = stm32_lptim_cnt_set_preset,
>> >> >> >>> +    },
>> >> >> >>> +    IIO_ENUM("polarity", IIO_SEPARATE, &stm32_lptim_cnt_polarity_en),
>> >> >> >>> +    IIO_ENUM_AVAILABLE("polarity", &stm32_lptim_cnt_polarity_en),
>> >> >> >>> +    {}
>> >> >> >>> +};
>> >> >> >>> +
>> >> >> >>> +static const struct iio_chan_spec stm32_lptim_cnt_channels = {
>> >> >> >>> +    .type = IIO_COUNT,
>> >> >> >>> +    .channel = 0,
>> >> >> >>> +    .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>> >> >> >>> +                          BIT(IIO_CHAN_INFO_ENABLE) |
>> >> >> >>> +                          BIT(IIO_CHAN_INFO_SCALE),
>> >> >> >>> +    .ext_info = stm32_lptim_cnt_ext_info,
>> >> >> >>> +    .indexed = 1,
>> >> >> >>> +};
>> >> >> >>> +
>> >> >> >>> +static int stm32_lptim_cnt_probe(struct platform_device *pdev)
>> >> >> >>> +{
>> >> >> >>> +    struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
>> >> >> >>> +    struct stm32_lptim_cnt *priv;
>> >> >> >>> +    struct iio_dev *indio_dev;
>> >> >> >>> +
>> >> >> >>> +    if (IS_ERR_OR_NULL(ddata))
>> >> >> >>> +            return -EINVAL;
>> >> >> >>> +
>> >> >> >>> +    indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
>> >> >> >>> +    if (!indio_dev)
>> >> >> >>> +            return -ENOMEM;
>> >> >> >>> +
>> >> >> >>> +    priv = iio_priv(indio_dev);
>> >> >> >>> +    priv->dev = &pdev->dev;
>> >> >> >>> +    priv->regmap = ddata->regmap;
>> >> >> >>> +    priv->clk = ddata->clk;
>> >> >> >>> +    priv->preset = STM32_LPTIM_MAX_ARR;
>> >> >> >>> +
>> >> >> >>> +    indio_dev->name = dev_name(&pdev->dev);
>> >> >> >>> +    indio_dev->dev.parent = &pdev->dev;
>> >> >> >>> +    indio_dev->dev.of_node = pdev->dev.of_node;
>> >> >> >>> +    indio_dev->info = &stm32_lptim_cnt_iio_info;
>> >> >> >>> +    if (ddata->has_encoder)
>> >> >> >>> +            indio_dev->channels = &stm32_lptim_enc_channels;
>> >> >> >>> +    else
>> >> >> >>> +            indio_dev->channels = &stm32_lptim_cnt_channels;
>> >> >> >>> +    indio_dev->num_channels = 1;
>> >> >> >>> +
>> >> >> >>> +    platform_set_drvdata(pdev, priv);
>> >> >> >>> +
>> >> >> >>> +    return devm_iio_device_register(&pdev->dev, indio_dev);
>> >> >> >>> +}
>> >> >> >>> +
>> >> >> >>> +static const struct of_device_id stm32_lptim_cnt_of_match[] = {
>> >> >> >>> +    { .compatible = "st,stm32-lptimer-counter", },
>> >> >> >>> +    {},
>> >> >> >>> +};
>> >> >> >>> +MODULE_DEVICE_TABLE(of, stm32_lptim_cnt_of_match);
>> >> >> >>> +
>> >> >> >>> +static struct platform_driver stm32_lptim_cnt_driver = {
>> >> >> >>> +    .probe = stm32_lptim_cnt_probe,
>> >> >> >>> +    .driver = {
>> >> >> >>> +            .name = "stm32-lptimer-counter",
>> >> >> >>> +            .of_match_table = stm32_lptim_cnt_of_match,
>> >> >> >>> +    },
>> >> >> >>> +};
>> >> >> >>> +module_platform_driver(stm32_lptim_cnt_driver);
>> >> >> >>> +
>> >> >> >>> +MODULE_AUTHOR("Fabrice Gasnier <fabrice.gasnier@st.com>");
>> >> >> >>> +MODULE_ALIAS("platform:stm32-lptimer-counter");
>> >> >> >>> +MODULE_DESCRIPTION("STMicroelectronics STM32 LPTIM counter driver");
>> >> >> >>> +MODULE_LICENSE("GPL v2");    
>> >> >> >>    
>> >> >>
>> >> >>
>> >> >>    
>> >> >    
>> >> 
>> >> 
>> >>   
>> >  
>> 
>
