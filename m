Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19EB3E7145;
	Mon,  4 May 2026 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916666; cv=none; b=lOJLGutuEwudETstNdTqX5uCNW7iddD5R3jcj+/wkvlyRrpnlIiEr/euZnKZgO+zbtYoMzx1Sp5LQTKUyI7T03aSwW4xBxSGTdS44XUJWXaGKY4+8QO4xyUlwlqfkh5JKDkXrzrb6DxOo+1a+s3H5FS7JHRxmCehldOl4BS10a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916666; c=relaxed/simple;
	bh=lAE33L4SBAL04KBWBPn8XrtNmFuqdqZRS8edpVpz8lw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSIRpi4Sby7a+z+a8g8XOK+vy1M7m4b5IRa6CQyYoBXGZaKj9WxjlbX/z/ESXwi0l7o9QkyFueqHYdyg1nFsWuw5c/6bd0f3+5qKXcPIEAE/CsLB1ums6VYOlNUOX9FOCa1Ihbnxfvwl5l8Wvn3hMkj9/mp4PhEFfLqDdoCEbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkTiNQib; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkTiNQib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1F3C2BCB8;
	Mon,  4 May 2026 17:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777916666;
	bh=lAE33L4SBAL04KBWBPn8XrtNmFuqdqZRS8edpVpz8lw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SkTiNQibA+I2sTuELpGZXbcTOXcbR8hYqS0n28C1amRl+XuWV6JMdaJe2QwElv1QD
	 Q68nYkFSIIfrzum9M9zAShe/ejfhUBGU6OwEO9zibzuu/ndgIQPyamDVnw0OKQ7hcG
	 i2SLWClrK4byIOa6dh8ZU1msJ5leNNXQTzH5QlcFfhRhNo+qPHshICH2wub7kgt8uT
	 GylrtjYW+Td3ADfs58zWVCIQQT9vZ5xAd/CtaseuDtEV/O9oea7IjUClMsrh67b6or
	 EZ7cqmqjNGdRuRQFE+ZlXcquNEF+vaiOeyS7173yM5oeCmOx6BRVQV+AgcFyGz8N3U
	 ekYRoHAKz9MPQ==
Date: Mon, 4 May 2026 18:44:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <git@amd.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <dlechner@baylibre.com>, <michal.simek@amd.com>, <conall.ogriofa@amd.com>,
 <erimsalih@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] iio: adc: versal-sysmon: add threshold event
 support
Message-ID: <20260504184415.7b6688f5@jic23-huawei>
In-Reply-To: <20260502111951.538488-5-salih.erim@amd.com>
References: <20260502111951.538488-1-salih.erim@amd.com>
	<20260502111951.538488-5-salih.erim@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 May 2026 12:19:50 +0100
Salih Erim <salih.erim@amd.com> wrote:

> Add threshold event support for temperature and supply voltage
> channels.
> 
> Temperature events:
>   - Rising/falling threshold with configurable values
>   - Over-temperature (OT) alarm with separate thresholds
>   - Per-channel hysteresis configuration
> 
> Supply voltage events:
>   - Rising/falling threshold per supply channel
>   - Per-channel alarm enable via alarm configuration registers
> 
> The interrupt handler masks active threshold interrupts (which are
> level-sensitive) and schedules a delayed worker to poll for condition
> clear before unmasking. When no hardware IRQ is available (irq <= 0),
> event channels are not created and interrupt init is skipped, since
> the I2C regmap backend cannot be called from atomic context.
> 
> When disabling a supply channel alarm, the group interrupt remains
> active if any other channel in the same alarm group still has an
> alarm enabled.
> 
> Named constants replace magic numbers for hysteresis bit positions
> (SYSMON_OT_HYST_BIT, SYSMON_TEMP_HYST_BIT) and alarm register width
> (SYSMON_ALARM_BITS_PER_REG).
> 
> Hysteresis values are validated to single-bit range (0 or 1) before
> writing to the hardware register.
> 
> Signed-off-by: Salih Erim <salih.erim@amd.com>
A few minor comments inline to add to what Andy found.

>  drivers/iio/adc/versal-sysmon-core.c | 539 ++++++++++++++++++++++++++-
>  drivers/iio/adc/versal-sysmon.h      |  36 ++
>  2 files changed, 574 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> index 37736c2900b..857fe21db7a 100644
> --- a/drivers/iio/adc/versal-sysmon-core.c
> +++ b/drivers/iio/adc/versal-sysmon-core.c

>  
> +/* OT and TEMP hysteresis bit positions in SYSMON_TEMP_EV_CFG */
> +#define SYSMON_OT_HYST_BIT		BIT(0)
> +#define SYSMON_TEMP_HYST_BIT		BIT(1)

You use a mix of these defines and manual shift.  Use FIELD_GET()
/FIELD_PREP() to avoid that.
>  
> +#define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _ext, _events) {	\
> +	.type = IIO_TEMP,					\
> +	.indexed = 1,						\
> +	.address = _address,					\
> +	.channel = _chan,					\
> +	.event_spec = _events,					\
> +	.num_event_specs = ARRAY_SIZE(_events),			\
> +	.scan_type = {						\
> +		.sign = 's',					\
> +		.realbits = 15,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_CPU,				\
> +	},							\
> +	.datasheet_name = _ext,					\

As before - consider renaming this.

> +}

> +
> +static int sysmon_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info, int *val,
> +				   int *val2)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	u32 mask, shift;
> +	int offset;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	if (chan->type == IIO_TEMP) {
> +		if (info == IIO_EV_INFO_VALUE) {
> +			offset = sysmon_temp_thresh_offset(chan->address, dir);
> +			if (offset < 0)
> +				return offset;
> +			ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +			if (ret)
> +				return ret;
> +			sysmon_q8p7_to_millicelsius(reg_val, val);
> +			return IIO_VAL_INT;
> +		}
> +		if (info == IIO_EV_INFO_HYSTERESIS) {
> +			mask = (chan->address == SYSMON_ADDR_OT_EVENT) ?
> +				SYSMON_OT_HYST_BIT : SYSMON_TEMP_HYST_BIT;

Not a massive amount of sharing for OT_EVENT vs others. Maybe just split it
and then you can use FIELD_GET() and get shift handling included via the mask.

			ret = regmap_read(sysmon->regmap, SYSMON_TEMP_EV_CFG,
				  	  &reg_val);
			if (ret)
				return ret;
			if (chan->addres == SYSMBO_ADDR_OT_EVENT) {
				*val = FIELD_GET(SYSMON_OT_HYST_BIT, reg_val);
			else
				*val = FIELD_GET(YSMON_TEMP_HYST_BIT, reg_val);



> +			*val = (reg_val & mask) >> shift;
			}
> +			shift = (chan->address == SYSMON_ADDR_OT_EVENT) ? 0 : 1;
> +			ret = regmap_read(sysmon->regmap, SYSMON_TEMP_EV_CFG,
> +					  &reg_val);
> +			if (ret)
> +				return ret;
> +			*val = (reg_val & mask) >> shift;
> +			return IIO_VAL_INT;
> +		}

> +
> +static int sysmon_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int val, int val2)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	u32 mask, shift;
> +	u32 raw_val;
> +	int offset;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	if (chan->type == IIO_TEMP) {
> +		if (info == IIO_EV_INFO_VALUE) {
> +			offset = sysmon_temp_thresh_offset(chan->address, dir);
> +			if (offset < 0)
> +				return offset;
> +			sysmon_millicelsius_to_q8p7(&raw_val, val);
> +			return regmap_write(sysmon->regmap, offset, raw_val);
> +		}
> +		if (info == IIO_EV_INFO_HYSTERESIS) {
> +			mask = (chan->address == SYSMON_ADDR_OT_EVENT) ?
> +				SYSMON_OT_HYST_BIT : SYSMON_TEMP_HYST_BIT;
> +			shift = (chan->address == SYSMON_ADDR_OT_EVENT) ? 0 : 1;
> +			if (val & ~1)

Just to confirm - this only has hysteresis values of 0 or 1?  That's unusually
small given hysteresis should be in same units as _raw.

Also similar to above, I'd split the two cases and use FIELD_PREP()

> +				return -EINVAL;
> +			return regmap_update_bits(sysmon->regmap,
> +						  SYSMON_TEMP_EV_CFG,
> +						  mask, val << shift);
> +		}
> +	} else if (chan->type == IIO_VOLTAGE) {
> +		offset = sysmon_supply_thresh_offset(chan->address, dir);
> +		if (offset < 0)
> +			return offset;
> +		ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +		if (ret)
> +			return ret;
> +		sysmon_supply_processedtoraw(val, reg_val, &raw_val);
> +		return regmap_write(sysmon->regmap, offset, raw_val);
> +	}
> +
> +	return -EINVAL;
> +}


