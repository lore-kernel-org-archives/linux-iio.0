Return-Path: <reyad.attiyat@gmail.com>
MIME-Version: 1.0
In-Reply-To: <53D2B587.7080506@linux.intel.com>
References: <1406316745-3351-1-git-send-email-reyad.attiyat@gmail.com> <53D2B587.7080506@linux.intel.com>
From: Reyad Attiyat <reyad.attiyat@gmail.com>
Date: Fri, 25 Jul 2014 16:02:22 -0500
Message-ID: <CA+BWVUQVpXZ50XMFhRBooff2573EnHn22E2ebofbKfEjch7gqw@mail.gmail.com>
Subject: Re: [PATCH] iio: hid-sensor-magn-3d: Fix build warning
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Whoops looks like I typed an extra character, sorry should have caught this.
Thanks Sirinivas will resend.

On Fri, Jul 25, 2014 at 2:52 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> On 07/25/2014 12:32 PM, Reyad Attiyat wrote:
>>
>> Fix build warning, sizeof() called on dynamically
>> sized pointer, by removing the call and the dependent
>> function parameter. It is not needed or used in this
>> driver, when pushing values to an iio buffer.
>>
>> Signed-off-by: Reyad Attiyat <reyad.attiyat@gmail.com>
>> ---
>>   drivers/iio/magnetometer/hid-sensor-magn-3d.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
>> b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
>> index 3ec777a..915ffb9 100644
>> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
>> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
>> @@ -246,8 +246,7 @@ static const struct iio_info magn_3d_info = {
>>   };
>>
>>   /* Function to push data to buffer */
>> -static void hid_sensor_push_data(struct iio_dev *indio_dev, const void
>> *data,
>> -       int len)
>> +static void hid_sensor_push_data(struct iio_dev *indio_dev, const void
>> *data)
>>   {
>>         dev_dbg(&indio_dev->dev, "hid_sensor_push_data\n");
>>         iio_push_to_buffers(indio_dev, data);
>> @@ -263,9 +262,7 @@ static int magn_3d_proc_event(struct
>> hid_sensor_hub_device *hsdev,
>>
>>         dev_dbg(&indio_dev->dev, "magn_3d_proc_event\n");
>>         if (atomic_read(&magn_state->common_attributes.data_ready))
>> -               hid_sensor_push_data(indio_dev,
>> -                               magn_state->iio_vals,
>> -                               sizeof(magn_state->iio_vals));
>> +               hid_sensor_push_data(indio_devm, magn_state->iio_vals);
>
> Is it indio_devm,  not indio_dev?
>
> Thanks,
> Srinivas
>>
>>
>>         return 0;
>>   }
>>
>
