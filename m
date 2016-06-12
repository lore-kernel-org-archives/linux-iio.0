Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34009 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbcFLGzI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jun 2016 02:55:08 -0400
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] iio: as3935: improve error reporting in as3935_event_work
From: Matt Ranostay <mranostay@gmail.com>
In-Reply-To: <75c2c65a-f1ac-8ad4-7f04-319939a1866a@kernel.org>
Date: Sat, 11 Jun 2016 23:55:04 -0700
Cc: "Andrew F. Davis" <afd@ti.com>, Arnd Bergmann <arnd@arndb.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Mark Brown <broonie@kernel.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <21E73984-CC08-43B4-8CCD-89DDC2718B65@gmail.com>
References: <1464619938-988956-1-git-send-email-arnd@arndb.de> <574DA582.50408@ti.com> <75c2c65a-f1ac-8ad4-7f04-319939a1866a@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Also important to note these warnings are environment related (e.g. room with lot of EMI noise) and unlikely a chip misconfiguration. Unless the tuning capacitor setting is wrong of course

> On Jun 11, 2016, at 09:32, Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> On 31/05/16 15:53, Andrew F. Davis wrote:
>>> On 05/30/2016 09:52 AM, Arnd Bergmann wrote:
>>> gcc warns about a potentially uninitialized variable use
>>> in as3935_event_work:
>>> 
>>> drivers/iio/proximity/as3935.c: In function ‘as3935_event_work’:
>>> drivers/iio/proximity/as3935.c:231:6: error: ‘val’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>> 
>>> This case specifically happens when spi_w8r8() fails with a
>>> negative return code. We check all other users of this function
>>> except this one.
>>> 
>>> As the error is rather unlikely to happen after the device
>>> has already been initialized, this just adds a dev_warn().
>>> Another warning already existst in the same function, but is
>> 
>>                            ^^ typo
>> 
>>> missing a trailing '\n' character, so I'm fixing that too.
>>> 
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>> drivers/iio/proximity/as3935.c | 10 ++++++++--
>>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
>>> index f4d29d5dbd5f..b49e3ab5730a 100644
>>> --- a/drivers/iio/proximity/as3935.c
>>> +++ b/drivers/iio/proximity/as3935.c
>>> @@ -224,10 +224,16 @@ static void as3935_event_work(struct work_struct *work)
>>> {
>>>    struct as3935_state *st;
>>>    int val;
>>> +    int ret;
>>> 
>>>    st = container_of(work, struct as3935_state, work.work);
>>> 
>>> -    as3935_read(st, AS3935_INT, &val);
>>> +    ret = as3935_read(st, AS3935_INT, &val);
>>> +    if (ret) {
>>> +        dev_warn(&st->spi->dev, "read error\n");
>> 
>> Maybe I'm misunderstanding the commit message, why does this error not
>> use dev_err()? A read error here would be rather serious, it might even
>> be worth it to return a code and fail through the caller too.
> They are unusual and typically result in momentary corruption.  Hmm.
> As this is in a work function, there is no easy way of actually
> passing the error upstream..  dev_err is a little brutal so perhaps
> this is the best option...
>> 
>>> +        return;
>>> +    }
>>> +
>>>    val &= AS3935_INT_MASK;
>>> 
>>>    switch (val) {
>>> @@ -235,7 +241,7 @@ static void as3935_event_work(struct work_struct *work)
>>>        iio_trigger_poll(st->trig);
>>>        break;
>>>    case AS3935_NOISE_INT:
>>> -        dev_warn(&st->spi->dev, "noise level is too high");
>>> +        dev_warn(&st->spi->dev, "noise level is too high\n");
>>>        break;
>>>    }
>>> }
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
