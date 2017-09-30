Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbdI3T7H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 15:59:07 -0400
Date: Sat, 30 Sep 2017 20:59:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 3/8] iio: accel: kxcjk1013: extract
 report_motion_event() from interrupt handler
Message-ID: <20170930205903.3a542b6e@archlinux>
In-Reply-To: <c53a0bb2038f796ee49b9b359a4133782bb5a339.1505660069.git.mirq-linux@rere.qmqm.pl>
References: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
        <c53a0bb2038f796ee49b9b359a4133782bb5a339.1505660069.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 17 Sep 2017 17:01:02 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> Extract reporting of motion event direction from interrupt handler,
> as it is not supported by KXTF9.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

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

