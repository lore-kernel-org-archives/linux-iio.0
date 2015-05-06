Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1430948924-4756-1-git-send-email-khoroshilov@ispras.ru>
References: <1430948924-4756-1-git-send-email-khoroshilov@ispras.ru>
Date: Wed, 6 May 2015 19:00:56 -0300
Message-ID: <CAOMZO5AC=SUdXh6+np_2c3vqaKjpk-rZcR_baJ3-e+qt=dxx9w@mail.gmail.com>
Subject: Re: [PATCH] iio: hid-sensors: Fix memory leak on failure path in hid_prox_probe()
From: Fabio Estevam <festevam@gmail.com>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>, ldv-project@linuxtesting.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 6, 2015 at 6:48 PM, Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:
> If prox_parse_report() fails, memory allocated for channels is not
> deallocated, since it is still in local variable channels
> while kfree() is called with indio_dev->channels.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/iio/light/hid-sensor-prox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index 91ecc46ffeaa..d0d188108a11 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -281,8 +281,9 @@ static int hid_prox_probe(struct platform_device *pdev)
>         ret = prox_parse_report(pdev, hsdev, channels,
>                                 HID_USAGE_SENSOR_PROX, prox_state);
>         if (ret) {
> +               kfree(channels);
>                 dev_err(&pdev->dev, "failed to setup attributes\n");
> -               goto error_free_dev_mem;
> +               return ret;

Then the other calls to error_free_dev_mem will also miss to call
'kfree(channels)'.

What about this fix instead?

--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -332,7 +332,7 @@ error_remove_trigger:
 error_unreg_buffer_funcs:
        iio_triggered_buffer_cleanup(indio_dev);
 error_free_dev_mem:
-       kfree(indio_dev->channels);
+       kfree(channels);
        return ret;
 }

Regards,

Fabio Estevam
