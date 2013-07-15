Return-Path: <otavio.salvador@gmail.com>
MIME-Version: 1.0
Sender: otavio.salvador@gmail.com
In-Reply-To: <201307151624.57438.marex@denx.de>
References: <1373898160-8460-1-git-send-email-otavio@ossystems.com.br>
	<1373898160-8460-2-git-send-email-otavio@ossystems.com.br>
	<201307151624.57438.marex@denx.de>
Date: Mon, 15 Jul 2013 11:38:28 -0300
Message-ID: <CAP9ODKqOEd_002KJ3xFQ0uQfNEoZosrD9UGPQ=rLS0W3N77XwQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] ARM: mxs-lradc: Simplify mxs_lradc_trigger_init error handle
From: Otavio Salvador <otavio@ossystems.com.br>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Kernel development list <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bill Pemberton <wfp5p@virginia.edu>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jul 15, 2013 at 11:24 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Dear Otavio Salvador,
>
>> As we have a 'ret' variable with the iio_trigger_register return, this
>> can be used as result.
>>
>> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
>> ---
>>  drivers/staging/iio/adc/mxs-lradc.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
>> b/drivers/staging/iio/adc/mxs-lradc.c index d92c97a..6d41846 100644
>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>> @@ -671,14 +671,12 @@ static int mxs_lradc_trigger_init(struct iio_dev
>> *iio) trig->ops = &mxs_lradc_trigger_ops;
>>
>>       ret = iio_trigger_register(trig);
>> -     if (ret) {
>> +     if (ret)
>>               iio_trigger_free(trig);
>> -             return ret;
>> -     }
>>
>>       iio->trig = trig;
>
>
> You are still setting iio->trig , you dont want to do that in case of failure

In this case it'd end being NULL I think, wouldn't it?

--
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://projetos.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
