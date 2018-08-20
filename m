Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:50436 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeHTTDY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Aug 2018 15:03:24 -0400
Subject: Re: [PATCH 1/3] iio: adxl372: Provide validate_trigger and
 validate_device callbacks
To: Stefan Popa <stefan.popa@analog.com>, jic23@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534776823-18703-1-git-send-email-stefan.popa@analog.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <1fc5f7bb-67d1-fa03-2242-b38b94a151ee@metafoo.de>
Date: Mon, 20 Aug 2018 17:47:08 +0200
MIME-Version: 1.0
In-Reply-To: <1534776823-18703-1-git-send-email-stefan.popa@analog.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/20/2018 04:53 PM, Stefan Popa wrote:
> This patch provides a validate_device callback for the trigger which makes
> sure that other devices are rejected.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com
> ---
>  drivers/iio/accel/adxl372.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index d2fdc75..5a039ba 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -762,11 +762,24 @@ static int adxl372_dready_trig_set_state(struct iio_trigger *trig,
>  	return adxl372_set_interrupts(st, mask, 0);
>  }
>  
> +static int adxl372_validate_trigger(struct iio_dev *indio_dev,
> +				    struct iio_trigger *trig)
> +{
> +	struct adxl372_state *st = iio_priv(indio_dev);
> +
> +	if (st->dready_trig != trig)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static const struct iio_trigger_ops adxl372_trigger_ops = {
> +	.validate_device = &iio_trigger_validate_own_device,
>  	.set_trigger_state = adxl372_dready_trig_set_state,
>  };
>  
>  static const struct iio_info adxl372_info = {
> +	.validate_trigger = &adxl372_validate_trigger,

I wonder, if the device only works with the trigger and the trigger only
works with the device should we actually register a trigger?

Seems to be just extra hassle when setting up the device without any extra
benefits.
