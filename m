Return-Path: <SRS0=nPas=C6=bgdev.pl=brgl@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171202114338.58c077dc@archlinux>
References: <20171127105449.27535-1-brgl@bgdev.pl> <20171202114338.58c077dc@archlinux>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 2 Dec 2017 16:33:59 +0100
Message-ID: <CAMRc=MehxFFxGU6vWyBaLWn7S_zR1+6B17mogFw4V1OS-Tq-cQ@mail.gmail.com>
Subject: Re: [PATCH] iio: dummy_evgen: modify the return value check for irq_sim_init()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

2017-12-02 12:43 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
> On Mon, 27 Nov 2017 11:54:49 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
>> As discussed with Marc Zyngier: irq_sim_init() and its devres variant
>> should return the base of the allocated interrupt range on success
>> rather than 0. This will be modified later - first, change the way
>> users handle the return value of these routines.
>>
>> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> I'm happy to take this but if it goes via my tree whilst the
> other changes take a different path you are going to slow things
> down considerably (a kernel cycle for this change to be in the
> upstream of where the fix gets applied).  So I would bundle
> it up in a single patch set with the more major changes.
>
> If you still want me to take it let me know, but if it
> might go via another route then
>
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> Thanks,
>
> Jonathan
>> ---
>>  drivers/iio/dummy/iio_dummy_evgen.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
>> index fe8884543da0..efd0005f59b4 100644
>> --- a/drivers/iio/dummy/iio_dummy_evgen.c
>> +++ b/drivers/iio/dummy/iio_dummy_evgen.c
>> @@ -56,7 +56,7 @@ static int iio_dummy_evgen_create(void)
>>               return -ENOMEM;
>>
>>       ret = irq_sim_init(&iio_evgen->irq_sim, IIO_EVENTGEN_NO);
>> -     if (ret) {
>> +     if (ret < 0) {
>>               kfree(iio_evgen);
>>               return ret;
>>       }
>

There's no hurry with that, it doesn't cause any problems really and
the same change must be applied to gpio-mockup. I planned to actually
change the return value for 4.17 after all users are modified for
4.16.

How does it sound?

Thanks,
Bartosz
