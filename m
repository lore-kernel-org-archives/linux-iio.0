Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33273 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964834AbcAZQMd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2016 11:12:33 -0500
Received: by mail-wm0-f68.google.com with SMTP id u188so18227939wmu.0
        for <linux-iio@vger.kernel.org>; Tue, 26 Jan 2016 08:12:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1601261657090.24513@pmeerw.net>
References: <1453823348-23074-1-git-send-email-daniel.baluta@intel.com>
	<1453823348-23074-3-git-send-email-daniel.baluta@intel.com>
	<alpine.DEB.2.02.1601261657090.24513@pmeerw.net>
Date: Tue, 26 Jan 2016 18:12:31 +0200
Message-ID: <CAEnQRZB4Nvp5k3QhL3Cd-qhg12RE4A22i8hg49q_RR3UjT7+Jw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: pressure: ms5611: Add triggered buffer support
From: Daniel Baluta <daniel.baluta@intel.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?Q?Tomasz_Duszy=C5=84ski?= <tduszyns@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jan 26, 2016 at 6:02 PM, Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:
> On Tue, 26 Jan 2016, Daniel Baluta wrote:
>
>> This will be used together with an external trigger (e.g hrtimer
>> based software trigger).
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>> ---
>>  drivers/iio/pressure/Kconfig       |  1 +
>>  drivers/iio/pressure/ms5611.h      |  1 +
>>  drivers/iio/pressure/ms5611_core.c | 71 ++++++++++++++++++++++++++++++++++++--
>>  drivers/iio/pressure/ms5611_i2c.c  |  7 ++++
>>  drivers/iio/pressure/ms5611_spi.c  |  8 +++++
>>  5 files changed, 86 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
>> index e8f60db..48c3741 100644
>> --- a/drivers/iio/pressure/Kconfig
>> +++ b/drivers/iio/pressure/Kconfig
>> @@ -69,6 +69,7 @@ config MPL3115
>>
>>  config MS5611
>>       tristate "Measurement Specialties MS5611 pressure sensor driver"
>> +     select IIO_TRIGGERED_BUFFER
>>       help
>>         Say Y here to build support for the Measurement Specialties
>>         MS5611, MS5607 pressure and temperature sensors.
>> diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
>> index 23b93c7..2d70dd6 100644
>> --- a/drivers/iio/pressure/ms5611.h
>> +++ b/drivers/iio/pressure/ms5611.h
>> @@ -52,5 +52,6 @@ struct ms5611_state {
>>  };
>>
>>  int ms5611_probe(struct iio_dev *indio_dev, struct device *dev, int type);
>> +int ms5611_remove(struct iio_dev *indio_dev);
>>
>>  #endif /* _MS5611_H */
>> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
>> index 6cf0e55..f7d364f 100644
>> --- a/drivers/iio/pressure/ms5611_core.c
>> +++ b/drivers/iio/pressure/ms5611_core.c
>> @@ -17,6 +17,9 @@
>>  #include <linux/iio/iio.h>
>>  #include <linux/delay.h>
>>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +#include <linux/iio/trigger_consumer.h>
>>  #include "ms5611.h"
>>
>>  static bool ms5611_prom_is_valid(u16 *prom, size_t len)
>> @@ -173,6 +176,31 @@ static int ms5611_reset(struct iio_dev *indio_dev)
>>       return 0;
>>  }
>>
>> +static irqreturn_t ms5611_trigger_handler(int irq, void *p)
>> +{
>> +     struct iio_poll_func *pf = p;
>> +     struct iio_dev *indio_dev = pf->indio_dev;
>> +     struct ms5611_state *st = iio_priv(indio_dev);
>> +     s32 buf[4], pressure, temp;
>
> a comment would be good explaining why 4 s32 are allocated while only the
> first two entries are used (because of timestamp)

Agree.

>
>> +     int ret;
>> +
>> +     mutex_lock(&st->lock);
>> +     ret = ms5611_read_temp_and_pressure(indio_dev, &temp, &pressure);
>> +     mutex_unlock(&st->lock);
>> +     if (ret < 0)
>> +             goto err;
>> +
>> +     if (test_bit(0, indio_dev->active_scan_mask))
>> +             buf[0] = pressure;
>> +     if (test_bit(1, indio_dev->active_scan_mask))
>> +             buf[1] = temp;
>
> I think this is wrong; what if only temp is active?, it should go into
> buf[0] then

Oops. You are right.
>
>> +
>> +     iio_push_to_buffers_with_timestamp(indio_dev, buf, pf->timestamp);
>
> maybe a newline here...
Agree.

>
>> +err:
>> +     iio_trigger_notify_done(indio_dev->trig);
>
> and here
>

Hmm, ok.
>> +     return IRQ_HANDLED;
>> +}
>> +
>>  static int ms5611_read_raw(struct iio_dev *indio_dev,
>>                          struct iio_chan_spec const *chan,
>>                          int *val, int *val2, long mask)
>> @@ -232,12 +260,27 @@ static const struct iio_chan_spec ms5611_channels[] = {
>>               .type = IIO_PRESSURE,
>>               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>>                       BIT(IIO_CHAN_INFO_SCALE),
>> +             .scan_index = 0,
>> +             .scan_type = {
>> +                     .sign = 's',
>> +                     .realbits = 32,
>> +                     .storagebits = 32,
>> +                     .endianness = IIO_CPU,
>> +             },
>>       },
>>       {
>>               .type = IIO_TEMP,
>>               .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>>                       BIT(IIO_CHAN_INFO_SCALE),
>> -     }
>> +             .scan_index = 1,
>> +             .scan_type = {
>> +                     .sign = 's',
>> +                     .realbits = 32,
>> +                     .storagebits = 32,
>> +                     .endianness = IIO_CPU,
>> +             },
>> +     },
>> +     IIO_CHAN_SOFT_TIMESTAMP(3),
>
> index should be 2 for timestamp
Ok.

>
>>  };
>>
>>  static const struct iio_info ms5611_info = {
>> @@ -274,10 +317,34 @@ int ms5611_probe(struct iio_dev *indio_dev, struct device *dev, int type)
>>       if (ret < 0)
>>               return ret;
>>
>> -     return devm_iio_device_register(dev, indio_dev);
>> +     ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
>> +                                      ms5611_trigger_handler, NULL);
>> +     if (ret < 0) {
>> +             dev_err(dev, "iio triggered buffer setup failed\n");
>> +             return ret;
>> +     }
>> +
>> +     ret = iio_device_register(indio_dev);
>> +     if (ret < 0) {
>> +             dev_err(dev, "unable to register iio device\n");
>> +             goto err_buffer_cleanup;
>> +     }
>> +
>> +     return 0;
>

Will do. Thanks a lot Peter!

Daniel.
