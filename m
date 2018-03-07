Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934454AbeCGUuf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Mar 2018 15:50:35 -0500
Date: Wed, 7 Mar 2018 20:50:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 10/11] Staging: iio: accel: Add comments about units in
 data read function
Message-ID: <20180307205030.11fff428@archlinux>
In-Reply-To: <1520236170-14668-11-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
        <1520236170-14668-11-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  5 Mar 2018 13:19:29 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Clarify the conversion and formation of resultant data in the
> adis16201_read_raw() with sufficient comments.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
This is fine but it needs to be in the original comment changing patch
rather than removing the comments first then a few patches later putting
back a different version.

So good change but in the wrong place in the series.  Learning to reorder
a series and merge down multiple patches into one is very useful when
working with git.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/adis16201.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 8d795e2..946c7b1 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -130,6 +130,11 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  			*val2 = 0;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
> +		       /*
> +			* IIO base unit for sensitivity of accelerometer
> +			* is milli g.
> +			* 1 LSB represents 0.244 mg.
> +			*/
>  			*val = 0;
>  			*val2 = IIO_G_TO_M_S_2(462400);
>  			return IIO_VAL_INT_PLUS_NANO;
> @@ -142,6 +147,11 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  		}
>  		break;
>  	case IIO_CHAN_INFO_OFFSET:
> +	       /*
> +		* The raw ADC value is 0x4FE when the temperature
> +		* is 25 degrees and the scale factor per milli
> +		* degree celcius is -470.
> +		*/
>  		*val = 25000 / -470 - 1278;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:

