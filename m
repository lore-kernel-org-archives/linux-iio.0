Return-Path: <festevam@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1431006262-18543-1-git-send-email-fabio.estevam@freescale.com>
References: <1431006262-18543-1-git-send-email-fabio.estevam@freescale.com>
Date: Thu, 7 May 2015 10:56:08 -0300
Message-ID: <CAOMZO5Dd1y5fZMCQ+Lx6Lq=fZX1SZHZu8-M6MH-fH10xj4Oj6A@mail.gmail.com>
Subject: Re: [PATCH] iio: light: hid-sensor-prox: Fix memory leak in hid_prox_probe()
From: Fabio Estevam <festevam@gmail.com>
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Jonathan Cameron <jic23@kernel.org>, LinuxTesting Org <khoroshilov@ispras.ru>, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, May 7, 2015 at 10:44 AM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> When prox_parse_report() fails we should free the previously allocated
> 'channels' struct.
>
> Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/iio/light/hid-sensor-prox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index 91ecc46..f76ef0f 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -332,7 +332,7 @@ error_remove_trigger:
>  error_unreg_buffer_funcs:
>         iio_triggered_buffer_cleanup(indio_dev);
>  error_free_dev_mem:
> -       kfree(indio_dev->channels);
> +       kfree(channels);

Even though it fixes the memory leak in probe(), we still have the
issue in the remove() function.

I will send a v2 that addresses both cases.
