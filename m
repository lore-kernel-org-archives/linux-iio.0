Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 20 Oct 2011 00:04:29 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org,
        drivers@analog.com, Michael Hennerich <michael.hennerich@analog.com>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>,
        device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH 2/4] staging:iio:dac:ad5791: Allow asymmetrical reference
 voltages
Message-ID: <20111019210429.GF24215@longonot.mountain>
References: <1319039272-19496-1-git-send-email-lars@metafoo.de>
 <1319039272-19496-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319039272-19496-2-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Oct 19, 2011 at 05:47:50PM +0200, Lars-Peter Clausen wrote:
> @@ -225,6 +226,7 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct ad5791_state *st = iio_priv(indio_dev);
> +	u64 val64;
>  	int ret;
>  
>  	switch (m) {
> @@ -234,12 +236,16 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		*val &= AD5791_DAC_MASK;
>  		*val >>= chan->scan_type.shift;
> -		*val -= (1 << (chan->scan_type.realbits - 1));
>  		return IIO_VAL_INT;
>  	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
>  		*val = 0;
>  		*val2 = (st->vref_mv * 1000) >> chan->scan_type.realbits;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case (1 << IIO_CHAN_INFO_OFFSET_SHARED):
> +		val64 = (((u64)st->vref_neg_mv) << chan->scan_type.realbits);
> +		do_div(val64, st->vref_mv);
> +		*val = -val64;
> +		return IIO_VAL_INT;

Why does iio use switch over a bitfield?  If the values are mutually
exclusive then why not just use an enum?

Hm...  "m" stands for mask and it gets created using the
IIO_UNMOD_EVENT_CODE() macro or sometimes it's just one bit at a
time copied from &chan->info_mask...  Odd.

regards,
dan carpenter
