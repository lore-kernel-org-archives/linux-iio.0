Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751138AbdJNSVU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Oct 2017 14:21:20 -0400
Date: Sat, 14 Oct 2017 19:21:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: sw_device: make the function argument as const
Message-ID: <20171014192116.73c29a26@archlinux>
In-Reply-To: <1507730747-13462-1-git-send-email-bhumirks@gmail.com>
References: <1507730747-13462-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 11 Oct 2017 16:05:47 +0200
Bhumika Goyal <bhumirks@gmail.com> wrote:

> This is a follow-up patch for:
> https://patchwork.kernel.org/patch/9999649/
> 
> Make the argument of the function iio_swd_group_init_type_name const as
> it is only passed to the function config_group_init_type_name having the
> argument as const.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

As mentioned before, please put together a single series with the
dependencies and the patches making use of them.

Otherwise, this is going to take a long time to merge.

Jonathan

> ---
> This change allows a lot of config_item_type structures to be const.
> 
>  include/linux/iio/sw_device.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/sw_device.h b/include/linux/iio/sw_device.h
> index fa79319..8642b91 100644
> --- a/include/linux/iio/sw_device.h
> +++ b/include/linux/iio/sw_device.h
> @@ -60,7 +60,7 @@ struct iio_sw_device *to_iio_sw_device(struct config_item *item)
>  static inline
>  void iio_swd_group_init_type_name(struct iio_sw_device *d,
>  				  const char *name,
> -				  struct config_item_type *type)
> +				  const struct config_item_type *type)
>  {
>  #if IS_ENABLED(CONFIG_CONFIGFS_FS)
>  	config_group_init_type_name(&d->group, name, type);

