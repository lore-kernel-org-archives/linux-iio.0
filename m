Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53144 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935082AbcJVPNu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 11:13:50 -0400
Subject: Re: [PATCH] iio: light: acpi-als: Add IO_CHAN_INFO_OFFSET/SCALE to
 mask.
To: Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
References: <1477037829-20352-1-git-send-email-enric.balletbo@collabora.com>
 <CAMHSBOXJArBSUZqNT0gbN0KQqPAttaWgL=BoXy7keV4Ez0VB6w@mail.gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <968cc6eb-5da3-93e3-839d-71f8e34937f9@kernel.org>
Date: Sat, 22 Oct 2016 16:13:47 +0100
MIME-Version: 1.0
In-Reply-To: <CAMHSBOXJArBSUZqNT0gbN0KQqPAttaWgL=BoXy7keV4Ez0VB6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/10/16 17:43, Gwendal Grignou wrote:
> On Fri, Oct 21, 2016 at 1:17 AM, Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>> According the ACPI specification (Version 5.0 Errata A) [1], the data
>> coming from the sensor represent the ambient light illuminance reading
>> expressed in lux. Unfortunately ACPI interface doesn't provide a
>> mechanism to calibrate this value, so this raw value can be slightly
>> wrong.
>>
>> This patch adds IIO_CHAN_INFO_OFFSET and IIO_CHAN_INFO_SCALE attributes
>> to give the possibiity to the userspace to calculate a calibrated data
possibility
>> by doing:
>>
>>  (raw_value + offset) * scale = calibrated_value (in lux)
>>
>> [1] http://www.acpi.info/DOWNLOADS/ACPI_5_Errata%20A.pdf
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Hmm.. I'm not particularly keen on adding support to an individual driver
to push calibration data into the kernel just so it can be 'popped' again
later.

After all ever light sensor suffers from the same 'fine tuning' problem as
ultimately does every sensor of any kind.

To my mind this is a job for userspace really rather than something
that ought to be pushed into the kernel.

These values are 'supposed' to be correct as provided by ACPI so its
not as though we are trying handle gross differences.

Or are we looking at patching buggy firmwares?

Jonathan

>> ---
>>  drivers/iio/light/acpi-als.c | 66 ++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 57 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
>> index f0b47c5..a8093ba 100644
>> --- a/drivers/iio/light/acpi-als.c
>> +++ b/drivers/iio/light/acpi-als.c
>> @@ -56,7 +56,9 @@ static const struct iio_chan_spec acpi_als_channels[] = {
>>                 },
>>                 /* _RAW is here for backward ABI compatibility */
>>                 .info_mask_separate     = BIT(IIO_CHAN_INFO_RAW) |
>> -                                         BIT(IIO_CHAN_INFO_PROCESSED),
>> +                                         BIT(IIO_CHAN_INFO_PROCESSED) |
>> +                                         BIT(IIO_CHAN_INFO_SCALE) |
>> +                                         BIT(IIO_CHAN_INFO_OFFSET),
>>         },
>>  };
>>
>> @@ -76,6 +78,10 @@ struct acpi_als {
>>         struct mutex            lock;
>>
>>         s32                     evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE];
>> +
>> +       int                     scale;
>> +       int                     uscale;
>> +       int                     offset;
>>  };
>>
>>  /*
>> @@ -154,25 +160,64 @@ static int acpi_als_read_raw(struct iio_dev *indio_dev,
>>         s32 temp_val;
>>         int ret;
>>
>> -       if ((mask != IIO_CHAN_INFO_PROCESSED) && (mask != IIO_CHAN_INFO_RAW))
>> -               return -EINVAL;
>> -
>>         /* we support only illumination (_ALI) so far. */
>>         if (chan->type != IIO_LIGHT)
>>                 return -EINVAL;
>>
>> -       ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &temp_val);
>> -       if (ret < 0)
>> -               return ret;
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_RAW:
>> +       case IIO_CHAN_INFO_PROCESSED:
> It seems PROCESSED is identical to RAW. Shouldn't we remove this attribute?
You can't without breaking userspace ABI.  We got this messed up a long
time back, but now we are pretty much stuck with having both.
>> +               ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &temp_val);
>> +               if (ret < 0)
>> +                       return ret;
>> +               *val = temp_val;
>> +               return IIO_VAL_INT;
>> +       case IIO_CHAN_INFO_OFFSET:
>> +               mutex_lock(&als->lock);
>> +               *val = als->offset;
>> +               mutex_unlock(&als->lock);
>> +               return IIO_VAL_INT;
>> +       case IIO_CHAN_INFO_SCALE:
>> +               mutex_lock(&als->lock);
>> +               *val = als->scale;
>> +               *val2 = als->uscale;
>> +               mutex_unlock(&als->lock);
>> +               return IIO_VAL_INT_PLUS_MICRO;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +}
>>
>> -       *val = temp_val;
>> +static int acpi_als_write_raw(struct iio_dev *indio_dev,
>> +                             struct iio_chan_spec const *chan, int val,
>> +                             int val2, long mask)
>> +{
>> +       struct acpi_als *als = iio_priv(indio_dev);
>> +
>> +       if (chan->type != IIO_LIGHT)
>> +               return -EINVAL;
>>
>> -       return IIO_VAL_INT;
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_OFFSET:
>> +               mutex_lock(&als->lock);
>> +               als->offset = val;
If you aren't providing a write_raw_fmt callback, then you
should sanity check that val2 is not non 0 for this case.
>> +               mutex_unlock(&als->lock);
>> +               return 0;
>> +       case IIO_CHAN_INFO_SCALE:
>> +               mutex_lock(&als->lock);
>> +               als->scale = val;
>> +               als->uscale = val2;
>> +               mutex_unlock(&als->lock);
>> +               return 0;
>> +       default:
>> +               return -EINVAL;
>> +       }
>>  }
>>
>>  static const struct iio_info acpi_als_info = {
>>         .driver_module          = THIS_MODULE,
>>         .read_raw               = acpi_als_read_raw,
>> +       .write_raw              = acpi_als_write_raw,
>>  };
>>
>>  static int acpi_als_add(struct acpi_device *device)
>> @@ -189,6 +234,9 @@ static int acpi_als_add(struct acpi_device *device)
>>
>>         device->driver_data = indio_dev;
>>         als->device = device;
>> +       als->scale = 1;
>> +       als->uscale = 0;
>> +       als->offset = 0;
>>         mutex_init(&als->lock);
>>
>>         indio_dev->name = ACPI_ALS_DEVICE_NAME;
>> --
>> 2.1.0
>>

