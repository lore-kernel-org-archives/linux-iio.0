Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36730 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdCAHfk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Mar 2017 02:35:40 -0500
Received: by mail-yw0-f195.google.com with SMTP id 2so3143014ywn.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Feb 2017 23:35:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703010723120.2079@hadrien>
References: <20170301052712.GA19851@sayli-HP-15-Notebook-PC> <alpine.DEB.2.20.1703010723120.2079@hadrien>
From: sayli karnik <karniksayli1995@gmail.com>
Date: Wed, 1 Mar 2017 12:55:18 +0530
Message-ID: <CAKG5xWg5Tb5uH_zioEQWFPowz1WBHMuNMm4xEmo-g4M=ACjyDg@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: ad7280a: Group similar
 macros into enums
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 1, 2017 at 11:53 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Wed, 1 Mar 2017, sayli karnik wrote:
>
>> The patch groups similar macros into enum data types.
>
> Like Alison said, I wonder why you changed the order.
>
Yes that was a mistake, I'll correct that along with other changes by
the reviewers, if any.

thanks,
sayli

> julia
>
>>
>> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
>> ---
>>  drivers/staging/iio/adc/ad7280a.h | 20 ++++++++++++--------
>>  1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7280a.h b/drivers/staging/iio/adc/ad7280a.h
>> index ccfb90d..08e97d4 100644
>> --- a/drivers/staging/iio/adc/ad7280a.h
>> +++ b/drivers/staging/iio/adc/ad7280a.h
>> @@ -13,15 +13,19 @@
>>   * TODO: struct ad7280_platform_data needs to go into include/linux/iio
>>   */
>>
>> -#define AD7280A_ACQ_TIME_400ns                       0
>> -#define AD7280A_ACQ_TIME_800ns                       1
>> -#define AD7280A_ACQ_TIME_1200ns                      2
>> -#define AD7280A_ACQ_TIME_1600ns                      3
>> +enum {
>> +     AD7280A_CONV_AVG_DIS = 0,
>> +     AD7280A_CONV_AVG_2,
>> +     AD7280A_CONV_AVG_4,
>> +     AD7280A_CONV_AVG_8,
>> +};
>>
>> -#define AD7280A_CONV_AVG_DIS                 0
>> -#define AD7280A_CONV_AVG_2                   1
>> -#define AD7280A_CONV_AVG_4                   2
>> -#define AD7280A_CONV_AVG_8                   3
>> +enum {
>> +     AD7280A_ACQ_TIME_400ns = 0,
>> +     AD7280A_ACQ_TIME_800ns,
>> +     AD7280A_ACQ_TIME_1200ns,
>> +     AD7280A_ACQ_TIME_1600ns,
>> +};
>>
>>  #define AD7280A_ALERT_REMOVE_VIN5            BIT(2)
>>  #define AD7280A_ALERT_REMOVE_VIN4_VIN5               BIT(3)
>> --
>> 2.7.4
>>
>> --
>> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
>> To post to this group, send email to outreachy-kernel@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170301052712.GA19851%40sayli-HP-15-Notebook-PC.
>> For more options, visit https://groups.google.com/d/optout.
>>
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/alpine.DEB.2.20.1703010723120.2079%40hadrien.
> For more options, visit https://groups.google.com/d/optout.
