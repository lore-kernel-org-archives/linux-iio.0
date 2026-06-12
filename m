Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B43812C2;
	Fri, 12 Jun 2026 13:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271811; cv=none; b=l+704P6kdrxoxVa2mqBy+sJkzWUFDVNVHAukkXMNM6Lk67r6YALloGTUrpA/XN07rs06LE+WXH1TxPFMwMPEp61I9N6Gw5B7F6L2PgBu1tXz2fF0Sr/2F7tuIOvZeTN8J3pDHmR+sEkwkMshD8XePmtLpyvxG14lYaGxDP0K+MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271811; c=relaxed/simple;
	bh=aG1qX9QR+6FrpZu6mpxINHBBlg4axuOBXYYiP++ajso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jmz9LzZUBf/NXxa+UX7nqbvz+rzttNaDT1JS/Z9om42zaFgDoSRm7F5mgNgCVGHWJeczDp5D5/eC8rWu/lg7yBa3tEIo+F8fRCfw3W5vhRsZNm2jBMczEas8P0c07xzEQK6X76a3s4WQ4ARWTGLeUljl04KHs1oEvjt8TOa07EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNB/icRh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNB/icRh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57DD1F000E9;
	Fri, 12 Jun 2026 13:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781271809;
	bh=PW0ch6LzyqRe1DD7YGoIllwa5ppibrk0KebrYTidl70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BNB/icRhOi/JrMzhsjLioAjhjYVgL4L1ysM1ESoF38GjqLgxeKyI2AYNnV+5YFuMX
	 PIQcklCv4xlxk4f0KUfNX1+VlLjQv3mSwDiu6tqrOzhC+XD+18H2W6bsyHw6tOaMjR
	 RCvWfdwtdV0AsgsKz981zLSj9pqDKr0qNYIAcqfkVDkbodY8miwkYPEEO2/CeABc0E
	 BLQX7Lk0tsxnB102kLPqnbr5CiM+dcnsTDyRGBUonwmH9DaulTXZidxX3JhKc087OO
	 1lRAqbzl9uGnW/ppmYCWCiZuTG+7aHRPonBNN0ZvgnhmnNhaPQgBpQcJRI6MIetar1
	 qwTtBgchPWRfg==
Date: Fri, 12 Jun 2026 14:43:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Erim, Salih" <salih.erim@amd.com>
Cc: andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 conall.ogriofa@amd.com, michal.simek@amd.com, linux@roeck-us.net,
 erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] iio: adc: versal-sysmon: add threshold event
 support
Message-ID: <20260612144319.2302418e@jic23-huawei>
In-Reply-To: <bd6299ae-cd02-4914-ab1b-f6bb9d3d1b9a@amd.com>
References: <20260611222738.2035062-1-salih.erim@amd.com>
	<20260611222738.2035062-5-salih.erim@amd.com>
	<20260612135222.0cec353b@jic23-huawei>
	<bd6299ae-cd02-4914-ab1b-f6bb9d3d1b9a@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jun 2026 14:39:12 +0100
"Erim, Salih" <salih.erim@amd.com> wrote:

> Hi Jonathan,
> 
> Thanks for reviews, replies are inline.
> 
> On 12/06/2026 13:52, Jonathan Cameron wrote:
> > On Thu, 11 Jun 2026 23:27:37 +0100
> > Salih Erim <salih.erim@amd.com> wrote:
> >   
> >> Add threshold event support for temperature and supply voltage
> >> channels.
> >>
> >> Temperature events:
> >>    - Rising threshold with configurable value
> >>    - Over-temperature (OT) alarm with separate threshold  
> > 
> > Ah. I ask about this below.  If this applies to the same channel
> > as the main threshold we generally don't support that in IIO and
> > definitely not by introducing a 'magic' extra channel.
> > See below.
> >   
> >>    - Per-channel hysteresis as a millicelsius value
> >>    - Event direction is IIO_EV_DIR_RISING (hysteresis mode)
> >>
> >> Supply voltage events:
> >>    - Rising/falling threshold per supply channel
> >>    - Per-channel alarm enable via alarm configuration registers
> >>
> >> The hardware supports both window and hysteresis alarm modes for
> >> temperature. This driver uses hysteresis mode, where the upper
> >> threshold triggers the alarm and the lower threshold clears it
> >> (re-arm point). The hardware has a single ISR bit per temperature
> >> channel with no indication of which threshold was crossed, so
> >> hysteresis mode is the natural fit. The lower threshold register
> >> is computed internally as (upper - hysteresis).
> >>
> >> Hysteresis is stored in the driver as a millicelsius value,
> >> initialized from the hardware registers at probe. Writing the
> >> rising threshold or hysteresis recomputes the lower register.
> >> ALARM_CONFIG is hard-coded to hysteresis mode during init.
> >>
> >> The interrupt handler masks active threshold interrupts (which are
> >> level-sensitive) and schedules a delayed worker to poll for condition
> >> clear before unmasking. When no hardware IRQ is available, event
> >> channels are not created and interrupt init is skipped, since the
> >> I2C regmap backend cannot be called from atomic context.
> >>
> >> When disabling a supply channel alarm, the group interrupt remains
> >> active if any other channel in the same alarm group still has an
> >> alarm enabled.
> >>
> >> Signed-off-by: Salih Erim <salih.erim@amd.com>  
> > 
> > Some follow on questions on the temperature channels and one thing
> > Sashiko noticed that looks real.
> >   
> >> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> >> index c875d156dbe..20fd3a87d44 100644
> >> --- a/drivers/iio/adc/versal-sysmon-core.c
> >> +++ b/drivers/iio/adc/versal-sysmon-core.c
> >> @@ -11,7 +11,9 @@
> >>   #include <linux/bitops.h>
> >>   #include <linux/cleanup.h>
> >>   #include <linux/device.h>
> >> +#include <linux/devm-helpers.h>
> >>   #include <linux/err.h>
> >> +#include <linux/interrupt.h>
> >>   #include <linux/module.h>
> >>   #include <linux/property.h>
> >>   #include <linux/regmap.h>
> >> @@ -19,10 +21,19 @@
> >>   #include <linux/sysfs.h>
> >>   #include <linux/units.h>
> >>
> >> +#include <linux/iio/events.h>
> >>   #include <linux/iio/iio.h>
> >>
> >>   #include "versal-sysmon.h"
> >>
> >> +/* OT and TEMP hysteresis mode bits in SYSMON_TEMP_EV_CFG */
> >> +#define SYSMON_OT_HYST_MASK          BIT(0)
> >> +#define SYSMON_TEMP_HYST_MASK                BIT(1)
> >> +
> >> +/* Compute alarm register offset from a channel address */
> >> +#define SYSMON_ALARM_OFFSET(addr) \
> >> +     (SYSMON_ALARM_REG + ((addr) / SYSMON_ALARM_BITS_PER_REG) * SYSMON_REG_STRIDE)
> >> +
> >>   #define SYSMON_CHAN_TEMP(_chan, _address, _name)             \
> >>   {                                                            \
> >>        .type = IIO_TEMP,                                       \
> >> @@ -34,14 +45,87 @@
> >>        .datasheet_name = _name,                                \
> >>   }
> >>
> >> +#define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _name, _events)      \
> >> +{                                                            \
> >> +     .type = IIO_TEMP,                                       \
> >> +     .indexed = 1,                                           \
> >> +     .address = _address,                                    \
> >> +     .channel = _chan,                                       \
> >> +     .event_spec = _events,                                  \
> >> +     .num_event_specs = ARRAY_SIZE(_events),                 \
> >> +     .datasheet_name = _name,                                \
> >> +}
> >> +
> >> +enum sysmon_alarm_bit {
> >> +     SYSMON_BIT_ALARM0 = 0,
> >> +     SYSMON_BIT_ALARM1 = 1,
> >> +     SYSMON_BIT_ALARM2 = 2,
> >> +     SYSMON_BIT_ALARM3 = 3,
> >> +     SYSMON_BIT_ALARM4 = 4,
> >> +     SYSMON_BIT_OT = 8,
> >> +     SYSMON_BIT_TEMP = 9,
> >> +};  
> >   
> >>   /* Static temperature channels (always present) */
> >> -static const struct iio_chan_spec temp_channels[] = {
> >> +static const struct iio_chan_spec temp_channels_no_events[] = {
> >>        SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
> >>        SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
> >>        SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
> >>        SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
> >>   };
> >>
> >> +/* Static temperature channels with event support (when IRQ available) */
> >> +static const struct iio_chan_spec temp_channels_with_events[] = {
> >> +     SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
> >> +     SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
> >> +     SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
> >> +     SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
> >> +     SYSMON_CHAN_TEMP_EVENT(4, SYSMON_ADDR_TEMP_EVENT, "temp",
> >> +                           sysmon_temp_events),  
> > Is this not an event on channel 0?  Why does it need a separate one?  
> 
> The hardware has two independent threshold register pairs on the
> same DEVICE_TEMP_MAX measurement: a TEMP threshold (ISR bit 9)
> and an OT threshold (ISR bit 8), each with its own hysteresis.
> We modelled them as separate event-only channels because of the
> independent HW registers.
> 
> However, you're right that they don't necessarily need separate
> channels. Both monitor the same value that channel 0 reads, so
> the TEMP event spec belongs directly on channel 0.
> 
> >> +     SYSMON_CHAN_TEMP_EVENT(5, SYSMON_ADDR_OT_EVENT, "ot",  
> > 
> > Why two separate channels for events? Are we dealing with two separate
> > events on the same signal? Generally we don't support that for IIO because
> > it's largely meaningless except in hwmon usecases - what is the point in two
> > thresholds if they are reported through the same path?  Just use one and update
> > it if you want to add another level of detection.  
> 
> Yes, both are thresholds on the same physical measurement. OT is
> a higher-severity threshold that can trigger the platform
> management controller to initiate a hardware shutdown sequence.
> 
> If you agree, I'd propose for v7:
>    - Move TEMP threshold event spec onto channel 0 directly
>    - Drop OT as a separate IIO channel, since it's a hardware
>      safety mechanism better suited for the thermal framework
>      as a critical trip point (planned for the follow-up
>      thermal series)
> 
> Happy to take a different direction if you prefer.

That sounds good.

Thanks,

Jonathan

> 
> >   
> >> +                           sysmon_temp_events),
> >> +};  
> >   
> >> +
> >> +static int sysmon_read_event_config(struct iio_dev *indio_dev,
> >> +                                 const struct iio_chan_spec *chan,
> >> +                                 enum iio_event_type type,
> >> +                                 enum iio_event_direction dir)
> >> +{
> >> +     u32 alarm_event_mask = sysmon_get_event_mask(chan->address);
> >> +     struct sysmon *sysmon = iio_priv(indio_dev);
> >> +     unsigned int imr;
> >> +     int config_value;
> >> +     int ret;
> >> +
> >> +     ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
> >> +     if (ret)
> >> +             return ret;
> >> +
> >> +     /* IMR bits are 1=masked, invert to get 1=enabled */
> >> +     imr = ~imr;
> >> +
> >> +     switch (chan->type) {
> >> +     case IIO_VOLTAGE:
> >> +             config_value = sysmon_read_alarm_config(sysmon, chan->address);
> >> +             if (config_value < 0)
> >> +                     return config_value;
> >> +             return config_value && (imr & alarm_event_mask);
> >> +
> >> +     case IIO_TEMP:
> >> +             return !!(imr & alarm_event_mask);  
> > 
> > Sashiko made a perhaps insightful observation here.  When the interrupt
> > is masked between sending an event and the worker reenabling it does
> > this give an unexpected value to userspace?  I think that condition
> > we'd kind of expect this to return 0.
> > https://sashiko.dev/#/patchset/20260611222738.2035062-1-salih.erim%40amd.com  
> 
> Agreed. read_event_config currently reads the hardware IMR which
> shows transient masking state during the 500ms polling window.
> Will fix to return the administrative state from temp_mask instead.
> 
> > 
> > I think the rest of the feedback is probably false positives or debatable
> > stuff but this one rang true. Please do take a look at the other stuff
> > as I may have missed something (maybe the comment about needing to disable
> > event interrupt generation is true?)  
> 
> Good point. Will investigate whether a devm_add_action to
> write SYSMON_IDR is needed on unbind and add it if so.
> 
> Reviewed the remaining Sashiko findings:
> 
>    - Integer overflow in threshold conversions: for temperature,
>      the Q8.7 register range is -256C to +255C, so any
>      reasonable millicelsius input fits after the shift. For
>      supply, val * scale can overflow int32 above ~32V, but
>      supply rails on Versal are well under 4V. Extreme sysfs
>      inputs are outside the hardware range.
> 
>    - I2C + IRQ panic on misconfigured DT: if an I2C node
>      incorrectly specifies an interrupts property, the driver
>      would register a hardirq handler on a sleeping regmap.
>      The binding does not list interrupts for I2C, so this
>      would be a DT authoring error.
> 
> Thanks,
> Salih
> 
> >   
> >> +
> >> +     default:
> >> +             return -EINVAL;
> >> +     }  
> > 
> > 
> > 
> >   
> >> +  
> >   
> 

