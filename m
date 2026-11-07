Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794014739;
	b=v5tnWmvJdn6dhNI9eBi7t29n0ZcLun7291fTTLH1+tjHlozUxS0f1y/LMmBq6bOeXSPJ
	 iNYf5yLJrMcul9Dr78zOp7UPIrRMTp9Yr8gcRt2wUijr38QTQ0s1Bwv57n8FZ2o1BNU8I
	 zxY0Bp5npTuaCvvNep+PFfvFY3X+Ik5XE+xF0Z/2wnQJjaLnBRrYZHD3IVdWgtHKxSMrV
	 NHAFaYOj6CIjw3HLHP9Mb1jw9MWwj+4II6Z9XfyGLJfHAXcK8EYMrAqc8lqH89Jmw32iz
	 DjqiBF9T2JVK39lB6TU1IpUe7G73eOo7X/nLvOMN8nU633QbUXNRJawLaDEAdcfFXgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794014739;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FDY5tdml7OFZfUMcUlARF5HMB401e/zIkvAhiB4/124=;
	b=CIPuiUxZ5N+tZw+Tq8EiceIg+QQDOvUXrmzdPA3rmBSSxvlpLdDXVhnWjfJmyqr3g8kc
	 KWZpN8SJSQ5MZbNVxy9lOL6HhJHY//FRhUql6EM7QLW9bZqZQFy7AGMkctKFnPK25KHKo
	 pii+RN7aj+wHp8xAT4wM9Ht9MJm0756QJFGtktHbSOjuCaf06gjXrER1p77YyiPPrnEoJ
	 c3Pv29ybap87MeQQDx8/a2DFhbOSopKw66DC9D/EZCBIytV5nfhxVk/bkxbHfSeaQSs4r
	 1m0huPsj41NXorx0tEopj+Ldmde5b++aSQtq/exSlDh9KYcSsE7i2W4YtFJ2qmCBHBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="md/beg28";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981EB606A326;
	Sat,  7 Nov 2026 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=md/beg28
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2261F008A1;
	Sat,  7 Nov 2026 01:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794014738;
	bh=FDY5tdml7OFZfUMcUlARF5HMB401e/zIkvAhiB4/124=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=md/beg28WI1E7C9vSL0aMljiYrx5XXp1VmvBWxU44a/bZnVU+mLtxGPV8Y3U6UPoe
	 0X6fKr/QaT0TCnwKVjkhnGv4uCRWCw/6w/u12l3CTZ4N6+yRLxGwMCQFgyNQZSrPPy
	 bT1+wbGefX8DkB4u+E4Gg1om0sBd8CHRznfCpywoirkdpTfAue7wd2XlRqUmT1em3K
	 yPJQgYByZ+ppP3ruDDJIwlJBUZ+qgFbk2u0ornyzxM8284ENAajzA+kJ5ihfUSY0S5
	 C7r4kwmFQLUHfdghzYFmtIFuINNPRIzdyBs9BiJvstgGG3ievv47IE1/G8zocpsO0y
	 kXDsCF/I1toJQ==
Date: Sat, 7 Nov 2026 01:25:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Balint <dbalint@google.com>
Cc: Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, Tzung-Bi
 Shih <tzungbi@kernel.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iio: adc: add cros_ec_pwrmon driver
Message-ID: <20261107012530.503f1589@jic23-hlaptop>
In-Reply-To: <20261106193129.43493-3-dbalint@google.com>
References: <20261106193129.43493-1-dbalint@google.com>
	<20261106193129.43493-3-dbalint@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Nov 2026 19:31:16 +0000
Daniel Balint <dbalint@google.com> wrote:

> Add the ChromeOS EC On-Device Power Monitoring (ODPM) driver to read
> onboard power-monitoring ADCs (such as PAC194x) wired through the EC.
> 
> The driver interfaces with the EC via the existing EC_CMD_PWRMON host
> command API and EC_MKBP_EVENT_PWRMON events to start/stop accumulation,
> latch ADC accumulators, and expose cumulative per-rail energy in
> microjoules (uWs) through the energy_value sysfs attribute.
> 
> Signed-off-by: Daniel Balint <dbalint@google.com>
Hi Daniel

Main comment here is the custom ABI.  It doesn't comply with sysfs
conventions or the IIO ABI.  For this sort of capture lots at the
same time we have the IIO chardev 'buffer' interface.

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-cros-ec         |  13 +
>  MAINTAINERS                                   |   7 +
>  drivers/iio/adc/Kconfig                       |  11 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/cros_ec_pwrmon.c              | 333 ++++++++++++++++++
>  5 files changed, 365 insertions(+)
>  create mode 100644 drivers/iio/adc/cros_ec_pwrmon.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> index 3de1dfc98389..9043824f2831 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> @@ -19,3 +19,16 @@ Description:
>  		represents the sensor ID as exposed by the EC. This ID is used
>  		by the Android sensor service hardware abstraction layer (sensor
>  		HAL) through the Android container on ChromeOS.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/energy_value

Why custom ABI? 

If you need a multi channel snapshot, use buffered IIO interface.
That should give you a nice binary representation of this will
sysfs description of data backing etc.  Hook it up to a sysfs
trigger if you want to have userspace request a capture on demand.

As a general rule, multi value sysfs attributes are frowned upon.
Occasionally we justify them as a group of numbers that are one
value (quaternions for instance) but this one doesn't
fit that pattern.

> +Date:		November 2026
> +KernelVersion:	7.5
> +Contact:	chrome-platform@lists.linux.dev, linux-iio@vger.kernel.org
> +Description:
> +		This read-only attribute is exposed by the ChromeOS EC power
> +		monitor (cros_ec_pwrmon) driver for On-Device Power Monitoring
> +		(ODPM). Reading it latches all EC power accumulators and returns
> +		a snapshot timestamp followed by per-channel accumulated energy:
> +
> +		t=<Measurement timestamp in ms since boot>
> +		CH<N>(T=<Duration in ms>)[<Rail schematic name>], <Accumulated energy in uWs>

> diff --git a/drivers/iio/adc/cros_ec_pwrmon.c b/drivers/iio/adc/cros_ec_pwrmon.c
> new file mode 100644
> index 000000000000..795b5f2b2a2c
> --- /dev/null
> +++ b/drivers/iio/adc/cros_ec_pwrmon.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ChromeOS EC Power Monitor Driver
> + *
> + * Copyright (c) 2026 Google Inc.
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/ktime.h>
> +#include <linux/math64.h>
> +#include <linux/mod_devicetable.h>

Shouldn't see that in a new driver.  The finer grained tables
structure defs in linux/device-id are included directly by
the relevant bus.  Here platform_device.h has it.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>
> +#include <linux/wait.h>

> +
> +static void cros_ec_pwrmon_unregister_notifier(void *data)
> +{
> +	struct cros_ec_pwrmon_state *st = data;
> +
> +	blocking_notifier_chain_unregister(&st->ec->event_notifier,
> +					   &st->notifier);
> +}
> +
> +static int cros_ec_pwrmon_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
> +	struct cros_ec_pwrmon_state *st;
> +	struct ec_params_pwrmon *params;
> +	struct pwrmon_dump_info *dump;
> +	struct iio_dev *indio_dev;
> +	size_t msg_size;
> +	int ret, i;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->ec_dev = ec_dev;
> +	st->ec = ec_dev->ec_dev;

That's somewhat confusing naming wise!  Why do we need both of them?

> +
> +	spin_lock_init(&st->event_lock);
> +	init_waitqueue_head(&st->wq);
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	msg_size = sizeof(*st->msg) + max(sizeof(struct ec_params_pwrmon),

Given you immediately assign params to this, sizeof(*params)
would be nicer.

> +					  sizeof(struct ec_response_pwrmon));

It is a bit of an unusual case but I'd use struct_size() here as it has
a trailing u8 data[] into which you are putting the union of those two structures.
 
> +	st->msg = devm_kzalloc(dev, msg_size, GFP_KERNEL);
> +	if (!st->msg)
> +		return -ENOMEM;
> +
> +	st->msg->version = 0;
> +	st->msg->command = EC_CMD_PWRMON + st->ec_dev->cmd_offset;
> +	params = (struct ec_params_pwrmon *)st->msg->data;
> +	st->msg->outsize = sizeof(*params);
> +	st->msg->insize = sizeof(struct ec_response_pwrmon);
> +
> +	/* Start PACs */
> +	params->cmd = EC_PWRMON_START;
> +	ret = cros_ec_cmd_xfer_status(st->ec, st->msg);
> +	if (ret < 0) {
> +		dev_warn(dev, "Failed to start PACs: %d\n", ret);

Error out of probe?  Use

		return dev_err_probe();

> +		return ret;
> +	}
> +	st->last_time_ms = ktime_to_ms(ktime_get_boottime());
> +
> +	ret = devm_add_action_or_reset(dev, cros_ec_pwrmon_stop, st);
> +	if (ret)
> +		return ret;
> +
> +	/* Get Channel Count */
> +	params->cmd = EC_PWRMON_GET_CHANNEL_COUNT;
> +	ret = cros_ec_cmd_xfer_status(st->ec, st->msg);
> +	if (ret < 0) {
> +		dev_warn(dev, "Failed to get channel count: %d\n", ret);
> +		return ret;

return dev_err_probe()

> +	}
> +	st->num_channels = ((struct ec_response_pwrmon *)st->msg->data)->channel_count;

Use a local variable rather than cast. Added bonus is you can use it for sizing the
storage above rather.

> +	if (st->num_channels > PWRMON_MAX_CHANNELS)
> +		st->num_channels = PWRMON_MAX_CHANNELS;

	st->num_channels = min(st->num_channels, PWRMON_MAX_CHANNELS);

> +
> +	st->accumulated_energy = devm_kcalloc(dev, st->num_channels,
> +					      sizeof(*st->accumulated_energy),
> +					      GFP_KERNEL);
> +	st->channel_names = devm_kcalloc(dev, st->num_channels,
> +					 sizeof(*st->channel_names),
> +					 GFP_KERNEL);
> +	if (!st->accumulated_energy || !st->channel_names)
> +		return -ENOMEM;
> +
> +	/* Get Dump Info (Names) */
> +	for (i = 0; i < st->num_channels; i++) {

	for (unsigned int i = 0; ...
as might as well keep it locally scoped.


> +		params->cmd = EC_PWRMON_DUMP_INFO;
> +		params->channel_id = i;
> +		ret = cros_ec_cmd_xfer_status(st->ec, st->msg);
> +		if (ret < 0) {
> +			dev_warn(dev, "Failed to get dump info for channel %d: %d\n",
> +				 i, ret);
> +			continue;
> +		}
> +		dump = &((struct ec_response_pwrmon *)st->msg->data)->dump_info;

As above, local variable seems more appropriate.

> +		strscpy(st->channel_names[i], dump->channel_name,
> +			sizeof(st->channel_names[i]));
> +	}
> +
> +	indio_dev->name = dev_name(dev);

Generally we want a part number for dev name. What does this end up as here?
Often it is better to hard code them.

> +	indio_dev->info = &cros_ec_pwrmon_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/* Register MKBP event notifier */
> +	st->notifier.notifier_call = cros_ec_pwrmon_notify;
> +	ret = blocking_notifier_chain_register(&st->ec->event_notifier,
> +					       &st->notifier);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to register notifier: %d\n", ret);
> +		return ret;

return dev_err_probe()

> +	}
> +
> +	ret = devm_add_action_or_reset(dev, cros_ec_pwrmon_unregister_notifier,
> +				       st);

This one has annoyed me before so maybe not really an ask for you to fix
but it would be nice to just have a devm_blocking _notifier_chain_register()
that would stash both parameters needed for the unregister.

> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct platform_device_id cros_ec_pwrmon_id[] = {
> +	{ "cros-ec-pwrmon", 0 },
Named initializers for these.  This is slowly getting tidied
up across the kernel. Not using the named fields makes certain
types of refactor trickier to do.  Don't set the 0 though
as that's what C will fill in anyway and for now there is no
use of that value.
> +	{}
	{ }

That one is a trivial IIO style preference.  We ended up standardizing
that a few years back in the interests of consistency and the choice
was with the space (there was no strong reason to go one way or the other!)

Jonathan

