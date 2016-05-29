Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33669 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbcE2RGU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 13:06:20 -0400
Subject: Re: [PATCH 2/7] iio: adc: ad7791: claim direct mode when writing
 frequency
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Alison Schofield <amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
 <b115a245427767bd4c2fd4242b7ee04a243008b3.1464115008.git.amsfield22@gmail.com>
 <CAEnQRZAdj1fn8ibNx1pCA44=DwDGP8yfMPwGfNCeiW24g97kJg@mail.gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ba579602-3808-f193-f8c0-1edb40f911a7@kernel.org>
Date: Sun, 29 May 2016 18:06:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZAdj1fn8ibNx1pCA44=DwDGP8yfMPwGfNCeiW24g97kJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/05/16 11:34, Daniel Baluta wrote:
> On Tue, May 24, 2016 at 10:16 PM, Alison Schofield <amsfield22@gmail.com> wrote:
>> Driver was checking for direct mode and trying to lock it, but
>> left a gap where mode could change before the desired operation.
>> Use iio_device_claim_direct_mode() to guarantee device stays in
>> direct mode.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
>> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> 
> Looks good to me. We could use an Acked-by from Lars here.
> 
> Acked-by: Daniel Baluta <daniel.baluta@gmail.com>
This one is a little more interesting.  I wonder if we wouldn't be better
off taking the lock for the whole function rather than dropping it for
short periods.

Can apply such a change at a later date however.

Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
>> ---
>>  drivers/iio/adc/ad7791.c | 15 ++++-----------
>>  1 file changed, 4 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
>> index cf172d58..f7edacc 100644
>> --- a/drivers/iio/adc/ad7791.c
>> +++ b/drivers/iio/adc/ad7791.c
>> @@ -272,24 +272,17 @@ static ssize_t ad7791_write_frequency(struct device *dev,
>>         struct ad7791_state *st = iio_priv(indio_dev);
>>         int i, ret;
>>
>> -       mutex_lock(&indio_dev->mlock);
>> -       if (iio_buffer_enabled(indio_dev)) {
>> -               mutex_unlock(&indio_dev->mlock);
>> -               return -EBUSY;
>> -       }
>> -       mutex_unlock(&indio_dev->mlock);
>> -
>> -       ret = -EINVAL;
>> -
>>         for (i = 0; i < ARRAY_SIZE(ad7791_sample_freq_avail); i++) {
>>                 if (sysfs_streq(ad7791_sample_freq_avail[i], buf)) {
>>
>> -                       mutex_lock(&indio_dev->mlock);
>> +                       ret = iio_device_claim_direct_mode(indio_dev);
>> +                       if (ret)
>> +                               return ret;
>>                         st->filter &= ~AD7791_FILTER_RATE_MASK;
>>                         st->filter |= i;
>>                         ad_sd_write_reg(&st->sd, AD7791_REG_FILTER,
>>                                          sizeof(st->filter), st->filter);
>> -                       mutex_unlock(&indio_dev->mlock);
>> +                       iio_device_release_direct_mode(indio_dev);
>>                         ret = 0;
>>                         break;
>>                 }
>> --
>> 2.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

