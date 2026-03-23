Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B743B4E8C
	for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278664; cv=none; b=R0la0+kl4pXQRU3NS7mVTB2Srehg8YLqXmHWVdqqSYSIRVhY5oLvEM52YDO3yM5+5Nmg3G7eBbIvIxE8v4kWlOm/zEHLJvB3uuVngzBr61hA1K5tXmKqc+aCSJRTEX3DRFaCvNlIkz6a6dm2Ist8OBN9uRTDQKnm4rom/8WmdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278664; c=relaxed/simple;
	bh=TSoqxiKvRUR1dZa1woJkYuljpKESR7AwTa16MhoVDHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOL9Hj/kmSy3sbChYu/eOxz0WMReH3um7tSgM0KFi+NEue2F7cJ+m3fAEmDo9Q4O2FWzbyxCW7eFdMbtMBWc3oARhaFdoSyXW3loeLbTcA7NG7UcZ/Dpu3UKg6l/qXePT/IlBpfcliRKITQBwzioD+/9QLxPhIRK2XCA5+nF6PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSlKzMuM; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSlKzMuM"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a133b686f7so252676e87.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Mar 2026 08:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774278661; x=1774883461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJ3emijR5oNOwnSkFZn8zHS372Ef2TX2E+/n8RR77do=;
        b=FSlKzMuMWaAwq4KhZubx9pLa5E+CAieFIOwRjP3EdPiDRaS3KwudBbvgcu44KGD/Yr
         oUToEnF1Ha5YC0kIBKylxW+0ZuN6g/16TR73HAbbNtCsxWi9i4h8UEOUFlam5AQ2hLDJ
         XCiM5Yj/Md2itZMt9pabOsCX/nEPwTJpDaP7ZjIaOHNXTejxX6D5oVNI8y395MBE8c7f
         7NF606SFmUxpiWyxNBBgSp2DS5cDkc0ADAuTyN7twfmhp/jDTpYPvqfQdnLXJ4k++5BY
         Ef/QvI+PqHmYbPKhOyHSDL0/OZbU9/nqbYytIogrjmSCmTeGnTueBoHyBE/4HSy1YamL
         Gn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774278661; x=1774883461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJ3emijR5oNOwnSkFZn8zHS372Ef2TX2E+/n8RR77do=;
        b=RyNwNH/6zI8SGEDfg2HhuqpGFCx8vMhofPMtLVV4jfOEVbU7HLM0+17dfW/BBKCKok
         JeOQffJT5DTEe+9iWIyQv6nZpVk1FpIDUVHHvDIjyEKel8tgsRVfRbQ0/AzzcjZgMhZI
         gKQO9r4VnpWy+aQsuq2yYs6fnNk9ZP8uChz0kDt7EXzDicugOqxEBZuVRK4bwEzA/1QK
         dYA+gd2K48l0dWzl+JUL1r/4vDEbKUW2soHezMk5ySwtFUcgIL9msJrsb80JZlFSWLq2
         1r1wbr2ZPBxRo4Am57h3Yt2plews5hiNgq48G7iZ7TwXmM7LqaC+1Ec53Me9tYN+JN5j
         5w4Q==
X-Gm-Message-State: AOJu0Yx27jRld/Mf5zr++JMveEf0EPcSW1RDdZL1dMdI40vml46dOGSd
	wtdjDYg/aMDhn5/GQSEL7QHaBjkLK0tySggftIPbE7vlwP3/9Zv5fer5
X-Gm-Gg: ATEYQzw0pJmtNciFJE7iGs8P5Zii1TU/k7ajqwIU5hZgoIVsAoXykU6H1+jO+fZocvY
	M6FngPcCY3JCZdy6DjTxx6iUD93hDdGga66xfKCx+GqYfTEDspolhtxhQeafG1puBv1HKDkNhG+
	puXLGegSAYQ9AjUo+HlTSCCTtplBFu7dDFFM6EKwkZTw232iOgm5i9WAFkUG/RVi/70Fs7JryZy
	EAB6dv2VMgq6mRTrsRhGxjtLVlnOvQIl1Q/Z94ZrN9asksDg7Eh61HEWiNBdesV3r85+otvidmS
	79YsDt3mmq7Wu/7J59jYXQpDhmq1X0WtiZXbT7flWEtdnzHrnStK24qJXYXWmYrlUaNjN0Lg+mv
	G/x0Xk4zzRrVbOQZurbtzGQsPPl15uFRfo0ok8IzOPXbQwKO55pASnGMC1Us99AqR6TlCn4ydvS
	s0tJKImXCsZhdKZ8GxU12FcmTi1wNKAyRGCp8RrzRyjCEF/smIeskRkv7QUXSJpMI0qLj51WWCR
	ZEXow/93+wUmKf3Xc2bp9THrYiQU/N1qq8WamvqLU4609HpYfpL3iAOt+9tMLLSuw==
X-Received: by 2002:a05:6512:ad4:b0:5a1:38c4:4247 with SMTP id 2adb3069b0e04-5a285ae5251mr4347077e87.1.1774278660268;
        Mon, 23 Mar 2026 08:11:00 -0700 (PDT)
Received: from ?IPV6:2001:14ba:6e:3100:284d:5aa8:b8e7:1b28? (2001-14ba-6e-3100-284d-5aa8-b8e7-1b28.rev.dnainternet.fi. [2001:14ba:6e:3100:284d:5aa8:b8e7:1b28])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2851ac33dsm2644116e87.31.2026.03.23.08.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 08:10:59 -0700 (PDT)
Message-ID: <7ef87de7-9731-46fb-9608-34c07fcf03cd@gmail.com>
Date: Mon, 23 Mar 2026 17:10:58 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: hid-sensors: Use software trigger
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 jic23@kernel.org
Cc: linux-iio@vger.kernel.org, bigeasy@linutronix.de, spasswolf@web.de,
 linux-kernel@vger.kernel.org
References: <20260220224514.471348-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?B?SGFubmUtTG90dGEgTcOkZW5ww6TDpA==?= <hannelotta@gmail.com>
In-Reply-To: <20260220224514.471348-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/21/26 12:45 AM, Srinivas Pandruvada wrote:
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
> Changes:
> v2:
> changed
> indio_dev->modes |= INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
> to
> indio_dev->modes = INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
> 
>  From RFC
> - The trigger alloc and register is still kept as old code with
> additional
> indio_dev->modes |= INDIO_DIRECT_MODE | INDIO_HARDWARE_TRIGGERED;
> 
>   .../common/hid-sensors/hid-sensor-trigger.c   | 48 ++++++++++++-------
>   1 file changed, 30 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 5540e2d28f4a..417c4ab8c1b2 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -14,6 +14,7 @@
>   #include <linux/iio/triggered_buffer.h>
>   #include <linux/iio/trigger_consumer.h>
>   #include <linux/iio/sysfs.h>
> +#include <linux/iio/kfifo_buf.h>
>   #include "hid-sensor-trigger.h"
>   
>   static ssize_t _hid_sensor_set_report_latency(struct device *dev,
> @@ -202,12 +203,21 @@ static void hid_sensor_set_power_work(struct work_struct *work)
>   		_hid_sensor_power_state(attrb, true);
>   }
>   
> -static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
> -						bool state)
> +static int buffer_postenable(struct iio_dev *indio_dev)
>   {
> -	return hid_sensor_power_state(iio_trigger_get_drvdata(trig), state);
> +	return hid_sensor_power_state(iio_device_get_drvdata(indio_dev), 1);
>   }
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
>   void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
>   			       struct hid_sensor_common *attrb)
>   {
> @@ -219,14 +229,9 @@ void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
>   	cancel_work_sync(&attrb->work);
>   	iio_trigger_unregister(attrb->trigger);
>   	iio_trigger_free(attrb->trigger);
> -	iio_triggered_buffer_cleanup(indio_dev);
>   }
>   EXPORT_SYMBOL_NS(hid_sensor_remove_trigger, "IIO_HID");
>   
> -static const struct iio_trigger_ops hid_sensor_trigger_ops = {
> -	.set_trigger_state = &hid_sensor_data_rdy_trigger_set_state,
> -};
> -
>   int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>   				struct hid_sensor_common *attrb)
>   {
> @@ -239,25 +244,34 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>   	else
>   		fifo_attrs = NULL;
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
>   	if (ret) {
> -		dev_err(&indio_dev->dev, "Triggered Buffer Setup Failed\n");
> +		dev_err(&indio_dev->dev, "Kfifo Buffer Setup Failed\n");
>   		return ret;
>   	}
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
>   	trig = iio_trigger_alloc(indio_dev->dev.parent,
>   				 "%s-dev%d", name, iio_device_id(indio_dev));
>   	if (trig == NULL) {
>   		dev_err(&indio_dev->dev, "Trigger Allocate Failed\n");
> -		ret = -ENOMEM;
> -		goto error_triggered_buffer_cleanup;
> +		return -ENOMEM;
>   	}
>   
>   	iio_trigger_set_drvdata(trig, attrb);
> -	trig->ops = &hid_sensor_trigger_ops;
>   	ret = iio_trigger_register(trig);
>   
>   	if (ret) {
> @@ -284,8 +298,6 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>   	iio_trigger_unregister(trig);
>   error_free_trig:
>   	iio_trigger_free(trig);
> -error_triggered_buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
>   	return ret;
>   }
>   EXPORT_SYMBOL_NS(hid_sensor_setup_trigger, "IIO_HID");


Hi,

This patch clears the warning "WARNING: kernel/irq/manage.c:1502 at 
__setup_irq" on Debian forky.

Tested-by: Hanne-Lotta Mäenpää

The referenced commit ID could be included in the commit message, like this:

Commit aef30c8d569c0f317154 ("genirq: Warn about using IRQF_ONESHOT 
without a threaded handler")

With that included, this patch will be easier to find if someone bisects 
the issue.

Also, a Closes tag could be added:

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221256

Best regards,

Hanne-Lotta Mäenpää
