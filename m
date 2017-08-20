Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbdHTKDK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 06:03:10 -0400
Date: Sun, 20 Aug 2017 11:01:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: accel: kxcjk1013: extract
 report_motion_event() from interrupt handler
Message-ID: <20170820110142.6ead44ca@archlinux>
In-Reply-To: <d6bd9449c675651882e4c3b63e107480493a170b.1502979014.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502979014.git.mirq-linux@rere.qmqm.pl>
        <d6bd9449c675651882e4c3b63e107480493a170b.1502979014.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 17 Aug 2017 16:21:36 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> Extract reporting of motion event direction from interrupt handler,
> as it is not supported by KXTF9.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

This uses register naming changes that aren't introduced until patch 3.

I've asked you to drop those anyway so this will get cleaned up when
you do that.

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 124 +++++++++++++++++++++--------------------
>  1 file changed, 65 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 33e4b98f39fc..80a6508d6370 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1027,6 +1027,70 @@ static const struct iio_trigger_ops kxcjk1013_trigger_ops = {
>  	.owner = THIS_MODULE,
>  };
>  
> +static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
> +{
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +
> +	int ret = i2c_smbus_read_byte_data(data->client,
> +					   KXCJK1013_REG_INT_SRC2);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_int_src2\n");
> +		return;
> +	}
> +
> +	if (ret & KXREG_MOTION_INT_BIT_XN)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +			       0,
> +			       IIO_MOD_X,
> +			       IIO_EV_TYPE_THRESH,
> +			       IIO_EV_DIR_FALLING),
> +			       data->timestamp);
> +	if (ret & KXREG_MOTION_INT_BIT_XP)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +			       0,
> +			       IIO_MOD_X,
> +			       IIO_EV_TYPE_THRESH,
> +			       IIO_EV_DIR_RISING),
> +			       data->timestamp);
> +
> +
> +	if (ret & KXREG_MOTION_INT_BIT_YN)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +			       0,
> +			       IIO_MOD_Y,
> +			       IIO_EV_TYPE_THRESH,
> +			       IIO_EV_DIR_FALLING),
> +			       data->timestamp);
> +	if (ret & KXREG_MOTION_INT_BIT_YP)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +			       0,
> +			       IIO_MOD_Y,
> +			       IIO_EV_TYPE_THRESH,
> +			       IIO_EV_DIR_RISING),
> +			       data->timestamp);
> +
> +	if (ret & KXREG_MOTION_INT_BIT_ZN)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +			       0,
> +			       IIO_MOD_Z,
> +			       IIO_EV_TYPE_THRESH,
> +			       IIO_EV_DIR_FALLING),
> +			       data->timestamp);
> +	if (ret & KXREG_MOTION_INT_BIT_ZP)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +			       0,
> +			       IIO_MOD_Z,
> +			       IIO_EV_TYPE_THRESH,
> +			       IIO_EV_DIR_RISING),
> +			       data->timestamp);
> +}
> +
>  static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
> @@ -1040,65 +1104,7 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
>  	}
>  
>  	if (ret & 0x02) {
> -		ret = i2c_smbus_read_byte_data(data->client,
> -					       KXCJK1013_REG_INT_SRC2);
> -		if (ret < 0) {
> -			dev_err(&data->client->dev,
> -				"Error reading reg_int_src2\n");
> -			goto ack_intr;
> -		}
> -
> -		if (ret & KXCJK1013_REG_INT_SRC2_BIT_XN)
> -			iio_push_event(indio_dev,
> -				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> -				       0,
> -				       IIO_MOD_X,
> -				       IIO_EV_TYPE_THRESH,
> -				       IIO_EV_DIR_FALLING),
> -				       data->timestamp);
> -		if (ret & KXCJK1013_REG_INT_SRC2_BIT_XP)
> -			iio_push_event(indio_dev,
> -				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> -				       0,
> -				       IIO_MOD_X,
> -				       IIO_EV_TYPE_THRESH,
> -				       IIO_EV_DIR_RISING),
> -				       data->timestamp);
> -
> -
> -		if (ret & KXCJK1013_REG_INT_SRC2_BIT_YN)
> -			iio_push_event(indio_dev,
> -				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> -				       0,
> -				       IIO_MOD_Y,
> -				       IIO_EV_TYPE_THRESH,
> -				       IIO_EV_DIR_FALLING),
> -				       data->timestamp);
> -		if (ret & KXCJK1013_REG_INT_SRC2_BIT_YP)
> -			iio_push_event(indio_dev,
> -				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> -				       0,
> -				       IIO_MOD_Y,
> -				       IIO_EV_TYPE_THRESH,
> -				       IIO_EV_DIR_RISING),
> -				       data->timestamp);
> -
> -		if (ret & KXCJK1013_REG_INT_SRC2_BIT_ZN)
> -			iio_push_event(indio_dev,
> -				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> -				       0,
> -				       IIO_MOD_Z,
> -				       IIO_EV_TYPE_THRESH,
> -				       IIO_EV_DIR_FALLING),
> -				       data->timestamp);
> -		if (ret & KXCJK1013_REG_INT_SRC2_BIT_ZP)
> -			iio_push_event(indio_dev,
> -				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> -				       0,
> -				       IIO_MOD_Z,
> -				       IIO_EV_TYPE_THRESH,
> -				       IIO_EV_DIR_RISING),
> -				       data->timestamp);
> +		kxcjk1013_report_motion_event(indio_dev);
>  	}
>  
>  ack_intr:

