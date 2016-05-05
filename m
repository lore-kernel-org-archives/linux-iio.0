Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33491 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbcEEITX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 5 May 2016 04:19:23 -0400
MIME-Version: 1.0
In-Reply-To: <1462435849-23364-1-git-send-email-sdliyong@gmail.com>
References: <1462435849-23364-1-git-send-email-sdliyong@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Thu, 5 May 2016 01:18:42 -0700
Message-ID: <CAKzfze-JO0+D9NW8q-JS=v+=7jnMp-rYsZXk3hD28PXvX_D5mw@mail.gmail.com>
Subject: Re: [PATCH] iio: light apds9960: Add the missing dev.parent
To: Yong Li <sdliyong@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	fengguang.wu@intel.com, Slawomir Stepien <sst@poczta.fm>,
	dan.carpenter@oracle.comn,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Reviewed-By: Matt Ranostay <mranostay@gmail.com>

On Thu, May 5, 2016 at 1:10 AM, Yong Li <sdliyong@gmail.com> wrote:
> Without this, the iio:deviceX is missing in the /sys/bus/i2c/devices/0-0039
>
> Signed-off-by: Yong Li <sdliyong@gmail.com>
> ---
>  drivers/iio/light/apds9960.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index 35928fb..f47cc0a 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -1010,6 +1010,7 @@ static int apds9960_probe(struct i2c_client *client,
>
>         iio_device_attach_buffer(indio_dev, buffer);
>
> +       indio_dev->dev.parent = &client->dev;
>         indio_dev->info = &apds9960_info;
>         indio_dev->name = APDS9960_DRV_NAME;
>         indio_dev->channels = apds9960_channels;
> --
> 2.5.0
>
