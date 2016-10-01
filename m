Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35141 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbcJALlG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 07:41:06 -0400
MIME-Version: 1.0
In-Reply-To: <743239c7-8341-6fdf-b493-ac98a4853322@kernel.org>
References: <1475315838-15366-1-git-send-email-bhumirks@gmail.com> <743239c7-8341-6fdf-b493-ac98a4853322@kernel.org>
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Sat, 1 Oct 2016 17:11:03 +0530
Message-ID: <CAOH+1jH-DfgJsydgEaNPBNt6REL=CStT3iGwaSROwJCfR3wW5g@mail.gmail.com>
Subject: Re: [PATCH] iio: Declare event_attrs field of iio_info structure as const
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Oct 1, 2016 at 4:39 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 01/10/16 10:57, Bhumika Goyal wrote:
>> The event_attrs field of iio_info structure is only initialized once
>> whenever an object of iio_info is created. After that this field
>> is never modified again anywhere in the kernel. So, declare event_attrs
>> field of iio_info as a const struct attribute_group.
>> Checked for occurences throughout the kernel using grep and
>> coccinelle.
>>
>> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
>
> Clearly this becomes more interesting when the follow up patches
> making ever event_attr group we can constant.
> Looking forward to those ;)
>
Yeah sure, I will definitely submit the follow up patches. :D

Thanks,
Bhumika
>
> Jonathan
>> ---
>>  include/linux/iio/iio.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index b4a0679..4591d8e 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -381,7 +381,7 @@ struct iio_dev;
>>   **/
>>  struct iio_info {
>>       struct module                   *driver_module;
>> -     struct attribute_group          *event_attrs;
>> +     const struct attribute_group    *event_attrs;
>>       const struct attribute_group    *attrs;
>>
>>       int (*read_raw)(struct iio_dev *indio_dev,
>>
>
