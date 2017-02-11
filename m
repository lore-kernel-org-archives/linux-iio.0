Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34668 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbdBKM72 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Feb 2017 07:59:28 -0500
Received: by mail-yw0-f194.google.com with SMTP id v73so4253330ywg.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Feb 2017 04:59:28 -0800 (PST)
Date: Sat, 11 Feb 2017 07:59:25 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/8] iio: quad-8: Set parent device
Message-ID: <20170211125925.GB31343@sophia>
References: <1486816461-28618-1-git-send-email-lars@metafoo.de>
 <1486816461-28618-3-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1486816461-28618-3-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Feb 11, 2017 at 01:34:15PM +0100, Lars-Peter Clausen wrote:
>Initialize the parent of the IIO device to the device that registered it.
>This makes sure that the IIO device appears the right level in the device
>hierarchy.
>
>Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>---
> drivers/iio/counter/104-quad-8.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/iio/counter/104-quad-8.c b/drivers/iio/counter/104-quad-8.c
>index a5913e9..e381ca6 100644
>--- a/drivers/iio/counter/104-quad-8.c
>+++ b/drivers/iio/counter/104-quad-8.c
>@@ -551,6 +551,7 @@ static int quad8_probe(struct device *dev, unsigned int id)
> 	indio_dev->num_channels = ARRAY_SIZE(quad8_channels);
> 	indio_dev->channels = quad8_channels;
> 	indio_dev->name = dev_name(dev);
>+	indio_dev->dev.parent = dev;
> 
> 	priv = iio_priv(indio_dev);
> 	priv->base = base[id];
>-- 
>2.1.4
>

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
