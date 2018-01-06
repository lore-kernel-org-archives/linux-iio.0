Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36582 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753092AbeAFNdK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 Jan 2018 08:33:10 -0500
MIME-Version: 1.0
In-Reply-To: <20180106124232.5f6609fb@archlinux>
References: <1515083791-19049-1-git-send-email-pundirsumit11@gmail.com> <20180106124232.5f6609fb@archlinux>
From: Sumit Pundir <pundirsumit11@gmail.com>
Date: Sat, 6 Jan 2018 19:03:09 +0530
Message-ID: <CAKunu93CPAo29-giyTEOGyU7LHZOSLfXWSSo5poB_-dMfkiDaw@mail.gmail.com>
Subject: Re: [PATCH] Staging: iio: Prefer using BIT macro
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jan 6, 2018 at 6:12 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu,  4 Jan 2018 22:06:31 +0530
> Sumit Pundir <pundirsumit11@gmail.com> wrote:
>
> Patch title needs to mention the specific driver being changed.
>
>> This patch fixes the following checkpatch.pl error at multiple lines:
>>
>> CHECK: Prefer using the BIT macro
>>
>> Signed-off-by: Sumit Pundir <pundirsumit11@gmail.com>
>
> The BIT Macros is just fine if they are actually a single bit field.
> Some of these are not. See below.
>
> You really have to check the datasheet to be sure on these though
> in the cases here it's obvious from the surrounding lines.
>
> Changing those ones to BIT will actively hurt readability.
>
> Anyhow, the other cases are good so if you can prepare a patch
> changing just that and ensd it that would be great.
>> ---
>>  drivers/staging/iio/cdc/ad7152.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
>> index 59d1b35..b2b15b9 100644
>> --- a/drivers/staging/iio/cdc/ad7152.c
>> +++ b/drivers/staging/iio/cdc/ad7152.c
>> @@ -47,24 +47,24 @@
>>  #define AD7152_STATUS_PWDN           BIT(7)
>>
>>  /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
>> -#define AD7152_SETUP_CAPDIFF         (1 << 5)
>> +#define AD7152_SETUP_CAPDIFF         BIT(5)
>
> This is indeed a 1 bit field so fine.
>
>>  #define AD7152_SETUP_RANGE_2pF               (0 << 6)
>> -#define AD7152_SETUP_RANGE_0_5pF     (1 << 6)
>> +#define AD7152_SETUP_RANGE_0_5pF     BIT(6)
> This is clearly putting the value 1 in a 2 bit field within
> the register - BIT macro obscures this compeltely.
>>  #define AD7152_SETUP_RANGE_1pF               (2 << 6)
>>  #define AD7152_SETUP_RANGE_4pF               (3 << 6)
>>  #define AD7152_SETUP_RANGE(x)                ((x) << 6)
>>
>>  /* Config Register Bit Designations (AD7152_REG_CFG) */
>> -#define AD7152_CONF_CH2EN            (1 << 3)
>> -#define AD7152_CONF_CH1EN            (1 << 4)
>> +#define AD7152_CONF_CH2EN            BIT(3)
>> +#define AD7152_CONF_CH1EN            BIT(4)
>
> These two are valid I think.
>
>>  #define AD7152_CONF_MODE_IDLE                (0 << 0)
>> -#define AD7152_CONF_MODE_CONT_CONV   (1 << 0)
>> +#define AD7152_CONF_MODE_CONT_CONV   BIT(0)
>
> This one is not. Again clear from the code let alone checking the
> datasheet. We write 6 to the same location.
>
>>  #define AD7152_CONF_MODE_SINGLE_CONV (2 << 0)
>>  #define AD7152_CONF_MODE_OFFS_CAL    (5 << 0)
>>  #define AD7152_CONF_MODE_GAIN_CAL    (6 << 0)
>>
>>  /* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
>> -#define AD7152_CAPDAC_DACEN          (1 << 7)
>> +#define AD7152_CAPDAC_DACEN          BIT(7)
>
> This one is a 1 bit field so fine.
>

Hi Jonathan,

I will send a v2 of this patch with all the prescribed changes.

Thanks,
Sumit

On Sat, Jan 6, 2018 at 6:12 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On Thu,  4 Jan 2018 22:06:31 +0530
> Sumit Pundir <pundirsumit11@gmail.com> wrote:
>
> Patch title needs to mention the specific driver being changed.
>
>> This patch fixes the following checkpatch.pl error at multiple lines:
>>
>> CHECK: Prefer using the BIT macro
>>
>> Signed-off-by: Sumit Pundir <pundirsumit11@gmail.com>
>
> The BIT Macros is just fine if they are actually a single bit field.
> Some of these are not. See below.
>
> You really have to check the datasheet to be sure on these though
> in the cases here it's obvious from the surrounding lines.
>
> Changing those ones to BIT will actively hurt readability.
>
> Anyhow, the other cases are good so if you can prepare a patch
> changing just that and ensd it that would be great.
>> ---
>>  drivers/staging/iio/cdc/ad7152.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
>> index 59d1b35..b2b15b9 100644
>> --- a/drivers/staging/iio/cdc/ad7152.c
>> +++ b/drivers/staging/iio/cdc/ad7152.c
>> @@ -47,24 +47,24 @@
>>  #define AD7152_STATUS_PWDN           BIT(7)
>>
>>  /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
>> -#define AD7152_SETUP_CAPDIFF         (1 << 5)
>> +#define AD7152_SETUP_CAPDIFF         BIT(5)
>
> This is indeed a 1 bit field so fine.
>
>>  #define AD7152_SETUP_RANGE_2pF               (0 << 6)
>> -#define AD7152_SETUP_RANGE_0_5pF     (1 << 6)
>> +#define AD7152_SETUP_RANGE_0_5pF     BIT(6)
> This is clearly putting the value 1 in a 2 bit field within
> the register - BIT macro obscures this compeltely.
>>  #define AD7152_SETUP_RANGE_1pF               (2 << 6)
>>  #define AD7152_SETUP_RANGE_4pF               (3 << 6)
>>  #define AD7152_SETUP_RANGE(x)                ((x) << 6)
>>
>>  /* Config Register Bit Designations (AD7152_REG_CFG) */
>> -#define AD7152_CONF_CH2EN            (1 << 3)
>> -#define AD7152_CONF_CH1EN            (1 << 4)
>> +#define AD7152_CONF_CH2EN            BIT(3)
>> +#define AD7152_CONF_CH1EN            BIT(4)
>
> These two are valid I think.
>
>>  #define AD7152_CONF_MODE_IDLE                (0 << 0)
>> -#define AD7152_CONF_MODE_CONT_CONV   (1 << 0)
>> +#define AD7152_CONF_MODE_CONT_CONV   BIT(0)
>
> This one is not. Again clear from the code let alone checking the
> datasheet. We write 6 to the same location.
>
>>  #define AD7152_CONF_MODE_SINGLE_CONV (2 << 0)
>>  #define AD7152_CONF_MODE_OFFS_CAL    (5 << 0)
>>  #define AD7152_CONF_MODE_GAIN_CAL    (6 << 0)
>>
>>  /* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
>> -#define AD7152_CAPDAC_DACEN          (1 << 7)
>> +#define AD7152_CAPDAC_DACEN          BIT(7)
>
> This one is a 1 bit field so fine.
>
>>  #define AD7152_CAPDAC_DACP(x)                ((x) & 0x1F)
>>
>>  /* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
>
