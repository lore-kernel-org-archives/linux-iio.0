Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbdICL5l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 07:57:41 -0400
Date: Sun, 3 Sep 2017 12:57:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/7] iio: accel: kxcjk1013: rename motion direction
 bits
Message-ID: <20170903125736.68d4a918@archlinux>
In-Reply-To: <763b40e19a19f0d35944b2b4bc0dcf7634dd69b8.1503352742.git.mirq-linux@rere.qmqm.pl>
References: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
        <763b40e19a19f0d35944b2b4bc0dcf7634dd69b8.1503352742.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 22 Aug 2017 00:03:31 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> Rename INT_SRC2 bits - detected motion direction. This will avoid
> duplication when KXTF9's tap direction is implemented.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

I would have preferred this being left until the tap direction
stuff is ready to go.   It's a premature change at the moment.

It is not that important though so lets leave it here to avoid a
respin if there are no issues in later patches.

If you are respining for some reason I'd like this dropped for now.

Jonathan


> ---
>  drivers/iio/accel/kxcjk-1013.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 3022bc951dc2..252004640403 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -80,12 +80,12 @@
>  #define KXCJK1013_REG_INT_SRC1_BIT_WUFS	BIT(1)
>  #define KXCJK1013_REG_INT_SRC1_BIT_DRDY	BIT(4)
>  
> -#define KXCJK1013_REG_INT_SRC2_BIT_ZP	BIT(0)
> -#define KXCJK1013_REG_INT_SRC2_BIT_ZN	BIT(1)
> -#define KXCJK1013_REG_INT_SRC2_BIT_YP	BIT(2)
> -#define KXCJK1013_REG_INT_SRC2_BIT_YN	BIT(3)
> -#define KXCJK1013_REG_INT_SRC2_BIT_XP	BIT(4)
> -#define KXCJK1013_REG_INT_SRC2_BIT_XN	BIT(5)
> +#define KXCJK1013_DIRECTION_BIT_ZP	BIT(0)
> +#define KXCJK1013_DIRECTION_BIT_ZN	BIT(1)
> +#define KXCJK1013_DIRECTION_BIT_YP	BIT(2)
> +#define KXCJK1013_DIRECTION_BIT_YN	BIT(3)
> +#define KXCJK1013_DIRECTION_BIT_XP	BIT(4)
> +#define KXCJK1013_DIRECTION_BIT_XN	BIT(5)
>  
>  #define KXCJK1013_DEFAULT_WAKE_THRES	1
>  
> @@ -1043,7 +1043,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
>  		return;
>  	}
>  
> -	if (ret & KXCJK1013_REG_INT_SRC2_BIT_XN)
> +	if (ret & KXCJK1013_DIRECTION_BIT_XN)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
> @@ -1052,7 +1052,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
>  						  IIO_EV_DIR_FALLING),
>  			       data->timestamp);
>  
> -	if (ret & KXCJK1013_REG_INT_SRC2_BIT_XP)
> +	if (ret & KXCJK1013_DIRECTION_BIT_XP)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
> @@ -1061,7 +1061,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
>  						  IIO_EV_DIR_RISING),
>  			       data->timestamp);
>  
> -	if (ret & KXCJK1013_REG_INT_SRC2_BIT_YN)
> +	if (ret & KXCJK1013_DIRECTION_BIT_YN)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
> @@ -1070,7 +1070,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
>  						  IIO_EV_DIR_FALLING),
>  			       data->timestamp);
>  
> -	if (ret & KXCJK1013_REG_INT_SRC2_BIT_YP)
> +	if (ret & KXCJK1013_DIRECTION_BIT_YP)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
> @@ -1079,7 +1079,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
>  						  IIO_EV_DIR_RISING),
>  			       data->timestamp);
>  
> -	if (ret & KXCJK1013_REG_INT_SRC2_BIT_ZN)
> +	if (ret & KXCJK1013_DIRECTION_BIT_ZN)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,
> @@ -1088,7 +1088,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
>  						  IIO_EV_DIR_FALLING),
>  			       data->timestamp);
>  
> -	if (ret & KXCJK1013_REG_INT_SRC2_BIT_ZP)
> +	if (ret & KXCJK1013_DIRECTION_BIT_ZP)
>  		iio_push_event(indio_dev,
>  			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  						  0,

