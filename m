Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E738550C;
	Fri, 12 Jun 2026 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268755; cv=none; b=KGzUKpRdeJe+xRs3TAcFelXEmBfeT2Jjk83Smzuo4eKcYEeOEtIZkxAHjzNLB/3o723z8ahfgitbSQwFbMyrgJSnQjYK+AqVzBvv3jFbKcIcwSZjpf1Dfp3ZUlpXZTUJbYY4cEEIcW1o8NIw57J3zvNJbpq2xUxHxMUTCHJ3txo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268755; c=relaxed/simple;
	bh=v5chSWBWmC7VLMjAZbVh9OAnibCPxEDZipEc5qXY8x0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UN2Q4UYTqnad8GQmxX/UbkLnGpqDywz3oPxkXckf34vDx1C1v22njwAY9jR93996pH+jgk2iRNjE5WB/tJnRWCGRJQJI2QOh1bQE2wDAcus8YKhMx7kgD8iZOwhCkSljhOMEfCWkvasruz61kpzyJR2cT8g8AkNaLiEsdr3p+XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgkgRHx7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgkgRHx7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE0E1F000E9;
	Fri, 12 Jun 2026 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781268750;
	bh=PmMLaJXjhRYelS8/jPqk9Km7Z0RgyZ6vCRvUCQiJvys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IgkgRHx7FYloM1vvW3IahbabCu1JC15CHQFRjCdwxE7jAqjKklXjFkrBWRIjMzXTn
	 ChEzT3rR0V/zSsKbQwMt6mJKYsCkANMcxfD0p5iXhexRVL7jNqmuH6sfC0mbAEtzjD
	 iw+P63YtjTLC0wTZJz1mJqNj1vkXl0720SCnFMc2p23xyazlIPiRJQyseTRzz9lLyn
	 9UCQOrk+fFbzQYmnBYFO9mV5xYQL6h21LhdhDAVbZeoWgP5UCdmNcaPl9tao9kb74G
	 gBVWPrbyXXxHm/T2UxfhF6svDGb/ouYsDEz2OrO11rVmR3tiIhGeaWbcqSSLrs6d8f
	 qD25nXiaNT1uQ==
Date: Fri, 12 Jun 2026 13:52:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: <andy@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <conall.ogriofa@amd.com>, <michal.simek@amd.com>, <linux@roeck-us.net>,
 <erimsalih@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/5] iio: adc: versal-sysmon: add threshold event
 support
Message-ID: <20260612135222.0cec353b@jic23-huawei>
In-Reply-To: <20260611222738.2035062-5-salih.erim@amd.com>
References: <20260611222738.2035062-1-salih.erim@amd.com>
	<20260611222738.2035062-5-salih.erim@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 23:27:37 +0100
Salih Erim <salih.erim@amd.com> wrote:

> Add threshold event support for temperature and supply voltage
> channels.
> 
> Temperature events:
>   - Rising threshold with configurable value
>   - Over-temperature (OT) alarm with separate threshold

Ah. I ask about this below.  If this applies to the same channel
as the main threshold we generally don't support that in IIO and
definitely not by introducing a 'magic' extra channel.
See below.

>   - Per-channel hysteresis as a millicelsius value
>   - Event direction is IIO_EV_DIR_RISING (hysteresis mode)
> 
> Supply voltage events:
>   - Rising/falling threshold per supply channel
>   - Per-channel alarm enable via alarm configuration registers
> 
> The hardware supports both window and hysteresis alarm modes for
> temperature. This driver uses hysteresis mode, where the upper
> threshold triggers the alarm and the lower threshold clears it
> (re-arm point). The hardware has a single ISR bit per temperature
> channel with no indication of which threshold was crossed, so
> hysteresis mode is the natural fit. The lower threshold register
> is computed internally as (upper - hysteresis).
> 
> Hysteresis is stored in the driver as a millicelsius value,
> initialized from the hardware registers at probe. Writing the
> rising threshold or hysteresis recomputes the lower register.
> ALARM_CONFIG is hard-coded to hysteresis mode during init.
> 
> The interrupt handler masks active threshold interrupts (which are
> level-sensitive) and schedules a delayed worker to poll for condition
> clear before unmasking. When no hardware IRQ is available, event
> channels are not created and interrupt init is skipped, since the
> I2C regmap backend cannot be called from atomic context.
> 
> When disabling a supply channel alarm, the group interrupt remains
> active if any other channel in the same alarm group still has an
> alarm enabled.
> 
> Signed-off-by: Salih Erim <salih.erim@amd.com>

Some follow on questions on the temperature channels and one thing
Sashiko noticed that looks real.

> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> index c875d156dbe..20fd3a87d44 100644
> --- a/drivers/iio/adc/versal-sysmon-core.c
> +++ b/drivers/iio/adc/versal-sysmon-core.c
> @@ -11,7 +11,9 @@
>  #include <linux/bitops.h>
>  #include <linux/cleanup.h>
>  #include <linux/device.h>
> +#include <linux/devm-helpers.h>
>  #include <linux/err.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> @@ -19,10 +21,19 @@
>  #include <linux/sysfs.h>
>  #include <linux/units.h>
>  
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  
>  #include "versal-sysmon.h"
>  
> +/* OT and TEMP hysteresis mode bits in SYSMON_TEMP_EV_CFG */
> +#define SYSMON_OT_HYST_MASK		BIT(0)
> +#define SYSMON_TEMP_HYST_MASK		BIT(1)
> +
> +/* Compute alarm register offset from a channel address */
> +#define SYSMON_ALARM_OFFSET(addr) \
> +	(SYSMON_ALARM_REG + ((addr) / SYSMON_ALARM_BITS_PER_REG) * SYSMON_REG_STRIDE)
> +
>  #define SYSMON_CHAN_TEMP(_chan, _address, _name)		\
>  {								\
>  	.type = IIO_TEMP,					\
> @@ -34,14 +45,87 @@
>  	.datasheet_name = _name,				\
>  }
>  
> +#define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _name, _events)	\
> +{								\
> +	.type = IIO_TEMP,					\
> +	.indexed = 1,						\
> +	.address = _address,					\
> +	.channel = _chan,					\
> +	.event_spec = _events,					\
> +	.num_event_specs = ARRAY_SIZE(_events),			\
> +	.datasheet_name = _name,				\
> +}
> +
> +enum sysmon_alarm_bit {
> +	SYSMON_BIT_ALARM0 = 0,
> +	SYSMON_BIT_ALARM1 = 1,
> +	SYSMON_BIT_ALARM2 = 2,
> +	SYSMON_BIT_ALARM3 = 3,
> +	SYSMON_BIT_ALARM4 = 4,
> +	SYSMON_BIT_OT = 8,
> +	SYSMON_BIT_TEMP = 9,
> +};

>  /* Static temperature channels (always present) */
> -static const struct iio_chan_spec temp_channels[] = {
> +static const struct iio_chan_spec temp_channels_no_events[] = {
>  	SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
>  	SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
>  	SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
>  	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
>  };
>  
> +/* Static temperature channels with event support (when IRQ available) */
> +static const struct iio_chan_spec temp_channels_with_events[] = {
> +	SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
> +	SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
> +	SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
> +	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
> +	SYSMON_CHAN_TEMP_EVENT(4, SYSMON_ADDR_TEMP_EVENT, "temp",
> +			      sysmon_temp_events),
Is this not an event on channel 0?  Why does it need a separate one?
> +	SYSMON_CHAN_TEMP_EVENT(5, SYSMON_ADDR_OT_EVENT, "ot",

Why two separate channels for events? Are we dealing with two separate
events on the same signal? Generally we don't support that for IIO because
it's largely meaningless except in hwmon usecases - what is the point in two
thresholds if they are reported through the same path?  Just use one and update
it if you want to add another level of detection.

> +			      sysmon_temp_events),
> +};

> +
> +static int sysmon_read_event_config(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir)
> +{
> +	u32 alarm_event_mask = sysmon_get_event_mask(chan->address);
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int imr;
> +	int config_value;
> +	int ret;
> +
> +	ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
> +	if (ret)
> +		return ret;
> +
> +	/* IMR bits are 1=masked, invert to get 1=enabled */
> +	imr = ~imr;
> +
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		config_value = sysmon_read_alarm_config(sysmon, chan->address);
> +		if (config_value < 0)
> +			return config_value;
> +		return config_value && (imr & alarm_event_mask);
> +
> +	case IIO_TEMP:
> +		return !!(imr & alarm_event_mask);

Sashiko made a perhaps insightful observation here.  When the interrupt
is masked between sending an event and the worker reenabling it does
this give an unexpected value to userspace?  I think that condition
we'd kind of expect this to return 0.
https://sashiko.dev/#/patchset/20260611222738.2035062-1-salih.erim%40amd.com

I think the rest of the feedback is probably false positives or debatable
stuff but this one rang true. Please do take a look at the other stuff
as I may have missed something (maybe the comment about needing to disable
event interrupt generation is true?)

> +
> +	default:
> +		return -EINVAL;
> +	}




> +	

