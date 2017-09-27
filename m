Return-Path: <SRS0=e8Nn=A4=bgdev.pl=brgl@kernel.org>
MIME-Version: 1.0
In-Reply-To: <187e45bf-03ac-1847-de43-92806c36e8ab@metafoo.de>
References: <20170926164910.31137-1-brgl@bgdev.pl> <187e45bf-03ac-1847-de43-92806c36e8ab@metafoo.de>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Sep 2017 21:23:04 +0200
Message-ID: <CAMRc=Mc26u0n6tCXajnK3vhJ6N4acGgZp2atS0otGLZNSNhxpA@mail.gmail.com>
Subject: Re: [PATCH] iio: dummy: evgen: use irq_sim
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

2017-09-27 19:12 GMT+02:00 Lars-Peter Clausen <lars@metafoo.de>:
> On 09/26/2017 06:49 PM, Bartosz Golaszewski wrote:
>> Switch to using the recently added interrupt simulator for dummy irqs.
>>
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
>
> Thanks for doing this.
>
> [...]
>>  static int iio_dummy_evgen_create(void)
>>  {
>> -     int ret, i;
>> +     int ret;
>>
>>       iio_evgen = kzalloc(sizeof(*iio_evgen), GFP_KERNEL);
>>       if (!iio_evgen)
>>               return -ENOMEM;
>>
>> -     iio_evgen->base = irq_alloc_descs(-1, 0, IIO_EVENTGEN_NO, 0);
>> -     if (iio_evgen->base < 0) {
>> -             ret = iio_evgen->base;
>> -             kfree(iio_evgen);
>> +     ret = irq_sim_init(&iio_evgen->irq_sim, IIO_EVENTGEN_NO);
>> +     if (ret)
>
> What happened to the kfree(iio_evgen)?
>

Oops, nice catch, thanks!

>>               return ret;
>> -     }
>> -     iio_evgen->chip.name = iio_evgen_name;
>> -     iio_evgen->chip.irq_mask = &iio_dummy_event_irqmask;
>> -     iio_evgen->chip.irq_unmask = &iio_dummy_event_irqunmask;
>> -     for (i = 0; i < IIO_EVENTGEN_NO; i++) {
>> -             irq_set_chip(iio_evgen->base + i, &iio_evgen->chip);
>> -             irq_set_handler(iio_evgen->base + i, &handle_simple_irq);
>> -             irq_modify_status(iio_evgen->base + i,
>> -                               IRQ_NOREQUEST | IRQ_NOAUTOEN,
>> -                               IRQ_NOPROBE);
>> -     }
>> -     init_irq_work(&iio_evgen->handler.work, iio_dummy_work_handler);
>> +
>> +     iio_evgen->base = irq_sim_irqnum(&iio_evgen->irq_sim, 0);
> I saw you introduced irq_sim_baseirq(), to get rid of ->base. But as far as
> I can see the only remaining places where we need the base is to do the
> reverse lookup from IRQ to index. It would be nice if the irq_sim had a
> function for that, then we wouldn't have to know about the base at all.
>

I'm not sure I understand. Irq sim doesn't know anything about iio
data structures, so how would such a reverse lookup work in this case?

Best regards,
Bartosz Golaszewski
