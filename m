Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <CAOMZO5AC=SUdXh6+np_2c3vqaKjpk-rZcR_baJ3-e+qt=dxx9w@mail.gmail.com>
References: <1430948924-4756-1-git-send-email-khoroshilov@ispras.ru>
	<CAOMZO5AC=SUdXh6+np_2c3vqaKjpk-rZcR_baJ3-e+qt=dxx9w@mail.gmail.com>
Date: Thu, 7 May 2015 10:43:40 +0300
Message-ID: <CAEnQRZB9702wokxfMM4Yq=qsQJ8OEs5adtupd5uRw+WU2ifiBQ@mail.gmail.com>
Subject: Re: [PATCH] iio: hid-sensors: Fix memory leak on failure path in hid_prox_probe()
From: Daniel Baluta <daniel.baluta@intel.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
	ldv-project@linuxtesting.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, May 7, 2015 at 1:00 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, May 6, 2015 at 6:48 PM, Alexey Khoroshilov
> <khoroshilov@ispras.ru> wrote:
>> If prox_parse_report() fails, memory allocated for channels is not
>> deallocated, since it is still in local variable channels
>> while kfree() is called with indio_dev->channels.
>>
>> Found by Linux Driver Verification project (linuxtesting.org).
>>
>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>> ---
>>  drivers/iio/light/hid-sensor-prox.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
>> index 91ecc46ffeaa..d0d188108a11 100644
>> --- a/drivers/iio/light/hid-sensor-prox.c
>> +++ b/drivers/iio/light/hid-sensor-prox.c
>> @@ -281,8 +281,9 @@ static int hid_prox_probe(struct platform_device *pdev)
>>         ret = prox_parse_report(pdev, hsdev, channels,
>>                                 HID_USAGE_SENSOR_PROX, prox_state);
>>         if (ret) {
>> +               kfree(channels);
>>                 dev_err(&pdev->dev, "failed to setup attributes\n");
>> -               goto error_free_dev_mem;
>> +               return ret;
>
> Then the other calls to error_free_dev_mem will also miss to call
> 'kfree(channels)'.
>
> What about this fix instead?
>
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -332,7 +332,7 @@ error_remove_trigger:
>  error_unreg_buffer_funcs:
>         iio_triggered_buffer_cleanup(indio_dev);
>  error_free_dev_mem:
> -       kfree(indio_dev->channels);
> +       kfree(channels);
>         return ret;
>  }

Both patches are correct and I think we should go
with Fabio's version since it's consistent with the
rest of the code.

thanks,
Daniel.
