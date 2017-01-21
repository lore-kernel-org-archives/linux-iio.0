Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34497 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdAUMWl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 07:22:41 -0500
Subject: Re: [PATCH] iio: proximity: sx9500: claim direct mode during raw
 proximity reads
To: Vlad Dogaru <ddvlad@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>
References: <20170120221123.GA22905@d830.WORKGROUP>
 <CAA+rx9TfvFH2JaCcD6OCjB3f1iUWrMgTZCwuOBUUuVP8HUitgA@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <aa2b2d4d-c531-7463-f1d5-1128918f4eeb@kernel.org>
Date: Sat, 21 Jan 2017 12:22:39 +0000
MIME-Version: 1.0
In-Reply-To: <CAA+rx9TfvFH2JaCcD6OCjB3f1iUWrMgTZCwuOBUUuVP8HUitgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/01/17 08:49, Vlad Dogaru wrote:
> On Fri, Jan 20, 2017 at 11:11 PM, Alison Schofield <amsfield22@gmail.com> wrote:
>> Driver was checking for direct mode but not locking it.  Use the
>> claim/release helper functions to guarantee the device stays in
>> direct mode during raw reads of proximity data.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> 
> Reviewed-by: Vlad Dogaru <ddvlad@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> 
>> ---
>>  drivers/iio/proximity/sx9500.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
>> index 1f06282..9ea147f 100644
>> --- a/drivers/iio/proximity/sx9500.c
>> +++ b/drivers/iio/proximity/sx9500.c
>> @@ -387,14 +387,18 @@ static int sx9500_read_raw(struct iio_dev *indio_dev,
>>                            int *val, int *val2, long mask)
>>  {
>>         struct sx9500_data *data = iio_priv(indio_dev);
>> +       int ret;
>>
>>         switch (chan->type) {
>>         case IIO_PROXIMITY:
>>                 switch (mask) {
>>                 case IIO_CHAN_INFO_RAW:
>> -                       if (iio_buffer_enabled(indio_dev))
>> -                               return -EBUSY;
>> -                       return sx9500_read_proximity(data, chan, val);
>> +                       ret = iio_device_claim_direct_mode(indio_dev);
>> +                       if (ret)
>> +                               return ret;
>> +                       ret = sx9500_read_proximity(data, chan, val);
>> +                       iio_device_release_direct_mode(indio_dev);
>> +                       return ret;
>>                 case IIO_CHAN_INFO_SAMP_FREQ:
>>                         return sx9500_read_samp_freq(data, val, val2);
>>                 default:
>> --
>> 2.1.4
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

