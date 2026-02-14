Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F95306B08
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771092980; cv=none; b=fl4tYGdyzy0dLVqto7wFCsK914fxnj6Ac91g+l0rhvyW8kqehNo7BPI8hTOm6psy03TiD/mzkvYH8N/+jrp5W9Vaq5NAmbB6lrE8FjvbKR7Ep1UaogAaPEDvQwuGOtbSg+k35dJzTT/d2gQOQFWgdsgSAWqFtkJSgieNzZvA1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771092980; c=relaxed/simple;
	bh=qznGoRnFgqUagexG4bSXRH64adpys+gk1aNAm+y8ZjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/8npHyLKwhKIIVsTIHPhPI996LhgHXUf0PbF3PmrHmE5Jy25EivSkK8g3m7kbojusApJOqujrMjrQ/rGVgdi9mgthjiy7PJSBddpO9s4VXhLNxJo9+u2A8xOlb/tBoag+cugc1vvvp6AJJFsU4m/OpChxUfmpl9GwBHp1weDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPmTmG/w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPmTmG/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70ACC16AAE;
	Sat, 14 Feb 2026 18:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771092979;
	bh=qznGoRnFgqUagexG4bSXRH64adpys+gk1aNAm+y8ZjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jPmTmG/wiSFSSxGN+07IIA6dUz4W9E/1Oi3/Oh8qaNYYa6o8UAGJFmzcRPjUW3g81
	 z2hFFye2UgJbE/B/VzeCey9a24OO0uw+9BQPd42+sdaHFI7hLLO5+vCcMPgJfRUTbs
	 HXJ5fAuGazaadyTGqR8JVP96+wfa6do9LNTCZytDwddnS/UVXDlY/ehlh4SvbbItpe
	 OVuDcGSDnPCLG6GwrVb5CtOqzk1D9R4TTIF1FZd8Pn2d1asE5AXDCK22QiRiMqn4Rb
	 M9OJ6ovGrIlq/kyhAduqhoLEStwbsB5LbqfmovLyTnWUQaRT4AaueWyJzf60ytaXd9
	 3txSt5IQ6imIg==
Date: Sat, 14 Feb 2026 18:16:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, bigeasy@linutronix.de, spasswolf@web.de
Subject: Re: [RFC PATCH] iio: hid-sensors: Use software trigger
Message-ID: <20260214181612.20b37528@jic23-huawei>
In-Reply-To: <20260209204227.1352304-1-srinivas.pandruvada@linux.intel.com>
References: <20260209204227.1352304-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Feb 2026 12:42:27 -0800
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
> ---
> This is RFC, because
> The current user space in distro "iio-sensor-proxy" is not working in
> trigerless mode as it expects /sys/bus/iio/devices/iio:device0/trigger/current_trigger.
> So, change needs to be submitted to fix that.

Sorry I took a while to reply to the previous thread - been off sick and
just catching up again.

I think we can't make this change on it's own because of the backwards compatibility
problem.  Please can you try what you have here without removing the trigger adding
chunk (as we still need that to exist) + 

iio_dev->modes = INDIO_DIRECT | INDIO_HARDWARE_TRIGGERED;

It's been a while but I think that is there basically to hook up current_trigger.
That was intended for cases where there are several to choose between but
I think it should do the job here of bringing back the interface.   Add a comment
though on why it is there.

I've tried to say roughly what to keep and drop inline.

thanks,

Jonathan



> 
>  .../common/hid-sensors/hid-sensor-trigger.c   | 62 ++++++-------------
>  1 file changed, 18 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 5540e2d28f4a..113fd1361643 100644
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
I think these changes all help simplify things anyway so probably
good to have.  Maybe we could do them in a follow up rather than the
fix but I'll leave that up to you.

> +
>  void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
>  			       struct hid_sensor_common *attrb)
>  {
> @@ -217,59 +227,30 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
>  	pm_runtime_set_suspended(&attrb->pdev->dev);
>  
>  	cancel_work_sync(&attrb->work);
> -	iio_trigger_unregister(attrb->trigger);
> -	iio_trigger_free(attrb->trigger);
Keep the trigger parts here.

> -	iio_triggered_buffer_cleanup(indio_dev);
>  }
>  EXPORT_SYMBOL_NS(hid_sensor_remove_trigger, "IIO_HID");
>  
> -static const struct iio_trigger_ops hid_sensor_trigger_ops = {
> -	.set_trigger_state = &hid_sensor_data_rdy_trigger_set_state,
> -};
and this.
> -
>  int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>  				struct hid_sensor_common *attrb)
>  {
>  	const struct iio_dev_attr **fifo_attrs;
>  	int ret;
> -	struct iio_trigger *trig;
>  
>  	if (hid_sensor_batch_mode_supported(attrb))
>  		fifo_attrs = hid_sensor_fifo_attributes;
>  	else
>  		fifo_attrs = NULL;
>  
> -	ret = iio_triggered_buffer_setup_ext(indio_dev,
> -					     &iio_pollfunc_store_time, NULL,
> -					     IIO_BUFFER_DIRECTION_IN,
> -					     NULL, fifo_attrs);
> +	ret = devm_iio_kfifo_buffer_setup_ext(&indio_dev->dev, indio_dev,
> +					      &hid_sensor_buffer_ops,
> +					      fifo_attrs);
>  	if (ret) {
> -		dev_err(&indio_dev->dev, "Triggered Buffer Setup Failed\n");
> +		dev_err(&indio_dev->dev, "Kfifo Buffer Setup Failed\n");
>  		return ret;
>  	}
Down to here is good but keep the trigger setup.

> -
> -	trig = iio_trigger_alloc(indio_dev->dev.parent,
> -				 "%s-dev%d", name, iio_device_id(indio_dev));
> -	if (trig == NULL) {
> -		dev_err(&indio_dev->dev, "Trigger Allocate Failed\n");
> -		ret = -ENOMEM;
> -		goto error_triggered_buffer_cleanup;
> -	}
> -
> -	iio_trigger_set_drvdata(trig, attrb);
> -	trig->ops = &hid_sensor_trigger_ops;
> -	ret = iio_trigger_register(trig);
> -
> -	if (ret) {
> -		dev_err(&indio_dev->dev, "Trigger Register Failed\n");
> -		goto error_free_trig;
> -	}
> -	attrb->trigger = trig;
> -	indio_dev->trig = iio_trigger_get(trig);
> -
>  	ret = pm_runtime_set_active(&indio_dev->dev);
>  	if (ret)
> -		goto error_unreg_trigger;
> +		return ret;
>  
>  	iio_device_set_drvdata(indio_dev, attrb);
>  
> @@ -280,13 +261,6 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>  	pm_runtime_set_autosuspend_delay(&attrb->pdev->dev,
>  					 3000);
>  	return ret;
> -error_unreg_trigger:
> -	iio_trigger_unregister(trig);
> -error_free_trig:
> -	iio_trigger_free(trig);
> -error_triggered_buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	return ret;
>  }
>  EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID");
>  

