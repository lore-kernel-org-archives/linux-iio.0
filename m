Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34043 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315AbcE2Sj1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 14:39:27 -0400
Subject: Re: [PATCH 7/7] iio: adc: ad799x: use iio helper function to
 guarantee direct mode
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
 <2df3d20cdbc9c3294ef91b515dcdfe0ad151bd01.1464115008.git.amsfield22@gmail.com>
 <CAEnQRZBAqO4RSZ=NtVOnVvAd08yBQzQ=mXFUxoN7eHM+xBdNjA@mail.gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8ebfb75f-706a-4300-b8f5-7d2e7300a2de@kernel.org>
Date: Sun, 29 May 2016 19:39:25 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZBAqO4RSZ=NtVOnVvAd08yBQzQ=mXFUxoN7eHM+xBdNjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/05/16 11:42, Daniel Baluta wrote:
> On Tue, May 24, 2016 at 10:20 PM, Alison Schofield <amsfield22@gmail.com> wrote:
>> Replace the code that guarantees the device stays in direct mode
>> with iio_device_claim_direct_mode() which does same.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> 
> Acked-by: Daniel Baluta <daniel.baluta@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> 
> 
>> ---
>>  drivers/iio/adc/ad799x.c | 24 +++++++++---------------
>>  1 file changed, 9 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
>> index a3f5254..ec0200d 100644
>> --- a/drivers/iio/adc/ad799x.c
>> +++ b/drivers/iio/adc/ad799x.c
>> @@ -282,12 +282,11 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
>>
>>         switch (m) {
>>         case IIO_CHAN_INFO_RAW:
>> -               mutex_lock(&indio_dev->mlock);
>> -               if (iio_buffer_enabled(indio_dev))
>> -                       ret = -EBUSY;
>> -               else
>> -                       ret = ad799x_scan_direct(st, chan->scan_index);
>> -               mutex_unlock(&indio_dev->mlock);
>> +               ret = iio_device_claim_direct_mode(indio_dev);
>> +               if (ret)
>> +                       return ret;
>> +               ret = ad799x_scan_direct(st, chan->scan_index);
>> +               iio_device_release_direct_mode(indio_dev);
>>
>>                 if (ret < 0)
>>                         return ret;
>> @@ -395,11 +394,9 @@ static int ad799x_write_event_config(struct iio_dev *indio_dev,
>>         struct ad799x_state *st = iio_priv(indio_dev);
>>         int ret;
>>
>> -       mutex_lock(&indio_dev->mlock);
>> -       if (iio_buffer_enabled(indio_dev)) {
>> -               ret = -EBUSY;
>> -               goto done;
>> -       }
>> +       ret = iio_device_claim_direct_mode(indio_dev);
>> +       if (ret)
>> +               return ret;
>>
>>         if (state)
>>                 st->config |= BIT(chan->scan_index) << AD799X_CHANNEL_SHIFT;
>> @@ -412,10 +409,7 @@ static int ad799x_write_event_config(struct iio_dev *indio_dev,
>>                 st->config &= ~AD7998_ALERT_EN;
>>
>>         ret = ad799x_write_config(st, st->config);
>> -
>> -done:
>> -       mutex_unlock(&indio_dev->mlock);
>> -
>> +       iio_device_release_direct_mode(indio_dev);
>>         return ret;
>>  }
>>
>> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

