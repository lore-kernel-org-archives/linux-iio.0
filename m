Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33313 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932601AbdA0Kms (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 05:42:48 -0500
MIME-Version: 1.0
In-Reply-To: <CAMHSBOWbjKtnta2F+FefDbU2ahszNB6h-fL+AO77Ey2bi1MLog@mail.gmail.com>
References: <20170111155139.6559-1-enric.balletbo@collabora.com>
 <20170111155139.6559-2-enric.balletbo@collabora.com> <d9b1a9c0-3d33-db5d-026b-81cddca43be0@kernel.org>
 <CAFqH_50TJ8ydh5b1OKDqTATsdjodtcPHhcX4FY2HLJ+8JybVjg@mail.gmail.com> <CAMHSBOWbjKtnta2F+FefDbU2ahszNB6h-fL+AO77Ey2bi1MLog@mail.gmail.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Fri, 27 Jan 2017 11:42:47 +0100
Message-ID: <CAFqH_51La78Dz_BMby0TFstsgRm_exGFQk1a7kg8v9nCGQxv=w@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] iio: cros_ec_light_prox: add ChromeOS EC Light and
 Proximity Sensors
To: Gwendal Grignou <gwendal@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

2017-01-23 19:18 GMT+01:00 Gwendal Grignou <gwendal@chromium.org>:
> On Fri, Jan 20, 2017 at 6:23 AM, Enric Balletbo Serra
> <eballetbo@gmail.com> wrote:
>> Hi Jonathan,
>>
>> Thanks for the review, I am preparing v3. Some answers to your questions below.
>>
>> 2017-01-14 14:06 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
>>> On 11/01/17 15:51, Enric Balletbo i Serra wrote:
>>>> From: Gwendal Grignou <gwendal@chromium.org>
>>>>
>>>> Handle Light and Proximity sensors presented by the ChromeOS EC Sensor hub.
>>>> Creates an IIO device for each functions.
>>>>
>>>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>>>> Signed-off-by: Guenter Roeck <groeck@chromium.org>
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> Hi.
>>>
>>> Looks like you were cleaning up the interface and left a few bits behind...
>>> Please tidy those up and repost.
>>>
>>> Thanks,
>>>
>>> Jonathan
>>>> ---
>>>>  drivers/iio/common/cros_ec_sensors/Kconfig         |   8 +
>>>>  drivers/iio/common/cros_ec_sensors/Makefile        |   1 +
>>>>  .../common/cros_ec_sensors/cros_ec_light_prox.c    | 287 +++++++++++++++++++++
>>> I missed this before.  I'd actually like to have this in the proximity
>>> directory rather than here.  The reason is to keep the drivers grouped
>>> by function is preferred to grouping by what implements them.
>>
>> Ok, I'll move this.
>>
>>>>  3 files changed, 296 insertions(+)
>>>>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_light_prox.c
> ...
>>>> +
>>>> +     switch (mask) {
>>>> +     case IIO_CHAN_INFO_PROCESSED:
>>>> +             if (cros_ec_sensors_read_cmd(indio_dev, 1 << idx,
>>>> +                                          (s16 *)&data) < 0) {
>>>> +                     ret = -EIO;
>>>> +                     break;
>>>> +             }
>>>> +
>>>> +             switch (chan->type) {
>>>> +             /*
>>>> +              * The data coming from the sensor is pre-processed, represents
>>>> +              * the ambient light illuminance reading expressed in lux.
>>>> +              */
>>>> +             case IIO_LIGHT:
>>>> +                     *val = data;
>>>> +                     ret = IIO_VAL_INT;
>>>> +                     break;
>>>> +             /*
>>>> +              * The data coming from the sensor is pre-processed, represents
>>>> +              * the distance reading expressed in cm. Convert to m.
>>>> +              */
>>>> +             case IIO_PROXIMITY:
>>> Out of curiousity, what kind of proximity sensor is this?  I'm suprised it
>>> has any real world units as I'd assumed we were dealing with a light
>>> intensity based sensor and reflection.
>>
>> The CrosEC acts as a sensor hub, it can have different sensors
>> attached that differs betweens Chromebooks models. The sensor hub
>> captures the data from sensors and does some conversion and then
>> exposes the result through it's interface. E.g For light and proximity
>> sensors it can have attached a si144x [1] Proximity/Ambient Light
>> Sensor Modules.
>>
>> [1] http://www.silabs.com/products/sensors/infraredsensors/Pages/Si114x.aspx
>>
> The embedded controller (EC) does the conversion from the reflection.
> SI114x has 2 mode, light sensor and proximity sensor: in the later
> case, ambient light is ignored and reflection of a led is measured.
> The transformation from reflection to distance is an approximation.
>
>>>> +                     *val = 0;
>>>> +                     *val2 = data * 10000;
>>>> +                     ret = IIO_VAL_INT_PLUS_MICRO;
>>>> +                     break;
>>>> +             default:
>>>> +                     ret = -EINVAL;
> ...
>>>> +     state->core.loc = state->core.resp->info.location;
>>>> +     channel = state->channels;
>>>> +
>>>> +     /* Common part */
>>>> +     channel->info_mask_separate =
>>>> +//           BIT(IIO_CHAN_INFO_RAW) |
>>> What's this doing here?
>>
>> Sorry, removed.
>>
>>>> +             BIT(IIO_CHAN_INFO_PROCESSED) |
>>>> +             BIT(IIO_CHAN_INFO_CALIBBIAS) |
>>>> +             BIT(IIO_CHAN_INFO_CALIBSCALE);
>>>> +     channel->info_mask_shared_by_all =
>>>> +             BIT(IIO_CHAN_INFO_SCALE) |
>>> Providing processed and 'scale' is unusual...  Even more interesting
>>> is you don't seem to provide it or indeed the next two...
> I see your point.
> Data from the sensor is massaged by the EC with input from calibbias
> and calibscale. Given this is not a heavy processing, it would be more
> logical to expose the illimunance/proximity as IIO_CHAN_INFO_RAW
> instead of IIO_CHAN_INFO_PROCESSED.
>

I see, I did not know about the internals of the EC for this sensor (I
will look at the EC code), but seems I was wrong saying that the EC
was returning processed value in known SI units. As Gwendal says in
the comment above, if the value is an approximation and not really
processed value that returns exactly the distance, what it really
indicates is if the object is more or less closer. It's a userspace
decision assume the values are valid meters or not. So I agree on use
RAW instead of PROCESSED. I assume is the same for light.

Jonathan, sounds good I use the RAW info for the next version again?
What do you think?

Also, as seems the EC massages the data from a si144x and there is
drivers/iio/light/si1145.c, which is a similar, makes more sense put
the cros_ec_light_prox in the iio/light directory instead of
iio/proximity?

> An earlier version of this driver was returning 1 to
> IIO_CHAN_INFO_SCALE, that's why IIO_CHAN_INFO_SCALE was present. We
> may bring it back if a sensor needs it.
>>>
>>> Please check out this whole area.
>>
>> Yes, I get rid of scale from here.
>>
>>>> +             BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>>>> +             BIT(IIO_CHAN_INFO_FREQUENCY);
>>
>> These are from cros_ec_sensors_core
>>
>>>> +     channel->scan_type.realbits = CROS_EC_SENSOR_BITS;
>>>> +     channel->scan_type.storagebits = CROS_EC_SENSOR_BITS;
>>>> +     channel->scan_type.shift = 0;
> ...
>>>> +
>>>> +MODULE_DESCRIPTION("ChromeOS EC light/proximity sensors driver");
>>>> +MODULE_LICENSE("GPL v2");
>>>>
>>>
>>
>> I'm preparing v3, thanks,
>>  Enric

Thanks,
 Enric
