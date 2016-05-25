Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34420 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbcEYKdb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 May 2016 06:33:31 -0400
MIME-Version: 1.0
In-Reply-To: <c023a9f4a7d9015a225f1ebedd998687da770e9b.1464115008.git.amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
	<c023a9f4a7d9015a225f1ebedd998687da770e9b.1464115008.git.amsfield22@gmail.com>
Date: Wed, 25 May 2016 13:33:28 +0300
Message-ID: <CAEnQRZBY94SXut69-o0wvXtiAw3qTxfEnaYbk_uG8qRkeUCbgQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] iio: adc: ad7266: claim direct mode during sensor read
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Alison Schofield <amsfield22@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, May 24, 2016 at 10:16 PM, Alison Schofield <amsfield22@gmail.com> wrote:
> Driver was checking for direct mode but not locking it down.
> Use iio_device_claim_direct_mode() to guarantee device stays
> in direct mode.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>

Acked-by: Daniel Baluta <daniel.baluta@gmail.com>

> ---
>  drivers/iio/adc/ad7266.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 21e19b6..01240ae 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -154,12 +154,11 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
>
>         switch (m) {
>         case IIO_CHAN_INFO_RAW:
> -               if (iio_buffer_enabled(indio_dev))
> -                       return -EBUSY;
> -
> -               ret = ad7266_read_single(st, val, chan->address);
> +               ret = iio_device_claim_direct_mode(indio_dev);
>                 if (ret)
>                         return ret;
> +               ret = ad7266_read_single(st, val, chan->address);
> +               iio_device_release_direct_mode(indio_dev);
>
>                 *val = (*val >> 2) & 0xfff;
>                 if (chan->scan_type.sign == 's')
> --
