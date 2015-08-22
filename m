Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36830 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbbHVNsI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Aug 2015 09:48:08 -0400
Subject: Re: [PATCH v3 1/7] iio: adc: hi8435: Holt HI-8435 threshold detector
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
References: <1438174469-19054-1-git-send-email-vladimir.barinov@cogentembedded.com>
 <1438174617-19143-1-git-send-email-vladimir.barinov@cogentembedded.com>
 <55C642C1.4070105@kernel.org> <55CA08BC.4070202@cogentembedded.com>
 <55D05144.70509@kernel.org> <55D0DC7A.7090600@cogentembedded.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, cory.tusar@pid1solutions.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D87D91.1030300@kernel.org>
Date: Sat, 22 Aug 2015 14:48:01 +0100
MIME-Version: 1.0
In-Reply-To: <55D0DC7A.7090600@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/08/15 19:54, Vladimir Barinov wrote:
> Hi Jonathan,
> 
> On 16.08.2015 12:00, Jonathan Cameron wrote:
>> On 11/08/15 15:37, Vladimir Barinov wrote:
>>> Hi Jonathan,
>>>
>>> Thank you for the review.
>> Sorry I was being so indecisive.  Always take a while when something
>> 'new' turns up to gather opinions and select the best option.  You
>> are just the unlucky guy who happened to hit the question first!
>>
>> Anyhow, I'm basically happy (now) with the events approach though
>> I would suggest some modifications to how exactly it is done
>> (see inline).
> Nice to hear!
> I've got some light in the tunnel :)
Yeah, sorry it took so long to pin down the approach!
> 
> Thank you for dealing with this stuff.
> Please find one minor questions below.
> 
> Regards,
> Vladimir
> 
>>
>> Jonathan
>>> On 08.08.2015 20:56, Jonathan Cameron wrote:
>>>> On 29/07/15 13:56, Vladimir Barinov wrote:
>>>>> Add Holt threshold detector driver for HI-8435 chip
>>>>>
>>>>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>>> Because it usually reads better that way, I review from the bottom.
>>>> Might make more sense if you read the comments that way around ;)
>>> I did try to match this way.
>>> At some places the comments below the code, but in other places the comments are above the code :)
>> Yeah, I've never been consistent ;)
>>>> I'm going to guess that the typical usecase for this device is in realtime
>>>> systems where polling gives a nice predictable timing (hence the lack of any
>>>> interrupt support).  These typically operate as 'scanning' devices
>>>> (e.g. you update all state at approximately the same time, by reading
>>>> one input after another in some predefined order).
>>> Probably you are right about 8435 h/w design or there were other
>>> reason why this functionality was dropped in comparison to 8429
>>> chip. The Holt chip hi-8429 has both hardware interrupt and hardware
>>> debounce enable lines, but it has less amount of sensors (just 8
>>> outputs).
>>>> Does the use of events actually map well to this use case?  You are taking
>>>> something that (other than the results being a bit different) is basically
>>>> a digital I/O interface and mapping it (sort of) to an interrupt chip
>>>> when it isn't nothing of the sort.
>>> a) Using hardware point of view.
>>>
>>> I was thinking that it matches the events a little bit more then
>>> buffer, because the chip senses for threshold changes (passing
>>> threshold high or threshold low margins) and then notifies the upper
>>> layer. The bad point here is that the chip does not have interrupt
>>> line for sensor state change (i.e. threshold passing).
>>>
>>> If it would have the interrupt line for sensor state changes then the
>>> event interface map this case best way.
>> Agreed.  I'm coming round to the argument Lars made that we should end
>> up with the interface being the same whether or not there is an interrupt
>> there.  Actually I suspect in the long run we will end up with both
>> a buffered interface and an event interface as they simply have different
>> usecases for the same hardware (which is why we are having these lengthy
>> discussions in the first place!)
>>
>>> b) Using s/w point of view
>>>
>>> I answer relying on current iio stack implementation. I do understand
>>> that the 8435 chip is not the common/usual iio client like
>>> adc/dac/light/others, so I'm trying to match the existent iio stack.
>> Yes.  It's certainly throwing up lots of questions!
>>>  From s/w point of view it does not matter much difference between
>>> event or buffer interface for this chip because in provides 1-bit
>>> change and does not have it's own interrupt source line.
>> Yes, just requires the userspace side to track the state if it wants
>> to know.  Actually the one nasty is initialization. When the events
>> are first enabled I guess we fire them all once (if any limits are currently
>> breached).  That way the state can always be known.
>>> The event interface has generic interface to fill in falling/rising
>>> thresholds but buffer interface does not.
>> We can always add more ABI.
>>
>>> The buffer interface has already has the trigger poll func support
>>> but event interface does not. So I've tried to implement the
>>> triggered event in iio stack. BTW: Doesn't the triggered event
>>> support match the usecase with iio_interrupt_trigger? Or it does not
>>> make sense to have triggered events (even with irqtrig) at all?
>> Initially I was unsure about this, but Lars and you have convinced me.
>> I'm happy having that in the subsystem.  Can also be used for devices
>> which have an interrupt but which didn't get wired for some reason rather
>> than having them have some internal poll loop (as we have done up to now).
>>
>>  
>>>> I'd like more opinions on this, but my gut reaction is that we would
>>>> be better making the normal buffered infrastructure handle this data
>>>> properly rather than pushing it through the events intrastructure.
>>>>
>>>> Your solution is neat and tidy in someways but feels like it is mashing
>>>> data into a particular format.
>>> Probably that's all because the chip lacks smth from buffer interface
>>> approach (the data should diferent the 1-bit) and smth from event
>>> interface approach (lack of h/w interrupt line)
>> Agreed.
>>>> To add to the complexity we could have debounce logic.  If we mapped to a
>>>> fill the buffer with a scan mode, how would we handle this?
>>>> My guess is that it would simply delay transistions.  Perhaps we even
>>>> support reading both the value right now and the debounced value if that
>>>> is possible?
>>> I did handle it in the driver the same way in both cases (buffer and
>>> event interfaces): event/buffer trigger issues interrupt and then the
>>> driver checks value right now and after delay (debounce_interval).
>> I am yet to be convinced we want software debounce in the kernel.  This
>> is something that the input subsystem has always had.  Partly the aim of
>> IIO was to provide a slim system where all this stuff was moved to userspace.
> Ok, I will remove the s/w debounce in the driver for now.
> 
>>
>> Ultimately the ideal option to my mind is to finally write an inkernel
>> interface for the events data flow (as we have for buffered data) then
>> we can have a generic attachable debounce unit independent of any particular
>> driver.  Hohum.  Now all I need is someone to write it or a few weeks off
>> work ;)
> This is a nice design :)
> But much more hard then implement this in the driver.
> 
>>> If we do not plan to put debounced values to buffer then we may cache
>>> during debouncing procedure and then return via
>>> IIO_CHAN_INFO_DEBOUNCE_VALUE (or other info name). Probably even with
>>> timestamp.
>>>> However, here the debounce is all software.  To my mind, move this into
>>>> userspace entirely. We aren't dealing with big data here so it's hardly
>>>> going to be particularly challenging.
>>> I will drop it on your demand in favour to encourage chipmakers to provide h/w debounce,
>>> but this was much easy/efficient to have it in kernel space, since
>>> during run generic_buffer sample (or other) we got the new data and then we have to start timer, then timer expires
>>> and we read raw values from sysfs manually to compare the one that came from buffer and one after debounce
>>> delay.
>> If you are clocking evenly and we were using buffering you'd simply do it as readback in time
>> rather than the other way around - thus no timer at all.  Just each time check the last N
>> samples to see if they are all high or all low or similar.
> This is right for high frequency clocking.
> If we are clocking evently at low frequency (~1Hz) and the recommended debounce interval is 10-100ms then
> we should use timer for issuing extra clock inside 10-100ms for check/validate the event.
>>
>>>> So my gut feeling is definitely we need to make the buffer infrastructure
>>>> handle 1 bit values (in groups) then push this data out that way.
>>> I will wait for your final decision.
>> Lets proceed with the event version.  If someone has a strong usecase
>> for adding buffering as well, there is nothing stopping the driver doing both
>> that I can see (once we have the core infrastructure in place).
> Ok, thx.
> 
>>>> Still I would like other opinions on this!
>>>>
>>>> Jonathan
>>>>
>>>>> ---
>>>>> Changes in version 2:
>>>>> - Added file sysfs-bus-iio-adc-hi8435
>>>>> - Changed naming from "discrete ADC" to "threshold detector"
>>>>> - Replaced swab16p/swab32p with be16_to_cpup/be32_to_cpup
>>>>> - Made *_show and *_store functions static
>>>>> - moved out from iio buffers to iio events
>>>>> - removed hi8436/hi8437 chips from the driver
>>>>> - moved from debounce_soft_delay/enable to debounce_interval via
>>>>>     IIO_CHAN_INFO_DEBOUNCE_TIME
>>>>> - added name extention "comparator"
>>>>> - moved threshold/hysteresis setup via generic iio event sysfs
>>>>> - added software mask/unmask channel events
>>>>> - added programming sensor outputs while in test mode via
>>>>>     IIO_CHAN_INFO_RAW
>>>>> - added channels .ext_info for programming sensing mode
>>>>> Changes in version 3:
>>>>> - fixed typos
>>>>> - moved <linux/interrupt.h> to match alphabetic order
>>>>> - fixed missed */event/* prefix in the ABI description
>>>>> - added missed colon in sysfs-bus-iio-adc-hi8435 file after "What"
>>>>> - moved in_voltageY_comparator_thresh_either_en and debounce_time
>>>>>     to sysfs-bus-iio file
>>>>> - added error checking for hi8435_write[b|w]
>>>>>
>>>>>    Documentation/ABI/testing/sysfs-bus-iio            |   1 +
>>>>>    Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435 |  61 ++
>>>>>    drivers/iio/adc/Kconfig                            |  11 +
>>>>>    drivers/iio/adc/Makefile                           |   1 +
>>>>>    drivers/iio/adc/hi8435.c                           | 659 +++++++++++++++++++++
>>>>>    5 files changed, 742 insertions(+)
>>>>>    create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435
>>>>>    create mode 100644 drivers/iio/adc/hi8435.c
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>>>>> index 70c9b1a..09eac44 100644
>>>>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>>>>> @@ -572,6 +572,7 @@ What:        /sys/.../iio:deviceX/events/in_rot_from_north_magnetic_tilt_comp_thresh_r
>>>>>    What:        /sys/.../iio:deviceX/events/in_rot_from_north_magnetic_tilt_comp_thresh_falling_en
>>>>>    What:        /sys/.../iio:deviceX/events/in_rot_from_north_true_tilt_comp_thresh_rising_en
>>>>>    What:        /sys/.../iio:deviceX/events/in_rot_from_north_true_tilt_comp_thresh_falling_en
>>>>> +What:        /sys/.../iio:deviceX/events/in_voltageY_comparator_thresh_either_en
>>>>>    What:        /sys/.../iio:deviceX/events/in_voltageY_supply_thresh_rising_en
>>>>>    What:        /sys/.../iio:deviceX/events/in_voltageY_supply_thresh_falling_en
>>>>>    What:        /sys/.../iio:deviceX/events/in_voltageY_thresh_rising_en
>>>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435 b/Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435
>>>>> new file mode 100644
>>>>> index 0000000..c59d81d
>>>>> --- /dev/null
>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-hi8435
>>>>> @@ -0,0 +1,61 @@
>>>>> +What:        /sys/bus/iio/devices/iio:deviceX/in_voltageY_comparator_raw
>> We really try to use the extended names infrequently and normally only
>> for things like 'this voltage channel is internally connected to the power
>> supply rail'.  Don't think we need it here.   As suggested below, if we
>> are going events then we don't want to expose a _raw reading except via
>> in the 'events' directory where it would be a 'current event status'.
>> Anyhow, I talk about that futher down.
> I will remove *_raw.
> 
>>>>> +Date:        July 2015
>>>>> +KernelVersion:    4.2.0
>>>>> +Contact:    source@cogentembedded.com
>>>>> +Description:
>>>>> +        Read value is a voltage threshold measurement from channel Y.
>>>>> +        Could be either 0 if sensor voltage is lower then low voltage
>>>>> +        threshold or 1 if sensor voltage is higher then high voltage
>>>>> +        threshold.
>>>>> +        Write value is a programmed sensor output while in self test
>>>>> +        mode. Could be either 0 or 1. The programmed value will be read
>>>>> +        back if /sys/bus/iio/devices/iio:deviceX/test_enable is set to 1.
>>>>> +
>>>>> +What:        /sys/bus/iio/devices/iio:deviceX/test_enable
>>>>> +Date:        July 2015
>>>>> +KernelVersion:    4.2.0
>>>>> +Contact:    source@cogentembedded.com
>>>>> +Description:
>>>>> +        Enable/disable the HI-8435 self test mode.
>>>>> +        If enabled the in_voltageY_comparator_raw should be read back
>>>>> +        accordingly to written value to in_voltageY_comparator_raw.
>> Hmm. Normally we just do self tests at startup.  So set some patterns, read them
>> and then verify they are fine.  Drops the need for a userspace interface
>> that can get a little confusing (writing to what is normally a read
>> only attribute).  Would this work here?
>>
>> Alternatively, just add a debugfs interface to allow this to be set rather than
>> exposing it via sysfs all the time?
> I will add debugfs or drop it (since I did use write_raw() for setting sensor output in test mode)
> 
>>
>>>>> +
>>>>> +What:        /sys/bus/iio/devices/iio:deviceX/in_voltageY_comparator_sensing_mode
>>>>> +Date:        July 2015
>>>>> +KernelVersion:    4.2.0
>>>>> +Contact:    source@cogentembedded.com
>>>>> +Description:
>>>>> +        Program sensor type for threshold detector inputs.
>>>>> +        Could be either "GND-Open" or "Supply-Open" mode. Y is a
>>>>> +        threshold detector input channel. Channels 0..7, 8..15, 16..23
>>>>> +        and 24..31 has common sensor types.
>>>>> +
>>>>> +What:        /sys/bus/iio/devices/iio:deviceX/events/in_voltageY_comparator_thresh_falling_value
>> This is where the comparator extended name looks a bit silly as we are
>> clearly comparing it anyway due to the thresh_falling part ;)
> I will remove the extended name.
> 
>>>>> +Date:        July 2015
>>>>> +KernelVersion:    4.2.0
>>>>> +Contact:    source@cogentembedded.com
>>>>> +Description:
>>>>> +        Channel Y low voltage threshold. If sensor input voltage goes lower then
>>>>> +        this value then the threshold falling event is pushed.
>>>>> +        Depending on in_voltageY_comparator_sensing_mode the low voltage threshold
>>>>> +        is separately set for "GND-Open" and "Supply-Open" modes.
>>>>> +        Channels 0..31 have common low threshold values, but could have different
>>>>> +        sensing_modes.
>>>>> +        The low voltage threshold range is between 2..21V.
>>>>> +        Hysteresis between low and high thresholds can not be lower then 2 and
>>>>> +        can not be odd.
>>>>> +
>>>>> +What:        /sys/bus/iio/devices/iio:deviceX/events/in_voltageY_comparator_thresh_rising_value
>>>>> +Date:        July 2015
>>>>> +KernelVersion:    4.2.0
>>>>> +Contact:    source@cogentembedded.com
>>>>> +Description:
>>>>> +        Channel Y high voltage threshold. If sensor input voltage goes higher then
>>>>> +        this value then the threshold rising event is pushed.
>>>>> +        Depending on in_voltageY_comparator_sensing_mode the high voltage threshold
>>>>> +        is separately set for "GND-Open" and "Supply-Open" modes.
>>>>> +        Channels 0..31 have common high threshold values, but could have different
>>>>> +        sensing_modes.
>>>>> +        The high voltage threshold range is between 3..22V.
>>>>> +        Hysteresis between low and high thresholds can not be lower then 2 and
>>>>> +        can not be odd.
>>>>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>>>>> index eb0cd89..553c91e 100644
>>>>> --- a/drivers/iio/adc/Kconfig
>>>>> +++ b/drivers/iio/adc/Kconfig
>>>>> @@ -170,6 +170,17 @@ config EXYNOS_ADC
>>>>>          of SoCs for drivers such as the touchscreen and hwmon to use to share
>>>>>          this resource.
>>>>>    +config HI8435
>>>>> +    tristate "Holt Integrated Circuits HI-8435 threshold detector"
>>>>> +    select IIO_TRIGGERED_EVENT
>>>>> +    depends on SPI
>>>>> +    help
>>>>> +      If you say yes here you get support for Holt Integrated Circuits
>>>>> +      HI-8435 chip.
>>>>> +
>>>>> +      This driver can also be built as a module. If so, the module will be
>>>>> +      called hi8435.
>>>>> +
>>>>>    config LP8788_ADC
>>>>>        tristate "LP8788 ADC driver"
>>>>>        depends on MFD_LP8788
>>>>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>>>>> index a096210..00f367aa 100644
>>>>> --- a/drivers/iio/adc/Makefile
>>>>> +++ b/drivers/iio/adc/Makefile
>>>>> @@ -19,6 +19,7 @@ obj-$(CONFIG_BERLIN2_ADC) += berlin2-adc.o
>>>>>    obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
>>>>>    obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
>>>>>    obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
>>>>> +obj-$(CONFIG_HI8435) += hi8435.o
>>>>>    obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
>>>>>    obj-$(CONFIG_MAX1027) += max1027.o
>>>>>    obj-$(CONFIG_MAX1363) += max1363.o
>>>>> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
>>>>> new file mode 100644
>>>>> index 0000000..f3dab5a
>>>>> --- /dev/null
>>>>> +++ b/drivers/iio/adc/hi8435.c
>>>>> @@ -0,0 +1,659 @@
>>>>> +/*
>>>>> + * Holt Integrated Circuits HI-8435 threshold detector driver
>>>>> + *
>>>>> + * Copyright (C) 2015 Zodiac Inflight Innovations
>>>>> + * Copyright (C) 2015 Cogent Embedded, Inc.
>>>>> + *
>>>>> + * This program is free software; you can redistribute  it and/or modify it
>>>>> + * under  the terms of  the GNU General  Public License as published by the
>>>>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>>>>> + * option) any later version.
>>>>> + */
>>>>> +
>>>>> +#include <linux/delay.h>
>>>>> +#include <linux/iio/events.h>
>>>>> +#include <linux/iio/iio.h>
>>>>> +#include <linux/iio/sysfs.h>
>>>>> +#include <linux/iio/trigger.h>
>>>>> +#include <linux/iio/trigger_consumer.h>
>>>>> +#include <linux/iio/triggered_event.h>
>>>>> +#include <linux/interrupt.h>
>>>>> +#include <linux/module.h>
>>>>> +#include <linux/of.h>
>>>>> +#include <linux/of_device.h>
>>>>> +#include <linux/of_gpio.h>
>>>>> +#include <linux/spi/spi.h>
>>>>> +#include <linux/workqueue.h>
>>>>> +
>>>>> +#define DRV_NAME "hi8435"
>>>>> +
>>>>> +/* Register offsets for HI-8435 */
>>>>> +#define HI8435_CTRL_REG            0x02
>>>>> +#define HI8435_PSEN_REG            0x04
>>>>> +#define HI8435_TMDATA_REG        0x1E
>>>>> +#define HI8435_GOCENHYS_REG        0x3A
>>>>> +#define HI8435_SOCENHYS_REG        0x3C
>>>> Hmm. These aren't in the docs that I can immediately acquire...
>>>> Any chance of some more meaningful naming?
>>> I did follow the register naming in the chip datasheet:
>>> http://www.holtic.com/products/3081-hi-8435.aspx
>>>
>>> The SO7_0 means "Sensor status bank 0 register: SO<7:0>".
>>> Does HI8435_STATUS_BANK0_REG work?
>> Ah, I missed the meaning entirely by not noticing they were 8 bits
>> each ;)  This current naming is fine.
>>> Or should I just add comments instead of changing definition?
>>>>> +#define HI8435_SO7_0_REG        0x10
>>>>> +#define HI8435_SO15_8_REG        0x12
>>>>    +#define HI8435_SO23_16_REG        0x14
>>>>> +#define HI8435_SO31_24_REG        0x16
>>>>> +#define HI8435_SO31_0_REG        0x78
>>>>> +
>>>>> +#define HI8435_WRITE_OPCODE        0x00
>>>>> +#define HI8435_READ_OPCODE        0x80
>>>>> +
>>>>> +/* CTRL register bits */
>>>>> +#define HI8435_CTRL_TEST        0x01
>>>>> +#define HI8435_CTRL_SRST        0x02
>>>>> +
>>>>> +#define HI8435_DEBOUNCE_DELAY_MAX    1000    /* msec */
>>>>> +#define HI8435_DEBOUNCE_DELAY_DEF    100    /* msec */
>>>>> +
>>>>> +struct hi8435_priv {
>>>>> +    struct spi_device *spi;
>>>>> +    struct mutex lock;
>>>>> +    struct delayed_work work;
>>>>> +
>>>>> +    int reset_gpio;
>>>>> +    int debounce_interval; /* msec */
>>>>> +    u32 debounce_val; /* prev value to compare during software debounce */
>>>>> +
>>>>> +    unsigned long event_scan_mask; /* soft mask/unmask channels events */
>>>>> +    unsigned int event_prev_val;
>>>>> +
>>>>> +    unsigned threshold_lo[2]; /* GND-Open and Supply-Open thresholds */
>>>>> +    unsigned threshold_hi[2]; /* GND-Open and Supply-Open threshold */
>>>>> +    u8 reg_buffer[4] ____cacheline_aligned;
>>>>> +};
>>>>> +
>>>>> +static int hi8435_readb(struct hi8435_priv *priv, u8 reg, u8 *val)
>>>>> +{
>>>>> +    reg |= HI8435_READ_OPCODE;
>>>>> +    return spi_write_then_read(priv->spi, &reg, 1, val, 1);
>>>>> +}
>>>>> +
>>>>> +static int hi8435_readw(struct hi8435_priv *priv, u8 reg, u16 *val)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    reg |= HI8435_READ_OPCODE;
>>>>> +    ret = spi_write_then_read(priv->spi, &reg, 1, val, 2);
>>>>> +    *val = be16_to_cpup(val);
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +static int hi8435_readl(struct hi8435_priv *priv, u8 reg, u32 *val)
>>>>> +{
>>>>> +    int ret;
>>>>> +
>>>>> +    reg |= HI8435_READ_OPCODE;
>>>>> +    ret = spi_write_then_read(priv->spi, &reg, 1, val, 4);
>>>>> +    *val = be32_to_cpup(val);
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +static int hi8435_writeb(struct hi8435_priv *priv, u8 reg, u8 val)
>>>>> +{
>>>>> +    priv->reg_buffer[0] = reg | HI8435_WRITE_OPCODE;
>>>>> +    priv->reg_buffer[1] = val;
>>>>> +
>>>>> +    return spi_write(priv->spi, priv->reg_buffer, 2);
>>>>> +}
>>>>> +
>>>>> +static int hi8435_writew(struct hi8435_priv *priv, u8 reg, u16 val)
>>>>> +{
>>>>> +    priv->reg_buffer[0] = reg | HI8435_WRITE_OPCODE;
>>>>> +    priv->reg_buffer[1] = (val >> 8) & 0xff;
>>>>> +    priv->reg_buffer[2] = val & 0xff;
>>>>> +
>>>>> +    return spi_write(priv->spi, priv->reg_buffer, 3);
>>>>> +}
>>>>> +
>>>>> +static ssize_t hi8435_test_enable_show(struct device *dev,
>>>>> +                       struct device_attribute *attr, char *buf)
>>>>> +{
>>>>> +    struct hi8435_priv *priv = iio_priv(dev_to_iio_dev(dev));
>>>>> +    int ret;
>>>>> +    u8 reg;
>>>>> +
>>>>> +    ret = hi8435_readb(priv, HI8435_CTRL_REG, &reg);
>>>>> +    if (ret < 0)
>>>>> +        return ret;
>>>>> +
>>>>> +    return sprintf(buf, "%d\n", reg & HI8435_CTRL_TEST);
>>>>> +}
>>>>> +
>>>>> +static ssize_t hi8435_test_enable_store(struct device *dev,
>>>>> +                    struct device_attribute *attr,
>>>>> +                    const char *buf, size_t len)
>>>>> +{
>>>>> +    struct hi8435_priv *priv = iio_priv(dev_to_iio_dev(dev));
>>>>> +    unsigned int val;
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = kstrtouint(buf, 10, &val);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>> +
>>>>> +    ret = hi8435_writeb(priv, HI8435_CTRL_REG, val ? HI8435_CTRL_TEST : 0);
>>>>> +    if (ret < 0)
>>>>> +        return ret;
>>>>> +
>>>>> +    return len;
>>>>> +}
>>>>> +
>>>>> +static IIO_DEVICE_ATTR(test_enable, S_IRUGO | S_IWUSR,
>>>>> +    hi8435_test_enable_show, hi8435_test_enable_store, 0);
>>>>> +
>>>>> +static struct attribute *hi8435_attributes[] = {
>>>>> +    &iio_dev_attr_test_enable.dev_attr.attr,
>>>>> +    NULL,
>>>>> +};
>>>>> +
>>>>> +static struct attribute_group hi8435_attribute_group = {
>>>>> +    .attrs = hi8435_attributes,
>>>>> +};
>>>>> +
>>>>> +static int hi8435_read_raw(struct iio_dev *idev,
>>>>> +               const struct iio_chan_spec *chan,
>>>>> +               int *val, int *val2, long mask)
>>>>> +{
>>>>> +    struct hi8435_priv *priv = iio_priv(idev);
>>>>> +    int ret;
>>>>> +
>>>>> +    switch (mask) {
>>>>> +    case IIO_CHAN_INFO_RAW:
>>>>> +        ret = hi8435_readl(priv, HI8435_SO31_0_REG, val);
>>>>> +        if (ret < 0)
>>>>> +            return ret;
>>>>> +        *val = !!(*val & BIT(chan->channel));
>>>>> +        return IIO_VAL_INT;
>> This is where we end up in an odd possition having elected to report these
>> as 'events'.
>> We are reporting a 'last event state' via a read raw rather than as part
>> of the events infrastructure. I wonder if instead we want to allow the
>> events stuff to give us a 'am I true now signal'.
>> Would be easy enough to add and would give a clear interface.
> I agree.
> 
> I was thinking to use it only for getting initial states.
> But it is ok if we assume that default state is all 0 and then
> make UI changes in accordance to coming events.
That would be the option that makes most sense to me.
> 
> Also It might be useful for UI debounce for clocking at low frequency when
> debounce interval is much smaller then clocking/polling period.
That would really mean that the polling wasn't fast enough. I can see your
point though that maybe you'd want to ensure a value had been up for a
particular period before accepting it.  Still I doubt this sort of chip is
ever really used for a UI interface!

> 
>>
>> IIO_EV_INFO_CURRENT_STATE and attibute naming something like
>> in_voltageY_thresh_rising_state
>> which reads either 1 or 0?
> Got it.
> I will remove *_raw in favour of new event interface entry.
> It should be read-only (read_event_value), right?
yes
> 
> May I use the pair callback write_event_value() for my test_mode for
> setting each sense output manually?
> Or should I put all test mode related stuff into debugfs?
For now I'd say debugfs.  It's a bit of an odd corner case
so I'm a little anxious not to set a precedence for it in the main
ABI. Debugfs stuff is always more fluid anyway so it will be fine there.
> 
>>
>> For other devices we might need to take into account the
>> we are not currently measuring but that can be done by an error
>> return.
>>
>>>>> +    case IIO_CHAN_INFO_DEBOUNCE_TIME:
>>>>> +        *val = priv->debounce_interval;
>>>>> +        return IIO_VAL_INT;
>>>>> +    default:
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +static int hi8435_write_raw(struct iio_dev *idev,
>>>>> +                const struct iio_chan_spec *chan,
>>>>> +                int val, int val2, long mask)
>>>>> +{
>>>>> +    struct hi8435_priv *priv = iio_priv(idev);
>>>>> +
>>>>> +    switch (mask) {
>>>>> +    case IIO_CHAN_INFO_RAW:
>>>>> +        /* program sensors outputs in test mode */
>>>>> +        return hi8435_writeb(priv, HI8435_TMDATA_REG, val ? 0x1 : 0x2);
>>>>> +    case IIO_CHAN_INFO_DEBOUNCE_TIME:
>>>>> +        if (val < 0)
>>>>> +            return -EINVAL;
>>>>> +        if (val > HI8435_DEBOUNCE_DELAY_MAX)
>>>>> +            val = HI8435_DEBOUNCE_DELAY_MAX;
>>>>> +        priv->debounce_interval = val;
>>>>> +        return 0;
>>>>> +    default:
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>> +}
>>>>> +
>>>>> +static int hi8435_read_event_config(struct iio_dev *idev,
>>>>> +                    const struct iio_chan_spec *chan,
>>>>> +                    enum iio_event_type type,
>>>>> +                    enum iio_event_direction dir)
>>>>> +{
>>>>> +    struct hi8435_priv *priv = iio_priv(idev);
>>>>> +
>>>>> +    return !!(priv->event_scan_mask & BIT(chan->channel));
>>>>> +}
>>>>> +
>>>>> +static int hi8435_write_event_config(struct iio_dev *idev,
>>>>> +                     const struct iio_chan_spec *chan,
>>>>> +                     enum iio_event_type type,
>>>>> +                     enum iio_event_direction dir, int state)
>>>>> +{
>>>>> +    struct hi8435_priv *priv = iio_priv(idev);
>>>>> +
>>>>> +    priv->event_scan_mask &= ~BIT(chan->channel);
>>>>> +    if (state)
>>>>> +        priv->event_scan_mask |= BIT(chan->channel);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int hi8435_read_event_value(struct iio_dev *idev,
>>>>> +                   const struct iio_chan_spec *chan,
>>>>> +                   enum iio_event_type type,
>>>>> +                   enum iio_event_direction dir,
>>>>> +                   enum iio_event_info info,
>>>>> +                   int *val, int *val2)
>>>>> +{
>>>>> +    struct hi8435_priv *priv = iio_priv(idev);
>>>>> +    int ret;
>>>>> +    u8 mode, psen;
>>>>> +    u16 reg;
>>>>> +
>>>>> +    ret = hi8435_readb(priv, HI8435_PSEN_REG, &psen);
>>>>> +    if (ret < 0)
>>>>> +        return ret;
>>>>> +
>>>>> +    /* Supply-Open or GND-Open sensing mode */
>>>>> +    mode = !!(psen & BIT(chan->channel / 8));
>>>>> +
>>>>> +    ret = hi8435_readw(priv, mode ? HI8435_SOCENHYS_REG :
>>>>> +                 HI8435_GOCENHYS_REG, &reg);
>>>>> +    if (ret < 0)
>>>>> +        return ret;
>>>>> +
>>>>> +    if (dir == IIO_EV_DIR_FALLING)
>>>>> +        *val = ((reg & 0xff) - (reg >> 8)) / 2;
>>>>> +
>>>>> +    if (dir == IIO_EV_DIR_RISING)
>>>>> +        *val = ((reg & 0xff) + (reg >> 8)) / 2;
>>>>> +
>>>>> +    return IIO_VAL_INT;
>>>>> +}
>>>>> +
>>>>> +static int hi8435_write_event_value(struct iio_dev *idev,
>>>>> +                    const struct iio_chan_spec *chan,
>>>>> +                    enum iio_event_type type,
>>>>> +                    enum iio_event_direction dir,
>>>>> +                    enum iio_event_info info,
>>>>> +                    int val, int val2)
>>>>> +{
>>>>> +    struct hi8435_priv *priv = iio_priv(idev);
>>>>> +    int ret;
>>>>> +    u8 mode, psen;
>>>>> +    u16 reg;
>>>>> +
>>>>> +    ret = hi8435_readb(priv, HI8435_PSEN_REG, &psen);
>>>>> +    if (ret < 0)
>>>>> +        return ret;
>>>>> +
>>>>> +    /* Supply-Open or GND-Open sensing mode */
>>>>> +    mode = !!(psen & BIT(chan->channel / 8));
>>>>> +
>>>>> +    ret = hi8435_readw(priv, mode ? HI8435_SOCENHYS_REG :
>>>>> +                 HI8435_GOCENHYS_REG, &reg);
>>>>> +    if (ret < 0)
>>>>> +        return ret;
>>>>> +
>>>>> +    if (dir == IIO_EV_DIR_FALLING) {
>>>>> +        /* falling threshold range 2..21V, hysteresis minimum 2V */
>>>>> +        if (val < 2 || val > 21 || (val + 1) >= priv->threshold_hi[mode])
>>>>> +            return -EINVAL;
>>>>> +
>>>>> +        if (val == priv->threshold_lo[mode])
>>>>> +            return 0;
>>>>> +
>>>>> +        priv->threshold_lo[mode] = val;
>>>>> +
>>>>> +        /* hysteresis must not be odd */
>>>>> +        if ((priv->threshold_hi[mode] - priv->threshold_lo[mode]) % 2)
>>>>> +            priv->threshold_hi[mode]--;
>>>>> +    }
>>>>> +
>>>>> +    if (dir == IIO_EV_DIR_RISING) {
>>>>> +        /* rising threshold range 3..22V, hysteresis minimum 2V */
>>>>> +        if (val < 3 || val > 22 || val <= (priv->threshold_lo[mode] + 1))
>>>>> +            return -EINVAL;
>>>>> +
>>>>> +        if (val == priv->threshold_hi[mode])
>>>>> +            return 0;
>>>>> +
>>>>> +        priv->threshold_hi[mode] = val;
>>>>> +
>>>>> +        /* hysteresis must not be odd */
>>>>> +        if ((priv->threshold_hi[mode] - priv->threshold_lo[mode]) % 2)
>>>>> +            priv->threshold_lo[mode]++;
>>>>> +    }
>>>>> +
>>>>> +    /* program thresholds */
>>>>> +    mutex_lock(&priv->lock);
>>>>> +
>>>>> +    ret = hi8435_readw(priv, mode ? HI8435_SOCENHYS_REG :
>>>>> +                 HI8435_GOCENHYS_REG, &reg);
>>>>> +    if (ret < 0) {
>>>>> +        mutex_unlock(&priv->lock);
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    /* hysteresis */
>>>>> +    reg = priv->threshold_hi[mode] - priv->threshold_lo[mode];
>>>>> +    reg <<= 8;
>>>>> +    /* threshold center */
>>>>> +    reg |= (priv->threshold_hi[mode] + priv->threshold_lo[mode]);
>>>>> +
>>>>> +    ret = hi8435_writew(priv, mode ? HI8435_SOCENHYS_REG :
>>>>> +                  HI8435_GOCENHYS_REG, reg);
>>>>> +
>>>>> +    mutex_unlock(&priv->lock);
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +static const struct iio_event_spec hi8435_events[] = {
>>>>> +    {
>>>>> +        .type = IIO_EV_TYPE_THRESH,
>>>>> +        .dir = IIO_EV_DIR_RISING,
>>>>> +        .mask_separate = BIT(IIO_EV_INFO_VALUE),
>>>>> +    }, {
>>>>> +        .type = IIO_EV_TYPE_THRESH,
>>>>> +        .dir = IIO_EV_DIR_FALLING,
>>>>> +        .mask_separate = BIT(IIO_EV_INFO_VALUE),
>>>>> +    }, {
>>>>> +        .type = IIO_EV_TYPE_THRESH,
>>>>> +        .dir = IIO_EV_DIR_EITHER,
>>>>> +        .mask_separate = BIT(IIO_EV_INFO_ENABLE),
>>>>> +    },
>>>>> +};
>>>>> +
>>>>> +static int hi8435_get_sensing_mode(struct iio_dev *idev,
>>>>> +                   const struct iio_chan_spec *chan)
>>>>> +{
>>>>> +    struct hi8435_priv *priv = iio_priv(idev);
>>>>> +    int ret;
>>>>> +    u8 reg;
>>>>> +
>>>>> +    ret = hi8435_readb(priv, HI8435_PSEN_REG, &reg);
>>>>> +    if (ret < 0)
>>>>> +        return ret;
>>>>> +
>>>>> +    return !!(reg & BIT(chan->channel / 8));
>>>>> +}
>>>>> +
>>>>> +static int hi8435_set_sensing_mode(struct iio_dev *idev,
>>>>> +                   const struct iio_chan_spec *chan,
>>>>> +                   unsigned int mode)
>>>>> +{
>>>>> +    struct hi8435_priv *priv = iio_priv(idev);
>>>>> +    int ret;
>>>>> +    u8 reg;
>>>>> +
>>>>> +    mutex_lock(&priv->lock);
>>>>> +
>>>>> +    ret = hi8435_readb(priv, HI8435_PSEN_REG, &reg);
>>>>> +    if (ret < 0) {
>>>>> +        mutex_unlock(&priv->lock);
>>>>> +        return ret;
>>>>> +    }
>>>>> +
>>>>> +    reg &= ~BIT(chan->channel / 8);
>>>>> +    if (mode)
>>>>> +        reg |= BIT(chan->channel / 8);
>>>>> +
>>>>> +    ret = hi8435_writeb(priv, HI8435_PSEN_REG, reg);
>>>>> +
>>>>> +    mutex_unlock(&priv->lock);
>>>>> +
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +static const char * const hi8435_sensing_modes[] = { "GND-Open",
>>>>> +                             "Supply-Open" };
>>>>> +
>>>>> +static const struct iio_enum hi8435_sensing_mode = {
>>>>> +    .items = hi8435_sensing_modes,
>>>>> +    .num_items = ARRAY_SIZE(hi8435_sensing_modes),
>>>>> +    .get = hi8435_get_sensing_mode,
>>>>> +    .set = hi8435_set_sensing_mode,
>>>>> +};
>>>>> +
>>>>> +static const struct iio_chan_spec_ext_info hi8435_ext_info[] = {
>>>>> +    IIO_ENUM("sensing_mode", IIO_SEPARATE, &hi8435_sensing_mode),
>>>>> +    {},
>>>>> +};
>>>>> +
>>>>> +#define HI8435_VOLTAGE_CHANNEL(num)                    \
>>>>> +{                                    \
>>>>> +    .type = IIO_VOLTAGE,                        \
>>>>> +    .indexed = 1,                            \
>>>>> +    .channel = num,                            \
>>>>> +    .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),            \
>> If we are using events, why have the raw access at all?
> I will remove *_raw.
> 
> I will probably add  IIO_EV_INFO_CURRENT_STATE.
> 
>>>>> +    .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_DEBOUNCE_TIME),    \
>>>>> +    .event_spec = hi8435_events,                    \
>>>>> +    .num_event_specs = ARRAY_SIZE(hi8435_events),            \
>>>>> +    .ext_info = hi8435_ext_info,                    \
>>>>> +    .extend_name = "comparator"                    \
>>>> I'm really not sure about this approach.  Can see where you are coming
>>>> from. We already have an events interface supporting these things so
>>>> why not use it?   I'm just doubtful it is an efficient option or a clean
>>>> interface (would like more opinions on this!)
>>> Sorry, I did not understand here.
>>> Is it about .extend_name ?
>>> I did add "comparator" extention to have attributes look like "in_voltage0_comparator_raw"
>> I'd drop it, particularly if we also drop the raw access.
> Now I understand. Thank you for clarification.
> I will remove it.
> 
>>>>> +}
>>>>> +
>>>>> +static const struct iio_chan_spec hi8435_channels[] = {
>>>>> +    HI8435_VOLTAGE_CHANNEL(0),
>>>>> +    HI8435_VOLTAGE_CHANNEL(1),
>>>>> +    HI8435_VOLTAGE_CHANNEL(2),
>>>>> +    HI8435_VOLTAGE_CHANNEL(3),
>>>>> +    HI8435_VOLTAGE_CHANNEL(4),
>>>>> +    HI8435_VOLTAGE_CHANNEL(5),
>>>>> +    HI8435_VOLTAGE_CHANNEL(6),
>>>>> +    HI8435_VOLTAGE_CHANNEL(7),
>>>>> +    HI8435_VOLTAGE_CHANNEL(8),
>>>>> +    HI8435_VOLTAGE_CHANNEL(9),
>>>>> +    HI8435_VOLTAGE_CHANNEL(10),
>>>>> +    HI8435_VOLTAGE_CHANNEL(11),
>>>>> +    HI8435_VOLTAGE_CHANNEL(12),
>>>>> +    HI8435_VOLTAGE_CHANNEL(13),
>>>>> +    HI8435_VOLTAGE_CHANNEL(14),
>>>>> +    HI8435_VOLTAGE_CHANNEL(15),
>>>>> +    HI8435_VOLTAGE_CHANNEL(16),
>>>>> +    HI8435_VOLTAGE_CHANNEL(17),
>>>>> +    HI8435_VOLTAGE_CHANNEL(18),
>>>>> +    HI8435_VOLTAGE_CHANNEL(19),
>>>>> +    HI8435_VOLTAGE_CHANNEL(20),
>>>>> +    HI8435_VOLTAGE_CHANNEL(21),
>>>>> +    HI8435_VOLTAGE_CHANNEL(22),
>>>>> +    HI8435_VOLTAGE_CHANNEL(23),
>>>>> +    HI8435_VOLTAGE_CHANNEL(24),
>>>>> +    HI8435_VOLTAGE_CHANNEL(25),
>>>>> +    HI8435_VOLTAGE_CHANNEL(26),
>>>>> +    HI8435_VOLTAGE_CHANNEL(27),
>>>>> +    HI8435_VOLTAGE_CHANNEL(28),
>>>>> +    HI8435_VOLTAGE_CHANNEL(29),
>>>>> +    HI8435_VOLTAGE_CHANNEL(30),
>>>>> +    HI8435_VOLTAGE_CHANNEL(31),
>>>>> +    IIO_CHAN_SOFT_TIMESTAMP(32),
>>>>> +};
>>>>> +
>>>>> +static const struct iio_info hi8435_info = {
>>>>> +    .driver_module = THIS_MODULE,
>>>>> +    .attrs = &hi8435_attribute_group,
>>>>> +    .read_raw = hi8435_read_raw,
>>>>> +    .write_raw = hi8435_write_raw,
>>>>> +    .read_event_config = &hi8435_read_event_config,
>>>>> +    .write_event_config = hi8435_write_event_config,
>>>>> +    .read_event_value = &hi8435_read_event_value,
>>>>> +    .write_event_value = &hi8435_write_event_value,
>>>>> +};
>>>>> +
>>>>> +static void hi8435_iio_push_event(struct iio_dev *idev, unsigned int val)
>>>>> +{
>>>>> +    struct hi8435_priv *priv = iio_priv(idev);
>>>>> +    enum iio_event_direction dir;
>>>>> +    unsigned int i;
>>>>> +    unsigned int status = priv->event_prev_val ^ val;
>>>>> +
>>>>> +    if (!status)
>>>>> +        return;
>>>>> +
>>>>> +    for_each_set_bit(i, &priv->event_scan_mask, 32) {
>>>>> +        if (!(status & BIT(i)))
>>>>> +            continue;
>>>>> +
>>>>> +        dir = val & BIT(i) ? IIO_EV_DIR_RISING : IIO_EV_DIR_FALLING;
>>>>> +
>>>>> +        iio_push_event(idev,
>>>>> +                   IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
>>>>> +                            IIO_EV_TYPE_THRESH, dir),
>>>>> +                   iio_get_time_ns());
>>>>> +    }
>>>>> +
>>>>> +    priv->event_prev_val = val;
>>>>> +}
>>>>> +
>>>>> +static void hi8435_debounce_work(struct work_struct *work)
>>>>> +{
>>>>> +    struct hi8435_priv *priv = container_of(work, struct hi8435_priv,
>>>>> +                        work.work);
>>>>> +    struct iio_dev *idev = spi_get_drvdata(priv->spi);
>>>>> +    u32 val;
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = hi8435_readl(priv, HI8435_SO31_0_REG, &val);
>>>>> +    if (ret < 0)
>>>>> +        return;
>>>>> +
>>>>> +    if (val == priv->debounce_val)
>>>>> +        hi8435_iio_push_event(idev, val);
>>>>> +    else
>>>>> +        dev_warn(&priv->spi->dev, "filtered by software debounce");
>>>> Definitely not.  Warning every time a standard event occurs?  Not
>>>> a good idea.  Use the debug stuff if you want a way of knowing this
>>>> happened, then it will silent under normal use.
>>> I'd say it is not standard event, but occasional/debounce event.
>>> Anyway I agree with you.
>>>
>>>>> +}
>>>>> +
>>>>> +static irqreturn_t hi8435_trigger_handler(int irq, void *private)
>>>>> +{
>>>>> +    struct iio_poll_func *pf = private;
>>>>> +    struct iio_dev *idev = pf->indio_dev;
>>>>> +    struct hi8435_priv *priv = iio_priv(idev);
>>>>> +    u32 val;
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = hi8435_readl(priv, HI8435_SO31_0_REG, &val);
>>>>> +    if (ret < 0)
>>>>> +        goto err_read;
>>>>> +
>>>>> +    if (priv->debounce_interval) {
>>>>> +        priv->debounce_val = val;
>>>>> +        schedule_delayed_work(&priv->work,
>>>>> +                msecs_to_jiffies(priv->debounce_interval));
>>>> This is another element that makes me doubt that the event interface
>>>> is the way to do this.  I'd much rather we pushed the debouncing out
>>>> to userspace where cleverer things can be done (and more adaptive things).
>>>> Here to keep the event flow low you have to do it in the kernel.
>>> Yes, it is helpful for reducing the data flow (buffer data or event data)
>>> Many kernel drivers support s/w event debouncing, f.e. usb cable plug-in, or other connectors.
>> True enough that it is common functionality.  However, we try to keep
>> the IIO datahandling as minimal as possible and leave the job to userspace.
>>
>> We aren't likely to be dealing with huge datarates here (as we are effectively
>> polling at maybe a few hundred Hz).   Also, with the hysterisis set sensibly
>> seems unlikely that much bounce due to noise will ever occur.  If you get
>> bounce that overcomes that then you probably have a wiring or logic problem!
> Ok, I see. I will remove it.
> 
>>>>> +    } else {
>>>>> +        hi8435_iio_push_event(idev, val);
>>>>> +    }
>>>>> +
>>>>> +err_read:
>>>>> +    iio_trigger_notify_done(idev->trig);
>>>>> +
>>>>> +    return IRQ_HANDLED;
>>>>> +}
>>>>> +
>>>>> +static void hi8435_parse_dt(struct hi8435_priv *priv)
>>>>> +{
>>>>> +    struct device_node *np = priv->spi->dev.of_node;
>>>>> +    int ret;
>>>>> +
>>>>> +    ret = of_get_named_gpio(np, "holt,reset-gpios", 0);
>>>>> +    priv->reset_gpio = ret < 0 ? 0 : ret;
>>>> Silly question, but can gpio0 exist on a board?  I suspect you
>>>> may need an additional variable to hold that this request failed
>>>> rather than using the magic value of 0.
>>> I will do handle this case, thank you.
>> Look at what Lars added on this question...
>>>>> +
>>>>> +    ret = of_property_read_u32(np, "holt,debounce-interval",
>>>>> +                   &priv->debounce_interval);
>>>>> +    if (ret)
>>>>> +        priv->debounce_interval = 0;
>>>>> +    if (priv->debounce_interval > HI8435_DEBOUNCE_DELAY_MAX)
>>>>> +        priv->debounce_interval = HI8435_DEBOUNCE_DELAY_MAX;
>>>>> +}
>>>>> +
>>>>> +static int hi8435_probe(struct spi_device *spi)
>>>>> +{
>>>>> +    struct iio_dev *idev;
>>>>> +    struct hi8435_priv *priv;
>>>>> +    int ret;
>>>>> +
>>>>> +    idev = devm_iio_device_alloc(&spi->dev, sizeof(*priv));
>>>>> +    if (!idev)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    priv = iio_priv(idev);
>>>>> +    priv->spi = spi;
>>>>> +
>>>>> +    if (spi->dev.of_node)
>>>>> +        hi8435_parse_dt(priv);
>>>>> +
>>>>> +    spi_set_drvdata(spi, idev);
>>>>> +    mutex_init(&priv->lock);
>>>>> +    INIT_DELAYED_WORK(&priv->work, hi8435_debounce_work);
>>>>> +
>>>>> +    idev->dev.parent    = &spi->dev;
>>>>> +    idev->name        = spi_get_device_id(spi)->name;
>>>>> +    idev->modes        = INDIO_DIRECT_MODE;
>>>>> +    idev->info        = &hi8435_info;
>>>>> +    idev->channels        = hi8435_channels;
>>>>> +    idev->num_channels    = ARRAY_SIZE(hi8435_channels);
>>>>> +
>>>>> +    if (priv->reset_gpio) {
>>>>> +        ret = devm_gpio_request(&spi->dev, priv->reset_gpio, idev->name);
>>>>> +        if (!ret) {
>>>>> +            /* chip hardware reset */
>>>>> +            gpio_direction_output(priv->reset_gpio, 0);
>>>>> +            udelay(5);
>>>>> +            gpio_direction_output(priv->reset_gpio, 1);
>>>>> +        }
>>>>> +    } else {
>>>>> +        /* chip software reset */
>>>>> +        hi8435_writeb(priv, HI8435_CTRL_REG, HI8435_CTRL_SRST);
>>>>> +        /* get out from reset state */
>>>>> +        hi8435_writeb(priv, HI8435_CTRL_REG, 0);
>>>>> +    }
>>>>> +
>>>>> +    /* unmask all events */
>>>>> +    priv->event_scan_mask = ~(0);
>>>>> +    /* initialize default thresholds */
>>>>> +    priv->threshold_lo[0] = priv->threshold_lo[1] = 2;
>>>>> +    priv->threshold_hi[0] = priv->threshold_hi[1] = 4;
>>>> These seem very random.  Why these values or
>>> The aim for thresholds initialization is that they are in undefined state after h/w reset and
>>> the driver allows userspace to change thresholds (high or low) separately.
>>>
>>> There is a restriction in the chip - the hysteresis can not be even.
>>> If the hysteresis is set to even value then it get's into lock state and not functional anymore. (I've figured this out empirically).
>> *nice*
>>> So we need to initialize thresholds (aka hysteresis + it's center) to some initial value to be able to change
>>> high and low thresholds separately and avoid even values for hysteresis.
>>>
>>> I will also add these comments.
>> Cool
>>>>> +    hi8435_writew(priv, HI8435_GOCENHYS_REG, 0x206);
>>>> What is 0x206?  Again, I guess a default. I'd like to see a comment
>>>> here saying what real world value it corresponds to.
>>> Yes it is default values.
>>>
>>> The 0x206 is a code for HI threshold voltage = 4V and low voltage threshold = 2V.
>>> The register HI8435_SOCENHYS_REG describes the voltage hysteresis of the sensor and the hysteresis center.
>>> The 0x206 is an encoded value for 2V-to-4V voltage threshold.
>>>
>>> I will add comments.
>> good.
>>>>> +    hi8435_writew(priv, HI8435_SOCENHYS_REG, 0x206);
>>>>> +
>>>> I am as yet unconvinced that using triggers to poll events is a terribly
>>>> good idea.  Feels rather like we are doing this due to a deficiency in
>>>> the buffer interface than because sending events makes sense here.
>>> Actually the first version of this driver was against the buffer interface.
>>> I did try to use your tip and switched to event interface :)
>> oops.
>>> Do you think I should switch to buffer interface back?
>> Nope. As discussed above, right now this approach is winning (just ;)
>>>>> +    ret = iio_triggered_event_setup(idev, NULL, hi8435_trigger_handler);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>> +
>>>>> +    ret = iio_device_register(idev);
>>>>> +    if (ret < 0) {
>>>>> +        dev_err(&spi->dev, "unable to register device\n");
>>>>> +        goto unregister_triggered_event;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +
>>>>> +unregister_triggered_event:
>>>>> +    iio_triggered_event_cleanup(idev);
>>>>> +    return ret;
>>>>> +}
>>>>> +
>>>>> +static int hi8435_remove(struct spi_device *spi)
>>>>> +{
>>>>> +    struct iio_dev *idev = spi_get_drvdata(spi);
>>>>> +    struct hi8435_priv *priv = iio_priv(idev);
>>>>> +
>>>>> +    cancel_delayed_work_sync(&priv->work);
>>>>> +    iio_device_unregister(idev);
>>>>> +    iio_triggered_event_cleanup(idev);
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static const struct of_device_id hi8435_dt_ids[] = {
>>>>> +    { .compatible = "holt,hi8435" },
>>>>> +    {},
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(of, hi8435_dt_ids);
>>>>> +
>>>>> +static const struct spi_device_id hi8435_id[] = {
>>>>> +    { "hi8435", 0},
>>>>> +    { }
>>>>> +};
>>>>> +MODULE_DEVICE_TABLE(spi, hi8435_id);
>>>>> +
>>>>> +static struct spi_driver hi8435_driver = {
>>>>> +    .driver    = {
>>>>> +        .name        = DRV_NAME,
>>>>> +        .of_match_table    = of_match_ptr(hi8435_dt_ids),
>>>>> +    },
>>>>> +    .probe        = hi8435_probe,
>>>>> +    .remove        = hi8435_remove,
>>>>> +    .id_table    = hi8435_id,
>>>>> +};
>>>>> +module_spi_driver(hi8435_driver);
>>>>> +
>>>>> +MODULE_LICENSE("GPL");
>>>>> +MODULE_AUTHOR("Vladimir Barinov");
>>>>> +MODULE_DESCRIPTION("HI-8435 threshold detector");
>>>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

