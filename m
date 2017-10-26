Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932255AbdJZQJS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 12:09:18 -0400
Date: Thu, 26 Oct 2017 17:09:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/accel/stk8312: Improve unlocking of a mutex in two
 functions
Message-ID: <20171026170913.5ff10718@archlinux>
In-Reply-To: <ae9d7e7f-541e-ce0c-1d41-6b9793c98f78@users.sourceforge.net>
References: <ae9d7e7f-541e-ce0c-1d41-6b9793c98f78@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 25 Oct 2017 20:55:23 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 25 Oct 2017 20:46:18 +0200
> 
> * Adjust jump targets so that a call of the function "mutex_unlock"
>   is mostly stored at the end of these function implementations.
> 
> * Replace four calls by goto statements.
> 
> * Adjust condition checks.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Hi Markus,

Thanks for this.  One small change would make the first case
easier to read in my mind.   We are already fairly deeply
indented here and having labels within switch blocks can be
difficult to read.

As such I would factor out this block as a separate read function.
That will make it a little more readable.

In the second case, the jump backwards just makes the code harder
to read than it currently is.

There is no firm rule about error handling in one place. If it
leads to more complex flow as here, don't do it.

Jonathan

> ---
>  drivers/iio/accel/stk8312.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
> index cacc0da2f874..5275ab886e39 100644
> --- a/drivers/iio/accel/stk8312.c
> +++ b/drivers/iio/accel/stk8312.c
> @@ -344,24 +344,24 @@ static int stk8312_read_raw(struct iio_dev *indio_dev,
>  			return -EBUSY;
>  		mutex_lock(&data->lock);
>  		ret = stk8312_set_mode(data, data->mode | STK8312_MODE_ACTIVE);
> -		if (ret < 0) {
> -			mutex_unlock(&data->lock);
> -			return ret;
> -		}
> +		if (ret)
> +			goto unlock;
> +
>  		ret = stk8312_read_accel(data, chan->address);
>  		if (ret < 0) {
>  			stk8312_set_mode(data,
>  					 data->mode & (~STK8312_MODE_ACTIVE));

Hmm. I'd like to factor out the set mode as well, but then we risk eating the
first error - so I suppose this is the best we can do.
> -			mutex_unlock(&data->lock);
> -			return ret;
> +			goto unlock;
>  		}
>  		*val = sign_extend32(ret, 7);
>  		ret = stk8312_set_mode(data,
>  				       data->mode & (~STK8312_MODE_ACTIVE));
> +unlock:
>  		mutex_unlock(&data->lock);
> -		if (ret < 0)
> -			return ret;
> -		return IIO_VAL_INT;
> +		if (!ret)
> +			ret = IIO_VAL_INT;

> +
> +		return ret;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = stk8312_scale_table[data->range - 1][0];
>  		*val2 = stk8312_scale_table[data->range - 1][1];
> @@ -444,17 +444,15 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
>  						    data->buffer);
>  		if (ret < STK8312_ALL_CHANNEL_SIZE) {
>  			dev_err(&data->client->dev, "register read failed\n");
> -			mutex_unlock(&data->lock);
> -			goto err;
> +			goto unlock_after_failure;
>  		}
>  	} else {
>  		for_each_set_bit(bit, indio_dev->active_scan_mask,
>  				 indio_dev->masklength) {
>  			ret = stk8312_read_accel(data, bit);
> -			if (ret < 0) {
> -				mutex_unlock(&data->lock);
> -				goto err;
> -			}
> +			if (ret < 0)
> +				goto unlock_after_failure;
> +
>  			data->buffer[i++] = ret;
>  		}
>  	}
> @@ -462,10 +460,13 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>  					   pf->timestamp);
> -err:
> +notify_trigger:
>  	iio_trigger_notify_done(indio_dev->trig);
> -
>  	return IRQ_HANDLED;
> +
> +unlock_after_failure:
> +	mutex_unlock(&data->lock);

No. This construction fails the easy to read case.  The original code
was cleaner.  The reason to bring mutex_unlocks into one place is to simplify
the code.  That isn't the case here.

> +	goto notify_trigger;
>  }
>  
>  static irqreturn_t stk8312_data_rdy_trig_poll(int irq, void *private)

