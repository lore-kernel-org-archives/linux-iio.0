Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47002 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbdDBIKq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 04:10:46 -0400
Subject: Re: [PATCH v2] iio: gyro: adis16060: Change the name of function.
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <20170331102143.GA13661@singhal-Inspiron-5558>
Cc: Michael.Hennerich@analog.com, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d8c9c1b1-b836-724a-2668-7dd0b04fb899@kernel.org>
Date: Sun, 2 Apr 2017 09:10:43 +0100
MIME-Version: 1.0
In-Reply-To: <20170331102143.GA13661@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/03/17 11:21, simran singhal wrote:
> Change the name of function from adis16060_spi_write_than_read()
> to adis16060_spi_write_then_read(). change "than" to "then" as
> its time depended.
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Applied.
> ---
> 
>  v2:
>    -Change the subject.
>    -Add signed-off-by.
> 
>  drivers/staging/iio/gyro/adis16060_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16060_core.c b/drivers/staging/iio/gyro/adis16060_core.c
> index 8115962..9675245 100644
> --- a/drivers/staging/iio/gyro/adis16060_core.c
> +++ b/drivers/staging/iio/gyro/adis16060_core.c
> @@ -40,7 +40,7 @@ struct adis16060_state {
>  
>  static struct iio_dev *adis16060_iio_dev;
>  
> -static int adis16060_spi_write_than_read(struct iio_dev *indio_dev,
> +static int adis16060_spi_write_then_read(struct iio_dev *indio_dev,
>  					 u8 conf, u16 *val)
>  {
>  	int ret;
> @@ -81,7 +81,7 @@ static int adis16060_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = adis16060_spi_write_than_read(indio_dev,
> +		ret = adis16060_spi_write_then_read(indio_dev,
>  						    chan->address, &tval);
>  		if (ret < 0)
>  			return ret;
> 

