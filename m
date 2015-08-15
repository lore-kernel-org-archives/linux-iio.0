Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49381 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbbHOUo6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 16:44:58 -0400
Subject: Re: [PATCH] iio: base: Adding flags to regmap_i2c
To: Crt Mori <cmo@melexis.com>
References: <1439303524-30801-1-git-send-email-cmo@melexis.com>
 <55CFA1C7.70706@kernel.org>
 <CAKv63uvi0xosNfUe+gfF1kD+LHZYP3ewbGT1DtsAikjU2YGHug@mail.gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CFA4C8.20000@kernel.org>
Date: Sat, 15 Aug 2015 21:44:56 +0100
MIME-Version: 1.0
In-Reply-To: <CAKv63uvi0xosNfUe+gfF1kD+LHZYP3ewbGT1DtsAikjU2YGHug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/08/15 21:35, Crt Mori wrote:
> On 15 August 2015 at 22:32, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 11/08/15 15:32, Crt Mori wrote:
>>> Providing access to i2c flags within regmap i2c functions.
>> The patch may be fine, but I'd like to see a more detailed description.
>> Why would one want to do this?  What exactly is the use case?
>>
>> Presumably either 10 bit addressing or PEC?  Or are we dealing
>> with a new flag working it's way through?
> Most notably in our case PEC, otherwise yes a 10-bit addressing
> was also on my mind.
Makes sense to me.  Thanks for the clarification.
>>>
>>> Signed-off-by: Crt Mori <cmo@melexis.com>
>>> ---
>>>  drivers/base/regmap/regmap-i2c.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
>>> index fa6bf52..33e5229 100644
>>> --- a/drivers/base/regmap/regmap-i2c.c
>>> +++ b/drivers/base/regmap/regmap-i2c.c
>>> @@ -46,12 +46,12 @@ static int regmap_i2c_gather_write(void *context,
>>>               return -ENOTSUPP;
>>>
>>>       xfer[0].addr = i2c->addr;
>>> -     xfer[0].flags = 0;
>>> +     xfer[0].flags = i2c->flags;
>>>       xfer[0].len = reg_size;
>>>       xfer[0].buf = (void *)reg;
>>>
>>>       xfer[1].addr = i2c->addr;
>>> -     xfer[1].flags = I2C_M_NOSTART;
>>> +     xfer[1].flags = i2c->flags | I2C_M_NOSTART;
>>>       xfer[1].len = val_size;
>>>       xfer[1].buf = (void *)val;
>>>
>>> @@ -74,12 +74,12 @@ static int regmap_i2c_read(void *context,
>>>       int ret;
>>>
>>>       xfer[0].addr = i2c->addr;
>>> -     xfer[0].flags = 0;
>>> +     xfer[0].flags = i2c->flags;
>>>       xfer[0].len = reg_size;
>>>       xfer[0].buf = (void *)reg;
>>>
>>>       xfer[1].addr = i2c->addr;
>>> -     xfer[1].flags = I2C_M_RD;
>>> +     xfer[1].flags = i2c->flags | I2C_M_RD;
>>>       xfer[1].len = val_size;
>>>       xfer[1].buf = val;
>>>
>>>
>>

