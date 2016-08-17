Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1469941905-2600-1-git-send-email-mranostay@gmail.com>
References: <1469941905-2600-1-git-send-email-mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Tue, 16 Aug 2016 21:01:51 -0700
Message-ID: <CAKzfze8szHzw-QoY_h98VMgYy-oMnPEZNkB9hP=zbYzRLTnk4w@mail.gmail.com>
Subject: Re: [PATCH] iio: iio-utils: use channel modifier scaling if it exists
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Cc: Matt Ranostay <mranostay@gmail.com>, Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jul 30, 2016 at 10:11 PM, Matt Ranostay <mranostay@gmail.com> wrote:
> Now there are channel modifiers with their own scaling those should be
> used when possible over the generic channel type scaling.
>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>

Jonathan,

Know you are probably still digging out your inbox since your holiday.
Any comments on this one?

Thanks,

Matt

> ---
>  tools/iio/iio_utils.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index 5eb6793f3972..7a6d61c6c012 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -121,10 +121,6 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>
>         ret = -ENOENT;
>         while (ent = readdir(dp), ent)
> -               /*
> -                * Do we allow devices to override a generic name with
> -                * a specific one?
> -                */
>                 if ((strcmp(builtname, ent->d_name) == 0) ||
>                     (strcmp(builtname_generic, ent->d_name) == 0)) {
>                         ret = asprintf(&filename,
> @@ -178,6 +174,13 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>                         sysfsfp = 0;
>                         free(filename);
>                         filename = 0;
> +
> +                       /*
> +                        * Avoid having a more generic entry overwriting
> +                        * the settings.
> +                        */
> +                       if (strcmp(builtname, ent->d_name) == 0)
> +                               break;
>                 }
>
>  error_close_sysfsfp:
> --
> 2.7.4
>
