Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54078 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753033AbcJKSni (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2016 14:43:38 -0400
Subject: Re: [PATCH v2] iio: bmi160_core: Fix sparse warning due to incorrect
 type in assignment
To: sayli karnik <karniksayli1995@gmail.com>,
        outreachy-kernel@googlegroups.com
References: <20161011113721.GA26944@sayli-HP-15-Notebook-PC>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <27fa1ed2-54c8-df68-2b46-bdfd086d3bc3@kernel.org>
Date: Tue, 11 Oct 2016 19:43:01 +0100
MIME-Version: 1.0
In-Reply-To: <20161011113721.GA26944@sayli-HP-15-Notebook-PC>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/16 12:37, sayli karnik wrote:
> There is a type mismatch between the buffer which is of type s16 and the
> samples stored, which are declared as __le16.
> 
> Fix the following sparse warning:
> drivers/iio/imu/bmi160/bmi160_core.c:411:26: warning: incorrect type
> in assignment (different base types)
> 
> drivers/iio/imu/bmi160/bmi160_core.c:411:26: expected signed short
> [signed] [short] [explicitly-signed] <noident>
> drivers/iio/imu/bmi160/bmi160_core.c:411:26: got restricted __le16
> [addressable] [usertype] sample
> 
> This is a cosmetic-type patch since it does not alter code behaviour.
> The le16 is going into a 16bit buf element, and is labelled as IIO_LE in the
> channel buffer definition.
> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> Changes in v2:
> Moved comment above declaration of buf array
> 
>  drivers/iio/imu/bmi160/bmi160_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index e0251b8..5355507 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -398,7 +398,8 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct bmi160_data *data = iio_priv(indio_dev);
> -	s16 buf[16]; /* 3 sens x 3 axis x s16 + 3 x s16 pad + 4 x s16 tstamp */
> +	__le16 buf[16];
> +	/* 3 sens x 3 axis x __le16 + 3 x __le16 pad + 4 x __le16 tstamp */
>  	int i, ret, j = 0, base = BMI160_REG_DATA_MAGN_XOUT_L;
>  	__le16 sample;
>  
> 

