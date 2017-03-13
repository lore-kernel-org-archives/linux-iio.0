Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:32993 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbdCMNd3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 09:33:29 -0400
Date: Mon, 13 Mar 2017 09:33:19 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: 104-quad-8: Fix off-by-one error when addressing
 flag register
Message-ID: <20170313133319.GA3607@sophia>
References: <20170209150341.GA29292@sophia>
 <d89a328a-4873-021e-a92b-f0498cb49d03@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <d89a328a-4873-021e-a92b-f0498cb49d03@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Feb 11, 2017 at 09:37:35AM +0000, Jonathan Cameron wrote:
>On 09/02/17 15:03, William Breathitt Gray wrote:
>> The flag register is offset by 1 from the respective channel data
>> register. This patch fixes an off-by-one error when attempting to read a
>> channel flag register where the base address was not properly offset.
>> 
>> Fixes: 28e5d3bb0325 ("iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8")
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>Applied to the fixes-togreg-post-rc1 branch of iio.git
>Clue to when this will go upstream is in the name ;)
>
>Thanks,
>
>Jonathan

Hi Jonathan,

I see that this fix made it into 4.11-rc1 but not the 4.10.2 release.
Is this patch on track to appear in stable, or should I explicitly CC
stable@vger.kernel.org to pick this up?

Thanks,

William Breathitt Gray

>> ---
>>  drivers/iio/counter/104-quad-8.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
>> index a5913e97945e..f9b8fc9ae13f 100644
>> --- a/drivers/iio/counter/104-quad-8.c
>> +++ b/drivers/iio/counter/104-quad-8.c
>> @@ -76,7 +76,7 @@ static int quad8_read_raw(struct iio_dev *indio_dev,
>>  			return IIO_VAL_INT;
>>  		}
>>  
>> -		flags = inb(base_offset);
>> +		flags = inb(base_offset + 1);
>>  		borrow = flags & BIT(0);
>>  		carry = !!(flags & BIT(1));
>>  
>> 
