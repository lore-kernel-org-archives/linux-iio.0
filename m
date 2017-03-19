Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:11353
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752093AbdCSSBY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 14:01:24 -0400
Date: Sun, 19 Mar 2017 18:56:05 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: simran singhal <singhalsimran0@gmail.com>
cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: impedance-analyzer: ad5933:
 Remove unnecessary goto
In-Reply-To: <20170319175133.GA19710@singhal-Inspiron-5558>
Message-ID: <alpine.DEB.2.20.1703191854260.2094@hadrien>
References: <20170319175133.GA19710@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Sun, 19 Mar 2017, simran singhal wrote:

> Remove unnecessary goto.
>
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 297665d..c9ed2ac 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -663,12 +663,12 @@ static void ad5933_work(struct work_struct *work)
>  		ad5933_cmd(st, AD5933_CTRL_START_SWEEP);
>  		st->state = AD5933_CTRL_START_SWEEP;
>  		schedule_delayed_work(&st->work, st->poll_time_jiffies);
> -		goto out;
> +		mutex_unlock(&indio_dev->mlock);

This is not correct.  The code at the end of the function implicitly does
a return, which has disappeared in the change.  You could add a return to
each place wher you have put a mutex_unlock, but I think that the code was
better off as it was.  It's microscopically less error prone to have this
cleanup code in only one place.

julia

>  	}
>
>  	ret = ad5933_i2c_read(st->client, AD5933_REG_STATUS, 1, &status);
>  	if (ret)
> -		goto out;
> +		mutex_unlock(&indio_dev->mlock);
>
>  	if (status & AD5933_STAT_DATA_VALID) {
>  		int scan_count = bitmap_weight(indio_dev->active_scan_mask,
> @@ -678,7 +678,7 @@ static void ad5933_work(struct work_struct *work)
>  				AD5933_REG_REAL_DATA : AD5933_REG_IMAG_DATA,
>  				scan_count * 2, (u8 *)buf);
>  		if (ret)
> -			goto out;
> +			mutex_unlock(&indio_dev->mlock);
>
>  		if (scan_count == 2) {
>  			val[0] = be16_to_cpu(buf[0]);
> @@ -690,7 +690,7 @@ static void ad5933_work(struct work_struct *work)
>  	} else {
>  		/* no data available - try again later */
>  		schedule_delayed_work(&st->work, st->poll_time_jiffies);
> -		goto out;
> +		mutex_unlock(&indio_dev->mlock);
>  	}
>
>  	if (status & AD5933_STAT_SWEEP_DONE) {
> @@ -703,8 +703,6 @@ static void ad5933_work(struct work_struct *work)
>  		ad5933_cmd(st, AD5933_CTRL_INC_FREQ);
>  		schedule_delayed_work(&st->work, st->poll_time_jiffies);
>  	}
> -out:
> -	mutex_unlock(&indio_dev->mlock);
>  }
>
>  static int ad5933_probe(struct i2c_client *client,
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170319175133.GA19710%40singhal-Inspiron-5558.
> For more options, visit https://groups.google.com/d/optout.
>
