Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41039 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966735AbdD0P3z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Apr 2017 11:29:55 -0400
Subject: Re: [PATCH] iio: proximity: as3935: fix AS3935_INT mask
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: "open list:IIO SUBSYSTEM AND..." <linux-iio@vger.kernel.org>,
        stable@vger.kernel.org
References: <20170427075232.3689-1-matt.ranostay@konsulko.com>
 <CAJCx=g=7BJB-HG0YyOVb9GEUPU35GwawPFRmAJkyUpu1n_y=QA@mail.gmail.com>
 <CAJCx=gk8af_Garn6Hu2pNLM7DmOhz3HB0n58kJNUTWGNsV13hg@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <640e3254-501c-3fd5-a65e-b8b4ac2e9ff0@kernel.org>
Date: Thu, 27 Apr 2017 16:29:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAJCx=gk8af_Garn6Hu2pNLM7DmOhz3HB0n58kJNUTWGNsV13hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/04/17 09:00, Matt Ranostay wrote:
> On Thu, Apr 27, 2017 at 12:59 AM, Matt Ranostay
> <matt.ranostay@konsulko.com> wrote:
>> On Thu, Apr 27, 2017 at 12:52 AM, Matt Ranostay
>> <matt.ranostay@konsulko.com> wrote:
>>> AS3935 interrupt mask has been incorrect so valid lightning events
>>> would never trigger an buffer event. Also noise interrupt should be
>>> BIT(0).
>>
>> Er, BIT(1)
> 
> Gah zero re-read the line wrong. Datasheet fun!
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
>>
>> Damn comment errors :)
>>
>>>
>>> Fixes: 24ddb0e4bba4 ("iio: Add AS3935 lightning sensor support")
>>> CC: stable@vger.kernel.org
>>> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
>>> ---
>>>  drivers/iio/proximity/as3935.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
>>> index aa0d0be1a608..8f081ef4802d 100644
>>> --- a/drivers/iio/proximity/as3935.c
>>> +++ b/drivers/iio/proximity/as3935.c
>>> @@ -40,9 +40,9 @@
>>>  #define AS3935_AFE_PWR_BIT     BIT(0)
>>>
>>>  #define AS3935_INT             0x03
>>> -#define AS3935_INT_MASK                0x07
>>> +#define AS3935_INT_MASK                0x0f
>>>  #define AS3935_EVENT_INT       BIT(3)
>>> -#define AS3935_NOISE_INT       BIT(1)
>>> +#define AS3935_NOISE_INT       BIT(0)
>>>
>>>  #define AS3935_DATA            0x07
>>>  #define AS3935_DATA_MASK       0x3F
>>> --
>>> 2.11.0
>>>

