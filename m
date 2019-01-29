Return-Path: <SRS0=/rIq=QF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1385C169C4
	for <linux-iio@archiver.kernel.org>; Tue, 29 Jan 2019 09:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB3C2177E
	for <linux-iio@archiver.kernel.org>; Tue, 29 Jan 2019 09:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfA2JLa (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:11:30 -0500
Received: from anchovy2.45ru.net.au ([203.30.46.146]:37274 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfA2JLa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Jan 2019 04:11:30 -0500
Received: (qmail 5879 invoked by uid 5089); 29 Jan 2019 09:11:28 -0000
Received: by simscan 1.2.0 ppid: 5775, pid: 5780, t: 0.0659s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.122?) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 29 Jan 2019 09:11:27 -0000
Subject: Re: [PATCH 1/1] iio: core: Improve precision of __iio_format_value
 for FRACTIONAL values
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <1548743212-83787-1-git-send-email-preid@electromag.com.au>
 <CA+U=Dso+_dn4mEew5y62nGg8AmEABOCnV9aFgHvQV9WsM0enrA@mail.gmail.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <20364822-e17d-5386-cd97-f244fa32f665@electromag.com.au>
Date:   Tue, 29 Jan 2019 17:11:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CA+U=Dso+_dn4mEew5y62nGg8AmEABOCnV9aFgHvQV9WsM0enrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

G'day Alex,

On 29/01/2019 4:32 pm, Alexandru Ardelean wrote:
> On Tue, Jan 29, 2019 at 8:28 AM Phil Reid <preid@electromag.com.au> wrote:
>>
>> Currently FRACTIONAL values are outputed with 9 digits after the decimal
>> place. This is not always sufficient to resolve the raw value with 1 bit.
>> Output FRACTIONAL values to 15 decimal places of precision, regardless
>> of the number of leading zeros.
>>
>> Currently for a 2.5V ref with 24 bits of precision the code outputs only
>> to 9 decimal places.
>>
>> Cur: 0.00014901100000000000 * 16777216 = 2499.989733
>> New: 0.00014901161193847600 * 16777216 = 2500.000000
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>> ---
>>
>> Notes:
>>      Alternatively I could add additonal FRACTIONAL types that select the new
>>      behaviour to prevent any possible regressions.
>>
>>   drivers/iio/industrialio-core.c | 55 ++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 46 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index a062cfd..bd9da64 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -571,11 +571,53 @@ int of_iio_read_mount_matrix(const struct device *dev,
>>   #endif
>>   EXPORT_SYMBOL(of_iio_read_mount_matrix);
>>
>> +static ssize_t __iio_format_div_prec(char *buf, unsigned int len, s64 x, s32 y)
>> +{
>> +       unsigned int prec = 0;
>> +       unsigned int idx = 0;
>> +       s64 d;
>> +
>> +       if (!len)
>> +               return 0;
>> +
>> +       if (!y)
>> +               return snprintf(buf, len, "inf");
>> +
>> +       if (!x)
>> +               return snprintf(buf, len, "0");
>> +
>> +       if (((x > 0) && (y < 0)) || ((x < 0) && (y > 0))) {
>> +               buf[idx++] = '-';
>> +               x = x > 0 ? x : -x;
>> +               y = y > 0 ? y : -y;
>> +       }
>> +
>> +       d = div64_s64(x, y);
>> +       idx += snprintf(buf+idx, len-idx, "%d", (int)d);
>> +       x = x - (y * d);
>> +       if ((x != 0) && (idx < len-1)) {
>> +               buf[idx++] = '.';
>> +               x = x * 10;
>> +               d = div64_s64(x, y);
>> +
>> +               while ((idx < len-1) && (prec < 15)) {
>> +                       if (d || prec)
>> +                               prec++;
>> +                       buf[idx++] = '0' + (char)d;
>> +                       x = x - (y * d);
>> +                       if (!x)
>> +                               break;
>> +                       x = x * 10;
>> +                       d = div64_s64(x, y);
>> +               }
>> +               buf[idx] = 0;
>> +       }
>> +       return idx;
>> +}
>> +
>>   static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>>                                    int size, const int *vals)
>>   {
>> -       unsigned long long tmp;
>> -       int tmp0, tmp1;
>>          bool scale_db = false;
>>
>>          switch (type) {
>> @@ -598,14 +640,9 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>>                  else
>>                          return snprintf(buf, len, "%d.%09u", vals[0], vals[1]);
>>          case IIO_VAL_FRACTIONAL:
>> -               tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
>> -               tmp1 = vals[1];
>> -               tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
>> -               return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
>> +               return __iio_format_div_prec(buf, len, vals[0], vals[1]);
> 
> Maybe I'm a bit naive, but I'm also a bit curious.
> If you just bump the numbers here, would it work the same ?
> 
> i.e.   10^9 -> 10^15 and "snprintf(buf, len, "%d.%15u", tmp0, abs(tmp1));"
I did look at that solution.

But I was running into overflow issues (even with 64 bit numbers).

eg: with a 2500 reference and 32 bits.

2500 * 10^15 = 2e+18 = 61 bits
And the result of
2500 / 2^32 =  0.000000582076609
Only provides 9 significant digits with 15 decimal places.

I was looking to provide 15 significant digits to match a standard double
precision floating point value.

Proposed solution seemed to work with a wider range, but I admit it's not elegant.
Certainly interested in other peoples ideas.

My alternative thought was to introduce a new type that returns the scale
as a rational. eg: return string like
scale_rational = 2500/4294967296

But that'd require existing user space to become aware of the new format.


> 
> But in any case, what would be interesting now, is to extend the IIO
> core logic to provide [somehow] a precision number, default being 9.
> This could probably be specified on per-channel basis [somehow],
> similar to other channel params.
> 
> So, for example in the default case, if you have "uint32_t precision =
> 9", you would have the same behavior, with something like
> 
>        tmp = div_s64((s64)vals[0] * pow_of_10(precision), vals[1]);
>        tmp1 = vals[1];
>        tmp0 = (int)div_s64_rem(tmp, pow_of_10(precision), &tmp1);
>        return snprintf(buf, len, "%d.%" precision "u", tmp0, abs(tmp1));
> 
> Obviously, the above code is just pseudo-code, where pow_of_10()
> multiplies 10 a "precision" number of times, and the snprintf() would
> need a temporary buffer to create a format string, which then would be
> used.

Good idea to have some kind of overide, I'll have a look

> 
> Thanks
> Alex
> 
>>          case IIO_VAL_FRACTIONAL_LOG2:
>> -               tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
>> -               tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
>> -               return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
>> +               return __iio_format_div_prec(buf, len, vals[0], 1 << vals[1]);
>>          case IIO_VAL_INT_MULTIPLE:
>>          {
>>                  int i;
>> --
>> 1.8.3.1
>>
> 
> 


-- 
Regards
Phil Reid

