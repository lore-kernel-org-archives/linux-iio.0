Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751604AbdICLvf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 07:51:35 -0400
Date: Sun, 3 Sep 2017 12:51:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iio: accel: kxcjk1013: extract
 report_motion_event() from interrupt handler
Message-ID: <20170903125131.5338b66c@archlinux>
In-Reply-To: <a3832939487448c6bc963208150c8d013ba4b8f6.1503352742.git.mirq-linux@rere.qmqm.pl>
References: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
        <a3832939487448c6bc963208150c8d013ba4b8f6.1503352742.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 Aug 2017 00:03:31 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> Extract reporting of motion event direction from interrupt handler,
> as it is not supported by KXTF9.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

Looks fine to me.  Will pick up once we hear from Srinivas.

Jonathan
> ---
>  drivers/iio/accel/kxcjk-1013.c | 126 ++++++++++++++++++++++-------------------
>  1 file changed, 67 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 7828570d87d2..3022bc951dc2 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1032,6 +1032,72 @@ static const struct iio_trigger_ops kxcjk1013_trigger_ops = {
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
> +	if (ret & KXCJK1013_REG_INT_SRC2_BIT_XN)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_X,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_FALLING),
> +			       data->timestamp);
> +
> +	if (ret & KXCJK1013_REG_INT_SRC2_BIT_XP)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_X,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_RISING),
> +			       data->timestamp);
> +
> +	if (ret & KXCJK1013_REG_INT_SRC2_BIT_YN)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Y,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_FALLING),
> +			       data->timestamp);
> +
> +	if (ret & KXCJK1013_REG_INT_SRC2_BIT_YP)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Y,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_RISING),
> +			       data->timestamp);
> +
> +	if (ret & KXCJK1013_REG_INT_SRC2_BIT_ZN)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Z,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_FALLING),
> +			       data->timestamp);
> +
> +	if (ret & KXCJK1013_REG_INT_SRC2_BIT_ZP)
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Z,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_RISING),
> +			       data->timestamp);
> +}
> +
>  static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
> @@ -1045,65 +1111,7 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
>  	}
>  
>  	if (ret & KXCJK1013_REG_INT_SRC1_BIT_WUFS) {
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

