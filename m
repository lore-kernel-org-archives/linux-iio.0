Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33958 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753767AbdBNPk4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Feb 2017 10:40:56 -0500
Received: by mail-vk0-f47.google.com with SMTP id r136so82404902vke.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Feb 2017 07:40:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486816461-28618-8-git-send-email-lars@metafoo.de>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de> <1486816461-28618-8-git-send-email-lars@metafoo.de>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Tue, 14 Feb 2017 07:40:55 -0800
Message-ID: <CAJCx=g=3-ffVxQDSd09dONuq7hDxee2RZdWJNk=XjBTLsec2dQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] iio: pulsedlight-lidar-lite-v2: Set parent device
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Feb 11, 2017 at 4:34 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Initialize the parent of the IIO device to the device that registered it.
> This makes sure that the IIO device appears the right level in the device
> hierarchy.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 20c16a0..36c1ddc 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -278,6 +278,7 @@ static int lidar_probe(struct i2c_client *client,
>         indio_dev->name = LIDAR_DRV_NAME;
>         indio_dev->channels = lidar_channels;
>         indio_dev->num_channels = ARRAY_SIZE(lidar_channels);
> +       indio_dev->dev.parent = &client->dev;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
>         i2c_set_clientdata(client, indio_dev);
> --
> 2.1.4
>
