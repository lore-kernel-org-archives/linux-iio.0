Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36942 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754531AbdEULnw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 May 2017 07:43:52 -0400
Subject: Re: [PATCH] iio: imu: inv_mpu6050: test whoami against invalid values
 and do it first
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <BLUPR12MB0657CCC7922C6655D88C9FB0C4E20@BLUPR12MB0657.namprd12.prod.outlook.com>
 <e90a537f-3eb8-2075-9c1d-393890ad1c3c@kernel.org>
 <BLUPR12MB0657D4E46506A1BED6430FCEC4E10@BLUPR12MB0657.namprd12.prod.outlook.com>
 <d7b3b09c-2b4e-d8c5-b0c5-62c18d162091@kernel.org>
 <BLUPR12MB06573DAB544C2B6C067587C4C4E70@BLUPR12MB0657.namprd12.prod.outlook.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dfb943f0-a26f-fa77-9355-a887c9928d3e@kernel.org>
Date: Sun, 21 May 2017 12:43:49 +0100
MIME-Version: 1.0
In-Reply-To: <BLUPR12MB06573DAB544C2B6C067587C4C4E70@BLUPR12MB0657.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/05/17 16:03, Jean-Baptiste Maneyrol wrote:
> 
>> From: Jonathan Cameron <jic23@kernel.org>
>> Sent: Tuesday, May 16, 2017 20:06
>> To: Jean-Baptiste Maneyrol; linux-iio@vger.kernel.org
>> Subject: Re: [PATCH] iio: imu: inv_mpu6050: test whoami against invalid values and do it first
>>      
>> On 15/05/17 09:42, Jean-Baptiste Maneyrol wrote:
>>> Hello,
>>>
>>> this is mainly useful for our test platforms where we want to support
>>> both I2C and SPI configuration with the same kernel image. For that
>>> purpose we declare 2 chips, 1 on I2C and 1 on SPI bus. But on the
>>> hardware there is only 1 chip connected (you can plug it in a I2C or
>>> SPI slot as required). And we expect the driver probe to fail
>>> properly when there is no chip connected on the corresponding bus
>>> (wasn't the case with SPI version).
>>>
>>> In any case if there is a SPI wiring issue somewhere, it is useful to
>>> have the driver probe failing correctly and reporting the issue.
>>> Since SPI transfer are not acked, there always will be a response for
>>> every transaction even if there is no chip behind (this is 0x00 on my
>>> platform, I don't know if there is some "standard" response here).
>>> That's why I am testing whoami reading against these values to ensure
>>> there is a real chip behind.
>>>
>>> I think it is useful to keep the check against ID not preventing the
>>> driver probe to succeed. We have a lot of similar chips with
>>> different IDs, so it can be helpful. Otherwise, I can switch to
>>> checking against ID and add all known IDs.
>> That would be be my preference.  Check against all known and
>> report but don't fail on the 'it is the wrong one' case we
>> all know happens out in the wild!
>>
>> Jonathan
>>
>> p.s. Please don't top post and please wrap lines at 80 chars.
>> I've just broken some threading email clients by wrapping
>> it in this reply... (minor point!)
> 
> We agree on this point, but we are digressing from the issue.
> Sorry my explanations were a bit too long.
> 
> The main point is that the SPI driver probe is not failing when
> there is no chip connected or when the wiring is broken.
> This is a blocking issue for my use case and not very clean anyway.
> The problem is that SPI transactions are never failing even if there is
> a transfer problem. That's not the case with I2C where every
> transactions are acked.
> 
> My solution is to read whoami and test if the value is clearly invalid
> (0x00 or 0xff are obvious invalid whoami that will be never used in any
> invensense chips, and are possible return values for a
> not working SPI wiring). So that we are not blocking the driver probe for
> future possible whoamiI would rather we did block on unknown future whoami values. The part
that is present could be something entirely different.

The 0x00 and 0xff is a kind of convenient hack.  Unless they are clamped
one way or the other you might well get something inbetween on a floating
pin and a random response.

I can see where you are coming from for wanting to allow future flexibility
for whoami values changing, but I'd rather have it clean and consistent.
Normally when there is a whoami change we need minor changes in the driver
anyway to support it properly...
> 
> Is this approach correct for you? Otherwise if you have a better idea,
> it would be welcome.
> 
> Thanks for your help.
> 
> JB
> 
> P.S.: Hope this e-mail is OK. I'm stuck with Outlook WebApp,
> but that's not that bad to use.
You have my sympathies ;)
> 
>>>
>>> Thanks. Jean-Baptiste
>>>
>>> From: Jonathan Cameron <jic23@kernel.org>
>>> Sent: Sunday, May 14, 2017 16:49
>>> To: Jean-Baptiste Maneyrol; linux-iio@vger.kernel.org
>>> Subject: Re: [PATCH] iio: imu: inv_mpu6050: test whoami against invalid values and do it first
>>>        
>>> On 12/05/17 13:45, Jean-Baptiste Maneyrol wrote:
>>>> SPI bus is never generating error during transfer, so a simple way to check
>>>> if a chip is correctly connected on a SPI bus is to check a fixed value like
>>>> whoami against valid values. 0x00 or 0xff can never happened. It is better
>>>> to do this test first since if there is a problem with a DTS and an incorrect
>>>> chip is wired instead, a write can be more damaging than a read.
>>>>
>>>> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
>>> Hmm. I'd a little unsure on this one.  If we start getting into the
>>> general game of protecting against every wrong DTS it may be a slippery
>>> slope.
>>>
>>> Is there an actual platform out there that you know of that this will
>>> protect?  If so I can probably be persuaded.
>>>
>>> If not I would actually prefer if we checked against the specified ID
>>> rather than relying on a different chip producing either high or low
>>> consistently when hit with this query.
>>>
>>> So perhaps make the ID check a failure if it doesn't match any of the
>>> supported parts?  Bit of a pain for new devices as they won't work
>>> immediately but conversely protects them against issues due to incorrect
>>> identification as well.
>>>
>>> Jonathan
>>>
>>>> ---
>>>       drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 ++++++++++++-------
>>>       1 file changed, 12 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> index 96dabbd..42fb135 100644
>>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>>> @@ -774,23 +774,28 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
>>>            st->hw  = &hw_info[st->chip_type];
>>>            st->reg = hw_info[st->chip_type].reg;
>>>       
>>> -     /* reset to make sure previous state are not there */
>>> -     result = regmap_write(st->map, st->reg->pwr_mgmt_1,
>>> -                           INV_MPU6050_BIT_H_RESET);
>>> -     if (result)
>>> -             return result;
>>> -     msleep(INV_MPU6050_POWER_UP_TIME);
>>> -
>>>            /* check chip self-identification */
>>>            result = regmap_read(st->map, INV_MPU6050_REG_WHOAMI, &regval);
>>>            if (result)
>>>                    return result;
>>>            if (regval != st->hw->whoami) {
>>> +             if (regval == 0x00 || regval == 0xff) {
>>> +                     dev_err(regmap_get_device(st->map),
>>> +                                     "invalid whoami probably io error\n");
>>> +                     return -EIO;
>>> +             }
>>>                    dev_warn(regmap_get_device(st->map),
>>>                                    "whoami mismatch got %#02x expected %#02hhx for %s\n",
>>>                                    regval, st->hw->whoami, st->hw->name);
>>>            }
>>>       
>>> +     /* reset to make sure previous state are not there */
>>> +     result = regmap_write(st->map, st->reg->pwr_mgmt_1,
>>> +                           INV_MPU6050_BIT_H_RESET);
>>> +     if (result)
>>> +             return result;
>>> +     msleep(INV_MPU6050_POWER_UP_TIME);
>>> +
>>>            /*
>>>             * toggle power state. After reset, the sleep bit could be on
>>>             * or off depending on the OTP settings. Toggling power would
>>>
>>
>>        
>>
> 
>      
> 

