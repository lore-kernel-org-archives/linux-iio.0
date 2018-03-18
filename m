Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752092AbeCRIgD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Mar 2018 04:36:03 -0400
Date: Sun, 18 Mar 2018 08:35:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        daniel.baluta@gmail.com, 21cnbao@gmail.com
Subject: Re: [PATCH v2 8/9] Staging: iio: accel: adis16201: Adjust argument
 to match open parentheses
Message-ID: <20180318083557.65078e93@archlinux>
In-Reply-To: <1521230786-18155-9-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
        <1521230786-18155-9-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 17 Mar 2018 01:36:25 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> In adis16201_read_raw() adjust an argument to match an open parentheses
> using tabs and spaces.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Applied, thanks

Jonathan

> ---
> v2:
>    -aligned perfectly to match open parentheses.
> 
>  drivers/staging/iio/accel/adis16201.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 00e944e..e439cf7 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -115,7 +115,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		return adis_single_conversion(indio_dev, chan,
> -				ADIS16201_ERROR_ACTIVE, val);
> +					      ADIS16201_ERROR_ACTIVE, val);
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:

