Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34020 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1160999AbcE2Sg4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 14:36:56 -0400
Subject: Re: [PATCH 6/7] iio: adc: ad7923: use iio helper function to
 guarantee direct mode
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
 <50659d12998d47dfe9da2b7bc7fbfc483588e5da.1464115008.git.amsfield22@gmail.com>
 <CAEnQRZDzfS7XJvwOELAHUfw2bfk8LiuZ6aVKGuriO358rHKZyQ@mail.gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b4162192-5e86-fa6e-ed8d-58ce4fa80d97@kernel.org>
Date: Sun, 29 May 2016 19:36:54 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZDzfS7XJvwOELAHUfw2bfk8LiuZ6aVKGuriO358rHKZyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/05/16 11:41, Daniel Baluta wrote:
> On Tue, May 24, 2016 at 10:19 PM, Alison Schofield <amsfield22@gmail.com> wrote:
>> Replace the code that guarantees the device stays in direct mode
>> with iio_device_claim_direct_mode() which does same.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> 
> Acked-by: Daniel Baluta <daniel.baluta@gmail.com>
Applied, - thanks

Jonathan
> 
> 
>> ---
>>  drivers/iio/adc/ad7923.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
>> index 45e29cc..ff444c1 100644
>> --- a/drivers/iio/adc/ad7923.c
>> +++ b/drivers/iio/adc/ad7923.c
>> @@ -233,12 +233,11 @@ static int ad7923_read_raw(struct iio_dev *indio_dev,
>>
>>         switch (m) {
>>         case IIO_CHAN_INFO_RAW:
>> -               mutex_lock(&indio_dev->mlock);
>> -               if (iio_buffer_enabled(indio_dev))
>> -                       ret = -EBUSY;
>> -               else
>> -                       ret = ad7923_scan_direct(st, chan->address);
>> -               mutex_unlock(&indio_dev->mlock);
>> +               ret = iio_device_claim_direct_mode(indio_dev);
>> +               if (ret)
>> +                       return ret;
>> +               ret = ad7923_scan_direct(st, chan->address);
>> +               iio_device_release_direct_mode(indio_dev);
>>
>>                 if (ret < 0)
>>                         return ret;
>> --
>> 2.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

