Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:35087 "EHLO
	mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758323AbcGZXaS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jul 2016 19:30:18 -0400
Received: by mail-ua0-f178.google.com with SMTP id l32so6570170ual.2
        for <linux-iio@vger.kernel.org>; Tue, 26 Jul 2016 16:30:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <df2f8e6f-3b69-819e-5aef-5fc1165aa1e8@kernel.org>
References: <1468825370-20075-1-git-send-email-enric.balletbo@collabora.com>
 <1468825370-20075-9-git-send-email-enric.balletbo@collabora.com> <df2f8e6f-3b69-819e-5aef-5fc1165aa1e8@kernel.org>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Tue, 26 Jul 2016 16:29:56 -0700
Message-ID: <CAMHSBOXzodLRfuaXvNKDyM08XC7MLvNOKE1zRGyCxA5hQGZnMg@mail.gmail.com>
Subject: Re: [PATCH 08/10] iio: cros_ec_sensors_ring: add ChromeOS EC Sensors Ring
To: Jonathan Cameron <jic23@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	linux-iio@vger.kernel.org, Olof Johansson <olof@lixom.net>,
	Lee Jones <lee.jones@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 18, 2016 at 9:27 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 18/07/16 08:02, Enric Balletbo i Serra wrote:
>> Add support for handling sensor events FIFO produced by the sensor
>> hub. A single device with a buffer will collect all samples produced
>> by the sensors managed by the CrosEC sensor hub.
> So you are defining a different device to support the buffer?
> That's 'unusual'...


>>
>> Signed-off-by: Guenter Roeck <groeck@chromium.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>> +     CHANNEL_SENSOR_FLAG,
> Ah, I'm beginning to understand.
>
> I think you really need to demux these into the appropriate devices individual
> buffers... If these are coming in fairly randomly (guessing so?) then you'll
> want a top level mfd pushing data to each of the child devices (representing
> the different possible sensors).

Yes, indeed. I did not find a good solution to demux the hardware FIFO
into each sensor. As you said, I should have written a MFD driver
between the sensor device driver and the cros ec device driver.
But at the same time, that MFD driver, while not being an IIO driver,
would have to know the iio_dev of each sensor and call them with
iio_push_to_buffers(). Is it acceptable to call iio function from
outside the IIO subsystem?

>
> Simply pushing it into a buffer with metadata doesn't fit with the IIO ABI
> at all.
>
> Note that there is no obligation to have any triggers involved at all. Here I'd
> suggest you don't as it'll just make life difficult for little gain.
>

The way chrome OS works today is one process (chrome) is gathering
accelerometer sensor data on a time basis (using sysfs trigger), while
another "process" (android) is listening to all sensors events as they
come. I see that IIO has support for serveral buffer per iio_dev, but
I did not see this feature used. Do you suggest to creating virtual
sensors - not tied to physical hardware - to be able to set different
trigger, or calll iio_update_buffers() directly with new buffers?

>> +
>> +static s64 cros_ec_get_time_ns(void)
>> +{
>> +     struct timespec ts;
>> +
>> +     get_monotonic_boottime(&ts);
>> +     return timespec_to_ns(&ts);
> Use the core IIO timestamp helper? (now supports all the different clocks...)

>> +}
> See comments earlier.  There is no need to have metadata here that userspace
> will have to unwind, just demux the data appropriately and push to the
> correct iio devices (one per 'scan' - set of samples acquired at approximately
> the same time - every time)
>> +
>> +#define CROS_EC_RING_AXIS(_axis)             \
>> +{                                            \
>> +     .type = IIO_ACCEL,                      \
>> +     .modified = 1,                          \
>> +     .channel2 = IIO_MOD_##_axis,            \
>> +     .scan_index = CHANNEL_##_axis,          \
>> +     .scan_type = {                          \
>> +             .sign = 's',                    \
>> +             .realbits = 16,                 \
>> +             .storagebits = 16,              \
>> +     },                                      \
>> +     .extend_name = "ring",                  \
> For obvious reasons given earlier comments I don't like this!
I got your point. We will defer upstreaming this driver until we have
a better solution for sensors behind a muxed FIFO.

Gwendal.

>> +}
