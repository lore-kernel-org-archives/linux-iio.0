Return-Path: <lars@metafoo.de>
Message-ID: <5422A10E.1070409@metafoo.de>
Date: Wed, 24 Sep 2014 12:46:38 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] staging:iio:ad5933: Report temperature as raw value
References: <1411495448-17941-1-git-send-email-lars@metafoo.de>	<1411495448-17941-3-git-send-email-lars@metafoo.de> <CAEnQRZA8t9VbDCe7yUwVTJQNo7fLT9_b6XpxFFjHAfUJojfzMA@mail.gmail.com>
In-Reply-To: <CAEnQRZA8t9VbDCe7yUwVTJQNo7fLT9_b6XpxFFjHAfUJojfzMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 09/24/2014 10:02 AM, Daniel Baluta wrote:
>> @@ -543,14 +543,13 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
>>                  if (ret < 0)
>>                          goto out;
>>                  mutex_unlock(&indio_dev->mlock);
>> -               ret = be16_to_cpu(dat);
>> -               /* Temp in Milli degrees Celsius */
>> -               if (ret < 8192)
>> -                       *val = ret * 1000 / 32;
>> -               else
>> -                       *val = (ret - 16384) * 1000 / 32;
>> +               *val = sign_extend32(be16_to_cpu(dat), 13);
>>
>>                  return IIO_VAL_INT;
>> +       case IIO_CHAN_INFO_SCALE:
>> +               *val = 1000;
>> +               *val2 = 5;
>> +               return IIO_VAL_FRACTIONAL_LOG2;
>>          }
>>
>>   out:
>
> Is it possible to reach this line with mutex not acquired?
>
> out:
>        mutex_unlock(&indio_dev->mlock);
>        return ret;
>

It is not possible, but you are right the code should be restructured to 
make this more clear.

Thanks.
- Lars
