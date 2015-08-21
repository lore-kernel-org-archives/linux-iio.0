Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35254 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbbHUHfH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Aug 2015 03:35:07 -0400
Received: by ykbi184 with SMTP id i184so62494229ykb.2
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2015 00:35:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1440079909-1337-3-git-send-email-nicola@corna.info>
References: <1440079909-1337-1-git-send-email-nicola@corna.info> <1440079909-1337-3-git-send-email-nicola@corna.info>
From: Crt Mori <cmo@melexis.com>
Date: Fri, 21 Aug 2015 09:34:26 +0200
Message-ID: <CAKv63utEjV7SxYd279=D3W0FbYM9kCOFzkXDPcb=yxQr6D6OFA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio:humidity:si7020: added processed data
To: Nicola Corna <nicola@corna.info>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

One comment inline.
On 20 August 2015 at 16:11, Nicola Corna <nicola@corna.info> wrote:
>
> The value given by the
> Si7013/20/21 modules needs a conversion using a
> small expression in order to obtain the measurement in °C or %RH. This
> patch adds the computation inside the si7020 module, allowing the user to
> obtain the measurement in m°C and 10E-3%RH without any additional
> calculation.
>
> Signed-off-by: Nicola Corna <nicola@corna.info>
Acked-by: Crt Mori <cmo@melexis.com>
>
> ---
>  drivers/iio/humidity/si7020.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
> index a8bad04..c534706 100644
> --- a/drivers/iio/humidity/si7020.c
> +++ b/drivers/iio/humidity/si7020.c
> @@ -70,6 +70,7 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW:
> +       case IIO_CHAN_INFO_PROCESSED:
>                 if (holdmode) {
>                         ret = i2c_smbus_read_word_data(*client,
>                                                        chan->type == IIO_TEMP ?
> @@ -108,6 +109,17 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
>                         else if (*val > 55575) /* 100%RH */
>                                 *val = 55575;
>                 }
> +               if (mask == IIO_CHAN_INFO_PROCESSED) {
> +                       /*
> +                        * To avoid overflows the fractions can be simplified:
> +                        * temperature --> 175720 / (65536 >> 2) = 21965 / 2048
> +                        * humidity    --> 125000 / (65536 >> 2) = 15625 / 2048
> +                        */
> +                       if (chan->type == IIO_TEMP)
> +                               *val = (*val - 4368) * 21965 / 2048;
I was suggested by Peter Meerwald to use parenthesis in case like this
(and below).
>
> +                       else
> +                               *val = (*val - 768) * 15625 / 2048;
> +               }
>                 return IIO_VAL_INT;
>         case IIO_CHAN_INFO_SCALE:
>                 if (chan->type == IIO_TEMP)
> @@ -142,12 +154,14 @@ static const struct iio_chan_spec si7020_channels[] = {
>         {
>                 .type = IIO_HUMIDITYRELATIVE,
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -                       BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +                       BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) |
> +                       BIT(IIO_CHAN_INFO_PROCESSED),
>         },
>         {
>                 .type = IIO_TEMP,
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -                       BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),
> +                       BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) |
> +                       BIT(IIO_CHAN_INFO_PROCESSED),
>         }
>  };
>
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
