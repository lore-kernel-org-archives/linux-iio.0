Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60169 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbdETQIu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2017 12:08:50 -0400
Subject: Re: [PATCH] iio: light: isl29018: Only declare ACPI table when ACPI
 is enabled
To: Guenter Roeck <groeck@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20170519212853.151172-1-mka@chromium.org>
 <CABXOdTeyRJigdSr6EsUTcoc6t6nCBP1u9nMPYTt5_+t-BZ3MnA@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1102f6ab-e457-f0cb-4b71-7f855383949e@kernel.org>
Date: Sat, 20 May 2017 17:08:49 +0100
MIME-Version: 1.0
In-Reply-To: <CABXOdTeyRJigdSr6EsUTcoc6t6nCBP1u9nMPYTt5_+t-BZ3MnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/17 22:57, Guenter Roeck wrote:
> On Fri, May 19, 2017 at 2:28 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
>> This fixes the following warning when building with clang:
>>
>> drivers/iio/light/isl29018.c:808:36: error: variable
>>      'isl29018_acpi_match' is not needed and will not be emitted
>>      [-Werror,-Wunneeded-internal-declaration]
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
I wondered if we would be slightly neater if we went with
__maybe_unused markings but realised I didn't really care enough
to make you respin the patch ;)  So if anyone else has strong
feelings on the two options, shout out now.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> 
>> ---
>>   drivers/iio/light/isl29018.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
>> index 917dd8b43e72..61f5924b472d 100644
>> --- a/drivers/iio/light/isl29018.c
>> +++ b/drivers/iio/light/isl29018.c
>> @@ -807,6 +807,7 @@ static SIMPLE_DEV_PM_OPS(isl29018_pm_ops, isl29018_suspend, isl29018_resume);
>>   #define ISL29018_PM_OPS NULL
>>   #endif
>>
>> +#ifdef CONFIG_ACPI
>>   static const struct acpi_device_id isl29018_acpi_match[] = {
>>          {"ISL29018", isl29018},
>>          {"ISL29023", isl29023},
>> @@ -814,6 +815,7 @@ static const struct acpi_device_id isl29018_acpi_match[] = {
>>          {},
>>   };
>>   MODULE_DEVICE_TABLE(acpi, isl29018_acpi_match);
>> +#endif
>>
>>   static const struct i2c_device_id isl29018_id[] = {
>>          {"isl29018", isl29018},
>> --
>> 2.13.0.303.g4ebf302169-goog
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

