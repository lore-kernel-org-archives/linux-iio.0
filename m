Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:48951 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbdI1KzH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Sep 2017 06:55:07 -0400
Received: by mail-oi0-f49.google.com with SMTP id 125so1581404oie.5
        for <linux-iio@vger.kernel.org>; Thu, 28 Sep 2017 03:55:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d8279093-c98a-20d9-ada4-8995243f4480@metafoo.de>
References: <20170926164910.31137-1-brgl@bgdev.pl> <187e45bf-03ac-1847-de43-92806c36e8ab@metafoo.de>
 <CAMRc=Mc26u0n6tCXajnK3vhJ6N4acGgZp2atS0otGLZNSNhxpA@mail.gmail.com> <d8279093-c98a-20d9-ada4-8995243f4480@metafoo.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 28 Sep 2017 12:55:06 +0200
Message-ID: <CAMRc=MdR+osCmb0mG5a53Ggk-s8HQoJ4x7VCvC8cfwqNC1EfvQ@mail.gmail.com>
Subject: Re: [PATCH] iio: dummy: evgen: use irq_sim
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2017-09-28 10:04 GMT+02:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 09/27/2017 09:23 PM, Bartosz Golaszewski wrote:
>>>>               return ret;
>>>> -     }
>>>> -     iio_evgen->chip.name = iio_evgen_name;
>>>> -     iio_evgen->chip.irq_mask = &iio_dummy_event_irqmask;
>>>> -     iio_evgen->chip.irq_unmask = &iio_dummy_event_irqunmask;
>>>> -     for (i = 0; i < IIO_EVENTGEN_NO; i++) {
>>>> -             irq_set_chip(iio_evgen->base + i, &iio_evgen->chip);
>>>> -             irq_set_handler(iio_evgen->base + i, &handle_simple_irq);
>>>> -             irq_modify_status(iio_evgen->base + i,
>>>> -                               IRQ_NOREQUEST | IRQ_NOAUTOEN,
>>>> -                               IRQ_NOPROBE);
>>>> -     }
>>>> -     init_irq_work(&iio_evgen->handler.work, iio_dummy_work_handler);
>>>> +
>>>> +     iio_evgen->base = irq_sim_irqnum(&iio_evgen->irq_sim, 0);
>>> I saw you introduced irq_sim_baseirq(), to get rid of ->base. But as far as
>>> I can see the only remaining places where we need the base is to do the
>>> reverse lookup from IRQ to index. It would be nice if the irq_sim had a
>>> function for that, then we wouldn't have to know about the base at all.
>>>
>>
>> I'm not sure I understand. Irq sim doesn't know anything about iio
>> data structures, so how would such a reverse lookup work in this case?
>
> Reverse lookup in the sense of translating IRQ number to offset. All we ever
> do with the base in the IIO code is `irq - base` to get the offset. I'd hide
> that calculation in a helper in the irq_sim code. This nicely splits
> functionality and implementation, the IIO code doesn't have to know how to
> get offset from the IRQ.

I see. Sounds like a good improvement for 4.16. In the meantime, I'll
send v2 with the missing kfree() added.

Thanks,
Bartosz
