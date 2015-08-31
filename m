Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:34976 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbbHaM4a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 08:56:30 -0400
Received: by lanb10 with SMTP id b10so35194000lan.2
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2015 05:56:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <17d2da9c4c05f45dce7aa81362770f9bdeae0bed.1440459082.git.knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
	<17d2da9c4c05f45dce7aa81362770f9bdeae0bed.1440459082.git.knaack.h@gmx.de>
Date: Mon, 31 Aug 2015 15:56:29 +0300
Message-ID: <CAEnQRZCbn5w9GczdcHHBAYrxoPi8n_5m=yLU6QDO0sEcP-HxXA@mail.gmail.com>
Subject: Re: [PATCH 2/6] iio:dac:m62332: shutdown on remove
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Aug 29, 2015 at 12:59 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> The regulator framework requests to balance regulator_enable() calls with
> regulator_disable() calls. To meet this requirement, set channels to 0 on
> remove, which implies a regulator_disable() call in case that channel was
> enabled.
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Acked-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/dac/m62332.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
> index cffc0630ed32..c61720de8606 100644
> --- a/drivers/iio/dac/m62332.c
> +++ b/drivers/iio/dac/m62332.c
> @@ -243,6 +243,8 @@ static int m62332_remove(struct i2c_client *client)
>
>         iio_device_unregister(indio_dev);
>         iio_map_array_unregister(indio_dev);
> +       m62332_set_value(indio_dev, 0, 0);
> +       m62332_set_value(indio_dev, 0, 1);
>
>         return 0;
>  }

Wouldn't be nice to factor this two calls in a separate function?

thanks,
Daniel.
