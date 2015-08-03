Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <4193254d1067149430a5a8d84a21def37f09bcec.1438598039.git.cristina.opriceana@gmail.com>
References: <4193254d1067149430a5a8d84a21def37f09bcec.1438598039.git.cristina.opriceana@gmail.com>
Date: Mon, 3 Aug 2015 13:44:00 +0300
Message-ID: <CAEnQRZBOd_5O+8-pWOJLDD-sycYmcn5cbkFctH4Fr73R21cr-Q@mail.gmail.com>
Subject: Re: [PATCH] iio: industrialio-buffer: Fix iio_buffer_poll return value
From: Daniel Baluta <daniel.baluta@intel.com>
To: Cristina Opriceana <cristina.opriceana@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Aug 3, 2015 at 1:37 PM, Cristina Opriceana
<cristina.opriceana@gmail.com> wrote:
> Change return value to 0 if no device is bound since
> unsigned int cannot support negative error codes.
>
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>

Fixes: f18e7a068 ("iio: Return -ENODEV for file operations if the
device has been unregistered")

> ---
>  drivers/iio/industrialio-buffer.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index faed6ef..e8e87cf 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -155,7 +155,9 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>   *             a wait queue
>   *
>   * Return: (POLLIN | POLLRDNORM) if data is available for reading
> - *        or 0 for other cases
> + *        and 0 for other cases, e.g. no device is bound or no
> + *        hardware fifo flush could be triggered.
> + *
>   */
>  unsigned int iio_buffer_poll(struct file *filp,
>                              struct poll_table_struct *wait)
> @@ -164,7 +166,7 @@ unsigned int iio_buffer_poll(struct file *filp,
>         struct iio_buffer *rb = indio_dev->buffer;
>
>         if (!indio_dev->info)
> -               return -ENODEV;
> +               return 0;
>
>         poll_wait(filp, &rb->pollq, wait);
>         if (iio_buffer_ready(indio_dev, rb, rb->watermark, 0))
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
