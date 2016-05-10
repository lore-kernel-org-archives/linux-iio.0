Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35434 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbcEJIMF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 May 2016 04:12:05 -0400
Received: by mail-ob0-f182.google.com with SMTP id n10so2508351obb.2
        for <linux-iio@vger.kernel.org>; Tue, 10 May 2016 01:12:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c747fbdf-5fcb-d8e3-e0d7-a815af1d291d@intel.com>
References: <1462805775-7723-1-git-send-email-linus.walleij@linaro.org>
	<c747fbdf-5fcb-d8e3-e0d7-a815af1d291d@intel.com>
Date: Tue, 10 May 2016 10:12:03 +0200
Message-ID: <CACRpkdZoAfMPbRetb2AnkPwbaZog5+EWO_XRW=CE-YjdSBP1sw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: st_sensors: switch to a threaded interrupt
From: Linus Walleij <linus.walleij@linaro.org>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 9, 2016 at 7:44 PM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:
> On 05/09/2016 05:56 PM, Linus Walleij wrote:

>> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
>> +     /* If we do timetamping here, do it before reading the values */
>> +     if (sdata->hw_irq_trigger)
>> +             timestamp = sdata->hw_timestamp;
>> +     else
>> +             timestamp = iio_get_time_ns();
>
> This ignores pf->timestamp so passing iio_pollfunc_store_time no longer
> has any effect, right? I think this is actually a good thing. When using
> software triggers it is best to get the timestamp as close to the actual
> read as possible. Relying on iio_pollfunc_store_time would just add the
> noisy delay between hrtimer interrupts and process context to iio
> timestamps.

Yeah that's right ... I didn't even think of that.

> But it would now make sense to pass NULL instead of
> iio_pollfunc_store_time to all the iio_triggered_buffer_setup calls in
> st_sensors, right?

Yep, I'm augmenting the patch to do that.

> It's also a bit strange that the buffer irq_handler is no longer called.
> Maybe this needs validate_device in trigger_ops?

Yeah that's true, it seems harmless but the mma8452 accelerometer
does this validation, it just compare if it's the same device, I'll add an
identical check for the st_sensors.

>> --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
>> +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
>> +     /*
>> +      * If this trigger is backed by a hardware interrupt and we have a
>> +      * status register, check if this IRQ came from us
>> +      */
>> +     if (sdata->sensor_settings->drdy_irq.addr_stat_drdy) {
>> +             u8 status;
>> +
>> +             ret = sdata->tf->read_byte(&sdata->tb, sdata->dev,
>> +                        sdata->sensor_settings->drdy_irq.addr_stat_drdy,
>> +                        &status);
>> +             if (ret < 0) {
>> +                     dev_err(sdata->dev, "could not read channel status\n");
>> +                     goto out_poll;
>> +             }
>> +
>> +             /*
>> +              * If this was not caused by any channels on this sensor,
>> +              * return IRQ_NONE
>> +              */
>> +             if (!indio_dev->active_scan_mask)
>> +                     return IRQ_NONE;
>> +             if (!(status & (u8)indio_dev->active_scan_mask[0]))
>> +                     return IRQ_NONE;
>
> It's not clear that this belongs here. The check is not related to
> sdata->sensor_settings->drdy_irq.addr_stat_drdy. It could be done before
> checking the status register or even in the hardirq handler.
>
> It seems to me that placing this check here would result in a bunch of
> useless bus transactions.

As you can see the read status is compared to the
active_scan_mask, this matches one-to-one to the enabled axis
and we check whether data is available on any of them.

We check sdata->sensor_settings->drdy_irq.addr_stat_drdy != NULL
to determine that the device has an DRDY status reqister.

If the sensor has this register (which is not a given) then we proceed
to check if it has indicated new values, i.e. if this sensor caused
the DRDY IRQ to happen.

If it doesn't have a status register, i.e.
sdata->sensor_settings->drdy_irq.addr_stat_drdy == NULL,
we cannot determine if we were the cause of this IRQ and we
proceed to poll the sensor anyways, assuming it was ours.
This makes it impossible to share the IRQ line or handle
spurious IRQs properly, but that is a hardware limitation.

Yours,
Linus Walleij
