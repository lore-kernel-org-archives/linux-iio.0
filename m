Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:35041 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbbHaTqo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 15:46:44 -0400
Received: by lbcbn3 with SMTP id bn3so66446831lbc.2
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2015 12:46:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9a834bd03fd40333cb6e9935e51ecf801c81d38b.1440459082.git.knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
	<9a834bd03fd40333cb6e9935e51ecf801c81d38b.1440459082.git.knaack.h@gmx.de>
Date: Mon, 31 Aug 2015 22:46:43 +0300
Message-ID: <CAEnQRZBm8DDpe82Pju+xF0yLqsuhPnvVXShQvEGHisPymxUkag@mail.gmail.com>
Subject: Re: [PATCH 4/6] iio:dac:m62332: drop unrequired variable
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
> A return variable is not required in _write_raw(), and dropping it reduces
> complexity, as well.
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Acked-by: Daniel Baluta <daniel.baluta@intel.com>

Initially forgot to CC linux-iio.

> ---
>  drivers/iio/dac/m62332.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
> index fe750982b502..1b65fc007bce 100644
> --- a/drivers/iio/dac/m62332.c
> +++ b/drivers/iio/dac/m62332.c
> @@ -112,21 +112,17 @@ static int m62332_read_raw(struct iio_dev *indio_dev,
>  static int m62332_write_raw(struct iio_dev *indio_dev,
>         struct iio_chan_spec const *chan, int val, int val2, long mask)
>  {
> -       int ret;
> -
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW:
>                 if (val < 0 || val > 255)
>                         return -EINVAL;
>
> -               ret = m62332_set_value(indio_dev, val, chan->channel);
> -               break;
> +               return m62332_set_value(indio_dev, val, chan->channel);
>         default:
> -               ret = -EINVAL;
>                 break;
>         }
>
> -       return ret;
> +       return -EINVAL;
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> --
> 2.4.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
