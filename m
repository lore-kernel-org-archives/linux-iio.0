Return-Path: <SRS0=CFMa=FG=oracle.com=dan.carpenter@kernel.org>
Date: Mon, 12 Feb 2018 16:10:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: 21cnbao@gmail.com, jic23@kernel.org, devel@driverdev.osuosl.org,
        lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 3/4] staging: iio: accel: Use sign_extend32 and adjust a
 switch statement
Message-ID: <20180212131000.h4tbinr4s6m4ckh4@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-4-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518436499-8584-4-git-send-email-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Feb 12, 2018 at 05:24:58PM +0530, Himanshu Jha wrote:
> Use sign_extend32 function instead of manually coding it. Also, adjust a
                                                            ^^^^^
> switch block to explicitly match channels and return -EINVAL as default
> case which improves code readability.

Greg likes to say something along the lines of "when you start your
sentence with "Also, " that could be a clue that it should be a separate
patch.".

> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16201.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 011d2c5..6800347 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -112,12 +112,17 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
> -			if (chan->channel == 0) {
> +			switch (chan->channel) {
> +			case 0:
>  				*val = 1;
>  				*val2 = 220000;
> -			} else {
> +				break;
> +			case 1:
>  				*val = 0;
>  				*val2 = 610000;
> +				break;
> +			default:
> +				return -EINVAL;
>  			}

I don't think this improves readability.  The -EINVAL is to handle a
driver bug which we haven't introduced yet.  Probably we would be better
off printing a warning or something?  But it feels weird to introduce so
much code to handle a bug which would actually be pretty difficult to
write.  The original code is fine.

>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
> @@ -155,9 +160,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, bits - 1);

Yeah.  This is a nice clean up.

regards,
dan carpenter
