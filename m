Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:35764 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbdAUItR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 03:49:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170120221123.GA22905@d830.WORKGROUP>
References: <20170120221123.GA22905@d830.WORKGROUP>
From: Vlad Dogaru <ddvlad@gmail.com>
Date: Sat, 21 Jan 2017 09:49:15 +0100
Message-ID: <CAA+rx9TfvFH2JaCcD6OCjB3f1iUWrMgTZCwuOBUUuVP8HUitgA@mail.gmail.com>
Subject: Re: [PATCH] iio: proximity: sx9500: claim direct mode during raw
 proximity reads
To: Alison Schofield <amsfield22@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jan 20, 2017 at 11:11 PM, Alison Schofield <amsfield22@gmail.com> wrote:
> Driver was checking for direct mode but not locking it.  Use the
> claim/release helper functions to guarantee the device stays in
> direct mode during raw reads of proximity data.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>

Reviewed-by: Vlad Dogaru <ddvlad@gmail.com>

> ---
>  drivers/iio/proximity/sx9500.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 1f06282..9ea147f 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -387,14 +387,18 @@ static int sx9500_read_raw(struct iio_dev *indio_dev,
>                            int *val, int *val2, long mask)
>  {
>         struct sx9500_data *data = iio_priv(indio_dev);
> +       int ret;
>
>         switch (chan->type) {
>         case IIO_PROXIMITY:
>                 switch (mask) {
>                 case IIO_CHAN_INFO_RAW:
> -                       if (iio_buffer_enabled(indio_dev))
> -                               return -EBUSY;
> -                       return sx9500_read_proximity(data, chan, val);
> +                       ret = iio_device_claim_direct_mode(indio_dev);
> +                       if (ret)
> +                               return ret;
> +                       ret = sx9500_read_proximity(data, chan, val);
> +                       iio_device_release_direct_mode(indio_dev);
> +                       return ret;
>                 case IIO_CHAN_INFO_SAMP_FREQ:
>                         return sx9500_read_samp_freq(data, val, val2);
>                 default:
> --
> 2.1.4
>
