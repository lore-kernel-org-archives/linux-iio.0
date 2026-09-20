Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA552139C9;
	Sun, 20 Sep 2026 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789869840; cv=none; b=JglJo27SFZ8SJWz/OAygObpbTnCT2TLWUU7v3Qyk0PoPdZWTjMbmmBT8lniKteHzo0RMsgqTSmM8wKzt6vj28pOdD9y0tfhBqrYbaBz9nFZTMOlB/jhh7lNq4Qe0G+wOk36+t4ft+tmdkt47RtKMPyLd1vNbx0bSru001XTBZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789869840; c=relaxed/simple;
	bh=PwVVYV4JEx/0Ve75abmdYMHHwrig3Ha1HpjqxDoEcWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyOlGXE2ReTtQHoFYSn6bNgqdFApGcz+0pqCWdQIQP6sXN+oJeYULLLTPdJgIfWi7pXfNq3o+BVAijS2tYg2DcnaRYwcXPI7ET8TkqazO6XOk+RkyFQLnVonf/UTsmY4p4/+WLSgvTblsbd2LjGwKB/PdSMZ5hTeQTgWfyDzCIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAq/C/R0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAq/C/R0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A551F00893;
	Sun, 20 Sep 2026 02:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789869838;
	bh=X9N4VoDKYV4KaRtg0FDgOvzdsIFsiYYCVYCWida5uF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GAq/C/R07e438NhKogWpebxC5aBzem2qlBeArf+KtMUu9bADSfOk5wQjOu/2R+6Bz
	 uiB3znfHvVNqZ73kx4iEo4W7p3t82gE30SnYg6Swwqe10w5NNhX5Mak4z3RoPoENUU
	 rOL7glhq/mjfTgRsnY4QK9mOGIOX0IzfnTMSc3ywA+4liQ9Jmx/n7SKoB0kJLHMhtF
	 6l3sHjWZpUUNbmlUANVFE0nOVYb9Bo82sZ78JBCT+Vy6GCyVQW6Mn8+LYwGZyYETaO
	 xScFWAW1Ajz4aL03SXKeBOPBHQpCkrZ/FY4ZLDr5PNDl3rABewsvg45Ayew8PF+tsa
	 EYJ2rR+8iwtGA==
Date: Sun, 20 Sep 2026 03:03:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, joshua.crofts1@gmail.com,
 u.kleine-koenig@baylibre.com, julianbraha@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 6/8] iio: osf: add IIO devices from capability
 reports
Message-ID: <20260920030352.62526119@jic23-hlaptop>
In-Reply-To: <c88d0ced0bff5cf29e765cd2c280ce3c10c50988.1789753020.git.kimjinseob88@gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
	<c88d0ced0bff5cf29e765cd2c280ce3c10c50988.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 03:24:44 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Register IIO devices from supported capability descriptors and expose
> signed raw samples, descriptor scales and software buffers. Keep early
> capabilities owned by the core until UART and supply setup is complete,
> and unregister children after the receive producer has stopped.
> 
> Validate nonzero descriptor scales and sample/descriptor equality, leave
> discovery open after empty or unsupported inventories, and compare
> repeated descriptors independently of order. Fault a bound session if a
> descriptor changes meaning, gating cache and buffer publication together.
> 
> Add initialized active-scan packing and buffer producer quiescence. The
> production implementation is now complete; subsequent patches only add
> the existing core and IIO KUnit suites and their build wiring.

No need to talk about what other patches do and that a series is functionally
complete in a patch. If you want to do it, under the --- so it doesn't end
up in the git log.

> 
> Assisted-by: LLM
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>

A few things inline.  Biggest one is a question (I'm not sure) on
whether you can use a claim on buffered mode (which will hold it in that
if it succeeds until released) is sufficient to replace the extra lock you
have to block that transition. 

Thanks,

Jonathan



> diff --git a/drivers/iio/opensensorfusion/osf_iio.c b/drivers/iio/opensensorfusion/osf_iio.c
> new file mode 100644
> index 000000000000..f4011b8fae14
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_iio.c
...

> +
> +struct osf_iio_scan_3axis {
> +	s32 values[3];
> +	u32 padding;
No needed unless you explicitly write into padding for some reason.
C rules add it anyway and then we don't need to make sure it remains
correct if this structure changes in future.
> +	aligned_s64 timestamp;
> +};
> +
> +struct osf_iio_scan_1axis {
> +	s32 value;
> +	u32 padding;
As above, unneeded.
> +	aligned_s64 timestamp;
> +};

Given I think these are only used in one place, moving them to there would
avoid need for named structure types.

> +
> +#define OSF_MOD_CHAN(_type, _mod, _idx)				\
> +	{								\
> +		.type = (_type),					\
> +		.modified = 1,						\
> +		.channel2 = (_mod),					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_index = (_idx),					\
> +		.scan_type = {						\
> +			.sign = 's',					\
> +			.realbits = 32,					\
> +			.storagebits = 32,				\
> +			.endianness = IIO_CPU,				\
> +		},							\
> +	}
> +
> +#define OSF_CHAN(_type, _idx)					\

Given this is not much used, you could use the IIO_NO_MOD modifier as a gate
on setting .modified = (_mod != IIO_NO_MOD) ? 1 : 0,
and have just one macro.

> +	{								\
> +		.type = (_type),					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_index = (_idx),					\
> +		.scan_type = {						\
> +			.sign = 's',					\
> +			.realbits = 32,					\
> +			.storagebits = 32,				\
> +			.endianness = IIO_CPU,				\
> +		},							\
> +	}
> +
> +static const struct iio_chan_spec osf_accel_channels[] = {
> +	OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_X, 0),
> +	OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_Y, 1),
> +	OSF_MOD_CHAN(IIO_ACCEL, IIO_MOD_Z, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static const struct iio_chan_spec osf_gyro_channels[] = {
> +	OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_X, 0),
> +	OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, 1),
> +	OSF_MOD_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static const struct iio_chan_spec osf_mag_channels[] = {
> +	OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_X, 0),
> +	OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_Y, 1),
> +	OSF_MOD_CHAN(IIO_MAGN, IIO_MOD_Z, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static const struct iio_chan_spec osf_temp_channels[] = {
> +	OSF_CHAN(IIO_TEMP, 0),
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +
> +static const struct osf_iio_sensor_spec osf_iio_sensor_specs[] = {
> +	{
> +		.sensor_type = OSF_SENSOR_ACCELEROMETER,
> +		.channel_count = 3,
> +		.name = "osf-accel",
> +		.channels = osf_accel_channels,
> +		.num_channels = ARRAY_SIZE(osf_accel_channels),
> +	},
> +	{
> +		.sensor_type = OSF_SENSOR_GYROSCOPE,
> +		.channel_count = 3,
> +		.name = "osf-gyro",
> +		.channels = osf_gyro_channels,
> +		.num_channels = ARRAY_SIZE(osf_gyro_channels),
> +	},
> +	{
> +		.sensor_type = OSF_SENSOR_MAGNETOMETER,
> +		.channel_count = 3,
> +		.name = "osf-magn",
> +		.channels = osf_mag_channels,
> +		.num_channels = ARRAY_SIZE(osf_mag_channels),
> +	},
> +	{
> +		.sensor_type = OSF_SENSOR_TEMPERATURE,
> +		.channel_count = 1,
> +		.name = "osf-temp",
> +		.channels = osf_temp_channels,
> +		.num_channels = ARRAY_SIZE(osf_temp_channels),
> +	},
> +};
> +
> +static const struct osf_iio_sensor_spec *
> +osf_iio_find_sensor_spec(u16 sensor_type, u16 channel_count)
> +{
> +	for (unsigned int i = 0; i < ARRAY_SIZE(osf_iio_sensor_specs); i++) {
> +		if (osf_iio_sensor_specs[i].sensor_type == sensor_type &&
> +		    osf_iio_sensor_specs[i].channel_count == channel_count)
> +			return &osf_iio_sensor_specs[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +bool osf_iio_sensor_supported(u16 sensor_type, u16 channel_count)
> +{
> +	if (osf_iio_find_sensor_spec(sensor_type, channel_count))
> +		return true;
> +
> +	return false

	return osf_iio_find_sensor_spec(sensor_type, channel_count) != NULL;

> +}

> +
> +static int osf_iio_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct osf_iio_state *state = iio_priv(indio_dev);
> +
> +	guard(mutex)(&state->buffer_lock);

These transistions are already guarded by the core, so see the question later
on whether you can just claim buffered mode in the data handler
to avoid the need for this. That might not work but the way you did
this got me thinking about a more general solution to the problem.

> +	state->buffer_active = true;
> +
> +	return 0;
> +}
> +
> +static int osf_iio_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct osf_iio_state *state = iio_priv(indio_dev);
> +
> +	/* Wait for the current push before the IIO core changes its buffers. */
> +	guard(mutex)(&state->buffer_lock);
> +	state->buffer_active = false;
> +
> +	return 0;
> +}


> +
> +int osf_iio_push_sample(struct iio_dev *indio_dev, const s32 *values,
> +			u16 channel_count)
> +{
> +	struct osf_iio_state *state = iio_priv(indio_dev);
> +	s64 timestamp;
> +
> +	if (channel_count != state->spec->channel_count)
> +		return -EPROTO;
> +
> +	guard(mutex)(&state->buffer_lock);

Using an extra lock is one solution I suppose to the risk
of this racing with the buffer tear down and the problems
around active_scan_mask being freed. Could you use

	if (iio_device_try_claim_buffer_mode(indio_dev))
and later a release on that to achieve the same result?

Only the ade9000 is doing similar at the moment so would need
some testing to make sure no lock inversions occur in general
but given you don't take any other locks in here it should be fine.


> +	if (!state->buffer_active || !iio_buffer_enabled(indio_dev))
> +		return 0;
> +
> +	timestamp = iio_get_time_ns(indio_dev);
> +
> +	switch (channel_count) {
> +	case 1: {
> +		struct osf_iio_scan_1axis scan = {
> +			.value = values[0],
> +		};
As suggested above, this structure type is only used locally here. So
make the definition local as well.
		struct {
			s32 value;
			aligned_s64 timestamp;
		} scan = { };

> +
> +		return iio_push_to_buffers_with_ts(indio_dev, &scan,
> +						   sizeof(scan), timestamp);
> +	}
> +	case 3: {
> +		struct osf_iio_scan_3axis scan = {
> +			.values = { },

Setting values doesn't add anything useful as = { } 
zeros the whole structure (including any holes - they kernel is
built with specific compiler options to ensure that last bit
as it wasn't required in older c specs).

> +		};
> +		unsigned int channel, index = 0;

Please split declarations that assign and ones that don't on to separate lines.
Ends up a little more readable.
		unsigned int index = 0;
		unsigned int channel;

> +
> +		/* Pack the active channels; unused storage remains initialized. */
> +		for_each_set_bit(channel, indio_dev->active_scan_mask, channel_count)
> +			scan.values[index++] = values[channel];
> +
> +		return iio_push_to_buffers_with_ts(indio_dev, &scan,
> +						   sizeof(scan), timestamp);
> +	}
> +	default:
> +		return -EPROTO;
> +	}
> +}

> diff --git a/drivers/iio/opensensorfusion/osf_serdev.c b/drivers/iio/opensensorfusion/osf_serdev.c
> index 8a747c01ff9d..3d5e90d83967 100644
> --- a/drivers/iio/opensensorfusion/osf_serdev.c
> +++ b/drivers/iio/opensensorfusion/osf_serdev.c
> @@ -23,7 +23,7 @@ struct osf_serdev {
>  	bool vcc_enabled;
>  	struct osf_device osf;
>  	struct osf_stream stream;
> -	/* Protects the parser and all RX counters. */
> +	/* Protects the parser, all RX counters, and the registration gate. */
>  	struct mutex rx_lock;

Just name it 'lock' given it has scope beyond rx.  Do that in earlier patch
though rather than changing it here.

>  };

>  
> @@ -139,5 +144,5 @@ static struct serdev_device_driver osf_serdev_driver = {
>  };
>  module_serdev_device_driver(osf_serdev_driver);
>  
> -MODULE_DESCRIPTION("Open Sensor Fusion UART receiver");
> +MODULE_DESCRIPTION("Open Sensor Fusion IIO driver");

Just have that being slightly missleading in earlier patch to reduce churn here.

>  MODULE_LICENSE("GPL");

