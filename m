Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34118 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751682AbdBNPjD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Feb 2017 10:39:03 -0500
Received: by mail-vk0-f50.google.com with SMTP id r136so82366727vke.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Feb 2017 07:39:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486816461-28618-7-git-send-email-lars@metafoo.de>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de> <1486816461-28618-7-git-send-email-lars@metafoo.de>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Tue, 14 Feb 2017 07:39:01 -0800
Message-ID: <CAJCx=gkqdx21DLQ4Cu_5AcOv=X_RR2PZFTmD6L4ofV85Cg5eRw@mail.gmail.com>
Subject: Re: [PATCH 6/8] iio: lmp91000: Set parent device
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
>  drivers/iio/potentiostat/lmp91000.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index e227143..afa8de3 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -325,6 +325,7 @@ static int lmp91000_probe(struct i2c_client *client,
>         indio_dev->channels = lmp91000_channels;
>         indio_dev->num_channels = ARRAY_SIZE(lmp91000_channels);
>         indio_dev->name = LMP91000_DRV_NAME;
> +       indio_dev->dev.parent = &client->dev;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         i2c_set_clientdata(client, indio_dev);
>
> --
> 2.1.4
>
