Return-Path: <jasaw@dius.com.au>
MIME-Version: 1.0
In-Reply-To: <1438939316-1809-1-git-send-email-linus.walleij@linaro.org>
References: <1438939316-1809-1-git-send-email-linus.walleij@linaro.org>
Date: Sat, 8 Aug 2015 00:07:35 +1000
Message-ID: <CA+0Dg4oO1jZbHjv_dW+vmT_-rJR4UGvgz=+mdLrJhDqYJfXwnw@mail.gmail.com>
Subject: Re: [PATCH] iio: iio_utils: accept channels with no offset
From: Joo Aun Saw <jasaw@dius.com.au>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Aug 7, 2015 at 7:21 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> The function build_channel_array() will currently bail out
> if the IIO device does not have a *_offset sysfs file. However
> this offset is not compulsory, see
> Documentation/ABI/testing/sysfs-bus-iio, and the ST sensors
> does not provide an offset so the functions fail with these
> sensors.
>
> Fix this by alloing the offset check to return -ENOENT and if
> it does, assume the offset is zero as per the ABI.

I've already submitted a patch to fix this some time ago.

>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  tools/iio/iio_utils.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index ec9ab7f9ae4c..9ea4b7c79558 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -479,7 +479,10 @@ int build_channel_array(const char *device_dir,
>                                                        device_dir,
>                                                        current->name,
>                                                        current->generic_name);
> -                       if (ret < 0)
> +                       if (ret == -ENOENT) {
> +                               /* Assume zero offset if not present */
> +                               current->offset = 0.0;
> +                       } else if (ret < 0)
>                                 goto error_cleanup_array;
>                         ret = iioutils_get_type(&current->is_signed,
>                                                 &current->bytes,
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Joo.
