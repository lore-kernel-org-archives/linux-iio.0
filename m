Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1425630960-7142-1-git-send-email-somyaanand214@gmail.com>
References: <1425630960-7142-1-git-send-email-somyaanand214@gmail.com>
Date: Fri, 6 Mar 2015 10:58:54 +0200
Message-ID: <CAEnQRZB9hGx1jR9YVJgQUPRzewNrj4TQ=_SnPLSK4rHvUtcU=w@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] Staging: iio: Change data type in
 adis16220_read_16bit to u16
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Somya Anand <somyaanand214@gmail.com>
Cc: outreachy-kernel@googlegroups.com, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Somya,

On Fri, Mar 6, 2015 at 10:36 AM, Somya Anand <somyaanand214@gmail.com> wrote:
> In the adis16220_read16bit() function we earlier used a s16 value 'val'
> which is used by the adis_read_reg_16 function to read data and takes a
> u16 value as a parameter.
>
> So, this patch changes the data type of 'val' from s16 to u16 for further
> simplification of code and thereby avoiding unnecessary typecast.
>
> Signed-off-by: Somya Anand <somyaanand214@gmail.com>

Ideally, subject should tell us "Why?" the patch is needed,
instead of "What?" the patch does.

The latter should be easy to understand reading the code.

e.g:

staging: iio: adis16220: Avoid unnecessary typecast

> ---
>  drivers/staging/iio/accel/adis16220_core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/adis16220_core.c b/drivers/staging/iio/accel/adis16220_core.c
> index d478f51..7a4a0fd 100644
> --- a/drivers/staging/iio/accel/adis16220_core.c
> +++ b/drivers/staging/iio/accel/adis16220_core.c
> @@ -28,16 +28,15 @@ static ssize_t adis16220_read_16bit(struct device *dev,
>         struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>         struct adis16220_state *st = iio_priv(indio_dev);
>         ssize_t ret;
> -       s16 val = 0;
> +       u16 val = 0;
>
>         /* Take the iio_dev status lock */
>         mutex_lock(&indio_dev->mlock);
> -       ret = adis_read_reg_16(&st->adis, this_attr->address,
> -                                       (u16 *)&val);
> +       ret = adis_read_reg_16(&st->adis, this_attr->address, &val);
>         mutex_unlock(&indio_dev->mlock);
>         if (ret)
>                 return ret;
> -       return sprintf(buf, "%d\n", val);
> +       return sprintf(buf, "%u\n", val);
>  }
>
>  static ssize_t adis16220_write_16bit(struct device *dev,


Other than that it looks good to me. We will need an ACK from Jonathan
/ Lars on this.

thanks,
Daniel.
