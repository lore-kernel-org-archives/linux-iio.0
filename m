Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1432678798-22903-1-git-send-email-rodriguez.twister@gmail.com>
References: <1432678798-22903-1-git-send-email-rodriguez.twister@gmail.com>
Date: Wed, 27 May 2015 09:21:28 +0300
Message-ID: <CAEnQRZC4XwYE1anLNCSyd=mTw0_cATS6_95x9CXTL49gxpJGUA@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: iio_simple_dummy: fix init
From: Daniel Baluta <daniel.baluta@intel.com>
To: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi,

On Wed, May 27, 2015 at 1:19 AM, Vladimirs Ambrosovs
<rodriguez.twister@gmail.com> wrote:
> This patch fixes the init function for the iio_simple_dummy driver.
> The main issues were absence of kfree for the allocated array, and no
> devices being removed in case the probe function fails, running in a loop.
>
> The iio_dummy_remove function was also changed:
>         * The return value was changed to void
>         * The check for return value of iio_simple_dummy_events_unregister()
> The reason for this changes is that, as per implementation,
> events_unregister function always returns 0, so we are safe not to check
> return value. As a result the return value for iio_dummy_remove function
> becomes useless as well, hence return value type change.

While at it I think we can also make
iio_simple_dummy_events_unregister return type void.
Nice to see that people pay attention to the dummy module :).

As part of Outreachy program, Cristina (CC'ed) will work on making the
IIO dummy driver
more useful with the final goal of moving it out of staging.

http://kernelnewbies.org/OutreachyIntro


>
> Signed-off-by: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
> ---
>  drivers/staging/iio/iio_simple_dummy.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
> index b47bf9f..88fbb4f 100644
> --- a/drivers/staging/iio/iio_simple_dummy.c
> +++ b/drivers/staging/iio/iio_simple_dummy.c
> @@ -665,9 +665,8 @@ error_ret:
>   *
>   * Parameters follow those of iio_dummy_probe for buses.
>   */
> -static int iio_dummy_remove(int index)
> +static void iio_dummy_remove(int index)
>  {
> -       int ret;
>         /*
>          * Get a pointer to the device instance iio_dev structure
>          * from the bus subsystem. E.g.
> @@ -685,15 +684,14 @@ static int iio_dummy_remove(int index)
>         /* Buffered capture related cleanup */
>         iio_simple_dummy_unconfigure_buffer(indio_dev);
>
> -       ret = iio_simple_dummy_events_unregister(indio_dev);
> -       if (ret)
> -               goto error_ret;
> +       /*
> +        * Tidy up interrupt handling
> +        * Always returns 0, so not checking for return value
> +        */
> +       iio_simple_dummy_events_unregister(indio_dev);
>
>         /* Free all structures */
>         iio_device_free(indio_dev);
> -
> -error_ret:
> -       return ret;
>  }
>
>  /**
> @@ -722,9 +720,17 @@ static __init int iio_dummy_init(void)
>         for (i = 0; i < instances; i++) {
>                 ret = iio_dummy_probe(i);
>                 if (ret < 0)
> -                       return ret;
> +                       goto error_probe;
>         }
>         return 0;
> +
> +error_probe:
> +       /* Free devices registered before error */
> +       while (i--)
> +               iio_dummy_remove(i);
> +
> +       kfree(iio_dummy_devs);
> +       return ret;
>  }
>  module_init(iio_dummy_init);
>
> --
> 2.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
