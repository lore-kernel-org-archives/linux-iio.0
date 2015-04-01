Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <551C2BD0.4060707@linux.intel.com>
Date: Wed, 01 Apr 2015 10:33:04 -0700
From: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 2/3] iio: ltr501: Add interrupt rate control support
References: <cover.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com>	<212b45fac712e84a3cf0bc5955def7d1b683a6bd.1427856701.git.sathyanarayanan.kuppuswamy@linux.intel.com> <CAEnQRZC=GtB7r=QG7DkDJOFz8bBQ-V+VD-DNkVG50-LubLMr8w@mail.gmail.com>
In-Reply-To: <CAEnQRZC=GtB7r=QG7DkDJOFz8bBQ-V+VD-DNkVG50-LubLMr8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 04/01/2015 07:04 AM, Daniel Baluta wrote:
> On Wed, Apr 1, 2015 at 5:55 AM, Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> Added rate control support for ALS and proximity
>> threshold interrupts.
>>
>> Setting <n> to ALS intr_persist sysfs node would
>> generate interrupt whenever ALS data cross either
>> upper or lower threshold limits <n> number of times.
>> Similarly setting <m> to proximity intr_persist sysfs
>> node would genere interrupt whenever proximity data falls
>> outside threshold limit <m> number of times.
>>
> <snip>
>
>> +static ssize_t ltr501_read_intr_prst(struct iio_dev *indio_dev,
>> +                                  uintptr_t private,
>> +                                  const struct iio_chan_spec *chan,
>> +                                  char *buf)
>> +{
>> +       struct ltr501_data *data = iio_priv(indio_dev);
>> +       int ret = -EINVAL;
>> +
>> +       switch (chan->type) {
>> +       case IIO_INTENSITY:
>> +               mutex_lock(&data->lock_als);
>> +               ret = i2c_smbus_read_byte_data(data->client, LTR501_INTR_PRST);
>> +               mutex_unlock(&data->lock_als);
> I am not sure I understand why is the mutex needed here? AFAIK I2C transactions
> are serialized.
That's mutex is to protect the ALS register updates. I want it 
serialized so that no data can be read when we are changing the control 
settings.
>
> <snip>
>
>> +static const struct iio_chan_spec_ext_info ltr501_ext_info[] = {
>> +       {
>> +               .name = "intr_persist",
>> +               .read = ltr501_read_intr_prst,
>> +               .write = ltr501_write_intr_prst,
>> +               .shared = IIO_SHARED_BY_TYPE,
>> +       },
>> +       {},
>> +};
>> +
> Would be nice to standardize persistence attribute (IIO_CHAN_INFO_PERSISTENCE).
Agreed. I will work on it.
>
> thanks,
> Daniel.
>

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer
