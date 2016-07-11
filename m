Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1468238144-30654-1-git-send-email-lars@metafoo.de>
References: <1468238144-30654-1-git-send-email-lars@metafoo.de>
From: Daniel Baluta <daniel.baluta@intel.com>
Date: Mon, 11 Jul 2016 15:47:22 +0300
Message-ID: <CAEnQRZDWEwQ6APgDQ5WQgy7SYXihZFZQg7kyQrivXDodSuHRhA@mail.gmail.com>
Subject: Re: [PATCH] iio: sw-trigger: Fix config group initialization
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Daniel Baluta <daniel.baluta@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jul 11, 2016 at 2:55 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Use the IS_ENABLED() helper macro to ensure that the configfs group is
> initialized either when configfs is built-in or when configfs is built as a
> module. Otherwise software trigger creation will result in undefined
> behaviour when configfs is built as a mdoule since the configfs group for
> the trigger is not properly initialized.
>
> Fixes: b662f809d410 ("iio: core: Introduce IIO software triggers")
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
> Appologies if you received this twice, forgot the list on the first try.
> ---
>  include/linux/iio/sw_trigger.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/iio/sw_trigger.h b/include/linux/iio/sw_trigger.h
> index 5198f8e..c97eab6 100644
> --- a/include/linux/iio/sw_trigger.h
> +++ b/include/linux/iio/sw_trigger.h
> @@ -62,7 +62,7 @@ void iio_swt_group_init_type_name(struct iio_sw_trigger *t,
>                                   const char *name,
>                                   struct config_item_type *type)
>  {
> -#ifdef CONFIG_CONFIGFS_FS
> +#if IS_ENABLED(CONFIG_CONFIGFS_FS)
>         config_group_init_type_name(&t->group, name, type);
>  #endif
>  }
> --
