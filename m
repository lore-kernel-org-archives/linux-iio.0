Return-Path: <SRS0=+A5L=2W=gmail.com=karniksayli1995@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170312222738.GB14070@d830.WORKGROUP>
References: <cover.1489356140.git.karniksayli1995@gmail.com>
 <59ddccc600cfd1594dcb4dadb44b80328fc06008.1489356140.git.karniksayli1995@gmail.com>
 <20170312222738.GB14070@d830.WORKGROUP>
From: sayli karnik <karniksayli1995@gmail.com>
Date: Mon, 13 Mar 2017 12:47:17 +0530
Message-ID: <CAKG5xWiGGZrRJ7wDFgh7HcwJvL1--A+YBT+4yjyJ=AMH7KFqiQ@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH v2 2/2] staging: iio: ad9834: Remove
 unnecessary goto label and compress return logic
To: Alison Schofield <amsfield22@gmail.com>
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 13, 2017 at 3:57 AM, Alison Schofield <amsfield22@gmail.com> wrote:
> On Mon, Mar 13, 2017 at 03:49:13AM +0530, sayli karnik wrote:
>> The patch removes excessive goto label and compresses return logic.
>>
>> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
>> ---
>>  drivers/staging/iio/frequency/ad9834.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
>> index 60461a6..18f3e8f 100644
>> --- a/drivers/staging/iio/frequency/ad9834.c
>> +++ b/drivers/staging/iio/frequency/ad9834.c
>> @@ -147,9 +147,8 @@ static ssize_t ad9834_write(struct device *dev,
>>       int ret;
>>       unsigned long val;
>>
>> -     ret = kstrtoul(buf, 10, &val);
>> -     if (ret)
>> -             goto error_ret;
>> +     if (kstrtoul(buf, 10, &val))
>> +             return kstrtoul(buf, 10, &val);
>
> Will a smaller change suffice?
>
Yes, sending a solution without having to call the function twice.

> ret = kstrtoul(buf, 10, &val);
> if (ret)
> -       goto error_ret;
> +       return ret;
>
> alisons
>
>>
>>       mutex_lock(&st->lock);
>>       switch ((u32)this_attr->address) {
>> @@ -211,7 +210,6 @@ static ssize_t ad9834_write(struct device *dev,
>>       }
>>       mutex_unlock(&st->lock);
>>
>> -error_ret:
>>       return ret ? ret : len;
>>  }
>>
>> --
>> 2.7.4
>>
>> --
>> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
>> To post to this group, send email to outreachy-kernel@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/59ddccc600cfd1594dcb4dadb44b80328fc06008.1489356140.git.karniksayli1995%40gmail.com.
>> For more options, visit https://groups.google.com/d/optout.
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170312222738.GB14070%40d830.WORKGROUP.
> For more options, visit https://groups.google.com/d/optout.
