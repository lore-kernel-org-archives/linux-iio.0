Return-Path: <SRS0=gBjv=F3=oracle.com=dan.carpenter@kernel.org>
Date: Mon, 5 Mar 2018 13:16:10 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: jic23@kernel.org, devel@driverdev.osuosl.org, daniel.baluta@gmail.com,
        lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 07/11] Staging: iio: accel: Adjust arguments to match
 open parentheses
Message-ID: <20180305101610.kw5llrgv2wkv73yi@mwanda>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
 <1520236170-14668-8-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520236170-14668-8-git-send-email-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Mar 05, 2018 at 01:19:26PM +0530, Himanshu Jha wrote:
> In adis16201_read_raw() adjust an argument to match an open parentheses
> using tabs.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16201.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 907fb85..1737708 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -110,7 +110,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		return adis_single_conversion(indio_dev, chan,
> -				ADIS16201_ERROR_ACTIVE, val);
> +						ADIS16201_ERROR_ACTIVE, val);

It still doesn't line up.  You need to use some spaces.

		return adis_single_conversion(indio_dev, chan,
					      ADIS16201_ERROR_ACTIVE, val);

[tab][tab][tab][tab][tab][space][space][space][space][space][space]ADIS...

regards,
dan carpenter
