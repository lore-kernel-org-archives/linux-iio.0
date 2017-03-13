Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48221 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752799AbdCMVOU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 17:14:20 -0400
Subject: Re: [PATCH] staging: iio: ad7192: Replace mlock with private driver
 lock
To: sayli karnik <karniksayli1995@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20170313104307.GA12480@sayli-HP-15-Notebook-PC>
 <a81ede74-f294-7ccc-5e0d-431eae058128@metafoo.de>
 <CAKG5xWg7-wifwSp3j-PmS20puo=BkOYrs0i3J9o2YFSsL2h=_g@mail.gmail.com>
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cb686d86-b73c-55b7-3607-268b3b91f9f1@kernel.org>
Date: Mon, 13 Mar 2017 21:14:17 +0000
MIME-Version: 1.0
In-Reply-To: <CAKG5xWg7-wifwSp3j-PmS20puo=BkOYrs0i3J9o2YFSsL2h=_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/03/17 14:12, sayli karnik wrote:
> On Mon, Mar 13, 2017 at 5:22 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 03/13/2017 11:43 AM, sayli karnik wrote:
>>> indio_dev->mlock should be used by the IIO core only for protecting
>>> device operating mode changes. ie. Changes between INDIO_DIRECT_MODE,
>>> INDIO_BUFFER_* modes.
>>> Replace mlock with a lock in the device's global data to protect
>>> hardware state changes.
>>>
>>> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
>>> ---
>>>  drivers/staging/iio/adc/ad7192.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
>>> index 4fc8588..bed48e7 100644
>>> --- a/drivers/staging/iio/adc/ad7192.c
>>> +++ b/drivers/staging/iio/adc/ad7192.c
>>> @@ -162,6 +162,7 @@ struct ad7192_state {
>>>       u32                             scale_avail[8][2];
>>>       u8                              gpocon;
>>>       u8                              devid;
>>> +     struct mutex                    lock;   /* protect sensor state */
>>>
>>>       struct ad_sigma_delta           sd;
>>>  };
>>> @@ -463,10 +464,10 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>>>       case IIO_CHAN_INFO_SCALE:
>>>               switch (chan->type) {
>>>               case IIO_VOLTAGE:
>>> -                     mutex_lock(&indio_dev->mlock);
>>> +                     mutex_lock(&st->lock);
>>>                       *val = st->scale_avail[AD7192_CONF_GAIN(st->conf)][0];
>>>                       *val2 = st->scale_avail[AD7192_CONF_GAIN(st->conf)][1];
>>> -                     mutex_unlock(&indio_dev->mlock);
>>> +                     mutex_unlock(&st->lock);
>>
>> Sorry, but this does not make too much sense. If this is the only place
>> where the lock is used there isn't really any mutual exclusion going on
>> since it doesn't prevent any other code from running concurrently.
>>
>> The purpose of taking the lock here is that st->conf is in a consistent
>> state and is not in the process of being changed.
>>
> So you mean indio_dev->mlock is good to go here?
Not as such.  Issue here is the current locking is ineffective.  It's buggy!
So you want to take what Lars has said and think about how to fix it.

Jonathan
> 
>>>                       return IIO_VAL_INT_PLUS_NANO;
>>>               case IIO_TEMP:
>>>                       *val = 0;
>>>
>>

