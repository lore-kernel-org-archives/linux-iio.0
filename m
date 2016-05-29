Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34012 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbcE2Sf5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 14:35:57 -0400
Subject: Re: [PATCH 5/7] iio: adc: ad7887: use iio helper function to
 guarantee direct mode
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
 <cce4f683cecf19937334b4f139aa6419e3bda967.1464115008.git.amsfield22@gmail.com>
 <CAEnQRZALyfvrE1RWe7hOz0quF9iHa+tJwH0dmg2=s39UnyPEsg@mail.gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7cb69ff3-6b0f-abfd-1d1b-51bced440647@kernel.org>
Date: Sun, 29 May 2016 19:35:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZALyfvrE1RWe7hOz0quF9iHa+tJwH0dmg2=s39UnyPEsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/05/16 11:38, Daniel Baluta wrote:
> On Tue, May 24, 2016 at 10:18 PM, Alison Schofield <amsfield22@gmail.com> wrote:
>> Replace the code that guarantees the device stays in direct mode
>> with iio_device_claim_direct_mode() which does same.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> 
> Acked-by: Daniel Baluta <daniel.baluta@gmail.com>
Applied - thanks.

Jonathan
> 
>> ---
>>  drivers/iio/adc/ad7887.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
>> index 2d3c397..ee2ccc1 100644
>> --- a/drivers/iio/adc/ad7887.c
>> +++ b/drivers/iio/adc/ad7887.c
>> @@ -156,12 +156,11 @@ static int ad7887_read_raw(struct iio_dev *indio_dev,
>>
>>         switch (m) {
>>         case IIO_CHAN_INFO_RAW:
>> -               mutex_lock(&indio_dev->mlock);
>> -               if (iio_buffer_enabled(indio_dev))
>> -                       ret = -EBUSY;
>> -               else
>> -                       ret = ad7887_scan_direct(st, chan->address);
>> -               mutex_unlock(&indio_dev->mlock);
>> +               ret = iio_device_claim_direct_mode(indio_dev);
>> +               if (ret)
>> +                       return ret;
>> +               ret = ad7887_scan_direct(st, chan->address);
>> +               iio_device_release_direct_mode(indio_dev);
>>
>>                 if (ret < 0)
>>                         return ret;
>> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

