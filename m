Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:33372 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbdEGX60 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 19:58:26 -0400
Received: by mail-ua0-f172.google.com with SMTP id z47so32189289uaz.0
        for <linux-iio@vger.kernel.org>; Sun, 07 May 2017 16:58:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ec098e23-72d0-cbc3-5cbd-4c089914d788@kernel.org>
References: <20170505003219.17570-1-matt.ranostay@konsulko.com> <ec098e23-72d0-cbc3-5cbd-4c089914d788@kernel.org>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Sun, 7 May 2017 16:58:25 -0700
Message-ID: <CAJCx=gnkcbyLNbUVeUtGfv8iAk+JB+HueC26WWYZ-7ibRpCaNg@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: as3935: fix iio_trigger_poll issue
To: Jonathan Cameron <jic23@kernel.org>
Cc: "open list:IIO SUBSYSTEM AND..." <linux-iio@vger.kernel.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, May 7, 2017 at 5:21 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 05/05/17 01:32, Matt Ranostay wrote:
>> Using iio_trigger_poll() can oops when multiple interrupts
>> happen before the first is handled.
>>
> Ah. I see. This should cause all sorts of trouble and warnings.
>
> It's calling the irq_chip infrastructure without going through the
> dance necessary to make that happen from an irq context.
>
> This is indeed the simplest fix.

Yeah only saw this because of a lightning storm last week (which never
happens here :)).

- Matt

>
> Jonathan
>> Use iio_trigger_poll_chained() instead and use the timestamp
>> when processed, since it will be in theory be 2 ms max latency.
>>
>> Fixes: 24ddb0e4bba4 ("iio: Add AS3935 lightning sensor support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
>> ---
>>  drivers/iio/proximity/as3935.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
>> index ddf9bee89f77..d98d38227f26 100644
>> --- a/drivers/iio/proximity/as3935.c
>> +++ b/drivers/iio/proximity/as3935.c
>> @@ -215,7 +215,7 @@ static irqreturn_t as3935_trigger_handler(int irq, void *private)
>>
>>       st->buffer[0] = val & AS3935_DATA_MASK;
>>       iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
>> -                                        pf->timestamp);
>> +                                        iio_get_time_ns(indio_dev));
>>  err_read:
>>       iio_trigger_notify_done(indio_dev->trig);
>>
>> @@ -244,7 +244,7 @@ static void as3935_event_work(struct work_struct *work)
>>
>>       switch (val) {
>>       case AS3935_EVENT_INT:
>> -             iio_trigger_poll(st->trig);
>> +             iio_trigger_poll_chained(st->trig);
>>               break;
>>       case AS3935_NOISE_INT:
>>               dev_warn(&st->spi->dev, "noise level is too high\n");
>>
>
