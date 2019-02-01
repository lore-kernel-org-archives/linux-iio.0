Return-Path: <SRS0=jBoM=QI=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5ACC282D8
	for <linux-iio@archiver.kernel.org>; Fri,  1 Feb 2019 05:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D750F21726
	for <linux-iio@archiver.kernel.org>; Fri,  1 Feb 2019 05:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfBAFsE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:48:04 -0500
Received: from anchovy3.45ru.net.au ([203.30.46.155]:51131 "EHLO
        anchovy3.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfBAFsE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Feb 2019 00:48:04 -0500
Received: (qmail 12633 invoked by uid 5089); 1 Feb 2019 05:48:00 -0000
Received: by simscan 1.2.0 ppid: 12560, pid: 12561, t: 0.0741s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
Received: from unknown (HELO ?192.168.0.122?) (preid@electromag.com.au@203.59.235.95)
  by anchovy2.45ru.net.au with ESMTPA; 1 Feb 2019 05:48:00 -0000
Subject: Re: [PATCH 1/1] iio: core: Improve precision of __iio_format_value
 for FRACTIONAL values
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <1548743212-83787-1-git-send-email-preid@electromag.com.au>
 <CA+U=Dso+_dn4mEew5y62nGg8AmEABOCnV9aFgHvQV9WsM0enrA@mail.gmail.com>
 <20364822-e17d-5386-cd97-f244fa32f665@electromag.com.au>
 <20190131133517.0000716d@huawei.com>
From:   Phil Reid <preid@electromag.com.au>
Message-ID: <b677dff8-11f5-abcd-6277-21490ce95a3b@electromag.com.au>
Date:   Fri, 1 Feb 2019 13:47:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190131133517.0000716d@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 31/01/2019 9:35 pm, Jonathan Cameron wrote:
> On Tue, 29 Jan 2019 17:11:25 +0800
> Phil Reid <preid@electromag.com.au> wrote:
> 
>> G'day Alex,
>>
>> On 29/01/2019 4:32 pm, Alexandru Ardelean wrote:
>>> On Tue, Jan 29, 2019 at 8:28 AM Phil Reid <preid@electromag.com.au> wrote:
>>>>
>>>> Currently FRACTIONAL values are outputed with 9 digits after the decimal
>>>> place. This is not always sufficient to resolve the raw value with 1 bit.
>>>> Output FRACTIONAL values to 15 decimal places of precision, regardless
>>>> of the number of leading zeros.
>>>>
>>>> Currently for a 2.5V ref with 24 bits of precision the code outputs only
>>>> to 9 decimal places.
>>>>
>>>> Cur: 0.00014901100000000000 * 16777216 = 2499.989733
>>>> New: 0.00014901161193847600 * 16777216 = 2500.000000
>>>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>>>> ---
>>>>
>>>> Notes:
>>>>       Alternatively I could add additonal FRACTIONAL types that select the new
>>>>       behaviour to prevent any possible regressions.
>>>>
>>>>    drivers/iio/industrialio-core.c | 55 ++++++++++++++++++++++++++++++++++-------
>>>>    1 file changed, 46 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>>>> index a062cfd..bd9da64 100644
>>>> --- a/drivers/iio/industrialio-core.c
>>>> +++ b/drivers/iio/industrialio-core.c
>>>> @@ -571,11 +571,53 @@ int of_iio_read_mount_matrix(const struct device *dev,
>>>>    #endif
>>>>    EXPORT_SYMBOL(of_iio_read_mount_matrix);
>>>>
>>>> +static ssize_t __iio_format_div_prec(char *buf, unsigned int len, s64 x, s32 y)
>>>> +{
>>>> +       unsigned int prec = 0;
>>>> +       unsigned int idx = 0;
>>>> +       s64 d;
>>>> +
>>>> +       if (!len)
>>>> +               return 0;
>>>> +
>>>> +       if (!y)
>>>> +               return snprintf(buf, len, "inf");
>>>> +
>>>> +       if (!x)
>>>> +               return snprintf(buf, len, "0");
>>>> +
>>>> +       if (((x > 0) && (y < 0)) || ((x < 0) && (y > 0))) {
>>>> +               buf[idx++] = '-';
>>>> +               x = x > 0 ? x : -x;
>>>> +               y = y > 0 ? y : -y;
>>>> +       }
>>>> +
>>>> +       d = div64_s64(x, y);
>>>> +       idx += snprintf(buf+idx, len-idx, "%d", (int)d);
>>>> +       x = x - (y * d);
>>>> +       if ((x != 0) && (idx < len-1)) {
>>>> +               buf[idx++] = '.';
>>>> +               x = x * 10;
>>>> +               d = div64_s64(x, y);
>>>> +
>>>> +               while ((idx < len-1) && (prec < 15)) {
>>>> +                       if (d || prec)
>>>> +                               prec++;
>>>> +                       buf[idx++] = '0' + (char)d;
>>>> +                       x = x - (y * d);
>>>> +                       if (!x)
>>>> +                               break;
>>>> +                       x = x * 10;
>>>> +                       d = div64_s64(x, y);
>>>> +               }
>>>> +               buf[idx] = 0;
>>>> +       }
>>>> +       return idx;
>>>> +}
>>>> +
>>>>    static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>>>>                                     int size, const int *vals)
>>>>    {
>>>> -       unsigned long long tmp;
>>>> -       int tmp0, tmp1;
>>>>           bool scale_db = false;
>>>>
>>>>           switch (type) {
>>>> @@ -598,14 +640,9 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>>>>                   else
>>>>                           return snprintf(buf, len, "%d.%09u", vals[0], vals[1]);
>>>>           case IIO_VAL_FRACTIONAL:
>>>> -               tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
>>>> -               tmp1 = vals[1];
>>>> -               tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
>>>> -               return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
>>>> +               return __iio_format_div_prec(buf, len, vals[0], vals[1]);
>>>
>>> Maybe I'm a bit naive, but I'm also a bit curious.
>>> If you just bump the numbers here, would it work the same ?
>>>
>>> i.e.   10^9 -> 10^15 and "snprintf(buf, len, "%d.%15u", tmp0, abs(tmp1));"
>> I did look at that solution.
>>
>> But I was running into overflow issues (even with 64 bit numbers).
>>
>> eg: with a 2500 reference and 32 bits.
>>
>> 2500 * 10^15 = 2e+18 = 61 bits
>> And the result of
>> 2500 / 2^32 =  0.000000582076609
>> Only provides 9 significant digits with 15 decimal places.
>>
>> I was looking to provide 15 significant digits to match a standard double
>> precision floating point value.
> 
> I'll ask the awkward engineering question.  Is this precision actually valid?
> I.e. typical voltage references are +- 0.0x %
> 
> The fact we have a 32 bit ADC means you'll detect small changes, but I'm
> dubious about whether the absolute value will ever be 'that good'.
> 
> If we are going to go out of way to support greater precision we need
> a strong justification of why.
> To take advantage of these high precision devices you need to take into
> account non linear effects, temperature etc.  These will swamp (I think)
> any effect of a lack of precision the scale value.
> 

All valid points.

9 signification digits is probably fine.
However the current formatting doesn't always provide 9 significant digits.
So I believe this can start to add significant error.


Some typical ref voltages using 32 bit scale.
         scale          iio scale    err               err%
2500  5.820766091E-07  0.000000582  -7.660913467E-11  -0.0132%
3000  6.984919310E-07  0.000000698  -4.919309616E-10  -0.0705%
3300  7.683411241E-07  0.000000768  -3.411240578E-10  -0.0444%
5000  1.164153218E-06  0.000001164  -1.532182693E-10  -0.0132%

Looking at other drivers they seem to adjust the scale figure based on gain
selection as well. Is this expected?

If so when adding gain eg: x100

       scale            iio scale     err              err%
2500  5.820766091E-09  0.000000005  -8.207660913E-10  -16%
3000  6.984919310E-09  0.000000006  -9.849193096E-10  -16%
3300  7.683411241E-09  0.000000007  -6.834112406E-10  -10%
5000  1.164153218E-08  0.000000011  -6.415321827E-10  -6%

The limited number of significant digits is swamping everything else.

even at 24bit with gain 1x00

       scale            iio scale     err              err%
2500  1.490116119E-06  0.000001490  -1.161193848E-10  -0.01%
3000  1.788139343E-06  0.000001788  -1.393432617E-10  -0.01%
3300  1.966953278E-06  0.000001966  -9.532775879E-10  -0.05%
5000  2.980232239E-06  0.000002980  -2.322387695E-10  -0.01%


Similarly this while also affect the accuracy of values mapped thru the
rescale driver.



-- 
Regards
Phil Reid

ElectroMagnetic Imaging Technology Pty Ltd
Development of Geophysical Instrumentation & Software
www.electromag.com.au

3 The Avenue, Midland WA 6056, AUSTRALIA
Ph: +61 8 9250 8100
Fax: +61 8 9250 7100
Email: preid@electromag.com.au
