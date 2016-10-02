Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36015 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbcJBFAg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2016 01:00:36 -0400
Received: by mail-pa0-f65.google.com with SMTP id cd13so4891302pac.3
        for <linux-iio@vger.kernel.org>; Sat, 01 Oct 2016 22:00:36 -0700 (PDT)
Date: Sat, 1 Oct 2016 22:00:33 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: sayli karnik <karniksayli1995@gmail.com>
Cc: outreachy-kernel@googlegroups.com,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] iio: imu: bmi160: bmi160_core: Fix
 sparse warning
Message-ID: <20161002050032.GA14117@d830.WORKGROUP>
References: <20161001110418.GA25515@sayli-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161001110418.GA25515@sayli-HP-15-Notebook-PC>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Oct 01, 2016 at 04:34:18PM +0530, sayli karnik wrote:
> Fix the following sparse warning due to incorrect type in assignment:
> drivers/iio/imu/bmi160/bmi160_core.c:411:26: warning: incorrect type
> in assignment (different base types)
> 
> drivers/iio/imu/bmi160/bmi160_core.c:411:26: expected signed short
> [signed] [short] [explicitly-signed] <noident>
> drivers/iio/imu/bmi160/bmi160_core.c:411:26: got restricted __le16
> [addressable] [usertype] sample
> 
> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>

Hi Sayli,

Please claim this via the outreachy task page - section endianness coding
task.  Perhaps you can update the commit msg & changelog with the cosmetic
vs bug impact statement as in your earlier patch. 

question inline below

> ---
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

Wondering about this option below.  Data was read into an __le16, so that
was good diligence on drivers part.  Seems we can use le16_to_cpu() for the
conversion into the buf.

--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -408,7 +408,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 				       &sample, sizeof(__le16));
 		if (ret < 0)
 			goto done;
-		buf[j++] = sample;
+		buf[j++] = le16_to_cpu(sample);
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, buf,


alisons

>  
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20161001110418.GA25515%40sayli-HP-15-Notebook-PC.
> For more options, visit https://groups.google.com/d/optout.
