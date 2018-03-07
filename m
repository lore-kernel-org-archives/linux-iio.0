Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754333AbeCGVHd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Mar 2018 16:07:33 -0500
Date: Wed, 7 Mar 2018 21:07:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH v3 3/4] Staging: iio: adis16209: Adjust a switch
 statement
Message-ID: <20180307210728.59457080@archlinux>
In-Reply-To: <5c523865f71eb68181bd2b207685bdf5e9b8da83.1520164945.git.shreeya.patel23498@gmail.com>
References: <cover.1520164945.git.shreeya.patel23498@gmail.com>
        <5c523865f71eb68181bd2b207685bdf5e9b8da83.1520164945.git.shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  4 Mar 2018 18:13:12 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Adjust a switch block to explicitly match channels and
> return -EINVAL as default case which makes the code
> semantically more clear.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan.
> ---
> 
> Changes in v3
>   -After split patch.
> 
>  drivers/staging/iio/accel/adis16209.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index eb5c878..9cb1ce0 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -155,10 +155,16 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
>  			*val = 0;
> -			if (chan->channel == 0)
> +			switch (chan->channel) {
> +			case 0:
>  				*val2 = 305180; /* 0.30518 mV */
> -			else
> +				break;
> +			case 1:
>  				*val2 = 610500; /* 0.6105 mV */
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
>  			*val = -470;

