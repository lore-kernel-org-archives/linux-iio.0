Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DCEE54B;
	Sun,  1 Mar 2026 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772368987; cv=none; b=gZvau944UfkBDl/2DCAAerEmYLv9RyEnqhUfTG+Aplrk8AD6o/AI8hmP5I8GrtU69RpPlWH3D8mphxTyiWFG7XUwPj5N0e2APzCRsjuRqkaLdsLBoVZmDrp2cU5TLKvGYOhVJo5kg/Y8aXVPPsBAh4eGAc+4pgM7P3mQlZfohUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772368987; c=relaxed/simple;
	bh=KqMDNZZBOjEU9MW+8ad7x7FbhLclAWduVG1usCGTNl0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoDZR2Tr9MIJZOKFs1aFDw8F6Di1uKu15ATB51l9VNni9SWzT9H2lZjE8YDpnNeD5LxzJTUyldIBgxJYGdSNeO14BWMcnoCLThk5ejvxTLqnhXPU2ch1CWyFElEYSN097jrkwG/raj1vPanxA+qdUEenrxAwkt41TPbzogiZxyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRxe/Wpw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRxe/Wpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F96C116C6;
	Sun,  1 Mar 2026 12:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772368986;
	bh=KqMDNZZBOjEU9MW+8ad7x7FbhLclAWduVG1usCGTNl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZRxe/Wpwf2RFAtCFiPqlKcoaxNK5qNW09dmCxfUZ5pPQqWqpaw2CNnztvYOpp5y5I
	 nzVqhdJz59RW5hwONLNvAz7nKuNmSpvhi2ydd+v9/ZMIvvnLNpWcMLScsH6jUxaLRB
	 zLSMg5ixf2INC9oSDh1HeYjoR1X3Jk4kaY868dHjTPF5oyIz43a5IURydRqOKIp3g8
	 wyyuADoUK91jsR+wGdcxYeDxHW4eMkyYXRqVXclXwLZudkp2UmX3EY7u017D1aK2kk
	 dPSI9ysX/ouU4IJPsUk4DkyqqnoHF5kxW677IO29tdfnZy4e6EOFCQ7C+OdR7vTpWB
	 FSZdwPguVtpzg==
Date: Sun, 1 Mar 2026 12:42:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, bigeasy@linutronix.de, spasswolf@web.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: hid-sensors: Use software trigger
Message-ID: <20260301124258.060a8276@jic23-huawei>
In-Reply-To: <20260220224514.471348-1-srinivas.pandruvada@linux.intel.com>
References: <20260220224514.471348-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 14:45:14 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> Recent changes linux mainline resulted in warning:
> "genirq: Warn about using IRQF_ONESHOT without a threaded handler"
> when HID sensor hub is used.
> 
> When INDIO_BUFFER_TRIGGERED is used, the core attaches a poll function
> when enabling the buffer. This poll function uses request_threaded_irq()
> with both bottom half and top half handlers. But when using HID
> sensor hub, bottom half (thread handler) is not registered.
> 
> In HID sensors, once a sensor is powered on, the hub collects samples
> and pushes data to the host when programmed thresholds are met. When
> this data is received for a sensor, it is pushed using
> iio_push_to_buffers_with_ts().
> 
> The sensor is powered ON or OFF based on the trigger callback
> set_trigger_state() when the poll function is attached. During the call
> to iio_triggered_buffer_setup_ext(), the HID sensor specifies only a
> handler function but provides no thread handler, as there is no data
> to read from the hub in thread context. Internally, this results in
> calling request_threaded_irq(). Recent kernel changes now warn when
> request_threaded_irq() is called without a thread handler.
> 
> To address this issue, fundamental changes are required to avoid using
> iio_triggered_buffer_setup_ext(). HID sensors can use
> INDIO_BUFFER_SOFTWARE instead of INDIO_BUFFER_TRIGGERED, as this can
> work in trigger-less mode.
> 
> In this approach, when user space opens the buffer, the sensor is powered
> on, and when the buffer is closed, the sensor is powered off using
> iio_buffer_setup_ops callbacks.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
I think this is fine, but it almost looks like coincidence that where we
introduce a new devm_ call is at the point where the driver moves
from devm to non devm - the only place we can safely swap one for
the other like this.

It might we be worth exploring if the driver can easily make more
use of devm to reduce what we have to manually cleanup.

Anyhow, applied this to the fixes-togreg branch of iio.git.
I haven't given it a fixes tag though as there wasn't really a bug here
just some misuse of interfaces.


> ---
> Changes:
> v2:
> changed 
> indio_dev->modes |= INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
> to 
> indio_dev->modes = INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
> 
> From RFC
> - The trigger alloc and register is still kept as old code with
> additional
> indio_dev->modes |= INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
> 
>  .../common/hid-sensors/hid-sensor-trigger.c   | 48 ++++++++++++-------
>  1 file changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 5540e2d28f4a..417c4ab8c1b2 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -14,6 +14,7 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/kfifo_buf.h>
>  #include "hid-sensor-trigger.h"
>  
>  static ssize_t _hid_sensor_set_report_latency(struct device *dev,
> @@ -202,12 +203,21 @@ static void hid_sensor_set_power_work(struct work_struct *work)
>  		_hid_sensor_power_state(attrb, true);
>  }
>  
> -static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
> -						bool state)
> +static int buffer_postenable(struct iio_dev *indio_dev)
>  {
> -	return hid_sensor_power_state(iio_trigger_get_drvdata(trig), state);
> +	return hid_sensor_power_state(iio_device_get_drvdata(indio_dev), 1);
>  }
>  
> +static int buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	return hid_sensor_power_state(iio_device_get_drvdata(indio_dev), 0);
> +}
> +
> +static const struct iio_buffer_setup_ops hid_sensor_buffer_ops = {
> +	.postenable = buffer_postenable,
> +	.predisable = buffer_predisable,
> +};
> +
>  void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
>  			       struct hid_sensor_common *attrb)
>  {
> @@ -219,14 +229,9 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
>  	cancel_work_sync(&attrb->work);
>  	iio_trigger_unregister(attrb->trigger);
>  	iio_trigger_free(attrb->trigger);
> -	iio_triggered_buffer_cleanup(indio_dev);
>  }
>  EXPORT_SYMBOL_NS(hid_sensor_remove_trigger, "IIO_HID");
>  
> -static const struct iio_trigger_ops hid_sensor_trigger_ops = {
> -	.set_trigger_state = &hid_sensor_data_rdy_trigger_set_state,
> -};
> -
>  int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>  				struct hid_sensor_common *attrb)
>  {
> @@ -239,25 +244,34 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>  	else
>  		fifo_attrs = NULL;
>  
> -	ret = iio_triggered_buffer_setup_ext(indio_dev,
> -					     &iio_pollfunc_store_time, NULL,
> -					     IIO_BUFFER_DIRECTION_IN,
> -					     NULL, fifo_attrs);
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
> +
> +	ret = devm_iio_kfifo_buffer_setup_ext(&indio_dev->dev, indio_dev,
> +					      &hid_sensor_buffer_ops,
> +					      fifo_attrs);
>  	if (ret) {
> -		dev_err(&indio_dev->dev, "Triggered Buffer Setup Failed\n");
> +		dev_err(&indio_dev->dev, "Kfifo Buffer Setup Failed\n");
>  		return ret;
>  	}
>  
> +	/*
> +	 * The current user space in distro "iio-sensor-proxy" is not working in
> +	 * trigerless mode and it expects
> +	 * /sys/bus/iio/devices/iio:device0/trigger/current_trigger.
> +	 * The change replacing iio_triggered_buffer_setup_ext() with
> +	 * devm_iio_kfifo_buffer_setup_ext() will not create attribute without
> +	 * registering a trigger with INDIO_HARDWARE_TRIGGERED.
> +	 * So the below code fragment is still required.
> +	 */
> +
>  	trig = iio_trigger_alloc(indio_dev->dev.parent,
>  				 "%s-dev%d", name, iio_device_id(indio_dev));
>  	if (trig == NULL) {
>  		dev_err(&indio_dev->dev, "Trigger Allocate Failed\n");
> -		ret = -ENOMEM;
> -		goto error_triggered_buffer_cleanup;
> +		return -ENOMEM;
>  	}
>  
>  	iio_trigger_set_drvdata(trig, attrb);
> -	trig->ops = &hid_sensor_trigger_ops;
>  	ret = iio_trigger_register(trig);
>  
>  	if (ret) {
> @@ -284,8 +298,6 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>  	iio_trigger_unregister(trig);
>  error_free_trig:
>  	iio_trigger_free(trig);
> -error_triggered_buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
>  	return ret;
>  }
>  EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID");

