Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52042 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbcFKPyP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2016 11:54:15 -0400
Subject: Re: [PATCH] iio: light: gp2ap020a00f: use iio helper function to lock
 direct mode
To: Jacek Anaszewski <j.anaszewski@samsung.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <20160608001856.GA15114@d830.WORKGROUP>
 <5757C69B.6060502@samsung.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <74b809a6-b771-d59f-e4e8-88ed7c21c0d3@kernel.org>
Date: Sat, 11 Jun 2016 16:54:12 +0100
MIME-Version: 1.0
In-Reply-To: <5757C69B.6060502@samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/06/16 08:17, Jacek Anaszewski wrote:
> Hi Alison,
> 
> On 06/08/2016 02:19 AM, Alison Schofield wrote:
>> Replace the code that guarantees the device stays in direct mode
>> with iio_device_claim_direct_mode() which does same.  Includes a
>> tiny bit of refactoring (single case -> if) and simplified return
>> flow.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
>> ---
>>   drivers/iio/light/gp2ap020a00f.c | 18 +++++-------------
>>   1 file changed, 5 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
>> index 6d41086..af73af3 100644
>> --- a/drivers/iio/light/gp2ap020a00f.c
>> +++ b/drivers/iio/light/gp2ap020a00f.c
>> @@ -1287,22 +1287,14 @@ static int gp2ap020a00f_read_raw(struct iio_dev *indio_dev,
>>       struct gp2ap020a00f_data *data = iio_priv(indio_dev);
>>       int err = -EINVAL;
>>
>> -    mutex_lock(&data->lock);
>> -
>> -    switch (mask) {
>> -    case IIO_CHAN_INFO_RAW:
>> -        if (iio_buffer_enabled(indio_dev)) {
>> -            err = -EBUSY;
>> -            goto error_unlock;
>> -        }
>> +    if (mask == IIO_CHAN_INFO_RAW) {
>> +        err = iio_device_claim_direct_mode(indio_dev);
>> +        if (err)
>> +            return err;
>>
>>           err = gp2ap020a00f_read_channel(data, chan, val);
>> -        break;
>> +        iio_device_release_direct_mode(indio_dev);
>>       }
>> -
>> -error_unlock:
>> -    mutex_unlock(&data->lock);
>> -
>>       return err < 0 ? err : IIO_VAL_INT;
>>   }
>>
>>
> 
> Nice patch.
> 
> Acked-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

I would have slightly preferred the patch to not change the
case to an if (as really a slightly separate cleanup from
the main target of the patch).

Good changes though!

Thanks,

Jonathan
Thanks,

Jonathan
> 

