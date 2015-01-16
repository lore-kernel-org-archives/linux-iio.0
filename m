Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33195 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbbAQNvd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 17 Jan 2015 08:51:33 -0500
Message-ID: <54B995AC.2040003@kernel.org>
Date: Fri, 16 Jan 2015 22:50:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael.Hennerich@analog.com, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: light: tcs3414: Fix misindented lines
References: <1421360702-1488-1-git-send-email-roberta.dobrescu@gmail.com> <CAEnQRZDCaWcs-Kqfh6EfW_Ax24KmkdAycu=6XC0AnGh+2zri_w@mail.gmail.com>
In-Reply-To: <CAEnQRZDCaWcs-Kqfh6EfW_Ax24KmkdAycu=6XC0AnGh+2zri_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/01/15 09:38, Daniel Baluta wrote:
> On Fri, Jan 16, 2015 at 12:25 AM, Roberta Dobrescu
> <roberta.dobrescu@gmail.com> wrote:
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to a branch that will get pushed out as testing and at probably
then rebased so I'm not lagging quite so far behind mainline...

Anyhow, it'll hit togreg sometime soonish!

Thanks,

Jonathan
> 
>> ---
>>  drivers/iio/light/tcs3414.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
>> index a9e449b..71c2bde 100644
>> --- a/drivers/iio/light/tcs3414.c
>> +++ b/drivers/iio/light/tcs3414.c
>> @@ -149,8 +149,8 @@ static int tcs3414_read_raw(struct iio_dev *indio_dev,
>>                 *val = ret;
>>                 return IIO_VAL_INT;
>>         case IIO_CHAN_INFO_SCALE:
>> -       i = (data->gain & TCS3414_GAIN_MASK) >> TCS3414_GAIN_SHIFT;
>> -       *val = tcs3414_scales[i][0];
>> +               i = (data->gain & TCS3414_GAIN_MASK) >> TCS3414_GAIN_SHIFT;
>> +               *val = tcs3414_scales[i][0];
>>                 *val2 = tcs3414_scales[i][1];
>>                 return IIO_VAL_INT_PLUS_MICRO;
>>         case IIO_CHAN_INFO_INT_TIME:
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

