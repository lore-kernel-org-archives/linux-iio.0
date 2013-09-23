Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:49792 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486Ab3IWNrh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2013 09:47:37 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so3222473pbc.36
        for <linux-iio@vger.kernel.org>; Mon, 23 Sep 2013 06:47:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1379941462-31627-1-git-send-email-aida.mynzhasova@skitlab.ru>
References: <1379941462-31627-1-git-send-email-aida.mynzhasova@skitlab.ru>
Date: Mon, 23 Sep 2013 21:47:37 +0800
Message-ID: <CAFRkauBqw3j37sjwMGipF3ytVNw2YOp1h2XhdNxfArv+RE+Aaw@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad5446: Add support for AD5641
From: Axel Lin <axel.lin@ingics.com>
To: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Cc: ic23@cam.ac.uk, Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2013/9/23 Aida Mynzhasova <aida.mynzhasova@skitlab.ru>:
> This patch adds support for the AD5641 single channel,
> 14-bit, buffered voltage output DAC.
>
> Signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
> ---
>  drivers/iio/dac/Kconfig  | 2 +-
>  drivers/iio/dac/ad5446.c | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index c9c33ce..cede548 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -62,7 +62,7 @@ config AD5446
>           Say yes here to build support for Analog Devices AD5300, AD5301, AD5310,
>           AD5311, AD5320, AD5321, AD5444, AD5446, AD5450, AD5451, AD5452, AD5453,
>           AD5512A, AD5541A, AD5542A, AD5543, AD5553, AD5601, AD5602, AD5611, AD5612,
> -         AD5620, AD5621, AD5622, AD5640, AD5660, AD5662 DACs.
> +         AD5620, AD5621, AD5641, AD5622, AD5640, AD5660, AD5662 DACs.

This driver has sorted the ID in proper order so you should put AD5641 after
AD5640. (This comment also applies for all below changes).
