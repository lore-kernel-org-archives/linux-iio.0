Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41810 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbbJKOoM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2015 10:44:12 -0400
Subject: Re: [PATCH 4/6] iio:dac:m62332: drop unrequired variable
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
 <9a834bd03fd40333cb6e9935e51ecf801c81d38b.1440459082.git.knaack.h@gmx.de>
 <CAEnQRZBm8DDpe82Pju+xF0yLqsuhPnvVXShQvEGHisPymxUkag@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561A75BB.8040200@kernel.org>
Date: Sun, 11 Oct 2015 15:44:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZBm8DDpe82Pju+xF0yLqsuhPnvVXShQvEGHisPymxUkag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/08/15 20:46, Daniel Baluta wrote:
> On Sat, Aug 29, 2015 at 12:59 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
>> A return variable is not required in _write_raw(), and dropping it reduces
>> complexity, as well.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
> 
> Initially forgot to CC linux-iio.
Applied.
> 
>> ---
>>  drivers/iio/dac/m62332.c | 8 ++------
>>  1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
>> index fe750982b502..1b65fc007bce 100644
>> --- a/drivers/iio/dac/m62332.c
>> +++ b/drivers/iio/dac/m62332.c
>> @@ -112,21 +112,17 @@ static int m62332_read_raw(struct iio_dev *indio_dev,
>>  static int m62332_write_raw(struct iio_dev *indio_dev,
>>         struct iio_chan_spec const *chan, int val, int val2, long mask)
>>  {
>> -       int ret;
>> -
>>         switch (mask) {
>>         case IIO_CHAN_INFO_RAW:
>>                 if (val < 0 || val > 255)
>>                         return -EINVAL;
>>
>> -               ret = m62332_set_value(indio_dev, val, chan->channel);
>> -               break;
>> +               return m62332_set_value(indio_dev, val, chan->channel);
>>         default:
>> -               ret = -EINVAL;
>>                 break;
>>         }
>>
>> -       return ret;
>> +       return -EINVAL;
>>  }
>>
>>  #ifdef CONFIG_PM_SLEEP
>> --
>> 2.4.6
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

